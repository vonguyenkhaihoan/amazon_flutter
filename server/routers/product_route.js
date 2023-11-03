const router = require("express").Router();
const AuthMidd = require("../middlewares/auth_middle");
const ProductModel = require("../model/product_model");
const ProductController = require("../controller/product_controller")


// api products
// router.get("/api/products", AuthMidd , async (req, res) => {
//     try {
//         console.log(req.query.category);

//         //tim tat ca san pham
//         const products = await ProductModel.find({category: req.query.category});
  
//         //tra ve nguoi dung
//         res.json(products);
//     } catch (e) {
//         res.status(500).json({ error: e.message });
//     }
//   });
router.get("/api/products", AuthMidd , ProductController.getProduct);

module.exports = router;