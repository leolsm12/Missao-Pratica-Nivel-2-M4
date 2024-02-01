package com.example.lugares.Lugares.repository;


import com.example.lugares.Lugares.model.Lugares;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LugaresRepository  extends JpaRepository<Lugares, Integer>{

}
