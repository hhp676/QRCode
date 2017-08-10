package com.itstyle.action;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.io.FileUtils;

import com.itstyle.util.QRCode;
import com.itstyle.util.RandomUtil;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

public class QRCodeAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	// 封装上传文件域的属性
	private File image;
	// 封装上传文件类型的属性
	private String imageContentType;
	// 封装上传文件名的属性
	private String imageFileName;
	private String message;
	private String content;
	/**
	 * 生成二维码
	 * @Author	张志朋
	 * @return  String
	 * @Date	2015年3月18日
	 * 更新日志
	 * 2015年3月18日 张志朋  首次创建
	 *
	 */
	public String encoderQRCode(){ //C:\\Users\\HHP\\workspace\\QRCode\\WebContent\\file
		String realpath ="D:\\file";// ServletActionContext.getServletContext().getRealPath("/file");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String imgName = sdf.format(new Date()) + ".png";
		String  imgPath= realpath+"/"+imgName;
		QRCode.encoderQRCode(content, imgPath, "png");
		message = imgName;
		return Action.SUCCESS;
	}
	
	
	public String encoderHongniu(){
		String realpath = "D:\\file\\HNfile";// ServletActionContext.getServletContext().getRealPath("/file");
		
		//新建的
		String httpurl = "HTTP://H.1A0.CN/";
		for(int i=0; i<20; i++) {
			String name = "S"+RandomUtil.generateString(13);
			String conStr = httpurl +name;
			String imgName = conStr + ".png";
			String  imgPath= realpath+"/"+name+ ".png";
			QRCode.encoderQRCode(conStr, imgPath, "png");
			message = imgName;
		}
		return Action.SUCCESS;
	}
	/**
	 * 获取二维码
	 * @Author	张志朋
	 * @return  String
	 * @Date	2015年3月18日
	 * 更新日志
	 * 2015年3月18日 张志朋  首次创建
	 *
	 */
	public String decoderQRCode(){
        try {
        	String realpath = "D:/";// ServletActionContext.getServletContext().getRealPath("/file");
        	File savefile = new File(new File(realpath), imageFileName);
        	if (!savefile.getParentFile().exists())
        		savefile.getParentFile().mkdirs();
			FileUtils.copyFile(image, savefile);
			message   = QRCode.decoderQRCode(realpath+"/"+imageFileName);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return Action.SUCCESS;
	}
	
	public void setImage(File image) {
		this.image = image;
	}
	public String getImageContentType() {
		return imageContentType;
	}
	public void setImageContentType(String imageContentType) {
		this.imageContentType = imageContentType;
	}
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
}
