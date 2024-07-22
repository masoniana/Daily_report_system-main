<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <h2>フォロー中</h2>
        <table id="timeline_list">
            <tbody>
                <tr>
                    <th class="following_name">氏名</th>
                    <th class="following_date">日付</th>
                    <th class="following_action">操作</th>
                </tr>
               <c:forEach var="following" items="${getMyAllFollowing}" varStatus="status">
                    <tr class="row${status.count % 2}">
                        <td class="following_name"><c:out value="${following.follow.name}" /></td>
                        <td class="following_date"><fmt:formatDate value='${following.created_at}' pattern='yyyy-MM-dd HH:mm:ss' /></td>
                        <td class="report_action">
                            <form method="POST" action="<c:url value='/follow/destroy' />">
                                <input type="hidden" name="id" value="${following.id}" />
                                <button type="submit" name="remove">フォロー解除</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div id="pagination">
            （全 ${getMyFollowingCount} 件）<br />
            <c:forEach var="i" begin="1" end="${((getMyFollowingCount - 1) / 10) + 1}"
                step="1">
                <c:choose>
                    <c:when test="${i == page}">
                        <c:out value="${i}" />&nbsp;
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/following/index?page=${i}' />"><c:out value="${i}" /></a>&nbsp;
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
        <p>
            <a href="<c:url value='/index.html' />">トップページへ戻る</a>
        </p>
    </c:param>
</c:import>