package com.ylb.common;


import java.util.List;

/**
 * 滚动查询输出参数
 *
 * @author Ricky
 * @date 2021/7/6
 */
public class PagedResult<T> {

    private Long total;
    private List<T> list;

    public PagedResult(Long total, List<T> list) {
        this.total = total;
        this.list = list;
    }

    public List<T> getList() {
        return this.list;
    }

    public Long getTotal() {
        return this.total;
    }

    public static <T> PagedResult<T> of(Long total, List<T> list) {
        return new PagedResult<>(total, list);
    }

    /**
     * 手动分页
     *
     * @author Ricky Li
     * @date 2023-08-02 18:08
     */
    public static <T> PagedResult<T> queryPageInfo(int currentPage, int pageSize, List<T> list) {
        int total = list.size();
        if (total > pageSize) {
            int toIndex = pageSize * currentPage;
            if (toIndex > total) {
                toIndex = total;
            }
            if (pageSize * (currentPage - 1) <= toIndex) {
                list = list.subList(pageSize * (currentPage - 1), toIndex);
            } else {
                list.clear();
            }
        }
        return PagedResult.of((long) total, list);
    }
}
