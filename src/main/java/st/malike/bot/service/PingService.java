package st.malike.bot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class PingService {

  @Autowired
  private Environment environment;
  @Autowired
  private RestTemplate restTemplate;


  public String pingURL(String text) {
    String urlToPing = environment.getProperty("PING_" + text) == null ? environment
        .getProperty("PING_" + text.toLowerCase())
        : environment.getProperty("PING_" + text);
    HttpHeaders headers = new HttpHeaders();
    HttpEntity<?> entity = new HttpEntity<>(headers);
    HttpEntity<String> stringHttpEntity = restTemplate.exchange(
        urlToPing,
        HttpMethod.GET,
        entity,
        String.class);
    return stringHttpEntity.getBody();
  }
}
