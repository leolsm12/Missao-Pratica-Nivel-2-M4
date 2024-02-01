package com.example.lugares.Lugares.controller;

import com.example.lugares.Lugares.model.Lugares;
import com.example.lugares.Lugares.repository.LugaresRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/lugares")
public class LugarController {

    @Autowired
    private LugaresRepository repository;


    @PostMapping("/post")
    public void postLugares(@RequestBody Lugares lugares) {
        repository.save(lugares);
    }

    @GetMapping
    public ResponseEntity<List<Lugares>> obterTodosLugares() {
        List<Lugares> lugares = repository.findAll();
        if (!lugares.isEmpty()) {
            return new ResponseEntity<>(lugares, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        }
    }
    @PutMapping("/{id}")
    public ResponseEntity<Lugares> editarlugares(@PathVariable Integer id, @RequestBody Lugares lugarAtualizado) {
        Optional<Lugares> lugarOptional = repository.findById(id);

        if (lugarOptional.isPresent()){
            Lugares lugarExistente = lugarOptional.get();

            lugarExistente.setEstrelas(lugarAtualizado.getEstrelas());

            //lugarExistente.setPreco(lugarAtualizado.getPreco());

            Lugares lugarAtualizadoSalvo = repository.save(lugarExistente);
            return new ResponseEntity<>(lugarAtualizadoSalvo, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

    }
}