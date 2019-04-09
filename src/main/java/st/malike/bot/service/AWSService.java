package st.malike.bot.service;

import java.io.IOException;
import org.springframework.stereotype.Service;

@Service
public class AWSService {

  public String executeAWSCommand(String text, String channelId) throws IOException {
    String output = "";
    String bashScript;
    if (text.equalsIgnoreCase("mfa-disabled")) {
      bashScript = "aws-mfacheck.sh " + channelId;
    } else if (text.equalsIgnoreCase("s3-check")) {
      bashScript = "aws-s3check.sh " + channelId;
    } else if (text.equalsIgnoreCase("aws-scaledown")) {
      bashScript = "aws-ecs-scaledown.sh " + channelId;
    } else if (text.equalsIgnoreCase("aws-scaleup")) {
      bashScript = "aws-ecs-scaleup.sh " + channelId;
    } else {
      bashScript = "no-configured-command";
    }
    new ProcessBuilder("bash", "-c", bashScript)
        .start();
    return output;
  }
}
