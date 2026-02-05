import express from "express";
import bodyParser from "body-parser";
import wardrobeRoutes from "./routes/wardrobeRoutes.js";

const app = express();

// middleware
app.use(bodyParser.json());

// serve uploaded images
app.use("/uploads", express.static("uploads"));

// routes
app.use("/api/wardrobe", wardrobeRoutes);

// test route
app.get("/", (req, res) => {
  res.send("Digital Wardrobe API is running...");
});

export default app;
