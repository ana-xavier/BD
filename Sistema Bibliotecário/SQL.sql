/* Ana Carolina Xavier */

-- Tabelas que fazem parte de Obra
CREATE TABLE TipoDeObra (
    codigo numeric(10) NOT NULL,
    descricao varchar(255) NOT NULL,

    CONSTRAINT PK_TipoObra PRIMARY KEY(codigo)
);

CREATE TABLE Autor (
    autor_PK numeric(10) NOT NULL,
    autor varchar(80) NOT NULL,

    CONSTRAINT PK_Autor PRIMARY KEY(autor_PK)
);

-- Tabela de Obras
CREATE TABLE Obra (
    codigo numeric(10) NOT NULL,
    titulo varchar(30) NOT NULL,
    fk_autor numeric(10) NOT NULL,
    nro_paginas numeric(4) NOT NULL,
    fk_TipoObra numeric(10) NOT NULL,

    CONSTRAINT PK_obra PRIMARY KEY(codigo),
    CONSTRAINT FK_autor FOREIGN KEY (fk_autor) REFERENCES Autor (autor_PK),
    CONSTRAINT FK_TipoObra FOREIGN KEY (fk_TipoObra) REFERENCES TipoDeObra (codigo)
);

-- Herança Pessoa (para Professores e Alunos)
CREATE TABLE Pessoa (
    cpf char(11) NOT NULL,
    nome varchar(80) NOT NULL,
    email varchar(50) NOT NULL,
    telefone varchar(12),
    
    CONSTRAINT PK_Pessoa PRIMARY KEY(cpf)
);

CREATE TABLE Professor (
    data_contratacao date NOT NULL,
    nro_registro numeric(10) NOT NULL,
    fk_Pessoa_cpf char(11) NOT NULL,

    CONSTRAINT PK_Professor PRIMARY KEY(fk_Pessoa_cpf),
    CONSTRAINT FK_Professor FOREIGN KEY (fk_Pessoa_cpf) REFERENCES Pessoa (cpf)
);

CREATE TABLE Aluno (
    nro_matricula numeric(10) NOT NULL,
    nro_creditos_concluidos numeric(3) NOT NULL,
    fk_Pessoa_cpf char(11) NOT NULL,

    CONSTRAINT PK_Aluno PRIMARY KEY(fk_Pessoa_cpf),
    CONSTRAINT FK_Aluno FOREIGN KEY (fk_Pessoa_cpf) REFERENCES Pessoa (cpf)
);

-- Tabela de empréstimos; registra informações sobre o empréstimo
CREATE TABLE Emprestimo (
    fk_Pessoa_cpf char(11) NOT NULL,
    fk_Obra numeric(10) NOT NULL,
    data_emprestimo date NOT NULL,
    data_devolucao date NOT NULL,
    cod_emprestimo numeric(10) NOT NULL,
    tipo_pessoa char(1) NOT NULL,

    CONSTRAINT PK_Emprestimo PRIMARY KEY(cod_emprestimo),
    CONSTRAINT FK_Pessoa FOREIGN KEY (fk_Pessoa_cpf) REFERENCES Pessoa (cpf),
    CONSTRAINT FK_Obra FOREIGN KEY (fk_Obra) REFERENCES Obra (codigo),
    CONSTRAINT CK_TipoPessoa CHECK(tipo_pessoa IN ('P', 'A'))

);

-- Integridade dos prazos de devolução das obras em caso professor (P) ou aluno (A)
ALTER TABLE Emprestimo
ADD CONSTRAINT prazo_devolucao_valido CHECK (
  (tipo_pessoa = 'A' AND data_devolucao <= data_emprestimo + INTERVAL '7' DAY)
  OR
  (tipo_pessoa = 'P' AND data_devolucao <= data_emprestimo + INTERVAL '14' DAY)
);

-- Inserção de Dados
-- Os únicos dados reais são em relação aos dados pessoais da aluna Ana Carolina
-- Os demais dados são ficticios.

-- Tipo de Obra
INSERT INTO TipoDeObra(codigo, descricao) VALUES('786546', 'Livro');
INSERT INTO TipoDeObra(codigo, descricao) VALUES('152349', 'Artigo');
INSERT INTO TipoDeObra(codigo, descricao) VALUES('852643', 'Revista');

-- Autor
INSERT INTO Autor(autor_PK, autor) VALUES('9535', 'Joseph Murin');
INSERT INTO Autor(autor_PK, autor) VALUES('8945', 'Amelia Rose');
INSERT INTO Autor(autor_PK, autor) VALUES('1057', 'Matthew Tools');
INSERT INTO Autor(autor_PK, autor) VALUES('3475', 'Kim Jeongyeon');
INSERT INTO Autor(autor_PK, autor) VALUES('0926', 'Beatriz Santos');

-- Obra
INSERT INTO Obra(codigo, titulo, fk_autor, nro_paginas, fk_TipoObra) VALUES('342', 'Flores Desabrocham', '9535', '216', '786546');
INSERT INTO Obra(codigo, titulo, fk_autor, nro_paginas, fk_TipoObra) VALUES('789', 'História III', '8945', '98', '152349');
INSERT INTO Obra(codigo, titulo, fk_autor, nro_paginas, fk_TipoObra) VALUES('164', 'Tempestade de Aço', '1057', '34', '852643');
INSERT INTO Obra(codigo, titulo, fk_autor, nro_paginas, fk_TipoObra) VALUES('890', 'Rastro de Fogo', '3475', '76', '852643');
INSERT INTO Obra(codigo, titulo, fk_autor, nro_paginas, fk_TipoObra) VALUES('675', 'Entrelinhas do Coração', '0926', '436', '786546');

-- Pessoa
INSERT INTO Pessoa(cpf, nome, email, telefone) VALUES('60112179070', 'Ana Carolina Xavier', 'a.xavier004@edu.pucrs.br', '985681353');
INSERT INTO Pessoa(cpf, nome, email, telefone) VALUES('89567545643', 'Maria Eduarda Oliveira', 'dudu@edu.com', '987654311');
INSERT INTO Pessoa(cpf, nome, email) VALUES('09376895643', 'Carlos Eduardo Oliveira', 'kaka@edu.com');
INSERT INTO Pessoa(cpf, nome, email, telefone) VALUES('65478967856', 'Isadora Brust', 'isa@edu.com', '985679643');
INSERT INTO Pessoa(cpf, nome, email) VALUES('10968467838', 'Sofia Mendes', 'mendes998@acad.com');
INSERT INTO Pessoa(cpf, nome, email, telefone) VALUES('86754365794', 'Ricardo Silva', 'silva_ric@acad.com', '9811450923');
INSERT INTO Pessoa(cpf, nome, email, telefone) VALUES('01568398594', 'Laura Fernandes', 'fernandes@acad.com', '987095643');

-- Professor
INSERT INTO Professor(data_contratacao, nro_registro, fk_Pessoa_cpf) VALUES(TO_DATE('12/05/2012', 'DD/MM/YYYY'), '12998765', '10968467838');
INSERT INTO Professor(data_contratacao, nro_registro, fk_Pessoa_cpf) VALUES(TO_DATE('25/01/2014', 'DD/MM/YYYY'), '14004784', '86754365794');
INSERT INTO Professor(data_contratacao, nro_registro, fk_Pessoa_cpf) VALUES(TO_DATE('09/12/2017', 'DD/MM/YYYY'), '17110043', '01568398594');

-- Aluno
INSERT INTO Aluno(nro_matricula, nro_creditos_concluidos, fk_Pessoa_cpf) VALUES('22103003', '50', '60112179070');
INSERT INTO Aluno(nro_matricula, nro_creditos_concluidos, fk_Pessoa_cpf) VALUES('22111153', '38', '89567545643');
INSERT INTO Aluno(nro_matricula, nro_creditos_concluidos, fk_Pessoa_cpf) VALUES('22111154', '38', '09376895643');
INSERT INTO Aluno(nro_matricula, nro_creditos_concluidos, fk_Pessoa_cpf) VALUES('22111167', '46', '65478967856');

-- Emprestimo
INSERT INTO Emprestimo(fk_Pessoa_cpf, fk_Obra, data_emprestimo, data_devolucao, cod_emprestimo, tipo_pessoa)
                VALUES('60112179070', '890', TO_DATE('20/05/2023', 'DD/MM/YYYY'), TO_DATE('27/05/2023', 'DD/MM/YYYY'), '0765', 'A');
INSERT INTO Emprestimo(fk_Pessoa_cpf, fk_Obra, data_emprestimo, data_devolucao, cod_emprestimo, tipo_pessoa)
                VALUES('89567545643', '164', TO_DATE('12/03/2023', 'DD/MM/YYYY'), TO_DATE('19/03/2023', 'DD/MM/YYYY'), '7832', 'A');
INSERT INTO Emprestimo(fk_Pessoa_cpf, fk_Obra, data_emprestimo, data_devolucao, cod_emprestimo, tipo_pessoa)
                VALUES('09376895643', '789', TO_DATE('09/08/2022', 'DD/MM/YYYY'), TO_DATE('16/08/2022', 'DD/MM/YYYY'), '1098', 'A');
INSERT INTO Emprestimo(fk_Pessoa_cpf, fk_Obra, data_emprestimo, data_devolucao, cod_emprestimo, tipo_pessoa)
                VALUES('65478967856', '342', TO_DATE('08/01/2023', 'DD/MM/YYYY'), TO_DATE('15/01/2023', 'DD/MM/YYYY'), '9831', 'A');
INSERT INTO Emprestimo(fk_Pessoa_cpf, fk_Obra, data_emprestimo, data_devolucao, cod_emprestimo, tipo_pessoa)
                VALUES('86754365794', '675', TO_DATE('01/05/2023', 'DD/MM/YYYY'), TO_DATE('15/05/2023', 'DD/MM/YYYY'), '5673', 'P');
INSERT INTO Emprestimo(fk_Pessoa_cpf, fk_Obra, data_emprestimo, data_devolucao, cod_emprestimo, tipo_pessoa)
                VALUES('60112179070', '675', TO_DATE('06/10/2022', 'DD/MM/YYYY'), TO_DATE('13/10/2022', 'DD/MM/YYYY'), '1402', 'A');
INSERT INTO Emprestimo(fk_Pessoa_cpf, fk_Obra, data_emprestimo, data_devolucao, cod_emprestimo, tipo_pessoa)
                VALUES('01568398594', '789', TO_DATE('02/07/2022', 'DD/MM/YYYY'), TO_DATE('16/07/2022', 'DD/MM/YYYY'), '1290', 'P');
INSERT INTO Emprestimo(fk_Pessoa_cpf, fk_Obra, data_emprestimo, data_devolucao, cod_emprestimo, tipo_pessoa)
                VALUES('09376895643', '890', TO_DATE('18/12/2022', 'DD/MM/YYYY'), TO_DATE('25/12/2022', 'DD/MM/YYYY'), '7523', 'A');
INSERT INTO Emprestimo(fk_Pessoa_cpf, fk_Obra, data_emprestimo, data_devolucao, cod_emprestimo, tipo_pessoa)
                VALUES('10968467838', '164', TO_DATE('10/03/2023', 'DD/MM/YYYY'), TO_DATE('24/03/2023', 'DD/MM/YYYY'), '8518', 'P');
INSERT INTO Emprestimo(fk_Pessoa_cpf, fk_Obra, data_emprestimo, data_devolucao, cod_emprestimo, tipo_pessoa)
                VALUES('89567545643', '342', TO_DATE('14/06/2023', 'DD/MM/YYYY'), TO_DATE('21/06/2023', 'DD/MM/YYYY'), '6853', 'A');