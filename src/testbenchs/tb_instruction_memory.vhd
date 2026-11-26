library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_instruction_memory is
end entity;

architecture sim of tb_instruction_memory is
    -- Sinais para conectar na Memória de Instruções
    signal pc_tb    : std_logic_vector(31 downto 0) := (others => '0');
    signal instr_tb : std_logic_vector(31 downto 0);
begin

    -- Instancia o componente que estamos testando (UUT = Unit Under Test)
    uut: entity work.instruction_memory
        port map (
            A  => pc_tb,
            RD => instr_tb
        );

    -- Processo de estímulos: muda o PC de 4 em 4 e verifica a saída
    stim_proc: process
    begin
        -- Teste 1: PC = 0 (deve ler a linha 0 do arquivo: 2008000A)
        pc_tb <= x"00000000";
        wait for 10 ns;
        assert instr_tb = x"2008000A"
            report "ERRO no PC=0!" severity error;

        -- Teste 2: PC = 4 (deve ler a linha 1 do arquivo: 20090005)
        pc_tb <= x"00000004";
        wait for 10 ns;
        assert instr_tb = x"20090005"
            report "ERRO no PC=4!" severity error;

        -- Teste 3: PC = 8 (deve ler a linha 2 do arquivo: 01095020)
        pc_tb <= x"00000008";
        wait for 10 ns;
        assert instr_tb = x"01095020"
            report "ERRO no PC=8!" severity error;

        -- Teste 4: PC = 12 / 0xC (deve ler a linha 3 do arquivo: AC0A0000)
        pc_tb <= x"0000000C";
        wait for 10 ns;
        assert instr_tb = x"AC0A0000"
            report "ERRO no PC=12!" severity error;

        -- Teste 5: PC = 16 / 0x10 (posição vazia -> deve retornar NOP: 00000000)
        pc_tb <= x"00000010";
        wait for 10 ns;
        assert instr_tb = x"00000000"
            report "ERRO no PC=16 (esperava NOP)!" severity error;

        report "SUCESSO: Todos os testes da Memoria de Instrucoes passaram!" severity note;
        wait; -- Para a simulação
    end process;

end architecture;