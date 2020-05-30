# CARLA-Autoware-Docker

CARLA と Autoware を含むDockerイメージの作成，コンテナの起動を行う．

## 環境依存

|ハードウェア                |テスト済         |
|----------------------------|-----------------|
|メモリが4GB以上のNVIDIA製GPU|NVIDIA RTX 2080Ti|

|ソフトウェア            |テスト済    |
|------------------------|------------|
|Linux OS - 64bit        |Ubuntu 18.04|
|NVIDIA Driver           |440.82      |
|Docker-CE               |19.03.9     |
|NVIDIA-Container-Toolkit|1.1.1       |

## インストール

```bash
git clone --recurse-submodules https://github.com/shikishima-TasakiLab/carla-autoware-docker.git
```

## 使い方

### Docker イメージのビルド

1. 次のコマンドでDockerイメージをビルドする．

    ```bash
    ./docker/build-docker.sh
    ```

1. ビルドに成功すると，Dockerイメージの一覧に "carla/autoware:1.14.0-melodic-cuda" が追加される．

    ```bash
    docker images

    >>>

    REPOSITORY          TAG                             IMAGE ID            CREATED             SIZE
    carla/autoware      1.14.0-melodic-cuda             b2c65c0f2add        9 minutes ago       23.8GB
    ```

### Docker コンテナの起動

1. 次のコマンドでDockerコンテナを起動する．

    ```bash
    ./docker/run-docker.sh
    ```
    
    終了時は，`exit`コマンドか [Ctrl]+[D] を入力する．

1. 起動したコンテナで複数のターミナルを使用する際は，別のターミナルで次のコマンドを実行する．

    ```bash
    ./docker/exec-docker.sh
    ```

    終了時は，`exit`コマンドか [Ctrl]+[D] を入力する．

### Autoware の起動

Dockerコンテナを起動した後，次のコマンドで Autoware を起動する．
```bash
autoware
```

### CARLA の起動

Dockerコンテナを起動した後，次のコマンドで CARLA を起動する．
```bash
carla
```

### Autoware・CARLA の連携

1. 次のコマンドでDockerコンテナを起動する．

    ```bash
    ./docker/run-docker.sh
    ```
    
1. 次のコマンドでAutowareを起動する．

    ```bash
    autoware
    ```

1. 別のターミナルで次のコマンドを実行し，起動中のDockerコンテナに入る．

    ```bash
    ./docker/exec-docker.sh
    ```

1. 次のコマンドでCARLAを起動する．

    ```bash
    carla
    ```

1. さらに別のターミナルで次のコマンドを実行し，起動中のDockerコンテナに入る．

    ```bash
    ./docker/exec-docker.sh
    ```

1. 次のコマンドを実行して，CARLAとAutowareを接続する．

    ```bash
    roslaunch carla_autoware_bridge carla_autoware_bridge_with_manual_control.launch use_sim_time:=False
    ```

    |オプション  |パラメータ   |説明                |既定値  |例                   |
    |------------|-------------|--------------------|--------|---------------------|
    |use_sim_time|{True\|False}|ROSTimeを使用する   |True    |`use_sim_time:=False`|
    |town        |TOWN         |使用する町を選択する|"Town01"|`town:="Town03"`     |