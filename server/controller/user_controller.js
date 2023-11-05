const {ProductModel} = require("../model/product_model");
const UserModel = require('../model/user_model');


class UserController{
    //them san pham
    async addToCart (req, res) {
        try {
            // lấy id từ UI
            const { id } = req.body;

            //tìm san pham theo id
            const product = await ProductModel.findById(id);

            // tìm nguoi dung teo id
            let user = await UserModel.findById(req.user);
      
            //kiểm tra gio hang co trống nếu trống thì thêm sản phâm và nguoic lại
            if (user.cart.length == 0) {
                user.cart.push({ product, quantity: 1 });
            } else {
                //neu gio hang không trong thì chạy vòng lạo giỏ hàng
                let isProductFound = false;
                for (let i = 0; i < user.cart.length; i++) {
                    //nêu tim thay san pham da có trong giỏ hang 
                    if (user.cart[i].product._id.equals(product._id)) {
                        isProductFound = true;
                    }
                }
                
                //nếu san pham da ton tại trong gio hang thì cap nhat lại số luong san pham
                if (isProductFound) {
                    let producttt = user.cart.find((productt) =>
                        productt.product._id.equals(product._id)
                    );
                  producttt.quantity += 1;

                } else {
                    //nếu san pham chua ton tại thi them vào
                    user.cart.push({ product, quantity: 1 });
                }
            }
            user = await user.save();
            res.json(user);
        } catch (e) {
            res.status(500).json({ error: e.message });
        }
      }

    //giam so luong san pham
    async removeAToCart (req, res) {
        try {
            // lấy id từ UI
            const { id } = req.params;

            //tìm san pham theo id
            const product = await ProductModel.findById(id);

            // tìm nguoi dung teo id
            let user = await UserModel.findById(req.user);
      
           
            //neu gio hang không trong thì chạy vòng lạo giỏ hàng
            for (let i = 0; i < user.cart.length; i++) {
                if (user.cart[i].product._id.equals(product._id)) {
                  if (user.cart[i].quantity == 1) {
                    user.cart.splice(i, 1);
                  } else {
                    user.cart[i].quantity -= 1;
                  }
                }
            }              
            
            user = await user.save();
            res.json(user);
        } catch (e) {
            res.status(500).json({ error: e.message });
        }
      }

      //xoa tat ca san pham
      async removeAllCart (req, res) {
        try {
          let user = await UserModel.findById(req.user);
          user.cart = [];
          user = await user.save();
          res.json(user);
        } catch (e) {
          res.status(500).json({ error: e.message });
        }
      }

      async removeProductToCart(req, res)  {
        try {
          const { id } = req.params;
          const product = await ProductModel.findById(id);
          let user = await UserModel.findById(req.user);
      
          // await user.cart.findOneAndDelete({ product: product });
          // Xóa sản phẩm khỏi giỏ hàng
          const cartIndex = user.cart.findIndex(item => item.product._id.toString() === product._id.toString());
          if (cartIndex !== -1) {
            user.cart.splice(cartIndex, 1);
          }
          user = await user.save();
          res.json(user);
        } catch (e) {
          res.status(500).json({ error: e.message });
        }
      }
}

module.exports = new UserController();