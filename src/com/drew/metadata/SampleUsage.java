package com.drew.metadata;

import java.io.File;
import java.io.IOException;

import com.drew.imaging.ImageMetadataReader;
import com.drew.imaging.ImageProcessingException;

public class SampleUsage {
	// 图片信息获取metadata元数据信息
	   
	    public ImgInfoBean parseImgInfo (String fileName)
	    {
	        File file = new File(fileName);
	        ImgInfoBean imgInfoBean = null;
	        try {
	            Metadata metadata = ImageMetadataReader.readMetadata(file);
	            imgInfoBean = printImageTags(file, metadata);
	        } catch (ImageProcessingException e) {
	            System.err.println("error 1a: " + e);
	        } catch (IOException e) {
	            System.err.println("error 1b: " + e);
	        }
	        return imgInfoBean;
	    }
	 
	    //读取metadata里面的信息
	    
	    private ImgInfoBean printImageTags(File sourceFile, Metadata metadata)
	    {
	        ImgInfoBean imgInfoBean = new ImgInfoBean ();
	        imgInfoBean.setImgSize(sourceFile.getTotalSpace());
	        imgInfoBean.setImgName(sourceFile.getName());
	        for (Directory directory : metadata.getDirectories()) {
	            for (Tag tag : directory.getTags()) {
	            	String tagName = tag.getTagName();
	            	String desc = tag.getDescription();
					if (tagName.equals("Image Height")) {
						imgInfoBean.setImgHeight(desc);
					} else if (tagName.equals("Image Width")) {
						imgInfoBean.setImgWidth(desc);
					} else if (tagName.equals("GPS Altitude")) {
						imgInfoBean.setAltitude(desc);
					} else if (tagName.equals("GPS Latitude")) {
						imgInfoBean.setLatitude(pointToLatlong(desc));
					} else if (tagName.equals("GPS Longitude")) {
						imgInfoBean.setLongitude(pointToLatlong(desc));
					}
	            }
	            for (String error : directory.getErrors()){
	            	System.err.println("ERROR: " + error);
	            }
	        }
	        return imgInfoBean;
	    }
	 
	    
	    
	    public String pointToLatlong (String point ) {
	    	Double du = Double.parseDouble(point.substring(0, point.indexOf("°")).trim());
	    	Double fen = Double.parseDouble(point.substring(point.indexOf("°")+1, point.indexOf("'")).trim());
	    	Double miao = Double.parseDouble(point.substring(point.indexOf("'")+1, point.indexOf("\"")).trim());
	    	Double duStr = du + fen / 60 + miao / 60 / 60 ;
	    	return duStr.toString();
	    }
	   
	    public static void main(String[] args)
	    {
	        ImgInfoBean imgInfoBean = new SampleUsage().parseImgInfo("C:\\Users\\Lenovo\\Desktop\\12.jpg");
	        System.out.println(imgInfoBean.toString());
	    }

}
