Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FEA3C866B
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 16:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbhGNO5x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 10:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239510AbhGNO5x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 10:57:53 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351DEC06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 07:55:01 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s18so2691020pgg.8
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 07:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RwxhhSOsJ1aPSyOvSctKcFRkwIMK+Fs/sJ4foqKsnY0=;
        b=hG1b5oUfUK0ZG19ZgtoCRPrTMWnKYOAIGS0s9CGe9mjtQU3sNy/9b1nOzTMDk44X1i
         zo9N2EFsCFZGPwyZ8LTPKN6wwNeY+V+r67urR44hG+zF25O1xTh64oxvXq1vJurRHP41
         0nPCqR/VF9/TKUDesINJb3AD3AA8G2KRDzgCDRa9mFCcc7WybhGihnqGcKg2ti6vP3P9
         NGWDOpP/SmbusRev3aDcrER8JpqK2pC+vkRSR/sd8gQbW72rThK5BSloZW4CayMLMsKz
         J05Vd6vHQXjcyqneqy+YMnH0/cZn076+kVP6vohE2fe+yAnKy9K312rnGgncqKpQIrSu
         W50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RwxhhSOsJ1aPSyOvSctKcFRkwIMK+Fs/sJ4foqKsnY0=;
        b=MZYHVEGLDsmJ1k+p7w9kXmRkX1nMUlYMTzj8Gt4Do2rUWKcEWIPCE0EYChtLG+3Sjr
         XcaB0cqRQRGrlOZVfIBIGHucQ+wRVVz5DZTcNS0CAHeCi04Ofk5uv7nU6JxGiPD+Of2E
         ex9h7hHBhQrhuw+RBcG/wNBlAmHtqET+OT7UY09PdNZ2lVq5kpUgcecMtRf6b8XHuvZu
         FGS/Yb001p1bNCNY+KP+2V+7ypOQiCk6slTMRDx7wgatzUQlAd35KDBxY0/6hpVxAY5y
         IpWq3Qo+K10M3APW3xNrMBSftiYW2MBMqsh/RTMfJ9lyi4/DvPoBDdJpIm8RfjJMkkQm
         lRag==
X-Gm-Message-State: AOAM532awhF3rGkZvi4b1L9yF9O9ir4ZFC82ZJHiXw7E0nU+IA2RCcfE
        j4dx1ChBkCQ1lDvFX5K2rgk6gXbOL+l9nQ==
X-Google-Smtp-Source: ABdhPJzvZ2txIf+QYWf9+c7veiY6pwAc7cHW4URU5w1s6DZ6gqWNBN7XXPZniO6jkdVH5O5TnUwA9A==
X-Received: by 2002:a63:1126:: with SMTP id g38mr9926762pgl.452.1626274500610;
        Wed, 14 Jul 2021 07:55:00 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id u24sm3353639pfm.141.2021.07.14.07.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 07:55:00 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v3 2/2] btrfs-progs: cmds: Add subcommand that dumps file extents
Date:   Wed, 14 Jul 2021 14:54:37 +0000
Message-Id: <20210714145437.75710-2-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210714145437.75710-1-realwakka@gmail.com>
References: <20210714145437.75710-1-realwakka@gmail.com>
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
v2:
 - Prints type and compression
 - Use the terms from file_extents_item like disk_bytenr not like
   "physical"
v3:
 - export util functions for removing duplication
 - change the way to loop with search ioctl
---
 Makefile                         |   2 +-
 cmds/commands.h                  |   2 +-
 cmds/inspect-dump-file-extents.c | 134 +++++++++++++++++++++++++++++++
 cmds/inspect.c                   |   1 +
 4 files changed, 137 insertions(+), 2 deletions(-)
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
index 00000000..2497eeb1
--- /dev/null
+++ b/cmds/inspect-dump-file-extents.c
@@ -0,0 +1,134 @@
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
+#include "kernel-shared/print-tree.h"
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
+	u64 buf_off;
+	u64 len;
+	u64 start;
+	u64 disk_bytenr;
+	u64 disk_num_bytes;
+	u64 offset;
+	int ret;
+	int i;
+	char compress_str[16];
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
+	sk->tree_id = lookup.treeid;
+	sk->min_objectid = statbuf.st_ino;
+	sk->max_objectid = statbuf.st_ino;
+	sk->min_offset = 0;
+	sk->max_offset = UINT64_MAX;
+	sk->min_transid = 0;
+	sk->max_transid = UINT64_MAX;
+	sk->min_type = sk->max_type = BTRFS_EXTENT_DATA_KEY;
+	sk->nr_items = UINT32_MAX;
+
+again:
+	if (ioctl(fd, BTRFS_IOC_TREE_SEARCH, &args)) {
+		error("failed to search tree ioctl %s: %m", argv[optind]);
+		ret = 1;
+		goto out;
+	}
+
+	buf_off = 0;
+	for(i=0; i<sk->nr_items; ++i) {
+		header = (struct btrfs_ioctl_search_header *)(args.buf + buf_off);
+
+		if (btrfs_search_header_type(header) == BTRFS_EXTENT_DATA_KEY) {
+			extent_item = (struct btrfs_file_extent_item *)(header + 1);
+			start = btrfs_search_header_offset(header);
+
+			printf("type = %s, start = %llu, ",
+				   btrfs_file_extent_type_to_str(extent_item->type), start);
+			switch (extent_item->type) {
+			case BTRFS_FILE_EXTENT_INLINE:
+				len = le64_to_cpu(extent_item->ram_bytes);
+				printf("len = %llu\n", len);
+				break;
+			case BTRFS_FILE_EXTENT_REG:
+			case BTRFS_FILE_EXTENT_PREALLOC:
+				len = le64_to_cpu(extent_item->num_bytes);
+				disk_bytenr = le64_to_cpu(extent_item->disk_bytenr);
+				disk_num_bytes = le64_to_cpu(extent_item->disk_num_bytes);
+				offset = le64_to_cpu(extent_item->offset);
+				btrfs_compress_type_to_str(extent_item->compression, compress_str);
+				printf("len = %llu, disk_bytenr = %llu, disk_num_bytes = %llu,"
+					   " offset = %llu, compression = %s\n",
+					   len, disk_bytenr, disk_num_bytes, offset, compress_str);
+
+				break;
+			}
+
+		}
+		buf_off += sizeof(*header) + btrfs_search_header_len(header);
+	}
+	if (sk->nr_items > 512) {
+		sk->nr_items = UINT32_MAX;
+		sk->min_offset = start + 1;
+		goto again;
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

