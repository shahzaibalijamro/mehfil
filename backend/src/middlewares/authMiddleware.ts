import { Request, Response, NextFunction } from "express";
import { verifyAccessToken } from "../utils/token";
import { User } from "../models/User";
import { sendResponse } from "../utils/apiResponse";

// Extend Express Request to include user
declare global {
  namespace Express {
    interface Request {
      user?: InstanceType<typeof User>;
    }
  }
}

export const authenticate = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const authHeader = req.headers.authorization;

    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      sendResponse(res, 401, "Access token is required");
      return;
    }

    const token = authHeader.split(" ")[1];
    const decoded = verifyAccessToken(token);

    const user = await User.findById(decoded.id);
    if (!user) {
      sendResponse(res, 401, "User not found");
      return;
    }

    req.user = user;
    next();
  } catch (error) {
    sendResponse(res, 401, "Invalid or expired access token");
  }
};
