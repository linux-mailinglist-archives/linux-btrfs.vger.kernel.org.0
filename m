Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9D65BDF1D
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 15:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406647AbfIYNhr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 09:37:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:35670 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406621AbfIYNhq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 09:37:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0DECAB63A;
        Wed, 25 Sep 2019 13:37:44 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v5 6/7] btrfs-progs: move crc32c implementation to crypto/
Date:   Wed, 25 Sep 2019 15:37:27 +0200
Message-Id: <20190925133728.18027-7-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190925133728.18027-1-jthumshirn@suse.de>
References: <20190925133728.18027-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the introduction of xxhash64 to btrfs-progs we created a crypto/
directory for all the hashes used in btrfs (although no
cryptographically secure hash is there yet).

Move the crc32c implementation from kernel-lib/ to crypto/ as well so we
have all hashes consolidated.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 Android.mk                      | 4 ++--
 Makefile                        | 4 ++--
 btrfs-crc.c                     | 2 +-
 btrfs-find-root.c               | 2 +-
 btrfs-sb-mod.c                  | 2 +-
 btrfs.c                         | 2 +-
 cmds/inspect-dump-super.c       | 2 +-
 cmds/rescue-chunk-recover.c     | 2 +-
 cmds/rescue-super-recover.c     | 2 +-
 common/utils.c                  | 2 +-
 convert/main.c                  | 2 +-
 {kernel-lib => crypto}/crc32c.c | 2 +-
 {kernel-lib => crypto}/crc32c.h | 0
 disk-io.c                       | 2 +-
 extent-tree.c                   | 2 +-
 file-item.c                     | 2 +-
 free-space-cache.c              | 2 +-
 hash.h                          | 2 +-
 image/main.c                    | 2 +-
 image/sanitize.c                | 2 +-
 library-test.c                  | 2 +-
 mkfs/main.c                     | 2 +-
 send-stream.c                   | 2 +-
 23 files changed, 24 insertions(+), 24 deletions(-)
 rename {kernel-lib => crypto}/crc32c.c (99%)
 rename {kernel-lib => crypto}/crc32c.h (100%)

diff --git a/Android.mk b/Android.mk
index e8de47eb4617..8288ba7356f4 100644
--- a/Android.mk
+++ b/Android.mk
@@ -32,10 +32,10 @@ cmds_objects := cmds-subvolume.c cmds-filesystem.c cmds-device.c cmds-scrub.c \
                cmds-inspect-dump-super.c cmds-inspect-tree-stats.c cmds-fi-du.c \
                mkfs/common.c
 libbtrfs_objects := send-stream.c send-utils.c kernel-lib/rbtree.c btrfs-list.c \
-                   kernel-lib/crc32c.c messages.c \
+                   crypto/crc32c.c messages.c \
                    uuid-tree.c utils-lib.c rbtree-utils.c
 libbtrfs_headers := send-stream.h send-utils.h send.h kernel-lib/rbtree.h btrfs-list.h \
-                   kernel-lib/crc32c.h kernel-lib/list.h kerncompat.h \
+                   crypto/crc32c.h kernel-lib/list.h kerncompat.h \
                    kernel-lib/radix-tree.h kernel-lib/sizes.h kernel-lib/raid56.h \
                    extent-cache.h extent_io.h ioctl.h ctree.h btrfsck.h version.h
 blkid_objects := partition/ superblocks/ topology/
diff --git a/Makefile b/Makefile
index 45530749e2b9..c241c22d1018 100644
--- a/Makefile
+++ b/Makefile
@@ -150,11 +150,11 @@ cmds_objects = cmds/subvolume.o cmds/filesystem.o cmds/device.o cmds/scrub.o \
 	       cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/filesystem-du.o \
 	       mkfs/common.o check/mode-common.o check/mode-lowmem.o
 libbtrfs_objects = send-stream.o send-utils.o kernel-lib/rbtree.o btrfs-list.o \
-		   kernel-lib/crc32c.o common/messages.o \
+		   crypto/crc32c.o common/messages.o \
 		   uuid-tree.o utils-lib.o common/rbtree-utils.o \
 		   crypto/hash.o crypto/xxhash.o
 libbtrfs_headers = send-stream.h send-utils.h send.h kernel-lib/rbtree.h btrfs-list.h \
-	       kernel-lib/crc32c.h kernel-lib/list.h kerncompat.h \
+	       crypto/crc32c.h kernel-lib/list.h kerncompat.h \
 	       kernel-lib/radix-tree.h kernel-lib/sizes.h kernel-lib/raid56.h \
 	       extent-cache.h extent_io.h ioctl.h ctree.h btrfsck.h version.h
 libbtrfsutil_major := $(shell sed -rn 's/^\#define BTRFS_UTIL_VERSION_MAJOR ([0-9])+$$/\1/p' libbtrfsutil/btrfsutil.h)
diff --git a/btrfs-crc.c b/btrfs-crc.c
index bcf25df8b46a..c4f81fc65f67 100644
--- a/btrfs-crc.c
+++ b/btrfs-crc.c
@@ -19,7 +19,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-#include "kernel-lib/crc32c.h"
+#include "crypto/crc32c.h"
 #include "common/utils.h"
 
 void print_usage(int status)
diff --git a/btrfs-find-root.c b/btrfs-find-root.c
index e46fa8723b33..741eb9a95ac5 100644
--- a/btrfs-find-root.c
+++ b/btrfs-find-root.c
@@ -32,7 +32,7 @@
 #include "kernel-lib/list.h"
 #include "volumes.h"
 #include "common/utils.h"
-#include "kernel-lib/crc32c.h"
+#include "crypto/crc32c.h"
 #include "extent-cache.h"
 #include "find-root.h"
 #include "common/help.h"
diff --git a/btrfs-sb-mod.c b/btrfs-sb-mod.c
index 105b556b0cf1..348991b39451 100644
--- a/btrfs-sb-mod.c
+++ b/btrfs-sb-mod.c
@@ -24,7 +24,7 @@
 #include <string.h>
 #include <limits.h>
 #include <byteswap.h>
-#include "kernel-lib/crc32c.h"
+#include "crypto/crc32c.h"
 #include "disk-io.h"
 
 #define BLOCKSIZE (4096)
diff --git a/btrfs.c b/btrfs.c
index 6c8aabe24dc8..72dad6fb3983 100644
--- a/btrfs.c
+++ b/btrfs.c
@@ -20,7 +20,7 @@
 #include <getopt.h>
 
 #include "volumes.h"
-#include "kernel-lib/crc32c.h"
+#include "crypto/crc32c.h"
 #include "cmds/commands.h"
 #include "common/utils.h"
 #include "common/help.h"
diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index 73e986ed8ee8..52636bd2e11c 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -32,7 +32,7 @@
 #include "kernel-lib/list.h"
 #include "common/utils.h"
 #include "cmds/commands.h"
-#include "kernel-lib/crc32c.h"
+#include "crypto/crc32c.h"
 #include "common/help.h"
 
 static int check_csum_sblock(void *sb, int csum_size, u16 csum_type)
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index 329a608dfc6b..bf35693ddbfa 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -36,7 +36,7 @@
 #include "disk-io.h"
 #include "volumes.h"
 #include "transaction.h"
-#include "kernel-lib/crc32c.h"
+#include "crypto/crc32c.h"
 #include "common/utils.h"
 #include "check/common.h"
 #include "cmds/commands.h"
diff --git a/cmds/rescue-super-recover.c b/cmds/rescue-super-recover.c
index ea3a00caf56c..5d6bea836c8b 100644
--- a/cmds/rescue-super-recover.c
+++ b/cmds/rescue-super-recover.c
@@ -31,7 +31,7 @@
 #include "disk-io.h"
 #include "kernel-lib/list.h"
 #include "common/utils.h"
-#include "kernel-lib/crc32c.h"
+#include "crypto/crc32c.h"
 #include "volumes.h"
 #include "cmds/commands.h"
 #include "cmds/rescue.h"
diff --git a/common/utils.c b/common/utils.c
index f2a10cccca86..fa49c01ad102 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -47,7 +47,7 @@
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
-#include "kernel-lib/crc32c.h"
+#include "crypto/crc32c.h"
 #include "common/utils.h"
 #include "common/path-utils.h"
 #include "common/device-scan.h"
diff --git a/convert/main.c b/convert/main.c
index bb689be9f3e4..3686b5814838 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -102,7 +102,7 @@
 #include "mkfs/common.h"
 #include "convert/common.h"
 #include "convert/source-fs.h"
-#include "kernel-lib/crc32c.h"
+#include "crypto/crc32c.h"
 #include "common/fsfeatures.h"
 #include "common/box.h"
 
diff --git a/kernel-lib/crc32c.c b/crypto/crc32c.c
similarity index 99%
rename from kernel-lib/crc32c.c
rename to crypto/crc32c.c
index 36bb6f189971..bd6283d5baeb 100644
--- a/kernel-lib/crc32c.c
+++ b/crypto/crc32c.c
@@ -8,7 +8,7 @@
  *
  */
 #include "kerncompat.h"
-#include "kernel-lib/crc32c.h"
+#include "crypto/crc32c.h"
 #include <inttypes.h>
 #include <string.h>
 #include <unistd.h>
diff --git a/kernel-lib/crc32c.h b/crypto/crc32c.h
similarity index 100%
rename from kernel-lib/crc32c.h
rename to crypto/crc32c.h
diff --git a/disk-io.c b/disk-io.c
index 59e297e2039c..8f15adbf4910 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -29,7 +29,7 @@
 #include "disk-io.h"
 #include "volumes.h"
 #include "transaction.h"
-#include "kernel-lib/crc32c.h"
+#include "crypto/crc32c.h"
 #include "common/utils.h"
 #include "print-tree.h"
 #include "common/rbtree-utils.h"
diff --git a/extent-tree.c b/extent-tree.c
index 932af2c644bd..a8f57776bd73 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -26,7 +26,7 @@
 #include "disk-io.h"
 #include "print-tree.h"
 #include "transaction.h"
-#include "kernel-lib/crc32c.h"
+#include "crypto/crc32c.h"
 #include "volumes.h"
 #include "free-space-cache.h"
 #include "free-space-tree.h"
diff --git a/file-item.c b/file-item.c
index c6e9d212bcab..64af57693baf 100644
--- a/file-item.c
+++ b/file-item.c
@@ -24,7 +24,7 @@
 #include "disk-io.h"
 #include "transaction.h"
 #include "print-tree.h"
-#include "kernel-lib/crc32c.h"
+#include "crypto/crc32c.h"
 #include "common/internal.h"
 
 #define MAX_CSUM_ITEMS(r, size) ((((BTRFS_LEAF_DATA_SIZE(r->fs_info) - \
diff --git a/free-space-cache.c b/free-space-cache.c
index 8a57f86dc650..6e7d7e1ef561 100644
--- a/free-space-cache.c
+++ b/free-space-cache.c
@@ -22,7 +22,7 @@
 #include "transaction.h"
 #include "disk-io.h"
 #include "extent_io.h"
-#include "kernel-lib/crc32c.h"
+#include "crypto/crc32c.h"
 #include "kernel-lib/bitops.h"
 #include "common/internal.h"
 #include "common/utils.h"
diff --git a/hash.h b/hash.h
index 5398e8869316..51e842047093 100644
--- a/hash.h
+++ b/hash.h
@@ -19,7 +19,7 @@
 #ifndef __BTRFS_HASH_H__
 #define __BTRFS_HASH_H__
 
-#include "kernel-lib/crc32c.h"
+#include "crypto/crc32c.h"
 
 static inline u64 btrfs_name_hash(const char *name, int len)
 {
diff --git a/image/main.c b/image/main.c
index f713e47b85cb..b87525412543 100644
--- a/image/main.c
+++ b/image/main.c
@@ -28,7 +28,7 @@
 #include <getopt.h>
 
 #include "kerncompat.h"
-#include "kernel-lib/crc32c.h"
+#include "crypto/crc32c.h"
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
diff --git a/image/sanitize.c b/image/sanitize.c
index 9caa5deaf2dd..cd2bd6fe2379 100644
--- a/image/sanitize.c
+++ b/image/sanitize.c
@@ -18,7 +18,7 @@
 #include "common/internal.h"
 #include "common/messages.h"
 #include "common/utils.h"
-#include "kernel-lib/crc32c.h"
+#include "crypto/crc32c.h"
 #include "image/sanitize.h"
 #include "extent_io.h"
 
diff --git a/library-test.c b/library-test.c
index c44bad228e50..e47917c25830 100644
--- a/library-test.c
+++ b/library-test.c
@@ -21,7 +21,7 @@
 #include "version.h"
 #include "kernel-lib/rbtree.h"
 #include "kernel-lib/radix-tree.h"
-#include "kernel-lib/crc32c.h"
+#include "crypto/crc32c.h"
 #include "kernel-lib/list.h"
 #include "kernel-lib/sizes.h"
 #include "ctree.h"
diff --git a/mkfs/main.c b/mkfs/main.c
index da40e958fe0a..a0dc5846beb3 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -45,7 +45,7 @@
 #include "common/rbtree-utils.h"
 #include "mkfs/common.h"
 #include "mkfs/rootdir.h"
-#include "kernel-lib/crc32c.h"
+#include "crypto/crc32c.h"
 #include "common/fsfeatures.h"
 #include "common/box.h"
 
diff --git a/send-stream.c b/send-stream.c
index 08687e5e6904..3b8ada2110aa 100644
--- a/send-stream.c
+++ b/send-stream.c
@@ -21,7 +21,7 @@
 
 #include "send.h"
 #include "send-stream.h"
-#include "kernel-lib/crc32c.h"
+#include "crypto/crc32c.h"
 #include "common/utils.h"
 
 struct btrfs_send_stream {
-- 
2.16.4

