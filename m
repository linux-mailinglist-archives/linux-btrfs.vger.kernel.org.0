Return-Path: <linux-btrfs+bounces-10544-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 567349F6202
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 10:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C1A18962AA
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 09:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DED19CC20;
	Wed, 18 Dec 2024 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="E62NQXWf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="E62NQXWf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5A519C558
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514939; cv=none; b=MRjqphu5IdzAhp28TIvgPrsau7zQYaSrjd0QZCeiM3bnU8USkKg2w09WHFOxHXZ2T9y7om7rhEyUgN5oX3FpY6b0pqnCBEL761WXIiywNUFF48Z91LSdMMAZTfYNDvO0v6REEvJaeZpLESGmkXCKWj9jKeVARwhspSF76zgXJMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514939; c=relaxed/simple;
	bh=5TCXzyk2WWDYCIJj+DkRieAet7QBB7fZU/4H621MIMk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLZ0+Q4vJM/1iXHO3Mb1FfYZGFvihpYzOfHt/A+R9SHFITutezlQbfTsGz8yL/8JoiALcaa3XvX/fml03hKrhNd7MtGdzJlR9R/ZZhQcg21CRaPHGREW6PmX/79Z5b+az1DfZpHhiptHRTvBdECgU+tPb6UmkqVolB5eHqzqvak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=E62NQXWf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=E62NQXWf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 736D82115C
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKdK5sTcTbWwv7EWdGoy1GTKJHEByNdZY4/4rleGgXY=;
	b=E62NQXWfnBLxR+mgFMfqe5gNUmpC3rc2iZrm4gt/MT6YcMVFl5uV9k7lyJ4zAqhIMd5D4V
	Q4Ol5yb5P8Mbo/656OD2sqHGKOoOq64kXFCWB7Ys8aVkOUYaqZlQsbFLYO2Lizr/Di8w2/
	QWVIbm5AIXzQ4BP6dgFH0c2LeumyMFs=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKdK5sTcTbWwv7EWdGoy1GTKJHEByNdZY4/4rleGgXY=;
	b=E62NQXWfnBLxR+mgFMfqe5gNUmpC3rc2iZrm4gt/MT6YcMVFl5uV9k7lyJ4zAqhIMd5D4V
	Q4Ol5yb5P8Mbo/656OD2sqHGKOoOq64kXFCWB7Ys8aVkOUYaqZlQsbFLYO2Lizr/Di8w2/
	QWVIbm5AIXzQ4BP6dgFH0c2LeumyMFs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 964D3132EA
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oBbpFPSYYmdmSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 15/18] btrfs: migrate selftests to use block size terminology
Date: Wed, 18 Dec 2024 20:11:31 +1030
Message-ID: <c3ce04dc578d5c28869703bddb9ffd551cde506e.1734514696.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734514696.git.wqu@suse.com>
References: <cover.1734514696.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

Straightforward rename from "sector" to "block".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tests/btrfs-tests.c            |  38 ++--
 fs/btrfs/tests/btrfs-tests.h            |  18 +-
 fs/btrfs/tests/delayed-refs-tests.c     |   4 +-
 fs/btrfs/tests/extent-buffer-tests.c    |   8 +-
 fs/btrfs/tests/extent-io-tests.c        |  34 +--
 fs/btrfs/tests/free-space-tests.c       | 104 ++++-----
 fs/btrfs/tests/free-space-tree-tests.c  |  28 +--
 fs/btrfs/tests/inode-tests.c            | 266 ++++++++++++------------
 fs/btrfs/tests/qgroup-tests.c           |  12 +-
 fs/btrfs/tests/raid-stripe-tree-tests.c |   8 +-
 10 files changed, 260 insertions(+), 260 deletions(-)

diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index 5eff8d7d2360..8ade0d610e63 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -115,7 +115,7 @@ static void btrfs_free_dummy_device(struct btrfs_device *dev)
 	kfree(dev);
 }
 
-struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize)
+struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 blocksize)
 {
 	struct btrfs_fs_info *fs_info = kzalloc(sizeof(struct btrfs_fs_info),
 						GFP_KERNEL);
@@ -141,8 +141,8 @@ struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize)
 	btrfs_init_fs_info(fs_info);
 
 	fs_info->nodesize = nodesize;
-	fs_info->sectorsize = sectorsize;
-	fs_info->sectorsize_bits = ilog2(sectorsize);
+	fs_info->blocksize = blocksize;
+	fs_info->blocksize_bits = ilog2(blocksize);
 
 	/* CRC32C csum size. */
 	fs_info->csum_size = 4;
@@ -232,7 +232,7 @@ btrfs_alloc_dummy_block_group(struct btrfs_fs_info *fs_info,
 
 	cache->start = 0;
 	cache->length = length;
-	cache->full_stripe_len = fs_info->sectorsize;
+	cache->full_stripe_len = fs_info->blocksize;
 	cache->fs_info = fs_info;
 
 	INIT_LIST_HEAD(&cache->list);
@@ -274,43 +274,43 @@ void btrfs_init_dummy_trans(struct btrfs_trans_handle *trans,
 int btrfs_run_sanity_tests(void)
 {
 	int ret, i;
-	u32 sectorsize, nodesize;
-	u32 test_sectorsize[] = {
+	u32 blocksize, nodesize;
+	u32 test_blocksize[] = {
 		PAGE_SIZE,
 	};
 	ret = btrfs_init_test_fs();
 	if (ret)
 		return ret;
-	for (i = 0; i < ARRAY_SIZE(test_sectorsize); i++) {
-		sectorsize = test_sectorsize[i];
-		for (nodesize = sectorsize;
+	for (i = 0; i < ARRAY_SIZE(test_blocksize); i++) {
+		blocksize = test_blocksize[i];
+		for (nodesize = blocksize;
 		     nodesize <= BTRFS_MAX_METADATA_BLOCKSIZE;
 		     nodesize <<= 1) {
-			pr_info("BTRFS: selftest: sectorsize: %u  nodesize: %u\n",
-				sectorsize, nodesize);
-			ret = btrfs_test_free_space_cache(sectorsize, nodesize);
+			pr_info("BTRFS: selftest: blocksize: %u  nodesize: %u\n",
+				blocksize, nodesize);
+			ret = btrfs_test_free_space_cache(blocksize, nodesize);
 			if (ret)
 				goto out;
-			ret = btrfs_test_extent_buffer_operations(sectorsize,
+			ret = btrfs_test_extent_buffer_operations(blocksize,
 				nodesize);
 			if (ret)
 				goto out;
-			ret = btrfs_test_extent_io(sectorsize, nodesize);
+			ret = btrfs_test_extent_io(blocksize, nodesize);
 			if (ret)
 				goto out;
-			ret = btrfs_test_inodes(sectorsize, nodesize);
+			ret = btrfs_test_inodes(blocksize, nodesize);
 			if (ret)
 				goto out;
-			ret = btrfs_test_qgroups(sectorsize, nodesize);
+			ret = btrfs_test_qgroups(blocksize, nodesize);
 			if (ret)
 				goto out;
-			ret = btrfs_test_free_space_tree(sectorsize, nodesize);
+			ret = btrfs_test_free_space_tree(blocksize, nodesize);
 			if (ret)
 				goto out;
-			ret = btrfs_test_raid_stripe_tree(sectorsize, nodesize);
+			ret = btrfs_test_raid_stripe_tree(blocksize, nodesize);
 			if (ret)
 				goto out;
-			ret = btrfs_test_delayed_refs(sectorsize, nodesize);
+			ret = btrfs_test_delayed_refs(blocksize, nodesize);
 			if (ret)
 				goto out;
 		}
diff --git a/fs/btrfs/tests/btrfs-tests.h b/fs/btrfs/tests/btrfs-tests.h
index 4307bdaa6749..a3d3d806211a 100644
--- a/fs/btrfs/tests/btrfs-tests.h
+++ b/fs/btrfs/tests/btrfs-tests.h
@@ -36,17 +36,17 @@ struct btrfs_root;
 struct btrfs_trans_handle;
 struct btrfs_transaction;
 
-int btrfs_test_extent_buffer_operations(u32 sectorsize, u32 nodesize);
-int btrfs_test_free_space_cache(u32 sectorsize, u32 nodesize);
-int btrfs_test_extent_io(u32 sectorsize, u32 nodesize);
-int btrfs_test_inodes(u32 sectorsize, u32 nodesize);
-int btrfs_test_qgroups(u32 sectorsize, u32 nodesize);
-int btrfs_test_free_space_tree(u32 sectorsize, u32 nodesize);
-int btrfs_test_raid_stripe_tree(u32 sectorsize, u32 nodesize);
+int btrfs_test_extent_buffer_operations(u32 blocksize, u32 nodesize);
+int btrfs_test_free_space_cache(u32 blocksize, u32 nodesize);
+int btrfs_test_extent_io(u32 blocksize, u32 nodesize);
+int btrfs_test_inodes(u32 blocksize, u32 nodesize);
+int btrfs_test_qgroups(u32 blocksize, u32 nodesize);
+int btrfs_test_free_space_tree(u32 blocksize, u32 nodesize);
+int btrfs_test_raid_stripe_tree(u32 blocksize, u32 nodesize);
 int btrfs_test_extent_map(void);
-int btrfs_test_delayed_refs(u32 sectorsize, u32 nodesize);
+int btrfs_test_delayed_refs(u32 blocksize, u32 nodesize);
 struct inode *btrfs_new_test_inode(void);
-struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize);
+struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 blocksize);
 void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info);
 void btrfs_free_dummy_root(struct btrfs_root *root);
 struct btrfs_block_group *
diff --git a/fs/btrfs/tests/delayed-refs-tests.c b/fs/btrfs/tests/delayed-refs-tests.c
index 6558508c2ddf..908b5eeabb01 100644
--- a/fs/btrfs/tests/delayed-refs-tests.c
+++ b/fs/btrfs/tests/delayed-refs-tests.c
@@ -971,7 +971,7 @@ static int select_delayed_refs_test(struct btrfs_trans_handle *trans)
 	return ret;
 }
 
-int btrfs_test_delayed_refs(u32 sectorsize, u32 nodesize)
+int btrfs_test_delayed_refs(u32 blocksize, u32 nodesize)
 {
 	struct btrfs_transaction *transaction;
 	struct btrfs_trans_handle trans;
@@ -980,7 +980,7 @@ int btrfs_test_delayed_refs(u32 sectorsize, u32 nodesize)
 
 	test_msg("running delayed refs tests");
 
-	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, blocksize);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		return -ENOMEM;
diff --git a/fs/btrfs/tests/extent-buffer-tests.c b/fs/btrfs/tests/extent-buffer-tests.c
index 6a43a64ba55a..b0c30a2740e8 100644
--- a/fs/btrfs/tests/extent-buffer-tests.c
+++ b/fs/btrfs/tests/extent-buffer-tests.c
@@ -10,7 +10,7 @@
 #include "../disk-io.h"
 #include "../accessors.h"
 
-static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
+static int test_btrfs_split_item(u32 blocksize, u32 nodesize)
 {
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_path *path = NULL;
@@ -28,7 +28,7 @@ static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
 
 	test_msg("running btrfs_split_item tests");
 
-	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, blocksize);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		return -ENOMEM;
@@ -216,8 +216,8 @@ static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
 	return ret;
 }
 
-int btrfs_test_extent_buffer_operations(u32 sectorsize, u32 nodesize)
+int btrfs_test_extent_buffer_operations(u32 blocksize, u32 nodesize)
 {
 	test_msg("running extent buffer operation tests");
-	return test_btrfs_split_item(sectorsize, nodesize);
+	return test_btrfs_split_item(blocksize, nodesize);
 }
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 0a2dbfaaf49e..0b98291167b4 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -106,7 +106,7 @@ static void dump_extent_io_tree(const struct extent_io_tree *tree)
 	}
 }
 
-static int test_find_delalloc(u32 sectorsize, u32 nodesize)
+static int test_find_delalloc(u32 blocksize, u32 nodesize)
 {
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_root *root = NULL;
@@ -124,7 +124,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 
 	test_msg("running find delalloc tests");
 
-	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, blocksize);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		return -ENOMEM;
@@ -177,7 +177,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	 * |--- delalloc ---|
 	 * |---  search  ---|
 	 */
-	set_extent_bit(tmp, 0, sectorsize - 1, EXTENT_DELALLOC, NULL);
+	set_extent_bit(tmp, 0, blocksize - 1, EXTENT_DELALLOC, NULL);
 	start = 0;
 	end = start + PAGE_SIZE - 1;
 	found = find_lock_delalloc_range(inode, page_folio(locked_page), &start,
@@ -186,9 +186,9 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 		test_err("should have found at least one delalloc");
 		goto out_bits;
 	}
-	if (start != 0 || end != (sectorsize - 1)) {
+	if (start != 0 || end != (blocksize - 1)) {
 		test_err("expected start 0 end %u, got start %llu end %llu",
-			sectorsize - 1, start, end);
+			blocksize - 1, start, end);
 		goto out_bits;
 	}
 	unlock_extent(tmp, start, end, NULL);
@@ -208,7 +208,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 		test_err("couldn't find the locked page");
 		goto out_bits;
 	}
-	set_extent_bit(tmp, sectorsize, max_bytes - 1, EXTENT_DELALLOC, NULL);
+	set_extent_bit(tmp, blocksize, max_bytes - 1, EXTENT_DELALLOC, NULL);
 	start = test_start;
 	end = start + PAGE_SIZE - 1;
 	found = find_lock_delalloc_range(inode, page_folio(locked_page), &start,
@@ -236,7 +236,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	 * |--- delalloc ---|
 	 *                    |--- search ---|
 	 */
-	test_start = max_bytes + sectorsize;
+	test_start = max_bytes + blocksize;
 	locked_page = find_lock_page(inode->i_mapping, test_start >>
 				     PAGE_SHIFT);
 	if (!locked_page) {
@@ -503,7 +503,7 @@ static int __test_eb_bitmaps(unsigned long *bitmap, struct extent_buffer *eb)
 	return 0;
 }
 
-static int test_eb_bitmaps(u32 sectorsize, u32 nodesize)
+static int test_eb_bitmaps(u32 blocksize, u32 nodesize)
 {
 	struct btrfs_fs_info *fs_info;
 	unsigned long *bitmap = NULL;
@@ -512,7 +512,7 @@ static int test_eb_bitmaps(u32 sectorsize, u32 nodesize)
 
 	test_msg("running extent buffer bitmap tests");
 
-	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, blocksize);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		return -ENOMEM;
@@ -539,10 +539,10 @@ static int test_eb_bitmaps(u32 sectorsize, u32 nodesize)
 	free_extent_buffer(eb);
 
 	/*
-	 * Test again for case where the tree block is sectorsize aligned but
+	 * Test again for case where the tree block is blocksize aligned but
 	 * not nodesize aligned.
 	 */
-	eb = __alloc_dummy_extent_buffer(fs_info, sectorsize, nodesize);
+	eb = __alloc_dummy_extent_buffer(fs_info, blocksize, nodesize);
 	if (!eb) {
 		test_std_err(TEST_ALLOC_ROOT);
 		ret = -ENOMEM;
@@ -708,7 +708,7 @@ static void init_eb_and_memory(struct extent_buffer *eb, void *memory)
 	write_extent_buffer(eb, memory, 0, eb->len);
 }
 
-static int test_eb_mem_ops(u32 sectorsize, u32 nodesize)
+static int test_eb_mem_ops(u32 blocksize, u32 nodesize)
 {
 	struct btrfs_fs_info *fs_info;
 	struct extent_buffer *eb = NULL;
@@ -717,7 +717,7 @@ static int test_eb_mem_ops(u32 sectorsize, u32 nodesize)
 
 	test_msg("running extent buffer memory operation tests");
 
-	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, blocksize);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		return -ENOMEM;
@@ -808,13 +808,13 @@ static int test_eb_mem_ops(u32 sectorsize, u32 nodesize)
 	return ret;
 }
 
-int btrfs_test_extent_io(u32 sectorsize, u32 nodesize)
+int btrfs_test_extent_io(u32 blocksize, u32 nodesize)
 {
 	int ret;
 
 	test_msg("running extent I/O tests");
 
-	ret = test_find_delalloc(sectorsize, nodesize);
+	ret = test_find_delalloc(blocksize, nodesize);
 	if (ret)
 		goto out;
 
@@ -822,11 +822,11 @@ int btrfs_test_extent_io(u32 sectorsize, u32 nodesize)
 	if (ret)
 		goto out;
 
-	ret = test_eb_bitmaps(sectorsize, nodesize);
+	ret = test_eb_bitmaps(blocksize, nodesize);
 	if (ret)
 		goto out;
 
-	ret = test_eb_mem_ops(sectorsize, nodesize);
+	ret = test_eb_mem_ops(blocksize, nodesize);
 out:
 	return ret;
 }
diff --git a/fs/btrfs/tests/free-space-tests.c b/fs/btrfs/tests/free-space-tests.c
index ebf68fcd2149..a5b27fd53b53 100644
--- a/fs/btrfs/tests/free-space-tests.c
+++ b/fs/btrfs/tests/free-space-tests.c
@@ -87,7 +87,7 @@ static int test_extents(struct btrfs_block_group *cache)
 	return 0;
 }
 
-static int test_bitmaps(struct btrfs_block_group *cache, u32 sectorsize)
+static int test_bitmaps(struct btrfs_block_group *cache, u32 blocksize)
 {
 	u64 next_bitmap_offset;
 	int ret;
@@ -127,7 +127,7 @@ static int test_bitmaps(struct btrfs_block_group *cache, u32 sectorsize)
 	 * The first bitmap we have starts at offset 0 so the next one is just
 	 * at the end of the first bitmap.
 	 */
-	next_bitmap_offset = (u64)(BITS_PER_BITMAP * sectorsize);
+	next_bitmap_offset = (u64)(BITS_PER_BITMAP * blocksize);
 
 	/* Test a bit straddling two bitmaps */
 	ret = test_add_free_space_entry(cache, next_bitmap_offset - SZ_2M,
@@ -156,9 +156,9 @@ static int test_bitmaps(struct btrfs_block_group *cache, u32 sectorsize)
 
 /* This is the high grade jackassery */
 static int test_bitmaps_and_extents(struct btrfs_block_group *cache,
-				    u32 sectorsize)
+				    u32 blocksize)
 {
-	u64 bitmap_offset = (u64)(BITS_PER_BITMAP * sectorsize);
+	u64 bitmap_offset = (u64)(BITS_PER_BITMAP * blocksize);
 	int ret;
 
 	test_msg("running bitmap and extent tests");
@@ -393,7 +393,7 @@ static int check_cache_empty(struct btrfs_block_group *cache)
  */
 static int
 test_steal_space_from_bitmap_to_extent(struct btrfs_block_group *cache,
-				       u32 sectorsize)
+				       u32 blocksize)
 {
 	int ret;
 	u64 offset;
@@ -530,7 +530,7 @@ test_steal_space_from_bitmap_to_extent(struct btrfs_block_group *cache,
 	 * The goal is to test that the bitmap entry space stealing doesn't
 	 * steal this space region.
 	 */
-	ret = btrfs_add_free_space(cache, SZ_128M + SZ_16M, sectorsize);
+	ret = btrfs_add_free_space(cache, SZ_128M + SZ_16M, blocksize);
 	if (ret) {
 		test_err("error adding free space: %d", ret);
 		return ret;
@@ -588,8 +588,8 @@ test_steal_space_from_bitmap_to_extent(struct btrfs_block_group *cache,
 		return -ENOENT;
 	}
 
-	if (cache->free_space_ctl->free_space != (SZ_1M + sectorsize)) {
-		test_err("cache free space is not 1Mb + %u", sectorsize);
+	if (cache->free_space_ctl->free_space != (SZ_1M + blocksize)) {
+		test_err("cache free space is not 1Mb + %u", blocksize);
 		return -EINVAL;
 	}
 
@@ -604,24 +604,24 @@ test_steal_space_from_bitmap_to_extent(struct btrfs_block_group *cache,
 	}
 
 	/*
-	 * All that remains is a sectorsize free space region in a bitmap.
+	 * All that remains is a blocksize free space region in a bitmap.
 	 * Confirm.
 	 */
 	ret = check_num_extents_and_bitmaps(cache, 1, 1);
 	if (ret)
 		return ret;
 
-	if (cache->free_space_ctl->free_space != sectorsize) {
-		test_err("cache free space is not %u", sectorsize);
+	if (cache->free_space_ctl->free_space != blocksize) {
+		test_err("cache free space is not %u", blocksize);
 		return -EINVAL;
 	}
 
 	offset = btrfs_find_space_for_alloc(cache,
-					    0, sectorsize, 0,
+					    0, blocksize, 0,
 					    &max_extent_size);
 	if (offset != (SZ_128M + SZ_16M)) {
 		test_err("failed to allocate %u, returned offset : %llu",
-			 sectorsize, offset);
+			 blocksize, offset);
 		return -EINVAL;
 	}
 
@@ -728,7 +728,7 @@ test_steal_space_from_bitmap_to_extent(struct btrfs_block_group *cache,
 	 * The goal is to test that the bitmap entry space stealing doesn't
 	 * steal this space region.
 	 */
-	ret = btrfs_add_free_space(cache, SZ_32M, 2 * sectorsize);
+	ret = btrfs_add_free_space(cache, SZ_32M, 2 * blocksize);
 	if (ret) {
 		test_err("error adding free space: %d", ret);
 		return ret;
@@ -752,7 +752,7 @@ test_steal_space_from_bitmap_to_extent(struct btrfs_block_group *cache,
 
 	/*
 	 * Confirm that our extent entry didn't stole all free space from the
-	 * bitmap, because of the small 2 * sectorsize free space region.
+	 * bitmap, because of the small 2 * blocksize free space region.
 	 */
 	ret = check_num_extents_and_bitmaps(cache, 2, 1);
 	if (ret)
@@ -778,8 +778,8 @@ test_steal_space_from_bitmap_to_extent(struct btrfs_block_group *cache,
 		return -ENOENT;
 	}
 
-	if (cache->free_space_ctl->free_space != (SZ_1M + 2 * sectorsize)) {
-		test_err("cache free space is not 1Mb + %u", 2 * sectorsize);
+	if (cache->free_space_ctl->free_space != (SZ_1M + 2 * blocksize)) {
+		test_err("cache free space is not 1Mb + %u", 2 * blocksize);
 		return -EINVAL;
 	}
 
@@ -793,24 +793,24 @@ test_steal_space_from_bitmap_to_extent(struct btrfs_block_group *cache,
 	}
 
 	/*
-	 * All that remains is 2 * sectorsize free space region
+	 * All that remains is 2 * blocksize free space region
 	 * in a bitmap. Confirm.
 	 */
 	ret = check_num_extents_and_bitmaps(cache, 1, 1);
 	if (ret)
 		return ret;
 
-	if (cache->free_space_ctl->free_space != 2 * sectorsize) {
-		test_err("cache free space is not %u", 2 * sectorsize);
+	if (cache->free_space_ctl->free_space != 2 * blocksize) {
+		test_err("cache free space is not %u", 2 * blocksize);
 		return -EINVAL;
 	}
 
 	offset = btrfs_find_space_for_alloc(cache,
-					    0, 2 * sectorsize, 0,
+					    0, 2 * blocksize, 0,
 					    &max_extent_size);
 	if (offset != SZ_32M) {
 		test_err("failed to allocate %u, offset: %llu",
-			 2 * sectorsize, offset);
+			 2 * blocksize, offset);
 		return -EINVAL;
 	}
 
@@ -830,7 +830,7 @@ static bool bytes_index_use_bitmap(struct btrfs_free_space_ctl *ctl,
 	return true;
 }
 
-static int test_bytes_index(struct btrfs_block_group *cache, u32 sectorsize)
+static int test_bytes_index(struct btrfs_block_group *cache, u32 blocksize)
 {
 	const struct btrfs_free_space_op test_free_space_ops = {
 		.use_bitmap = bytes_index_use_bitmap,
@@ -853,7 +853,7 @@ static int test_bytes_index(struct btrfs_block_group *cache, u32 sectorsize)
 			test_err("couldn't add extent entry %d\n", ret);
 			return ret;
 		}
-		offset += bytes + sectorsize;
+		offset += bytes + blocksize;
 	}
 
 	for (node = rb_first_cached(&ctl->free_space_bytes), i = 9; node;
@@ -870,7 +870,7 @@ static int test_bytes_index(struct btrfs_block_group *cache, u32 sectorsize)
 	/* Now validate bitmaps do the correct thing. */
 	btrfs_remove_free_space_cache(cache);
 	for (i = 0; i < 2; i++) {
-		offset = i * BITS_PER_BITMAP * sectorsize;
+		offset = i * BITS_PER_BITMAP * blocksize;
 		bytes = (i + 1) * SZ_1M;
 		ret = test_add_free_space_entry(cache, offset, bytes, 1);
 		if (ret) {
@@ -895,26 +895,26 @@ static int test_bytes_index(struct btrfs_block_group *cache, u32 sectorsize)
 	orig_free_space_ops = cache->free_space_ctl->op;
 	cache->free_space_ctl->op = &test_free_space_ops;
 
-	ret = test_add_free_space_entry(cache, 0, sectorsize, 1);
+	ret = test_add_free_space_entry(cache, 0, blocksize, 1);
 	if (ret) {
 		test_err("couldn't add bitmap entry");
 		return ret;
 	}
 
-	offset = BITS_PER_BITMAP * sectorsize;
-	ret = test_add_free_space_entry(cache, offset, sectorsize, 1);
+	offset = BITS_PER_BITMAP * blocksize;
+	ret = test_add_free_space_entry(cache, offset, blocksize, 1);
 	if (ret) {
 		test_err("couldn't add bitmap_entry");
 		return ret;
 	}
 
 	/*
-	 * Now set a bunch of sectorsize extents in the first entry so it's
+	 * Now set a bunch of blocksize extents in the first entry so it's
 	 * ->bytes is large.
 	 */
 	for (i = 2; i < 20; i += 2) {
-		offset = sectorsize * i;
-		ret = btrfs_add_free_space(cache, offset, sectorsize);
+		offset = blocksize * i;
+		ret = btrfs_add_free_space(cache, offset, blocksize);
 		if (ret) {
 			test_err("error populating sparse bitmap %d", ret);
 			return ret;
@@ -925,8 +925,8 @@ static int test_bytes_index(struct btrfs_block_group *cache, u32 sectorsize)
 	 * Now set a contiguous extent in the second bitmap so its
 	 * ->max_extent_size is larger than the first bitmaps.
 	 */
-	offset = (BITS_PER_BITMAP * sectorsize) + sectorsize;
-	ret = btrfs_add_free_space(cache, offset, sectorsize);
+	offset = (BITS_PER_BITMAP * blocksize) + blocksize;
+	ret = btrfs_add_free_space(cache, offset, blocksize);
 	if (ret) {
 		test_err("error adding contiguous extent %d", ret);
 		return ret;
@@ -938,22 +938,22 @@ static int test_bytes_index(struct btrfs_block_group *cache, u32 sectorsize)
 	 */
 	entry = rb_entry(rb_first_cached(&ctl->free_space_bytes),
 			 struct btrfs_free_space, bytes_index);
-	if (entry->bytes != (10 * sectorsize)) {
+	if (entry->bytes != (10 * blocksize)) {
 		test_err("error, wrong entry in the first slot in bytes_index");
 		return -EINVAL;
 	}
 
 	max_extent_size = 0;
-	offset = btrfs_find_space_for_alloc(cache, cache->start, sectorsize * 3,
+	offset = btrfs_find_space_for_alloc(cache, cache->start, blocksize * 3,
 					    0, &max_extent_size);
 	if (offset != 0) {
 		test_err("found space to alloc even though we don't have enough space");
 		return -EINVAL;
 	}
 
-	if (max_extent_size != (2 * sectorsize)) {
+	if (max_extent_size != (2 * blocksize)) {
 		test_err("got the wrong max_extent size %llu expected %llu",
-			 max_extent_size, (unsigned long long)(2 * sectorsize));
+			 max_extent_size, (unsigned long long)(2 * blocksize));
 		return -EINVAL;
 	}
 
@@ -963,14 +963,14 @@ static int test_bytes_index(struct btrfs_block_group *cache, u32 sectorsize)
 	 */
 	entry = rb_entry(rb_first_cached(&ctl->free_space_bytes),
 			 struct btrfs_free_space, bytes_index);
-	if (entry->bytes != (2 * sectorsize)) {
+	if (entry->bytes != (2 * blocksize)) {
 		test_err("error, the bytes index wasn't recalculated properly");
 		return -EINVAL;
 	}
 
-	/* Add another sectorsize to re-arrange the tree back to ->bytes. */
-	offset = (BITS_PER_BITMAP * sectorsize) - sectorsize;
-	ret = btrfs_add_free_space(cache, offset, sectorsize);
+	/* Add another blocksize to re-arrange the tree back to ->bytes. */
+	offset = (BITS_PER_BITMAP * blocksize) - blocksize;
+	ret = btrfs_add_free_space(cache, offset, blocksize);
 	if (ret) {
 		test_err("error adding extent to the sparse entry %d", ret);
 		return ret;
@@ -978,7 +978,7 @@ static int test_bytes_index(struct btrfs_block_group *cache, u32 sectorsize)
 
 	entry = rb_entry(rb_first_cached(&ctl->free_space_bytes),
 			 struct btrfs_free_space, bytes_index);
-	if (entry->bytes != (11 * sectorsize)) {
+	if (entry->bytes != (11 * blocksize)) {
 		test_err("error, wrong entry in the first slot in bytes_index");
 		return -EINVAL;
 	}
@@ -988,12 +988,12 @@ static int test_bytes_index(struct btrfs_block_group *cache, u32 sectorsize)
 	 * result in a re-arranging of the tree.
 	 */
 	max_extent_size = 0;
-	offset = btrfs_find_space_for_alloc(cache, cache->start, sectorsize * 2,
+	offset = btrfs_find_space_for_alloc(cache, cache->start, blocksize * 2,
 					    0, &max_extent_size);
-	if (offset != (BITS_PER_BITMAP * sectorsize)) {
+	if (offset != (BITS_PER_BITMAP * blocksize)) {
 		test_err("error, found %llu instead of %llu for our alloc",
 			 offset,
-			 (unsigned long long)(BITS_PER_BITMAP * sectorsize));
+			 (unsigned long long)(BITS_PER_BITMAP * blocksize));
 		return -EINVAL;
 	}
 
@@ -1002,7 +1002,7 @@ static int test_bytes_index(struct btrfs_block_group *cache, u32 sectorsize)
 	return 0;
 }
 
-int btrfs_test_free_space_cache(u32 sectorsize, u32 nodesize)
+int btrfs_test_free_space_cache(u32 blocksize, u32 nodesize)
 {
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_block_group *cache;
@@ -1010,7 +1010,7 @@ int btrfs_test_free_space_cache(u32 sectorsize, u32 nodesize)
 	int ret = -ENOMEM;
 
 	test_msg("running btrfs free space cache tests");
-	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, blocksize);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		return -ENOMEM;
@@ -1022,7 +1022,7 @@ int btrfs_test_free_space_cache(u32 sectorsize, u32 nodesize)
 	 * alloc dummy block group whose size cross bitmaps.
 	 */
 	cache = btrfs_alloc_dummy_block_group(fs_info,
-				      BITS_PER_BITMAP * sectorsize + PAGE_SIZE);
+				      BITS_PER_BITMAP * blocksize + PAGE_SIZE);
 	if (!cache) {
 		test_std_err(TEST_ALLOC_BLOCK_GROUP);
 		btrfs_free_dummy_fs_info(fs_info);
@@ -1044,17 +1044,17 @@ int btrfs_test_free_space_cache(u32 sectorsize, u32 nodesize)
 	ret = test_extents(cache);
 	if (ret)
 		goto out;
-	ret = test_bitmaps(cache, sectorsize);
+	ret = test_bitmaps(cache, blocksize);
 	if (ret)
 		goto out;
-	ret = test_bitmaps_and_extents(cache, sectorsize);
+	ret = test_bitmaps_and_extents(cache, blocksize);
 	if (ret)
 		goto out;
 
-	ret = test_steal_space_from_bitmap_to_extent(cache, sectorsize);
+	ret = test_steal_space_from_bitmap_to_extent(cache, blocksize);
 	if (ret)
 		goto out;
-	ret = test_bytes_index(cache, sectorsize);
+	ret = test_bytes_index(cache, blocksize);
 out:
 	btrfs_free_dummy_block_group(cache);
 	btrfs_free_dummy_root(root);
diff --git a/fs/btrfs/tests/free-space-tree-tests.c b/fs/btrfs/tests/free-space-tree-tests.c
index b61972046feb..e804bcbb9a96 100644
--- a/fs/btrfs/tests/free-space-tree-tests.c
+++ b/fs/btrfs/tests/free-space-tree-tests.c
@@ -68,7 +68,7 @@ static int __check_free_space_extents(struct btrfs_trans_handle *trans,
 					i++;
 				}
 				prev_bit = bit;
-				offset += fs_info->sectorsize;
+				offset += fs_info->blocksize;
 			}
 		}
 		if (prev_bit == 1) {
@@ -421,7 +421,7 @@ typedef int (*test_func_t)(struct btrfs_trans_handle *,
 			   struct btrfs_path *,
 			   u32 alignment);
 
-static int run_test(test_func_t test_func, int bitmaps, u32 sectorsize,
+static int run_test(test_func_t test_func, int bitmaps, u32 blocksize,
 		    u32 nodesize, u32 alignment)
 {
 	struct btrfs_fs_info *fs_info;
@@ -431,7 +431,7 @@ static int run_test(test_func_t test_func, int bitmaps, u32 sectorsize,
 	struct btrfs_path *path = NULL;
 	int ret;
 
-	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, blocksize);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		ret = -ENOMEM;
@@ -522,32 +522,32 @@ static int run_test(test_func_t test_func, int bitmaps, u32 sectorsize,
 	return ret;
 }
 
-static int run_test_both_formats(test_func_t test_func, u32 sectorsize,
+static int run_test_both_formats(test_func_t test_func, u32 blocksize,
 				 u32 nodesize, u32 alignment)
 {
 	int test_ret = 0;
 	int ret;
 
-	ret = run_test(test_func, 0, sectorsize, nodesize, alignment);
+	ret = run_test(test_func, 0, blocksize, nodesize, alignment);
 	if (ret) {
 		test_err(
-	"%ps failed with extents, sectorsize=%u, nodesize=%u, alignment=%u",
-			 test_func, sectorsize, nodesize, alignment);
+	"%ps failed with extents, blocksize=%u, nodesize=%u, alignment=%u",
+			 test_func, blocksize, nodesize, alignment);
 		test_ret = ret;
 	}
 
-	ret = run_test(test_func, 1, sectorsize, nodesize, alignment);
+	ret = run_test(test_func, 1, blocksize, nodesize, alignment);
 	if (ret) {
 		test_err(
-	"%ps failed with bitmaps, sectorsize=%u, nodesize=%u, alignment=%u",
-			 test_func, sectorsize, nodesize, alignment);
+	"%ps failed with bitmaps, blocksize=%u, nodesize=%u, alignment=%u",
+			 test_func, blocksize, nodesize, alignment);
 		test_ret = ret;
 	}
 
 	return test_ret;
 }
 
-int btrfs_test_free_space_tree(u32 sectorsize, u32 nodesize)
+int btrfs_test_free_space_tree(u32 blocksize, u32 nodesize)
 {
 	test_func_t tests[] = {
 		test_empty_block_group,
@@ -574,12 +574,12 @@ int btrfs_test_free_space_tree(u32 sectorsize, u32 nodesize)
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		int ret;
 
-		ret = run_test_both_formats(tests[i], sectorsize, nodesize,
-					    sectorsize);
+		ret = run_test_both_formats(tests[i], blocksize, nodesize,
+					    blocksize);
 		if (ret)
 			test_ret = ret;
 
-		ret = run_test_both_formats(tests[i], sectorsize, nodesize,
+		ret = run_test_both_formats(tests[i], blocksize, nodesize,
 					    bitmap_alignment);
 		if (ret)
 			test_ret = ret;
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index 3ea3bc2225fe..e6f3a3241c5b 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -93,7 +93,7 @@ static void insert_inode_item_key(struct btrfs_root *root)
  * [69635-73731][   73731 - 86019   ][86019-90115]
  * [  regular  ][ hole but no extent][  regular  ]
  */
-static void setup_file_extents(struct btrfs_root *root, u32 sectorsize)
+static void setup_file_extents(struct btrfs_root *root, u32 blocksize)
 {
 	int slot = 0;
 	u64 disk_bytenr = SZ_1M;
@@ -107,7 +107,7 @@ static void setup_file_extents(struct btrfs_root *root, u32 sectorsize)
 	insert_extent(root, offset, 6, 6, 0, 0, 0, BTRFS_FILE_EXTENT_INLINE, 0,
 		      slot);
 	slot++;
-	offset = sectorsize;
+	offset = blocksize;
 
 	/* Now another hole */
 	insert_extent(root, offset, 4, 4, 0, 0, 0, BTRFS_FILE_EXTENT_REG, 0,
@@ -116,106 +116,106 @@ static void setup_file_extents(struct btrfs_root *root, u32 sectorsize)
 	offset += 4;
 
 	/* Now for a regular extent */
-	insert_extent(root, offset, sectorsize - 1, sectorsize - 1, 0,
-		      disk_bytenr, sectorsize - 1, BTRFS_FILE_EXTENT_REG, 0, slot);
+	insert_extent(root, offset, blocksize - 1, blocksize - 1, 0,
+		      disk_bytenr, blocksize - 1, BTRFS_FILE_EXTENT_REG, 0, slot);
 	slot++;
-	disk_bytenr += sectorsize;
-	offset += sectorsize - 1;
+	disk_bytenr += blocksize;
+	offset += blocksize - 1;
 
 	/*
 	 * Now for 3 extents that were split from a hole punch so we test
 	 * offsets properly.
 	 */
-	insert_extent(root, offset, sectorsize, 4 * sectorsize, 0, disk_bytenr,
-		      4 * sectorsize, BTRFS_FILE_EXTENT_REG, 0, slot);
+	insert_extent(root, offset, blocksize, 4 * blocksize, 0, disk_bytenr,
+		      4 * blocksize, BTRFS_FILE_EXTENT_REG, 0, slot);
 	slot++;
-	offset += sectorsize;
-	insert_extent(root, offset, sectorsize, sectorsize, 0, 0, 0,
+	offset += blocksize;
+	insert_extent(root, offset, blocksize, blocksize, 0, 0, 0,
 		      BTRFS_FILE_EXTENT_REG, 0, slot);
 	slot++;
-	offset += sectorsize;
-	insert_extent(root, offset, 2 * sectorsize, 4 * sectorsize,
-		      2 * sectorsize, disk_bytenr, 4 * sectorsize,
+	offset += blocksize;
+	insert_extent(root, offset, 2 * blocksize, 4 * blocksize,
+		      2 * blocksize, disk_bytenr, 4 * blocksize,
 		      BTRFS_FILE_EXTENT_REG, 0, slot);
 	slot++;
-	offset += 2 * sectorsize;
-	disk_bytenr += 4 * sectorsize;
+	offset += 2 * blocksize;
+	disk_bytenr += 4 * blocksize;
 
 	/* Now for a unwritten prealloc extent */
-	insert_extent(root, offset, sectorsize, sectorsize, 0, disk_bytenr,
-		sectorsize, BTRFS_FILE_EXTENT_PREALLOC, 0, slot);
+	insert_extent(root, offset, blocksize, blocksize, 0, disk_bytenr,
+		blocksize, BTRFS_FILE_EXTENT_PREALLOC, 0, slot);
 	slot++;
-	offset += sectorsize;
+	offset += blocksize;
 
 	/*
 	 * We want to jack up disk_bytenr a little more so the em stuff doesn't
 	 * merge our records.
 	 */
-	disk_bytenr += 2 * sectorsize;
+	disk_bytenr += 2 * blocksize;
 
 	/*
 	 * Now for a partially written prealloc extent, basically the same as
 	 * the hole punch example above.  Ram_bytes never changes when you mark
 	 * extents written btw.
 	 */
-	insert_extent(root, offset, sectorsize, 4 * sectorsize, 0, disk_bytenr,
-		      4 * sectorsize, BTRFS_FILE_EXTENT_PREALLOC, 0, slot);
+	insert_extent(root, offset, blocksize, 4 * blocksize, 0, disk_bytenr,
+		      4 * blocksize, BTRFS_FILE_EXTENT_PREALLOC, 0, slot);
 	slot++;
-	offset += sectorsize;
-	insert_extent(root, offset, sectorsize, 4 * sectorsize, sectorsize,
-		      disk_bytenr, 4 * sectorsize, BTRFS_FILE_EXTENT_REG, 0,
+	offset += blocksize;
+	insert_extent(root, offset, blocksize, 4 * blocksize, blocksize,
+		      disk_bytenr, 4 * blocksize, BTRFS_FILE_EXTENT_REG, 0,
 		      slot);
 	slot++;
-	offset += sectorsize;
-	insert_extent(root, offset, 2 * sectorsize, 4 * sectorsize,
-		      2 * sectorsize, disk_bytenr, 4 * sectorsize,
+	offset += blocksize;
+	insert_extent(root, offset, 2 * blocksize, 4 * blocksize,
+		      2 * blocksize, disk_bytenr, 4 * blocksize,
 		      BTRFS_FILE_EXTENT_PREALLOC, 0, slot);
 	slot++;
-	offset += 2 * sectorsize;
-	disk_bytenr += 4 * sectorsize;
+	offset += 2 * blocksize;
+	disk_bytenr += 4 * blocksize;
 
 	/* Now a normal compressed extent */
-	insert_extent(root, offset, 2 * sectorsize, 2 * sectorsize, 0,
-		      disk_bytenr, sectorsize, BTRFS_FILE_EXTENT_REG,
+	insert_extent(root, offset, 2 * blocksize, 2 * blocksize, 0,
+		      disk_bytenr, blocksize, BTRFS_FILE_EXTENT_REG,
 		      BTRFS_COMPRESS_ZLIB, slot);
 	slot++;
-	offset += 2 * sectorsize;
+	offset += 2 * blocksize;
 	/* No merges */
-	disk_bytenr += 2 * sectorsize;
+	disk_bytenr += 2 * blocksize;
 
 	/* Now a split compressed extent */
-	insert_extent(root, offset, sectorsize, 4 * sectorsize, 0, disk_bytenr,
-		      sectorsize, BTRFS_FILE_EXTENT_REG,
+	insert_extent(root, offset, blocksize, 4 * blocksize, 0, disk_bytenr,
+		      blocksize, BTRFS_FILE_EXTENT_REG,
 		      BTRFS_COMPRESS_ZLIB, slot);
 	slot++;
-	offset += sectorsize;
-	insert_extent(root, offset, sectorsize, sectorsize, 0,
-		      disk_bytenr + sectorsize, sectorsize,
+	offset += blocksize;
+	insert_extent(root, offset, blocksize, blocksize, 0,
+		      disk_bytenr + blocksize, blocksize,
 		      BTRFS_FILE_EXTENT_REG, 0, slot);
 	slot++;
-	offset += sectorsize;
-	insert_extent(root, offset, 2 * sectorsize, 4 * sectorsize,
-		      2 * sectorsize, disk_bytenr, sectorsize,
+	offset += blocksize;
+	insert_extent(root, offset, 2 * blocksize, 4 * blocksize,
+		      2 * blocksize, disk_bytenr, blocksize,
 		      BTRFS_FILE_EXTENT_REG, BTRFS_COMPRESS_ZLIB, slot);
 	slot++;
-	offset += 2 * sectorsize;
-	disk_bytenr += 2 * sectorsize;
+	offset += 2 * blocksize;
+	disk_bytenr += 2 * blocksize;
 
 	/* Now extents that have a hole but no hole extent */
-	insert_extent(root, offset, sectorsize, sectorsize, 0, disk_bytenr,
-		      sectorsize, BTRFS_FILE_EXTENT_REG, 0, slot);
+	insert_extent(root, offset, blocksize, blocksize, 0, disk_bytenr,
+		      blocksize, BTRFS_FILE_EXTENT_REG, 0, slot);
 	slot++;
-	offset += 4 * sectorsize;
-	disk_bytenr += sectorsize;
-	insert_extent(root, offset, sectorsize, sectorsize, 0, disk_bytenr,
-		      sectorsize, BTRFS_FILE_EXTENT_REG, 0, slot);
+	offset += 4 * blocksize;
+	disk_bytenr += blocksize;
+	insert_extent(root, offset, blocksize, blocksize, 0, disk_bytenr,
+		      blocksize, BTRFS_FILE_EXTENT_REG, 0, slot);
 }
 
 static u32 prealloc_only = 0;
 static u32 compressed_only = 0;
 static u32 vacancy_only = 0;
 
-static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
+static noinline int test_btrfs_get_extent(u32 blocksize, u32 nodesize)
 {
 	struct btrfs_fs_info *fs_info = NULL;
 	struct inode *inode = NULL;
@@ -234,7 +234,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		return ret;
 	}
 
-	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, blocksize);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		goto out;
@@ -258,7 +258,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 
 	/* First with no extents */
 	BTRFS_I(inode)->root = root;
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, blocksize);
 	if (IS_ERR(em)) {
 		em = NULL;
 		test_err("got an error when we shouldn't have");
@@ -276,7 +276,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	 * setup_file_extents, so if you change anything there you need to
 	 * update the comment and update the expected values below.
 	 */
-	setup_file_extents(root, sectorsize);
+	setup_file_extents(root, blocksize);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, (u64)-1);
 	if (IS_ERR(em)) {
@@ -289,7 +289,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	}
 
 	/*
-	 * For inline extent, we always round up the em to sectorsize, as
+	 * For inline extent, we always round up the em to blocksize, as
 	 * they are either:
 	 *
 	 * a) a hidden hole
@@ -298,10 +298,10 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	 * b) a file extent with unaligned bytenr
 	 *    Tree checker will reject it.
 	 */
-	if (em->start != 0 || em->len != sectorsize) {
+	if (em->start != 0 || em->len != blocksize) {
 		test_err(
 	"unexpected extent wanted start 0 len %u, got start %llu len %llu",
-			sectorsize, em->start, em->len);
+			blocksize, em->start, em->len);
 		goto out;
 	}
 	if (em->flags != 0) {
@@ -316,7 +316,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, blocksize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -339,7 +339,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* Regular extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, blocksize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -348,7 +348,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
-	if (em->start != offset || em->len != sectorsize - 1) {
+	if (em->start != offset || em->len != blocksize - 1) {
 		test_err(
 	"unexpected extent wanted start %llu len 4095, got start %llu len %llu",
 			offset, em->start, em->len);
@@ -366,7 +366,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* The next 3 are split extents */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, blocksize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -375,10 +375,10 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
-	if (em->start != offset || em->len != sectorsize) {
+	if (em->start != offset || em->len != blocksize) {
 		test_err(
 		"unexpected extent start %llu len %u, got start %llu len %llu",
-			offset, sectorsize, em->start, em->len);
+			offset, blocksize, em->start, em->len);
 		goto out;
 	}
 	if (em->flags != 0) {
@@ -394,7 +394,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, blocksize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -403,10 +403,10 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("expected a hole, got %llu", em->disk_bytenr);
 		goto out;
 	}
-	if (em->start != offset || em->len != sectorsize) {
+	if (em->start != offset || em->len != blocksize) {
 		test_err(
 	"unexpected extent wanted start %llu len %u, got start %llu len %llu",
-			offset, sectorsize, em->start, em->len);
+			offset, blocksize, em->start, em->len);
 		goto out;
 	}
 	if (em->flags != 0) {
@@ -416,7 +416,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, blocksize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -425,10 +425,10 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
-	if (em->start != offset || em->len != 2 * sectorsize) {
+	if (em->start != offset || em->len != 2 * blocksize) {
 		test_err(
 	"unexpected extent wanted start %llu len %u, got start %llu len %llu",
-			offset, 2 * sectorsize, em->start, em->len);
+			offset, 2 * blocksize, em->start, em->len);
 		goto out;
 	}
 	if (em->flags != 0) {
@@ -450,7 +450,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* Prealloc extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, blocksize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -459,10 +459,10 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
-	if (em->start != offset || em->len != sectorsize) {
+	if (em->start != offset || em->len != blocksize) {
 		test_err(
 	"unexpected extent wanted start %llu len %u, got start %llu len %llu",
-			offset, sectorsize, em->start, em->len);
+			offset, blocksize, em->start, em->len);
 		goto out;
 	}
 	if (em->flags != prealloc_only) {
@@ -478,7 +478,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* The next 3 are a half written prealloc extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, blocksize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -487,10 +487,10 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
-	if (em->start != offset || em->len != sectorsize) {
+	if (em->start != offset || em->len != blocksize) {
 		test_err(
 	"unexpected extent wanted start %llu len %u, got start %llu len %llu",
-			offset, sectorsize, em->start, em->len);
+			offset, blocksize, em->start, em->len);
 		goto out;
 	}
 	if (em->flags != prealloc_only) {
@@ -507,7 +507,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, blocksize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -516,10 +516,10 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
-	if (em->start != offset || em->len != sectorsize) {
+	if (em->start != offset || em->len != blocksize) {
 		test_err(
 	"unexpected extent wanted start %llu len %u, got start %llu len %llu",
-			offset, sectorsize, em->start, em->len);
+			offset, blocksize, em->start, em->len);
 		goto out;
 	}
 	if (em->flags != 0) {
@@ -539,7 +539,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, blocksize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -548,10 +548,10 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
-	if (em->start != offset || em->len != 2 * sectorsize) {
+	if (em->start != offset || em->len != 2 * blocksize) {
 		test_err(
 	"unexpected extent wanted start %llu len %u, got start %llu len %llu",
-			offset, 2 * sectorsize, em->start, em->len);
+			offset, 2 * blocksize, em->start, em->len);
 		goto out;
 	}
 	if (em->flags != prealloc_only) {
@@ -573,7 +573,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* Now for the compressed extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, blocksize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -582,10 +582,10 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
-	if (em->start != offset || em->len != 2 * sectorsize) {
+	if (em->start != offset || em->len != 2 * blocksize) {
 		test_err(
 	"unexpected extent wanted start %llu len %u, got start %llu len %llu",
-			offset, 2 * sectorsize, em->start, em->len);
+			offset, 2 * blocksize, em->start, em->len);
 		goto out;
 	}
 	if (em->flags != compressed_only) {
@@ -606,7 +606,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* Split compressed extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, blocksize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -615,10 +615,10 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
-	if (em->start != offset || em->len != sectorsize) {
+	if (em->start != offset || em->len != blocksize) {
 		test_err(
 	"unexpected extent wanted start %llu len %u, got start %llu len %llu",
-			offset, sectorsize, em->start, em->len);
+			offset, blocksize, em->start, em->len);
 		goto out;
 	}
 	if (em->flags != compressed_only) {
@@ -640,7 +640,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, blocksize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -649,10 +649,10 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
-	if (em->start != offset || em->len != sectorsize) {
+	if (em->start != offset || em->len != blocksize) {
 		test_err(
 	"unexpected extent wanted start %llu len %u, got start %llu len %llu",
-			offset, sectorsize, em->start, em->len);
+			offset, blocksize, em->start, em->len);
 		goto out;
 	}
 	if (em->flags != 0) {
@@ -666,7 +666,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, blocksize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -676,10 +676,10 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 			 disk_bytenr, extent_map_block_start(em));
 		goto out;
 	}
-	if (em->start != offset || em->len != 2 * sectorsize) {
+	if (em->start != offset || em->len != 2 * blocksize) {
 		test_err(
 	"unexpected extent wanted start %llu len %u, got start %llu len %llu",
-			offset, 2 * sectorsize, em->start, em->len);
+			offset, 2 * blocksize, em->start, em->len);
 		goto out;
 	}
 	if (em->flags != compressed_only) {
@@ -701,7 +701,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* A hole between regular extents but no hole extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset + 6, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset + 6, blocksize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -710,10 +710,10 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
-	if (em->start != offset || em->len != sectorsize) {
+	if (em->start != offset || em->len != blocksize) {
 		test_err(
 	"unexpected extent wanted start %llu len %u, got start %llu len %llu",
-			offset, sectorsize, em->start, em->len);
+			offset, blocksize, em->start, em->len);
 		goto out;
 	}
 	if (em->flags != 0) {
@@ -741,10 +741,10 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	 * length of the actual hole, if this changes we'll have to change this
 	 * test.
 	 */
-	if (em->start != offset || em->len != 3 * sectorsize) {
+	if (em->start != offset || em->len != 3 * blocksize) {
 		test_err(
 	"unexpected extent wanted start %llu len %u, got start %llu len %llu",
-			offset, 3 * sectorsize, em->start, em->len);
+			offset, 3 * blocksize, em->start, em->len);
 		goto out;
 	}
 	if (em->flags != vacancy_only) {
@@ -759,7 +759,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, blocksize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -768,10 +768,10 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
-	if (em->start != offset || em->len != sectorsize) {
+	if (em->start != offset || em->len != blocksize) {
 		test_err(
 	"unexpected extent wanted start %llu len %u, got start %llu len %llu",
-			offset, sectorsize, em->start, em->len);
+			offset, blocksize, em->start, em->len);
 		goto out;
 	}
 	if (em->flags != 0) {
@@ -792,7 +792,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	return ret;
 }
 
-static int test_hole_first(u32 sectorsize, u32 nodesize)
+static int test_hole_first(u32 blocksize, u32 nodesize)
 {
 	struct btrfs_fs_info *fs_info = NULL;
 	struct inode *inode = NULL;
@@ -808,7 +808,7 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 		return ret;
 	}
 
-	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, blocksize);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		goto out;
@@ -836,9 +836,9 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 	 * btrfs_get_extent.
 	 */
 	insert_inode_item_key(root);
-	insert_extent(root, sectorsize, sectorsize, sectorsize, 0, sectorsize,
-		      sectorsize, BTRFS_FILE_EXTENT_REG, 0, 1);
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, 2 * sectorsize);
+	insert_extent(root, blocksize, blocksize, blocksize, 0, blocksize,
+		      blocksize, BTRFS_FILE_EXTENT_REG, 0, 1);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, 2 * blocksize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -847,10 +847,10 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 		test_err("expected a hole, got %llu", em->disk_bytenr);
 		goto out;
 	}
-	if (em->start != 0 || em->len != sectorsize) {
+	if (em->start != 0 || em->len != blocksize) {
 		test_err(
 	"unexpected extent wanted start 0 len %u, got start %llu len %llu",
-			sectorsize, em->start, em->len);
+			blocksize, em->start, em->len);
 		goto out;
 	}
 	if (em->flags != vacancy_only) {
@@ -860,19 +860,19 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 	}
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, sectorsize, 2 * sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, blocksize, 2 * blocksize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (extent_map_block_start(em) != sectorsize) {
+	if (extent_map_block_start(em) != blocksize) {
 		test_err("expected a real extent, got %llu", extent_map_block_start(em));
 		goto out;
 	}
-	if (em->start != sectorsize || em->len != sectorsize) {
+	if (em->start != blocksize || em->len != blocksize) {
 		test_err(
 	"unexpected extent wanted start %u len %u, got start %llu len %llu",
-			sectorsize, sectorsize, em->start, em->len);
+			blocksize, blocksize, em->start, em->len);
 		goto out;
 	}
 	if (em->flags != 0) {
@@ -890,7 +890,7 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 	return ret;
 }
 
-static int test_extent_accounting(u32 sectorsize, u32 nodesize)
+static int test_extent_accounting(u32 blocksize, u32 nodesize)
 {
 	struct btrfs_fs_info *fs_info = NULL;
 	struct inode *inode = NULL;
@@ -905,7 +905,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 		return ret;
 	}
 
-	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, blocksize);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		goto out;
@@ -933,9 +933,9 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 
-	/* [BTRFS_MAX_EXTENT_SIZE][sectorsize] */
+	/* [BTRFS_MAX_EXTENT_SIZE][blocksize] */
 	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), BTRFS_MAX_EXTENT_SIZE,
-					BTRFS_MAX_EXTENT_SIZE + sectorsize - 1,
+					BTRFS_MAX_EXTENT_SIZE + blocksize - 1,
 					0, NULL);
 	if (ret) {
 		test_err("btrfs_set_extent_delalloc returned %d", ret);
@@ -948,10 +948,10 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 
-	/* [BTRFS_MAX_EXTENT_SIZE/2][sectorsize HOLE][the rest] */
+	/* [BTRFS_MAX_EXTENT_SIZE/2][blocksize HOLE][the rest] */
 	ret = clear_extent_bit(&BTRFS_I(inode)->io_tree,
 			       BTRFS_MAX_EXTENT_SIZE >> 1,
-			       (BTRFS_MAX_EXTENT_SIZE >> 1) + sectorsize - 1,
+			       (BTRFS_MAX_EXTENT_SIZE >> 1) + blocksize - 1,
 			       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
 			       EXTENT_UPTODATE, NULL);
 	if (ret) {
@@ -965,10 +965,10 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 
-	/* [BTRFS_MAX_EXTENT_SIZE][sectorsize] */
+	/* [BTRFS_MAX_EXTENT_SIZE][blocksize] */
 	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), BTRFS_MAX_EXTENT_SIZE >> 1,
 					(BTRFS_MAX_EXTENT_SIZE >> 1)
-					+ sectorsize - 1,
+					+ blocksize - 1,
 					0, NULL);
 	if (ret) {
 		test_err("btrfs_set_extent_delalloc returned %d", ret);
@@ -982,11 +982,11 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	}
 
 	/*
-	 * [BTRFS_MAX_EXTENT_SIZE+sectorsize][sectorsize HOLE][BTRFS_MAX_EXTENT_SIZE+sectorsize]
+	 * [BTRFS_MAX_EXTENT_SIZE+blocksize][blocksize HOLE][BTRFS_MAX_EXTENT_SIZE+blocksize]
 	 */
 	ret = btrfs_set_extent_delalloc(BTRFS_I(inode),
-			BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize,
-			(BTRFS_MAX_EXTENT_SIZE << 1) + 3 * sectorsize - 1,
+			BTRFS_MAX_EXTENT_SIZE + 2 * blocksize,
+			(BTRFS_MAX_EXTENT_SIZE << 1) + 3 * blocksize - 1,
 			0, NULL);
 	if (ret) {
 		test_err("btrfs_set_extent_delalloc returned %d", ret);
@@ -1000,11 +1000,11 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	}
 
 	/*
-	* [BTRFS_MAX_EXTENT_SIZE+sectorsize][sectorsize][BTRFS_MAX_EXTENT_SIZE+sectorsize]
+	* [BTRFS_MAX_EXTENT_SIZE+blocksize][blocksize][BTRFS_MAX_EXTENT_SIZE+blocksize]
 	*/
 	ret = btrfs_set_extent_delalloc(BTRFS_I(inode),
-			BTRFS_MAX_EXTENT_SIZE + sectorsize,
-			BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1, 0, NULL);
+			BTRFS_MAX_EXTENT_SIZE + blocksize,
+			BTRFS_MAX_EXTENT_SIZE + 2 * blocksize - 1, 0, NULL);
 	if (ret) {
 		test_err("btrfs_set_extent_delalloc returned %d", ret);
 		goto out;
@@ -1018,8 +1018,8 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 
 	/* [BTRFS_MAX_EXTENT_SIZE+4k][4K HOLE][BTRFS_MAX_EXTENT_SIZE+4k] */
 	ret = clear_extent_bit(&BTRFS_I(inode)->io_tree,
-			       BTRFS_MAX_EXTENT_SIZE + sectorsize,
-			       BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1,
+			       BTRFS_MAX_EXTENT_SIZE + blocksize,
+			       BTRFS_MAX_EXTENT_SIZE + 2 * blocksize - 1,
 			       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
 			       EXTENT_UPTODATE, NULL);
 	if (ret) {
@@ -1038,8 +1038,8 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	 * might fail and I'd rather satisfy my paranoia at this point.
 	 */
 	ret = btrfs_set_extent_delalloc(BTRFS_I(inode),
-			BTRFS_MAX_EXTENT_SIZE + sectorsize,
-			BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1, 0, NULL);
+			BTRFS_MAX_EXTENT_SIZE + blocksize,
+			BTRFS_MAX_EXTENT_SIZE + 2 * blocksize - 1, 0, NULL);
 	if (ret) {
 		test_err("btrfs_set_extent_delalloc returned %d", ret);
 		goto out;
@@ -1077,7 +1077,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	return ret;
 }
 
-int btrfs_test_inodes(u32 sectorsize, u32 nodesize)
+int btrfs_test_inodes(u32 blocksize, u32 nodesize)
 {
 	int ret;
 
@@ -1086,11 +1086,11 @@ int btrfs_test_inodes(u32 sectorsize, u32 nodesize)
 	compressed_only |= EXTENT_FLAG_COMPRESS_ZLIB;
 	prealloc_only |= EXTENT_FLAG_PREALLOC;
 
-	ret = test_btrfs_get_extent(sectorsize, nodesize);
+	ret = test_btrfs_get_extent(blocksize, nodesize);
 	if (ret)
 		return ret;
-	ret = test_hole_first(sectorsize, nodesize);
+	ret = test_hole_first(blocksize, nodesize);
 	if (ret)
 		return ret;
-	return test_extent_accounting(sectorsize, nodesize);
+	return test_extent_accounting(blocksize, nodesize);
 }
diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
index 3fc8dc3fd980..533fd318d848 100644
--- a/fs/btrfs/tests/qgroup-tests.c
+++ b/fs/btrfs/tests/qgroup-tests.c
@@ -203,7 +203,7 @@ static int remove_extent_ref(struct btrfs_root *root, u64 bytenr,
 }
 
 static int test_no_shared_qgroup(struct btrfs_root *root,
-		u32 sectorsize, u32 nodesize)
+		u32 blocksize, u32 nodesize)
 {
 	struct btrfs_backref_walk_ctx ctx = { 0 };
 	struct btrfs_trans_handle trans;
@@ -315,7 +315,7 @@ static int test_no_shared_qgroup(struct btrfs_root *root,
  * adjusted properly.
  */
 static int test_multiple_refs(struct btrfs_root *root,
-		u32 sectorsize, u32 nodesize)
+		u32 blocksize, u32 nodesize)
 {
 	struct btrfs_backref_walk_ctx ctx = { 0 };
 	struct btrfs_trans_handle trans;
@@ -468,14 +468,14 @@ static int test_multiple_refs(struct btrfs_root *root,
 	return 0;
 }
 
-int btrfs_test_qgroups(u32 sectorsize, u32 nodesize)
+int btrfs_test_qgroups(u32 blocksize, u32 nodesize)
 {
 	struct btrfs_fs_info *fs_info = NULL;
 	struct btrfs_root *root;
 	struct btrfs_root *tmp_root;
 	int ret = 0;
 
-	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, blocksize);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		return -ENOMEM;
@@ -548,10 +548,10 @@ int btrfs_test_qgroups(u32 sectorsize, u32 nodesize)
 	btrfs_put_root(tmp_root);
 
 	test_msg("running qgroup tests");
-	ret = test_no_shared_qgroup(root, sectorsize, nodesize);
+	ret = test_no_shared_qgroup(root, blocksize, nodesize);
 	if (ret)
 		goto out;
-	ret = test_multiple_refs(root, sectorsize, nodesize);
+	ret = test_multiple_refs(root, blocksize, nodesize);
 out:
 	btrfs_free_dummy_root(root);
 	btrfs_free_dummy_fs_info(fs_info);
diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
index 30f17eb7b6a8..825cc356e204 100644
--- a/fs/btrfs/tests/raid-stripe-tree-tests.c
+++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
@@ -458,14 +458,14 @@ static const test_func_t tests[] = {
 	test_front_delete,
 };
 
-static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)
+static int run_test(test_func_t test, u32 blocksize, u32 nodesize)
 {
 	struct btrfs_trans_handle trans;
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_root *root = NULL;
 	int ret;
 
-	fs_info = btrfs_alloc_dummy_fs_info(sectorsize, nodesize);
+	fs_info = btrfs_alloc_dummy_fs_info(blocksize, nodesize);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		ret = -ENOMEM;
@@ -520,13 +520,13 @@ static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)
 	return ret;
 }
 
-int btrfs_test_raid_stripe_tree(u32 sectorsize, u32 nodesize)
+int btrfs_test_raid_stripe_tree(u32 blocksize, u32 nodesize)
 {
 	int ret = 0;
 
 	test_msg("running raid-stripe-tree tests");
 	for (int i = 0; i < ARRAY_SIZE(tests); i++) {
-		ret = run_test(tests[i], sectorsize, nodesize);
+		ret = run_test(tests[i], blocksize, nodesize);
 		if (ret) {
 			test_err("test-case %ps failed with %d\n", tests[i], ret);
 			goto out;
-- 
2.47.1


