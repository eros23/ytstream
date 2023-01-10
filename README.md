# ytstream
## _Streaming su youtube da telecamera_

Invia il tuo flusso streaming da una semplice telecamera di videosorveglianza.

# Requisiti

Installa ffmpeg su Debian/Ubuntu/Raspberry

```sudo apt install ffmpeg```

## Installazione

Copia i file ffmpeg.sh e ytstream.sh nella caratella dove vuoi eseguire il tuo script, ad esemipio "/home/pi/" e assicurati di averere i permessi di esecuzione.

```cp ffmpeg.sh /home/pi/
cp ytstream.sh /home/pi/
chmod +x /home/pi/ffmpeg.sh
chmod +x /home/pi/ytstream.sh
```
Copia il file audio.mp4 (si! Youtube vuole un flusso audio obbligatorio.) nella cartella dei file sh.

```cp audio.m4a /home/pi/```

Crea un file vuoto di log:

```touch /home/pi/ffmpeg.log```

Salva il file di servizio, ad esempio "ytstream.service", in /etc/systemd/system/.

```sudo cp ytstream.service /etc/systemd/system/```

Abilita il servizio per avviarlo automaticamente all'avvio del sistema:

```sudo systemctl enable ytstream.service```

Una volta configurate le variabili su ffmpeg.sh, avvia il servizio.

```sudo systemctl start ytstream.service```

