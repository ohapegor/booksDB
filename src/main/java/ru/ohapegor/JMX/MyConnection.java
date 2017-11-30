package ru.ohapegor.JMX;

import javax.management.MBeanInfo;
import javax.management.MBeanServerConnection;
import javax.management.ObjectName;
import javax.management.remote.JMXConnector;
import javax.management.remote.JMXConnectorFactory;
import javax.management.remote.JMXServiceURL;
import javax.naming.Context;
import java.io.IOException;
import java.net.MalformedURLException;
import java.util.Hashtable;

public class MyConnection  {

    private static MBeanServerConnection connection;
    private static JMXConnector connector;
    private static ObjectName service;


    public static void initConnection(String hostname, String portString,
                                      String username, String password) throws IOException,
            MalformedURLException {

        String protocol = "t3";
        Integer portInteger = Integer.valueOf(portString);
        int port = portInteger.intValue();
        String jndiroot = "/jndi/";
        String mserver = "weblogic.management.mbeanservers.domainruntime";
        JMXServiceURL serviceURL = new JMXServiceURL(protocol, hostname, port,
                jndiroot + mserver);

        Hashtable h = new Hashtable();
        h.put(Context.SECURITY_PRINCIPAL, username);
        h.put(Context.SECURITY_CREDENTIALS, password);
        h.put(JMXConnectorFactory.PROTOCOL_PROVIDER_PACKAGES,
                "weblogic.management.remote");
        h.put("jmx.remote.x.request.waiting.timeout", new Long(10000));
        connector = JMXConnectorFactory.connect(serviceURL, h);
        connection = connector.getMBeanServerConnection();
    }

    public static void main(String[] args) throws Exception {
        String hostname = "localhost";
        String portString = "7001";
        String username = "weblogic";
        String password = "htytcfyc1992";

        MyConnection c= new MyConnection();
        initConnection("localhost", "7001", "weblogic", "htytcfyc1992");
       ObjectName service =  new ObjectName("com.bea:Name=MBeanTypeService,Type=weblogic.management.mbeanservers.MBeanTypeService");
        //ObjectName service =  new ObjectName("*:Name=WorkManager,Type=weblogic.management.configuration.WorkManagerMBean ");
        //MBeanTypeServiceMBean
          MBeanInfo info = connection.getMBeanInfo(service);
        System.out.println(info);
       //System.out.println(connection.getAttribute(service,"Count"));
       // MBeanServerConnection

        connector.close();
    }
}
