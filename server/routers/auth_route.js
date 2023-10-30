const router = require("express").Router();
const UserController = require("../controller/user_controller");
const AuthMidd = require("../middlewares/auth_middlle");
const UserModle = require("../model/user_model");


router.post('/api/signup', UserController.signup);
router.post('/api/signin', UserController.signin);
router.post('/api/tokenIsValid', UserController.token);

//get user data
router.get('/', AuthMidd, async (req, res) => {
    const user = await UserModle.findById(req.user);
    res.json({ ...user._doc, token: req.token });
  });




module.exports = router;