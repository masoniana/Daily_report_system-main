package controllers.likes;

import java.io.IOException;
import java.sql.Timestamp;

import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Employee;
import models.Like;
import models.Report;
import utils.DBUtil;

/**
 * Servlet implementation class LikesCreateServlet
 */
@WebServlet("/likes/create")
public class LikesCreateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public LikesCreateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // EntityManagerのオブジェクトを生成
        EntityManager em = DBUtil.createEntityManager();

        // リクエストパラメータからレポートのIDを取得して該当のIDのレポート1件のみをデータベースから取得
        Report r = em.find(Report.class, Integer.parseInt(request.getParameter("report_id")));

        Like l = new Like();

        l.setEmployee((Employee) request.getSession().getAttribute("login_employee"));
        l.setReport(r);
        Timestamp currentTime = new Timestamp(System.currentTimeMillis());
        l.setCreated_at(currentTime);
        l.setUpdated_at(currentTime);

        // いいねをプロパティにvalue(1)を上書き
        r.setLike_count(Integer.parseInt(request.getParameter("like_count")) + r.getLike_count());

        // データベースを更新
        em.getTransaction().begin();
        em.persist(l);
        em.getTransaction().commit();
        em.close();
        request.getSession().setAttribute("flush", "いいねしました。");

        // indexページへリダイレクト
        response.sendRedirect(request.getContextPath() + "/reports/index");
    }

}
