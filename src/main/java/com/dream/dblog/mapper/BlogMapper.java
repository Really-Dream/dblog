package com.dream.dblog.mapper;

import com.dream.dblog.entity.Blog;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 *
 */
@Mapper
public interface BlogMapper {


    Blog getBlog(int id);

    List<Blog> showParent();
    List<Blog> showChild(int id);

    String getParentTitle(int id);

    int insert(Blog blog);
    int delete(int id);
    int update(Blog blog);
    int getMaxId();
}
