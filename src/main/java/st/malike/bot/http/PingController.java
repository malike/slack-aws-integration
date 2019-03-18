package st.malike.bot.http;

import java.text.ParseException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import st.malike.bot.exception.MissingParameterException;
import st.malike.bot.util.JSONResponse;

@Controller
public class PingController extends ExceptionController {


  @RequestMapping(value = "/ping", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
  @ResponseBody
  public JSONResponse ping(@RequestParam(value = "token", required = false) String token,
      @RequestParam(value = "team_id") String team_id,
      @RequestParam(value = "team_domain") String team_domain,
      @RequestParam(value = "enterprise_id") String enterprise_id,
      @RequestParam(value = "enterprise_name") String enterprise_name,
      @RequestParam(value = "channel_id") String channel_id,
      @RequestParam(value = "channel_name") String channel_name,
      @RequestParam(value = "user_id") String user_id,
      @RequestParam(value = "user_name") String user_name,
      @RequestParam(value = "command") String command,
      @RequestParam(value = "text") String text,
      @RequestParam(value = "response_url") String response_url,
      @RequestParam(value = "trigger_id") String trigger_id,
      HttpServletResponse response,
      HttpServletRequest request) throws MissingParameterException, ParseException {
    JSONResponse jSONResponse = new JSONResponse();
    jSONResponse.setStatus(true);
    jSONResponse.setMessage("SUCCESS");
    return jSONResponse;
  }


}
