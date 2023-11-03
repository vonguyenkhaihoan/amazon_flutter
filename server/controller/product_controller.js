const ProductModel = require("../model/product_model");


class ProductController{
     async getProduct (req, res)  {
        try {
            console.log(req.query.category);
    
            //tim tat ca san pham
            const products = await ProductModel.find({category: req.query.category});
      
            //tra ve nguoi dung
            res.json(products);
        } catch (e) {
            res.status(500).json({ error: e.message });
        }
    }
}

module.exports = new  ProductController();
