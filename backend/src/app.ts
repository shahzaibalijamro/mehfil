import express from "express";
import cors from "cors";
import authRoutes from "./routes/authRoutes";
import { errorHandler } from "./middlewares/errorHandler";

const app = express();

// ─── Global Middleware ─────────────────────────────────────────────────
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// ─── Health Check ──────────────────────────────────────────────────────
app.get("/api/health", (_req, res) => {
  res.json({ status: "ok", timestamp: new Date().toISOString() });
});

// ─── Routes ────────────────────────────────────────────────────────────
app.use("/api/auth", authRoutes);

// ─── Error Handler (must be last) ──────────────────────────────────────
app.use(errorHandler);

export default app;
