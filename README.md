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
git clone https://github.com/shikishima-TasakiLab/carla-autoware-docker.git
```

## 使い方

### Docker イメージのビルド

1. 次のコマンドでDockerイメージをビルドする．

    ```bash
    ./docker/build-docker.sh
    ```

1. ビルドに成功すると，Dockerイメージの一覧に "carla/autoware:1.14.0-alpha.1-melodic-cuda" が追加される．

    ```bash
    docker images

    >>>

    REPOSITORY          TAG                             IMAGE ID            CREATED             SIZE
    carla/autoware      1.14.0-alpha.1-melodic-cuda     d0b033d2befc        12 hours ago        20.9GB
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
