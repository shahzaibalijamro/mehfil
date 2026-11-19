import { Router } from "express";
import * as authController from "../controllers/authController";

const router = Router();

router.post("/signup", authController.signup);
router.post("/verify-otp", authController.verifyOtp);
router.post("/login", authController.login);
router.post("/refresh", authController.refresh);

export default router;
