Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329EA3C34E1
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Jul 2021 16:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhGJOoJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Jul 2021 10:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhGJOoJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Jul 2021 10:44:09 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AEDC0613DD
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Jul 2021 07:41:24 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id j9so5935122pfc.5
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Jul 2021 07:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jNjC1i+um7q0O2DwfD8V3j575O+DBdAx/zsw40NkfPw=;
        b=svEE6mrTAofsIU5TTOROmtMyoaW3Vlf6HVTv/GwYtQwH5hf6DH2iwjqud223FlfHDm
         yBqWuNJ21K+voF6LHitGXGX/o9W5gNLzB6ytUyp8CBk8lLJfRFLR9Y6w7iGQ2ZEwNzPu
         ZPc2Bi/4v3mgoN4vYzdTDIdENhY+HG0bMNXzWE0Q148RKTwmbYbFqGUtiVQ97GMUtrQU
         t50wKVn9u9vADTbNvWvpyjU4AV1cx8yABJx1qqjYwAdfJkHZuhxVSfR9TDKT10+MtjVr
         JXWwz26N33qbpKT5Q69QtGZmgLNNuXscLLRF4NhwnWaNm+ozXGKtAwN5MfO6LPETz4C7
         yPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jNjC1i+um7q0O2DwfD8V3j575O+DBdAx/zsw40NkfPw=;
        b=Sir3WQxqUVGS2FeGgU/HgyTMmblXh0HKZ3fMp4YR0jt2My7HUafrmGH6Yyk1qD6Kj2
         VZTvpCe+r/L9DRl1daidi02i+HmQDIjngtkM1jU60homuqznpU8qQznpExoj6Y2L3K1W
         AH9zqcl1o3qtqqLLcolVn6X0pMO8rCgWb98pHHz4GyxYR8mPnOF5d4f8Zh4LIm1SWxyc
         TnsbJHV3UAmB5MWUn0uQNQtS4ZWeg0q+SBKwxMSqs9/0m6GcgBVi1IrKJzE9/uM9AM1R
         XUquIWgZQmGvh1QXfq965oLhHJAYVKtOJ3FOxA8t7VJm9/wplyg125Wxd66d4WSd8nm/
         /bzg==
X-Gm-Message-State: AOAM532ZMMBeL0kNHzUhHM3k6KNMnIDHWv7YFN1F4bBvuM9KV8wU1VXj
        8Rb2h37iNK7UfTxQohtR9H6yCbMGKuZhBg==
X-Google-Smtp-Source: ABdhPJzL51wOWAowOXG6PfdzNH9AzZOiK+ILWrljMGb8/UMMNrJe8JzB/oC8tMXU4/+K5FPv2WbBHA==
X-Received: by 2002:a05:6a00:bd3:b029:329:3e4f:eadb with SMTP id x19-20020a056a000bd3b02903293e4feadbmr6703639pfu.44.1625928077010;
        Sat, 10 Jul 2021 07:41:17 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id i6sm11664594pgg.50.2021.07.10.07.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 07:41:16 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [RFC] btrfs-progs: cmds: Add subcommand that dumps file extents
Date:   Sat, 10 Jul 2021 14:41:07 +0000
Message-Id: <20210710144107.65224-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch adds an subcommand in inspect-internal. It dumps file extents of
the file that user provided. It helps to show the internal information
about file extents comprise the file.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
Hi, I'm writing an patch that adds an subcommand that dumps file extents of
the file. I don't have much idea about btrfs but I referenced btrfs
wiki, dev-docs, and also Zygo's bee. It's just like draft.

I have some questions below.

The command works like below,
# ./btrfs inspect-internal dump-file-extents /mnt/bb/TAGS
begin = 0x0, end = 0x20000, physical = 0x4fdf5000, physical_len = 0xc000
begin = 0x20000, end = 0x40000, physical = 0x4fe01000, physical_len = 0xc000
begin = 0x40000, end = 0x47000, physical = 0x4fe0d000, physical_len = 0x3000

What format would be better?
Is it better to just use the variable name as it is? like disk_bytenr
not like physical_len?

And what option do we need? like showing compression or file extent type?

Any comments will be welcome. Thanks!
---
 Makefile                         |   2 +-
 cmds/commands.h                  |   2 +-
 cmds/inspect-dump-file-extents.c | 130 +++++++++++++++++++++++++++++++
 cmds/inspect.c                   |   1 +
 4 files changed, 133 insertions(+), 2 deletions(-)
 create mode 100644 cmds/inspect-dump-file-extents.c

diff --git a/Makefile b/Makefile
index a1cc457b..911e16de 100644
--- a/Makefile
+++ b/Makefile
@@ -156,7 +156,7 @@ cmds_objects = cmds/subvolume.o cmds/filesystem.o cmds/device.o cmds/scrub.o \
 	       cmds/restore.o cmds/rescue.o cmds/rescue-chunk-recover.o \
 	       cmds/rescue-super-recover.o \
 	       cmds/property.o cmds/filesystem-usage.o cmds/inspect-dump-tree.o \
-	       cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/filesystem-du.o \
+	       cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/inspect-dump-file-extents.o cmds/filesystem-du.o \
 	       mkfs/common.o check/mode-common.o check/mode-lowmem.o
 libbtrfs_objects = common/send-stream.o common/send-utils.o kernel-lib/rbtree.o btrfs-list.o \
 		   kernel-lib/radix-tree.o common/extent-cache.o kernel-shared/extent_io.o \
diff --git a/cmds/commands.h b/cmds/commands.h
index 8fa85d6c..55de248e 100644
--- a/cmds/commands.h
+++ b/cmds/commands.h
@@ -154,5 +154,5 @@ DECLARE_COMMAND(select_super);
 DECLARE_COMMAND(dump_super);
 DECLARE_COMMAND(debug_tree);
 DECLARE_COMMAND(rescue);
-
+DECLARE_COMMAND(inspect_dump_file_extents);
 #endif
diff --git a/cmds/inspect-dump-file-extents.c b/cmds/inspect-dump-file-extents.c
new file mode 100644
index 00000000..99aec7d7
--- /dev/null
+++ b/cmds/inspect-dump-file-extents.c
@@ -0,0 +1,130 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License v2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the
+ * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 021110-1307, USA.
+ */
+
+#include <unistd.h>
+#include <stdio.h>
+#include <fcntl.h>
+
+#include <sys/ioctl.h>
+
+#include "common/utils.h"
+#include "cmds/commands.h"
+
+static const char * const cmd_inspect_dump_file_extents_usage[] = {
+	"btrfs inspect-internal dump-extent path",
+	"Dump file extent in a textual form",
+	NULL
+};
+
+static int cmd_inspect_dump_file_extents(const struct cmd_struct *cmd,
+										 int argc, char **argv)
+{
+	int fd;
+	struct stat statbuf;
+	struct btrfs_ioctl_ino_lookup_args lookup;
+	struct btrfs_ioctl_search_args args;
+	struct btrfs_ioctl_search_key *sk = &args.key;
+	struct btrfs_file_extent_item *extent_item;
+	struct btrfs_ioctl_search_header *header;
+	u64 pos;
+	u64 buf_off;
+	u64 len;
+	u64 begin;
+	u64 physical;
+	u64 offset;
+	u64 physical_len;
+	int ret;
+	int i;
+
+	fd = open(argv[optind], O_RDONLY);
+	if (fd < 0) {
+		error("cannot open %s: %m", argv[optind]);
+		ret = 1;
+		goto out;
+	}
+
+	if (fstat(fd, &statbuf) < 0) {
+		error("failed to fstat %s: %m", argv[optind]);
+		ret = 1;
+		goto out;
+	}
+
+	lookup.treeid = 0;
+	lookup.objectid = BTRFS_FIRST_FREE_OBJECTID;
+
+	if (ioctl(fd, BTRFS_IOC_INO_LOOKUP, &lookup) < 0) {
+		error("failed to lookup inode %s: %m", argv[optind]);
+		ret = 1;
+		goto out;
+	}
+
+	pos = 0;
+
+	sk->tree_id = lookup.treeid;
+	sk->min_objectid = statbuf.st_ino;
+	sk->max_objectid = statbuf.st_ino;
+
+	sk->max_offset = UINT64_MAX;
+	sk->min_transid = 0;
+	sk->max_transid = UINT64_MAX;
+	sk->min_type = sk->max_type = BTRFS_EXTENT_DATA_KEY;
+	sk->nr_items = 4096;
+
+	while (statbuf.st_size > pos) {
+		sk->min_offset = pos;
+		if (ioctl(fd, BTRFS_IOC_TREE_SEARCH, &args)) {
+			error("failed to search tree ioctl %s: %m", argv[optind]);
+			ret = 1;
+			goto out;
+		}
+
+		buf_off = 0;
+		for(i=0; i<sk->nr_items; ++i) {
+			header = (struct btrfs_ioctl_search_header *)(args.buf + buf_off);
+
+			if (btrfs_search_header_type(header) == BTRFS_EXTENT_DATA_KEY) {
+				extent_item = (struct btrfs_file_extent_item *)(header + 1);
+				begin = btrfs_search_header_offset(header);
+
+				printf("begin = 0x%llx, ", begin);
+				switch (extent_item->type) {
+				case BTRFS_FILE_EXTENT_INLINE:
+					len = le64_to_cpu(extent_item->ram_bytes);
+					printf("end = 0x%llx\n", begin + len);
+					break;
+				case BTRFS_FILE_EXTENT_REG:
+				case BTRFS_FILE_EXTENT_PREALLOC:
+					len = le64_to_cpu(extent_item->num_bytes);
+					physical = le64_to_cpu(extent_item->disk_bytenr);
+					physical_len = le64_to_cpu(extent_item->disk_num_bytes);
+					offset = le64_to_cpu(extent_item->offset);
+					printf("end = 0x%llx, physical = 0x%llx, physical_len = 0x%llx\n",
+						   begin + len, physical, physical_len);
+					break;
+				}
+
+			}
+			buf_off += sizeof(*header) + btrfs_search_header_len(header);
+			pos += len;
+		}
+
+	}
+	ret = 0;
+out:
+	close(fd);
+	return ret;
+}
+DEFINE_SIMPLE_COMMAND(inspect_dump_file_extents, "dump-file-extents");
diff --git a/cmds/inspect.c b/cmds/inspect.c
index 2ef5f4b6..dfb0e27b 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -696,6 +696,7 @@ static const struct cmd_group inspect_cmd_group = {
 		&cmd_struct_inspect_dump_tree,
 		&cmd_struct_inspect_dump_super,
 		&cmd_struct_inspect_tree_stats,
+		&cmd_struct_inspect_dump_file_extents,
 		NULL
 	}
 };
-- 
2.25.1

