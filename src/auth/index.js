const express = require("express");
const router = express.Router();
const createUser = require("./createUser");
const updateUser = require("./updateUser");
const deleteUser = require("./deleteUser");
const getSession = require("./getSession");
const getUser = require("./getUser");
// const passwordReset = require("./passwordReset");
const login = require("./login");
const logout = require("./logout");

router.use("/auth", createUser);
router.use("/auth", updateUser);
router.use("/auth", deleteUser);
router.use("/auth", getSession);
router.use("/auth", getUser);
// router.use("/auth", passwordReset);
router.use("/auth", login);
router.use("/auth", logout);

module.exports = router;
