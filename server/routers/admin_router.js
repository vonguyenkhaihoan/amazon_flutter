const router = require("express").Router();
const AdminMidd = require("../middlewares/admin_middle");
const ProductModel = require("../model/product_model");

// const AdminController = require("../controller/admin_controller");

// Add product
router.post('/admin/add-product', AdminMidd,  async (req, res) => {
    try {
      const { name, description, images, quantity, price, category } = req.body;
      let product = new ProductModel({
        name,
        description,
        images,
        quantity,
        price,
        category,
      });
      product = await product.save();
      res.json(product);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });


module.exports = router;
