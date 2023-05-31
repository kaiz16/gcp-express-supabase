const { supabase } = require("../supabase.js");
const express = require("express");
const router = express.Router();

router.get("/get-user", async (req, res) => {
    if(!req.query.JWT) {
        return res.status(401).send("JWT is required");
    }

    const { user, error } = await supabase.auth.api.getUser(req.query.JWT || null)

    return res.json({ user, error });
});

module.exports = router;
