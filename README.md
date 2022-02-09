# Organizar MP3 - Script em PowerShell

Script feito em powershell para organizar arquivos baseados em metadados de artista e album

Move os arquivos para pastas baseadas nestas informações, as pastas serão criadas neste formato "artista/album".

Útil para organizar pastas com várias músicas que estão esquecidas no PC.

Modo de uso

```
.\orgMP3.ps1 [pastaDeOrigem] [pastaDeDestino] [-debugMode]
```

## Parametros de entradas

### pastaDeOrigem
- Opcional
- Valor padrão é a pasta atual (".\")
- Deve ser informado no seguinte formado "C:\Nome\Da\Pasta"

```
.\orgMP3.ps1 "C:\Nome\Da\Pasta"
```

### pastaDeDestino
- Opcional
- Valor padrão é o valor de pastaDeOrigem
- Deve ser informado no seguinte formado "C:\Nome\Outra\Pasta"

```
.\orgMP3.ps1 "C:\Nome\Da\Pasta" "C:\Nome\Outra\Pasta"
```

### debugMode
- Opcional
- Se o valor 1 for informado, somente vai listar os arquivos e não executar a ação.

```
.\orgMP3.ps1 -debugMode 1
```

```
.\orgMP3.ps1 "C:\Nome\Da\Pasta"  -debugMode 1
```
```
.\orgMP3.ps1 "C:\Nome\Da\Pasta" "C:\Nome\Outra\Pasta"  -debugMode 1
```