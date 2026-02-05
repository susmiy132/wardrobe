import express from "express";
import upload from "../middleware/uploadMiddleware.js"

import {
  addCloth,
  getClothes, 
  deleteCloth,
  recommendByOccasion,
  recommendBYWeather,
  aiOutfitRecommendation
} from "../controller/wardrobeController.js";

const router = express.Router();

router.post("/add", upload.single("image"), addCloth);
router.get("/all", getClothes);
router.delete("/delete/:id", deleteCloth);
router.get("/recommend/occassion", recommendByOccasion);
router.get("/recommend/weather", recommendBYWeather);
router.get("/recommend/ai", aiOutfitRecommendation);

export default router;