Return-Path: <linux-btrfs+bounces-14027-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4418FAB7F82
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 10:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBDB21BA0701
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 08:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C862253E9;
	Thu, 15 May 2025 08:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YFQVG2yd";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YFQVG2yd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC2E163
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747296052; cv=none; b=NT8TyVA5ZMTG5vuNLJCW1MWsY7m6w4m+xj487ozeO0qeS9PS0vLIQgunfRI49Fx2WYhGyJIpZv7Ywt7Mccc8wAnP5Yx9nrut5By1tFG0PbSvGZKKtD2gKJ1+oo0f5qswVDOre9vY1kAsWpPPtNTwi8ARfCmQmG+WkH9ccl9bLos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747296052; c=relaxed/simple;
	bh=QoE2vsbSotFTgI5S6nHZamFCCASbdqrUKmYYIUvMuD0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NillyGihRZsRaJNJDawg17aquWMCRx5ocWE9LNeJgD+BIpVAVbRNZPAcFHtuB37Z3ccCsdKvmY4eGGovIX4rCq1BTnbeSniQ1LJdO98S2ZVWM8zf3jPPfYWNjUuXT60g1Zv1nm0BRbEMoRzEaH9fEFJe/hy4hKcMgaAQ3P2XnEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YFQVG2yd; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YFQVG2yd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 254382120C
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747296041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBjompMYYNr8aXxRYE2uVtWFOLffaOJmyZ3WtlEXIUQ=;
	b=YFQVG2ydTa90PvjWoeVXo9pjUc8dYgUJ25dupDKzao5kEOCWCM2PN7AiQqym2gbl2t1mpr
	yZdfjiKYCNRUEQeW8ab3VdjcOgRelolqKcqagMHSXeIJ8fHk3NZV85YU68egYaCfm3bTrK
	mLxzBiCoMiNJ7q8nKib0lQZQR91tTJA=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=YFQVG2yd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747296041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBjompMYYNr8aXxRYE2uVtWFOLffaOJmyZ3WtlEXIUQ=;
	b=YFQVG2ydTa90PvjWoeVXo9pjUc8dYgUJ25dupDKzao5kEOCWCM2PN7AiQqym2gbl2t1mpr
	yZdfjiKYCNRUEQeW8ab3VdjcOgRelolqKcqagMHSXeIJ8fHk3NZV85YU68egYaCfm3bTrK
	mLxzBiCoMiNJ7q8nKib0lQZQR91tTJA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F598137E8
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:00:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2DemCCifJWi8LwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:00:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/6] btrfs-progs: introduce "btrfs rescue fix-data-checksum"
Date: Thu, 15 May 2025 17:30:16 +0930
Message-ID: <a91001c175a5dd38a8873c6550bf856f1f4c5cde.1747295965.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747295965.git.wqu@suse.com>
References: <cover.1747295965.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 254382120C
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

It's a long known problem that direct IO can lead to data checksum
mismatches if the user space is also modifying its buffer during
writeback.

Although it's fixed in the recent v6.15 release (and backported to older
kernels), we still need a user friendly way to fix those problems.

This patch introduce the dryrun version of "btrfs rescue
fix-data-checksum", which reports the logical bytenr and corrupted mirrors.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-rescue.rst  |  19 +++
 Makefile                        |   2 +-
 cmds/rescue-fix-data-checksum.c | 288 ++++++++++++++++++++++++++++++++
 cmds/rescue.c                   |  48 ++++++
 cmds/rescue.h                   |   7 +
 5 files changed, 363 insertions(+), 1 deletion(-)
 create mode 100644 cmds/rescue-fix-data-checksum.c

diff --git a/Documentation/btrfs-rescue.rst b/Documentation/btrfs-rescue.rst
index f52e6c26359a..7a237ba8ebbb 100644
--- a/Documentation/btrfs-rescue.rst
+++ b/Documentation/btrfs-rescue.rst
@@ -50,6 +50,25 @@ fix-device-size <device>
 
                 WARNING: CPU: 3 PID: 439 at fs/btrfs/ctree.h:1559 btrfs_update_device+0x1c5/0x1d0 [btrfs]
 
+fix-data-checksum <device>
+	fix data checksum mismatch
+
+	There is a long existing problem that if a user space program is doing
+	direct IO and modifies the buffer before the write back finished, it
+	can lead to data checksum mismatches.
+
+	This problem is known but not fixed until upstream release v6.15
+	(backported to older kernels). So it's possible to hit false data
+	checksum mismatch for any long running btrfs.
+
+	In that case this program can be utilized to repair such problem.
+
+        ``Options``
+
+	-r|--readonly
+		readonly mode, only scan and report for data checksum mismatch,
+		do no repair
+
 .. _man-rescue-clear-ino-cache:
 
 clear-ino-cache <device>
diff --git a/Makefile b/Makefile
index 7e36aa425736..523b83495524 100644
--- a/Makefile
+++ b/Makefile
@@ -256,7 +256,7 @@ cmds_objects = cmds/subvolume.o cmds/subvolume-list.o \
 	       cmds/inspect.o cmds/balance.o cmds/send.o cmds/receive.o \
 	       cmds/quota.o cmds/qgroup.o cmds/replace.o check/main.o \
 	       cmds/restore.o cmds/rescue.o cmds/rescue-chunk-recover.o \
-	       cmds/rescue-super-recover.o \
+	       cmds/rescue-super-recover.o cmds/rescue-fix-data-checksum.o \
 	       cmds/property.o cmds/filesystem-usage.o cmds/inspect-dump-tree.o \
 	       cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/filesystem-du.o \
 	       cmds/reflink.o \
diff --git a/cmds/rescue-fix-data-checksum.c b/cmds/rescue-fix-data-checksum.c
new file mode 100644
index 000000000000..7e613ba57f76
--- /dev/null
+++ b/cmds/rescue-fix-data-checksum.c
@@ -0,0 +1,288 @@
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
+#include "kernel-shared/disk-io.h"
+#include "kernel-shared/ctree.h"
+#include "kernel-shared/volumes.h"
+#include "common/messages.h"
+#include "common/open-utils.h"
+#include "cmds/rescue.h"
+
+/*
+ * Record one corrupted data blocks.
+ *
+ * We do not report immediately, this is for future file deleting support.
+ */
+struct corrupted_block {
+	struct list_head list;
+	/* The logical bytenr of the exact corrupted block. */
+	u64 logical;
+
+	/* The amount of mirrors above logical have. */
+	unsigned int num_mirrors;
+
+	/*
+	 * Which mirror failed.
+	 *
+	 * Note, bit 0 means mirror 1, since mirror 0 means choosing a
+	 * live mirror, and we never utilized that mirror 0.
+	 */
+	unsigned long *error_mirror_bitmap;
+};
+
+static int global_repair_mode;
+LIST_HEAD(corrupted_blocks);
+
+static int add_corrupted_block(struct btrfs_fs_info *fs_info, u64 logical,
+			       unsigned int mirror, unsigned int num_mirrors)
+{
+	struct corrupted_block *last;
+	if (list_empty(&corrupted_blocks))
+		goto add;
+
+	last = list_entry(corrupted_blocks.prev, struct corrupted_block, list);
+	/* The last entry is the same, just set update the error mirror bitmap. */
+	if (last->logical == logical) {
+		UASSERT(last->error_mirror_bitmap);
+		set_bit(mirror, last->error_mirror_bitmap);
+		return 0;
+	}
+add:
+	last = calloc(1, sizeof(*last));
+	if (!last)
+		return -ENOMEM;
+	last->error_mirror_bitmap = calloc(1, BITS_TO_LONGS(num_mirrors));
+	if (!last->error_mirror_bitmap) {
+		free(last);
+		return -ENOMEM;
+	}
+	set_bit(mirror - 1, last->error_mirror_bitmap);
+	last->logical = logical;
+	last->num_mirrors = num_mirrors;
+
+	list_add_tail(&last->list, &corrupted_blocks);
+	return 0;
+}
+
+/*
+ * Verify all mirrors for @logical.
+ *
+ * If something critical happened, return <0 and should end the run immediately.
+ * Otherwise return 0, including data checksum mismatch or read failure.
+ */
+static int verify_one_data_block(struct btrfs_fs_info *fs_info,
+				 struct extent_buffer *leaf,
+				 unsigned long leaf_offset, u64 logical,
+				 unsigned int num_mirrors)
+{
+	const u32 blocksize = fs_info->sectorsize;
+	const u32 csum_size = fs_info->csum_size;
+	u8 *buf;
+	u8 csum[BTRFS_CSUM_SIZE];
+	u8 csum_expected[BTRFS_CSUM_SIZE];
+	int ret = 0;
+
+	buf = malloc(blocksize);
+	if (!buf)
+		return -ENOMEM;
+
+	for (int mirror = 1; mirror <= num_mirrors; mirror++) {
+		u64 read_len = blocksize;
+
+		ret = read_data_from_disk(fs_info, buf, logical, &read_len, mirror);
+		if (ret < 0) {
+			/* IO error, add one record. */
+			ret = add_corrupted_block(fs_info, logical, mirror, num_mirrors);
+			if (ret < 0)
+				break;
+		}
+		/* Verify the data checksum. */
+		btrfs_csum_data(fs_info, fs_info->csum_type, buf, csum, blocksize);
+		read_extent_buffer(leaf, csum_expected, leaf_offset, csum_size);
+		if (memcmp(csum_expected, csum, csum_size) != 0) {
+			ret = add_corrupted_block(fs_info, logical, mirror, num_mirrors);
+			if (ret < 0)
+				break;
+		}
+	}
+
+	free(buf);
+	return ret;
+}
+
+static int iterate_one_csum_item(struct btrfs_fs_info *fs_info, struct btrfs_path *path)
+{
+	struct btrfs_key key;
+	const unsigned long item_ptr_off = btrfs_item_ptr_offset(path->nodes[0],
+								 path->slots[0]);
+	const u32 blocksize = fs_info->sectorsize;
+	int num_mirrors;
+	u64 data_size;
+	u64 cur;
+	char *buf;
+	int ret = 0;
+
+	buf = malloc(blocksize);
+	if (!buf)
+		return -ENOMEM;
+
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+	data_size = btrfs_item_size(path->nodes[0], path->slots[0]) /
+		    fs_info->csum_size * blocksize;
+	num_mirrors = btrfs_num_copies(fs_info, key.offset, data_size);
+
+	for (cur = 0; cur < data_size; cur += blocksize) {
+		const unsigned long leaf_offset = item_ptr_off +
+			cur / blocksize * fs_info->csum_size;
+
+		ret = verify_one_data_block(fs_info, path->nodes[0], leaf_offset,
+					    key.offset + cur, num_mirrors);
+		if (ret < 0)
+			break;
+	}
+	free(buf);
+	return ret;
+}
+
+static int iterate_csum_root(struct btrfs_fs_info *fs_info, struct btrfs_root *csum_root)
+{
+	struct btrfs_path path = { 0 };
+	struct btrfs_key key;
+	int ret;
+
+	key.objectid = 0;
+	key.type = 0;
+	key.offset = 0;
+
+	ret = btrfs_search_slot(NULL, csum_root, &key, &path, 0, 0);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to get the first tree block of csum tree: %m");
+		return ret;
+	}
+	UASSERT(ret > 0);
+	while (true) {
+		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+		if (key.type != BTRFS_EXTENT_CSUM_KEY)
+			goto next;
+		ret = iterate_one_csum_item(fs_info, &path);
+		if (ret < 0)
+			break;
+next:
+		ret = btrfs_next_item(csum_root, &path);
+		if (ret > 0) {
+			ret = 0;
+			break;
+		}
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to get next csum item: %m");
+		}
+	}
+	btrfs_release_path(&path);
+	return ret;
+}
+
+static void report_corrupted_blocks(void)
+{
+	struct corrupted_block *entry;
+
+	if (list_empty(&corrupted_blocks)) {
+		printf("No data checksum mismatch found\n");
+		return;
+	}
+
+	list_for_each_entry(entry, &corrupted_blocks, list) {
+		bool has_printed = false;
+
+		printf("logical=%llu corrtuped mirrors=", entry->logical);
+		/* Poor man's bitmap print. */
+		for (int i = 0; i < entry->num_mirrors; i++) {
+			if (test_bit(i, entry->error_mirror_bitmap)) {
+				if (has_printed)
+					printf(",");
+				/*
+				 * Bit 0 means mirror 1, thus we need to increase
+				 * the value by 1.
+				 */
+				printf("%d", i + 1);
+				has_printed=true;
+			}
+		}
+		printf("\n");
+	}
+}
+
+static void free_corrupted_blocks(void)
+{
+	while (!list_empty(&corrupted_blocks)) {
+		struct corrupted_block *entry;
+
+		entry = list_entry(corrupted_blocks.next, struct corrupted_block, list);
+		list_del_init(&entry->list);
+		free(entry->error_mirror_bitmap);
+		free(entry);
+	}
+}
+
+int btrfs_recover_fix_data_checksum(const char *path,
+				    enum btrfs_fix_data_checksum_mode mode)
+{
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_root *csum_root;
+	struct open_ctree_args oca = { 0 };
+	int ret;
+
+	if (mode >= BTRFS_FIX_DATA_CSUMS_LAST)
+		return -EINVAL;
+
+	ret = check_mounted(path);
+	if (ret < 0) {
+		errno = -ret;
+		error("could not check mount status: %m");
+		return ret;
+	}
+	if (ret > 0) {
+		error("%s is currently mounted", path);
+		return -EBUSY;
+	}
+
+	global_repair_mode = mode;
+	oca.filename = path;
+	oca.flags = OPEN_CTREE_WRITES;
+	fs_info = open_ctree_fs_info(&oca);
+	if (!fs_info) {
+		error("failed to open btrfs at %s", path);
+		return -EIO;
+	}
+	csum_root = btrfs_csum_root(fs_info, 0);
+	if (!csum_root) {
+		error("failed to get csum root");
+		ret = -EIO;
+		goto out_close;
+	}
+	ret = iterate_csum_root(fs_info, csum_root);
+	if (ret) {
+		errno = -ret;
+		error("failed to iterate csum tree: %m");
+	}
+	report_corrupted_blocks();
+out_close:
+	free_corrupted_blocks();
+	close_ctree_fs_info(fs_info);
+	return ret;
+}
diff --git a/cmds/rescue.c b/cmds/rescue.c
index c60bf11675b9..0d3f86f7e8d6 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -22,6 +22,7 @@
 #include <errno.h>
 #include <stdbool.h>
 #include <unistd.h>
+#include <getopt.h>
 #include "kernel-lib/list.h"
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/volumes.h"
@@ -275,6 +276,52 @@ out:
 }
 static DEFINE_SIMPLE_COMMAND(rescue_fix_device_size, "fix-device-size");
 
+static const char * const cmd_rescue_fix_data_checksum_usage[] = {
+	"btrfs rescue fix-data-checksum <device>",
+	"Fix data checksum mismatches.",
+	"",
+	OPTLINE("-r", "readonly mode, only report errors without repair"),
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_VERBOSE,
+	NULL
+};
+
+static int cmd_rescue_fix_data_checksum(const struct cmd_struct *cmd,
+					int argc, char **argv)
+{
+	enum btrfs_fix_data_checksum_mode mode = BTRFS_FIX_DATA_CSUMS_READONLY;
+	int ret;
+	optind = 0;
+
+	while (1) {
+		int c;
+		enum { GETOPT_VAL_DRYRUN = GETOPT_VAL_FIRST, };
+		static const struct option long_options [] = {
+			{"readonly", no_argument, NULL, 'r'},
+			{"NULL", 0, NULL, 0},
+		};
+		c = getopt_long(argc, argv, "r", long_options, NULL);
+		if (c < 0)
+			break;
+		switch (c) {
+		case 'r':
+			mode = BTRFS_FIX_DATA_CSUMS_READONLY;
+			break;
+		default:
+			usage_unknown_option(cmd, argv);
+		}
+	}
+	if (check_argc_min(argc - optind, 1))
+		return 1;
+	ret = btrfs_recover_fix_data_checksum(argv[optind], mode);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to fix data checksums: %m");
+	}
+	return !!ret;
+}
+static DEFINE_SIMPLE_COMMAND(rescue_fix_data_checksum, "fix-data-checksum");
+
 static const char * const cmd_rescue_create_control_device_usage[] = {
 	"btrfs rescue create-control-device",
 	"Create /dev/btrfs-control (see 'CONTROL DEVICE' in btrfs(5))",
@@ -527,6 +574,7 @@ static const struct cmd_group rescue_cmd_group = {
 		&cmd_struct_rescue_super_recover,
 		&cmd_struct_rescue_zero_log,
 		&cmd_struct_rescue_fix_device_size,
+		&cmd_struct_rescue_fix_data_checksum,
 		&cmd_struct_rescue_create_control_device,
 		&cmd_struct_rescue_clear_ino_cache,
 		&cmd_struct_rescue_clear_space_cache,
diff --git a/cmds/rescue.h b/cmds/rescue.h
index 5a9e46b7aae0..331b595f1c6f 100644
--- a/cmds/rescue.h
+++ b/cmds/rescue.h
@@ -20,7 +20,14 @@
 #ifndef __BTRFS_RESCUE_H__
 #define __BTRFS_RESCUE_H__
 
+enum btrfs_fix_data_checksum_mode {
+	BTRFS_FIX_DATA_CSUMS_READONLY,
+	BTRFS_FIX_DATA_CSUMS_LAST,
+};
+
 int btrfs_recover_superblocks(const char *path, int yes);
 int btrfs_recover_chunk_tree(const char *path, int yes);
+int btrfs_recover_fix_data_checksum(const char *path,
+				    enum btrfs_fix_data_checksum_mode mode);
 
 #endif
-- 
2.49.0


