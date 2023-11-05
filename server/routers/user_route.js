const router = require("express").Router();
const AuthMidd = require("../middlewares/auth_middle");
const UserController = require("../controller/user_controller");


// Add product to cart
router.post('/api/add-to-cart', AuthMidd,  UserController.addToCart);
router.delete('/api/remove-a-to-cart/:id', AuthMidd,  UserController.removeAToCart);
router.delete("/api/empty-cart", AuthMidd, UserController.removeAllCart);
router.delete("/api/remove-from-cart/:id", AuthMidd, UserController.removeProductToCart);

  


module.exports = router;
