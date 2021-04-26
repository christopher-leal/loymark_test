const Router = require('express').Router;
const UserController = require('../controllers/users');

const router = Router();

router.post('/upsertUser', UserController.upsertUser);

router.post('/searchUser', UserController.searchUser);

router.post('/getUsers', UserController.getUsers);

router.get('/delete/:id', UserController.deleteUser);

module.exports = router;
