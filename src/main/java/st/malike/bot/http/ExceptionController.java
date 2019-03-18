package st.malike.bot.http;

import java.text.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import st.malike.bot.exception.NotFoundException;
import st.malike.bot.util.JSONResponse;

@Controller
@ControllerAdvice
public class ExceptionController {

  @ExceptionHandler(value = NotFoundException.class)
  @ResponseBody
  public JSONResponse notFoundException(NotFoundException e) {
    JSONResponse jsonResponse = new JSONResponse();
    jsonResponse.setCount(0);
    jsonResponse.setMessage("Data not Found");
    jsonResponse.setStatus(false);
    jsonResponse.setResult(e.getLocalizedMessage());
    return jsonResponse;
  }


  @ExceptionHandler(value = ParseException.class)
  @ResponseBody
  public JSONResponse parseException(ParseException e) {
    JSONResponse jsonResponse = new JSONResponse();
    jsonResponse.setCount(0);
    jsonResponse.setMessage("Parameter not parsable");
    jsonResponse.setStatus(false);
    jsonResponse.setResult(e.getLocalizedMessage());
    return jsonResponse;
  }

}