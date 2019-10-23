Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94F47E1FAE
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 17:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406902AbfJWPo2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 11:44:28 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:57685 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406900AbfJWPo2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 11:44:28 -0400
Received: from [192.168.1.13] ([86.201.28.196])
        by mwinf5d42 with ME
        id H3kR210024DsWEm033kRH4; Wed, 23 Oct 2019 17:44:25 +0200
X-ME-Helo: [192.168.1.13]
X-ME-Auth: bm9ibGV0X2p1bGllbkBvcmFuZ2UuZnI=
X-ME-Date: Wed, 23 Oct 2019 17:44:25 +0200
X-ME-IP: 86.201.28.196
Subject: Re: [PATCH] btrfs-progs: build: add missing symbols to libbtrfs - new
 patch
From:   Julien_N <noblet_julien@orange.fr>
To:     linux-btrfs@vger.kernel.org
References: <3c3f25e4-7f36-b1f3-0e82-9745e0eb84cb@orange.fr>
Autocrypt: addr=noblet_julien@orange.fr; keydata=
 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 vriT
Message-ID: <41f818a8-a359-a21a-6490-94ce1cbfe16a@orange.fr>
Date:   Wed, 23 Oct 2019 17:44:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <3c3f25e4-7f36-b1f3-0e82-9745e0eb84cb@orange.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

After testing with ldd tool, there is some other stuff to add:

(please apply those 2 patchs)

---
 Makefile | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 616d469a..edab7fff 100644
--- a/Makefile
+++ b/Makefile
@@ -149,19 +149,17 @@ cmds_objects = cmds/subvolume.o cmds/filesystem.o
cmds/device.o cmds/scrub.o \
            cmds/property.o cmds/filesystem-usage.o
cmds/inspect-dump-tree.o \
            cmds/inspect-dump-super.o cmds/inspect-tree-stats.o
cmds/filesystem-du.o \
            mkfs/common.o check/mode-common.o check/mode-lowmem.o
-libbtrfs_objects = send-stream.o send-utils.o kernel-lib/rbtree.o
btrfs-list.o \
-           kernel-lib/radix-tree.o extent-cache.o extent_io.o ctree.o
volumes.o \
-             disk-io.o extent-tree.o delayed-ref.o print-tree.o
common/device-scan.o \
-             common/utils.o free-space-cache.o common/path-utils.o
root-tree.o \
-             transaction.o file-item.o kernel-lib/raid56.o
kernel-lib/tables.o \
-           kernel-lib/crc32c.o common/messages.o \
-           uuid-tree.o utils-lib.o common/rbtree-utils.o
+libbtrfs_objects = $(objects) send-stream.o send-utils.o
kernel-lib/rbtree.o btrfs-list.o \
+           kernel-lib/radix-tree.o extent-cache.o extent_io.o \
+           kernel-lib/crc32c.o common/messages.o libbtrfsutil/errors.o \
+           uuid-tree.o utils-lib.o common/rbtree-utils.o
libbtrfsutil/subvolume.o
 libbtrfs_headers = send-stream.h send-utils.h send.h
kernel-lib/rbtree.h btrfs-list.h \
            kernel-lib/crc32c.h kernel-lib/list.h kerncompat.h \
            kernel-lib/radix-tree.h kernel-lib/sizes.h kernel-lib/raid56.h \
            extent-cache.h extent_io.h ioctl.h ctree.h btrfsck.h version.h \
                  volumes.h disk-io.h delayed-ref.h print-tree.h
free-space-cache.h \
-                 common/device-scan.h common/utils.h
common/path-utils.h transaction.h
+                 common/device-scan.h common/utils.h
common/path-utils.h transaction.h \
+                 libbtrfsutil/btrfsutil.h
 libbtrfsutil_major := $(shell sed -rn 's/^\#define
BTRFS_UTIL_VERSION_MAJOR ([0-9])+$$/\1/p' libbtrfsutil/btrfsutil.h)
 libbtrfsutil_minor := $(shell sed -rn 's/^\#define
BTRFS_UTIL_VERSION_MINOR ([0-9])+$$/\1/p' libbtrfsutil/btrfsutil.h)
 libbtrfsutil_patch := $(shell sed -rn 's/^\#define
BTRFS_UTIL_VERSION_PATCH ([0-9])+$$/\1/p' libbtrfsutil/btrfsutil.h)
-- 
2.23.0


I think also libbtrfsutil/subvolume.o and libbtrfsutil/errors.o have to
be moved to common/ ...

Le 23/10/2019 à 16:47, Julien_N a écrit :
> According to Johannes Thumshirn, there are missing some symbols in libbtrfs.
>
> I've made that patch, it seem to work with snapper.
>
> $ snapper --version
> snapper 0.8.4
> flags btrfs,lvm,ext4,xattrs,rollback,btrfs-quota,no-selinux
>
>
> BR.
>
> Julien
>
>
> ---
>  Makefile | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 21bf2717..616d469a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -150,13 +150,18 @@ cmds_objects = cmds/subvolume.o cmds/filesystem.o
> cmds/device.o cmds/scrub.o \
>             cmds/inspect-dump-super.o cmds/inspect-tree-stats.o
> cmds/filesystem-du.o \
>             mkfs/common.o check/mode-common.o check/mode-lowmem.o
>  libbtrfs_objects = send-stream.o send-utils.o kernel-lib/rbtree.o
> btrfs-list.o \
> -           kernel-lib/radix-tree.o extent-cache.o extent_io.o \
> +           kernel-lib/radix-tree.o extent-cache.o extent_io.o ctree.o
> volumes.o \
> +             disk-io.o extent-tree.o delayed-ref.o print-tree.o
> common/device-scan.o \
> +             common/utils.o free-space-cache.o common/path-utils.o
> root-tree.o \
> +             transaction.o file-item.o kernel-lib/raid56.o
> kernel-lib/tables.o \
>             kernel-lib/crc32c.o common/messages.o \
>             uuid-tree.o utils-lib.o common/rbtree-utils.o
>  libbtrfs_headers = send-stream.h send-utils.h send.h
> kernel-lib/rbtree.h btrfs-list.h \
>             kernel-lib/crc32c.h kernel-lib/list.h kerncompat.h \
>             kernel-lib/radix-tree.h kernel-lib/sizes.h kernel-lib/raid56.h \
> -           extent-cache.h extent_io.h ioctl.h ctree.h btrfsck.h version.h
> +           extent-cache.h extent_io.h ioctl.h ctree.h btrfsck.h version.h \
> +                 volumes.h disk-io.h delayed-ref.h print-tree.h
> free-space-cache.h \
> +                 common/device-scan.h common/utils.h
> common/path-utils.h transaction.h
>  libbtrfsutil_major := $(shell sed -rn 's/^\#define
> BTRFS_UTIL_VERSION_MAJOR ([0-9])+$$/\1/p' libbtrfsutil/btrfsutil.h)
>  libbtrfsutil_minor := $(shell sed -rn 's/^\#define
> BTRFS_UTIL_VERSION_MINOR ([0-9])+$$/\1/p' libbtrfsutil/btrfsutil.h)
>  libbtrfsutil_patch := $(shell sed -rn 's/^\#define
> BTRFS_UTIL_VERSION_PATCH ([0-9])+$$/\1/p' libbtrfsutil/btrfsutil.h)
