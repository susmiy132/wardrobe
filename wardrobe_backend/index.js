import mongoose from "mongoose";
import dotenv from "dotenv";
import app from "./app.js";

dotenv.config();

const PORT = process.env.PORT || 5000;
const MONGOURL = process.env.MONGO_URL;

mongoose
  .connect(MONGOURL)
  .then(() => {
    console.log("Database connected successfully.");
    app.listen(PORT, () => {
      console.log(`Server is running on port ${PORT}`);
      console.log(`Server URL:http://localhost:${PORT}`);
    });
  })
  .catch((error) => console.log(error));
