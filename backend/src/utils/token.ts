import jwt from "jsonwebtoken";
import { env } from "../config/env";

export const generateAccessToken = (userId: string): string => {
  return jwt.sign({ id: userId }, env.ACCESS_TOKEN_SECRET, {
    expiresIn: env.ACCESS_TOKEN_EXPIRY as string,
  });
};

export const generateRefreshToken = (userId: string): string => {
  return jwt.sign({ id: userId }, env.REFRESH_TOKEN_SECRET, {
    expiresIn: env.REFRESH_TOKEN_EXPIRY as string,
  });
};

export const verifyAccessToken = (token: string): jwt.JwtPayload => {
  return jwt.verify(token, env.ACCESS_TOKEN_SECRET) as jwt.JwtPayload;
};

export const verifyRefreshToken = (token: string): jwt.JwtPayload => {
  return jwt.verify(token, env.REFRESH_TOKEN_SECRET) as jwt.JwtPayload;
};
