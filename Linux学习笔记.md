****

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

#### 3./etc/group

```shell
root@wintrys:~# vim /etc/group

root:x:0:
daemon:x:1:
bin:x:2:
sys:x:3:
adm:x:4:syslog
tty:x:5:syslog
disk:x:6:
lp:x:7:
mail:x:8:
news:x:9:
uucp:x:10:
man:x:12:
proxy:x:13:
kmem:x:15:
dialout:x:20:
fax:x:21:
voice:x:22:
cdrom:x:24:
floppy:x:25:
tape:x:26:
sudo:x:27:
audio:x:29:
dip:x:30:
www-data:x:33:
backup:x:34:
operator:x:37:
list:x:38:
irc:x:39:
src:x:40:
gnats:x:41:
shadow:x:42:
utmp:x:43:
video:x:44:
sasl:x:45:
```

第一个字段：组名   

第二个字段：组密码标志

第三个字段：GID

第四个字段：组中附加用户  (看不到初始用户)

#### 4./etc/gshadow

```shell
root@wintrys:~# vim /etc/gshadow

root:*::
daemon:*::
bin:*::
sys:*::
adm:*::syslog
tty:*::syslog
disk:*::
lp:*::
mail:*::
news:*::
uucp:*::
man:*::
proxy:*::
kmem:*::
dialout:*::
fax:*::
voice:*::
cdrom:*::
floppy:*::
tape:*::
sudo:*::
audio:*::
dip:*::
www-data:*::
backup:*::
operator:*::
list:*::
irc:*::
src:*::
gnats:*::
shadow:*::
utmp:*::
video:*::
sasl:*::
```

第一个字段：组名

第二个字段: 组密码

第三个字段：组管理员用户名

第四个字段：组中附加用户

### 2.用户管理的相关文件

#### 1./home

普通用户: /home/用户名      所有者和所属组都是此用户，权限700  $:普通用户

```shell
root@wintrys:~# ls -l /home/
total 4
drwxr-xr-x 4 liwanlin liwanlin 4096 Jan  9 23:04 liwanlin
```

超级用户：/root 所有者和所属组都是root  权限550   #：管理员

#### 2./var/spool/mail

 用户的邮箱

#### 3./etc/skel

#### 用户模板目录

```shell
root@wintrys:/etc/skel# ls -al
total 20
drwxr-xr-x  2 root root 4096 Jun 23  2021 .
drwxr-xr-x 85 root root 4096 Jan 10 13:44 ..
-rw-r--r--  1 root root  220 Feb 25  2020 .bash_logout
-rw-r--r--  1 root root 3771 Feb 25  2020 .bashrc
-rw-r--r--  1 root root  807 Feb 25  2020 .profile
```

上面为模板，创建新用户会默认把这边模板文件加到新用户目录下

```shell
root@wintrys:/home/liwanlin# ls -l 
total 0
root@wintrys:/home/liwanlin# ls -al  这些隐藏文件都是模板自动生成
total 36
drwxr-xr-x 4 liwanlin liwanlin 4096 Jan  9 23:04 .
drwxr-xr-x 3 root     root     4096 Jan  7 16:57 ..
-rw------- 1 liwanlin liwanlin   81 Jan 10 01:17 .bash_history
-rw-r--r-- 1 liwanlin liwanlin  220 Feb 25  2020 .bash_logout
-rw-r--r-- 1 liwanlin liwanlin 3771 Feb 25  2020 .bashrc
drwx------ 2 liwanlin liwanlin 4096 Jan  7 17:00 .cache
-rw-r--r-- 1 liwanlin liwanlin  807 Feb 25  2020 .profile
drwxr-xr-x 2 liwanlin liwanlin 4096 Jan  9 21:30 .rpmdb
-rw------- 1 liwanlin liwanlin  879 Jan  9 23:04 .viminfo
```

### 3.用户管理命令

#### 1.useradd

-u UID   手工指定用户UID

-d 家目录  手动指定家目录

-s  shell  手动指定用户的登录shell   默认：/bin/bash

```shell
root@wintrys:~# useradd lihuazhen -m
root@wintrys:~# cd /home/
root@wintrys:/home# ls -l
total 8
drwxr-xr-x 2 lihuazhen lihuazhen 4096 Jan 10 14:03 lihuazhen
drwxr-xr-x 4 liwanlin  liwanlin  4096 Jan  9 23:04 liwanlin
```

**ubantu添加用户要加上 -m  不然不会生成家目录**

#### 2.passwd

passwd [选项]  用户名

```shell
root@wintrys:~# passwd lihuazhen 
New password:
```

#### 3.usermod

修改用户信息

-u UID   手工指定用户UID

-d 家目录  手动指定家目录

-s  shell  手动指定用户的登录shell   默认：/bin/bash

#### 4.userdel

删除用户

-r 删除用户的同时删除用户嘉沐旅馆

```shell
root@wintrys:~# userdel -r lihuazhen 
userdel: lihuazhen mail spool (/var/mail/lihuazhen) not found
root@wintrys:~# cd /home/
root@wintrys:/home# ls
liwanlin
```

#### 5.id

查看用户UID等信息

```shell
root@wintrys:/home# id liwanlin
uid=1000(liwanlin) gid=1000(liwanlin) groups=1000(liwanlin)
```

#### 6.su

切换用户身份

su [选项] 用户名

**“-” 这个符号代表连带用户的环境变量一起切换，切用户时一定要带上**

-c 近执行一次命令，而不切换用户身份

```shell
root@wintrys:~# su - liwanlin
liwanlin@wintrys:~$ ls
```

超级用户切普通用户，不需要输入密码，反之需要。

### 4.用户组管理命令

#### 1.groupadd

添加用户组

groupadd [选项] 组名

-g  GID  指定组ID

#### 2.groupmod

修改用户组

-n 新组名

```shell
root@wintrys:~# groupadd linxia   #新增
root@wintrys:~# groupmod -n gansu linxia  #改名
```

#### 3.groupdel

删除用户组

组有初始用户就不能删除

# 8.权限管理

### 1.ACL权限

#### 1.简介与开启

解决除了ugo之外的权限管理场景

dumpe2fs -h /dev/vdal  查询分区表的详细信息，可以叨叨是否开启acl

#### 2.查看设定acl权限

getfacle 文件名 查看ack

setfacl     设定acl

### 2.sudo权限

**root把本来只有管理员用户执行的命令赋予普通用户执行**

sudo的操作对象是系统命令

```shell
root@wintrys:~# visudo

  GNU nano 4.8             /etc/sudoers.tmp                        
#
# This file MUST be edited with the 'visudo' command as root.
#
# Please consider adding local content in /etc/sudoers.d/ instead >
# directly modifying this file.
#
# See the man page for details on how to write a sudoers file.
#
Defaults        env_reset
Defaults        mail_badpass
Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/s>

# Host alias specification

# User alias specification

# Cmnd alias specification

# User privilege specification
root    ALL=(ALL:ALL) ALL

# Members of the admin group may gain root privileges
%admin ALL=(ALL) ALL

# Allow members of group sudo to execute any command
%sudo   ALL=(ALL:ALL) ALL

# See sudoers(5) for more information on "#include" directives:

#includedir /etc/sudoers.d
```

在这个配置文件栏给用户加执行权限

# 9.文件系统管理

### 1.分区和文件系统

第一讲

### 2.文件系统常用命令

#### 1.df 

统计文件系统的空间占用情况  （面向文件系统）

```shell
root@wintrys:~# df
Filesystem     1K-blocks    Used Available Use% Mounted on
udev              988136       0    988136   0% /dev
tmpfs             203516     700    202816   1% /run
/dev/vda1       41152812 5117816  34131340  14% /
tmpfs            1017568       0   1017568   0% /dev/shm
tmpfs               5120       0      5120   0% /run/lock
tmpfs            1017568       0   1017568   0% /sys/fs/cgroup
tmpfs             203512       0    203512   0% /run/user/0
tmpfs             203512       0    203512   0% /run/user/1000
```

-a  显示所有信息

-h 使用习惯单位显示容量

#### 2.du

统计目录或文件的大小  (面向文件)

```shell
root@wintrys:~# du ./zbx -h
4.0K    ./zbx/视频
35M     ./zbx/上海2021-4
1.5M    ./zbx/I012jk/合同/北京2021.1-2/北京2021-1
736K    ./zbx/I012jk/合同/北京2021.1-2/北京2021-2/沈阳德睿-209
1.3M    ./zbx/I012jk/合同/北京2021.1-2/北京2021-2/北京财税-207
13M     ./zbx/I012jk/合同/北京2021.1-2/北京2021-2
14M     ./zbx/I012jk/合同/北京2021.1-2
```

#### 3.fsck

文件修复命令

#### 4.dumpe2fs

显示磁盘状态

#### 5.mount

挂载设备

### 3.fdisk分区

待学习补充

# 10.Shell基础

### 1.shell概述

命令行解释器， 编程语言

### 2.执行方式

#### 1.echo

```shell
root@wintrys:~# echo 'hello world!'
hello world!
```

-e  支持转义字符     \b 退格键，向左删除

```shell
root@wintrys:~# echo -e 'ab\bc'    
ac
```

1.赋予执行权限，直接运行    常用此方式 

```shell
root@wintrys:~/lee# chmod 755 hello.sh 
root@wintrys:~/lee# ./hello.sh 
我的第一个shell脚本
```

2.通过bash调用执行脚本    不需要加权限

```shell
root@wintrys:~/lee# bash hello.sh 
我的第一个shell脚本
```

### 3.Bash的基本功能

#### 1.histroy

历史命令

-w 将缓存中的历史命令写入历史命令文件保存  /bash_history

-c  清空历史命令  缓存和文件里的都会被清空

2.补全

tab     两次tab出现一个list

```shell
root@wintrys:~/lee# user
useradd  userdel  usermod  users
```

#### 2alias

命令别名与快捷键

```shell
root@wintrys:~/lee# alias
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
```

#### 3.输入输出重定向

正常输出：

命令 > 文件  （覆盖）

命令 >> 文件  (追加)

错误输出要加2

命令 2> 文件  （覆盖）

命令 2>> 文件  (追加)

正常错误都会写入：

命令 &> 文件  （覆盖）

命令 &>> 文件  (追加)

文件分开写：

**命令 >>文件1 2>>文件2**

输入重定向：

wc  [选项] [文件名]

#### 4.多命令顺序执行

； 命令1；命令2    互相没有关系

```shell
root@wintrys:~/lee# ls;date;cd /kk;pwd   #其中一个报错也不影响
A  C         ip.txt   newname.conf       newname.conf.soft
B  hello.sh  lwl.txt  newname.conf.hard
Mon 10 Jan 2022 07:28:06 PM CST
-bash: cd: /kk: No such file or directory
/root/lee
```

&&  命令1&&命令2   逻辑与                             有先后关系的场景用

```shell
root@wintrys:~/lee# ls && echo yes   第一条成功则执行第二条
A  C         ip.txt   newname.conf       newname.conf.soft
B  hello.sh  lwl.txt  newname.conf.hard
yes
root@wintrys:~/lee# ls llll && echo yes 第一条失败第二条不会执行
ls: cannot access 'llll': No such file or directory
```

||   命令1||命令2     逻辑或

```shell
root@wintrys:~/lee# ls || echo yes      成功则退出
A  C         ip.txt   newname.conf       newname.conf.soft
B  hello.sh  lwl.txt  newname.conf.hard
root@wintrys:~/lee# ls llll || echo yes  
ls: cannot access 'llll': No such file or directory
yes
```

#### 5.管道符

命令1 |  命令2

**命令1的正确输出作为命令2的操作对象**

```shell
root@wintrys:~/lee# netstat -an |grep 'ESTABLISHED'
tcp        0      0 172.17.228.126:43938    100.100.30.26:80        ESTABLISHED
tcp        0     52 172.17.228.126:22       123.139.18.226:27578    ESTABLISHED
```

如果命令1没有输出，或者报错，命令2就不会执行

6.通配符和其他符号

```shell
root@wintrys:~/lee# ls -l *.txt
-rw-r--r-- 1 root root 32 Jan 10 18:35 ip.txt
-rwxrw-r-- 1 root root 97 Jan  6 19:57 lwl.txt
```

### 4.Bash的变量

查看系统里的所有变量用 set命令

删除变量用 unset 变量名

#### 1.自定义变量

**只在当前shell中生效**，默认都是字符串类型，如果要进行数值运算，则必须指定变量类型为数值型

**变量用“=”链接，左右两侧不能加空格**

```shell
root@wintrys:~/lee# name=lihuazhen
root@wintrys:~/lee# echo $name  
lihuazhen
```

如果把命令的结果赋给变量，则需使用$()

```shell
root@wintrys:~/lee# time=$(date)
root@wintrys:~/lee# echo time    打印变量要加$
time
root@wintrys:~/lee# echo $time
Mon 10 Jan 2022 08:01:24 PM CST
```

变量叠加

```shell
root@wintrys:~/lee# aa=123
root@wintrys:~/lee# aa="$aa"456     第一种
root@wintrys:~/lee# echo $aa
123456
root@wintrys:~/lee# aa=${aa}789     第二种
root@wintrys:~/lee# echo $aa   
123456789
```

#### 2.环境变量

**在当前shell和这个shell的所有子shell当中生效。如果把环境变量写入相应的配置文件，那么就会在所有的shell生效**。

申明： **export 变量名=变量值**

查询：env

```shell
root@wintrys:~/lee# env
SHELL=/bin/bash
PWD=/root/lee
LOGNAME=root
XDG_SESSION_TYPE=tty
MOTD_SHOWN=pam
HOME=/root
LANG=en_US.UTF-8
OLDPWD=/root
```

删除：unset

#### 3.位置参数变量

$n ：n为数字，$0代表本身 1-9 第一道第九个参数。

$*：命令行中代表所有参数   循环遍历只执行一次    理解为一个字符串

$@：区别对待     循环遍历会执行多次      理解为数组

$#：参数个数

```shell
root@wintrys:~/lee# vim hello.sh 

#!/bin/bash
# liwanlin
echo "我的第一个shell脚本"
echo $0
echo $1
echo $2
echo $*   
echo $@
echo $#


root@wintrys:~/lee# chmod 777 hello.sh 
root@wintrys:~/lee# ./hello.sh "可乐" “橙汁”
我的第一个shell脚本
./hello.sh
可乐
“橙汁”
可乐 “橙汁” 
可乐 “橙汁”
2
```

#### 4.预定义变量

$?：命令执行的返回状态，值为0表示执行成功，反之是失败

```shell
root@wintrys:~/lee# echo $?
0
root@wintrys:~/lee# ls kkl
ls: cannot access 'kkl': No such file or directory
root@wintrys:~/lee# echo $?
2
root@wintrys:~/lee# lssss
lssss: command not found
root@wintrys:~/lee# echo $?
127
```

$$：当前进程的进程号(PID)

```shell
root@wintrys:~/lee# vim hello.sh            

#!/bin/bash
# liwanlin
echo "我的第一个shell脚本"
echo $$

root@wintrys:~/lee# ./hello.sh "可乐" “橙汁”
我的第一个shell脚本
24587
```

$!：最后一个进程号

接受键盘输入

**read [选项] [变量名]**

-p  提示信息

-t 等待时间

-n  限制字符大小

-s 隐藏输入的数据

```shell
root@wintrys:~/lee# vim canshu.sh

#!/bin/bash
read -t 30 -p "请输入名字：" name
echo $name


root@wintrys:~/lee# chmod 777 canshu.sh 
root@wintrys:~/lee# ./canshu.sh 
请输入名字：liwanlin
liwanlin
```

### 5.Bash的运算符

#### **1.declare**

声明变量类型

```shell
root@wintrys:~/lee# a=11
root@wintrys:~/lee# b=22
root@wintrys:~/lee# c=$a+$b
root@wintrys:~/lee# echo $c   #默认是字符串类型，直接相加就就是字符串拼接
11+22
root@wintrys:~/lee# declare -i cc=$a+$b
root@wintrys:~/lee# echo $cc
33
```

#### 2.express (let)

```shell
root@wintrys:~/lee# a=11
root@wintrys:~/lee# b=22
root@wintrys:~/lee# c=$a+$b
root@wintrys:~/lee# echo $c
11+22
root@wintrys:~/lee# dd=$(expr $a + $b)  # 加号两边必须有空格
root@wintrys:~/lee# echo $dd
33
```

#### 3.$((运算式))  

脚本里常用

```shell
root@wintrys:~/lee# ff=$(($a+$b))
root@wintrys:~/lee# echo $ff
33

root@wintrys:~/lee# gg=$[$a+$b]  #这种方式也可以
root@wintrys:~/lee# echo $gg
33
```

### 6.环境变量配置文件

source 配置文件

issue 配置文件   欢迎界面

```shell
root@wintrys:~# cat /etc/issue
Ubuntu 20.04.2 LTS \n \l
```

# 11.Shell编程

### 1.正则表达式

**正则表达式用来匹配文件内容   grep awk sed**

```shell
root@wintrys:~/lee# grep 'better' python_chan.txt 
Beautiful is better than ugly.
Explicit is better than implicit.
Simple is better than complex.
Complex is better than complicated.
Flat is better than nested.
Sparse is better than dense.
Now is better than never.
Although never is often better than *right* now.
root@wintrys:~/lee#

root@wintrys:~/lee# grep '^S' python_chan.txt   以S开头的行   
Simple is better than complex.
Sparse is better than dense.
Special cases aren't special enough to break the rules.
```

包含匹配

**通配符用来匹配文件名    ls find cp**

```shell
root@wintrys:~# cd lee/
root@wintrys:~/lee# ls -l *.sh
-rwxrwxrwx 1 root root  63 Jan 10 23:18 canshu.sh
-rwxrwxrwx 1 root root 113 Jan 10 23:08 hello.sh
```

完全匹配

?  *   []

### 2.字符截取命令

#### 1.cut

提取符合条件的列 ，grep是提取行

-f 列号

-d 分割符号            有空格是不能使用

```shell
root@wintrys:~/lee# cut -d ":" -f 1,3 /etc/passwd 
root:0
daemon:1
bin:2
sys:3
sync:4
games:5
man:6
lp:7
mail:8
news:9
```

与grep配合使用

```shell
root@wintrys:~# cat /etc/passwd | grep /bin/bash | cut -d ":" -f 1
root
liwanlin
```

#### 2.printf

格式化输出

```shell
root@wintrys:~# printf 1234
1234root@wintrys:~# printf %s 1234
1234root@wintrys:~# printf %s %s %s 1234
%s%s1234root@wintrys:~# printf '%s %s %s' 1234  #必须加单引号才能生效
1234  root@wintrys:~# printf '%s %s %s' 1 2 34
1 2 34root@wintrys:~# printf '%s %s %s' 1234  
1234  root@wintrys:~# printf '%s %s %s' 1 2 3 4 5 6
1 2 34 5 6root@wintrys:~# printf '%s %s %s\n' 1 2 3 4 5 6
1 2 3
4 5 6
```

#### 3.awk

用来列截取数据

awk '条件1 {动作1} 条件2 {动作2}' 文件名

printf 要手动表换行符

print 自动加换行符

```shell
root@wintrys:~# df -h
Filesystem      Size  Used Avail Use% Mounted on
udev            965M     0  965M   0% /dev
tmpfs           199M  668K  199M   1% /run
/dev/vda1        40G  4.9G   33G  14% /
tmpfs           994M     0  994M   0% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           994M     0  994M   0% /sys/fs/cgroup
tmpfs           199M     0  199M   0% /run/user/0
root@wintrys:~# df -h | awk '{print $1 "\t" $5 "\t" $6}'
Filesystem      Use%    Mounted
udev    0%      /dev
tmpfs   1%      /run
/dev/vda1       14%     /
tmpfs   0%      /dev/shm
tmpfs   0%      /run/lock
tmpfs   0%      /sys/fs/cgroup
tmpfs   0%      /run/user/0
```

  某个盘符的剩余空间

```shell
root@wintrys:~# df -h | grep /dev/vda1
/dev/vda1        40G  4.9G   33G  14% /
root@wintrys:~# df -h | grep /dev/vda1 | awk '{print $5}'
14%
root@wintrys:~# df -h | grep /dev/vda1 | awk '{print $5}' | cut -d '%'
cut: you must specify a list of bytes, characters, or fields
Try 'cut --help' for more information.
root@wintrys:~# df -h | grep /dev/vda1 | awk '{print $5}' | cut -d '%' -f 1
14
```

BENGIN  : 在所有数据读取之前执行

END：在所有数据读取之后执行

```shell
root@wintrys:~# df -h | grep /dev/vda1 | awk 'BEGIN{print "this is begin"}{print $1 "\t" $5}END{print "this is end"}'
this is begin
/dev/vda1       14%
this is end
```

#### 4.sed

轻量级流编辑器，用来将数据进行选取，替换，删除，新增的命令

sed [选项] ‘[动作]’ 文件名

-n 输出到屏幕

-e：允许多天命令编辑

-i：修改结果直接修改读取数据的文件

动作：

a\：追加

c\：替换

i\：插入

d:删除

p：

s:

### 3.字符处理命令

#### 1.sort

```shell
root@wintrys:~# sort /etc/passwd   按字母排
_apt:x:105:65534::/nonexistent:/usr/sbin/nologin
backup:x:34:34:backup:/var/backups:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
_chrony:x:110:121:Chrony daemon,,,:/var/lib/chrony:/usr/sbin/nologin
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
games:x:5:60:games:/usr/games:/usr/sbin/nologinshe
```

-r 取反

```shell
root@wintrys:~# sort -r /etc/passwd
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
uuidd:x:106:112::/run/uuidd:/usr/sbin/nologin
uucp:x:10:10:uucp:/var/spool/uucp:/usr/sbin/nologin
tcpdump:x:107:113::/nonexistent:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
systemd-timesync:x:102:104:systemd Time Synchronization,,,:/run/systemd:/usr/sbin/nologin
```

#### 2.wc

wc [选项] 文件名

-l: 只统计行数

-w: 只统计单词数

-m:只统计字符数

```shell
root@wintrys:~# wc /etc//passwd
  31   44 1653 /etc//passwd       统计该文件有31行，44个单词  1653个字符
```

### 4.条件判断

#### 1.判断文件是否存在

-e  是否存在

-f  是否为普通文件

```shell
root@wintrys:~# test -e /root/instal.log    第一种
root@wintrys:~# echo $?                    前面学过$?  返后0表示存在，非0不存在
1

root@wintrys:~# [ -e /root/lee/canshu.sh ]   第二种
root@wintrys:~# echo $?
0
```

#### 2.判断文件权限

-r 是否有读权限

-w 是否有写权限

-r  是否有执行权限

```shell
root@wintrys:~# [ -w /root/lee/canshu.sh ] && echo yes ||echo no    不能识别具体身份权限
yes
```

#### 3.判断两文件关系

文件1 -nt 文件2   ：1的修改时间是否比2新

文件1 -ot 文件2   ：1的修改时间是否比2旧

文件1 -ef 文件2   ：1的inode号跟2时候一致，意思是否为同一个文件

#### 4.判断整数之间关系

-eq :相等

-ne:不相等

-gt：大于

-lt：小于

-ge：大于等于

-le:小于等于

```shell
root@wintrys:~# [ 23 -eq 23 ] && echo yes ||echo no
yes
```

#### 5.判断字符串

-z 字符串是否为空

-n 是否非空

==  相等

!= 不相等

```shell
root@wintrys:~# name=liwanlin
root@wintrys:~# [ -z "$name" ] && echo yes ||echo no  
no
root@wintrys:~# [ -z "$age" ] && echo yes ||echo no    
yes


root@wintrys:~# [ lee == lee ] && echo yes ||echo no       
yes
```

6.判断多重条件

判断1 -a  判断2   逻辑与 都T，则T

判断1 -o  判断2   逻辑或 有一个T，则T

！判断  逻辑非  原始判断取反

### 5.流程控制

#### 1.单分支if

if [ 条件 ] ；then

   满足条件执行的代码

fi

或者

if [ 条件 ]

  then

​       满足条件执行的代码

fi

注意点：

**1.if语句及时fi结尾**

**2.[条件] 使用test命令判断，所以中括号与条件式之间要有空格**

**3.then后跟符合条件的代码，放在[]后面要加“；”,也可以换行，就不需要加“；”了**

```shell
#!/bin/bash
#统计根分区使用率

rate=$(df -h | grep '/dev/vda1' |awk '{print $5}' | cut -d "%" -f 1
)

if [ $rate -ge 80 ]
   then
           echo "Warning! /dev/vda1 is full!"
fi
```



#### 2.双分支if

if [ 条件 ]

  then

​       满足条件执行的代码

  else

​    不满足条件执行的代码

fi

```shell
#!/bin/bash
date=$(date +%y%m%d)
size=$(du -sh /etc)

if [ -d /temp/dbback ]
        then
                echo "Date is:$date" > /tmp/dbback/db.txt
                echo "Size is:$size" >> /tmp/dbback/db.txt
                cd /tmp/dbback
                tar -zcf etc_$date.tar.gz /etc db.txt &>/dev/null
                rm -rf /tmp/dbback/db.txt
        else
                mkdir /tmp/dbback
                echo "Date is:$date" > /tmp/dbback/db.txt
                echo "Size is:$size" >> /tmp/dbback/db.txt                                      
                cd /tmp/dbback                                  
                tar -zcf etc_$date.tar.gz /etc db.txt &>/dev/nll 
                rm -rf /tmp/dbback/db.txt
fi             
```

执行结果：

```shell
root@wintrys:~/lee# chmod 777 if_xuexi2.sh 
root@wintrys:~/lee# ./if_xuexi2.sh 
root@wintrys:~/lee# cd /tmp/
root@wintrys:/tmp# ls
AliyunAssistClientSingleLock.lock  systemd-private-9d6b3901efbd46329b25d7d1e7c6e854-chrony.service-ROcSSh
CmsGoAgent.pid                     systemd-private-9d6b3901efbd46329b25d7d1e7c6e854-systemd-logind.service-jAYy2g
dbback                             systemd-private-9d6b3901efbd46329b25d7d1e7c6e854-systemd-resolved.service-ODCJqh
root@wintrys:/tmp# cd dbback/
root@wintrys:/tmp/dbback# ls
etc_220112.tar.gz
```

3.多分支if

if [ 条件 ]

  then

​       满足条件执行的代码

elif [ 条件 ]

   then

​        满足条件执行的代码

  else

​    不满足条件执行的代码

fi

#### 3.流程控制-case

case $变量名 in

  “值1”）

​       执行符合条件代码

​       ;;

“值2”）

​       执行符合条件代码

​       ;;

esac

注意：

**1.case开头  esac结尾**

**2.条件之间用 ;;隔开**

```shell
#!/bin/bash
  
echo 'you want to shanghai please input "1"'
echo 'you want to beijing please input "2"'
echo 'you want to xian please input "3"'

read  -t 30 -p "please input your choose: " cho

case "$cho" in
        "1")
                echo "你想去上海！"
                ;;
        "2")
                echo "你想去北京！"
                ;;
        "3")
                echo "你想去西安！"
                ;;
        *)
                echo "你想上天吗？"
                ;;
esac
```

打印

```shell
root@wintrys:~/lee# ./case_xuexi.sh  
you want to shanghai please input "1"
you want to beijing please input "2"
you want to xian please input "3"
please input your choose: 3
你想去西安！
root@wintrys:~/lee# ./case_xuexi.sh 
you want to shanghai please input "1"
you want to beijing please input "2"
you want to xian please input "3"
please input your choose: 4
你想上天吗？
```

#### 4.for循环

1.for  变量 in 值1 值2 值3  ...

​     do

​           执行代码

​    done

```shell
#!/bin/bash
#打印时间

for i in 1 2 3 4 5
        do
                echo $i
        done
        
        
root@wintrys:~/lee# chmod 755 for_xuexi.sh 
root@wintrys:~/lee# ./for_xuexi.sh 
1
2
3
4
5
```

2.for ((初始值;循环控制条件;变量变化))

​	do

​			要执行的代码

​	done

```shell
#!/bin/bash
#求100内的和

s=0

for (( i=1;i<=100;i=i+1))
        do
                s=$(( $s+$i ))    # 数值运算要用(())括起来。前面学过
        done
echo $s


root@wintrys:~/lee# ./for_xuexi2.sh  
5050
```

#### 5.while循环

只要满足条件就执行

while [ 条件 ]

​	do

​		要执行的代码

​	done

#### 6.until循环

只要不满足条件就执行

until [ 条件 ]

​	do

​		要执行的代码

​	done

# 12.服务管理

### 1.服务的分类

RPM包默认安装的服务

​		独立的服务

​		j基于xinetd服务

源码包安装的服务

### 2.独立服务管理

service 独立服务名 start|stop|restart|status

# 13.进程管理

进程是正在执行的一个程序或者命令，每一个进程都是一个运行的实体，都有自己的地址空间，并占用一定的系统资源

### 1.进程查看

ps aux  用BSD标准命令格式  常用此命令

```shell
root@wintrys:~# ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.5 167228 11028 ?        Ss   Jan02   0:07 /sbin/init noibrs
root           2  0.0  0.0      0     0 ?        S    Jan02   0:00 [kthreadd]
root           3  0.0  0.0      0     0 ?        I<   Jan02   0:00 [rcu_gp]
root           4  0.0  0.0      0     0 ?        I<   Jan02   0:00 [rcu_par_gp]
root           6  0.0  0.0      0     0 ?        I<   Jan02   0:00 [kworker/0:0H-kblockd]
root           9  0.0  0.0      0     0 ?        I<   Jan02   0:00 [mm_percpu_wq]
root          10  0.0  0.0      0     0 ?        S    Jan02   0:10 [ksoftirqd/0]
```

UESR：由那个用户产生

PID：进程的id号                           pid=1的是一个init进程 系统调用的第一个进程。是所有进程的父进程

TTY：终端类型        (tty本地终端   pts虚拟终端)

STAT：进程状态   S 睡眠   R 运行   s 包含子进程 

START：进程启动时间

ps -le   用linux标准命令格式  不常用

```shell
root@wintrys:~# ps -le
F S   UID     PID    PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
4 S     0       1       0  0  80   0 - 41807 ep_pol ?        00:00:07 systemd
1 S     0       2       0  0  80   0 -     0 kthrea ?        00:00:00 kthreadd
1 I     0       3       2  0  60 -20 -     0 rescue ?        00:00:00 rcu_gp
1 I     0       4       2  0  60 -20 -     0 rescue ?        00:00:00 rcu_par_gp
1 I     0       6       2  0  60 -20 -     0 worker ?        00:00:00 kworker/0:0H-kblockd
1 I     0       9       2  0  60 -20 -     0 rescue ?        00:00:00 mm_percpu_wq
```

top 进程健康状态

```shell
root@wintrys:~# top

top - 17:58:12 up 10 days,  4:33,  2 users,  load average: 0.05, 0.01, 0.00
Tasks:  83 total,   2 running,  81 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.3 us,  1.4 sy,  0.0 ni, 98.3 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :   1987.4 total,   1052.7 free,    121.1 used,    813.6 buff/cache
MiB Swap:      0.0 total,      0.0 free,      0.0 used.   1682.8 avail Mem 

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND                                                           
    695 root      10 -10  112748  22116  15744 S   1.7   1.1 252:50.43 AliYunDun                                                         
    575 root      20   0  756800  19484  11424 S   0.3   1.0  22:40.51 exe                                                               
    938 root      10 -10  424028   6316   5844 S   0.3   0.3   6:33.89 AliSecGuard                                                       
      1 root      20   0  167228  11028   8156 S   0.0   0.5   0:07.17 systemd                                                           
      2 root      20   0       0      0      0 S   0.0   0.0   0:00.02 kthreadd                                                          
      3 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_gp                                                            
      4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_par_gp                                                        
      6 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker/0:0H-kblockd                                              
      9 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 mm_percpu_w
```

top : 系统当前时间  系统运行时长  当前登录用户数量 系统负载

Tasks： 总数      zomie 僵尸进程   正在终止状态，如果长期不为0，则需手动操作

CPU：cpu使用情况

pstree

```shell
root@wintrys:~# pstree
systemd─┬─AliSecGuard───6*[{AliSecGuard}]   #6*意思这个下面有6个子进程
        ├─AliYunDun───23*[{AliYunDun}]
        ├─AliYunDunUpdate───5*[{AliYunDunUpdate}]
        ├─CmsGoAgent.linu─┬─exe───14*[{exe}]
        │                 └─5*[{CmsGoAgent.linu}]
        ├─accounts-daemon───2*[{accounts-daemon}]
        ├─2*[agetty]
        ├─aliyun-service───7*[{aliyun-service}]
        ├─assist_daemon───7*[{assist_daemon}]
        ├─atd
        ├─chronyd───chronyd
        ├─cron
        ├─dbus-daemon
        ├─networkd-dispat
        ├─nginx───nginx
        ├─rsyslogd───3*[{rsyslogd}]
        ├─sshd─┬─sshd───bash
        │      └─sshd───bash───pstree
        ├─systemd───(sd-pam)
        ├─systemd-journal
        ├─systemd-logind
        ├─systemd-network
        ├─systemd-resolve
        └─systemd-udevd
```

### 2.进程终止

#### 1.kill

kill  信号值   PID     **一定跟的pid**

```shell
root@wintrys:~# kill -l    #查看常用信号
 1) SIGHUP       2) SIGINT       3) SIGQUIT      4) SIGILL       5) SIGTRAP
 6) SIGABRT      7) SIGBUS       8) SIGFPE       9) SIGKILL     10) SIGUSR1
11) SIGSEGV     12) SIGUSR2     13) SIGPIPE     14) SIGALRM     15) SIGTERM
16) SIGSTKFLT   17) SIGCHLD     18) SIGCONT     19) SIGSTOP     20) SIGTSTP
21) SIGTTIN     22) SIGTTOU     23) SIGURG      24) SIGXCPU     25) SIGXFSZ
26) SIGVTALRM   27) SIGPROF     28) SIGWINCH    29) SIGIO       30) SIGPWR
31) SIGSYS      34) SIGRTMIN    35) SIGRTMIN+1  36) SIGRTMIN+2  37) SIGRTMIN+3
38) SIGRTMIN+4  39) SIGRTMIN+5  40) SIGRTMIN+6  41) SIGRTMIN+7  42) SIGRTMIN+8
43) SIGRTMIN+9  44) SIGRTMIN+10 45) SIGRTMIN+11 46) SIGRTMIN+12 47) SIGRTMIN+13
48) SIGRTMIN+14 49) SIGRTMIN+15 50) SIGRTMAX-14 51) SIGRTMAX-13 52) SIGRTMAX-12
53) SIGRTMAX-11 54) SIGRTMAX-10 55) SIGRTMAX-9  56) SIGRTMAX-8  57) SIGRTMAX-7
58) SIGRTMAX-6  59) SIGRTMAX-5  60) SIGRTMAX-4  61) SIGRTMAX-3  62) SIGRTMAX-2
63) SIGRTMAX-1  64) SIGRTMAX
```

1：关闭，重新读取配置文件后重启

9：强制终止

15：正常终止进程

kill -1  233    重启进程

kill -9   233   强制终止进程

#### 2.killall

killall -9  nginx    **跟的进程名**

#### 3.pkill

跟killall一样用法

-t   **可以根据终端号踢用户**

```shell
root@wintrys:~# w
 18:37:24 up 10 days,  5:12,  3 users,  load average: 0.03, 0.02, 0.00
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
root     pts/0    123.139.18.226   12:24    2:28m  0.25s  0.25s -bash
root     pts/1    123.139.22.147   18:05    1.00s  0.04s  0.00s w
liwanlin pts/2    123.139.22.147   18:37    5.00s  0.02s  0.02s -bash
root@wintrys:~# pkill -9 -t pts/2
```

# 14.资源查看

#### 1.vmstat

vmastat  [刷新延时 刷新次数]

```shell
root@wintrys:~# vmstat 1 3    刷3此，每次间隔1s
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 2  0      0 1070692 260452 574800    0    0     1     4   29   29  1  1 98  0  0
 0  0      0 1070684 260452 574800    0    0     0     0 1357 3043  1  2 97  0  0
 0  0      0 1070684 260452 574800    0    0     0     0 1365 3054  1  2 97  0  0
```

#### 2.dmesg

开机时内核检查信息

```shell
root@wintrys:~# dmesg | grep CPU
[    0.016744] smpboot: Allowing 2 CPUs, 1 hotplug CPUs
[    0.016787] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.025569] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.042969] rcu:     RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=2.
[    0.045642] random: crng done (trusting CPU's manufacturer)
[    0.049871] TAA: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.049871] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.053282] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2682 v4 @ 2.50GHz (family: 0x6, model: 0x4f, stepping: 0x1)
[    0.053282] Performance Events: unsupported p6 CPU model 79 no PMU driver, software events only.
[    0.053282] smp: Bringing up secondary CPUs ...
[    0.053282] smp: Brought up 1 node, 1 CPU
[    0.521015] intel_pstate: CPU model not supported
[    0.521026] ledtrig-cpu: registered to indicate activity on CPUs
```

#### 3.free

查看内存使用状态

-m 换算成M单位

-g       g

-k   同理

-b    同理

```shell
root@wintrys:~# free
              total        used        free      shared  buff/cache   available
Mem:        2035140      129336     1070384        2228      835420     1717524
```

#### 4.uptime

系统启动时间，平均负载

```shell
root@wintrys:~# uptime
 20:01:06 up 10 days,  6:36,  2 users,  load average: 0.00, 0.00, 0.00
```

#### 5.uname

-a 所有信息

-r  内核版本

-s  内核名称

```shell
root@wintrys:~# uname -a
Linux wintrys 5.4.0-77-generic #86-Ubuntu SMP Thu Jun 17 02:35:03 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
root@wintrys:~# uname -r
5.4.0-77-generic
root@wintrys:~# uname -s
Linux
```

#### 6.lsof

查看进程调用或打开了那些文件

# 15.定时任务

1.crond服务

用来做定时任务的服务

```shell
root@wintrys:~# ps aux | grep crond
root       28269  0.0  0.0   9032   732 pts/1    S+   20:12   0:00 grep --color=auto crond
```

crontab [选项]

-e 编辑

-l 查询

-r  删除

```shell
root@wintrys:~# crontab -e
no crontab for root - using an empty one

Select an editor.  To change later, run 'select-editor'.
  1. /bin/nano        <---- easiest
  2. /usr/bin/vim.basic
  3. /usr/bin/vim.tiny
  4. /bin/ed

Choose 1-4 [1]: 2

# Edit this file to introduce tasks to be run by cron.
# 
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
# 
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
# 
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
# 
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
# 
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
# 
# For more information see the manual pages of crontab(5) and cron(8)
# 
# m h  dom mon dow   command

* * * * * echo llll >> /tmp/test    每隔一分钟执行一次
第一个*：min  0-59
第二个*：h     0-23
第三个*：d    1-31
第四个*：m    1-12
第五个*：w    0-7 (0和7都代表星期天)
                                                                                                                                     
"crontab.o2O1xk/crontab" 25L, 923C written
crontab: installing new crontab
root@wintrys:~# date
Wed 12 Jan 2022 08:28:36 PM CST
root@wintrys:~# cat /tmp/test 
llll
```

删除定时任务

```shell
root@wintrys:~# crontab -r
root@wintrys:~# crontab -l
no crontab for root
```

# 16.日志管理

 /var/log  系统的日志保存在这里

#### 1.rsyslogd

```shell
root@wintrys:~# ps aux | grep rsyslogd
syslog       481  0.0  0.2 224348  5072 ?        Ssl  Jan02   0:01 /usr/sbin/rsyslogd -n -iNONE
root       28365  0.0  0.0   9032   728 pts/1    S+   20:45   0:00 grep --color=auto rsyslogd
```

日志格式：

```shell
root@wintrys:~# cat /var/log/auth.log | grep liwanlin
Jan  9 00:06:47 wintrys sshd[19660]: pam_unix(sshd:session): session closed for user liwanlin
Jan  9 00:11:58 wintrys sshd[19814]: pam_unix(sshd:session): session closed for user liwanlin
Jan  9 00:35:39 wintrys sshd[20107]: pam_unix(sshd:session): session closed for user liwanlin
Jan  9 21:05:50 wintrys sshd[21803]: Accepted password for liwanlin from 123.139.17.29 port 16345 ssh2
Jan  9 21:05:50 wintrys sshd[21803]: pam_unix(sshd:session): session opened for user liwanlin by (uid=0)
Jan  9 21:05:50 wintrys systemd-logind[510]: New session 1346 of user liwanlin.
Jan  9 21:05:50 wintrys systemd: pam_unix(systemd-user:session): session opened for user liwanlin by (uid=0)
Jan  9 21:06:09 wintrys sshd[21803]: pam_unix(sshd:session): session closed for user liwanlin
Jan  9 21:06:14 wintrys sshd[21865]: Accepted password for liwanlin from 123.139.17.29 port 16350 ssh2
Jan  9 21:06:14 wintrys sshd[21865]: pam_unix(sshd:session): session opened for user liwanlin by (uid=0)
Jan  9 21:06:14 wintrys systemd-logind[510]: New session 1348 of user liwanlin.
Jan  9 21:30:08 wintrys sshd[21984]: Accepted password for liwanlin from 123.139.17.29 port 13596 ssh2
Jan  9 21:30:08 wintrys sshd[21984]: pam_unix(sshd:session): session opened for user liwanlin by (uid=0)
```

2.rsyslogd配置

```shell
root@wintrys:~# cat /etc/rsyslog.conf 
# /etc/rsyslog.conf configuration file for rsyslog
#
# For more information install rsyslog-doc and see
# /usr/share/doc/rsyslog-doc/html/configuration/index.html
#
# Default logging rules can be found in /etc/rsyslog.d/50-default.conf


#################
#### MODULES ####
#################

module(load="imuxsock") # provides support for local system logging
#module(load="immark")  # provides --MARK-- message capability

# provides UDP syslog reception
#module(load="imudp")
#input(type="imudp" port="514")

# provides TCP syslog reception
#module(load="imtcp")
#input(type="imtcp" port="514")

# provides kernel logging support and enable non-kernel klog messages
module(load="imklog" permitnonkernelfacility="on")

###########################
#### GLOBAL DIRECTIVES ####
###########################

#
# Use traditional timestamp format.
# To enable high precision timestamps, comment out the following line.
#
$ActionFileDefaultTemplate RSYSLOG_TraditionalFileFormat

# Filter duplicated messages
$RepeatedMsgReduction on

#
# Set the default permissions for all log files.
#
$FileOwner syslog
$FileGroup adm
$FileCreateMode 0640
$DirCreateMode 0755
$Umask 0022
$PrivDropToUser syslog
$PrivDropToGroup syslog

#
# Where to place spool and state files
#
$WorkDirectory /var/spool/rsyslog

#
# Include all config files in /etc/rsyslog.d/
#
$IncludeConfig /etc/rsyslog.d/*.conf
```

# 17.启动管理

查看运行级别

```shell
root@wintrys:~# runlevel 
N 5
```

init 0  关机 

init 6  重启

```shell
root@wintrys:~# vim /boot/grub/grub.cfg 

#
# DO NOT EDIT THIS FILE
#
# It is automatically generated by grub-mkconfig using templates
# from /etc/grub.d and settings from /etc/default/grub
#

### BEGIN /etc/grub.d/00_header ###
if [ -s $prefix/grubenv ]; then
  set have_grubenv=true
  load_env
fi
if [ "${initrdfail}" = 2 ]; then
   set initrdfail=
elif [ "${initrdfail}" = 1 ]; then
   set next_entry="${prev_entry}"
   set prev_entry=
   save_env prev_entry
   if [ "${next_entry}" ]; then
      set initrdfail=2
   fi
fi
if [ "${next_entry}" ] ; then
   set default="${next_entry}"
   set next_entry=
   save_env next_entry
   set boot_once=true
else
   set default="0"
fi

if [ x"${feature_menuentry_id}" = xy ]; then
  menuentry_id_option="--id"
else
"/boot/grub/grub.cfg" [readonly] 268L, 8624C 
```

# 18.备份与恢复

### 1.备份策略

完全备份

增量备份  dump

### 2.dump

dump [选项] 备份之后的文件名  源文件或目录

-level：备份级别 0-9    0是完全备份 1-9增量备份

-f  指定文件名

### 3.restore

恢复命令