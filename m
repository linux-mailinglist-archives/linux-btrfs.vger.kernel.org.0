Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A97401E95
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 18:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241778AbhIFQgc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 12:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhIFQgb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Sep 2021 12:36:31 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC04C061575
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Sep 2021 09:35:26 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 18so5973602pfh.9
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Sep 2021 09:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Djw1cBVDlvQELrM5mqQ9VrZPkZp4vKod9NeIeWJERRY=;
        b=YlVkm1R4cxR768OWWW462SpYB1RO/uVjVjbJ+k8lgKyb9OfiX1bmwA8ZrsvCU8SgWS
         nWdh8bqQ2f6LBMj+1e4o9+rXL3a7zdQvyyYaNuzBhu9hlICMukoXzsIs9svFgKlQilNn
         IEAW9HtJ9ZsHHgFHwkskPI5O2a2/gns8+HPiKmLeyFatXUKStKnr/vFvRBFuLUWoFus1
         w/OTkhXIxtr9yEKfFHU2KPtJrM/imG2wOkygx1iNVoSMy/yMV+7AMgKAeKSkhOGZS07K
         jPvAfF+zHMsX5XPa0t+eeH/kCV+fJcKUcI4MTTprG1qlqEocG/5IXPMILIT/nIAXlcV1
         Uo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Djw1cBVDlvQELrM5mqQ9VrZPkZp4vKod9NeIeWJERRY=;
        b=fsF3NSZfqW+UCsHW3PQIOZYaM4chEACutYN6JBR0MycFraau2LAHV2HiUsZXbqG7dJ
         xPgOirtPQfb8jbLBxwWaJAn60nvlgJxphIVDWeUuK+J9HoXGdB5nT+4f1Pi74hIgd58o
         baqzigsXnrzVhbCnyRqTiL3DIciaA2eDKbQnci3fAWer2eqov2Py6j3RgXBMTwxxyT2N
         jAH8FYVOac9u+/fOYaCP9h75ZTA3IWSFcOEDl7aNbwz9N2PRBOW2u9OIWLPVOpY/Q0mS
         LHwYP5xc04FDBa0AhrudenYzA7lR8MGqNgoCUWXIhGRG/03Z+5PhE80DDDDViKaBjV0i
         dYDA==
X-Gm-Message-State: AOAM533e6D5vM5h9/dx+L1XLmhmS9IIT+yh9EY7Hfh7uKVCRpwo+4/HQ
        aCEQp9ekK6pzyAC+7xCKBpCXwvXo61E=
X-Google-Smtp-Source: ABdhPJzqOuS0NhOG4PTAkqFSaymzs5lduJoImlMLrW1rC/P34XY+Apk19wbvrho3lX93agN2vostZA==
X-Received: by 2002:a63:5f8f:: with SMTP id t137mr12993994pgb.420.1630946125859;
        Mon, 06 Sep 2021 09:35:25 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id s5sm10410062pgp.81.2021.09.06.09.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 09:35:25 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [RFC PATCH] btrfs-progs: cmds: filesystem: introduce reflink command
Date:   Mon,  6 Sep 2021 16:35:13 +0000
Message-Id: <20210906163513.6709-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, I'm trying to handle btrfs-progs issue #396. This is incomplete code
for solving problem. Because it doesn't copy file properies like
compression. I read some code in btrfs-props/props.h but it seems that
there is no convenient way to copy props. Is there any good way to copy
props? Thanks for reading.

This patch handles btrfs-progs issue #396. This command does a reflink
from A to B and copies its fileattrs. And it can make reflink with
source ranges to target ranges. This code gets paths and ranges of both
source and targets. it make reflink by calling ioctl FICLONERANGE and
also it copies fileattrs.
---
 Makefile                          |   2 +-
 cmds/commands.h                   |   1 +
 cmds/filesystem-reflink.c         | 124 +++++++++++++++++++++++++++
 cmds/filesystem-reflink.c~        |  73 ++++++++++++++++
 cmds/filesystem.c                 |   1 +
 cmds/inspect-dump-fiemap.c~       |   0
 cmds/inspect-dump-file-extents.c~ | 135 ++++++++++++++++++++++++++++++
 7 files changed, 335 insertions(+), 1 deletion(-)
 create mode 100644 cmds/filesystem-reflink.c
 create mode 100644 cmds/filesystem-reflink.c~
 create mode 100644 cmds/inspect-dump-fiemap.c~
 create mode 100644 cmds/inspect-dump-file-extents.c~

diff --git a/Makefile b/Makefile
index a1cc457b..b0cd9ec7 100644
--- a/Makefile
+++ b/Makefile
@@ -156,7 +156,7 @@ cmds_objects = cmds/subvolume.o cmds/filesystem.o cmds/device.o cmds/scrub.o \
 	       cmds/restore.o cmds/rescue.o cmds/rescue-chunk-recover.o \
 	       cmds/rescue-super-recover.o \
 	       cmds/property.o cmds/filesystem-usage.o cmds/inspect-dump-tree.o \
-	       cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/filesystem-du.o \
+	       cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/filesystem-du.o cmds/filesystem-reflink.o \
 	       mkfs/common.o check/mode-common.o check/mode-lowmem.o
 libbtrfs_objects = common/send-stream.o common/send-utils.o kernel-lib/rbtree.o btrfs-list.o \
 		   kernel-lib/radix-tree.o common/extent-cache.o kernel-shared/extent_io.o \
diff --git a/cmds/commands.h b/cmds/commands.h
index 7d46c6f4..65cc18e4 100644
--- a/cmds/commands.h
+++ b/cmds/commands.h
@@ -133,6 +133,7 @@ DECLARE_COMMAND(subvolume);
 DECLARE_COMMAND(filesystem);
 DECLARE_COMMAND(filesystem_du);
 DECLARE_COMMAND(filesystem_usage);
+DECLARE_COMMAND(filesystem_reflink);
 DECLARE_COMMAND(balance);
 DECLARE_COMMAND(device);
 DECLARE_COMMAND(scrub);
diff --git a/cmds/filesystem-reflink.c b/cmds/filesystem-reflink.c
new file mode 100644
index 00000000..059bebdb
--- /dev/null
+++ b/cmds/filesystem-reflink.c
@@ -0,0 +1,124 @@
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
+#include <stdio.h>
+#include <unistd.h>
+#include <getopt.h>
+#include <fcntl.h>
+
+#include <linux/fs.h>
+#include <sys/ioctl.h>
+
+#include "kernel-shared/ctree.h"
+
+#include "cmds/commands.h"
+
+static const char * const cmd_filesystem_reflink_usage[] = {
+	"btrfs filesystem reflink --source <path> --src-offset <offset> --length <length> --dest <path> --offset <offset>",
+	"make reflinks from source file to dest files.",
+	"",
+	"-s|--src      source file path",
+	"--src-offset    start offset of source file",
+	"-l|--length   length of reflink",
+	"-d|--dest      destination file path",
+	"--dest-offset   offset of dest file",
+	NULL
+};
+
+static int cmd_filesystem_reflink(const struct cmd_struct *cmd,
+			     int argc, char **argv)
+{
+	const char *src_path;
+	const char *dest_path;
+	u64 src_offset, dest_offset, length;
+	int src_fd, dest_fd, ret;
+	struct file_clone_range range;
+
+	while (1) {
+		enum {
+			GETOPT_VAL_SRC_OFFSET = 256,
+			GETOPT_VAL_DEST_OFFSET
+		};
+
+		static const struct option long_options[] = {
+			{ "src", required_argument, NULL, 's'},
+			{ "src-offset", required_argument, NULL, GETOPT_VAL_SRC_OFFSET},
+			{ "length", required_argument, NULL, 'l'},
+			{ "dest", required_argument, NULL, 'd'},
+			{ "dest-offset", required_argument, NULL, GETOPT_VAL_DEST_OFFSET},
+			{ NULL, 0, NULL, 0 }
+		};
+		int c = getopt_long(argc, argv, "s:l:d:", long_options, NULL);
+
+		if (c < 0)
+			break;
+		switch (c) {
+		case 's':
+			src_path = optarg;
+			break;
+		case GETOPT_VAL_SRC_OFFSET:
+			src_offset = parse_size_from_string(optarg);
+			break;
+		case 'l':
+			length = parse_size_from_string(optarg);
+			break;
+		case 'd':
+			dest_path = optarg;
+			break;
+		case GETOPT_VAL_DEST_OFFSET:
+			dest_offset = parse_size_from_string(optarg);
+			break;
+		default:
+			usage_unknown_option(cmd, argv);
+		}
+	}
+
+	if (check_argc_exact(argc - optind, 0))
+		return 1;
+
+	src_fd = open(src_path, O_RDONLY);
+	if (src_fd < 0) {
+		error("cannot open src path %s", src_path);
+		return 1;
+	}
+
+	dest_fd = open(dest_path, O_WRONLY|O_CREAT, 0666);
+	if (dest_fd < 0) {
+		close(src_fd);
+		error("cannot open dest path %s", dest_path);
+		return 1;
+	}
+
+	memset(&range, 0, sizeof(range));
+	range.src_fd = src_fd;
+	range.src_offset = src_offset;
+	range.src_length = length;
+	range.dest_offset = dest_offset;
+
+	ret = ioctl(dest_fd, FICLONERANGE, &range);
+
+	if (ret < 0)
+		error("clone range failed : %m");
+
+	/* it should copy properties */
+
+	close(src_fd);
+	close(dest_fd);
+
+	return ret;
+}
+
+DEFINE_SIMPLE_COMMAND(filesystem_reflink, "reflink");
diff --git a/cmds/filesystem-reflink.c~ b/cmds/filesystem-reflink.c~
new file mode 100644
index 00000000..06916a05
--- /dev/null
+++ b/cmds/filesystem-reflink.c~
@@ -0,0 +1,73 @@
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
+#include <stdio.h>
+#include <unistd.h>
+#include <getopt.h>
+
+static const char * const cmd_filesystem_reflink_usage[] = {
+	"btrfs filesystem reflink --source <path> --src-offset <offset> --length <length> --target <path> --offset <offset>",
+	"make reflinks from source file to dest files.",
+	"",
+	"-s|--src      source file path",
+	"-o|--start    start offset of source file",
+	"-l|--length   length of reflink",
+	"-t|--target   target file path",	
+	"-o|--offset   offset of dest file",	
+	NULL
+};
+
+static int cmd_filesystem_reflink(const struct cmd_struct *cmd,
+			     int argc, char **argv)
+{
+	while (1) {
+		static const struct option long_options[] = {
+			{ "src", required_argument, NULL, 's'},
+			{ "start", required_argument, NULL, 'o'},
+			{ "length", required_argument, NULL, 'l'},
+			{ "target", required_argument, NULL, 't'},
+			{ "offset", required_argument, NULL, 'f'},
+			{ NULL, 0, NULL, 0 }
+		};
+		int c = getopt_long(argc, argv, "s:o:l:t:f:", long_options, NULL);
+
+		if (c < 0)
+			break;
+		switch (c) {
+		case 's':
+			printf ("option -s with value `%s'\n", optarg);
+			break;
+		case 'o':
+			printf ("option -s with value `%s'\n", optarg);
+			break;
+		case 'l':
+			printf ("option -s with value `%s'\n", optarg);
+			break;
+		case 't':
+			printf ("option -s with value `%s'\n", optarg);
+			break;
+		case 'f':
+			printf ("option -s with value `%s'\n", optarg);
+			break;
+		default:
+			usage_unknown_option(cmd, argv);
+		}
+	}
+	
+	return 0;
+}
+
+DEFINE_SIMPLE_COMMAND(filesystem_reflink, "reflink");
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index db8433ba..30ce6d55 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1381,6 +1381,7 @@ static const struct cmd_group filesystem_cmd_group = {
 		&cmd_struct_filesystem_resize,
 		&cmd_struct_filesystem_label,
 		&cmd_struct_filesystem_usage,
+		&cmd_struct_filesystem_reflink,
 		NULL
 	}
 };
diff --git a/cmds/inspect-dump-fiemap.c~ b/cmds/inspect-dump-fiemap.c~
new file mode 100644
index 00000000..e69de29b
diff --git a/cmds/inspect-dump-file-extents.c~ b/cmds/inspect-dump-file-extents.c~
new file mode 100644
index 00000000..1beed9fd
--- /dev/null
+++ b/cmds/inspect-dump-file-extents.c~
@@ -0,0 +1,135 @@
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
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include <errno.h>
+
+#include <sys/ioctl.h>
+
+#include <linux/fs.h>
+#include <linux/fiemap.h>
+
+#include "common/utils.h"
+#include "cmds/commands.h"
+
+static const char * const cmd_inspect_dump_fiemap_usage[] = {
+	"btrfs inspect-internal dump-extent path",
+	"Dump file extent in a textual form",
+	NULL
+};
+
+static int cmd_inspect_dump_fiemap(const struct cmd_struct *cmd,
+				  int argc, char **argv)
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
+	int i;	
+	u64 len;
+	u64 begin;
+	u64 physical;
+	u64 offset;
+	u64 physical_len;
+	int ret;
+	
+	fd = open(argv[optind], O_RDONLY);
+	if (fd < 0) {
+		error("cannot open %s: %m", argv[optind]);
+		ret = 1;
+		goto exit;
+	}
+
+	if (fstat(fd, &statbuf) < 0) {
+		error("failed to fstat %s: %m", argv[optind]);
+		ret = 1;
+		goto exit;
+	}
+
+	lookup.treeid = 0;
+	lookup.objectid = BTRFS_FIRST_FREE_OBJECTID;
+
+	if (ioctl(fd, BTRFS_IOC_INO_LOOKUP, &lookup) < 0) {
+		error("failed to lookup inode %s: %m", argv[optind]);
+		ret = 1;
+		goto exit;
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
+			goto exit;
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
+					printf("end = 0x%llx, physical = 0x%llx, physical_len = 0x%llx\n", begin + len, physical, physical_len);
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
+ exit:
+	close(fd);
+	return ret;
+}
+DEFINE_SIMPLE_COMMAND(inspect_dump_file_extents, "dump-file-extents");
-- 
2.25.1

