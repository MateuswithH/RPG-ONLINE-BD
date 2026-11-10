/* Projeto: Jogo de RPG Online */

-- 1. Criacao do banco de dados (somente se ainda nao existir)
IF DB_ID('RPG_Online') IS NULL
BEGIN
    CREATE DATABASE RPG_Online;
END
GO

-- 2. Selecao do banco para que as tabelas sejam criadas dentro dele
USE RPG_Online;
GO

/*  3. Tabelas independentes (nao possuem chave estrangeira) */

-- Tabela USUARIOS
CREATE TABLE USUARIOS (
    UsuarioId  INT IDENTITY(1,1) NOT NULL,
    Email      VARCHAR(150)      NOT NULL,
    Senha      VARCHAR(255)      NOT NULL,  -- armazena o HASH da senha, nunca a senha pura
    CONSTRAINT PK_USUARIOS PRIMARY KEY (UsuarioId),
    CONSTRAINT UQ_USUARIOS_Email UNIQUE (Email)
);
GO

-- Tabela CLASSES
CREATE TABLE CLASSES (
    ClasseId   INT IDENTITY(1,1) NOT NULL,
    Nome       VARCHAR(50)       NOT NULL,
    Descricao  VARCHAR(255)      NULL,
    CONSTRAINT PK_CLASSES PRIMARY KEY (ClasseId),
    CONSTRAINT UQ_CLASSES_Nome UNIQUE (Nome)
);
GO

-- Tabela HABILIDADES
CREATE TABLE HABILIDADES (
    HabilidadeId  INT IDENTITY(1,1) NOT NULL,
    Nome          VARCHAR(50)       NOT NULL,
    CONSTRAINT PK_HABILIDADES PRIMARY KEY (HabilidadeId),
    CONSTRAINT UQ_HABILIDADES_Nome UNIQUE (Nome)
);
GO

/*  4. Tabelas dependentes (possuem chaves estrangeiras) */

-- Tabela PERSONAGENS
-- Relacionamentos: USUARIOS 1:N PERSONAGENS e CLASSES 1:N PERSONAGENS
CREATE TABLE PERSONAGENS (
    PersonagemId    INT IDENTITY(1,1) NOT NULL,
    NomePersonagem  VARCHAR(50)       NOT NULL,
    UsuarioId       INT               NOT NULL,
    ClasseId        INT               NOT NULL,
    CONSTRAINT PK_PERSONAGENS PRIMARY KEY (PersonagemId),
    CONSTRAINT FK_PERSONAGENS_USUARIOS FOREIGN KEY (UsuarioId)
        REFERENCES USUARIOS (UsuarioId),
    CONSTRAINT FK_PERSONAGENS_CLASSES FOREIGN KEY (ClasseId)
        REFERENCES CLASSES (ClasseId)
);
GO

-- Tabela CLASSES_HABILIDADES (tabela associativa do relacionamento N:N)
-- A chave primaria e composta pelas duas chaves estrangeiras
CREATE TABLE CLASSES_HABILIDADES (
    ClasseId      INT NOT NULL,
    HabilidadeId  INT NOT NULL,
    CONSTRAINT PK_CLASSES_HABILIDADES PRIMARY KEY (ClasseId, HabilidadeId),
    CONSTRAINT FK_CLASSES_HABILIDADES_CLASSES FOREIGN KEY (ClasseId)
        REFERENCES CLASSES (ClasseId),
    CONSTRAINT FK_CLASSES_HABILIDADES_HABILIDADES FOREIGN KEY (HabilidadeId)
        REFERENCES HABILIDADES (HabilidadeId)
);
GO
