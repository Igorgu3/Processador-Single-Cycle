library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
    port (
        CLK : in  std_logic;                     -- Clock do sistema
        WE3 : in  std_logic;                     -- Write Enable (recebe RegWrite da Controladora)
        A1  : in  std_logic_vector(4 downto 0);  -- Endereço do registrador 1 a ser lido (rs)
        A2  : in  std_logic_vector(4 downto 0);  -- Endereço do registrador 2 a ser lido (rt)
        A3  : in  std_logic_vector(4 downto 0);  -- Endereço do registrador onde vamos escrever (rd/rt)
        WD3 : in  std_logic_vector(31 downto 0); -- Dado de 32 bits que será escrito em A3
        RD1 : out std_logic_vector(31 downto 0); -- Dado de 32 bits lido da posição A1
        RD2 : out std_logic_vector(31 downto 0)  -- Dado de 32 bits lido da posição A2
    );
end entity;

architecture rtl of register_file is
    -- 1. Cria o MOLDE (tipo): uma tabela com 32 posições de 32 bits
    type reg_array is array (0 to 31) of std_logic_vector(31 downto 0);

    -- 2. Cria o HARDWARE (os 32 registradores) usando o molde acima, tudo começando em 0
    --    (others => (others => '0')) significa: "todas as 32 posições recebem todos os 32 bits em '0'"
    signal regs : reg_array := (others => (others => '0'));

begin
    -- ESCRITA SÍNCRONA: só grava dados na borda de subida do clock
    process(CLK)
    begin
        if rising_edge(CLK) then
            -- Só escreve se a controladora autorizar (WE3 = '1') E se o destino não for o registrador $0
            if WE3 = '1' and to_integer(unsigned(A3)) /= 0 then
                regs(to_integer(unsigned(A3))) <= WD3;
            end if;
        end if;
    end process;

    -- LEITURAS ASSÍNCRONAS (combinacionais): atualizam na hora em que A1 ou A2 mudarem
    -- Se o endereço pedido for 0, força saída 0; senão, devolve o valor salvo dentro de regs(...)
    RD1 <= (others => '0') when to_integer(unsigned(A1)) = 0
           else regs(to_integer(unsigned(A1)));

    RD2 <= (others => '0') when to_integer(unsigned(A2)) = 0
           else regs(to_integer(unsigned(A2)));

end architecture;