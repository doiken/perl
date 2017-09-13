#ifdef __cplusplus
extern "C" {
#endif

#define PERL_NO_GET_CONTEXT /* we want efficiency */
#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>

#ifdef __cplusplus
} /* extern "C" */
#endif

#define NEED_newSVpvn_flags
#include "ppport.h"

MODULE = Http    PACKAGE = Http

PROTOTYPES: DISABLE

typedef struct {
    char url;
} Http;

Http* Http_new(const char *url) {
    Http *http = malloc(sizeof(Http));
    http->url = x;
    return h;
}

void Http_free(Http* http) {
    free(http);
}

char*
get(char *url)
CODE:
     char *body;
     body = (char*) malloc(0); // realloc前にalloc呼び出し必須
     int body_size = 0;
     
     struct sockaddr_in server;
     int sock;
     char buf[1024];
     unsigned int **addrptr;
    
     sock = socket(AF_INET, SOCK_STREAM, 0);
     if (sock < 0) {
         perror("socket");
         abort();
     }
    
     server.sin_family = AF_INET;
     server.sin_port = htons(80); /* HTTPのポートは80番です */
    
     server.sin_addr.s_addr = inet_addr(url);
     if (server.sin_addr.s_addr == 0xffffffff) {
         struct hostent *host;
    
         host = gethostbyname(url);
         if (host == NULL) {
             if (h_errno == HOST_NOT_FOUND) {
                 /* h_errnoはexternで宣言されています */
                 printf("host not found : %s\n", url);
             } else {
                /*
                HOST_NOT_FOUNDだけ特別扱いする必要はないですが、
                とりあえず例として分けてみました
                */
                printf("%s : %s\n", hstrerror(h_errno), url);
             }
             abort();
         }
    
         addrptr = (unsigned int **)host->h_addr_list;
    
         while (*addrptr != NULL) {
             server.sin_addr.s_addr = *(*addrptr);
    
             /* connect()が成功したらloopを抜けます */
             if (connect(sock,
                    (struct sockaddr *)&server,
                    sizeof(server)) == 0) {
                break;
             }
    
             addrptr++;
             /* connectが失敗したら次のアドレスで試します */
         }
    
         /* connectが全て失敗した場合 */
         if (*addrptr == NULL) {
             perror("connect");
             abort();
         }
     } else {
         if (connect(sock,
                         (struct sockaddr *)&server, sizeof(server)) != 0) {
             perror("connect");
             abort();
         }
     }
    
     /* HTTPで「/」をリクエストする文字列を生成 */
     memset(buf, 0, sizeof(buf));
     snprintf(buf, sizeof(buf), "GET / HTTP/1.0\r\n\r\n");
    
     /* HTTPリクエスト送信 */
     int n = write(sock, buf, (int)strlen(buf));
     if (n < 0) {
         perror("write");
         abort();
     }
    
     /* サーバからのHTTPメッセージ受信 */
     while (n > 0) {
         memset(buf, 0, sizeof(buf));
         
         // bufを取り込み再度コピー
         n = read(sock, buf, sizeof(buf));
         if (n < 0) {
             perror("read");
             abort();
         }
         
         char *t = (char *) realloc(body, body_size + sizeof(buf));
         if(!t) {
             abort();
         }
         body = t;
         
         // 追記分をコピー
         memcpy(&body[body_size], buf, sizeof(buf));
         // sv_dump(newSVpvn(buf, sizeof(buf)));
         // sv_dump(newSVpvn(body, body_size));
         
         /* 受信結果を標準出力へ表示(ファイルディスクリプタ1は標準出力) */
         // write(1, buf, n);
         
         body_size += sizeof(buf);
     }
    
     // sv_dump(newSVpvn(body, 4));
     close(sock);
    
     // sv_dump(url);
    
    RETVAL = body;
OUTPUT:
    RETVAL
