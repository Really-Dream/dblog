package com.dream.dblog.controller;

import com.dream.dblog.entity.Blog;
import com.dream.dblog.mapper.BlogMapper;
import com.dream.dblog.service.BlogService;
import com.dream.dblog.util.DataFormat;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.UnsupportedEncodingException;
import java.util.List;

/**
 *
 */
@Controller
@RequestMapping(value = {"blog",""})
public class BlogController {

    @Autowired
    BlogMapper blogMapper;

    @Autowired
    BlogService blogService;

    Gson gson = new Gson();

    /**
     * 查询所有的分类
     * @return
     */
    @RequestMapping(value = "showParent")
    @ResponseBody
    public String showParent(){
        List<Blog> list = blogMapper.showParent();
        return gson.toJson(list);
    }

    /**
     * 查询分类下的所有的子节点
     * @param id
     * @return
     */
    @RequestMapping(value = "showChild")
    @ResponseBody
    public String showChild(int id){
        List<Blog> list = blogMapper.showChild(id);
        return gson.toJson(list);
    }

    /**
     * 查询分类标题
     * @param id
     * @return
     */
    @RequestMapping(value = "showTitle")
    @ResponseBody
    public String showTitle(int id){
        String title = blogMapper.getParentTitle(id);
        if(title == null || title.length()<=0){
            title = "時光若刻";
        }
        return gson.toJson(title);
    }

    /**
     * 首页和分类首页
     * @param model
     * @param id
     * @return
     */
    @RequestMapping(value = {"index",""})
    public String index(Model model,String id){
        List<Blog> parent_title = blogMapper.showParent();
        if(id != null){
            String title = blogMapper.getParentTitle(Integer.parseInt(id));
            List<Blog> list = blogMapper.showChild(Integer.parseInt(id));
            model.addAttribute("list",list);
            model.addAttribute("title",title);
        }else{
            String title = "時光若刻";
            List<Blog> list = blogMapper.showParent();
            model.addAttribute("list",list);
            model.addAttribute("title",title);
        }
        model.addAttribute("parent_title",parent_title);
        model.addAttribute("id",id);
        return "index";
    }

    /**
     * 查看博客
     * @param model
     * @param id
     * @return
     */
    @RequestMapping(value = "readBlog")
    public String readBlog(Model model,String id){
        Blog blog = blogMapper.getBlog(Integer.parseInt(id));
        blogService.getBlog(model,blog);
        model.addAttribute("blog",blog);
        return "readMarkdown";
    }


    /**
     * 初始化后台首页
     * @param model
     * @return
     */
    @RequestMapping(value = "admin")
    public String admin(Model model){
        List<Blog> list = blogMapper.showParent();
        model.addAttribute("list",list);
        return "admin";
    }

    /**
     * 编辑Blog
     * @param model
     * @param id
     * @return
     */
    @RequestMapping(value = "editBlog")
    public String editBlog(Model model,String id){
        Blog blog = blogMapper.getBlog(Integer.parseInt(id));
        blogService.getBlog(model,blog);
        model.addAttribute("blog",blog);
        return "markdown";
    }

    /**
     * 新建Blog
     * @param article
     * @param title
     * @return
     */
    @RequestMapping(value = "insert")
    @ResponseBody
    public String insert(String article, String title, String parent_id, String sub_id){
        Blog blog = new Blog();
        try {
            if(article != null){
                byte[] articles = article.getBytes("UTF-8");
                blog.setArticle(articles);
            }
            blog.setTitle(title);
            blog.setParent_id(Integer.parseInt(parent_id));
            blog.setCreate_time(DataFormat.getNowDate());
            blog.setModify_time(DataFormat.getNowDate());
            if(sub_id != null && sub_id.length() > 0 ){
                blog.setId(Integer.parseInt(sub_id));
                blogMapper.update(blog);
            }else{
                blog.setId(blogService.getNewId());
                blogMapper.insert(blog);
            }
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return gson.toJson("FALSE");
        }
        return gson.toJson("SUCCESS");
    }

    @RequestMapping(value = "delete")
    public String delete(String id){
        blogMapper.delete(Integer.parseInt(id));
        return "";
    }

    @RequestMapping(value = "getBlog")
    @ResponseBody
    public String getBlog(String id){
        Blog blog = blogMapper.getBlog(Integer.parseInt(id));
        return gson.toJson(blog);
    }


}
