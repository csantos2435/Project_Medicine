import Header from "../header/Header";
import Sidebar from "../sidebar/Sidebar";

import { useLocation } from 'react-router-dom';
import { useState } from "react";

import api from '../../../services/api';

import styles from './NovoDiagnostico.module.css';

function NovoDiagnostico() {
    const location = useLocation();
    const { nome, imagem } = location.state || { 
        nome: "Usuário", 
        imagem: "https://img.freepik.com/vetores-premium/ilustracao-plana-vetorial-em-escala-de-cinza-avatar-perfil-de-usuario-pessoa-icone-imagem-de-perfil-perfil-de-negocio-de-uma-mulher-adequado-para-perfis-de-midia-social-icones-protetores-de-tela-e-como-um-modelox9_719432-1351.jpg?ga=GA1.1.1974532293.1682703455&semt=ais_hybrid"
    };

    const sintomas = [
        "Coceira", "Erupção Cutânea", "Erupções Cutâneas Nodais", "Espirros Contínuos", "Tremores", 
        "Calafrios", "Dor nas Articulações", "Dor de Estômago", "Acidez", "Úlceras na Língua", 
        "Perda de Massa Muscular", "Vômito", "Queimação ao Urinar", "Manchas ao Urinar", "Fadiga", 
        "Ganho de Peso", "Ansiedade", "Mãos e Pés Frios", "Mudanças de Humor", "Perda de Peso", 
        "Inquietação", "Letargia", "Manchas na Garganta", "Nível Irregular de Açúcar", "Tosse", 
        "Febre Alta", "Olhos Fundos", "Falta de Ar", "Suor", "Desidratação", "Indigestão", "Dor de Cabeça", 
        "Pele Amarelada", "Urina Escura", "Náusea", "Perda de Apetite", "Dor Atrás dos Olhos", "Dor nas Costas", 
        "Constipação", "Dor Abdominal", "Diarreia", "Febre Leve", "Urina Amarela", "Amarelamento dos Olhos", 
        "Insuficiência Hepática Aguda", "Sobrecarga de Fluidos", "Inchaço do Estômago", "Linfonodos Inchados", 
        "Mal-estar", "Visão Turva e Distorcida", "Catarro", "Irritação na Garganta", "Vermelhidão dos Olhos", 
        "Pressão Sinusal", "Coriza", "Congestão", "Dor no Peito", "Fraqueza nos Membros", 
        "Frequência Cardíaca Acelerada", "Dor Durante as Evacuações", "Dor na Região Anal", "Fezes com Sangue", 
        "Irritação no Ânus", "Dor no Pescoço", "Tontura", "Cólicas", "Hematomas", "Obesidade", "Pernas Inchadas", 
        "Vasos Sanguíneos Inchados", "Rosto e Olhos Inchados", "Tireoide Aumentada", "Unhas Quebradiças", 
        "Extremidades Inchadas", "Fome Excessiva", "Contatos Extraconjugais", "Lábios Ressecados e Formigantes", 
        "Fala Arrastada", "Dor no Joelho", "Dor na Articulação do Quadril", "Fraqueza Muscular", "Pescoço Rígido", 
        "Articulações Inchadas", "Rigidez de Movimento", "Movimentos Giratórios", "Perda de Equilíbrio", "Instabilidade", 
        "Fraqueza de um Lado do Corpo", "Perda do Olfato", "Desconforto na Bexiga", "Cheiro Fétido de Urina", 
        "Sensação Contínua de Urina", "Passagem de Gases", "Coceira Interna", "Aparência Tóxica (Tifo)", "Depressão", 
        "Irritabilidade", "Dor Muscular", "Sensório Alterado", "Manchas Vermelhas pelo Corpo", "Dor na Barriga", 
        "Menstruação Anormal", "Manchas Discromicas", "Olhos Lacrimejantes", "Aumento do Apetite", "Poliúria", 
        "Histórico Familiar", "Escarro Mucoide", "Escarro Enferrujado", "Falta de Concentração", "Distúrbios Visuais", 
        "Recebendo Transfusão de Sangue", "Recebendo Injeções Não Esterilizadas", "Coma", "Sangramento Estomacal", 
        "Distensão do Abdômen", "Histórico de Consumo de Álcool", "Sangue no Escarro", "Veias Proeminentes na Panturrilha", 
        "Palpitações", "Caminhada Dolorosa", "Espinhas Cheias de Pus", "Cravos", "Escorrimento", "Descamação da Pele", 
        "Poeira Prateada", "Pequenos Amassados nas Unhas", "Unhas Inflamatórias", "Bolha", 
        "Ferida Vermelha ao Redor do Nariz", "Exsudação de Crosta Amarela", "Prognóstico",
    ];

    const [formData, setFormData] = useState({
        nomePaciente: "",
        cpf: "",
        dataHora: "",
        sintomas: {},
    });

    const formatarCPF = (cpf) => {
        cpf = cpf.replace(/\D/g, ''); // Remove tudo o que não for número
        if (cpf.length <= 3) {
            return cpf;
        } else if (cpf.length <= 6) {
            return cpf.replace(/(\d{3})(\d{1,})/, '$1.$2');
        } else if (cpf.length <= 9) {
            return cpf.replace(/(\d{3})(\d{3})(\d{1,})/, '$1.$2.$3');
        } else {
            return cpf.replace(/(\d{3})(\d{3})(\d{3})(\d{1,})/, '$1.$2.$3-$4');
        }
    };

    const handleInputChange = (e) => {
        const { name, type, checked, value } = e.target;
    
        if (name === "cpf") {
            let cpfLimpo = value.replace(/\D/g, '').slice(0, 11); 
            const cpfFormatado = formatarCPF(cpfLimpo);
            setFormData({ ...formData, [name]: cpfFormatado });
        } else if (type === 'checkbox') {
            setFormData((prev) => {
                const newSintomas = { ...prev.sintomas };
    
                if (checked) {
                    newSintomas[name] = true;
                } else {
                    newSintomas[name] = false;
                }
    
                sintomas.forEach(sintoma => {
                    if (!(sintoma in newSintomas)) {
                        newSintomas[sintoma] = false;
                    }
                });
    
                return {
                    ...prev,
                    sintomas: newSintomas,
                };
            });
        } else {
            setFormData({ ...formData, [name]: value });
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
    
        if (!formData.nomePaciente || !formData.cpf || !formData.dataHora || Object.keys(formData.sintomas).length === 0) {
            alert("Por favor, preencha todos os campos.");
            return;
        }
    
        const sintomasProcessados = Object.entries(formData.sintomas).reduce((acc, [key, value]) => {
            acc[key] = value ? 1 : 0;
            return acc;
        }, {});
    
        const dadosParaEnviar = {
            ...formData,
            sintomas: sintomasProcessados,
        };
    
        try {
            const response = await api.post("/diagnosticos", dadosParaEnviar);
            alert("Diagnóstico criado com sucesso!");
            console.log("Resposta da API:", response.data);
    
            setFormData({
                nomePaciente: "",
                cpf: "",
                dataHora: "",
                sintomas: {},
            });
    
        } catch (error) {
            console.error("Erro ao criar diagnóstico:", error);
            alert("Ocorreu um erro ao criar o diagnóstico.");
        }
    };

    return (
        <>
            <div className={styles.wrapper}>
                <Sidebar nome={nome} imagem={imagem} />
                <div className={styles.main}>
                    <Header title="Novo Diagnóstico" />

                    <form onSubmit={handleSubmit}>
                        <div className={styles.dados_pessoais}>
                            <p>Dados Pessoais</p>
                            <input
                                type="text"
                                name="nomePaciente"
                                value={formData.nomePaciente}
                                onChange={handleInputChange}
                                placeholder="Nome"
                                className={styles.input}
                                required
                            />
                            <div className={styles.cpf_data}>
                                <input
                                    type="text"
                                    name="cpf"
                                    value={formData.cpf}
                                    onChange={handleInputChange}
                                    placeholder="CPF"
                                    className={styles.input}
                                    required
                                />
                                <input
                                    type="date"
                                    name="dataHora"
                                    value={formData.dataHora}
                                    onChange={handleInputChange}
                                    className={styles.input}
                                    required
                                />
                            </div>

                            <p>Sintomas</p>
                        </div>

                        <div className={styles.sintomas}>
                            {sintomas.map((sintoma, index) => (
                                <div key={index}>
                                    <input
                                        type="checkbox"
                                        id={sintoma}
                                        name={sintoma}
                                        checked={formData.sintomas[sintoma] || false}
                                        onChange={handleInputChange}
                                    />
                                    <label htmlFor={sintoma}>{sintoma}</label>
                                </div>
                            ))}
                        </div>

                        <button type="submit" className={styles.button}>Cadastrar Diagnóstico</button>
                    </form>
                </div>
            </div>
        </>
    );
}

export default NovoDiagnostico;
