<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <h2>タイムライン</h2>
        <table id="timeline_list">
            <tbody>
                <tr>
                    <th class="report_name">氏名</th>
                    <th class="report_date">日付</th>
                    <th class="report_title">タイトル</th>
                    <th class="report_like">いいね数</th>
                    <th class="report_action">操作</th>
                </tr>
                <c:forEach var="report" items="${getMyFollowAllReports}" varStatus="status">
                    <tr class="row${status.count % 2}">
                        <td class="report_name"><c:out value="${report.employee.name}" /></td>
                        <td class="report_date"><fmt:formatDate value='${report.created_at}' pattern='yyyy-MM-dd HH:mm:ss' /></td>
                        <td class="report_title">${report.title}</td>
                        <c:choose>
                            <c:when test="${report.like_count == 0}">
                                <td class="report_likes"><c:out value="${report.like_count}" /></td>
                            </c:when>
                            <c:otherwise>
                                <td class="report_likes"><a href="<c:url value='/likes/index?report_id=${report.id}' />"><c:out value="${report.like_count}" /></a></td>
                            </c:otherwise>
                        </c:choose>
                        <td class="report_action"><a href="<c:url value='/reports/show?id=${report.id}' />">詳細を見る</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div id="pagination">
            （全 ${getMyFollowReportsCount} 件）<br />
            <c:forEach var="i" begin="1" end="${((getMyFollowReportsCount - 1) / 10) + 1}"
                step="1">
                <c:choose>
                    <c:when test="${i == page}">
                        <c:out value="${i}" />&nbsp;
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/timeline/index?page=${i}' />"><c:out value="${i}" /></a>&nbsp;
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
        <p>
            <a href="<c:url value='/index.html' />">トップページへ戻る</a>
        </p>
    </c:param>
</c:import>