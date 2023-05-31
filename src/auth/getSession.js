const { supabase } = require("../supabase.js");
const express = require("express");
const router = express.Router();

router.get("/get-session", async (req, res) => {
  const session =
    supabase.auth.session();


  return res.json({ session });
});

module.exports = router;
