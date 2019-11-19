# 这是什么
该镜像用于为掌圈的web服务提供基础设施，将开发人员从繁琐的系统配置和环境依赖中解放出来，让开发者可以更快上手开发

# 项目依赖
- 使用docker-compose用于容器编排
- nginx代理web请求

# 项目中间件
- php-fpm管理fastcgi
- nginx转发fastcgi请求


# 如何使用
- 安装docker desktop for mac
- 设置docker中国镜像  `preference => daemon => registry mirrors`
```shell
http://docker.mirrors.ustc.edu.cn/
```
- 将项目的父级目录加入共享中 `preference => file sharing`
- clone 掌圈项目
- 配置nginx反向代理
```nginx
server {
  listen 80;
  server_name zquan.cc *.zquan.cc zquan.com *.zquan.com 0c1d.com *.0c1d.com;

  location / {
    proxy_pass http://127.0.0.1:7788;
    proxy_http_version 1.1;
    proxy_set_header Host $host;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection $http_connection;
    proxy_pass_request_headers on;
  }
}
```
- 切换到项目路径下 && 运行docker-compose up -d
- 修改host文件
```
127.0.0.1 zquan.com www.zquan.com 0c1d.com xhjd.0c1d.com
```
