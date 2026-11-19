import { Response } from "express";

interface ApiResponse {
  success: boolean;
  message: string;
  data?: unknown;
}

export const sendResponse = (
  res: Response,
  statusCode: number,
  message: string,
  data?: unknown
): Response<ApiResponse> => {
  return res.status(statusCode).json({
    success: statusCode >= 200 && statusCode < 300,
    message,
    ...(data !== undefined && { data }),
  });
};
