// IMPORTS
const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const { application } = require("express");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");

// SIGN-UP ROUTE
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

// SIGN-IN ROUTE
authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;

    // find user in the database
    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email does not exist" });
    }

    const isMatch = await bcryptjs.compare(password, user.password)
    // guard clause is simply a check that immediately exist the function
    if (!isMatch) {
      return res.status(400).json({msg: "Incorrect Password"})
    }

    // use this to see user is authentic and not a backer 
    // token is used for two factor authentication so that passwords aren't shared across platforms
    const token = jwt.sign({id: user._id}, "passwordKey");
    // ... <- object destructuring 
    // _doc <- lets you access the raw document directly
    res.json({token, ...user._doc})


  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = authRouter;
