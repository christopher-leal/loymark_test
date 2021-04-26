const Router = require('express').Router;
const ActivitiesController = require('../controllers/activities');

const router = Router();


router.post('/getActivities', ActivitiesController.getActivities);

router.post('/getActivitiesByUser', ActivitiesController.getActivitiesByUser);

module.exports = router;
