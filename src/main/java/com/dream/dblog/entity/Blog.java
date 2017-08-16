package com.dream.dblog.entity;

/**
 * Blog 实体类
 */
public class Blog {

    private int id;
    private int parent_id;
    private String title;
    private byte[] article;
    private String create_time;
    private String modify_time;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getParent_id() {
        return parent_id;
    }

    public void setParent_id(int parent_id) {
        this.parent_id = parent_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public byte[] getArticle() {
        return article;
    }

    public void setArticle(byte[] article) {
        this.article = article;
    }

    public String getCreate_time() {
        return create_time;
    }

    public void setCreate_time(String createTime) {
        this.create_time = createTime;
    }

    public String getModify_time() {
        return modify_time;
    }

    public void setModify_time(String modifyTime) {
        this.modify_time = modifyTime;
    }
}
