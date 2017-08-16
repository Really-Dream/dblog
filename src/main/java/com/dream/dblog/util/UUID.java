package com.dream.dblog.util;

import com.dream.dblog.mapper.BlogMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.concurrent.atomic.AtomicInteger;

/**
 * 生成UUID
 */
public class UUID {

    public UUID (int initValue){
        counter = new AtomicInteger(initValue);
    }

    private static AtomicInteger counter = new AtomicInteger(0);

    public static long getAtomicCounter() {
        if (counter.get() > 999999) {
            counter.set(1);
        }
        long time = System.currentTimeMillis();
        long returnValue = time * 100 + counter.incrementAndGet();
        return returnValue;
    }

    public static long incrementAndGet() {
        return counter.incrementAndGet();
    }


}
