const { request } = require("express");
const Blog = require("../models/blog");
const blog_index = (req, res) => {
    Blog.find().sort({ createdAt: -1 })
        .then((result) => {
            res.render("blogs/ejsIndex.ejs", { title: "All Blogs", blogs: result });
            console.log("");
        })
        .catch((err) => {
            console.log(err);
        });
};
const blog_create_post = async(req, res) => {
    console.log(req.body);
    const post_values = new Blog(req.body);
    post_values.save()
        .then((result) => {
            console.log("Blog saved successfully:", result);
            res.redirect("/blogs");
        })
        .catch((err) => {
            console.error("Error saving blog:", err);
            res.status(500).send("Error saving blog");
        });

};
const createBlog = (req, res) => {
    res.render("blogs/create", { title: "Create New Blogs" })
};

const blog_details = (req, res) => {
    const id = req.params.id;
    Blog.findById(id)
        .then((result) => {
            res.render("blogs/details", { title: "Blog Details", blog: result })
        })
        .catch((err) => {
            console.log(err)
        })
};


const blog_delete = (req, res) => {
    const id = req.params.id;
    Blog.findByIdAndDelete(id)
        .then((result) => {
            res.json({ redirect: "/blogs" });
        })
        .catch((err) => { console.log(err) })
}
module.exports = { blog_index, blog_create_post, createBlog, blog_details, blog_delete };

