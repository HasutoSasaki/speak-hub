## TCPサーバーとクライアント

---

### TCPサーバーの作成

```c
fd = socket()
bind(fd, address)
listen(fd)
while True:
    conn_fd = accept(fd)
    do_something_with(conn_fd)
    close(conn_fd)
```

---

#### ステップ1: ソケットハンドルを取得

```c
int fd = socket(AF_INET,SOCK_STREAM,0);
```

1. `AF_INET`はIPv4アドレスファミリを指定
2. `SOCK_STREAM`はTCPソケットを指定
3. `0`はプロトコルを自動的に選択

3つの引数の組み合わせによって、ソケットの種類が決まります。

| Protocol | Arguments                          |
| -------- | ---------------------------------- |
| IPv4+TCP | `socket(AF_INET, SOCK_STREAM, 0)`  |
| IPv4+UDP | `socket(AF_INET, SOCK_DGRAM, 0)`   |
| IPv6+TCP | `socket(AF_INET6, SOCK_STREAM, 0)` |
| IPv6+UDP | `socket(AF_INET6, SOCK_DGRAM, 0)`  |

---

#### ステップ2: アドレスにバインド

```c
struct sockaddr_in addr = {};
addr.sin_family = AF_INET;
addr.sin_port = htons(1234); // port
addr.sin_addr.s_addr = htonl(0); // wildcard IP 0.0.0.0
int rv = bind(fd, (const struct sockaddr *)&addr, sizeof(addr));
if (rv) { die("bind()"); }
```

```c
struct sockaddr_in = {
    uint16_t sin_family; // AF_INET
    uint16_t sin_port;   // port in big-endian
    struct in_addr sin_addr; // IP address
};
struct in_addr = {
    uint32_t s_addr; // IP address in big-endian
};
```

補足：endianとは
バイトの並び順を指します。

- **ビッグエンディアン**: 上位バイトが先に来る形式
- **リトルエンディアン**: 下位バイトが先に来る形式

`入力値` : 0001 0010 0011 0100
`ビッグエンディアン` : 0001 0010 0011 0100
`リトルエンディアン` : 0100 0011 0010 0001
違いはバイトの順序です。
バイトの順序を逆にすることを、`バイトスワップ`と呼びます。

---

#### ステップ3: Listen

`socket`は`listen`の後に作成されます。

```c
rv = listen(fd,COMAXCONN);
if (rv) { die("listen()"); }
```

第二引数は、キューの最大数です。Linuxでは、`MAXCONN`は4096です。

---

#### ステップ4: Accept connections

```c
while (true) {
    // accept
    struct sockaddr_in client_addr = {};
    socklen_t addrlen = sizeof(client_addr);
    int connfd = accept(fd, (struct sockaddr *)&client_addr, &addrlen);
    if (connfd < 0) {
        continue; // error
    }

    do_something(connfd);
    close(connfd);
}
```

---

#### ステップ5: Read & write

```c
static void do_something(int connfd) {
    char rbuf[64] = {};
    ssize_t n = read(connfd, rbuf, sizeof(rbuf) - 1);
    if (n < 0) {
        msg("read() error");
        return;
    }
    printf("client says: %s\n", rbuf);

    char wbuf[64] = "world";
    write(connfd, wbuf, strlen(wbuf));
}
```

ちなみに、`read/write`は、`send/recv`に置き換えることもできます。
違いは、`flag`を指定できることです。

```c
ssize_t read(int fd, void *buf, size_t len);
ssize_t recv(int fd, void *buf, size_t len, int flags); //read
ssize_t write(int fd, const void *buf, size_t len);
ssize_t send(int fd, const void *buf, size_t len, int flags); //write
```

---

### Create a TCP client

```c
int fd = socket(AF_INET, SOCK_STREAM, 0);
if (fd < 0) {
    die("socket()");
}

struct sockaddr_in addr = {};
addr.sin_family = AF_INET;
addr.sin_port = ntohs(1234); // port
addr.sin_addr.s_addr = inet_addr(INADDR_LOOPBACK); // 127.0.0.1
int rv = connect(fd, (const struct sockaddr *)&addr, sizeof(addr));
if (rv) {
    die("connect()");
}

char msg[] = "hello";
write(fd, msg, strlen(msg));

char rbuf[64] = {};
ssize_t n = read(fd, rbuf, sizeof(rbuf) - 1);
if (n < 0) {
    die("read()");
}
printf("server says: %s\n", rbuf);
close(fd);
```

---

### More on socket API

#### struct sockaddr を理解する

```c
int accept(int scokfd, struct sockaddr *addr, socklen_t len);
int connect(int sockfd, const struct sockaddr *addr, socklen_t len);
int bind(int sockfd, const struct sockaddr *addr, socklen_t len);
```

```c
// pointless
struct sockaddr {
    unsigned short sa_family; // AF_INET, AF_INET6
    char sa_data[14]; // useless
};
// IPv4:port
struct sockaddr_in {
    sa_family_t sin_family; // AF_INET
    uint16_t sin_port; // port number, big-endian
    struct in_addr sin_addr; // IPv4 address
}
// IPv6:port
struct sockaddr_in6 {
    sa_family_t sin6_family; // AF_INET6
    uint16_t sin6_port; // port number, big-endian
    struct in6_addr sin6_addr; // IPv6 address
    uint32_t sin6_flowinfo; // flow info
    uint32_t sin6_scope_id; // scope ID
}
//can store both sockaddr_in & sockaddr_in6
struct sockaddr_storage {
    sa_family_t ss_family; // AF_INET, AF_INET6
    char __some_padding[__BIG_ENOUGH_NUMBER];
}
```

APIが実現したいことは、単純なタグで表現できる

```c
struct fictional_sane_sockaddr {
    uint16_t family; // AF_INET, AF_INET6
    uint16_t port;
    union {
        struct { uint8_t ipv4[4]; };
        struct { uint8_t ipv6[16]; };
    };
}
```

---

付録

- TCPについてわかりやすい記事
  [詳しめ](https://www.ne.jp/asahi/hishidama/home/tech/socket/)
  [ざっくり](https://qiita.com/Michinosuke/items/0778a5344bdf81488114)
