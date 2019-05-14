Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E1E1C95C
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2019 15:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfENNZi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 May 2019 09:25:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:48116 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726246AbfENNZh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 May 2019 09:25:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7111DAD55
        for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2019 13:25:36 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 2/3] btrfs-progs: add 'btrfs inspect-internal csum-dump' command
Date:   Tue, 14 May 2019 15:25:31 +0200
Message-Id: <20190514132532.16934-3-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190514132532.16934-1-jthumshirn@suse.de>
References: <20190514132532.16934-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a 'btrfs inspect-internal csum-dump' command to dump the on-disk
checksums of a file.

The dump command first uses the FIEMAP ioctl() to get a map of the file's
extents and then uses the BTRFS_TREE_SEARCH_V2 ioctl() to get the
checksums for these extents.

Using FIEMAP instead of the BTRFS_TREE_SEARCH_V2 ioctl() to get the
extents allows us to quickly filter out any holes in the file, as this is
already done for us in the kernel.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 Makefile                 |   3 +-
 cmds-inspect-dump-csum.c | 238 +++++++++++++++++++++++++++++++++++++++++++++++
 cmds-inspect.c           |   2 +
 commands.h               |   2 +
 4 files changed, 244 insertions(+), 1 deletion(-)
 create mode 100644 cmds-inspect-dump-csum.c

diff --git a/Makefile b/Makefile
index e25e256f96af..f5d0c0532faf 100644
--- a/Makefile
+++ b/Makefile
@@ -130,7 +130,8 @@ cmds_objects = cmds-subvolume.o cmds-filesystem.o cmds-device.o cmds-scrub.o \
 	       cmds-restore.o cmds-rescue.o chunk-recover.o super-recover.o \
 	       cmds-property.o cmds-fi-usage.o cmds-inspect-dump-tree.o \
 	       cmds-inspect-dump-super.o cmds-inspect-tree-stats.o cmds-fi-du.o \
-	       mkfs/common.o check/mode-common.o check/mode-lowmem.o
+	       cmds-inspect-dump-csum.o mkfs/common.o check/mode-common.o \
+	       check/mode-lowmem.o
 libbtrfs_objects = send-stream.o send-utils.o kernel-lib/rbtree.o btrfs-list.o \
 		   kernel-lib/crc32c.o messages.o \
 		   uuid-tree.o utils-lib.o rbtree-utils.o
diff --git a/cmds-inspect-dump-csum.c b/cmds-inspect-dump-csum.c
new file mode 100644
index 000000000000..02ebd462041e
--- /dev/null
+++ b/cmds-inspect-dump-csum.c
@@ -0,0 +1,238 @@
+/*
+ * Copyright (C) 2019 SUSE. All rights reserved.
+ *
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
+#include <linux/fiemap.h>
+#include <linux/fs.h>
+
+#include <sys/types.h>
+#include <sys/ioctl.h>
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <string.h>
+#include <fcntl.h>
+#include <getopt.h>
+
+#include "kerncompat.h"
+#include "ctree.h"
+#include "messages.h"
+#include "help.h"
+#include "ioctl.h"
+#include "utils.h"
+#include "disk-io.h"
+
+static bool debug = false;
+
+static int btrfs_lookup_csum_for_extent(int fd, struct btrfs_super_block *sb,
+					struct fiemap_extent *fe)
+{
+	struct btrfs_ioctl_search_args_v2 *search;
+	struct btrfs_ioctl_search_key *sk;
+	const int bufsz = 1024;
+	char buf[bufsz], *bp;
+	unsigned int off = 0;
+	const int csum_size = btrfs_super_csum_size(sb);
+	const int sector_size = btrfs_super_sectorsize(sb);
+	int ret, i, j;
+	u64 phys = fe->fe_physical;
+	u64 needle = phys;
+	u64 pending_csum_count = fe->fe_length / sector_size;
+
+	memset(buf, 0, sizeof(buf));
+	search = (struct btrfs_ioctl_search_args_v2 *)buf;
+	sk = &search->key;
+
+again:
+	if (debug)
+		printf(
+"Looking up checksums for extent at physial offset: %llu (searching at %llu), looking for %llu csums\n",
+		       phys, needle, pending_csum_count);
+
+	sk->tree_id = BTRFS_CSUM_TREE_OBJECTID;
+	sk->min_objectid = BTRFS_EXTENT_CSUM_OBJECTID;
+	sk->max_objectid = BTRFS_EXTENT_CSUM_OBJECTID;
+	sk->max_type = BTRFS_EXTENT_CSUM_KEY;
+	sk->min_type = BTRFS_EXTENT_CSUM_KEY;
+	sk->min_offset = needle;
+	sk->max_offset = (u64)-1;
+	sk->max_transid = (u64)-1;
+	sk->nr_items = 1;
+	search->buf_size = bufsz - sizeof(*search);
+
+	ret = ioctl(fd, BTRFS_IOC_TREE_SEARCH_V2, search);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * If we don't find the csum item at @needle go back by @sector_size and
+	 * retry until we've found it.
+	 */
+	if (sk->nr_items == 0) {
+		needle -= sector_size;
+		goto again;
+	}
+
+
+	bp = (char *) search->buf;
+
+	for (i = 0; i < sk->nr_items; i++) {
+		struct btrfs_ioctl_search_header *sh;
+		u64 csums_in_item;
+
+		sh = (struct btrfs_ioctl_search_header *) (bp + off);
+		off += sizeof(*sh);
+
+		csums_in_item = btrfs_search_header_len(sh) / csum_size;
+		csums_in_item = min(csums_in_item, pending_csum_count);
+
+		for (j = 0; j < csums_in_item; j++) {
+			struct btrfs_csum_item *csum_item;
+
+			csum_item = (struct btrfs_csum_item *)
+						(bp + off + j * csum_size);
+
+			printf("Offset: %llu, checksum: 0x%08x\n",
+			       phys + j * sector_size, *(u32 *)csum_item);
+		}
+
+		off += btrfs_search_header_len(sh);
+		pending_csum_count -= csums_in_item;
+
+	}
+
+	return ret;
+}
+
+static int btrfs_get_extent_csum(int fd, struct btrfs_super_block *sb)
+{
+	struct fiemap *fiemap, *tmp;
+	size_t ext_size;
+	int ret, i;
+
+	fiemap = calloc(1, sizeof(*fiemap));
+	if (!fiemap)
+		return -ENOMEM;
+
+	fiemap->fm_length = ~0;
+
+	ret = ioctl(fd, FS_IOC_FIEMAP, fiemap);
+	if (ret)
+		goto free_fiemap;
+
+	ext_size = fiemap->fm_mapped_extents * sizeof(struct fiemap_extent);
+
+	tmp = realloc(fiemap, sizeof(*fiemap) + ext_size);
+	if (!tmp) {
+		ret = -ENOMEM;
+		goto free_fiemap;
+	}
+
+	fiemap = tmp;
+	fiemap->fm_extent_count = fiemap->fm_mapped_extents;
+	fiemap->fm_mapped_extents = 0;
+
+	ret = ioctl(fd, FS_IOC_FIEMAP, fiemap);
+	if (ret)
+		goto free_fiemap;
+
+	for (i = 0; i < fiemap->fm_mapped_extents; i++) {
+
+		ret = btrfs_lookup_csum_for_extent(fd, sb,
+						   &fiemap->fm_extents[i]);
+		if (ret)
+			break;
+	}
+
+
+free_fiemap:
+	free(fiemap);
+	return ret;
+}
+
+const char * const cmd_inspect_dump_csum_usage[] = {
+	"btrfs inspect-internal dump-csum <path> <device>",
+	"Get Checksums for a given file",
+	"-d|--debug    Be more verbose",
+	NULL
+};
+
+int cmd_inspect_dump_csum(int argc, char **argv)
+{
+	struct btrfs_super_block sb;
+	char *filename;
+	char *device;
+	int fd;
+	int devfd;
+	int ret;
+
+	optind = 0;
+
+	while (1) {
+		static const struct option longopts[] = {
+			{ "debug", no_argument, NULL, 'd' },
+			{ NULL, 0, NULL, 0 }
+		};
+
+		int opt = getopt_long(argc, argv, "d", longopts, NULL);
+		if (opt < 0)
+			break;
+
+		switch (opt) {
+		case 'd':
+			debug = true;
+			break;
+		default:
+			usage(cmd_inspect_dump_csum_usage);
+		}
+	}
+
+	if (check_argc_exact(argc - optind, 2))
+		usage(cmd_inspect_dump_csum_usage);
+
+	filename = argv[optind];
+	device = argv[optind + 1];
+
+	fd = open(filename, O_RDONLY);
+	if (fd < 0) {
+		error("cannot open file %s:%m", filename);
+		return -errno;
+	}
+
+	devfd = open(device, O_RDONLY);
+	if (devfd < 0) {
+		ret = -errno;
+		goto out_close;
+	}
+	load_sb(devfd, btrfs_sb_offset(0), &sb);
+	close(devfd);
+
+	if (btrfs_super_magic(&sb) != BTRFS_MAGIC) {
+		ret = -EINVAL;
+		error("bad magic on superblock on %s", device);
+		goto out_close;
+	}
+
+	ret = btrfs_get_extent_csum(fd, &sb);
+	if (ret)
+		error("checsum lookup for file %s failed", filename);
+out_close:
+	close(fd);
+	return ret;
+}
diff --git a/cmds-inspect.c b/cmds-inspect.c
index efea0331b7aa..c20decbf6fac 100644
--- a/cmds-inspect.c
+++ b/cmds-inspect.c
@@ -654,6 +654,8 @@ const struct cmd_group inspect_cmd_group = {
 				cmd_inspect_dump_super_usage, NULL, 0 },
 		{ "tree-stats", cmd_inspect_tree_stats,
 				cmd_inspect_tree_stats_usage, NULL, 0 },
+		{ "dump-csum",  cmd_inspect_dump_csum,
+				cmd_inspect_dump_csum_usage, NULL, 0 },
 		NULL_CMD_STRUCT
 	}
 };
diff --git a/commands.h b/commands.h
index 76991f2b28d5..698ae532b2b8 100644
--- a/commands.h
+++ b/commands.h
@@ -92,6 +92,7 @@ extern const char * const cmd_rescue_usage[];
 extern const char * const cmd_inspect_dump_super_usage[];
 extern const char * const cmd_inspect_dump_tree_usage[];
 extern const char * const cmd_inspect_tree_stats_usage[];
+extern const char * const cmd_inspect_dump_csum_usage[];
 extern const char * const cmd_filesystem_du_usage[];
 extern const char * const cmd_filesystem_usage_usage[];
 
@@ -108,6 +109,7 @@ int cmd_super_recover(int argc, char **argv);
 int cmd_inspect(int argc, char **argv);
 int cmd_inspect_dump_super(int argc, char **argv);
 int cmd_inspect_dump_tree(int argc, char **argv);
+int cmd_inspect_dump_csum(int argc, char **argv);
 int cmd_inspect_tree_stats(int argc, char **argv);
 int cmd_property(int argc, char **argv);
 int cmd_send(int argc, char **argv);
-- 
2.16.4

