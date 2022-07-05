Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD99566453
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 09:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiGEHi1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 03:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiGEHiS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 03:38:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505AE13D33
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 00:38:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E29F224AC
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657006696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M0yewmi8EdLEQEOLmsr7b+GZsEtgmCWjKiV6cwI8twI=;
        b=QQ0ZODB7j9t30yhK7f6A+WaDDgA+Yi6ar/Bk+kj2S1f+4nCbQr7q2VRzXynKMCqxRzEXdX
        Cz6AX9n35JQaSp0gHalK92uVH0AjfpRxhi74iuAyB2J9bsXLjGyzD5vNyhibtFo8N0W99+
        fRQNvBk37qZoiWgyFKEeYKA4TV5qVkQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 685661339A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:38:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6OCcDWfqw2JTOwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Jul 2022 07:38:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] btrfs-progs: cmds/inspect: add the ability to dump write intent bitmaps
Date:   Tue,  5 Jul 2022 15:37:47 +0800
Message-Id: <482e48f39f1b7c43a939e50230415e3d2ba3488b.1657006141.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657006141.git.wqu@suse.com>
References: <cover.1657006141.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Makefile                         |   3 +-
 cmds/commands.h                  |   1 +
 cmds/inspect-dump-write-intent.c | 158 +++++++++++++++++++++++++++++++
 cmds/inspect.c                   |   1 +
 kernel-shared/print-tree.c       |  93 ++++++++++++++++++
 kernel-shared/print-tree.h       |   1 +
 6 files changed, 256 insertions(+), 1 deletion(-)
 create mode 100644 cmds/inspect-dump-write-intent.c

diff --git a/Makefile b/Makefile
index ea5a1ae86f30..314a22078a9a 100644
--- a/Makefile
+++ b/Makefile
@@ -203,7 +203,8 @@ cmds_objects = cmds/subvolume.o cmds/subvolume-list.o \
 	       cmds/restore.o cmds/rescue.o cmds/rescue-chunk-recover.o \
 	       cmds/rescue-super-recover.o \
 	       cmds/property.o cmds/filesystem-usage.o cmds/inspect-dump-tree.o \
-	       cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/filesystem-du.o \
+	       cmds/inspect-dump-super.o cmds/inspect-dump-write-intent.o \
+	       cmds/inspect-tree-stats.o cmds/filesystem-du.o \
 	       mkfs/common.o check/mode-common.o check/mode-lowmem.o
 
 libbtrfs_objects = \
diff --git a/cmds/commands.h b/cmds/commands.h
index 9ec50136e29a..166686454137 100644
--- a/cmds/commands.h
+++ b/cmds/commands.h
@@ -141,6 +141,7 @@ DECLARE_COMMAND(check);
 DECLARE_COMMAND(inspect);
 DECLARE_COMMAND(inspect_dump_super);
 DECLARE_COMMAND(inspect_dump_tree);
+DECLARE_COMMAND(inspect_dump_write_intent);
 DECLARE_COMMAND(inspect_tree_stats);
 DECLARE_COMMAND(property);
 DECLARE_COMMAND(send);
diff --git a/cmds/inspect-dump-write-intent.c b/cmds/inspect-dump-write-intent.c
new file mode 100644
index 000000000000..c4d792f23659
--- /dev/null
+++ b/cmds/inspect-dump-write-intent.c
@@ -0,0 +1,158 @@
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
+#include "kerncompat.h"
+#include <stdio.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <getopt.h>
+#include <uuid/uuid.h>
+
+#include "kernel-shared/ctree.h"
+#include "kernel-shared/disk-io.h"
+#include "kernel-shared/volumes.h"
+#include "kernel-shared/write-intent.h"
+#include "kernel-shared/print-tree.h"
+#include "crypto/hash.h"
+#include "common/utils.h"
+#include "cmds/commands.h"
+#include "common/help.h"
+
+static const char * const cmd_inspect_dump_write_intent_usage[] = {
+	"btrfs inspect-internal dump-write-intet [options] device",
+	"Dump the write-intent bitmaps in a textual form",
+	"",
+	"-a|--all              print write-intent bitmaps from every device",
+	"-b|--bytenr <offset>  print write-intent bitmaps using specific physical offset",
+	"-f|--force            print write-intent bitmaps with bad magic",
+};
+
+static int cmd_inspect_dump_write_intent(const struct cmd_struct *cmd,
+					int argc, char **argv)
+{
+	struct open_ctree_flags ocf = { .flags = OPEN_CTREE_PARTIAL |
+						 OPEN_CTREE_NO_BLOCK_GROUPS };
+	struct btrfs_fs_info *fs_info;
+	u8 buf[WRITE_INTENT_BITMAPS_SIZE] = {0};
+	/* Dump all write-intent bitmaps from all involved devices. */
+	bool all = false;
+	/* Force dump even very basic checks failed. */
+	bool force = 0;
+	/* Read the write intent bitmaps from specific physical offset. */
+	u64 bytenr = SZ_1M;
+	char *dev;
+	int fd;
+	int ret = 0;
+
+	while (1) {
+		int c;
+		enum { GETOPT_VAL_BYTENR = 257 };
+		static const struct option long_options[] = {
+			{"all", no_argument, NULL, 'a'},
+			{"bytenr", required_argument, NULL, 'b'},
+			{"force", no_argument, NULL, 'F'},
+			{NULL, 0, NULL, 0}
+		};
+
+		c = getopt_long(argc, argv, "Fb:a", long_options, NULL);
+		if (c < 0)
+			break;
+
+		switch (c) {
+		case 'a':
+			all = 1;
+			break;
+		case 'F':
+			force = 1;
+			break;
+		case 'b':
+			bytenr = arg_strtou64(optarg);
+			break;
+		default:
+			usage_unknown_option(cmd, argv);
+		}
+	}
+	if (check_argc_exact(argc - optind, 1))
+		return 1;
+
+	dev = argv[optind];
+
+	fd = open(argv[optind], O_RDONLY);
+	if (fd < 0) {
+		error("failed to open %s: %m", dev);
+		return 1;
+	}
+	ret = pread64(fd, buf, WRITE_INTENT_BITMAPS_SIZE, bytenr);
+	close(fd);
+	if (ret < WRITE_INTENT_BITMAPS_SIZE) {
+		error("failed to read write intent bitmap from %s", dev);
+		return 1;
+	}
+
+	if (!force && wi_super_magic((struct write_intent_super *)buf) !=
+		WRITE_INTENT_SUPER_MAGIC) {
+		error("no valid write intent super found");
+		return 1;
+	}
+	ocf.filename = dev;
+	fs_info = open_ctree_fs_info(&ocf);
+	if (!fs_info) {
+		/* -a|--all needs to open the fs to find all devces. */
+		if (all || !force) {
+			error("can not open btrfs on %s", ocf.filename);
+			return 1;
+		}
+		/* Forced dump is still fine. */
+		btrfs_print_write_intent(buf);
+		return 0;
+	}
+
+	/* Basic checks, making sure the fs has bitmaps. */
+	if (!force) {
+		if (!btrfs_fs_compat_ro(fs_info, WRITE_INTENT_BITMAP)) {
+			error("no WRITE_INTENT_BITMAP feature");
+			ret = -EINVAL;
+			goto out;
+		}
+		if (fs_info->csum_type != wi_super_csum_type(
+				(struct write_intent_super *)buf)) {
+			error(
+		"mismatched csum type, write intent bitmap has %u fs has %u",
+			      wi_super_csum_type((struct write_intent_super *)buf),
+			      fs_info->csum_type);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+	if (all) {
+		struct btrfs_device *dev;
+
+		list_for_each_entry(dev, &fs_info->fs_devices->devices, dev_list) {
+			printf("devid %llu:\n", dev->devid);
+			btrfs_print_write_intent(buf);
+		}
+		ret = 0;
+		goto out;
+	}
+	btrfs_print_write_intent(buf);
+out:
+	close_ctree(fs_info->tree_root);
+	return !!ret;
+}
+
+DEFINE_SIMPLE_COMMAND(inspect_dump_write_intent, "dump-write-intent");
diff --git a/cmds/inspect.c b/cmds/inspect.c
index 1534f2040f4e..a5c1d289d84f 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -695,6 +695,7 @@ static const struct cmd_group inspect_cmd_group = {
 		&cmd_struct_inspect_dump_tree,
 		&cmd_struct_inspect_dump_super,
 		&cmd_struct_inspect_tree_stats,
+		&cmd_struct_inspect_dump_write_intent,
 		NULL
 	}
 };
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 55875a7bc2d3..105ef2d5b072 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -26,6 +26,7 @@
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/print-tree.h"
 #include "kernel-shared/volumes.h"
+#include "kernel-shared/write-intent.h"
 #include "common/utils.h"
 
 static void print_dir_item_type(struct extent_buffer *eb,
@@ -1934,6 +1935,25 @@ static void print_backup_roots(struct btrfs_super_block *sb)
 	}
 }
 
+#define DEF_WRITE_INTENT_FLAG_ENTRY(bit_name)			\
+	{WRITE_INTENT_FLAGS_##bit_name, #bit_name}
+
+static struct readable_flag_entry write_intent_flags_array[] = {
+	DEF_WRITE_INTENT_FLAG_ENTRY(TARGET_RAID56),
+	DEF_WRITE_INTENT_FLAG_ENTRY(INTERNAL),
+	DEF_WRITE_INTENT_FLAG_ENTRY(BYTENR_LOGICAL),
+};
+
+static const int write_intent_flags_num = sizeof(write_intent_flags_array) /
+					sizeof(struct readable_flag_entry);
+
+static void print_readable_write_intent_flag(u64 flag)
+{
+	return __print_readable_flag(flag, write_intent_flags_array,
+			write_intent_flags_num,
+			WRITE_INTENT_FLAGS_SUPPORTED);
+}
+
 void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
 {
 	int i;
@@ -2100,3 +2120,76 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
 		print_backup_roots(sb);
 	}
 }
+
+void btrfs_print_write_intent(const u8 *buf)
+{
+	struct write_intent_super *wis = (struct write_intent_super *)buf;
+	struct write_intent_entry *wie;
+	bool csum_match;
+	u16 csum_type = wi_super_csum_type(wis);
+	int csum_size;
+	int cur = 0;
+	char uuid_buf[BTRFS_UUID_UNPARSED_SIZE];
+	u8 result[BTRFS_CSUM_SIZE] = { 0 };
+	char *s;
+	int i;
+
+	if (is_valid_csum_type(csum_type)) {
+		csum_size = btrfs_csum_type_size(csum_type);
+		btrfs_csum_data(NULL, csum_type, buf + BTRFS_CSUM_SIZE, result,
+			WRITE_INTENT_BITMAPS_SIZE - BTRFS_CSUM_SIZE);
+		csum_match = !memcmp(result, buf, csum_size);
+	} else {
+		csum_size = BTRFS_CSUM_SIZE;
+		csum_match = false;
+	}
+
+	printf("csum_type\t\t%hu (", csum_type);
+	if (!is_valid_csum_type(csum_type)) {
+		printf("INVALID");
+	} else {
+		printf("%s", btrfs_super_csum_name(csum_type));
+	}
+	printf(")\n");
+	printf("csum\t\t\t0x");
+	for (i = 0; i < csum_size; i++)
+		printf("%02x", wis->csum[i]);
+	if (csum_match)
+		printf(" [match]");
+	else
+		printf(" [DON'T MATCH]");
+	putchar('\n');
+	printf("magic\t\t\t");
+	s = (char *) &wis->magic;
+	for (i = 0; i < 8; i++)
+		putchar(isprint(s[i]) ? s[i] : '.');
+	if (wi_super_magic(wis) == WRITE_INTENT_SUPER_MAGIC)
+		printf(" [match]\n");
+	else
+		printf(" [DON't MATCH]\n");
+
+	uuid_unparse(wis->fsid, uuid_buf);
+	printf("fsid\t\t\t%s\n", uuid_buf);
+	printf("flags\t\t\t0x%llx\n", wi_super_flags(wis));
+	print_readable_write_intent_flag(wi_super_flags(wis));
+	printf("events\t\t\t%llu\n", wi_super_events(wis));
+	printf("size\t\t\t%llu\n", wi_super_size(wis));
+	printf("blocksize\t\t%u\n", wi_super_blocksize(wis));
+	printf("nr_entries\t\t%llu\n", wi_super_nr_entries(wis));
+
+	for (cur = sizeof(*wis), i = 0; cur < WRITE_INTENT_BITMAPS_SIZE;
+	     cur += sizeof(*wie), i++) {
+		u64 bytenr;
+
+		wie = (struct write_intent_entry *)(buf + cur);
+
+		bytenr = wi_entry_bytenr(wie);
+
+		/* Last one. */
+		if (bytenr == 0)
+			break;
+		printf("entry %d, bytenr %llu, bitmap 0x%08x%08x\n",
+			i, bytenr, wie_get_bitmap0(wie),
+			wie_get_bitmap1(wie));
+	}
+}
diff --git a/kernel-shared/print-tree.h b/kernel-shared/print-tree.h
index 80fb6ef75ff5..5ed398b15be5 100644
--- a/kernel-shared/print-tree.h
+++ b/kernel-shared/print-tree.h
@@ -42,5 +42,6 @@ void print_extent_item(struct extent_buffer *eb, int slot, int metadata);
 void print_objectid(FILE *stream, u64 objectid, u8 type);
 void print_key_type(FILE *stream, u64 objectid, u8 type);
 void btrfs_print_superblock(struct btrfs_super_block *sb, int full);
+void btrfs_print_write_intent(const u8 *buf);
 
 #endif
-- 
2.36.1

