library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- synthesis translate_off
use std.textio.all;
use ieee.std_logic_textio.all;
-- synthesis translate_on

entity data_memory is
    port (
        CLK : in  std_logic;                     -- Clock do sistema
        WE  : in  std_logic;                     -- Write Enable (recebe MemWrite da Controladora)
        A   : in  std_logic_vector(31 downto 0); -- Endereço vindo do ALUResult
        WD  : in  std_logic_vector(31 downto 0); -- Dado a ser escrito (vem do RD2 do Banco)
        RD  : out std_logic_vector(31 downto 0)  -- Dado lido da memória (vai para o Mux MemtoReg)
    );
end entity;

architecture rtl of data_memory is
    -- Tabela de 64 palavras de 32 bits
    type ram_type is array (0 to 63) of std_logic_vector(31 downto 0);
    signal ram : ram_type := (others => (others => '0'));

    -- synthesis translate_off
    -- Cria (ou sobrescreve) o arquivo de saída automaticamente ao iniciar a simulação
    file arq_saida : text open write_mode is "saida_memoria.txt";
    -- synthesis translate_on
begin

    -- Escrita síncrona na borda de subida do clock
    process(CLK)
        -- synthesis translate_off
        variable linha : line;
        -- synthesis translate_on
    begin
        if rising_edge(CLK) then
            if WE = '1' then
                -- Escrita normal na RAM (vai para a FPGA)
                ram(to_integer(unsigned(A(7 downto 2)))) <= WD;

                -- synthesis translate_off
                -- Registra cada escrita no arquivo de saída (apenas simulação)
                write(linha, string'("Tempo: "));
                write(linha, now);
                write(linha, string'(" | End: 0x"));
                hwrite(linha, A);
                write(linha, string'(" | Dado: 0x"));
                hwrite(linha, WD);
                writeline(arq_saida, linha);
                -- synthesis translate_on
            end if;
        end if;
    end process;

    -- Leitura assíncrona (combinacional)
    RD <= ram(to_integer(unsigned(A(7 downto 2))));

end architecture;