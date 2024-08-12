package com.ga.gaent.util;

import java.io.File;
import org.springframework.stereotype.Component;
import com.ga.gaent.dto.FileReqDTO;
import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class FileUploadSetting {
    private static String UPLOAD_DIR;

    /*
     * @author : 조인환
     * @since : 2024. 07. 16.
     * Description : 파일이 저장되는 위치 설정
     */
    @PostConstruct
    public void initDIR() {
        try {

            String projectDir = System.getProperty("user.dir") + "/src/main/resources/static/upload/";
            // String projectDir = System.getProperty("user.dir") + "/upload/";

            UPLOAD_DIR = projectDir;
            // log.debug(TeamColor.PURPLE_BG + "파일저장위치: " + UPLOAD_DIR + TeamColor.RESET);

        } catch (Exception e) {
            throw new RuntimeException("Failed to initialize UPLOAD_DIR", e);
        }
    }

    /*
     * @author : 조인환
     * @since : 2024. 07. 16.
     * Description : 실제파일저장
     */
    public int insertFile(String newFileName, FileReqDTO fileReqDTO, String dir) {
        File destinationFile = new File(UPLOAD_DIR + dir + File.separator + newFileName);

        try {
            fileReqDTO.getGaFile().transferTo(destinationFile);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("File transfer failed.", e);
        }

        return 1;
    }

}
