# SILENT MoneroMiner ♨️
Compiled xmrig CPU based miner 🚀

### Compiled with 0% Developer Fee


## Usage 🚨

generally the program will need this configurations to run
```bash
./xmrig -o <Pool> -u <Wallet> -p <Miner-Name> (-k --tls) --cpu-max-threads-hint [25|50|75|100] -o <Another-Pool> -u <Wallet> -p <Miner-Name> (-k --tls)
```

# Linux Installer 🐧
Simple bash script to REMOTELY start xmrig mining 😈

1. First it Downloads xmrig engine from your server
2. Creates a uniq identifier for the client and sends it back to your server using POST request to **/getinfo**
3. If the user is **root**:
    1. Creates a service for xmrig miner called **process-monitor** 🔎
    2. Runs a maintainig script to be sure that xmrig proccess never dies 🧑‍⚕️
    3. starts on boot ⚙️
    4. restarts on killing the xmrig proccess 🐦‍🔥
4. If the user is **NOT root**
    1. Places the miner in **/.local/data/**
    2. Creates a maintaining script and adds it to users **.SHELLrc** file
    3. Every time that users creates a shell the Miner will start silently 🔇

# Windwos 🪟

Its name has been changed to Google something so dont panic... 😁

* Will restart after killing the proccess ♻
* restarts on killing the xmrig proccess 🐦‍🔥
* Starts on boot ⚙️
* Last time i checked There was no problem with WindowsDefender 🤪


# Disclaimer ⚠️

This project is a fork of the XMRig Monero miner, originally developed by Original authors: https://github.com/xmrig/xmrig.


# Support 💎

If you find this project helpful and would like to support its continued development, you can donate via the following methods:
  * Bitcoin
    ```
    bc1qq6vrlnytva67mj956nydfyvuzwl4t6wy2naahc
    ```
  * Ethereum
    ```
    0xa88238491Df0219b0F924Fc6c6e1Bc8B3BB50E60
    ```
  * USDT (trc20)
    ```
    TDxoEoBLnStz6QBY69rUnsnkAxuoE485Xy
    ```

Thank you for your support!
