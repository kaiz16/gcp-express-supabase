const { supabase } = require('../supabase.js')
const express = require('express')
const router = express.Router()

router.post('/update-user', async (req, res) => {
  const {
    data: authData,
    error: authError,
  } = await supabase.auth.api.updateUserById(req.body.user_id, req.body.details)

  if (authError == null) {
    var { data: dbData, error: dbError } = await supabase
      .from('profile')
      .update([
        {
          fullname: req.body.details.user_metadata.fullname,
          username: req.body.details.user_metadata.username,
          email: req.body.details.email,
        },
      ])
      .eq('id', authData.id)
  }

  return res.json({ authData, authError, dbData, dbError })
})

module.exports = router
