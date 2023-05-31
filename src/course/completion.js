const { supabase } = require('../supabase.js')
const express = require('express')
const router = express.Router()

router.post('/completion', async (req, res) => {
  const { courseId, startupId, answers, submittedBy } = req.body

  //   Introductory course
  if (courseId === 'f6317093-1e57-4369-873a-f23887b544cc') {
    const { data: startupData, error: startupError } = await supabase
      .from('startup')
      .insert([
        {
          name: answers['0b0e7e57-4f78-4297-81b2-3cc1d7114940'],
          description: answers['beecbd02-cd8d-45c4-89b5-0b6082180491'],
          cover: answers['f5570922-83ee-4174-a4c2-fabdf4dda03b'],
          website: answers['856db375-ddcc-438d-b9fe-e9b61ab9a2ee'],
          country: answers['4225d4f5-d6b3-4d5a-8407-31d204d68ade'],
          story: answers['de438293-32b6-40ba-92e6-5045f8b200fc'],
          owner: submittedBy,
        },
      ])

    if (startupError) {
      return res.json({
        status: 400,
        error: startupError,
      })
    }

    const { error: startupCouseError } = await supabase
      .from('startup_course')
      .insert([
        {
          course: 'f6317093-1e57-4369-873a-f23887b544cc',
          startup: startupData[0].id,
        },
      ])

    if (startupCouseError) {
      return res.json({
        status: 400,
        error: startupCouseError,
      })
    }

    const { data: positionData, error: positionError } = await supabase
      .from('position')
      .insert([
        {
          title: 'Founder',
          description: `Founder of ${answers['0b0e7e57-4f78-4297-81b2-3cc1d7114940']}`,
          availability: 'false',
          location: answers['4225d4f5-d6b3-4d5a-8407-31d204d68ade'],
          timezone: '',
          salary: 0,
          language: 'English',
          startup: startupData[0].id,
          role: 'Founder',
        },
      ])

    if (positionError) {
      return res.json({
        status: 400,
        error: positionError,
      })
    }

    const { error: startupMemberError } = await supabase
      .from('startup_member')
      .insert([
        {
          startup: startupData[0].id,
          position: positionData[0].id,
          user: submittedBy,
          status: 'ACTIVE',
          authority: 'ADMIN',
        },
      ])

    if (startupMemberError) {
      return res.json({
        status: 400,
        error: startupMemberError,
      })
    }

    const { error: pitchError } = await supabase.from('pitch').insert([
      {
        problem: answers['5311aaf4-893b-49d4-888e-1689cb472087'],
        solution: answers['2c6b3eb9-c9a0-496c-84c2-1f80305cb9a0'],
        audience: answers['02f13eee-165b-406e-b0a2-abb00f6e9434'],
        proposition: answers['6a8da16b-e724-4b0f-b8b2-6eb3a7753a4b'],
        roi: answers['dfb0cf93-fe69-42b3-9a45-ed1af4bafeff'],
        needs: answers['fed3cff2-1c59-4298-a2c2-aed881b29634'],
        startup: startupData[0].id,
      },
    ])

    if (pitchError) {
      return res.json({ status: 400, error: pitchError })
    }

    return res.json({ status: 200, data: startupData })
  }

  //   TODO: Regular course
  else {
    const { count: startupCourseCount } = await supabase
      .from('startup_course')
      .select('id', { count: 'exact' })
      .match({ course: courseId, startup: startupId })

    if (startupCourseCount === 0) {
      const { error: startupCourseError } = await supabase
        .from('startup_course')
        .insert([
          {
            course: courseId,
            startup: startupId,
          },
        ])

      if (startupCourseError) return res.json({ status: 400, error })
    }

    for (const key of Object.keys(answers)) {
      const { count } = await supabase
        .from('answer')
        .select('id', { count: 'exact' })
        .match({ question: key, user: submittedBy, startup: startupId })

      if (count === 0) {
        const { error: answerError } = await supabase.from('answer').insert([
          {
            question: key,
            answer: answers[key],
            user: submittedBy,
            startup: startupId
          },
        ])

        if (answerError) return res.json({ status: 300, error })
      } else {
        const { error: answerError } = await supabase
          .from('answer')
          .update({ answer: answers[key] })
          .match({ question: key, user: submittedBy, startup: startupId })

        if (answerError) return res.json({ status: 300, error })
      }
    }

    return res.json({ status: 200 })
  }
})

module.exports = router
