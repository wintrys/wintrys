## git 知识

**commit**

**tree**

**blob**

三个对象是git的核心

```shell
fores@DESKTOP-2SEHIIO MINGW64 /d/git_learning
$ git init watch_git_objects
Initialized empty Git repository in D:/git_learning/watch_git_objects/.git/

fores@DESKTOP-2SEHIIO MINGW64 /d/git_learning
$ cd watch_git_objects/

fores@DESKTOP-2SEHIIO MINGW64 /d/git_learning/watch_git_objects (master)
$ ls -al
total 4
drwxr-xr-x 1 fores 197609 0 1月   9 15:42 ./
drwxr-xr-x 1 fores 197609 0 1月   9 15:42 ../
drwxr-xr-x 1 fores 197609 0 1月   9 15:42 .git/

fores@DESKTOP-2SEHIIO MINGW64 /d/git_learning/watch_git_objects (master)
$ mkdir doc    #只建文件夹

fores@DESKTOP-2SEHIIO MINGW64 /d/git_learning/watch_git_objects (master)
$ git status
On branch master    #git 不理空文件夹

No commits yet

nothing to commit (create/copy files and use "git add" to track)

fores@DESKTOP-2SEHIIO MINGW64 /d/git_learning/watch_git_objects (master)
$ cd doc/

fores@DESKTOP-2SEHIIO MINGW64 /d/git_learning/watch_git_objects/doc (master)
$ echo "hello,world" >readme    #创建个文件

fores@DESKTOP-2SEHIIO MINGW64 /d/git_learning/watch_git_objects/doc (master)
$ cd ..

fores@DESKTOP-2SEHIIO MINGW64 /d/git_learning/watch_git_objects (master)
$ git status
On branch master

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)  # 有文件时，会识别出来

        doc/

nothing added to commit but untracked files present (use "git add" to track)
```

