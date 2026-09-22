package com.lavajato.lavajato.controller;

import com.lavajato.lavajato.repository.RelatorioRepository;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * Endpoints da Etapa 03: 4 consultas SQL + dashboard estatistico.
 */
@RestController
@RequestMapping("/relatorios")
@CrossOrigin("*")
public class RelatorioController {

    private final RelatorioRepository relatorioRepository;

    public RelatorioController(RelatorioRepository relatorioRepository) {
        this.relatorioRepository = relatorioRepository;
    }

    @GetMapping("/consulta-faturamento")
    public Object servicosComFaturamentoMinimo(
            @RequestParam(defaultValue = "60") BigDecimal minimo) {
        return relatorioRepository.servicosComFaturamentoMinimo(minimo);
    }

    @GetMapping("/consulta-atendimentos-periodo")
    public Object atendimentosFinalizadosPorPeriodo(
            @RequestParam(defaultValue = "2026-04-10")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate inicio,
            @RequestParam(defaultValue = "2026-04-20")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fim) {
        return relatorioRepository.atendimentosFinalizadosPorPeriodo(inicio, fim);
    }

    @GetMapping("/consulta-atendimentos-sem-pagamento")
    public Object atendimentosSemPagamento() {
        return relatorioRepository.atendimentosSemPagamento();
    }

    @GetMapping("/consulta-clientes-acima-media")
    public Object clientesComAvaliacaoAcimaDaMedia() {
        return relatorioRepository.clientesComAvaliacaoAcimaDaMedia();
    }

    @GetMapping("/dashboard")
    public Object indicadoresDashboard() {
        return relatorioRepository.indicadoresDashboard();
    }

    @GetMapping("/opcoes-veiculos")
    public Object veiculosParaAtendimento() {
        return relatorioRepository.veiculosParaAtendimento();
    }

    @GetMapping("/dashboard-resumo")
    public Object resumoDashboard(
            @RequestParam(defaultValue = "2026-04-01")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate inicio,
            @RequestParam(defaultValue = "2026-04-30")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fim) {
        return relatorioRepository.resumoDashboard(inicio, fim);
    }

    @GetMapping("/dashboard-faturamento-servico")
    public Object faturamentoPorServico(
            @RequestParam(defaultValue = "2026-04-01")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate inicio,
            @RequestParam(defaultValue = "2026-04-30")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fim,
            @RequestParam(defaultValue = "10") Integer limite) {
        return relatorioRepository.faturamentoPorServico(inicio, fim, limite);
    }

    @GetMapping("/dashboard-status-atendimento")
    public Object atendimentosPorStatus(
            @RequestParam(defaultValue = "2026-04-01")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate inicio,
            @RequestParam(defaultValue = "2026-04-30")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fim) {
        return relatorioRepository.atendimentosPorStatus(inicio, fim);
    }

    @GetMapping("/dashboard-tendencia")
    public Object tendenciaTemporal(
            @RequestParam(defaultValue = "2026-04-01")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate inicio,
            @RequestParam(defaultValue = "2026-04-30")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fim,
            @RequestParam(defaultValue = "dia") String granularidade) {
        return relatorioRepository.tendenciaTemporal(inicio, fim, granularidade);
    }

    @GetMapping("/dashboard-distribuicao-notas")
    public Object distribuicaoNotas(
            @RequestParam(defaultValue = "2026-04-01")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate inicio,
            @RequestParam(defaultValue = "2026-04-30")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fim) {
        return relatorioRepository.distribuicaoNotas(inicio, fim);
    }

    @GetMapping("/dashboard-formas-pagamento")
    public Object formasPagamento(
            @RequestParam(defaultValue = "2026-04-01")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate inicio,
            @RequestParam(defaultValue = "2026-04-30")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fim) {
        return relatorioRepository.formasPagamento(inicio, fim);
    }

    @GetMapping("/dashboard-top-clientes")
    public Object topClientes(
            @RequestParam(defaultValue = "2026-04-01")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate inicio,
            @RequestParam(defaultValue = "2026-04-30")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fim,
            @RequestParam(defaultValue = "10") Integer limite) {
        return relatorioRepository.topClientes(inicio, fim, limite);
    }
}
