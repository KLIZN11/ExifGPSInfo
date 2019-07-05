package com.edu.imnu.exifgps.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.drew.metadata.ImgInfoBean;
import com.edu.imnu.exifgps.util.DBUtil;

public class gpsDAO {
	public List<String> getGpsList(){
		List<String>list=new ArrayList<String>();
		Connection conn=DBUtil.getConnection();
		//if(connection==null) 
			//return null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="SELECT image_path FROM tb_image";
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				String path=rs.getString("image_path");
				list.add(path);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.closeJDBC(rs, pstmt, conn);
		}
		return list;
	}
}
