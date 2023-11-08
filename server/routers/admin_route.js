const router = require("express").Router();
const AdminMidd = require("../middlewares/admin_middle");
const {ProductModel} = require("../model/product_model");
const OrderModel = require("../model/order_model");
const AdminController = require("../controller/admin_controller")

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

//get all product
router.get("/admin/get-products", AdminMidd , async (req, res) => {
  try {
    //tim tat ca san pham
    const products = await ProductModel.find({});

    //tra ve nguoi dung
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

router.get("/admin/get-orders", AdminMidd, async (req, res) => {
  try {
    const orders = await OrderModel.find({});
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


// Delete the product
router.post("/admin/delete-product", AdminMidd , async (req, res) => {
  try {
    //lay id san pham tu UI
    const { id } = req.body;

    //timf vao xoa san pham theo ID
    let product = await ProductModel.findByIdAndDelete(id);

    //phan hoi nguoi dung
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// change status Order
router.post("/admin/change-order-status", AdminMidd ,AdminController.changeOrderStatus);
// router.post("/admin/change-order-status", AdminMidd , async (req, res) => {
//   try {
//     //lay id san pham tu UI
//     const { id , status} = req.body;

//     //timf vao xoa san pham theo ID
//     // let order = await OrderModel.findById(id);
//     // order.status = status
//     let order = await OrderModel.findByIdAndUpdate(id, { status });

//     order = await order.save();
//     //phan hoi nguoi dung
//     res.json(order);
//   } catch (e) {
//     res.status(500).json({ error: e.message });
//   }
// });

//get analytics
router.get("/admin/analytics", AdminMidd, AdminController.getAnalytics);




module.exports = router;
