npm install -g @anthropic-ai/claude-code
git clone https://github.com/Fe-ctrl/deepseek-mcp ~/deepseek-mcp
claude mcp add --scope user deepseek -- python3 ~/deepseek-mcp/server.py
mkdir -p ~/.claude/agents && cp ~/deepseek-mcp/examples/deepseek-worker.md ~/.claude/agents/
mkdir -p ~/.claude && cat > ~/.claude/CLAUDE.md <<'EOF'
## Implementação com DeepSeek (Subagente)

- **Privacidade e Autorização:** Só delegue tarefas para a DeepSeek em projetos e repositórios com autorização explícita para envio de código a APIs de terceiros. Nunca envie trechos que contenham credenciais, variáveis de ambiente ou dados sensíveis.

- **Padrão de Delegação e Exceções:**
  - **Padrão:** Use o subagente `deepseek-worker` para implementações substanciais, criação de novas classes/módulos, testes unitários completos e refatorações densas.
  - **Exceções (execução direta):** Ajustes cirúrgicos (alterações de 1 a 3 linhas, renomeação de variáveis, correção de imports, typos ou snippets rápidos) devem ser feitos diretamente pelo orquestrador.

- **Divisão de responsabilidades:**
  - **Claude (orquestrador):** Planeja a arquitetura, extrai o contexto mínimo necessário (interfaces/tipos), formula o prompt, revisa o retorno e executa testes/compilação.
  - **deepseek-worker (executor):** Gera o código bruto via tool MCP.

- **Escopo e permissões:**
  - O subagente só deve ler e alterar os arquivos designados na tarefa.
  - É proibido realizar operações Git (`commit`, `push`, checkout de branch) ou alterar arquivos de configuração como `.gitignore`, `package.json` ou `pom.xml`, a menos que isso seja explicitamente solicitado.

- **Tratamento de falhas e limite de loop:**
  - Se a API retornar erro de conexão ou saldo insuficiente, aborte imediatamente, informe o usuário e não invente o código por conta própria.
  - Para erros de sintaxe ou compilação, o subagente tem no máximo 2 tentativas de correção. Persistindo a falha, o orquestrador interrompe o ciclo, registra o erro detalhado e aguarda orientação do usuário.
EOF
cat ~/.claude/CLAUDE.md | head -5</parameter>
EOF
