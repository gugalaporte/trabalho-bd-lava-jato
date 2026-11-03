USE lava_jato;

-- =========================================================
-- ETAPA 04 - SQL DOS INDICES
-- Execute depois de create_tables.sql e insert_data.sql.
-- Os CREATE INDEX devem ser executados apenas uma vez.
-- =========================================================

-- Indice 01
-- Justificativa:
-- Acelera filtros por status (e ordenacao/periodo por data) em atendimento.
-- Usado na View 01 (WHERE status = 'finalizado') e na subconsulta da
-- Consulta 04 (contagem de atendimentos finalizados por servico).
CREATE INDEX idx_atendimento_status_data
ON atendimento (status, data);

-- Indice 02
-- Justificativa:
-- Acelera filtros e ordenacao por nota, alem do join com cliente.
-- Usado na Consulta 03 (nota > media), na View 02 (nota >= media)
-- e no relacionamento avaliacao -> cliente.
CREATE INDEX idx_avaliacao_nota_cliente
ON avaliacao (nota, id_cliente);
