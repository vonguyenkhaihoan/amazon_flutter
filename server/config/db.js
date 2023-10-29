const mongoose = require('mongoose');
const DB ='mongodb://localhost:27017/amazone';

const connection = mongoose
.connect(DB)
.then(() => {
  console.log("Connection Successful");
})
.catch((e) => {
  console.log(e);
});

module.exports = connection;