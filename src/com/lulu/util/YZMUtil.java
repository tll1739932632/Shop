package com.lulu.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//验证码的生成
public class YZMUtil {

	public  String words="qwertyuipasdfghjkzxcvbnmQWERTYUIPASDFGHJKLZXCVBNM23456789";
	Random random=new Random();
	//随机生成验证码
	public String getRandomYZM(){
		StringBuilder code=new StringBuilder();
	
		for(int i=0;i<4;i++){
			char c=words.charAt(random.nextInt(words.length()-1));
			code.append(c);
		}
		return code.toString();
	}
	
	public Color getColor(){
		int r=50+random.nextInt(125);
		int g=50+random.nextInt(125);
		int b=50+random.nextInt(125);
		return new Color(r, g, b);
	}
	//画出验证码
	public void drawYZM(HttpServletRequest request,HttpServletResponse response){
		String code=getRandomYZM();
		HttpSession session=request.getSession();
		session.setAttribute("VCODE", code);//备份验证码在session中
		
		int width=110;
		int height=25;
		
		
		//图片对象，把验证码放在图片对象里
		BufferedImage image=new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		
		//获取“画笔”
		Graphics2D g=image.createGraphics();
		
		//背景颜色
		g.setColor(new Color(175,238,238));
		//背景大小
		g.fillRect(0, 0, width, height);
		
		//绘制验证码
		for(int i=0;i<code.length();i++){
			g.setColor(getColor());	
			g.setFont(new Font("宋体", Font.BOLD, 22));
			//g.rotate(10*Math.PI/180);
			g.drawString(code.charAt(i)+"", 20*i+15, 20);
			
		}
		
		//绘制干扰线
		for(int i=0;i<5;i++){
			g.setColor(getColor());
			int x1=random.nextInt(width-5);
			int x2=random.nextInt(width-5);
			int y1=random.nextInt(height-5);
			int y2=random.nextInt(height-5);
			g.drawLine(x1, y1, x2, y2);
		}
		//绘制干扰点
		for(int i=0;i<5;i++){
			g.setColor(getColor());
			int x=random.nextInt(width-5);
			int y=random.nextInt(height-5);
			g.fillOval(x, y, (int)2.5, (int)2.5);
		}
		
		//把画好的图片写入到响应输出流
		try {
			ImageIO.write(image, "JPEG", response.getOutputStream());
			//强制写入到浏览器
			response.getOutputStream().flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
