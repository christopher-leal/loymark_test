const Router = require('express').Router;
const UserController = require('../controllers/users');

const router = Router();

router.post('/upsertUser', UserController.upsertUser);

router.post('/getUsers', UserController.getUsers);

router.post('/delete', UserController.deleteUser);

module.exports = router;
