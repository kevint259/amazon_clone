// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");

// IMPORTS FROM OTHER FILES
const authRouter = require("./routes/auth");

// INIT
const PORT = 3000;
const app = express();
const DB =
  "mongodb+srv://kevint259:kev54321@cluster0.tojcnze.mongodb.net/?retryWrites=true&w=majority";

// middleware
// CLIENT -> middleware -> SERVER -> CLIENT
app.use(express.json());
// this basically initiates the post request from the server
app.use(authRouter);

// Connections
mongoose
  .connect(DB)
  .then(function () {
    console.log("Connection Successful");
  })
  .catch(function (e) {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});