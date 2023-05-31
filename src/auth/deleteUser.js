const { supabase } = require("../supabase.js");
const express = require("express");
const router = express.Router();

router.post("/delete-user", async (req, res) => {
  const { data: user, error: error } =
    await supabase.auth.api.deleteUser({
      id: req.body.user_id,
    });

  return res.json({ user, error });
});

module.exports = router;
