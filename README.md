# ubuntu-zimg精简版

* 基于ubuntu镜像制作，[zimg](http://zimg.buaa.us/) v3.2.0 支持 png webp 格式图片

```bash
启动方式：docker run -it -d -p 4869:4869 -v /data/zimg/:/zimg/bin/img --name zimg wangyp0701/zimg-ubuntu
```

*  [helm](https://helm.sh) 安装到k8s

```bash
 helm repo add ali https://apphub.aliyuncs.com/experimental
 helm repo update
 helm install zimg ali/zimg
 ```
