Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B21326FB2
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Feb 2021 01:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhB1AEL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 27 Feb 2021 19:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhB1AEK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 27 Feb 2021 19:04:10 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F61C06174A
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Feb 2021 16:03:29 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id h8so13061543qkk.6
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Feb 2021 16:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JzKvirtjcLemrbUutm8uDqTY7phWcRWC1VE1ktUvSbk=;
        b=ZnYxF9l/DN4sqYk/bS5wtdzhSqM+W0vAsc9EAmlBd9Yoe0/Sup7KgTP9jPov6AAunm
         vpFD207VbP89Uw4iQwbCotu3sePErtw6vQMiJGTwThx70SwApxJn6waB2p1LRrhT4O2B
         aottMsWk+GaWn1cKYFLHH5IDNxAM9/sokMznpXuPFpSBvW/RHRQ7IbYAINKMfU7bVVGi
         E37pxGk9fPNCqxxNCdy7kSSXdijR45s22ZncMrYdz9DG6EVAsoTJqTC8dOR/o2v2KimF
         ZyFVZadELPSa/p3s2Tt/vbmusFWw/vUPAyFIVoGxNnLBcdA/UFxATxkRDN7mnTp0ui4h
         8V1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JzKvirtjcLemrbUutm8uDqTY7phWcRWC1VE1ktUvSbk=;
        b=k+djC9nRCxs8NcwgC7VKCbh3ki+bjjnwfaEY6YdaDsMHzp9SiDigJUknd0+7h/8y8M
         9jS/dnJVJ01lXd7cfOU6C4XOK0+bXgiOk6g3mqBh+PTObAZz0xCf2BDAjxkXHUG0huFV
         ZMMUOxWcF1808EBPwK+tCHrUPXhDPriv8WmHOgKpG7kbRrChVY/Y0MMF/znLjV6M3VSV
         QZLNw7O2H2xLf3mUvYqi3pBKASg5V/y4OacoDoEBr8uA9kRoFHPFjT6CIzRB2yYdB+52
         sy5yVeWU34WThCesVXsKkuOJby/SRCfk/d7Mm2RxhYg08xJhXFmx5AO0dstCZBpasTHw
         zwfg==
X-Gm-Message-State: AOAM531GCuTk67SVZVHH2TF/4pnDdHUF2Q0cAUfiKq1lGqVdHmWZ24Af
        Xbx8xOVlEbYFp890oylHtzosB4SxmHx10w==
X-Google-Smtp-Source: ABdhPJyLnYVG9imBGnvfHvt5eA8buXvRgu3AJsEEH8bwwE+CPJnR7Ccv3FAJi7PT0yCN4IFjZ7d6/g==
X-Received: by 2002:a05:620a:12ae:: with SMTP id x14mr9022616qki.25.1614470608593;
        Sat, 27 Feb 2021 16:03:28 -0800 (PST)
Received: from localhost.localdomain ([81.198.235.160])
        by smtp.gmail.com with ESMTPSA id t71sm9543942qka.86.2021.02.27.16.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 16:03:28 -0800 (PST)
From:   =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
Subject: [PATCH 1/1] btrfs-progs: Implement dump-raw command
Date:   Sun, 28 Feb 2021 02:04:49 +0200
Message-Id: <20210228000448.41694-2-davispuh@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210228000448.41694-1-davispuh@gmail.com>
References: <20210228000448.41694-1-davispuh@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This command allows to inspect raw blocks.
It also shows information about where specified block is read from.
---
 Android.mk              |   3 +-
 Makefile                |   3 +-
 cmds/commands.h         |   1 +
 cmds/inspect-dump-raw.c | 343 ++++++++++++++++++++++++++++++++++++++++
 cmds/inspect.c          |   1 +
 5 files changed, 349 insertions(+), 2 deletions(-)
 create mode 100644 cmds/inspect-dump-raw.c

diff --git a/Android.mk b/Android.mk
index a45e87aa..40873dd5 100644
--- a/Android.mk
+++ b/Android.mk
@@ -31,7 +31,8 @@ cmds_objects := cmds-subvolume.c cmds-filesystem.c cmds-device.c cmds-scrub.c \
                cmds-quota.c cmds-qgroup.c cmds-replace.c cmds-check.c \
                cmds-restore.c cmds-rescue.c chunk-recover.c super-recover.c \
                cmds-property.c cmds-fi-usage.c cmds-inspect-dump-tree.c \
-               cmds-inspect-dump-super.c cmds-inspect-tree-stats.c cmds-fi-du.c \
+               cmds-inspect-dump-raw.c cmds-inspect-dump-super.c \
+               cmds-inspect-tree-stats.c cmds-fi-du.c \
                mkfs/common.c
 libbtrfs_objects := common/send-stream.c common/send-utils.c kernel-lib/rbtree.c btrfs-list.c \
                    crypto/crc32c.c messages.c \
diff --git a/Makefile b/Makefile
index 40c5aee0..ea6e4921 100644
--- a/Makefile
+++ b/Makefile
@@ -165,7 +165,8 @@ cmds_objects = cmds/subvolume.o cmds/filesystem.o cmds/device.o cmds/scrub.o \
 	       cmds/restore.o cmds/rescue.o cmds/rescue-chunk-recover.o \
 	       cmds/rescue-super-recover.o \
 	       cmds/property.o cmds/filesystem-usage.o cmds/inspect-dump-tree.o \
-	       cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/filesystem-du.o \
+	       cmds/inspect-dump-raw.o cmds/inspect-dump-super.o \
+	       cmds/inspect-tree-stats.o cmds/filesystem-du.o \
 	       mkfs/common.o check/mode-common.o check/mode-lowmem.o
 libbtrfs_objects = common/send-stream.o common/send-utils.o kernel-lib/rbtree.o btrfs-list.o \
 		   kernel-lib/radix-tree.o common/extent-cache.o kernel-shared/extent_io.o \
diff --git a/cmds/commands.h b/cmds/commands.h
index 8fa85d6c..57a976bb 100644
--- a/cmds/commands.h
+++ b/cmds/commands.h
@@ -142,6 +142,7 @@ DECLARE_COMMAND(super_recover);
 DECLARE_COMMAND(inspect);
 DECLARE_COMMAND(inspect_dump_super);
 DECLARE_COMMAND(inspect_dump_tree);
+DECLARE_COMMAND(inspect_dump_raw);
 DECLARE_COMMAND(inspect_tree_stats);
 DECLARE_COMMAND(property);
 DECLARE_COMMAND(send);
diff --git a/cmds/inspect-dump-raw.c b/cmds/inspect-dump-raw.c
new file mode 100644
index 00000000..5f41aea4
--- /dev/null
+++ b/cmds/inspect-dump-raw.c
@@ -0,0 +1,343 @@
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
+#include <stdbool.h>
+#include <getopt.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <dirent.h>
+
+#include "kerncompat.h"
+#include "kernel-shared/ctree.h"
+#include "kernel-shared/disk-io.h"
+#include "kernel-shared/volumes.h"
+#include "common/device-scan.h"
+#include "common/utils.h"
+#include "cmds/commands.h"
+
+static const char * const cmd_inspect_dump_raw_usage[] = {
+	"btrfs inspect-internal dump-raw [options] <device> [<device> ..]",
+	"Dump blocks from a given device in raw form",
+	"",
+	"-b|--block <block_num>   dump specified block",
+	"                         can be specified multiple times",
+	"-m|--mirror <mirror_num> use specific mirror, useful only when they differ",
+	"--force                  continue even if block is corrupted",
+	NULL
+};
+
+/*
+ * Helper function to record all tree block bytenr so we don't need to put
+ * all code into deep indent.
+ *
+ * Return >0 if we hit a duplicated bytenr (already recorded)
+ * Return 0 if nothing went wrong
+ * Return <0 if error happens (ENOMEM)
+ *
+ * For != 0 return value, all warning/error will be outputted by this function.
+ */
+static int dump_add_tree_block(struct cache_tree *tree, u64 bytenr)
+{
+	int ret;
+
+	/*
+	 * We don't really care about the size and we don't have
+	 * nodesize before we open the fs, so just use 1 as size here.
+	 */
+	ret = add_cache_extent(tree, bytenr, 1);
+	if (ret == -EEXIST) {
+		warning("tree block bytenr %llu is duplicated", bytenr);
+		return 1;
+	}
+	if (ret < 0) {
+		error("failed to record tree block bytenr %llu: %d(%s)",
+			bytenr, ret, strerror(-ret));
+		return ret;
+	}
+	return ret;
+}
+
+int read_whole_eb_verbose(struct btrfs_fs_info *info, struct extent_buffer *eb, int mirror, u64 bytenr)
+{
+	unsigned long offset = 0;
+	struct btrfs_multi_bio *multi = NULL;
+	struct btrfs_device *device;
+	int ret = 0;
+	u64 read_len;
+	unsigned long bytes_left = eb->len;
+	char uuid_str[BTRFS_UUID_UNPARSED_SIZE];
+
+	while (bytes_left) {
+		read_len = bytes_left;
+		device = NULL;
+
+		ret = btrfs_map_block(info, READ, eb->start + offset,
+				      &read_len, &multi, mirror, NULL);
+		if (ret) {
+			printk("Couldn't map the block %Lu\n", eb->start + offset);
+			kfree(multi);
+			return -EIO;
+		}
+		device = multi->stripes[0].dev;
+
+		if (device->fd <= 0) {
+			kfree(multi);
+			return -EIO;
+		}
+
+		eb->fd = device->fd;
+		device->total_ios++;
+		eb->dev_bytenr = multi->stripes[0].physical;
+		kfree(multi);
+		multi = NULL;
+
+
+		if (read_len > bytes_left)
+			read_len = bytes_left;
+
+		uuid_unparse(device->uuid, uuid_str);
+		fprintf(stderr, "block %llu, mirror %d: reading %llu bytes from device %s at offset %llu\n",
+			bytenr, mirror, read_len, uuid_str, eb->dev_bytenr);
+		ret = read_extent_from_disk(eb, offset, read_len);
+		if (ret)
+			return -EIO;
+		offset += read_len;
+		bytes_left -= read_len;
+	}
+	return 0;
+}
+
+static struct extent_buffer* read_tree_block_mirror(struct btrfs_fs_info *fs_info, u64 bytenr,
+						    int mirror_num, bool force)
+{
+	struct extent_buffer *eb;
+	int ret = 0;
+	int num_copies;
+	int current_mirror = 0;
+
+	/*
+	 * Please note that here we can't check it against nodesize,
+	 * as it's possible a chunk is just aligned to sectorsize but
+	 * not aligned to nodesize.
+	 */
+	if (!IS_ALIGNED(bytenr, fs_info->sectorsize)) {
+		error("tree block bytenr %llu is not aligned to sectorsize %u",
+		      bytenr, fs_info->sectorsize);
+		return ERR_PTR(-EINVAL);
+	}
+
+	eb = btrfs_find_create_tree_block(fs_info, bytenr);
+	if (!eb)
+		return ERR_PTR(-ENOMEM);
+
+	num_copies = btrfs_num_copies(fs_info, eb->start, eb->len);
+	if (mirror_num >= 0) {
+		if (mirror_num >= num_copies) {
+			error("block %llu has only %d mirror(s), can't use specified mirror",
+			       bytenr, num_copies);
+
+			ret = -EINVAL;
+			goto error;
+		}
+		fprintf(stderr, "block %llu: using mirror %d from %d mirrors\n", bytenr, mirror_num, num_copies);
+		current_mirror = mirror_num;
+	}
+
+	while (current_mirror < num_copies) {
+		ret = read_whole_eb_verbose(fs_info, eb, current_mirror, bytenr);
+		if (ret == 0) {
+			if (csum_tree_block(fs_info, eb, 1) == 0 ||
+			    (force && (mirror_num >= 0 || current_mirror + 1 == num_copies))
+			) {
+				btrfs_set_buffer_uptodate(eb);
+				return eb;
+			}
+			ret = -EIO;
+		}
+		if (mirror_num >= 0) {
+			break;
+		}
+		current_mirror++;
+	}
+
+error:
+	/*
+	 * We failed to read this tree block, it be should deleted right now
+	 * to avoid stale cache populate the cache.
+	 */
+	free_extent_buffer_nocache(eb);
+	return ERR_PTR(ret);
+}
+
+/*
+ *
+ * Return 0 if nothing wrong happened for *each* tree blocks
+ * Return <0 if anything wrong happened, and return value will be the last
+ * error.
+ */
+static int dump_raw_blocks(struct btrfs_fs_info *fs_info,
+			   struct cache_tree *tree, int mirror_num, bool force)
+{
+	FILE *out = stdout;
+	struct cache_extent *ce;
+	struct extent_buffer *eb;
+	u64 bytenr;
+	int ret = 0;
+	int i = 0;
+
+
+	ce = first_cache_extent(tree);
+	while (ce) {
+		bytenr = ce->start;
+
+		eb = read_tree_block_mirror(fs_info, bytenr, mirror_num, force);
+		if (!extent_buffer_uptodate(eb)) {
+			error("failed to read tree block %llu", bytenr);
+			ret = -EIO;
+			goto next;
+		}
+
+		if (isatty(fileno(out))) {
+			for (i = 0; i < eb->len; i++) {
+				if (i % 16 == 0) {
+					fprintf(out, "\n%08x  ", i);
+				} else if ((i + 8) % 16 == 0) {
+					fprintf(out, " ");
+				}
+				fprintf(out, "%02x ", eb->data[i] & 0xff);
+			}
+			fprintf(out, "\n");
+		} else {
+			fwrite(eb->data, eb->len, 1, out);
+		}
+
+		free_extent_buffer(eb);
+next:
+		remove_cache_extent(tree, ce);
+		free(ce);
+		ce = first_cache_extent(tree);
+	}
+	return ret;
+}
+
+static int cmd_inspect_dump_raw(const struct cmd_struct *cmd,
+				int argc, char **argv)
+{
+	struct btrfs_fs_info *info;
+	struct cache_tree block_root;	/* for multiple --block parameters */
+	int ret = 0;
+	int dev_optind;
+	unsigned open_ctree_flags;
+	u64 block_bytenr;
+	int mirror_num = -1;
+	bool force = false;
+
+	open_ctree_flags = OPEN_CTREE_PARTIAL | OPEN_CTREE_NO_BLOCK_GROUPS;
+	cache_tree_init(&block_root);
+	optind = 0;
+	while (1) {
+		int c;
+		static const struct option long_options[] = {
+			{ "block", required_argument, NULL, 'b'},
+			{ "mirror", required_argument, NULL, 'm'},
+			{ "force", no_argument, NULL, 'f'},
+			{ NULL, 0, NULL, 0 }
+		};
+
+		c = getopt_long(argc, argv, "b:m:", long_options, NULL);
+		if (c < 0)
+			break;
+		switch (c) {
+		case 'b':
+			/*
+			 * No need to fill roots other than chunk root
+			 */
+			open_ctree_flags |= __OPEN_CTREE_RETURN_CHUNK_ROOT;
+			block_bytenr = arg_strtou64(optarg);
+			ret = dump_add_tree_block(&block_root, block_bytenr);
+			if (ret < 0)
+				goto out;
+			break;
+		case 'm':
+			mirror_num = arg_strtou64(optarg);
+			break;
+		case 'f':
+			force = true;
+			break;
+		default:
+			usage_unknown_option(cmd, argv);
+		}
+	}
+
+	if (check_argc_min(argc - optind, 1))
+		return 1;
+
+	dev_optind = optind;
+	while (dev_optind < argc) {
+		int fd;
+		struct btrfs_fs_devices *fs_devices;
+		u64 num_devices;
+
+		ret = check_arg_type(argv[optind]);
+		if (ret != BTRFS_ARG_BLKDEV && ret != BTRFS_ARG_REG) {
+			if (ret < 0) {
+				errno = -ret;
+				error("invalid argument %s: %m", argv[dev_optind]);
+			} else {
+				error("not a block device or regular file: %s",
+				       argv[dev_optind]);
+			}
+		}
+		fd = open(argv[dev_optind], O_RDONLY);
+		if (fd < 0) {
+			error("cannot open %s: %m", argv[dev_optind]);
+			return -EINVAL;
+		}
+		ret = btrfs_scan_one_device(fd, argv[dev_optind], &fs_devices,
+					    &num_devices,
+					    BTRFS_SUPER_INFO_OFFSET,
+					    SBREAD_DEFAULT);
+		close(fd);
+		if (ret < 0) {
+			errno = -ret;
+			error("device scan %s: %m", argv[dev_optind]);
+			return ret;
+		}
+		dev_optind++;
+	}
+
+	fprintf(stderr, "%s\n", PACKAGE_STRING);
+
+	info = open_ctree_fs_info(argv[optind], 0, 0, 0, open_ctree_flags);
+	if (!info) {
+		error("unable to open %s", argv[optind]);
+		ret = -EIO;
+		goto out;
+	}
+
+	if (!cache_tree_empty(&block_root)) {
+		ret = dump_raw_blocks(info, &block_root, mirror_num, force);
+	} else {
+		error("No blocks specified");
+		ret = -EINVAL;
+	}
+
+	close_ctree(info->chunk_root);
+out:
+	return !!ret;
+}
+DEFINE_SIMPLE_COMMAND(inspect_dump_raw, "dump-raw");
diff --git a/cmds/inspect.c b/cmds/inspect.c
index 15f19c8a..2d133830 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -693,6 +693,7 @@ static const struct cmd_group inspect_cmd_group = {
 		&cmd_struct_inspect_min_dev_size,
 		&cmd_struct_inspect_dump_tree,
 		&cmd_struct_inspect_dump_super,
+		&cmd_struct_inspect_dump_raw,
 		&cmd_struct_inspect_tree_stats,
 		NULL
 	}
-- 
2.30.1

