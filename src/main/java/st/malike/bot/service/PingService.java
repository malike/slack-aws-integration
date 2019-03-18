package st.malike.bot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class PingService {

  @Autowired
  private RestTemplate restTemplate;

  public String getPing() {
    return "";
  }

}
