-- Bibliotecas padrão do VHDL
library ieee;
use ieee.std_logic_1164.all;   -- Define os tipos std_logic e std_logic_vector (bits e barramentos)
use ieee.numeric_std.all;      -- Permite conversões numéricas como unsigned() e to_integer()
use std.textio.all;            -- Permite ler arquivos de texto (.txt) linha por linha
use ieee.std_logic_textio.all; -- Adiciona a função hread() para ler valores em hexadecimal

-- Entidade: define as entradas e saídas (pinos) do bloco de Memória de Instruções
entity instruction_memory is
    port (
        A  : in  std_logic_vector(31 downto 0); -- Endereço da instrução atual vindo do PC
        RD : out std_logic_vector(31 downto 0)  -- Instrução de 32 bits (Instr) entregue ao processador
    );
end entity;

-- Arquitetura: descreve o funcionamento interno do circuito
architecture rtl of instruction_memory is

    -- Define um novo tipo de dado: um array (tabela) com 64 posições de 32 bits cada
    type rom_type is array (0 to 63) of std_logic_vector(31 downto 0);

    -- Função impura (precisa ser "impure" porque lê um arquivo externo ao código)
    -- Ela executa APENAS UMA VEZ: na compilação do Quartus ou no início da simulação
    impure function init_rom(file_name : string) return rom_type is
        -- Abre o arquivo de texto especificado em modo de leitura e o associa ao ponteiro "rom_file"
        file rom_file      : text open read_mode is file_name;
        
        -- Variável temporária que armazena uma linha de texto lida por vez
        variable text_line : line;
        
        -- Memória temporária inicializada toda com zeros (instrução NOP no MIPS)
        -- Isso evita lixo de memória nas posições que o programa não utilizar
        variable temp_mem  : rom_type := (others => (others => '0'));
        
        -- Índice contador para saber em qual posição do array (0 a 63) gravar cada linha
        variable i         : integer := 0;
    begin
        -- Repete enquanto o arquivo não chegar ao fim E ainda houver espaço no array
        while not endfile(rom_file) and i <= 63 loop
            readline(rom_file, text_line); -- Lê uma linha inteira do arquivo .txt
            hread(text_line, temp_mem(i)); -- Converte 8 dígitos hexadecimais (32 bits) e salva em temp_mem(i)
            i := i + 1;                    -- Avança para a próxima posição da memória
        end loop;
        
        -- Retorna o array totalmente preenchido com as instruções do arquivo
        return temp_mem;
    end function;

    -- Cria a memória ROM de fato como uma constante, preenchida pelo retorno da função acima.
    -- O arquivo "instrucoes.txt" deve estar na mesma pasta do projeto no Quartus/simulador.
    constant rom : rom_type := init_rom("instrucoes.txt");

begin
    RD <= rom(to_integer(unsigned(A(7 downto 2))));

end architecture;