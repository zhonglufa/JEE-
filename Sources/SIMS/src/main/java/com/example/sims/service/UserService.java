package com.example.sims.service;

import com.example.sims.dao.UserDao;
import com.example.sims.pojo.User;

public interface UserService {


    public User authenticate(String username, String password) ;

    public void registerUser(String username, String email, String password, String realName) ;

    public boolean usernameExists(String username) ;

    boolean emailExists(String email);
}
