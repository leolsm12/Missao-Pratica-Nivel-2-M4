package com.example.lugares.Lugares.model;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "lugares")
public class Lugares {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    @Basic(optional = false)
    @Column(name = "nome")
    private String nome;
    @Column(name = "localizacao")
    private String localizacao;
    @Column(name = "telefone")
    private String telefone;
    @Column(name = "estrelas")
    private Integer estrelas;
    @Column(name = "descricao")
    private String descricao;
    @Column(name = "pacote1")
    private String pacote1;
    @Column(name = "pacote2")
    private String pacote2;
    @Column(name = "pacote3")
    private String pacote3;
    @Column(name = "preco")
    private Integer preco;
    @Column(name = "pacote1preco")
    private String pacote1preco;
    @Column(name = "pacote2preco")
    private String pacote2preco;
    @Column(name = "pacote3preco")
    private String pacote3preco;
    @Column(name = "foto")
    private String foto;
    @Column(name = "foto1")
    private String foto1;
    @Column(name = "foto2")
    private String foto2;
}