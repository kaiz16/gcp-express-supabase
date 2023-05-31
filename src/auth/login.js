const { supabase } = require("../supabase.js");
const express = require("express");
const router = express.Router();

router.post("/login", async (req, res) => {
    const { user, session, error } = await supabase.auth.signIn({
        email: req.body.email,
        password: req.body.password,
    })

    return res.json({ user, session, error });
});

module.exports = router;
