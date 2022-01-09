

# 0.系统分类

- RedHat系列：Redhat、Centos、Fedora等
- Debian系列：Debian、Ubuntu等

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

```shell
root@wintrys:~# touch testgizp  
root@wintrys:~# gzip testgizp 
root@wintrys:~# ls -l
total 16
drwxr-xr-x 5 root root 4096 Jan  6 20:31 lee
-rw-r--r-- 1 root root 1490 Jul 13 21:44 newname.conf
-rw-r--r-- 1 root root   29 Jan  8 12:06 testgizp.gz
drwxr-xr-x 7 root root 4096 Jul 10 23:31 zbx
```

####   2.gunzip

解压缩.gz的压缩文件      或者 gzip -d

**只能压缩文件，不保留源文件**

```shell
root@wintrys:~# gunzip testgizp.gz 
root@wintrys:~# ls -l
total 12
drwxr-xr-x 5 root root 4096 Jan  6 20:31 lee
-rw-r--r-- 1 root root 1490 Jul 13 21:44 newname.conf
-rw-r--r-- 1 root root    0 Jan  8 12:06 testgizp
drwxr-xr-x 7 root root 4096 Jul 10 23:31 zbx
```

#### 3.tar

打包目录

-c  打包

-v 显示详细信息

-f 指定文件名

-z 打包同时压缩

```shell
root@wintrys:~# tar -cvf Japan.tar Japan
Japan/          
Japan/boduo
Japan/longze
Japan/canglaoshi
root@wintrys:~# ls -l
total 28
drwxr-xr-x 2 root root  4096 Jan  8 14:48 Japan
-rw-r--r-- 1 root root 10240 Jan  8 14:49 Japan.tar
drwxr-xr-x 5 root root  4096 Jan  6 20:31 lee
-rw-r--r-- 1 root root  1490 Jul 13 21:44 newname.conf
-rw-r--r-- 1 root root     0 Jan  8 12:06 testgizp
drwxr-xr-x 7 root root  4096 Jul 10 23:31 zbx
```

在对打包文件进行压缩

```shell
root@wintrys:~# gzip Japan.tar 
root@wintrys:~# ls
Japan  Japan.tar.gz  lee  newname.conf  testgizp  zbx
```

Japan.tar.gz 最常见的代码打包方式

参数加 -z 一步到位

```shell
root@wintrys:~# tar -zcf Japan.tar.gz Japan
root@wintrys:~# ls -l
total 20
drwxr-xr-x 2 root root 4096 Jan  8 14:48 Japan
-rw-r--r-- 1 root root  189 Jan  8 14:54 Japan.tar.gz
drwxr-xr-x 5 root root 4096 Jan  6 20:31 lee
-rw-r--r-- 1 root root 1490 Jul 13 21:44 newname.conf
-rw-r--r-- 1 root root    0 Jan  8 12:06 testgizp
drwxr-xr-x 7 root root 4096 Jul 10 23:31 zbx
```

解压用 -x

```shell
root@wintrys:~# tar -zxvf Japan.tar.gz 
Japan/
Japan/boduo
Japan/longze
Japan/canglaoshi
root@wintrys:~# ls -l
total 20
drwxr-xr-x 2 root root 4096 Jan  8 14:48 Japan
-rw-r--r-- 1 root root  189 Jan  8 14:54 Japan.tar.gz
drwxr-xr-x 5 root root 4096 Jan  6 20:31 lee
-rw-r--r-- 1 root root 1490 Jul 13 21:44 newname.conf
-rw-r--r-- 1 root root    0 Jan  8 12:06 testgizp
drwxr-xr-x 7 root root 4096 Jul 10 23:31 zbx
```

#### 4.zip

压缩文件或目录

**能保留源文件**

```shell
root@wintrys:~# ls
boduo  Japan  Japan.tar.gz  lee  newname.conf  testgizp  zbx
root@wintrys:~# zip boduo.zip boduo 
  adding: boduo (stored 0%)
root@wintrys:~# ls
boduo      Japan         lee           testgizp
boduo.zip  Japan.tar.gz  newname.conf  zbx
```

-r  压缩目录

```shell
root@wintrys:~# zip -r Japan.zip Japan
  adding: Japan/ (stored 0%)
  adding: Japan/boduo (stored 0%)
  adding: Japan/longze (stored 0%)
  adding: Japan/canglaoshi (stored 0%)
```

#### 5.unzip

解压.zip的压缩文件

```shell
root@wintrys:~# unzip Japan.zip 
Archive:  Japan.zip
   creating: Japan/
 extracting: Japan/boduo             
 extracting: Japan/longze            
 extracting: Japan/canglaoshi
```

#### 6.bzip2

压缩文件

-k 产生压缩文件后保留源文件

```shell
root@wintrys:~# bzip2 boduo
root@wintrys:~# ls
boduo.bz2  Japan         Japan.zip  newname.conf  zbx
boduo.zip  Japan.tar.gz  lee        testgizp
```

#### 7.bunzip2

解压bzip2文件

```shell
root@wintrys:~# bunzip2 boduo.bz2 
root@wintrys:~# ls
boduo      Japan         Japan.zip  newname.conf  zbx
boduo.zip  Japan.tar.gz  lee        testgizp
```

### 7.网络命令

#### 1.write

给在线用户发消息  用Ctrl+D保存发送

```shell
root@wintrys:~# write liwanlin
write: write: you have write permission turned off.

hello world
```

```shell
liwanlin@wintrys:~$ 
Message from root@wintrys on pts/2 at 21:32 ...
helle world
EOF
```

#### 2.wall

给所有用户发广播

```shell
root@wintrys:~# wall wo shi zgr!
                                                                               
Broadcast message from root@wintrys (pts/2) (Sat Jan  8 21:38:46 2022):        
                                                                               
wo shi zgr!
```

自己也会收到。

#### 3.ping

测试网络连通性

-c  次数

```shell
root@wintrys:~# ping -c 4 www.baidu.com
PING www.a.shifen.com (180.101.49.12) 56(84) bytes of data.
64 bytes from 180.101.49.12 (180.101.49.12): icmp_seq=1 ttl=50 time=15.2 ms
64 bytes from 180.101.49.12 (180.101.49.12): icmp_seq=2 ttl=50 time=15.3 ms
64 bytes from 180.101.49.12 (180.101.49.12): icmp_seq=3 ttl=50 time=15.3 ms
64 bytes from 180.101.49.12 (180.101.49.12): icmp_seq=4 ttl=50 time=15.3 ms

--- www.a.shifen.com ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3004ms
rtt min/avg/max/mdev = 15.225/15.256/15.275/0.019 ms
```

#### 4.ifconfig

查看和设置网卡信息

ifconfig eth0 192.168.8.250

#### 5.mail

查看发送电子邮件

mail [用户名]

用Ctrl+D保存发送

#### 6.last

列出目前与过去登入系统的用户信息

```shell
root@wintrys:~# last
liwanlin pts/3        123.139.17.29    Sat Jan  8 21:31   still logged in
root     pts/2        123.139.17.29    Sat Jan  8 21:14   still logged in
root     pts/0        123.139.17.29    Sat Jan  8 20:35   still logged in
root     pts/1        123.139.17.29    Sat Jan  8 17:04   still logged in
root     pts/0        113.201.129.29   Sat Jan  8 12:02 - 19:17  (07:15)
liwanlin pts/1        113.201.129.29   Fri Jan  7 21:26 - 23:39  (02:12)
```

#### 7.lastlog

检查某特定用户上次登录的信息

```shell
root@wintrys:~# lastlog -u liwanlin
Username         Port     From             Latest
liwanlin         pts/4    123.139.17.29    Sat Jan  8 21:51:07 +0800 2022
```

#### 8.traceroute

显示数据包到主机间的路径  (每一个节点)

用于定位那个节点出问题

```shell
root@wintrys:~# traceroute www.sina.com.cn
traceroute to www.sina.com.cn (39.96.118.196), 30 hops max, 60 byte packets
 1  10.4.16.74 (10.4.16.74)  1.886 ms  1.919 ms  1.881 ms
 2  * * 10.4.20.13 (10.4.20.13)  2.364 ms
 3  10.102.239.41 (10.102.239.41)  2.003 ms 10.102.239.109 (10.102.239.109)  2.065 ms 10.54.235.133 (10.54.235.133)  6.509 ms
 4  * 11.94.128.74 (11.94.128.74)  5.619 ms 11.94.128.26 (11.94.128.26)  3.889 ms
 5  10.102.41.122 (10.102.41.122)  26.418 ms 10.102.50.10 (10.102.50.10)  28.913 ms  28.771 ms
 6  140.205.27.149 (140.205.27.149)  29.666 ms  31.349 ms 117.49.45.109 (117.49.45.109)  25.570 ms
```

#### 9.netstat

显示网络相关信息

-t  TCP协议

-u  UDP协议

-l   监听

-r  路由

-n  显示IP地址和端口

netstat -tlun  查看本机监听的端口

```shell
root@wintrys:~# netstat -tlun
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN     
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN     
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN     
tcp6       0      0 :::80                   :::*                    LISTEN     
udp        0      0 127.0.0.1:323           0.0.0.0:*                           # udp协议没有监听状态
udp        0      0 127.0.0.53:53           0.0.0.0:*                          
udp        0      0 172.17.228.126:68       0.0.0.0:*                          
udp6       0      0 ::1:323                 :::*
```

netstat -an   查看本机所有的网络连接

```shell
root@wintrys:~# netstat -an
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN     
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN     
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN     
tcp        0      0 172.17.228.126:43938    100.100.30.26:80        ESTABLISHED    #正在连接状态
tcp        0      0 172.17.228.126:22       123.139.17.29:14562     ESTABLISHED
tcp        0      0 172.17.228.126:22       123.139.17.29:15021     ESTABLISHED
tcp        0      0 172.17.228.126:22       123.139.17.29:17057     ESTABLISHED
tcp        0      0 172.17.228.126:22       123.139.17.29:16108     ESTABLISHED
tcp        0      0 172.17.228.126:53246    100.100.45.186:80       TIME_WAIT  
tcp        0      0 172.17.228.126:43438    100.100.45.106:443      TIME_WAIT  
tcp        0      0 172.17.228.126:53242    100.100.45.186:80       TIME_WAIT  
tcp        0      0 172.17.228.126:22       123.139.17.29:16583     ESTABLISHED
tcp6       0      0 :::80                   :::*                    LISTEN  
```

#### 10.mount

mout [-t 文件系统] 设备文件名 挂载点

### 8.关机重启命令

#### 1.shutdown

-c 取消前一个关机命令

-h 关机

-r  重启

#### 2.其他关机命令

halt

poweroff

init 0

#### 3.其他重启命令

reboot

init 6

#### 4.系统运行级别

0 关机       init 0

1 单用户(只启动最小核心程序)

2  不完全多用户，不含NFS服务

3  完全多用户

4  未分配

5 图形界面

6 重启     init 6

```shell
root@wintrys:/etc# runlevel
N 5
```

#### 5.logout

退出登录命令

用完建议都要退出账号

# 5.文本编辑器Vim

### 1.Vim常用操作

功能强大的文本编辑器，新建，编辑 ，显示。

vi  filename  进入

:wq   退出

i a o 进去插入模式

ESC  命令模式

流程：vi  filename  进入-->命令模式-----(i,a,o)----->插入模式-----(ESC)----->命令模式-----(:wq)------.>退出

误操作卡住Vim 可用 Ctrl+q 退出

### 2.Vim使用技巧

:r   /file  导入命令

:map  快捷键

# 6.软件包管理

### 1.软件包分类

源码包:     开源，安装慢。

二进制包:   (RPM包，系统默认包)   不开源，安装快。

### 2.RPM命令管理

rpm -ivh  包名

-i  install

-v  显示信息

-h  显示安装过程

--nodeps   不检测依赖性    一般不用

rpm -Uvh 包全名

-U 升级

rpm -e  包名

-e  erase 卸载

--nodeps   不检测依赖性    一般不用

rpm -q  包名

-q   query 查询

-a  查询所有rpm包

#### 1.rpm包命名原则

**httpd-2.2.15-15.el6.centos.l.i686.rpm**      --->包全名

httpd  软件包名

2.2.15 软件版本

15  软件发布次数

el6.centos  适合的Linux平台

i686  适合的硬件平台

rpm rpm包扩展名

#### 2.RPM包依赖性

树形依赖:  a-->b-->c

环形依赖：a-->b-->c-->a

模块依赖：模块依赖查询网站 www.rpmfind.net

#### 3.RPM包校验

rpm -V 包名

### 3.yum在线管理

yum安装：

　　安装：yum install 名称

　　卸载：yum remove 名称

　　更新：yum update  名称

### 4.脚本安装包

 webmin 可视化界面

# 7.用户和用户组管理

  服务器对安全性要求高，需建立合理的用户权限等级制度和服务器操作规范。

### 1.用户配置文件

  Linux中主要通过用户配置文件来查看和修改用户信息

#### 1./etc/passwd 

 用户信息文件

```shell
root@wintrys:~# vim /etc/passwd

root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/usr/sbin/nologin
man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
news:x:9:9:news:/var/spool/news:/usr/sbin/nologin
uucp:x:10:10:uucp:/var/spool/uucp:/usr/sbin/nologin
proxy:x:13:13:proxy:/bin:/usr/sbin/nologin
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
backup:x:34:34:backup:/var/backups:/usr/sbin/nologin
list:x:38:38:Mailing List Manager:/var/list:/usr/sbin/nologin
irc:x:39:39:ircd:/var/run/ircd:/usr/sbin/nologin
gnats:x:41:41:Gnats Bug-Reporting System (admin):/var/lib/gnats:/usr/sbin/nologin
nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin
systemd-network:x:100:102:systemd Network Management,,,:/run/systemd:/usr/sbin/nologin
systemd-resolve:x:101:103:systemd Resolver,,,:/run/systemd:/usr/sbin/nologin
systemd-timesync:x:102:104:systemd Time Synchronization,,,:/run/systemd:/usr/sbin/nologin
messagebus:x:103:106::/nonexistent:/usr/sbin/nologin
syslog:x:104:110::/home/syslog:/usr/sbin/nologin
_apt:x:105:65534::/nonexistent:/usr/sbin/nologin
uuidd:x:106:112::/run/uuidd:/usr/sbin/nologin
tcpdump:x:107:113::/nonexistent:/usr/sbin/nologin
ntp:x:108:115::/nonexistent:/usr/sbin/nologin
sshd:x:109:65534::/run/sshd:/usr/sbin/nologin
systemd-coredump:x:999:999:systemd Core Dumper:/:/usr/sbin/nologin
_chrony:x:110:121:Chrony daemon,,,:/var/lib/chrony:/usr/sbin/nologin
liwanlin:x:1000:1000::/home/liwanlin:/bin/bash
```

第一个字段： 用户名称

第二个字段：密码标志   x只是说明他有密码 (实际密码存在了shadow)

第三个字段：UID(用户id)

​            0：超级用户     **叫root的不一定是管理员，UID=0的不管叫啥就是管理员**    想把一个用户改成管理员，可以把他uid改为0即可。

​            1-999：系统用户（伪用户）     centos  1-499

​            1000-65535： 普通用户

第四个字段：GID(用户初始组id)

​          初始组：用户一登录就立刻拥有这个组的相关权限，**每个用户必须有一个初始组且只能有一个初始组。**

​                         一般初始组组名和用户名相同，平常不建议更改。

​          附加组：指用户可以加入多个其他的用户组，并拥有这些组的权限，**附加组可以有多个。**

第五个字段：用户说明信息。可选项，可以不加。

第六个字段：家目录

​         超级用户：/root/

​         普通用户：/home/用户名/

第七个字段：登录之后的shell

​          暂时禁用用户时，可以在此操作改成usr/sbin/nologin

#### 2./etc/shadow

保存加密的密码串，在passwd里面只有密码标志X

```shell
root@wintrys:~# vi /etc/shadow

root:$6$UDJx7OJurgAffO6t$hCQBBzH9qcVdm07OYo0VouZRwOnFS9jDfx6aNV1xF5EIO6ELItQ9P0kJMVnk1wapMGI7u.OnyY9Bp4aywPt2x1:18994:0:99999:7:::
daemon:*:18375:0:99999:7:::
bin:*:18375:0:99999:7:::
sys:*:18375:0:99999:7:::
sync:*:18375:0:99999:7:::
games:*:18375:0:99999:7:::
man:*:18375:0:99999:7:::
lp:*:18375:0:99999:7:::
mail:*:18375:0:99999:7:::
news:*:18375:0:99999:7:::
uucp:*:18375:0:99999:7:::
proxy:*:18375:0:99999:7:::
www-data:*:18375:0:99999:7:::
backup:*:18375:0:99999:7:::
list:*:18375:0:99999:7:::
irc:*:18375:0:99999:7:::
gnats:*:18375:0:99999:7:::
nobody:*:18375:0:99999:7:::
systemd-network:*:18375:0:99999:7:::
systemd-resolve:*:18375:0:99999:7:::
systemd-timesync:*:18375:0:99999:7:::
messagebus:*:18375:0:99999:7:::
syslog:*:18375:0:99999:7:::
_apt:*:18375:0:99999:7:::
uuidd:*:18801:0:99999:7:::
tcpdump:*:18801:0:99999:7:::
ntp:*:18801:0:99999:7:::
sshd:*:18801:0:99999:7:::
systemd-coredump:!!:18801::::::
_chrony:*:18801:0:99999:7:::
liwanlin:$6$V3ySS0XFuR6Uioq/$P9la5DJW1RNQN2RUA1tJlrw6D3morEQzGl45zJy2gfukm00BIamacrEhwJTjEO5Fowqqk/cUcDFSuT/lmnfK..:18999:0:99999:7:::
~                                                                                                     
```

第一个字段：用户名

第二个字段：加密密码

​			加密算法升级为SHA512散列加密算法

​			如果密码位是!!或*  代表没有密码，不能登录

​            在用户密码前＋个！，可以禁用用户登录

第三个字段：密码最后一次更改时间

第四个字段：两次密码的修改间隔时间  默认是0，假如是10，就是10天之后才能改

第五个字段：密码有效期   假如参数是90   那么90天之后必须改密码

第六个字段：密码修改到期前的警告时间  7    到第83天会提醒你改密码

第七个字段：密码过期后的宽限时间     5     到95天还没改，会被封掉

​			0:表示密码过期立即失效

​			-1:表示密码永远不会失效

第八个字段：账号失效时间

​			要用时间戳表示

第九个字段：保留

