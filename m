Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14743CC7FE
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jul 2021 08:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhGRGtX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 18 Jul 2021 02:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhGRGtK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 18 Jul 2021 02:49:10 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1233FC061762
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jul 2021 23:46:13 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id h1so7807885plf.6
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jul 2021 23:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=djS4yHu9H9HvU5bm2lyOGyHsUSZNFJ8qFoaLocKNOVM=;
        b=U64PQYfRkpeMRO95RQNWM/y9PRLUM1tCovkpP35KiuHrtZ9qqRsczyG9J1HVjZCqcO
         EjqwG3IhAYVtTOKTBz+EpSRT1++FgZUv3oBj2PvxXj76tqCSwhdcDFTNPUg3x2jY/4/Z
         qop/drsQggG5JBk3gD6xYb/XRY+2E0ddw26knCHtqqo7DBXq0soH/1FBiVgoVYphFsa9
         h5GXl1ZRq64xrWkkp//XX6t5Hf6Wzc1NrOEQl14NcMNV7KZzm3HYsKhEooAINQ8I0TYh
         8oc7Qs4atTFxNRSyr8apSDp1Hyuuc2W4Id2VZ3yBrbLORPCzFaEKRAkWdnxEsxiTkhHB
         MPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=djS4yHu9H9HvU5bm2lyOGyHsUSZNFJ8qFoaLocKNOVM=;
        b=MudQl6lqpvbp9nP4zINbs35sMhfIP7ckoWj/Uwmzg2xAfhLTP+U/VylWHlxkWAHcd8
         U6nhSjNmbkYLOKHaPliZWXR3M7g8UkiWVc1DnUMsFq3NNJy20ShW6UX8JHbQXlkuTQFH
         z5tPqVnQud96ABhYVB7/E64k7kcCIaSlXAQxZO3Olo+tCbRRC+rtPzQ8L/pIoa9yXj/j
         Dt0mEuNaYyW7ze6e81OQjzN/cIrE1nMUfI8yDC8tbSkRGHZSM9/w560hs0W0/HeKW//Y
         667jwTHheNVviZtuk5PAR4nhseFF0uTzI7KU/HS6/pTmW7GAWIEBvQybGKWyT9J5Z6xs
         rpbQ==
X-Gm-Message-State: AOAM53152Yv7JVUdwTJNhN0VfOnaPGoDDCGX6VpaqzwXsU45qPxcbDzJ
        CIlRUwNK/ByfkPyNUxrPp1Huunopvxg=
X-Google-Smtp-Source: ABdhPJwZtpQdFwIWTNDvoUWAGeJFcl06xP3SbNSxsSCBt1ah/PAxK6a6uOjzFhmDERIsuOfcRxeo7Q==
X-Received: by 2002:a17:90a:a087:: with SMTP id r7mr24398538pjp.84.1626590772472;
        Sat, 17 Jul 2021 23:46:12 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id w23sm1302741pfc.60.2021.07.17.23.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 23:46:12 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v4 2/2] btrfs-progs: cmds: Add subcommand that dumps file extents
Date:   Sun, 18 Jul 2021 06:46:01 +0000
Message-Id: <20210718064601.3435-3-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210718064601.3435-1-realwakka@gmail.com>
References: <20210718064601.3435-1-realwakka@gmail.com>
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
index 00000000..5e5bc6f7
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
+	char compress_str[BTRFS_COMPRESS_STR_LEN];
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

