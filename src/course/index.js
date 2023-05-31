const express = require("express");
const router = express.Router();
const completion = require("./completion");

router.use("/course", completion);

module.exports = router;
