package st.malike.bot;

import io.github.cdimascio.dotenv.Dotenv;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.client.RestTemplate;

@SpringBootApplication
public class SlackBotApplication {

  public static Map<String,String> URLS = new HashMap<>();

  public static void main(String[] args) throws Exception{
    loadConfig();
    System.getProperties().entrySet();
    System.getenv().forEach((k, v) -> {
     if(k.startsWith("PING_")){
       URLS.put(k.replaceFirst("PING_",""),v);
     }
    });
    SpringApplication.run(SlackBotApplication.class, args);
  }

  public static void loadConfig() throws Exception{
    Properties prop = new Properties();
    String fileName = "config.env";
    InputStream is = null;
    try {
      is = new FileInputStream(fileName);
    } catch (FileNotFoundException ex) {

    }
    try {
      prop.load(is);
    } catch (IOException ex) {

    }
  }
  @Bean
  public RestTemplate restTemplate() {
    return new RestTemplate();
  }

}
