const express = require("express");
const mongoose = require("mongoose");
const Blog = require("./models/blog");
const router = require("./routes/blogRoutes");
var app = express();

//mongoDb connection
const dbUrl =
  "mongodb+srv://sri_2004:malasri32@cluster0.w9fzv.mongodb.net/NodejsProject?retryWrites=true&w=majority&appName=Cluster0";
mongoose
  .connect(dbUrl)
  .then((result) => {
    console.log("Db connected");
    console.log("port listening on 4000");
    app.listen(4000);
  })
  .catch((err) => {
    console.log("error:", err);
  });
app.set("view engine", "ejs");
app.use((req, res, next) => {
  console.log("MiddleWare Started");
  console.log("host:", req.hostname);
  console.log("path:", req.path);
  console.log("method:", req.method);
  next(); //go to next middleware
});

app.use((req, res, next) => {
  console.log("The Next Middleware");
  next();
});
//to find files inside the public folder without specifing the entire path
app.use(express.static("public"));
app.use(express.urlencoded({ extended: true }));
//middleware is viewing the request.body & this works to navigate all url.

//to display in home page
// app.get("/", (req, res) => {
//   // res.sendFile("./views/index.html", { root: __dirname })
//   // res.render("./blogs/ejsIndex");
//   const blogs = [
//     {
//       title: "The Secret",
//       snippet: "law of attraction",
//     },
//     {
//       title: "Rich dad poor dad",
//       snippet: "Personal Finance",
//     },
//     {
//       title: "The power of subconsious mind",
//       snippet: "Self help book",
//     }
//   ];
//   res.render("./blogs/ejsIndex", { blogs , title:"home"});
// });

//Sandbox routes
// app.get("/add-blogs", (req, res) => {
//   const Dbblogs = new Blog({
//     title: "Ratan Tata : A Life",
//     snippet: "Inspirational Book",
//     body: "Life of Ratan Tata and his contribution to people by brands.",
//   });
//   Dbblogs.save()
//     .then((result) => {
//       res.send(result);
//       console.log(result);
//     })
//     .catch((err) => {
//       console.log(err);
//     });
// });

// app.get("/all-blogs", (req, res) => {
//   Blog.find()
//     .then((result) => {
//       res.send(result);
//       console.log(result);
//     })
//     .catch((err) => {
//       console.log(err);
//     });
// });

app.get("/",(req,res)=>{
  res.redirect("/blogs");
})
app.use("/blogs", router);

app.get("/about", (req, res) => {
  //     res.sendFile("./blogs/ejsAbout", { root: __dirname })
  res.render("./blogs/ejsAbout.ejs");
});


app.use((req, res) => {
  res.sendFile("./views/404.html", { root: __dirname });
});
