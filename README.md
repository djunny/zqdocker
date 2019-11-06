# 这是什么
该镜像用于为掌圈的web服务提供基础设施，将开发人员从繁琐的系统配置和环境依赖中解放出来，让开发者可以更快上手开发

# 项目依赖
- 使用docker-compose用于容器编排
- nginx代理web请求
- php-fpm管理fastcgi

# 如何使用
- clone 掌圈项目
- 运行docker-compose up -d