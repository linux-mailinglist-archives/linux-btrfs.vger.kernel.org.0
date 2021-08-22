Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114E03F4034
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Aug 2021 17:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhHVPCn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Aug 2021 11:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbhHVPCm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Aug 2021 11:02:42 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B110C061575
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Aug 2021 08:02:01 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mq3so10292218pjb.5
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Aug 2021 08:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUqt/HOa7tYeaazdC6LR3UwsHpiwY4kdrFXz9A5yQYU=;
        b=a1OLj1kXzsCOWKXY5EQ/WyJPRA5K8+ZmcnUJNW+hD6VabYLORMFxBbytdqPa1uPs9o
         vTtfoLgxHDDX+qng6RPQodXRGIlkXyo2pNLyRfjyHHIH0PX1plDF5eUwRbansydt/+Kx
         7yvO37hGMfflkuiyqg+J8KY2BRuMFGCnw4zxtNzPAjO1Sy7vzeb1m1QnuRSBlB5cpccy
         d5a66MJiHf64Yrk7iJBty1F1i09xY/IDKZHe+J4swMnzwl9USSkrQmKsMP+q+s9dvp7U
         px0/lkmTCCJ4iibUkQZWg32qejagDUcEpOnk+ORXdCyRbUU4qhToyKb9aqqOl1rrnZmI
         J8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUqt/HOa7tYeaazdC6LR3UwsHpiwY4kdrFXz9A5yQYU=;
        b=BMdKgvzIRf3IeHoT3LuWWJogWxC/aa1+TMNLo1UWygDwtYM2Pzosb08oYFcxcRn0HK
         2/PorWzlSTZ6tvjMGNQ+zmqS2t/0xVivOEkeIoX7AwBn1IDlEw8LjyKIeAxL8wJWfWPN
         bI6967vmghORDILuGWFO+bsfKXA/0WjT6G8owNB67f9/mZUMzCnJoIhOmpo1XwCMBicD
         ZVDiMyoSY0A02jNmZqf0gm1MoWC5bWZ6HYHDKqJ5OqvjXqDKQoEEug2zGRWJSqr4+rtV
         4TIkgp4qHbC80qCeeTLYIIQmqbQOm0VMdjTg0cMaRgXzU5drNqeoRen299K9HnB9CPo0
         95Kw==
X-Gm-Message-State: AOAM532IIRTE+rABwPgYGsKtaWtyuxW8KSyDm72Yx5ciUpHFybc+sKW/
        jFaYjqZTP4kD1a64BrazPGjMkVBSLMMIhg==
X-Google-Smtp-Source: ABdhPJx/zo/JmH9uaSKxHZM6RGLQjewMdclCGdlRGC2TLcHoWrtrLxGRv4INSwCowlWz0z2PUlVizg==
X-Received: by 2002:a17:90a:2b89:: with SMTP id u9mr15247895pjd.116.1629644520762;
        Sun, 22 Aug 2021 08:02:00 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id n185sm13992266pfn.171.2021.08.22.08.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 08:02:00 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v5 2/2] btrfs-progs: cmds: Add subcommand that dumps file extents
Date:   Sun, 22 Aug 2021 15:01:40 +0000
Message-Id: <20210822150140.44152-3-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210822150140.44152-1-realwakka@gmail.com>
References: <20210822150140.44152-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch adds an subcommand in inspect-internal. It dumps file extents of
the file that user provided. It helps to show the internal information
about file extents comprise the file. It supports json format by using
formatted printing. An example is below.

{
  "__header": {
    "version": "1"
  },
  "file-extents": [
    {
      "start": "0",
      "disk_bytenr": "21651456",
      "disk_num_bytes": "4096",
      "offset": "0",
      "len": "65536",
      "compression": "zstd",
      "type": "regular"
    },
    {
      "start": "65536",
      "len": "131072",
      "compression": "none",
      "type": "hole"
    }
  ]
}

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 Makefile                         |   2 +-
 cmds/commands.h                  |   2 +-
 cmds/inspect-dump-file-extents.c | 161 +++++++++++++++++++++++++++++++
 cmds/inspect.c                   |   1 +
 4 files changed, 164 insertions(+), 2 deletions(-)
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
index 00000000..5f5469a3
--- /dev/null
+++ b/cmds/inspect-dump-file-extents.c
@@ -0,0 +1,161 @@
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
+#include "common/format-output.h"
+#include "cmds/commands.h"
+#include "kernel-shared/print-tree.h"
+
+static const char * const cmd_inspect_dump_file_extents_usage[] = {
+	"btrfs inspect-internal dump-extent path",
+	"Dump file extent in a textual form",
+	NULL
+};
+
+static const struct rowspec dump_file_extents_rowspec[] = {
+	{ .key = "device", .fmt = "%s", .out_text = "device", .out_json = "device" },
+	{ .key = "type", .fmt = "%s", .out_text = "type", .out_json = "type" },
+	{ .key = "start", .fmt = "%u", .out_text = "start", .out_json = "start" },
+	{ .key = "len", .fmt = "%u", .out_text = "len", .out_json = "len" },
+	{ .key = "disk_bytenr", .fmt = "%u", .out_text = "disk_bytenr", .out_json = "disk_bytenr" },
+	{ .key = "disk_num_bytes", .fmt = "%u", .out_text = "disk_num_bytes", .out_json = "disk_num_bytes" },
+	{ .key = "offset", .fmt = "%u", .out_text = "offset", .out_json = "offset" },
+	{ .key = "compression", .fmt = "%s", .out_text = "compression", .out_json = "compression" },
+	ROWSPEC_END
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
+	u64 start, buf_off;
+	int ret, i;
+
+	struct format_ctx fctx;
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
+	fmt_start(&fctx, dump_file_extents_rowspec, 24, 0);
+	fmt_print_start_group(&fctx, "file-extents", JSON_TYPE_ARRAY);
+	for(i=0; i<sk->nr_items; ++i) {
+		header = (struct btrfs_ioctl_search_header *)(args.buf + buf_off);
+
+		if (btrfs_search_header_type(header) == BTRFS_EXTENT_DATA_KEY) {
+			u64 len, disk_bytenr, disk_num_bytes, offset;
+			const char *type_str;
+			char compress_str[BTRFS_COMPRESS_STR_LEN];
+
+			extent_item = (struct btrfs_file_extent_item *)(header + 1);
+			fmt_print_start_group(&fctx, NULL, JSON_TYPE_MAP);
+
+			start = btrfs_search_header_offset(header);
+			fmt_print(&fctx, "start", start);
+			type_str = btrfs_file_extent_type_to_str(extent_item->type);
+			btrfs_compress_type_to_str(extent_item->compression, compress_str);
+
+			switch (extent_item->type) {
+			case BTRFS_FILE_EXTENT_INLINE:
+				len = le64_to_cpu(extent_item->ram_bytes);
+				break;
+			case BTRFS_FILE_EXTENT_REG:
+			case BTRFS_FILE_EXTENT_PREALLOC:
+				len = le64_to_cpu(extent_item->num_bytes);
+				disk_bytenr = le64_to_cpu(extent_item->disk_bytenr);
+				if (disk_bytenr) {
+					disk_num_bytes = le64_to_cpu(extent_item->disk_num_bytes);
+					offset = le64_to_cpu(extent_item->offset);
+					fmt_print(&fctx, "disk_bytenr", disk_bytenr);
+					fmt_print(&fctx, "disk_num_bytes", disk_num_bytes);
+					fmt_print(&fctx, "offset", offset);
+
+				} else {
+					type_str = "hole";
+				}
+				break;
+			}
+
+			fmt_print(&fctx, "len", len);
+			fmt_print(&fctx, "compression", compress_str);
+			fmt_print(&fctx, "type", type_str);
+			fmt_print_end_group(&fctx, NULL);
+		}
+		buf_off += sizeof(*header) + btrfs_search_header_len(header);
+	}
+	fmt_print_end_group(&fctx, "file-extents");
+	fmt_end(&fctx);
+
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
+
+DEFINE_COMMAND_WITH_FLAGS(inspect_dump_file_extents, "dump-file-extents", CMD_FORMAT_JSON);
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

