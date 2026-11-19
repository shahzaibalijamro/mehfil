import { Request, Response, NextFunction } from "express";
import { sendResponse } from "../utils/apiResponse";

export const errorHandler = (
  err: Error,
  _req: Request,
  res: Response,
  _next: NextFunction
): void => {
  console.error("🔥 Unhandled Error:", err.message);
  sendResponse(res, 500, "Internal server error");
};
