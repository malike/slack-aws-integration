package st.malike.bot.service;

import org.springframework.stereotype.Service;

@Service
public class AWSService {

  public String executeAWSCommand(String text) {
    String bashScript = "";
    Process process = new ProcessBuilder("/bin/bash", "-c", bashScript);
  }
}
