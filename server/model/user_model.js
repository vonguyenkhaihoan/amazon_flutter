const mongoose = require("mongoose");
const db = require('../config/db');
const { productSchema } = require("./product_model");

const UserSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
    trim: true,
  },
  email: {
    required: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(re);
      },
      message: "Please enter a valid email address",
    },
  },
  password: {
    required: true,
    type: String,
  },
  address: {
    type: String,
    default: "",
  },
  type: {
    type: String,
    default: "user",
  },
  cart: [
    {
      product: productSchema,
      quantity: {
        type: Number,
        required: true,
      },
    },
  ],
 
} ,{ timestamps: true }
// ,{
//   toJSON:{
//     tranfrom: function(doc, ret){
//       ret.authId = ret._id.toString();
//       delete ret._id;
//       delete ret._v;
//     }
//   }
// }
);

const UserModel = mongoose.model("User", UserSchema);
module.exports = UserModel;