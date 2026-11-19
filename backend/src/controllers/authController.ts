import { Request, Response, NextFunction } from "express";
import * as authService from "../services/authService";
import { sendResponse } from "../utils/apiResponse";

// POST /api/auth/signup
export const signup = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { name, email, password, role } = req.body;

    if (!name || !email || !password || !role) {
      sendResponse(res, 400, "Name, email, password, and role are required");
      return;
    }

    if (!["invitee", "host"].includes(role)) {
      sendResponse(res, 400, "Role must be either 'invitee' or 'host'");
      return;
    }

    if (password.length < 6) {
      sendResponse(res, 400, "Password must be at least 6 characters");
      return;
    }

    await authService.initiateSignup(name, email, password, role);

    sendResponse(res, 200, "OTP sent to your email. Please verify to complete signup.");
  } catch (error: any) {
    if (error.status) {
      sendResponse(res, error.status, error.message);
      return;
    }
    next(error);
  }
};

// POST /api/auth/verify-otp
export const verifyOtp = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { email, otp } = req.body;

    if (!email || !otp) {
      sendResponse(res, 400, "Email and OTP are required");
      return;
    }

    const result = await authService.verifyOtpAndCreateUser(email, otp);

    sendResponse(res, 201, "Signup successful", {
      user: {
        id: result.user._id,
        name: result.user.name,
        email: result.user.email,
        role: result.user.role,
      },
      accessToken: result.accessToken,
      refreshToken: result.refreshToken,
    });
  } catch (error: any) {
    if (error.status) {
      sendResponse(res, error.status, error.message);
      return;
    }
    next(error);
  }
};

// POST /api/auth/login
export const login = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      sendResponse(res, 400, "Email and password are required");
      return;
    }

    const result = await authService.login(email, password);

    sendResponse(res, 200, "Login successful", {
      user: {
        id: result.user._id,
        name: result.user.name,
        email: result.user.email,
        role: result.user.role,
      },
      accessToken: result.accessToken,
      refreshToken: result.refreshToken,
    });
  } catch (error: any) {
    if (error.status) {
      sendResponse(res, error.status, error.message);
      return;
    }
    next(error);
  }
};

// POST /api/auth/refresh
export const refresh = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { refreshToken } = req.body;

    if (!refreshToken) {
      sendResponse(res, 400, "Refresh token is required");
      return;
    }

    const tokens = await authService.refreshAccessToken(refreshToken);

    sendResponse(res, 200, "Token refreshed", tokens);
  } catch (error: any) {
    if (error.status) {
      sendResponse(res, error.status, error.message);
      return;
    }
    next(error);
  }
};
