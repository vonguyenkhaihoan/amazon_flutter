const router = require("express").Router();
const UserController = require("../controller/user_controller");


router.post('/api/signup', UserController.signup);
router.post('/api/signin', UserController.signin);


module.exports = router;