import bcrypt from "bcryptjs";
import { User, IUser } from "../models/User";
import { Otp } from "../models/Otp";
import { sendOtpEmail } from "./emailService";
import {
  generateAccessToken,
  generateRefreshToken,
  verifyRefreshToken,
} from "../utils/token";
import { generateOtp } from "../utils/otp";

// ─── Initiate Signup (send OTP) ────────────────────────────────────────
export const initiateSignup = async (
  name: string,
  email: string,
  password: string,
  role: "invitee" | "host"
): Promise<void> => {
  // Check if user already exists
  const existingUser = await User.findOne({ email });
  if (existingUser) {
    throw { status: 409, message: "Email already registered" };
  }

  // Hash password before storing in OTP doc
  const salt = await bcrypt.genSalt(12);
  const hashedPassword = await bcrypt.hash(password, salt);

  const otp = generateOtp();
  const expiresAt = new Date(Date.now() + 10 * 60 * 1000); // 10 min

  // Upsert — if user re-requests OTP, overwrite previous
  await Otp.findOneAndUpdate(
    { email },
    { otp, name, password: hashedPassword, role, expiresAt },
    { upsert: true, new: true }
  );

  await sendOtpEmail(email, otp);
};

// ─── Verify OTP & Complete Signup ──────────────────────────────────────
export const verifyOtpAndCreateUser = async (
  email: string,
  otp: string
): Promise<{ user: IUser; accessToken: string; refreshToken: string }> => {
  const otpRecord = await Otp.findOne({ email });

  if (!otpRecord) {
    throw { status: 400, message: "No pending signup found. Please sign up first." };
  }

  if (otpRecord.otp !== otp) {
    throw { status: 400, message: "Invalid OTP" };
  }

  if (otpRecord.expiresAt < new Date()) {
    await Otp.deleteOne({ email });
    throw { status: 400, message: "OTP has expired. Please sign up again." };
  }

  // Create the user — password is already hashed, so insert directly
  // to skip the pre-save hash hook
  const result = await User.collection.insertOne({
    name: otpRecord.name,
    email: otpRecord.email,
    password: otpRecord.password,
    role: otpRecord.role,
    createdAt: new Date(),
    updatedAt: new Date(),
  });

  const user = await User.findById(result.insertedId);
  if (!user) {
    throw { status: 500, message: "Failed to create user" };
  }

  const accessToken = generateAccessToken(user._id as string);
  const refreshToken = generateRefreshToken(user._id as string);

  // Store refresh token
  await User.updateOne({ _id: user._id }, { refreshToken });

  // Clean up OTP
  await Otp.deleteOne({ email });

  return { user, accessToken, refreshToken };
};

// ─── Login ─────────────────────────────────────────────────────────────
export const login = async (
  email: string,
  password: string
): Promise<{ user: IUser; accessToken: string; refreshToken: string }> => {
  const user = await User.findOne({ email }).select("+password");

  if (!user) {
    throw { status: 401, message: "Invalid email or password" };
  }

  const isMatch = await user.comparePassword(password);
  if (!isMatch) {
    throw { status: 401, message: "Invalid email or password" };
  }

  const accessToken = generateAccessToken(user._id as string);
  const refreshToken = generateRefreshToken(user._id as string);

  // Store refresh token
  await User.updateOne({ _id: user._id }, { refreshToken });

  // Strip password from response object
  user.password = undefined as unknown as string;

  return { user, accessToken, refreshToken };
};

// ─── Refresh Token ─────────────────────────────────────────────────────
export const refreshAccessToken = async (
  token: string
): Promise<{ accessToken: string; refreshToken: string }> => {
  try {
    const decoded = verifyRefreshToken(token);

    const user = await User.findById(decoded.id).select("+refreshToken");
    if (!user || user.refreshToken !== token) {
      throw { status: 401, message: "Invalid refresh token" };
    }

    const accessToken = generateAccessToken(user._id as string);
    const refreshToken = generateRefreshToken(user._id as string);

    // Rotate refresh token
    await User.updateOne({ _id: user._id }, { refreshToken });

    return { accessToken, refreshToken };
  } catch (error: any) {
    if (error.status) throw error;
    throw { status: 401, message: "Invalid or expired refresh token" };
  }
};
