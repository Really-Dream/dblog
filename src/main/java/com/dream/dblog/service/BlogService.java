package com.dream.dblog.service;

import com.dream.dblog.entity.Blog;
import com.dream.dblog.mapper.BlogMapper;
import com.dream.dblog.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.io.UnsupportedEncodingException;

/**
 * .
 */
@Service
public class BlogService {
    @Autowired
    BlogMapper blogMapper;

    public void getBlog(Model model, Blog blog){
        String article;
        try {
            if(blog.getArticle() != null){
                article = new String(blog.getArticle(),"UTF-8");
                model.addAttribute("article", article);
            }else{
                model.addAttribute("article","");
            }
        } catch (UnsupportedEncodingException e) {
            model.addAttribute("article","");
            e.printStackTrace();
        }
    }

    public int getNewId(){
        UUID uuid = new UUID(blogMapper.getMaxId());
        return (int) UUID.incrementAndGet();
    }

}
