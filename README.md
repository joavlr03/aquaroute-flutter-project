# 🛰️ AquaRoute
### Logística Fluvial Amazônica Inteligente
**FIAP · Global Solution 2026 · Desenvolvimento Cross Platform**

> *"A Amazônia tem mais rios do que estradas — e a AquaRoute existe para garantir que cada um deles seja navegado com segurança, inteligência e dados do espaço."*

---

## 📋 Sobre o Projeto

O **AquaRoute** é um aplicativo mobile desenvolvido em Flutter que integra dados satelitais, monitoramento hidrológico e inteligência artificial para otimizar a navegação fluvial na Amazônia brasileira.

Com mais de **20.000 km de rios navegáveis** e **30 milhões de pessoas** dependendo da logística fluvial, a Amazônia opera hoje de forma quase inteiramente analógica. O AquaRoute resolve isso entregando, na palma da mão do capitão, informações em tempo real sobre condições dos rios, alertas de perigo e rotas inteligentes.

### O Problema
- **0** plataformas integradas de alerta fluvial existentes
- Dados da NASA, ESA e ANA existem, mas não chegam a quem precisa
- Navegação às cegas = acidentes evitáveis
- 3 grandes naufrágios nos últimos 3 anos por falta de informação

### A Solução
Plataforma que conecta fontes satelitais (NASA GOES, ESA Sentinel, ANA Hidroweb) a um app acessível para ribeirinhos, capitães, empresas de frota, Marinha e Defesa Civil.

---

## 🛠️ Tecnologias Utilizadas

| Tecnologia | Uso |
|---|---|
| Flutter | Framework principal (cross-platform) |
| Dart | Linguagem de programação |
| google_fonts | Tipografia (Inter) |
| flutter_animate | Animações de entrada e transições |
| Material 3 | Design system |

---

## 📁 Estrutura do Projeto

```
lib/
├── main.dart                    # Ponto de entrada, rotas da aplicação
│
├── theme/
│   └── app_theme.dart           # Paleta de cores, tipografia e tema global
│
├── models/
│   └── models.dart              # Modelos de dados: River, Alert, AquaRoute, Weather
│
├── data/
│   └── mock_data.dart           # Dados mockados: rios, alertas, rotas, previsão
│
├── widgets/
│   └── widgets.dart             # Componentes reutilizáveis: RiskBadge, AlertCard, etc.
│
└── screens/
    ├── splash_screen.dart       # Tela de splash animada
    ├── intro_screen.dart        # Onboarding com 3 slides
    ├── main_shell.dart          # Shell com NavigationBar inferior
    ├── home_screen.dart         # Dashboard principal
    ├── rivers_screen.dart       # Listagem e monitoramento de rios
    ├── alerts_screen.dart       # Central de alertas
    ├── routes_screen.dart       # Planejador de rotas fluviais
    └── weather_screen.dart      # Previsão do tempo (7 dias)
```

---

## 🗺️ Fluxo de Telas

```
┌─────────────┐
│   SPLASH    │  Logo animado + "Conectando aos satélites..."
│             │  (3 segundos, transição automática)
└──────┬──────┘
       │
       ▼
┌─────────────┐
│    INTRO    │  Slide 1: Dados do Espaço, na sua mão
│  (3 slides) │  Slide 2: Navegue com inteligência
│             │  Slide 3: Alertas antes do perigo
│             │  [Voltar] / [Avançar] / [Pular]
└──────┬──────┘
       │
       ▼
┌──────────────────────────────────────────────────────┐
│                    MAIN SHELL                        │
│         NavigationBar com 5 abas na parte inferior   │
│                                                      │
│  [ Início ][ Rios ][ Alertas ][ Rotas ][ Tempo ]     │
└───┬──────────┬─────────┬────────┬──────────┬─────────┘
    │          │         │        │          │
    ▼          ▼         ▼        ▼          ▼
┌───────┐ ┌───────┐ ┌───────┐ ┌───────┐ ┌───────┐
│ HOME  │ │ RIOS  │ │ALERTA │ │ROTAS  │ │TEMPO  │
└───────┘ └───────┘ └───────┘ └───────┘ └───────┘
```

---

## 📱 Descrição Detalhada das Telas

### 1. Splash Screen
- Logo **AquaRoute** com animação de escala e fade
- Indicador de carregamento com texto "Conectando aos satélites..."
- Redirecionamento automático para o Intro após 3 segundos
  
### Tela

<img width="567" height="1018" alt="Tela Splash (Simulação dde conexão com satélite)" src="https://github.com/user-attachments/assets/df39f2c5-b1c8-4c2c-afbc-106184bfa3f9" />

---



### 2. Intro Screen (Onboarding)
Apresenta o app em **3 slides** com navegação por botões e indicador de progresso (dots):

| Slide | Ícone | Título | Conteúdo |
|---|---|---|---|
| 1 | 🛰️ | Dados do Espaço, na sua mão | Integração com NASA, ESA e ANA |
| 2 | 🗺️ | Navegue com inteligência | Rotas otimizadas por IA |
| 3 | 🔔 | Alertas antes do perigo | Notificações de risco em tempo real |

- Botão **Avançar** / **Começar** (último slide)
- Botão **Voltar** (slides 2 e 3)
- Botão **Pular** (acesso direto ao app)

### Tela
<img width="558" height="1016" alt="Tela 1 de Introdução" src="https://github.com/user-attachments/assets/85ff51b9-fae4-4c34-890f-444dee873256" />
<img width="576" height="1032" alt="Tela 2 de Introdução" src="https://github.com/user-attachments/assets/872bdb3b-d18f-449a-baf9-a87c1b49139c" />
<img width="564" height="1016" alt="Tela 3 de introdução" src="https://github.com/user-attachments/assets/9f5b5b1a-22a7-4985-9d5f-703fbe30be26" />


---

### 3. Home (Dashboard)
Visão geral do sistema em tempo real:

- **Cabeçalho** com saudação e ícone de satélite
- **Cards de estatísticas**: Rios monitorados, Alertas ativos, Trechos seguros, Dias de previsão
- **CTA de Rota**: atalho rápido para o planejador
- **Alertas recentes**: 3 alertas mais recentes com severidade
- **Rios Amazônicos**: listagem prévia dos principais rios

### Tela

<img width="560" height="1032" alt="Tela Inicial" src="https://github.com/user-attachments/assets/929dbcfe-a531-46a1-8926-a0e5510c9f70" />

---

### 4. Rios
Monitoramento detalhado de cada rio:

- **Filtro por risco**: TODOS / BAIXA / MÉDIA / ALTA / CRÍTICA
- **Card expandido** para cada rio com:
  - Barra lateral colorida por nível de risco
  - Nível atual (metros), temperatura e status
  - Chips de dados: nível, temperatura, risco
  - Barra de progresso do nível (% do máximo)
  - Botão de **favoritar** (estrela)

### Tela

<img width="574" height="1025" alt="Tela de rios" src="https://github.com/user-attachments/assets/fa39ae91-2900-463b-895b-6d691ee7357e" />

---

### 5. Alertas
Central de alertas com filtragem por severidade:

- **Badge** com total de alertas ativos
- **Filtro**: TODOS / BAIXA / MÉDIA / ALTA / CRÍTICA
- **Card de alerta** com:
  - Ícone por tipo (tempestade, nível, trecho, corrente)
  - Título, descrição e nome do rio
  - Tempo decorrido ("Há 15min", "Há 2h")
  - Badge de severidade colorido

### Tela

<img width="576" height="1031" alt="Tela de Alertas" src="https://github.com/user-attachments/assets/d6340ef2-c305-4251-b3b3-91dae90d8a7d" />

---

### 6. Rotas ⭐
Planejador de rotas fluviais inteligente (funcionalidade principal):

**Etapa 1 — Seleção:**
- Dropdown de **Origem** (15 cidades/portos amazônicos)
- Dropdown de **Destino**
- Botão **Calcular Rotas** (ativo apenas quando ambos selecionados)
- Animação de loading "Consultando dados satelitais..."

**Etapa 2 — Resultados:**
O app retorna **3 opções de rota**, cada uma com foco diferente:

| Rota | Foco | Cor |
|---|---|---|
| ⚡ Mais Rápida | Menor tempo de viagem | Azul |
| 🛡️ Mais Segura | Sem alertas, risco mínimo | Verde |
| 🌿 Mais Econômica | Menor consumo de combustível | Âmbar |

**Cada card de rota exibe:**
- Distância (km), Duração, Custo de combustível, Nível de risco
- **Expansão com detalhes:**
  - Descrição da rota
  - Rio principal percorrido
  - Alertas ativos no trecho
  - Waypoints com tipo (Porto, Posto de Combustível, Comunidade)
  - Botão **"Usar esta rota"**

### Tela

<img width="569" height="1021" alt="Escolha de rotas" src="https://github.com/user-attachments/assets/d3a19f79-6a8e-4d27-89ed-376e46387dcc" />


<img width="560" height="710" alt="Rota detalhes" src="https://github.com/user-attachments/assets/f81eaf46-50c3-44f8-8b4d-4e85a2dd4c41" />

---

### 7. Tempo
Previsão meteorológica para navegação:

- **Card hero** do dia selecionado com emoji, condição, temperatura máx/min e precipitação
- **Seletor horizontal** dos próximos 7 dias
- **Recomendação automática de navegação** baseada na precipitação:
  - ✅ Verde: condições favoráveis
  - 🔶 Âmbar: chuvas moderadas, cautela
  - ⚠️ Vermelho: precipitação intensa, evitar navegação

### Tela

<img width="573" height="1025" alt="Previsão do tempo" src="https://github.com/user-attachments/assets/7c14e5fe-c045-47ce-a321-0bfeb77f32ac" />

---

## 🎨 Identidade Visual

| Token | Cor | Uso |
|---|---|---|
| Deep Navy | `#0A1628` | Background principal |
| Navy Blue | `#0D2137` | Cards e superfícies |
| Aqua Green | `#2EC4A0` | Cor primária, CTAs |
| River Blue | `#1A6B8A` | Secundária, rota rápida |
| Safe Green | `#27AE60` | Risco baixo, rota segura |
| Warning Amber | `#F39C12` | Risco médio, rota econômica |
| Danger Red | `#E74C3C` | Risco alto |
| Critical Red | `#C0392B` | Risco crítico |

---

## ▶️ Como Executar

**Pré-requisitos:** Flutter SDK instalado, Modo Desenvolvedor ativo (Windows)

```bash
# 1. Clone ou extraia o projeto
cd aquaroute

# 2. Instale as dependências
flutter pub get

# 3. Execute
flutter run
```

---

## 👥 Equipe

| Nome | RM |
|---|---|
| João Victor Oliveira Avellar | RM550283 |
| Nicole Alves Nogueira | RM555182 |

**Curso:** Sistemas de Informação — FIAP  
**Turma:** 3SIR · Fevereiro 2026
