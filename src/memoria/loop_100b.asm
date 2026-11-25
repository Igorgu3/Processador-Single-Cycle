.text
    # Endereço base da memória de dados no modo "Compact, Text at Address 0": 0x00002000 (8192)
    addi $s0, $zero, 8192

    # ATENCAO: Para testar rapido no MARS, mude os 3 numeros abaixo para 2, 3 e 4!
    # Para gerar o arquivo final da FPGA (100 bilhoes), deixe 2000, 1000 e 10000.
    addi $t0, $zero, 2000         # Loop 1 (externo)

loop_externo:
    addi $t1, $zero, 1000          # Loop 2 (meio)

loop_meio:
    addi $t2, $zero, 10000         # Loop 3 (interno)

loop_interno:
    sw   $t2, 0($s0)               # 1) Escreve $t2 na RAM (testa SW)
    lw   $t3, 0($s0)               # 2) Le de volta da RAM para $t3 (testa LW)
    addi $t2, $t2, -1              # 3) Decrementa contador interno (testa ADDI)
    beq  $t2, $zero, fim_interno   # 4) Se $t2 == 0, sai do loop interno (testa BEQ)
    beq  $zero, $zero, loop_interno# 5) Volta para o inicio do loop interno

fim_interno:
    addi $t1, $t1, -1              # Decrementa contador do meio
    beq  $t1, $zero, fim_meio      # Se $t1 == 0, sai do loop do meio
    beq  $zero, $zero, loop_meio   # Volta para o loop do meio

fim_meio:
    addi $t0, $t0, -1              # Decrementa contador externo
    beq  $t0, $zero, fim_programa  # Se $t0 == 0, encerra os loops
    beq  $zero, $zero, loop_externo# Volta para o loop externo

fim_programa:
    # Na FPGA, esta linha trava o PC no final para o programa nao reiniciar sozinho.
    # Para testar o fim no MARS, comente a linha abaixo com '#' antes de dar Run:
    beq  $zero, $zero, fim_programa
