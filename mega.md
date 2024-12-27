# Baseando-se nos números sorteados recentemente, criar uma lista única sem repetições
numeros_sorteados = [
    2, 4, 15, 28, 34, 39,  # Concurso 2809
    10, 24, 33, 35, 41, 46, # Concurso 2808
    8, 25, 49, 52, 55, 56,  # Concurso 2807
    5, 11, 13, 45,          # Concurso 2806 (excluindo repetidos)
    1, 6, 47, 58,           # Concurso 2805 (excluindo repetidos)
    14, 31, 60,             # Concurso 2804 (excluindo repetidos)
    20, 32, 43, 57,         # Concurso 2803 (excluindo repetidos)
    17, 21, 26,             # Concurso 2802 (excluindo repetidos)
    27, 48,                 # Concurso 2801 (excluindo repetidos)
    19, 50                  # Concurso 2800 (excluindo repetidos)
]

# Adicionar números que ainda faltam até completar os 60
faltantes = set(range(1, 61)) - set(numeros_sorteados)
numeros_unicos = numeros_sorteados + list(faltantes)

# Organizar os números em grupos de 6 sem repetições
random.shuffle(numeros_unicos)
conjuntos_unicos = [sorted(numeros_unicos[i:i+6]) for i in range(0, len(numeros_unicos), 6)]

conjuntos_unicos
