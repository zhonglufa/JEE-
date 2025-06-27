
import com.example.sims.controller.AuthController;
import com.example.sims.pojo.User;
import com.example.sims.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.junit.Before;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.ui.Model;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.assertEquals;

class AuthControllerTest {

    @Mock
    private UserService userService;

    @Mock
    private HttpSession session;

    @Mock
    private Model model;

    @InjectMocks
    private AuthController authController;

    // 初始化 Mockito 注解
    @Before
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testLoginSuccess() {
        // 模拟用户存在
        User mockUser = new User();
        when(userService.authenticate(anyString(), anyString())).thenReturn(mockUser);

        // 调用登录方法
        String result = authController.login("test", "password", session, model);

        // 验证结果
        assertEquals("redirect:/dashboard", result);
        verify(session).setAttribute("currentUser", mockUser);
    }

    @Test
    void testLoginFailure() {
        // 模拟用户不存在
        when(userService.authenticate(anyString(), anyString())).thenReturn(null);

        // 调用登录方法
        String result = authController.login("test", "wrong", session, model);

        // 验证结果
        assertEquals("login", result);
        verify(model).addAttribute("error", "用户名或密码错误");
    }

    @Test
    void testRegisterSuccess() {
        // 模拟服务层方法
        when(userService.usernameExists(anyString())).thenReturn(false);
        when(userService.emailExists(anyString())).thenReturn(false);

        // 调用注册方法
        String result = authController.register(
                "newuser",
                "new@example.com",
                "password",
                "password",
                "New User",
                model
        );

        // 验证结果
        assertEquals("login", result);
        verify(model).addAttribute("registerSuccess", "注册成功，请登录");
        verify(userService).registerUser(anyString(), anyString(), anyString(), anyString());
    }

    @Test
    void testRegisterPasswordMismatch() {
        // 调用注册方法（密码不一致）
        String result = authController.register(
                "newuser",
                "1836553412@qq.com",
                "password1",
                "password2",
                "New User",
                model
        );

        // 验证结果
        assertEquals("login", result);
        verify(model).addAttribute("registerError", "两次输入的密码不一致");
        verify(userService, never()).registerUser(any(), any(), any(), any());
    }

    @Test
    void testRegisterUsernameExists() {
        // 模拟用户名已存在
        when(userService.usernameExists(anyString())).thenReturn(true);

        // 调用注册方法
        String result = authController.register(
                "existing",
                "new@example.com",
                "password",
                "password",
                "New User",
                model
        );

        // 验证结果
        assertEquals("login", result);
        verify(model).addAttribute("registerError", "用户名已存在");
        verify(userService, never()).registerUser(any(), any(), any(), any());
    }

    @Test
    void testLogout() {
        // 调用登出方法
        String result = authController.logout(session);

        // 验证结果
        assertEquals("redirect:/login", result);
        verify(session).invalidate();
    }
}