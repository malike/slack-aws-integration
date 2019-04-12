package st.malike.bot.service;

import java.io.IOException;
import org.springframework.stereotype.Service;

@Service
public class AWSService {

  public String executeAWSCommand(String text, String channelId, String... arg) throws IOException {
    String output = "";
    String bashScript;
    if (text.equalsIgnoreCase("mfa-disabled")) {
      bashScript = "aws-mfacheck.sh " + channelId;
    } else if (text.equalsIgnoreCase("s3-check")) {
      bashScript = "aws-s3check.sh " + channelId;
    } else if (text.equalsIgnoreCase("aws-lb-scale")) {
      bashScript = "aws-ecs-scale.sh " + channelId;
    } else {
      bashScript = "no-configured-command";
    }
    new ProcessBuilder("bash", "-c", bashScript)
        .start();
    return output;
  }
}
