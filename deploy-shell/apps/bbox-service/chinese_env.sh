#!/bin/sh


rpm -ivh  kde-filesystem-4-47.el7.x86_64.rpm kde-l10n-4.10.5-2.el7.noarch.rpm kde-l10n-Chinese-4.10.5-2.el7.noarch.rpm


rpm -ivh  glibc-headers-2.17-222.el7.x86_64.rpm  glibc-devel-2.17-222.el7.x86_64.rpm glibc-2.17-222.el7.x86_64.rpm glibc-common-2.17-222.el7.x86_64.rpm

localedef -c -f UTF-8 -i zh_CN zh_CN.utf8 
