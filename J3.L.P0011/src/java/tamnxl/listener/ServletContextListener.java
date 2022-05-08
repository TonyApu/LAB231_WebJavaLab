/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.listener;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.annotation.WebListener;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import tamnxl.util.FileHelper;

/**
 * Web application lifecycle listener.
 *
 * @author TamNXL
 */
@WebListener
public class ServletContextListener implements javax.servlet.ServletContextListener {
    
    static final Logger LOGGER = Logger.getLogger(ServletContextListener.class);

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        String log4jConfigFile = context.getInitParameter("log4j-config-location");
        String fullPath = context.getRealPath("/") + log4jConfigFile;
        PropertyConfigurator.configure(fullPath);
        Map<String, String> siteMap = new HashMap();

        FileHelper fileHelper = new FileHelper();
        try {

            fileHelper.loadFile("siteMap.txt", sce);

        } catch (IOException ex) {
            LOGGER.error("ServletContextListener - IO " + ex.getMessage());
        }
        siteMap = fileHelper.getSiteMap();

        context.setAttribute("SITE_MAP", siteMap);
}

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
