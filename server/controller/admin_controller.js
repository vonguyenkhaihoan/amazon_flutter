const OrderModel = require('../model/order_model');

class AdmminController {

    // change order status
    async changeOrderStatus (req, res)  {
        try {
          //lay id san pham tu UI
          const { id , status} = req.body;
      
          //timf vao xoa san pham theo ID
          // let order = await OrderModel.findById(id);
          // order.status = status
          let order = await OrderModel.findByIdAndUpdate(id, { status });
      
          order = await order.save();
          //phan hoi nguoi dung
          res.json(order);
        } catch (e) {
          res.status(500).json({ error: e.message });
        }
    }

    //get analytics
    async getAnalytics (req, res) {
        try {
            const orders = await OrderModel.find({});
            let totalEarnings = 0;
      
            for (let i = 0; i < orders.length; i++) {
                for (let j = 0; j < orders[i].products.length; j++) {
                totalEarnings +=
                    orders[i].products[j].quantity * orders[i].products[j].product.price;
                }   
            }

            // CATEGORY WISE ORDER FETCHING
            let mobileEarnings = await fetchCategoryWiseProduct("Mobiles");
            let essentialEarnings = await fetchCategoryWiseProduct("Essentials");
            let applianceEarnings = await fetchCategoryWiseProduct("Appliances");
            let booksEarnings = await fetchCategoryWiseProduct("Books");
            let fashionEarnings = await fetchCategoryWiseProduct("Fashion");

            let earnings = {
                totalEarnings,
                mobileEarnings,
                essentialEarnings,
                applianceEarnings,
                booksEarnings,
                fashionEarnings,
            };

            res.json(earnings);
        } catch (e) {
            res.status(500).json({ error: e.message });
        }
    }

}

//tong tien cua tung danh muc 
async function fetchCategoryWiseProduct(category) {
    let earnings = 0;
    let categoryOrders = await OrderModel.find({
      "products.product.category": category,
    });
  
    for (let i = 0; i < categoryOrders.length; i++) {
      for (let j = 0; j < categoryOrders[i].products.length; j++) {
        earnings +=
          categoryOrders[i].products[j].quantity *
          categoryOrders[i].products[j].product.price;
      }
    }
    return earnings;
}

module.exports = new AdmminController();