# Etapa 03 — Interface funcional com dashboard (1ª versão)

Versão enxuta do Sistema Lava Jato para entrega/apresentação da **Etapa 03**.
O projeto completo (etapas 04, 05 e 06) continua na raiz do repositório.

## O que esta pasta entrega

1. **Aplicação web** (`interface/`) — Spring Boot + JDBC + MySQL
2. **SQL das consultas** (`sql/consultas.sql`) — 4 consultas (todas com JOIN)

## Requisitos cobertos

- CRUD (inserção/alteração/exclusão) e visualização em várias tabelas
- Dashboard com gráficos (estatística)
- Visualização dos resultados das 4 consultas na interface
- SQL explícito via `JdbcTemplate` (sem ORM)

## Estrutura

```text
etapa03/
|- modelo/          mini-mundo, esquemas e dicionário
|- sql/
|  |- create_tables.sql
|  |- insert_data.sql
|  |- consultas.sql      ← entregável 2
|- interface/            ← entregável 1 (código da app)
|- readme.md
```

## Como rodar

### 1. Banco

No MySQL, execute na ordem:

```text
etapa03/sql/create_tables.sql
etapa03/sql/insert_data.sql
```

(`consultas.sql` é para inspeção/demonstração; a interface já executa as mesmas consultas.)

### 2. Senha

Ajuste `etapa03/interface/src/main/resources/application.properties`:

```properties
spring.datasource.password=SUA_SENHA
server.port=8081
```

A porta padrão desta versão é **8081**, para não conflitar com a app completa (8080).

### 3. Subir

```powershell
cd etapa03\interface
.\mvnw.cmd spring-boot:run
```

Abra: http://localhost:8081

## Abas da interface

- **Cadastros** — CRUD de clientes, serviços, veículos, funcionários, atendimentos e avaliações
- **Consultas** — as 4 consultas SQL
- **Dashboard** — indicadores e gráficos

Não inclui views, índices, funções, procedures nem triggers (etapas 04/05).
