Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3665699DA
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 07:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbiGGFdJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 01:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbiGGFdI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 01:33:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3783134C
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 22:33:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C056C21EDA
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 05:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657171985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ixV9ZO8TtEoDFyIMcivCPdUEX0tcGN5Egu7vdgIsTc=;
        b=NesgbPmY2NKmrCxyqBIB8ead6QnS3f/tNw5S9ZtKizWf6OGrDJRGjwCGDSh3h+4wnnn05g
        pzW9+BLNU07pO8j3HNKTDBTEgpzltzZ7qA4HRhRDHMjWaG3CenG4mwJZi3tpsIAqvt/GOO
        hhZk2T3MeUl3KPZsrPX7EDAjSA6l6Ck=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22CE113488
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 05:33:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cMz0NxBwxmKcLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Jul 2022 05:33:04 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/12] btrfs: selftests: add selftests for write-intent bitmaps
Date:   Thu,  7 Jul 2022 13:32:33 +0800
Message-Id: <71df1f42e026a2da1e24de5f961175b669f47935.1657171615.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657171615.git.wqu@suse.com>
References: <cover.1657171615.git.wqu@suse.com>
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

It turns out such sparse bitmap still has a lot of things to go wrong,
definitely needs some tests to cover all the different corner cases.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/Makefile                           |   3 +-
 fs/btrfs/tests/btrfs-tests.c                |   4 +
 fs/btrfs/tests/btrfs-tests.h                |   2 +
 fs/btrfs/tests/write-intent-bitmaps-tests.c | 245 ++++++++++++++++++++
 fs/btrfs/write-intent.c                     |  10 -
 fs/btrfs/write-intent.h                     |  12 +
 6 files changed, 265 insertions(+), 11 deletions(-)
 create mode 100644 fs/btrfs/tests/write-intent-bitmaps-tests.c

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index af93119d52e2..a9658782d363 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -42,4 +42,5 @@ btrfs-$(CONFIG_FS_VERITY) += verity.o
 btrfs-$(CONFIG_BTRFS_FS_RUN_SANITY_TESTS) += tests/free-space-tests.o \
 	tests/extent-buffer-tests.o tests/btrfs-tests.o \
 	tests/extent-io-tests.o tests/inode-tests.o tests/qgroup-tests.o \
-	tests/free-space-tree-tests.o tests/extent-map-tests.o
+	tests/free-space-tree-tests.o tests/extent-map-tests.o \
+	tests/write-intent-bitmaps-tests.o
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index 1591bfa55bcc..27bb34acb156 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -27,6 +27,7 @@ const char *test_error[] = {
 	[TEST_ALLOC_INODE]	     = "cannot allocate inode",
 	[TEST_ALLOC_BLOCK_GROUP]     = "cannot allocate block group",
 	[TEST_ALLOC_EXTENT_MAP]      = "cannot allocate extent map",
+	[TEST_ALLOC_WRITE_INTENT_CTRL] = "cannot allocate write intent control",
 };
 
 static const struct super_operations btrfs_test_super_ops = {
@@ -279,6 +280,9 @@ int btrfs_run_sanity_tests(void)
 		}
 	}
 	ret = btrfs_test_extent_map();
+	if (ret)
+		goto out;
+	ret = btrfs_test_write_intent_bitmaps();
 
 out:
 	btrfs_destroy_test_fs();
diff --git a/fs/btrfs/tests/btrfs-tests.h b/fs/btrfs/tests/btrfs-tests.h
index 7a2d7ffbe30e..1845bfb6465d 100644
--- a/fs/btrfs/tests/btrfs-tests.h
+++ b/fs/btrfs/tests/btrfs-tests.h
@@ -23,6 +23,7 @@ enum {
 	TEST_ALLOC_INODE,
 	TEST_ALLOC_BLOCK_GROUP,
 	TEST_ALLOC_EXTENT_MAP,
+	TEST_ALLOC_WRITE_INTENT_CTRL,
 };
 
 extern const char *test_error[];
@@ -37,6 +38,7 @@ int btrfs_test_inodes(u32 sectorsize, u32 nodesize);
 int btrfs_test_qgroups(u32 sectorsize, u32 nodesize);
 int btrfs_test_free_space_tree(u32 sectorsize, u32 nodesize);
 int btrfs_test_extent_map(void);
+int btrfs_test_write_intent_bitmaps(void);
 struct inode *btrfs_new_test_inode(void);
 struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize);
 void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/tests/write-intent-bitmaps-tests.c b/fs/btrfs/tests/write-intent-bitmaps-tests.c
new file mode 100644
index 000000000000..c956acaea1c7
--- /dev/null
+++ b/fs/btrfs/tests/write-intent-bitmaps-tests.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "../ctree.h"
+#include "../volumes.h"
+#include "../write-intent.h"
+#include "btrfs-tests.h"
+
+static struct write_intent_ctrl *alloc_dummy_ctrl(void)
+{
+	struct write_intent_ctrl *ctrl;
+	struct write_intent_super *wis;
+
+	ctrl = kzalloc(sizeof(*ctrl), GFP_NOFS);
+	if (!ctrl)
+		return NULL;
+	/*
+	 * For dummy tests, we only need the primary page, no need for the
+	 * commit page.
+	 */
+	ctrl->page = alloc_page(GFP_NOFS);
+	if (!ctrl->page) {
+		kfree(ctrl);
+		return NULL;
+	}
+	ctrl->blocksize = BTRFS_STRIPE_LEN;
+	atomic64_set(&ctrl->event, 1);
+	spin_lock_init(&ctrl->lock);
+	memzero_page(ctrl->page, 0, WRITE_INTENT_BITMAPS_SIZE);
+	wis = page_address(ctrl->page);
+	wi_set_super_magic(wis, WRITE_INTENT_SUPER_MAGIC);
+	wi_set_super_csum_type(wis, 0);
+	wi_set_super_events(wis, 1);
+	wi_set_super_flags(wis, WRITE_INTENT_FLAGS_SUPPORTED);
+	wi_set_super_size(wis, WRITE_INTENT_BITMAPS_SIZE);
+	wi_set_super_blocksize(wis, ctrl->blocksize);
+	wi_set_super_nr_entries(wis, 0);
+	return ctrl;
+}
+
+static void zero_bitmaps(struct write_intent_ctrl *ctrl)
+{
+	struct write_intent_super *wis = page_address(ctrl->page);
+
+	memzero_page(ctrl->page, sizeof(struct write_intent_super),
+			WRITE_INTENT_BITMAPS_SIZE -
+			sizeof(struct write_intent_super));
+	wi_set_super_nr_entries(wis, 0);
+}
+
+static int compare_bitmaps(struct write_intent_ctrl *ctrl,
+			   int nr_entries, u64 *bytenrs, u64 *bitmaps)
+{
+	struct write_intent_super *wis = page_address(ctrl->page);
+	struct write_intent_entry empty = {0};
+	int i;
+
+	if (wi_super_nr_entries(wis) != nr_entries) {
+		test_err("nr entries mismatch, has %llu expect %u",
+			wi_super_nr_entries(wis), nr_entries);
+		goto err;
+	}
+
+	for (i = 0; i < nr_entries; i++) {
+		struct write_intent_entry *entry =
+			write_intent_entry_nr(ctrl, i);
+
+		if (wi_entry_bytenr(entry) != bytenrs[i]) {
+			test_err("bytenr mismatch, has %llu expect %llu",
+				  wi_entry_bytenr(entry), bytenrs[i]);
+			goto err;
+		}
+		if (wi_entry_raw_bitmap(entry) != bitmaps[i]) {
+			test_err("bitmap mismatch, has 0x%016llx expect 0x%016llx",
+				  wi_entry_raw_bitmap(entry), bitmaps[i]);
+			goto err;
+		}
+	}
+
+	/* The unused entries should all be zero. */
+	for (i = nr_entries; i < WRITE_INTENT_INTERNAL_BITMAPS_MAX_ENTRIES;
+	     i++) {
+		if (memcmp(write_intent_entry_nr(ctrl, i), &empty,
+			   sizeof(empty))) {
+			test_err(
+			"unused entry is not empty, entry %u nr_entries %u",
+				 i, nr_entries);
+			goto err;
+		}
+	}
+	return 0;
+err:
+	/* Dump the bitmaps for better debugging. */
+	test_err("dumping bitmaps, nr_entries=%llu:", wi_super_nr_entries(wis));
+	for (i = 0; i < wi_super_nr_entries(wis); i++) {
+		struct write_intent_entry *entry =
+			write_intent_entry_nr(ctrl, i);
+
+		test_err("  entry=%u bytenr=%llu bitmap=0x%016llx\n",
+			 i, wi_entry_bytenr(entry), wi_entry_raw_bitmap(entry));
+	}
+	return -EUCLEAN;
+}
+
+static void free_dummy_ctrl(struct write_intent_ctrl *ctrl)
+{
+	__free_page(ctrl->page);
+	ASSERT(ctrl->commit_page == NULL);
+	kfree(ctrl);
+}
+
+/*
+ * Basic tests to ensure set and clear can properly handle bits set/clear in
+ * one entry.
+ */
+static int test_case_simple_entry(struct write_intent_ctrl *ctrl)
+{
+	const u32 blocksize = BTRFS_STRIPE_LEN;
+	u64 bitmaps[1] = { 0 };
+	u64 bytenrs[1] = { 0 };
+	int ret;
+
+	zero_bitmaps(ctrl);
+
+	write_intent_set_bits(ctrl, 0, blocksize * 3);
+
+	bitmaps[0] = 0x7;
+	bytenrs[0] = 0;
+	ret = compare_bitmaps(ctrl, 1, bytenrs, bitmaps);
+	if (ret < 0)
+		return ret;
+
+	write_intent_clear_bits(ctrl, 0, blocksize * 3);
+	ret = compare_bitmaps(ctrl, 0, bytenrs, bitmaps);
+	if (ret < 0)
+		return ret;
+
+	write_intent_set_bits(ctrl, blocksize * 8, blocksize * 3);
+
+	bitmaps[0] = 0x700;
+	bytenrs[0] = 0;
+	ret = compare_bitmaps(ctrl, 1, bytenrs, bitmaps);
+	if (ret < 0)
+		return ret;
+
+	write_intent_clear_bits(ctrl, blocksize * 9, blocksize * 2);
+	bitmaps[0] = 0x100;
+	bytenrs[0] = 0;
+	ret = compare_bitmaps(ctrl, 1, bytenrs, bitmaps);
+	if (ret < 0)
+		return ret;
+
+	write_intent_clear_bits(ctrl, blocksize * 8, blocksize * 1);
+	ret = compare_bitmaps(ctrl, 0, bytenrs, bitmaps);
+	if (ret < 0)
+		return ret;
+
+	/* Tests at high bits. */
+	write_intent_set_bits(ctrl, blocksize * 61, blocksize * 3);
+	bitmaps[0] = 0xe000000000000000L;
+	bytenrs[0] = 0;
+	ret = compare_bitmaps(ctrl, 1, bytenrs, bitmaps);
+	if (ret < 0)
+		return ret;
+	write_intent_clear_bits(ctrl, blocksize * 61, blocksize * 1);
+	bitmaps[0] = 0xc000000000000000L;
+	bytenrs[0] = 0;
+	ret = compare_bitmaps(ctrl, 1, bytenrs, bitmaps);
+	if (ret < 0)
+		return ret;
+	write_intent_clear_bits(ctrl, blocksize * 62, blocksize * 2);
+	ret = compare_bitmaps(ctrl, 0, bytenrs, bitmaps);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+/* Tests set/clear that cross entry boundaries. */
+static int test_case_cross_entries(struct write_intent_ctrl *ctrl)
+{
+	const u32 blocksize = BTRFS_STRIPE_LEN;
+	u64 bitmaps[3] = { 0 };
+	u64 bytenrs[3] = { 0 };
+	int ret;
+
+	zero_bitmaps(ctrl);
+
+	write_intent_set_bits(ctrl, blocksize * 32, blocksize * 64);
+	bitmaps[0] = 0xffffffff00000000L;
+	bytenrs[0] = 0;
+	bitmaps[1] = 0x00000000ffffffffL;
+	bytenrs[1] = 4194304;
+	ret = compare_bitmaps(ctrl, 2, bytenrs, bitmaps);
+	if (ret < 0)
+		return ret;
+
+	write_intent_set_bits(ctrl, blocksize * 96, blocksize * 64);
+	bitmaps[0] = 0xffffffff00000000L;
+	bytenrs[0] = 0;
+	bitmaps[1] = 0xffffffffffffffffL;
+	bytenrs[1] = 4194304;
+	bitmaps[2] = 0x00000000ffffffffL;
+	bytenrs[2] = 8388608;
+	ret = compare_bitmaps(ctrl, 3, bytenrs, bitmaps);
+	if (ret < 0)
+		return ret;
+
+	write_intent_clear_bits(ctrl, blocksize * 33, blocksize * 126);
+	bitmaps[0] = 0x0000000100000000L;
+	bytenrs[0] = 0;
+	bitmaps[1] = 0x0000000080000000L;
+	bytenrs[1] = 8388608;
+	ret = compare_bitmaps(ctrl, 2, bytenrs, bitmaps);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+int btrfs_test_write_intent_bitmaps(void)
+{
+	struct write_intent_ctrl *ctrl;
+	int ret;
+
+	ctrl = alloc_dummy_ctrl();
+	if (!ctrl) {
+		test_std_err(TEST_ALLOC_WRITE_INTENT_CTRL);
+		return -ENOMEM;
+	}
+	test_msg("running extent_map tests");
+
+	ret = test_case_simple_entry(ctrl);
+	if (ret < 0) {
+		test_err("failed set/clear tests in one simple entry");
+		goto out;
+	}
+
+	ret = test_case_cross_entries(ctrl);
+	if (ret < 0) {
+		test_err("failed set/clear tests across entry boundaries");
+		goto out;
+	}
+out:
+	free_dummy_ctrl(ctrl);
+	return ret;
+}
diff --git a/fs/btrfs/write-intent.c b/fs/btrfs/write-intent.c
index 8a69bf39a994..b4a205cb0c88 100644
--- a/fs/btrfs/write-intent.c
+++ b/fs/btrfs/write-intent.c
@@ -216,16 +216,6 @@ static int write_intent_init(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
-static struct write_intent_entry *write_intent_entry_nr(
-				struct write_intent_ctrl *ctrl, int nr)
-{
-
-	ASSERT(nr < WRITE_INTENT_INTERNAL_BITMAPS_MAX_ENTRIES);
-	return (page_address(ctrl->page) +
-		sizeof(struct write_intent_super) +
-		nr * sizeof(struct write_intent_entry));
-}
-
 /*
  * Return <0 if the bytenr is before the given entry.
  * Return 0 if the bytenr is inside the given entry.
diff --git a/fs/btrfs/write-intent.h b/fs/btrfs/write-intent.h
index 0da1b7421590..00eb116e4c38 100644
--- a/fs/btrfs/write-intent.h
+++ b/fs/btrfs/write-intent.h
@@ -197,6 +197,8 @@ WRITE_INTENT_SETGET_FUNCS(super_blocksize, struct write_intent_super,
 WRITE_INTENT_SETGET_FUNCS(super_csum_type, struct write_intent_super,
 			  csum_type, 16);
 WRITE_INTENT_SETGET_FUNCS(entry_bytenr, struct write_intent_entry, bytenr, 64);
+WRITE_INTENT_SETGET_FUNCS(entry_raw_bitmap, struct write_intent_entry,
+			  bitmap, 64);
 
 static inline u32 write_intent_entry_size(struct write_intent_ctrl *ctrl)
 {
@@ -205,6 +207,16 @@ static inline u32 write_intent_entry_size(struct write_intent_ctrl *ctrl)
 	return wi_super_blocksize(wis) * WRITE_INTENT_BITS_PER_ENTRY;
 }
 
+static inline struct write_intent_entry *write_intent_entry_nr(
+				struct write_intent_ctrl *ctrl, int nr)
+{
+
+	ASSERT(nr < WRITE_INTENT_INTERNAL_BITMAPS_MAX_ENTRIES);
+	return (page_address(ctrl->page) +
+		sizeof(struct write_intent_super) +
+		nr * sizeof(struct write_intent_entry));
+}
+
 static inline void wie_get_bitmap(struct write_intent_entry *entry,
 				  unsigned long *bitmap)
 {
-- 
2.36.1

