package com.poly.service.imp;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.poly.service.UploadService;

@Service
public class UploadServiceImp implements UploadService {

	@Autowired
	ServletContext app;

	@Override
	public File save(MultipartFile file, String folder) {
		File dir = new File(app.getRealPath("/image/"+folder));
		if(!dir.exists())
			dir.mkdirs();
		
		//String s = System.currentTimeMillis() + file.getOriginalFilename();
		String name = file.getOriginalFilename();
		try {
			File saveFile = new File(dir,name);
			file.transferTo(saveFile);
			System.out.println(saveFile.getAbsolutePath());
			return saveFile;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
}
