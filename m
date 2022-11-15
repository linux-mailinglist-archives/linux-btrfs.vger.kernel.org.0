Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3708D629D94
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 16:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiKOPcc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 10:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238390AbiKOPb7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 10:31:59 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F7B29831
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:56 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id p18so9703087qkg.2
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tI5t1Ab2ACbZ9kaLd7cKx0DOAFOHo4ZqfHXDteZcXY=;
        b=zUswNKU+8HCo9PF4pC+HkiUc2jUB1HeotGVNGB+PiU1HGnQjGspQh8uiOewN8bUCBA
         /R+K8h+ib+7HfYI8JOPzVvENbbrBCKXKk/C2qlVS4/9Jev7R6KugliN37FV+YQw0oelK
         ffZKw4XiCkEACLvExWZTbyi3MPShRMAG4hfBAoePZZ2qgidB1pCRSg2YUE3pxZ+AeIu5
         WBEf53Cnc2YEVnba0C+z3LC0J3C7T3odDtkwCX8OTv/OynP7Fne2wcICruXo3QVuVBuH
         N/AD5sZDR1GWIEGsY65orEKLsWBncZd9Tf4mHTQTOfZ0J3HVDeK09wkuHRVdsyiv8UCQ
         G0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tI5t1Ab2ACbZ9kaLd7cKx0DOAFOHo4ZqfHXDteZcXY=;
        b=pLvjtqtXb/rBFvboDFs/cDioMgIvlMruiy5KMzgznIYD19vVXtJ2KLEO5AKTxYr6iJ
         CaIdJK5mB9tWM6Q/JSIAvMseQ/x/ySN1+z8TCPSGBSNH0cLvu93ifizUArT7uNu/eayU
         kvO0nA2PUKPUSFI5tdV6S965ECSnXAXuNzS8O5PetAMuCJEMN0QFmQb2lxcYowRzdkGk
         dfNvpdhZDkBE+BiAoewI4xz6/g76mrpXKgrFr9UO/RghW3jfH9ECqOxx2EuQ4K7Oudzu
         QY1W5+9Hm4nwSVBpjwCeFpjQyMgVo/B/LMad3D5AM8pa2kse92D0Rqz+vzYBOhRyYrbB
         Cn8Q==
X-Gm-Message-State: ANoB5pm8ERNdMSRfDUQKOHVAqWI142J7hW1jMyrpskNAKnliBE1tSzSt
        uKz+bJ+v9CXOTjV3Nr0iwbvz0igxjWnlPA==
X-Google-Smtp-Source: AA0mqf5bMTXBpnCsF9O+JmzTZWLMk25+A3oO6eWVGbFp/h3MJbTsUGmewMAEYZLek2zhAdZJ5oc7CQ==
X-Received: by 2002:a05:620a:b:b0:6fb:ab7:82c6 with SMTP id j11-20020a05620a000b00b006fb0ab782c6mr15560644qki.37.1668526314614;
        Tue, 15 Nov 2022 07:31:54 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id dm8-20020a05620a1d4800b006fb8239db65sm3370482qkb.43.2022.11.15.07.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:31:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 14/18] btrfs-progs: sync messages.* from the kernel
Date:   Tue, 15 Nov 2022 10:31:23 -0500
Message-Id: <1a0af78703c965a1d9e3d9138816d1b4fb614c58.1668526161.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668526161.git.josef@toxicpanda.com>
References: <cover.1668526161.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These are the printk helpers from the kernel.  There were a few
modifications, the hi-lights are

 - We do not have fs_info::fs_state, so that needed to be removed.
 - We do not have discard.h sync'ed yet, so that dependency was dropped.
 - Anything related to struct super_block was commented out.
 - The transaction abort had to be modified to fit with the current
   btrfs-progs code.

Additionally there were kerncompat.h changes that needed to be made to
handle the dependencies properly.  Those are easier to spot.

Any function that needed to be modified has a MODIFIED tag in the
comment section with a list of things that were changed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Makefile                        |   1 +
 btrfs-corrupt-block.c           |   1 +
 btrfstune.c                     |   1 +
 check/clear-cache.c             |   1 +
 check/main.c                    |   1 +
 check/mode-common.c             |   1 +
 check/mode-lowmem.c             |   1 +
 cmds/filesystem-du.c            |   1 +
 cmds/filesystem-usage.c         |   1 +
 cmds/qgroup.c                   |   1 +
 cmds/replace.c                  |   1 +
 cmds/rescue-chunk-recover.c     |   1 +
 cmds/rescue.c                   |   1 +
 cmds/subvolume-list.c           |   1 +
 common/units.c                  |   1 +
 convert/common.c                |   1 +
 convert/source-ext2.c           |   1 +
 image/main.c                    |   1 +
 kerncompat.h                    |  44 ++--
 kernel-shared/backref.c         |   1 +
 kernel-shared/ctree.h           |   2 +
 kernel-shared/delayed-ref.c     |   1 +
 kernel-shared/extent_io.c       |   1 +
 kernel-shared/free-space-tree.c |   1 +
 kernel-shared/messages.c        | 372 ++++++++++++++++++++++++++++++++
 kernel-shared/messages.h        | 253 ++++++++++++++++++++++
 kernel-shared/transaction.c     |   5 -
 kernel-shared/transaction.h     |   1 -
 kernel-shared/ulist.c           |   1 +
 kernel-shared/zoned.h           |   1 +
 libbtrfs/ctree.h                |   1 +
 mkfs/main.c                     |   1 +
 32 files changed, 677 insertions(+), 26 deletions(-)
 create mode 100644 kernel-shared/messages.c
 create mode 100644 kernel-shared/messages.h

diff --git a/Makefile b/Makefile
index f25042f3..96683354 100644
--- a/Makefile
+++ b/Makefile
@@ -166,6 +166,7 @@ objects = \
 	kernel-shared/free-space-tree.o	\
 	kernel-shared/inode-item.o	\
 	kernel-shared/inode.o	\
+	kernel-shared/messages.o	\
 	kernel-shared/print-tree.o	\
 	kernel-shared/root-tree.o	\
 	kernel-shared/transaction.o	\
diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 33e3f85d..29915f47 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -28,6 +28,7 @@
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/extent_io.h"
+#include "kernel-shared/messages.h"
 #include "common/utils.h"
 #include "common/help.h"
 #include "common/extent-cache.h"
diff --git a/btrfstune.c b/btrfstune.c
index 8dd32129..0ad7275c 100644
--- a/btrfstune.c
+++ b/btrfstune.c
@@ -31,6 +31,7 @@
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/extent_io.h"
+#include "kernel-shared/messages.h"
 #include "common/defs.h"
 #include "common/utils.h"
 #include "common/extent-cache.h"
diff --git a/check/clear-cache.c b/check/clear-cache.c
index 0a3001a4..c4ee6b33 100644
--- a/check/clear-cache.c
+++ b/check/clear-cache.c
@@ -21,6 +21,7 @@
 #include "kernel-shared/free-space-tree.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/transaction.h"
+#include "kernel-shared/messages.h"
 #include "common/internal.h"
 #include "common/messages.h"
 #include "check/common.h"
diff --git a/check/main.c b/check/main.c
index 4d8d6882..ddad9553 100644
--- a/check/main.c
+++ b/check/main.c
@@ -41,6 +41,7 @@
 #include "kernel-shared/free-space-tree.h"
 #include "kernel-shared/backref.h"
 #include "kernel-shared/ulist.h"
+#include "kernel-shared/messages.h"
 #include "common/defs.h"
 #include "common/extent-cache.h"
 #include "common/internal.h"
diff --git a/check/mode-common.c b/check/mode-common.c
index c8ac235d..a49755da 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -28,6 +28,7 @@
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/backref.h"
 #include "kernel-shared/compression.h"
+#include "kernel-shared/messages.h"
 #include "common/internal.h"
 #include "common/messages.h"
 #include "common/utils.h"
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 8377f647..9766da49 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -30,6 +30,7 @@
 #include "kernel-shared/backref.h"
 #include "kernel-shared/compression.h"
 #include "kernel-shared/volumes.h"
+#include "kernel-shared/messages.h"
 #include "common/messages.h"
 #include "common/internal.h"
 #include "common/utils.h"
diff --git a/cmds/filesystem-du.c b/cmds/filesystem-du.c
index 98cf75eb..e22135c6 100644
--- a/cmds/filesystem-du.c
+++ b/cmds/filesystem-du.c
@@ -32,6 +32,7 @@
 #include "kernel-lib/rbtree_types.h"
 #include "kernel-lib/interval_tree_generic.h"
 #include "kernel-shared/ctree.h"
+#include "kernel-shared/messages.h"
 #include "common/utils.h"
 #include "common/open-utils.h"
 #include "common/units.h"
diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 5810324f..09aa1405 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -31,6 +31,7 @@
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/volumes.h"
+#include "kernel-shared/messages.h"
 #include "common/utils.h"
 #include "common/string-table.h"
 #include "common/open-utils.h"
diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index b3fd7e9f..77932330 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -39,6 +39,7 @@
 #include "cmds/commands.h"
 #include "cmds/qgroup.h"
 #include "kernel-shared/uapi/btrfs.h"
+#include "kernel-shared/messages.h"
 
 #define BTRFS_QGROUP_NFILTERS_INCREASE (2 * BTRFS_QGROUP_FILTER_MAX)
 #define BTRFS_QGROUP_NCOMPS_INCREASE (2 * BTRFS_QGROUP_COMP_MAX)
diff --git a/cmds/replace.c b/cmds/replace.c
index 077a9d04..917874ab 100644
--- a/cmds/replace.c
+++ b/cmds/replace.c
@@ -40,6 +40,7 @@
 #include "cmds/commands.h"
 #include "mkfs/common.h"
 #include "kernel-shared/uapi/btrfs.h"
+#include "kernel-shared/messages.h"
 
 static int print_replace_status(int fd, const char *path, int once);
 static char *time2string(char *buf, size_t s, __u64 t);
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index a085f108..460a7f2f 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -38,6 +38,7 @@
 #include "cmds/rescue.h"
 #include "check/common.h"
 #include "kernel-shared/uapi/btrfs.h"
+#include "kernel-shared/messages.h"
 
 struct recover_control {
 	int verbose;
diff --git a/cmds/rescue.c b/cmds/rescue.c
index 2536ca70..c23bd989 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -28,6 +28,7 @@
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/extent_io.h"
+#include "kernel-shared/messages.h"
 #include "common/messages.h"
 #include "common/utils.h"
 #include "common/help.h"
diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
index 1c734f50..e4bb5898 100644
--- a/cmds/subvolume-list.c
+++ b/cmds/subvolume-list.c
@@ -36,6 +36,7 @@
 #include "common/utils.h"
 #include "cmds/commands.h"
 #include "kernel-shared/uapi/btrfs.h"
+#include "kernel-shared/messages.h"
 
 /*
  * Naming of options:
diff --git a/common/units.c b/common/units.c
index 698dc1d0..5192b6a8 100644
--- a/common/units.c
+++ b/common/units.c
@@ -18,6 +18,7 @@
 #include <string.h>
 #include "common/units.h"
 #include "common/messages.h"
+#include "kernel-shared/messages.h"
 
 /*
  * Note: this function uses a static per-thread buffer. Do not call this
diff --git a/convert/common.c b/convert/common.c
index 228191b8..af115d14 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -30,6 +30,7 @@
 #include "mkfs/common.h"
 #include "convert/common.h"
 #include "kernel-shared/uapi/btrfs.h"
+#include "kernel-shared/messages.h"
 
 #define BTRFS_CONVERT_META_GROUP_SIZE SZ_32M
 
diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index b0b865b9..a8b33317 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -27,6 +27,7 @@
 #include <string.h>
 #include "kernel-lib/sizes.h"
 #include "kernel-shared/transaction.h"
+#include "kernel-shared/messages.h"
 #include "common/extent-cache.h"
 #include "common/messages.h"
 #include "convert/common.h"
diff --git a/image/main.c b/image/main.c
index 6a1bcd42..6bdb5d66 100644
--- a/image/main.c
+++ b/image/main.c
@@ -39,6 +39,7 @@
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/extent_io.h"
+#include "kernel-shared/messages.h"
 #include "crypto/crc32c.h"
 #include "common/internal.h"
 #include "common/messages.h"
diff --git a/kerncompat.h b/kerncompat.h
index dedcf5f0..59beb4f4 100644
--- a/kerncompat.h
+++ b/kerncompat.h
@@ -35,6 +35,8 @@
 #include <linux/types.h>
 #include <linux/const.h>
 #include <stdint.h>
+#include <stdbool.h>
+#include <stdarg.h>
 
 #include <features.h>
 
@@ -314,6 +316,12 @@ static inline int IS_ERR_OR_NULL(const void *ptr)
 #define printk(fmt, args...) fprintf(stderr, fmt, ##args)
 #define	KERN_CRIT	""
 #define KERN_ERR	""
+#define KERN_EMERG	""
+#define KERN_ALERT	""
+#define KERN_CRIT	""
+#define KERN_NOTICE	""
+#define KERN_INFO	""
+#define KERN_WARNING	""
 
 /*
  * kmalloc/kfree
@@ -329,26 +337,6 @@ static inline int IS_ERR_OR_NULL(const void *ptr)
 #define memalloc_nofs_save() (0)
 #define memalloc_nofs_restore(x)	((void)(x))
 
-#ifndef BTRFS_DISABLE_BACKTRACE
-static inline void assert_trace(const char *assertion, const char *filename,
-			      const char *func, unsigned line, long val)
-{
-	if (val)
-		return;
-	fprintf(stderr,
-		"%s:%d: %s: Assertion `%s` failed, value %ld\n",
-		filename, line, func, assertion, val);
-#ifndef BTRFS_DISABLE_BACKTRACE
-	print_trace();
-#endif
-	abort();
-	exit(1);
-}
-#define	ASSERT(c) assert_trace(#c, __FILE__, __func__, __LINE__, (long)(c))
-#else
-#define ASSERT(c) assert(c)
-#endif
-
 #define BUG_ON(c) bugon_trace(#c, __FILE__, __func__, __LINE__, (long)(c))
 #define BUG()				\
 do {					\
@@ -568,7 +556,23 @@ struct work_struct {
 typedef struct wait_queue_head_s {
 } wait_queue_head_t;
 
+struct super_block {
+	char *s_id;
+};
+
+struct va_format {
+	const char *fmt;
+	va_list *va;
+};
+
 #define __init
 #define __cold
 
+#define __printf(a, b)                  __attribute__((__format__(printf, a, b)))
+
+static inline bool sb_rdonly(struct super_block *sb)
+{
+	return false;
+}
+
 #endif
diff --git a/kernel-shared/backref.c b/kernel-shared/backref.c
index 9c5a3895..897cd089 100644
--- a/kernel-shared/backref.c
+++ b/kernel-shared/backref.c
@@ -23,6 +23,7 @@
 #include "kernel-shared/ulist.h"
 #include "kernel-shared/transaction.h"
 #include "common/internal.h"
+#include "messages.h"
 
 #define pr_debug(...) do { } while (0)
 
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index d3fc0660..42cacf74 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -367,6 +367,8 @@ struct btrfs_fs_info {
 		u64 zone_size;
 		u64 zoned;
 	};
+
+	struct super_block *sb;
 };
 
 static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
diff --git a/kernel-shared/delayed-ref.c b/kernel-shared/delayed-ref.c
index 5b041ac6..f148b5f2 100644
--- a/kernel-shared/delayed-ref.c
+++ b/kernel-shared/delayed-ref.c
@@ -20,6 +20,7 @@
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/delayed-ref.h"
 #include "kernel-shared/transaction.h"
+#include "messages.h"
 
 /*
  * delayed back reference update tracking.  For subvolume trees
diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index f112983a..dfc42a90 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -33,6 +33,7 @@
 #include "common/utils.h"
 #include "common/device-utils.h"
 #include "common/internal.h"
+#include "messages.h"
 
 void extent_io_tree_init(struct extent_io_tree *tree)
 {
diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 656de3fa..4064b7cb 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -24,6 +24,7 @@
 #include "kernel-shared/transaction.h"
 #include "kernel-lib/bitops.h"
 #include "common/internal.h"
+#include "messages.h"
 
 static struct btrfs_root *btrfs_free_space_root(struct btrfs_fs_info *fs_info,
 						struct btrfs_block_group *block_group)
diff --git a/kernel-shared/messages.c b/kernel-shared/messages.c
new file mode 100644
index 00000000..e8ba1df8
--- /dev/null
+++ b/kernel-shared/messages.c
@@ -0,0 +1,372 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "kerncompat.h"
+#include "kernel-lib/bitops.h"
+#include "ctree.h"
+#include "messages.h"
+#include "transaction.h"
+
+#ifdef CONFIG_PRINTK
+
+#define STATE_STRING_PREFACE	": state "
+#define STATE_STRING_BUF_LEN	(sizeof(STATE_STRING_PREFACE) + BTRFS_FS_STATE_COUNT)
+
+/*
+ * Characters to print to indicate error conditions or uncommon filesystem state.
+ * RO is not an error.
+ */
+static const char fs_state_chars[] = {
+	[BTRFS_FS_STATE_ERROR]			= 'E',
+	[BTRFS_FS_STATE_REMOUNTING]		= 'M',
+	[BTRFS_FS_STATE_RO]			= 0,
+	[BTRFS_FS_STATE_TRANS_ABORTED]		= 'A',
+	[BTRFS_FS_STATE_DEV_REPLACING]		= 'R',
+	[BTRFS_FS_STATE_DUMMY_FS_INFO]		= 0,
+	[BTRFS_FS_STATE_NO_CSUMS]		= 'C',
+	[BTRFS_FS_STATE_LOG_CLEANUP_ERROR]	= 'L',
+};
+
+static void btrfs_state_to_string(const struct btrfs_fs_info *info, char *buf)
+{
+	unsigned int bit;
+	bool states_printed = false;
+	unsigned long fs_state = READ_ONCE(info->fs_state);
+	char *curr = buf;
+
+	memcpy(curr, STATE_STRING_PREFACE, sizeof(STATE_STRING_PREFACE));
+	curr += sizeof(STATE_STRING_PREFACE) - 1;
+
+	for_each_set_bit(bit, &fs_state, sizeof(fs_state)) {
+		WARN_ON_ONCE(bit >= BTRFS_FS_STATE_COUNT);
+		if ((bit < BTRFS_FS_STATE_COUNT) && fs_state_chars[bit]) {
+			*curr++ = fs_state_chars[bit];
+			states_printed = true;
+		}
+	}
+
+	/* If no states were printed, reset the buffer */
+	if (!states_printed)
+		curr = buf;
+
+	*curr++ = 0;
+}
+#endif
+
+/*
+ * Generally the error codes correspond to their respective errors, but there
+ * are a few special cases.
+ *
+ * EUCLEAN: Any sort of corruption that we encounter.  The tree-checker for
+ *          instance will return EUCLEAN if any of the blocks are corrupted in
+ *          a way that is problematic.  We want to reserve EUCLEAN for these
+ *          sort of corruptions.
+ *
+ * EROFS: If we check BTRFS_FS_STATE_ERROR and fail out with a return error, we
+ *        need to use EROFS for this case.  We will have no idea of the
+ *        original failure, that will have been reported at the time we tripped
+ *        over the error.  Each subsequent error that doesn't have any context
+ *        of the original error should use EROFS when handling BTRFS_FS_STATE_ERROR.
+ */
+const char * __attribute_const__ btrfs_decode_error(int error)
+{
+	char *errstr = "unknown";
+
+	switch (error) {
+	case -ENOENT:		/* -2 */
+		errstr = "No such entry";
+		break;
+	case -EIO:		/* -5 */
+		errstr = "IO failure";
+		break;
+	case -ENOMEM:		/* -12*/
+		errstr = "Out of memory";
+		break;
+	case -EEXIST:		/* -17 */
+		errstr = "Object already exists";
+		break;
+	case -ENOSPC:		/* -28 */
+		errstr = "No space left";
+		break;
+	case -EROFS:		/* -30 */
+		errstr = "Readonly filesystem";
+		break;
+	case -EOPNOTSUPP:	/* -95 */
+		errstr = "Operation not supported";
+		break;
+	case -EUCLEAN:		/* -117 */
+		errstr = "Filesystem corrupted";
+		break;
+	case -EDQUOT:		/* -122 */
+		errstr = "Quota exceeded";
+		break;
+	}
+
+	return errstr;
+}
+
+/*
+ * __btrfs_handle_fs_error decodes expected errors from the caller and
+ * invokes the appropriate error response.
+ */
+__cold
+void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function,
+		       unsigned int line, int error, const char *fmt, ...)
+{
+	struct super_block *sb = fs_info->sb;
+#ifdef CONFIG_PRINTK
+	char statestr[STATE_STRING_BUF_LEN];
+	const char *errstr;
+#endif
+
+#ifdef CONFIG_PRINTK_INDEX
+	printk_index_subsys_emit(
+		"BTRFS: error (device %s%s) in %s:%d: error=%d %s", KERN_CRIT, fmt);
+#endif
+
+	/*
+	 * Special case: if the error is EROFS, and we're already under
+	 * SB_RDONLY, then it is safe here.
+	 */
+	if (error == -EROFS && sb_rdonly(sb))
+		return;
+
+#ifdef CONFIG_PRINTK
+	errstr = btrfs_decode_error(error);
+	btrfs_state_to_string(fs_info, statestr);
+	if (fmt) {
+		struct va_format vaf;
+		va_list args;
+
+		va_start(args, fmt);
+		vaf.fmt = fmt;
+		vaf.va = &args;
+
+		pr_crit("BTRFS: error (device %s%s) in %s:%d: error=%d %s (%pV)\n",
+			sb->s_id, statestr, function, line, error, errstr, &vaf);
+		va_end(args);
+	} else {
+		pr_crit("BTRFS: error (device %s%s) in %s:%d: error=%d %s\n",
+			sb->s_id, statestr, function, line, error, errstr);
+	}
+#endif
+
+	/*
+	 * We don't have fs_info::fs_state yet, and the rest of this is more
+	 * kernel related cleanup, so for now comment it out.
+	 */
+#if 0
+	/*
+	 * Today we only save the error info to memory.  Long term we'll also
+	 * send it down to the disk.
+	 */
+	set_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state);
+
+	/* Don't go through full error handling during mount. */
+	if (!(sb->s_flags & SB_BORN))
+		return;
+
+	if (sb_rdonly(sb))
+		return;
+
+	btrfs_discard_stop(fs_info);
+
+	/* Handle error by forcing the filesystem readonly. */
+	btrfs_set_sb_rdonly(sb);
+#endif
+
+	btrfs_info(fs_info, "forced readonly");
+	/*
+	 * Note that a running device replace operation is not canceled here
+	 * although there is no way to update the progress. It would add the
+	 * risk of a deadlock, therefore the canceling is omitted. The only
+	 * penalty is that some I/O remains active until the procedure
+	 * completes. The next time when the filesystem is mounted writable
+	 * again, the device replace operation continues.
+	 */
+}
+
+#ifdef CONFIG_PRINTK
+static const char * const logtypes[] = {
+	"emergency",
+	"alert",
+	"critical",
+	"error",
+	"warning",
+	"notice",
+	"info",
+	"debug",
+};
+
+/*
+ * Use one ratelimit state per log level so that a flood of less important
+ * messages doesn't cause more important ones to be dropped.
+ */
+static struct ratelimit_state printk_limits[] = {
+	RATELIMIT_STATE_INIT(printk_limits[0], DEFAULT_RATELIMIT_INTERVAL, 100),
+	RATELIMIT_STATE_INIT(printk_limits[1], DEFAULT_RATELIMIT_INTERVAL, 100),
+	RATELIMIT_STATE_INIT(printk_limits[2], DEFAULT_RATELIMIT_INTERVAL, 100),
+	RATELIMIT_STATE_INIT(printk_limits[3], DEFAULT_RATELIMIT_INTERVAL, 100),
+	RATELIMIT_STATE_INIT(printk_limits[4], DEFAULT_RATELIMIT_INTERVAL, 100),
+	RATELIMIT_STATE_INIT(printk_limits[5], DEFAULT_RATELIMIT_INTERVAL, 100),
+	RATELIMIT_STATE_INIT(printk_limits[6], DEFAULT_RATELIMIT_INTERVAL, 100),
+	RATELIMIT_STATE_INIT(printk_limits[7], DEFAULT_RATELIMIT_INTERVAL, 100),
+};
+
+void __cold _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
+{
+	char lvl[PRINTK_MAX_SINGLE_HEADER_LEN + 1] = "\0";
+	struct va_format vaf;
+	va_list args;
+	int kern_level;
+	const char *type = logtypes[4];
+	struct ratelimit_state *ratelimit = &printk_limits[4];
+
+#ifdef CONFIG_PRINTK_INDEX
+	printk_index_subsys_emit("%sBTRFS %s (device %s): ", NULL, fmt);
+#endif
+
+	va_start(args, fmt);
+
+	while ((kern_level = printk_get_level(fmt)) != 0) {
+		size_t size = printk_skip_level(fmt) - fmt;
+
+		if (kern_level >= '0' && kern_level <= '7') {
+			memcpy(lvl, fmt,  size);
+			lvl[size] = '\0';
+			type = logtypes[kern_level - '0'];
+			ratelimit = &printk_limits[kern_level - '0'];
+		}
+		fmt += size;
+	}
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	if (__ratelimit(ratelimit)) {
+		if (fs_info) {
+			char statestr[STATE_STRING_BUF_LEN];
+
+			btrfs_state_to_string(fs_info, statestr);
+			_printk("%sBTRFS %s (device %s%s): %pV\n", lvl, type,
+				fs_info->sb->s_id, statestr, &vaf);
+		} else {
+			_printk("%sBTRFS %s: %pV\n", lvl, type, &vaf);
+		}
+	}
+
+	va_end(args);
+}
+#endif
+
+#ifdef CONFIG_BTRFS_ASSERT
+void __cold btrfs_assertfail(const char *expr, const char *file, int line)
+{
+	pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
+	BUG();
+}
+#endif
+
+void __cold btrfs_print_v0_err(struct btrfs_fs_info *fs_info)
+{
+	btrfs_err(fs_info,
+"Unsupported V0 extent filesystem detected. Aborting. Please re-create your filesystem with a newer kernel");
+}
+
+#if BITS_PER_LONG == 32
+void __cold btrfs_warn_32bit_limit(struct btrfs_fs_info *fs_info)
+{
+	if (!test_and_set_bit(BTRFS_FS_32BIT_WARN, &fs_info->flags)) {
+		btrfs_warn(fs_info, "reaching 32bit limit for logical addresses");
+		btrfs_warn(fs_info,
+"due to page cache limit on 32bit systems, btrfs can't access metadata at or beyond %lluT",
+			   BTRFS_32BIT_MAX_FILE_SIZE >> 40);
+		btrfs_warn(fs_info,
+			   "please consider upgrading to 64bit kernel/hardware");
+	}
+}
+
+void __cold btrfs_err_32bit_limit(struct btrfs_fs_info *fs_info)
+{
+	if (!test_and_set_bit(BTRFS_FS_32BIT_ERROR, &fs_info->flags)) {
+		btrfs_err(fs_info, "reached 32bit limit for logical addresses");
+		btrfs_err(fs_info,
+"due to page cache limit on 32bit systems, metadata beyond %lluT can't be accessed",
+			  BTRFS_32BIT_MAX_FILE_SIZE >> 40);
+		btrfs_err(fs_info,
+			   "please consider upgrading to 64bit kernel/hardware");
+	}
+}
+#endif
+
+/*
+ * We only mark the transaction aborted and then set the file system read-only.
+ * This will prevent new transactions from starting or trying to join this
+ * one.
+ *
+ * This means that error recovery at the call site is limited to freeing
+ * any local memory allocations and passing the error code up without
+ * further cleanup. The transaction should complete as it normally would
+ * in the call path but will return -EIO.
+ *
+ * We'll complete the cleanup in btrfs_end_transaction and
+ * btrfs_commit_transaction.
+ *
+ * MODIFIED:
+ *  - We do not have trans->aborted, change to fs_info->transaction_aborted.
+ *  - We do not have btrfs_dump_space_info_for_trans_abort().
+ *  - We do not have transaction_wait, transaction_blocked_wait.
+ */
+__cold
+void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
+			       const char *function,
+			       unsigned int line, int error, bool first_hit)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+
+	fs_info->transaction_aborted = error;
+#if 0
+	if (first_hit && error == -ENOSPC)
+		btrfs_dump_space_info_for_trans_abort(fs_info);
+	/* Wake up anybody who may be waiting on this transaction */
+	wake_up(&fs_info->transaction_wait);
+	wake_up(&fs_info->transaction_blocked_wait);
+#endif
+	__btrfs_handle_fs_error(fs_info, function, line, error, NULL);
+}
+
+/*
+ * __btrfs_panic decodes unexpected, fatal errors from the caller, issues an
+ * alert, and either panics or BUGs, depending on mount options.
+ *
+ * MODIFIED:
+ *  - We don't have btrfs_test_opt() yet, kill that and s_id.
+ */
+__cold
+void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
+		   unsigned int line, int error, const char *fmt, ...)
+{
+	const char *errstr;
+	struct va_format vaf = { .fmt = fmt };
+	va_list args;
+#if 0
+	char *s_id = "<unknown>";
+
+	if (fs_info)
+		s_id = fs_info->sb->s_id;
+#endif
+
+	va_start(args, fmt);
+	vaf.va = &args;
+
+	errstr = btrfs_decode_error(error);
+#if 0
+	if (fs_info && (btrfs_test_opt(fs_info, PANIC_ON_FATAL_ERROR)))
+		panic(KERN_CRIT "BTRFS panic (device %s) in %s:%d: %pV (error=%d %s)\n",
+			s_id, function, line, &vaf, error, errstr);
+#endif
+
+	btrfs_crit(fs_info, "panic in %s:%d: %pV (error=%d %s)",
+		   function, line, &vaf, error, errstr);
+	va_end(args);
+	/* Caller calls BUG() */
+}
diff --git a/kernel-shared/messages.h b/kernel-shared/messages.h
new file mode 100644
index 00000000..92fa124f
--- /dev/null
+++ b/kernel-shared/messages.h
@@ -0,0 +1,253 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_MESSAGES_H
+#define BTRFS_MESSAGES_H
+
+#include "kerncompat.h"
+#include <linux/types.h>
+
+struct btrfs_fs_info;
+struct btrfs_trans_handle;
+
+static inline __printf(2, 3) __cold
+void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
+{
+}
+
+#ifdef CONFIG_PRINTK
+
+#define btrfs_printk(fs_info, fmt, args...)				\
+	_btrfs_printk(fs_info, fmt, ##args)
+
+__printf(2, 3)
+__cold
+void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
+
+#else
+
+#define btrfs_printk(fs_info, fmt, args...) \
+	btrfs_no_printk(fs_info, fmt, ##args)
+#endif
+
+#define btrfs_emerg(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_EMERG fmt, ##args)
+#define btrfs_alert(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_ALERT fmt, ##args)
+#define btrfs_crit(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_CRIT fmt, ##args)
+#define btrfs_err(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_ERR fmt, ##args)
+#define btrfs_warn(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_WARNING fmt, ##args)
+#define btrfs_notice(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_NOTICE fmt, ##args)
+#define btrfs_info(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_INFO fmt, ##args)
+
+/*
+ * Wrappers that use printk_in_rcu
+ */
+#define btrfs_emerg_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_EMERG fmt, ##args)
+#define btrfs_alert_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_ALERT fmt, ##args)
+#define btrfs_crit_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_CRIT fmt, ##args)
+#define btrfs_err_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_ERR fmt, ##args)
+#define btrfs_warn_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_WARNING fmt, ##args)
+#define btrfs_notice_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_NOTICE fmt, ##args)
+#define btrfs_info_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_INFO fmt, ##args)
+
+/*
+ * Wrappers that use a ratelimited printk_in_rcu
+ */
+#define btrfs_emerg_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_EMERG fmt, ##args)
+#define btrfs_alert_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_ALERT fmt, ##args)
+#define btrfs_crit_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_CRIT fmt, ##args)
+#define btrfs_err_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_ERR fmt, ##args)
+#define btrfs_warn_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_WARNING fmt, ##args)
+#define btrfs_notice_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_NOTICE fmt, ##args)
+#define btrfs_info_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_INFO fmt, ##args)
+
+/*
+ * Wrappers that use a ratelimited printk
+ */
+#define btrfs_emerg_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_EMERG fmt, ##args)
+#define btrfs_alert_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_ALERT fmt, ##args)
+#define btrfs_crit_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_CRIT fmt, ##args)
+#define btrfs_err_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_ERR fmt, ##args)
+#define btrfs_warn_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_WARNING fmt, ##args)
+#define btrfs_notice_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_NOTICE fmt, ##args)
+#define btrfs_info_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_INFO fmt, ##args)
+
+#if defined(CONFIG_DYNAMIC_DEBUG)
+#define btrfs_debug(fs_info, fmt, args...)				\
+	_dynamic_func_call_no_desc(fmt, btrfs_printk,			\
+				   fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_in_rcu(fs_info, fmt, args...)			\
+	_dynamic_func_call_no_desc(fmt, btrfs_printk_in_rcu,		\
+				   fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_rl_in_rcu(fs_info, fmt, args...)			\
+	_dynamic_func_call_no_desc(fmt, btrfs_printk_rl_in_rcu,		\
+				   fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_rl(fs_info, fmt, args...)				\
+	_dynamic_func_call_no_desc(fmt, btrfs_printk_ratelimited,	\
+				   fs_info, KERN_DEBUG fmt, ##args)
+#elif defined(DEBUG)
+#define btrfs_debug(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_DEBUG fmt, ##args)
+#else
+#define btrfs_debug(fs_info, fmt, args...) \
+	btrfs_no_printk(fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_in_rcu(fs_info, fmt, args...) \
+	btrfs_no_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_no_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_rl(fs_info, fmt, args...) \
+	btrfs_no_printk(fs_info, KERN_DEBUG fmt, ##args)
+#endif
+
+#define btrfs_printk_in_rcu(fs_info, fmt, args...)	\
+do {							\
+	rcu_read_lock();				\
+	btrfs_printk(fs_info, fmt, ##args);		\
+	rcu_read_unlock();				\
+} while (0)
+
+#define btrfs_no_printk_in_rcu(fs_info, fmt, args...)	\
+do {							\
+	rcu_read_lock();				\
+	btrfs_no_printk(fs_info, fmt, ##args);		\
+	rcu_read_unlock();				\
+} while (0)
+
+#define btrfs_printk_ratelimited(fs_info, fmt, args...)		\
+do {								\
+	static DEFINE_RATELIMIT_STATE(_rs,			\
+		DEFAULT_RATELIMIT_INTERVAL,			\
+		DEFAULT_RATELIMIT_BURST);			\
+	if (__ratelimit(&_rs))					\
+		btrfs_printk(fs_info, fmt, ##args);		\
+} while (0)
+
+#define btrfs_printk_rl_in_rcu(fs_info, fmt, args...)		\
+do {								\
+	rcu_read_lock();					\
+	btrfs_printk_ratelimited(fs_info, fmt, ##args);		\
+	rcu_read_unlock();					\
+} while (0)
+
+#ifdef CONFIG_BTRFS_ASSERT
+void __cold btrfs_assertfail(const char *expr, const char *file, int line);
+
+#define ASSERT(expr)						\
+	(likely(expr) ? (void)0 : btrfs_assertfail(#expr, __FILE__, __LINE__))
+#else
+#define ASSERT(expr)	(void)(expr)
+#endif
+
+void __cold btrfs_print_v0_err(struct btrfs_fs_info *fs_info);
+
+__printf(5, 6)
+__cold
+void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function,
+		     unsigned int line, int error, const char *fmt, ...);
+
+const char * __attribute_const__ btrfs_decode_error(int error);
+
+__cold
+void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
+			       const char *function,
+			       unsigned int line, int error, bool first_hit);
+
+/*
+ * Call btrfs_abort_transaction as early as possible when an error condition is
+ * detected, that way the exact line number is reported.
+ *
+ * MODIFIED:
+ *  - We do not have fs_info->fs_state.
+ *  - We do not have test_and_set_bit.
+ */
+#if 0
+#define btrfs_abort_transaction(trans, error)		\
+do {								\
+	bool first = false;					\
+	/* Report first abort since mount */			\
+	if (!test_and_set_bit(BTRFS_FS_STATE_TRANS_ABORTED,	\
+			&((trans)->fs_info->fs_state))) {	\
+		first = true;					\
+		if ((error) != -EIO && (error) != -EROFS) {		\
+			WARN(1, KERN_DEBUG				\
+			"BTRFS: Transaction aborted (error %d)\n",	\
+			(error));					\
+		} else {						\
+			btrfs_debug((trans)->fs_info,			\
+				    "Transaction aborted (error %d)", \
+				  (error));			\
+		}						\
+	}							\
+	__btrfs_abort_transaction((trans), __func__,		\
+				  __LINE__, (error), first);	\
+} while (0)
+#else
+#define btrfs_abort_transaction(trans, error)				\
+	__btrfs_abort_transaction((trans), __func__, __LINE__,		\
+				  (error), false)
+#endif
+
+#define btrfs_handle_fs_error(fs_info, error, fmt, args...)		\
+	__btrfs_handle_fs_error((fs_info), __func__, __LINE__,		\
+				(error), fmt, ##args)
+
+__printf(5, 6)
+__cold
+void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
+		   unsigned int line, int error, const char *fmt, ...);
+/*
+ * If BTRFS_MOUNT_PANIC_ON_FATAL_ERROR is in mount_opt, __btrfs_panic
+ * will panic().  Otherwise we BUG() here.
+ */
+#define btrfs_panic(fs_info, error, fmt, args...)			\
+do {									\
+	__btrfs_panic(fs_info, __func__, __LINE__, error, fmt, ##args);	\
+	BUG();								\
+} while (0)
+
+#if BITS_PER_LONG == 32
+#define BTRFS_32BIT_MAX_FILE_SIZE (((u64)ULONG_MAX + 1) << PAGE_SHIFT)
+/*
+ * The warning threshold is 5/8th of the MAX_LFS_FILESIZE that limits the logical
+ * addresses of extents.
+ *
+ * For 4K page size it's about 10T, for 64K it's 160T.
+ */
+#define BTRFS_32BIT_EARLY_WARN_THRESHOLD (BTRFS_32BIT_MAX_FILE_SIZE * 5 / 8)
+void btrfs_warn_32bit_limit(struct btrfs_fs_info *fs_info);
+void btrfs_err_32bit_limit(struct btrfs_fs_info *fs_info);
+#endif
+
+#endif
diff --git a/kernel-shared/transaction.c b/kernel-shared/transaction.c
index 28b16848..141171ba 100644
--- a/kernel-shared/transaction.c
+++ b/kernel-shared/transaction.c
@@ -277,8 +277,3 @@ error:
 	free(trans);
 	return ret;
 }
-
-void btrfs_abort_transaction(struct btrfs_trans_handle *trans, int error)
-{
-	trans->fs_info->transaction_aborted = error;
-}
diff --git a/kernel-shared/transaction.h b/kernel-shared/transaction.h
index 599cc954..27b27123 100644
--- a/kernel-shared/transaction.h
+++ b/kernel-shared/transaction.h
@@ -47,6 +47,5 @@ int commit_tree_roots(struct btrfs_trans_handle *trans,
 			     struct btrfs_fs_info *fs_info);
 int btrfs_commit_transaction(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root);
-void btrfs_abort_transaction(struct btrfs_trans_handle *trans, int error);
 
 #endif
diff --git a/kernel-shared/ulist.c b/kernel-shared/ulist.c
index e193b02d..0cd4f74f 100644
--- a/kernel-shared/ulist.c
+++ b/kernel-shared/ulist.c
@@ -21,6 +21,7 @@
 #include "kerncompat.h"
 #include "ulist.h"
 #include "kernel-shared/ctree.h"
+#include "messages.h"
 
 /*
  * ulist is a generic data structure to hold a collection of unique u64
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index cc0d6b6f..adbe144e 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -22,6 +22,7 @@
 #include <stdbool.h>
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/volumes.h"
+#include "messages.h"
 
 #ifdef BTRFS_ZONED
 #include <linux/blkzoned.h>
diff --git a/libbtrfs/ctree.h b/libbtrfs/ctree.h
index 298351fb..b1c4eed9 100644
--- a/libbtrfs/ctree.h
+++ b/libbtrfs/ctree.h
@@ -26,6 +26,7 @@
 #include "kernel-lib/rbtree.h"
 #include "kerncompat.h"
 #include "kernel-shared/uapi/btrfs.h"
+#include "kernel-shared/messages.h"
 #else
 #include <btrfs/list.h>
 #include <btrfs/rbtree.h>
diff --git a/mkfs/main.c b/mkfs/main.c
index df091b16..6d4ca540 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -37,6 +37,7 @@
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/zoned.h"
+#include "kernel-shared/messages.h"
 #include "crypto/crc32c.h"
 #include "common/defs.h"
 #include "common/internal.h"
-- 
2.26.3

