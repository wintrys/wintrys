## git 知识

**commit**    一次提交对应一个大的tree对象

**tree**          每一个文件夹就是一个tree对象

**blob**         每一个文件就是一个blob对象

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

在add新增内容后:

```shell
fores@DESKTOP-2SEHIIO MINGW64 /d/git_learning/watch_git_objects (master)
$ git add doc

fores@DESKTOP-2SEHIIO MINGW64 /d/git_learning/watch_git_objects (master)
$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

        new file:   doc/readme


fores@DESKTOP-2SEHIIO MINGW64 /d/git_learning/watch_git_objects (master)
$ find .git/objects -type f   #这个时候git把文件加入到暂存区
.git/objects/2d/832d9044c698081e59c322d5a2a459da546469

fores@DESKTOP-2SEHIIO MINGW64 /d/git_learning/watch_git_objects (master)
$ git cat-file -t 2d832d90    #其实就是个blob对象
blob

```

分离头指针操作

 git cmmit --amend     用来变更上次提交的msg

```shell

fores@DESKTOP-2SEHIIO MINGW64 /d/git_learning/watch_git_objects (master)
$ git commit -m"add"
[master c904a8c] add
 1 file changed, 1 insertion(+)

fores@DESKTOP-2SEHIIO MINGW64 /d/git_learning/watch_git_objects (master)
$ git commit --amend
[master f3f24d4] add
 Date: Sun Jan 9 17:00:46 2022 +0800
 1 file changed, 1 insertion(+)

```

git rebase

```shell
pick f3f24d4 add

# Rebase 0bdab1c..f3f24d4 onto 0bdab1c (1 command)
#
# Commands:
# p, pick <commit> = use commit
# r, reword <commit> = use commit, but edit the commit message
# e, edit <commit> = use commit, but stop for amending
# s, squash <commit> = use commit, but meld into previous commit
# f, fixup <commit> = like "squash", but discard this commit's log message
# x, exec <command> = run command (the rest of the line) using shell
# b, break = stop here (continue rebase later with 'git rebase --continue')
# d, drop <commit> = remove commit
# l, label <label> = label current HEAD with a name
# t, reset <label> = reset HEAD to a label
# m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
# .       create a merge commit using the original merge commit's
# .       message (or the oneline, if no original merge commit was
# .       specified). Use -c <commit> to reword the commit message.
#
# These lines can be re-ordered; they are executed from top to bottom.

```

