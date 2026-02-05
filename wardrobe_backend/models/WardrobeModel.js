import mongoose from "mongoose";

const wardrobeSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
    },
    category: {
      type: String, // top, bottom, dress
      required: true,
    },
    color: {
      type: String,
      required: true,
    },
    season: {
      type: String, // Summer, Winter, Monsoon
      required: true,
    },
    occasion: {
      type: String, // College, Party, Office, Casual
      required: true,
    },
    image: {
      type: String, // image path
      required: true,
    },
  },
  { timestamps: true }
);

export default mongoose.model("Wardrobe", wardrobeSchema);
