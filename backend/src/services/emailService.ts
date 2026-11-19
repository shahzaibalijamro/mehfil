import nodemailer from "nodemailer";
import { env } from "../config/env";

const transporter = nodemailer.createTransport({
  host: env.SMTP_HOST,
  port: env.SMTP_PORT,
  secure: false, // true for 465, false for 587
  auth: {
    user: env.SMTP_USER,
    pass: env.SMTP_PASS,
  },
});

export const sendOtpEmail = async (
  to: string,
  otp: string
): Promise<void> => {
  const mailOptions = {
    from: `"Mehfil" <${env.SMTP_USER}>`,
    to,
    subject: "Your Verification Code — Mehfil",
    html: `
      <div style="font-family: Arial, sans-serif; max-width: 480px; margin: 0 auto; padding: 32px;">
        <h2 style="color: #333;">Verify Your Email</h2>
        <p style="color: #555; font-size: 16px;">
          Use the following code to complete your sign-up. It expires in <strong>10 minutes</strong>.
        </p>
        <div style="background: #f4f4f4; padding: 20px; text-align: center; border-radius: 8px; margin: 24px 0;">
          <span style="font-size: 32px; font-weight: bold; letter-spacing: 8px; color: #111;">${otp}</span>
        </div>
        <p style="color: #999; font-size: 13px;">If you didn't request this, you can safely ignore this email.</p>
      </div>
    `,
  };

  await transporter.sendMail(mailOptions);
};
