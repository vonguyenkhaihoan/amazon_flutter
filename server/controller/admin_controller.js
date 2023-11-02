const ProductModel = require("../model/product_model");

class AdminController{
    async addProduct(req, res){
        try {
            // lay du lieu tu UI
            const {name , description, quantity, images, category, price} = req.body;

            //tao bien product co dangj doi tuong Product()
            let product = new ProductModel({
                name,
                description,
                images,
                quantity,
                price,
                category,
            });

            // luu bien vao db
            product = await product.save();
            res.json(product);

        }catch(err){

        }
    }
}

module.exports = new AdminController();