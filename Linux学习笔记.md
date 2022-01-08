

# 1.系统分区

## 1.分区

分区类型：

1.主分区：最多只能有**4个**

2.扩展分区：

1. 最多只能有一个。
2. 主分区加扩展分区最多有4个。
3. 不能写入数据，只能包含逻辑分区

3.逻辑分区：可以正常读写数据 。

**逻辑分区编号从5开始，1~4被主分区占用，逻辑分区不能使用。**

## 2.格式化

写入文件系统，在写入文件系统的同事会覆盖原来存在数据，不能把格式化单纯理解成清空数据

## 3.设备文件名

给每个分区定义设备文件名。

设备文件名   /dev 路径下

/dev/hda 1 （IDE硬盘接口 ）   1代表第一个分区   古老，读写能力不如SCSI硬盘接口

/dev/sda 1    (SCSI硬盘接口,SATA硬盘接口)     目前使用最多的SATA硬盘接口。

## 4.挂载

分区->格式化->设备文件名->挂载

### 1.必须分区：

1. / 根分区
2. swap分区（交换分区）内存2倍，不能超过2GB  虚拟分区。

### 2.推荐分区：

/boot 启动分区 200MB，保证系统启动不会受影响

以上3个是必须分区的。/boot会默认分成sda 1 强制改其他的，会影响系统的正常启动

# 2.学习注意事项

1.命令严格区分大小写。

2.所有内容以文件形式保存，包括硬件。

3.Linux 不靠扩展名区分文件类型。(**靠的文件权限**)

4.所有的存储设备都必须挂载之后用户才能使用，包括硬盘，U盘，光盘。

5.Windows下的程序不能直接在Linux中安装和运行。

# 3.服务器的管理和建议

## 1.Linux各目录的作用

/bin/:存放系统命令的目录 ， 普通用户也可以使用。（*bin=binary 二进制文件*）

/sbin/:保存和系统环境设置相关的命令， 只有roo使用。

/usr/bin/:存放系统命令的目录，单用户模式下不能使用。

/boot/:系统启动目录，内核文件和启动引导程序文件。 建议备份

/dev/:设备文件保存位置。

/etc/：系统默认配置文件保存位置。 建议备份

/home/:普通用户的家目录 ，如/home/user1

/lib/：系统调用的函数库保存位置

/lost+found/:系统意外奔溃货关机，产生的文件碎片放在这里，恢复备份使用。

/media/:挂载目录，用来挂载媒体设备，如光盘。

/mnt/:挂载目录，用来挂载U盘，移动硬盘。

/misc/:挂载目录，挂载NFS服务的共享目录。

/opt/：第三方安装的软件保存位置。  习惯装在usr/local目录下。

/proc/:虚拟文件系统，主要保存系统的CPU系统  建议不要写数据

/sys/:虚拟文件系统，保存内核相关信息   建议不要写数据

/root/：超级用户家目录

/srv/:服务数据目录。

/tmp/：临时目录

/usr/: 系统软件资源目录。  (unix softwre resouce)

/var/:动态数据保存位置。 缓存，日志，邮件。

## 2.服务器注意事项

1.远程服务器不允许关机，只能重启。

2.重启时应该关闭服务。

3.不要在服务器访问高峰运行高负载命令。

4.远程配置防火墙时不要把自己踢出服务器。

# 4.Linux常用命令

命令格式：**命令 [-选项] [参数]**

### 1.文件处理命令

-a  --all     (**简化选项用一个-，完成选项用两个-**)

-l  long

-d  dirctory  显示指定目录的属性 只看目录本身，不看它的下面的文件

-i  文件的身份证号

```shell
root@wintrys:/# ls -l
total 970036
lrwxrwxrwx   1 root root         7 Jun 23  2021 bin -> usr/bin
drwxr-xr-x   3 root root      4096 Jun 23  2021 boot
drwxr-xr-x  18 root root      3900 Jan  2 13:27 dev
drwxr-xr-x  85 root root      4096 Jan  2 13:24 etc
drwxr-xr-x   2 root root      4096 Apr 15  2020 home
```

-h  人类能看懂的文件大小。如下文件大小有单位了。

```shell
root@wintrys:~# ls -lh
total 8.0K
drwxr-xr-x 2 root root 4.0K Jul  8 22:50 lee
drwxr-xr-x 7 root root 4.0K Jul 10 23:31 zbx
```

上面第二个参数2,7指的引用计数。

Linux没有文件创建时间的概念

**drwxr-xr-x**

第一个字符表示文件类型：**- 表示二进制文件  d 目录  l 软链接文件**  常见这三种。

后面九个字符，3个为一组

|        u         |        g        |       o       |
| :--------------: | :-------------: | :-----------: |
| user  文件所有者 | group文件所属组 | other  其他人 |

权限控制： r 读  w 写  x 执行

#### 1.mkdir   

创建新目录 

-p 递归创建  （本身不存在的目录下创建新目录要加 -p，不然无法创建）

```shell
root@wintrys:~/lee# mkdir -p f/s
root@wintrys:~/lee# ls
f  test
root@wintrys:~/lee# cd f
root@wintrys:~/lee/f# ls
s
```

可多个文件目录一块创建

```shell
root@wintrys:~/lee# mkdir A B C
root@wintrys:~/lee# ls
A  B  C
root@wintrys:~/lee# ls -l
total 12
drwxr-xr-x 2 root root 4096 Jan  6 17:06 A
drwxr-xr-x 2 root root 4096 Jan  6 17:06 B
drwxr-xr-x 2 root root 4096 Jan  6 17:06 C
```

#### 2.cd  

 切换目录  ==change directory

cd ..  回到上一级目录

#### 3.pwd   

显示当前目录    print working  directory

#### 4.rmdir 

 删除空目录  只能删除空目录

#### 5.cp  

复制文件或目录

-r   复制路径

```shell
root@wintrys:~/lee/A# cp nginx.conf /tmp/
root@wintrys:~/lee/A# cd /tmp/
root@wintrys:/tmp# ls -l
total 20
-rw------- 1 root root    0 Jan  2 13:24 AliyunAssistClientSingleLock.lock
-rw-r--r-- 1 root root    3 Jan  2 13:24 CmsGoAgent.pid
-rw-r--r-- 1 root root 1490 Jan  6 17:44 nginx.conf
```

-p  保留文件属性

```shell
root@wintrys:~/lee/A# cp -p nginx.conf /tmp/
root@wintrys:~/lee/A# cd /tmp/
root@wintrys:/tmp# ls -l
total 20
-rw------- 1 root root    0 Jan  2 13:24 AliyunAssistClientSingleLock.lock
-rw-r--r-- 1 root root    3 Jan  2 13:24 CmsGoAgent.pid
-rw-r--r-- 1 root root 1490 Jul 13 21:44 nginx.conf
```

注意看文件修改时间

#### 6.mv  

剪切文件，改名

```shell
root@wintrys:/tmp# mv nginx.conf /root
root@wintrys:/tmp# ls
AliyunAssistClientSingleLock.lock
CmsGoAgent.pid
systemd-private-9d6b3901efbd46329b25d7d1e7c6e854-chrony.service-ROcSSh
systemd-private-9d6b3901efbd46329b25d7d1e7c6e854-systemd-logind.service-jAYy2g
systemd-private-9d6b3901efbd46329b25d7d1e7c6e854-systemd-resolved.service-ODCJqh
root@wintrys:/tmp# ls -l /root
total 12
drwxr-xr-x 5 root root 4096 Jan  6 17:29 lee
-rw-r--r-- 1 root root 1490 Jul 13 21:44 nginx.conf
```

改名操作

```shell
root@wintrys:~# ls -l
total 12
drwxr-xr-x 5 root root 4096 Jan  6 17:29 lee
-rw-r--r-- 1 root root 1490 Jul 13 21:44 nginx.conf
drwxr-xr-x 7 root root 4096 Jul 10 23:31 zbx
root@wintrys:~# mv nginx.conf newname.conf
root@wintrys:~# ls -l
total 12
drwxr-xr-x 5 root root 4096 Jan  6 17:29 lee
-rw-r--r-- 1 root root 1490 Jul 13 21:44 newname.conf
drwxr-xr-x 7 root root 4096 Jul 10 23:31 zbx
```

#### 7.rm

   -rf 删除文件   remove       Linux没有回收站  删除前做好备份

-r  删除目录

-f  强制执行

#### 8.touch 

创建空文件

```shell
root@wintrys:~/lee# touch lwl.txt
root@wintrys:~/lee# ls
A  B  C  lwl.txt
```

#### 9.cat

显示文件内容，适用于内容比较短的文件

```shell
root@wintrys:~/lee# cat lwl.txt 
残歌未央  
若贻笑千古 
江畔暮雨 
青丝蘸白雪  
残月沉霜鬓  
初夏的雨点
root@wintrys:~/lee#
```

-n 显示行号

```shell
root@wintrys:~/lee# cat -n lwl.txt 
     1  残歌未央  
     2  若贻笑千古 
     3  江畔暮雨 
     4  青丝蘸白雪  
     5  残月沉霜鬓  
     6  初夏的雨点
```

tca   倒着显示

```shell
root@wintrys:~/lee# tac lwl.txt    
初夏的雨点残月沉霜鬓  
青丝蘸白雪  
江畔暮雨 
若贻笑千古 
残歌未央
```

#### 10.more

分页显示文件内容   适用于内容比较长的文件

空格或f    翻页

Enter 换行     逐行遍历

q或者Q   退出

#### 11.less

分页显示文件内容（可向上翻页）

可搜索内容

#### 12.head

显示文件前面几行

-n  指定行号

```shell
root@wintrys:~/lee# head -n 5 newname.conf 
user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;
```

#### 13.tail

显示文件后面一行

-n 指定行号

-f 动态显示文件末尾内容

```shell
root@wintrys:~/lee# tail newname.conf 
#               protocol   pop3;
#               proxy      on;
#       }
# 
#       server {
#               listen     localhost:143;
#               protocol   imap;
#               proxy      on;
#       }
#}
```

#### 14.ln

生成链接

软连接: 相当于windows里面的快捷方式          源文件删除，提示没有文件

硬链接：cp -p  + 同步                                         源文件删除，硬链接可以正常访问

**硬链接和源文件的i节点一样的**，**软链接的不一样**

### 2.权限管理命令

#### 1.chmod

改变文件或目录权限

chmod [{ugoa}{+-=}] [文件或目录]             a 代表前三者所有

```shell
root@wintrys:~/lee# ls -l
total 28
drwxr-xr-x 2 root root 4096 Jan  6 17:39 A
drwxr-xr-x 2 root root 4096 Jan  6 17:06 B
drwxr-xr-x 3 root root 4096 Jan  6 17:29 C
-rw-r--r-- 1 root root   97 Jan  6 19:57 lwl.txt
-rw-r--r-- 3 root root 1490 Jul 13 21:44 newname.conf
-rw-r--r-- 3 root root 1490 Jul 13 21:44 newname.conf.hard
-rw-r--r-- 3 root root 1490 Jul 13 21:44 newname.conf.soft
root@wintrys:~/lee# chmod u+x lwl.txt 
root@wintrys:~/lee# ls -l
total 28
drwxr-xr-x 2 root root 4096 Jan  6 17:39 A
drwxr-xr-x 2 root root 4096 Jan  6 17:06 B
drwxr-xr-x 3 root root 4096 Jan  6 17:29 C
-rwxr--r-- 1 root root   97 Jan  6 19:57 lwl.txt
-rw-r--r-- 3 root root 1490 Jul 13 21:44 newname.conf
-rw-r--r-- 3 root root 1490 Jul 13 21:44 newname.conf.hard
-rw-r--r-- 3 root root 1490 Jul 13 21:44 newname.conf.soft
```

**chmod [mode=421] [文件或目录]**

权限的数字表示：

r----4

w---2

x----1

rwxrw-r--   

7   6   4

```shell
root@wintrys:~/lee# chmod 764 lwl.txt  
root@wintrys:~/lee# ls -l lwl.txt     
-rwxrw-r-- 1 root root 97 Jan  6 19:57 lwl.txt
```

chmod -R 777      -R   递归修改子目录下的全部文件的权限

```shell
root@wintrys:~/lee# chmod -R 777 A
root@wintrys:~/lee# ls -l A
total 4
-rwxrwxrwx 1 root root 1490 Jul 13 21:44 nginx.conf
```

文件和目录的权限读写执行详情：

| 权限 |          file           |      directory       |
| :--: | :---------------------: | :------------------: |
|  r   | cat/more/less/head/tail |          ls          |
|  w   |           vim           | touch/mkdir/rmdir/rm |
|  x   |    script   command     |          cd          |

**删除一个文件，不是对一个文件有w权限，是要有该所在目录有w的权限**

#### 2.chown

改变文件或目录的所有者    **只有管理员才可以操作**

chown [用户] [文件或目录]

#### 3.chgrp

改变文件或目录的所属组

chgrp [用户组] [文件或目录

#### 4.umask

显示，设置文件的缺省权限

```shell
root@wintrys:~/lee# umask -S
u=rwx,g=rx,o=rx
```

### 3.文件搜索命令

#### 1.find

文件搜索

find [搜索范围] [匹配条件]

**-name  文件名查找**

-iname  文件名不区分大小写     *     通配符

```shell
root@wintrys:~# find /etc -name init    在目录/etc中查找文件init
/etc/apparmor/init
root@wintrys:~# find /etc -name *init*     在目录/etc中查找文件名包含init
/etc/init.d
/etc/ufw/before.init
/etc/ufw/after.init
/etc/default/grub.d/init-select.cfg
/etc/systemd/system/emergency.target.wants/grub-initrd-fallback.service
/etc/systemd/system/sysinit.target.wants
```

**-size  文件大小查找**

+n大于   -n小于  n 等于

```shell
root@wintrys:~# find /etc -size +100   #查找/etc目录下大于100字节的文件
/etc/ssh/moduli
/etc/ssl/certs/ca-certificates.crt
```

-a 两个条件同时满足

-o 满足其中一个即可

```shell
root@wintrys:~# find /root -cmin -60 -a -size -10000
/root/.bash_history
```

**-user： 文件所有者查找**

**-cmin ： 修改文件属性   change**

**-amin  ：访问时间    access**

**-mmin：修改文件内容  modify**

```shell
root@wintrys:~# find /root -cmin -60     # /root目录下最近60min内修改过的文件属性
/root/.bash_history
```

-type：根据文件类型查找

f 文件 d 目录 l 软链接文件

```shell
root@wintrys:~/lee# find -type f
./lwl.txt
./newname.conf
./newname.conf.hard
./A/nginx.conf
./newname.conf.soft
root@wintrys:~/lee# find -type d
.
./A
./B
./C
./C/D
```

-exec/-ok 命令 {} \;           exec直接执行，ok是要确认是否操作

```shell
root@wintrys:~/lee# find -name A -exec ls -l {} \;   # 找到A目录并执行ls -l命令
total 4
-rwxrwxrwx 1 root root 1490 Jul 13 21:44 nginx.conf
```

-inum  根据i节点查找

```shell
root@wintrys:~/lee# ls -i
1441827 A  1442128 B  1442132 C  1314486 lwl.txt  1314489 newname.conf  1314489 newname.conf.hard  1314489 newname.conf.soft
root@wintrys:~/lee# find -inum 1314486
./lwl.txt
```

#### 2.locate

在文件资料库中查找文件

-i  不区分大小写

updatedb   更新文件资料库

```shell
root@wintrys:~# locate newname.conf 
/root/newname.conf
/root/lee/newname.conf
/root/lee/newname.conf.hard
/root/lee/newname.conf.soft
root@wintrys:~# updatedb
```

#### 3.which

搜索命令所在目录及别名信息

```shell
root@wintrys:~# which ls
/usr/bin/ls
root@wintrys:~# which cp
/usr/bin/cp
```

#### 4.whereis

搜索命令所在目录及帮助文档路径

```shell
root@wintrys:~# whereis rm
rm: /usr/bin/rm /usr/share/man/man1/rm.1.gz
```

#### 5.grep

在文件中搜索字串匹配的行并输出

-i 不区分大小写

-v 排除指定字串

```shell
root@wintrys:~# grep -v ^# newname.conf     
user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
        worker_connections 768;
        # multi_accept on;
}

```

### 4.帮助命令

#### 1.man

获得帮助信息

1  对应命令的帮助，5 配置文件的帮助

#### 2.help

获得shell内置命令的帮助信息

### 5.用户管理命令

#### 1.useradd

添加新用户

```shell
root@wintrys:~# useradd liwanlin
useradd: user 'liwanlin' already exists
```

#### 2.passwd

设置用户密码

#### 3.who

查看登录用户信息

```shell
root@wintrys:~# who
root     pts/0        2022-01-07 17:03 (113.201.129.29)
liwanlin pts/1        2022-01-07 16:16 (113.201.129.29)
liwanlin pts/2        2022-01-07 16:28 (113.201.129.29)
liwanlin pts/3        2022-01-07 16:34 (113.201.129.29)
liwanlin pts/4        2022-01-07 17:11 (113.201.129.29)
```

tty 本地终端   pts远程终端        登录时间    登录IP

#### 4.w

查看登录用户详细信息

```shell
root@wintrys:~# w
 17:22:34 up 5 days,  3:58,  6 users,  load average: 0.00, 0.02, 0.00
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
root     pts/0    113.201.129.29   17:03    1.00s  0.02s  0.00s w
liwanlin pts/1    113.201.129.29   16:16    1:05m  0.00s  0.00s -sh
liwanlin pts/2    113.201.129.29   16:28   54:13   0.00s  0.00s -sh
liwanlin pts/3    113.201.129.29   16:34   47:41   0.00s  0.00s -sh
liwanlin pts/4    113.201.129.29   17:11    9:59   0.01s  0.01s -bash
liwanlin pts/5    113.201.129.29   17:17    4:34   0.02s  0.02s -bash
```

第一行 up表示系统连续运行的时间   最后参数表示系统负载情况

```shell
root@wintrys:~# uptime
 17:26:43 up 5 days,  4:02,  7 users,  load average: 0.05, 0.04, 0.00
```

### 6.压缩解压命令

#### 1.gzip

压缩文件 格式： .gz  