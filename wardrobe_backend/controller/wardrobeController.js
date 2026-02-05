
import axios from "axios";
import Wardrobe from "../models/WardrobeModel.js";

// Add clothing item

export const addCloth = async (req, res) => {
  try {
    const newItem = new Wardrobe ({
      name: req.body.name,
      category: req.body.category,
      color: req.body.color,
      season:req.body.season,
      occasion: req.body.occasion,
      image: req.file.path,

    });

    await newItem.save();
    res.status(201).json(newItem);
  } catch (error) {
    res.status(500).json({message:error.message})
  }
};

// Get all clothes
export const getClothes = async (req, res) => {
  try {
    const clothes = await Wardrobe.find();
    res.status(200).json(clothes);
  } catch(error) {
    res.status(500).json({message: error.message});
  }
};

// Delete cloth
export const deleteCloth = async (req, res) => {
  try {
    await Wardrobe.findByIdAndDelete(req.params.id);
    res.status(200).json({ message: "Cloth deleted successfully"});
  } catch (error) {
    res.status(500).json({ message: error.message});
  }
};



// Rcommend clothes by occasion

export const recommendByOccasion = async (req, res) => {
  try{
    const {occasion} = req.query;

    if(!occasion) {
      return res.status(400).json({ message: "Please provide an occasion"});
    }
    
    // Find clothes that match the selected occaion
    const clothes = await Wardrobe.find({occasion: occasion});

    if(clothes.length === 0) {
      return res
      .status(404)
      .json({message:`No clothes found for ${occasion}`});
    }

    res.status(200).json(clothes);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};


// Recommend clothes based on weather 
export const recommendBYWeather = async (req, res) => {
  try{
    const {city} = req.query;
    if(!city) {
      return res.status(400).json({message: "Please provide a city"});
    }

    // Fetch current weather 
    const weatherRes = await axios.get(
      `http://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${process.env.WEATHER_API_KEY}`
    );

    const tempKelvin = weatherRes.data.main.temp;          //temperature in Kelvin
    const tempCelsius = tempKelvin - 273.15;

    // Determine season based on tmperature
    let season = "summer";
    if(tempCelsius < 20) season = "Winter";
    else if (tempCelsius >= 20 && tempCelsius <30) season = "Monsoon";

    // Find clothes for this season
    const clothes = await Wardrobe.find({season});

    res.status(200).json({
      city,
      temperature: tempCelsius.toFixed(1) + "°C",
      season,
      clothes,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({message: "Failed to fetch weather data"});
  }
};



// AI based outfit rcommendation 
// Filters clothes based on:
// Occasion (optional)
// City (weather-based season)

export const aiOutfitRecommendation = async (req, res) => {
  try {
    const { city, occasion } = req.query;

    if(!city && !occassion) {
      return res
      .status(400)
      .json({ message: "Please provide at least city or occasion" });
    }

    let season;

    // Determine season by city weather
    if(city) {
      const weatherRes = await axios.get(
        `http://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${process.env.WEATHER_API_KEY}`
      );

      const tempKelvin = weatherRes.data.main.temp;
      const tempCelsius = tempKelvin - 273.15;

      if(tempCelsius < 20) season = "Winter";
      else if (tempCelsius >= 20 && tempCelsius < 30) season = "Monsoon";
      else season = "Summer";
    }

    // Build query object
    const query = {};
    if(season) query.season = season;
    if(occasion) query.occasion = occasion;

    // Fetch clothes that match rules
    const clothes = await Wardrobe.find(query);

    // Smart combinations (basic rule: group by category)
    const tops = clothes.filter((c) => c.category.toLowerCase() === "top");
    const bottoms = clothes.filter((c) = c.category.toLowerCase() == "bottom");
    const dresses = clothes.filter((c) => c.category.toLocaleLowerCase() == "dress");

    const outfits = [];

    // Crate outfit combinations
    if(dresses.length > 0) {
      dresses.forEach((dress) => {
        outfits.push({dress});
      });
    } else if (tops.length > 0 && bottoms.length > 0) {
      tops.forEach((top) => {
        bottoms.forEach((bottom) => {
          outfits.push({top, bottom});
        });
      });
    }

    res.status(200).json({
      city: city || null,
      season: season || null,
      occasion: occasion || null,
      totalClothes: clothes.length,
      totalOUtfits: outfits.length,
      outfits,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({message: "Failed to generate AI outfit recommendation" })
  }
  
};