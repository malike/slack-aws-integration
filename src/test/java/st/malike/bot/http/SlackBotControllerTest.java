package st.malike.bot.http;

import static com.jayway.restassured.module.mockmvc.RestAssuredMockMvc.given;

import com.jayway.restassured.module.mockmvc.RestAssuredMockMvc;
import java.util.HashMap;
import java.util.Map;
import org.apache.http.HttpStatus;
import org.hamcrest.Matchers;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.IntegrationTest;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import st.malike.bot.SlackBotApplication;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = SlackBotApplication.class)
@WebAppConfiguration
@IntegrationTest
public class SlackBotControllerTest {

  Map ping = null;
  @Autowired
  private SlackBotController slackBotController;

  @Before
  public void setUp() {

    ping = new HashMap<>();

    RestAssuredMockMvc.standaloneSetup(slackBotController);
  }

  @After
  public void tearDown() {

  }


  @Test
  public void testPing() {
    given()
        .log()
        .all().contentType("application/x-www-form-urlencoded")
        .when()
        .post("/slack-bot?token=gIkuvaNzQIHg97ATvDxqgjtO"
            + "&team_id=T0001"
            + "&team_domain=example"
            + "&enterprise_id=E0001"
            + "&enterprise_name=Globular%20Construct%20Inc"
            + "&channel_id=C2147483705"
            + "&channel_name=test"
            + "&user_id=U2147483697"
            + "&user_name=Steve"
            + "&command=/ping"
            + "&text=URL"
            + "&response_url=https://hooks.slack.com/commands/1234/5678"
            + "&trigger_id=13345224609.738474920.8088930838d88f008e0")
        .then()
        .statusCode(HttpStatus.SC_OK);
  }


}
