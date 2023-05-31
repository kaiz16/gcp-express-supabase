const { supabase } = require("../supabase.js");
const express = require("express");
const router = express.Router();

router.post("/logout", async (req, res) => {
    if(!req.body.JWT) {
        return res.status(401).send("JWT is required");
    }
    const { error } = await supabase.auth.signOut(req.body.JWT || null)

    return res.json({ error });
});

module.exports = router;
