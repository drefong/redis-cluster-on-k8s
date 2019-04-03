# redis-cluster-on-k8s
redis cluster in kubernetes(k8s) with configmap and storage class
    实现Redis Cluster在Kubernetes中的部署，同时考虑了容器的非持久性（IP、文件系统等）。总体的部署思路是通过yaml创建redis实例，通过脚本实现自动化的集群构建，同时在Pod中集成fix ip脚本，在重启或者重建后完成IP发生变化的情况下，完成集群的修复工作。具体采用了statefulset的资源类型，同时结合configmaps、storageclass等资源。其中statefulset是为了解决域名和文件系统持久化的问题，configmaps实现配置和应用分离，具有更好的灵活性，storageclass是为了解决pv、pvc的自动分配和绑定，使得volume的按需分配和挂载自动化
部分内容引用其他github，同时进行了修正和调试，POD重启或者重建都测试正常。
使用方式：
下载redis-cluster.yml和redis-cluster-create.sh，放置于同一目录下，执行redis-cluster-create.sh即可。需要有执行kubectl命令权限。

chmod u+x redis-cluster-create.sh 

./redis-cluster-create.sh 

