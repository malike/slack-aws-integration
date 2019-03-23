package st.malike.bot.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import org.springframework.stereotype.Service;

@Service
public class ShellScriptExecutor {

  public String executeShell(String text, String channelId) throws IOException {
    String output = "";
    String bashScript = text;
    Process processBuilder = new ProcessBuilder("bash", "-c", bashScript)
        .start();
    BufferedReader reader =
        new BufferedReader(new InputStreamReader(processBuilder.getInputStream()));

    String line;
    while ((line = reader.readLine()) != null) {
      output += line + "\n";
    }
    return output;
  }

}
