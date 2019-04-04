package st.malike.bot.service;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.runners.MockitoJUnitRunner;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

@RunWith(MockitoJUnitRunner.class)
public class PingServiceTest {

  private final String RANDOM_URL = "RANDOM_URL";
  @InjectMocks
  private PingService pingService;
  @Mock
  private Environment environment;
  @Mock
  private RestTemplate restTemplate;
  
  @Before
  public void setUp() {
    //when
  }

  @Test
  public void testPing() {
    HttpHeaders headers = new HttpHeaders();
    HttpEntity<?> entity = new HttpEntity<>(headers);
    ResponseEntity<String> stringResponseEntity = new ResponseEntity<String>(HttpStatus.OK);
    Mockito.when(environment.getProperty("PING_" + RANDOM_URL)).thenReturn(RANDOM_URL);
    Mockito.when(restTemplate.exchange(RANDOM_URL,
        HttpMethod.GET,
        entity,
        String.class)).thenReturn(new ResponseEntity(RANDOM_URL, HttpStatus.OK));

    pingService.pingURL(RANDOM_URL);

    Mockito.verify(restTemplate, Mockito.times(1))
        .exchange(RANDOM_URL,
            HttpMethod.GET,
            entity,
            String.class);
  }


}