package com.sns.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileManagerService {

	public static final String FILE_UPLOAD_PATH = "D:\\Limhyeona\\6_spring_project\\SNS\\sns_workspace\\images/";
//	public static final String FILE_UPLOAD_PATH = "/Users/jessie/Desktop/jessie/6_springproject/sns/sns_workspace/images/";
	
	public String saveFile(String loginId, MultipartFile file) {
		
		String directoryName = loginId + "_" + System.currentTimeMillis(); // aaaa + "_" + 2384098
		String filePath = FILE_UPLOAD_PATH + directoryName; 
		// /Users/jessie/Desktop/jessie/6_springproject/sns/sns_workspace/images/aaaa_2384098/
		
		File directory = new File(filePath);
		if (directory.mkdir() == false) {
			return null;
		}
		
		// 파일 업로드 
		try {
			byte[] bytes = file.getBytes();
			Path path = Paths.get(filePath + "/" + file.getOriginalFilename());
			Files.write(path, bytes);
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
		
		return "/images/" + directoryName + "/" + file.getOriginalFilename();
		
	}
	
}
