package controller;

import dao.AlertDAO;
import java.io.IOException;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.AppUser;

@WebServlet(urlPatterns = {"/standarts", "/standards"})
public class StandardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        AppUser me = (AppUser) req.getSession().getAttribute("user");
        String userRole = (me != null && me.getRoleCode() != null) ? me.getRoleCode() : "VIEWER";
        req.setAttribute("isAdmin", "ADMIN".equals(userRole));

        int openAlertCount = AlertDAO.getOpeningAlertCount();
        req.setAttribute("openAlertCount", openAlertCount);

        ZonedDateTime nowZdt = ZonedDateTime.now(ZoneId.of("Asia/Ho_Chi_Minh"));
        String jDateStr = nowZdt.format(DateTimeFormatter.ofPattern("EEEE, d MMMM yyyy", Locale.ENGLISH));
        String jTimeStr = nowZdt.format(DateTimeFormatter.ofPattern("HH:mm"));
        String jSidebarDateTime = nowZdt.format(DateTimeFormatter.ofPattern("EEEE, dd/MM/yyyy, HH:mm", Locale.ENGLISH));
        req.setAttribute("jDateStr", jDateStr);
        req.setAttribute("jTimeStr", jTimeStr);
        req.setAttribute("jSidebarDateTime", jSidebarDateTime);

        req.getRequestDispatcher("/WEB-INF/views/standards.jsp").forward(req, resp);
    }
}
