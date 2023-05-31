const { supabase } = require("../supabase.js");
const express = require("express");
const router = express.Router();

router.post("/create-user", async (req, res) => {
  const { data: authData, error: authError } =
    await supabase.auth.api.createUser({
      email: req.body.email,
      password: req.body.password,
      user_metadata: req.body.user_metadata,
      email_confirm: true,
    });

  var dbData = null,
    dbError = null;


  if (authError == null) {
    var { data: dbData, error: dbError } = await supabase.from("profile").insert([
      {
        id: authData.id,
        fullname: req.body.user_metadata.fullname,
        username: req.body.user_metadata.username,
        email: req.body.email,
      },
    ]);
  }

  return res.json({ authData, authError, dbData, dbError });
});

module.exports = router;
