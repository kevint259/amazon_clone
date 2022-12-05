
// IMPORTS 
const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const authRouter = express.Router();

authRouter.post("/api/signup", async function (req, res) {
  try {
    // get data from client
    const { name, email, password } = req.body;

    const existingUser = await User.findOne({ email });
    // 400 code means Bad Request -> server cannot process request
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }

    // Hash the password to protect users
    const hashedPassword = await bcryptjs.hash(password, 8);

    // let --> can't declare again
    let user = new User({
      email,
      password: hashedPassword,
      name,
    });
    // post that data in database
    user = await user.save();

    // return data to the user
    res.json(user);

  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = authRouter;
