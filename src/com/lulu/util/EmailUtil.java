package com.lulu.util;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtil {
    // 发件人固定地址(服务号的地址，自动发送邮件发件人)
	public static final String SENDADDRESS="service@shop.com";
	// 发件人密码
	public static final String SENDPASSWORD="tll1739.";
	// 邮件服务器地址（因为winmail服务器 装在本地，这里写的是本地的ip地址)
	public static final String HOST="192.168.1.101";
	
	public static void sendEmail(String reciever,String code){
		// 1. 建立连接
		// ① 设置连接属性
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true"); // 是否需要授权，验证
		props.put("mail.smtp.host", HOST);   // 邮件服务器的地址
		props.put("mail.smtp.port", 25);     // 端口号
	    // 建立连接
		Session session = Session.getInstance(props, new Authenticator(){
			@Override // 重写使用密码验证方法
			protected PasswordAuthentication getPasswordAuthentication() {
				// 新建一个 使用用户名密码 验证
				return new PasswordAuthentication(SENDADDRESS,SENDPASSWORD);
			}
		});
		
		try {
			// 2. 发送
			Message message = new MimeMessage(session);
			// 设置发件人地址
			message.setFrom(new InternetAddress(SENDADDRESS));
			// 设置收件人地址 // RecipientType表示收件人的类型
			message.setRecipient(RecipientType.TO, new InternetAddress(reciever));
			// 邮件标题
			message.setSubject("lulu商城官方网站激活邮件");
			// 邮件正文
			String content="";
			content+="<p>lulu商城官方网站激活邮件!点此链接，完成激活!此邮件由系统自动发送，请勿回复!</p>";
			content+="<a href='http://192.168.1.101:8080/Shop/user/active.do?code=";
			content+=code;
			content+="'>";
			content+="http://tianluluweb.free.ngrok.cc/Shop/user/active.do?code=";
			content+=code;
			content+="</a>";
			message.setContent(content,"text/html;charset=UTF-8");
			// 发送邮件
			Transport.send(message);
		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		sendEmail("1739932632@qq.com", "abcd1234abcd");
		System.out.println("邮件发送成功!");
	}
}
