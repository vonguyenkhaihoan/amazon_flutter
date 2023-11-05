const {ProductModel} = require("../model/product_model");


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

    async searchProduct (req, res)  {
        try {
          const products = await ProductModel.find({
            name: { $regex: req.params.name, $options: "i" },
          });
      
          res.json(products);
        } catch (e) {
          res.status(500).json({ error: e.message });
        }
      }

  //top ten rate
  async toprate (req, res)  {
    try {
      //tim tat ca san pham trong db
      let products = await ProductModel.find({});
      
      // so sanh dang gia 
      products = products.sort((a, b) => {
        let aSum = 0;
        let bSum = 0;
  
        for (let i = 0; i < a.ratings.length; i++) {
          aSum += a.ratings[i].rating;
        }
  
        for (let i = 0; i < b.ratings.length; i++) {
          bSum += b.ratings[i].rating;
        }
        return aSum < bSum ? 1 : -1;
      });
      
      // tra ve 10 san pham đung dau danh sach danh gia
      res.json(products.slice(0, 10));
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }

}

module.exports = new  ProductController();
