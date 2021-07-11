Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB38A3C3DDE
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jul 2021 18:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhGKQNE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Jul 2021 12:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhGKQNE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Jul 2021 12:13:04 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93434C0613DD
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jul 2021 09:10:16 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso9010835pjp.2
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jul 2021 09:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LUBGQy1hJIpFdKt7KRUn4nXzjC4+9tZoJ40Y1Yv3hmY=;
        b=hNvKGAPmB4L4bpInYDI+BaA0wPBolVM3jgwJCRbsbkuQQjgs2YOOMn0wwivk/NgclG
         PUuyYHimP7M9+wy+ofyCUYtXMb4zFtWwuJcxw6RDCtHrzj3LHsu155MRm/SpiT+gJ4Bf
         9hMTxtg9vTwGMSQ8sse7cN78smRRVXkkTPeDWft2OMdrU31SOw5CdyUMPmrRzKNlrQFA
         7lHjn1b9ntmtQWPEQdXvhAJH0ub7izk3AMc5oUzKfhn5ToKfyiEI5hhN4OiSDttgPcIM
         b6aqbSKt1xLBfixDeoSSg9mv95+ABH+vCnFKozMDpQp99ACDhYRoVIr247HriMdKnuaV
         3hoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LUBGQy1hJIpFdKt7KRUn4nXzjC4+9tZoJ40Y1Yv3hmY=;
        b=tEFh4vf3bsQSq2ZL0ghb+62MejxBMXOuum7EbPZ7BMPR2JyNsrch9rmaF/7e6NrwjH
         mXLFsieMtwEY5hwc0Qw5/jnr1QVzlfB8kRPPsV9vCxhELuUDRfIpz0FzMdbA7+aC2kl3
         IKRv6B7bOMrnbfFGJ/YQ/kMFis9r1T9TMwL7o8vhbu4As+1bN4GtjYlgynTs2xMoo2l8
         TvhMwm71Dy+Q7b41fIJsHvKSWfy6hy70h1v6wAlsDmcYkE5HaIMzgPlRlT3BrIrF/Fke
         l6PABPcn+Ii3IgojmRLbtANSfY0oom1vWzkUP8GZBVzybvH304wD+v0Mzo19y1pzzX7A
         elxw==
X-Gm-Message-State: AOAM532WEhp+THDGcdQ+ycQusc2hqbHDusBiFBZ4n03x5Bw7QKfqP1PB
        WwuYCzgRw622HFSbPDucGrUuIni6ij3DEw==
X-Google-Smtp-Source: ABdhPJzDJ05vcX9EragM1cFhUxne1X5Z4uStSbd1P0XKqPIJC9e0CumpfW2UC/Qw0tGVn7yfnR34kg==
X-Received: by 2002:a17:90a:520e:: with SMTP id v14mr9601416pjh.163.1626019816016;
        Sun, 11 Jul 2021 09:10:16 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id b10sm12508785pfi.122.2021.07.11.09.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 09:10:15 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v2] btrfs-progs: cmds: Add subcommand that dumps file extents
Date:   Sun, 11 Jul 2021 16:10:07 +0000
Message-Id: <20210711161007.68589-1-realwakka@gmail.com>
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
v2:
 - Prints type and compression
 - Use the terms from file_extents_item like disk_bytenr not like physical"
---
 Makefile                         |   2 +-
 cmds/commands.h                  |   2 +-
 cmds/inspect-dump-file-extents.c | 165 +++++++++++++++++++++++++++++++
 cmds/inspect.c                   |   1 +
 4 files changed, 168 insertions(+), 2 deletions(-)
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
index 00000000..8574a1d0
--- /dev/null
+++ b/cmds/inspect-dump-file-extents.c
@@ -0,0 +1,165 @@
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
+static void compress_type_to_str(u8 compress_type, char *ret)
+{
+	switch (compress_type) {
+	case BTRFS_COMPRESS_NONE:
+		strcpy(ret, "none");
+		break;
+	case BTRFS_COMPRESS_ZLIB:
+		strcpy(ret, "zlib");
+		break;
+	case BTRFS_COMPRESS_LZO:
+		strcpy(ret, "lzo");
+		break;
+	case BTRFS_COMPRESS_ZSTD:
+		strcpy(ret, "zstd");
+		break;
+	default:
+		sprintf(ret, "UNKNOWN.%d", compress_type);
+	}
+}
+
+static const char* file_extent_type_to_str(u8 type)
+{
+	switch (type) {
+	case BTRFS_FILE_EXTENT_INLINE: return "inline";
+	case BTRFS_FILE_EXTENT_PREALLOC: return "prealloc";
+	case BTRFS_FILE_EXTENT_REG: return "regular";
+	default: return "unknown";
+	}
+}
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
+				printf("type = %s, begin = %llu, ",
+					   file_extent_type_to_str(extent_item->type), begin);
+				switch (extent_item->type) {
+				case BTRFS_FILE_EXTENT_INLINE:
+					len = le64_to_cpu(extent_item->ram_bytes);
+					printf("end = %llu\n", begin + len);
+					break;
+				case BTRFS_FILE_EXTENT_REG:
+				case BTRFS_FILE_EXTENT_PREALLOC:
+					len = le64_to_cpu(extent_item->num_bytes);
+					disk_bytenr = le64_to_cpu(extent_item->disk_bytenr);
+					disk_num_bytes = le64_to_cpu(extent_item->disk_num_bytes);
+					offset = le64_to_cpu(extent_item->offset);
+					compress_type_to_str(extent_item->compression, compress_str);
+					printf("end = %llu, disk_bytenr = %llu, disk_num_bytes = %llu,"
+						   " offset = %llu, compression = %s\n",
+						   begin + len, disk_bytenr, disk_num_bytes, offset, compress_str);
+
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

