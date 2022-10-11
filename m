Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AFA5FB234
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJKMRW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiJKMRT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:17:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A9350193
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 05:17:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2988B815AE
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0664C433D7
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665490635;
        bh=j/fo/HYhv5LzyER1NEKyL/rwFT7JSUblpuAfunWaKEs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=A8RpU267W6+V1JVWpROrmtHBy702JrZYzqiBEHdkjKemmmCdIa3stwSSggk/jaLGN
         VurzLblLCXgEJXV7F8S8v1bQTdyf3byLdwLuXLBCNvV4Z889rTE5bchsmDOyj99e85
         af/Uv1/YkP7+3uPyxCipIfq3kQ0Jq+Wqrkrk25za/DmcwWy9LtGTpCOehcpLdPmR2t
         43enhm2RaRBDFPem0+nLYSX1IRvikVs8JO6AI2vhj0FdFDKoADxw1D4euYLmy502MS
         KIwZBpPnWcUiIKXM3FFbK0h20V9p7yWAJTTUEeh0PljzN+BZI+pD8V3ideBSS72q00
         RwnQ5xHotQRPw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 03/19] btrfs: ignore fiemap path cache if we have multiple leaves for a data extent
Date:   Tue, 11 Oct 2022 13:16:53 +0100
Message-Id: <71399b6945941e364f2bd63ebe2f41d9e2275993.1665490018.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665490018.git.fdmanana@suse.com>
References: <cover.1665490018.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The path cache used during fiemap used to determine the sharedness of
extent buffers in a path from a leaf containing a file extent item
pointing to our data extent up to the root node of the tree, is meant to
be used for a single path. Having a single path is by far the most common
case, and therefore worth to optimize for, but it's possible to actually
have multiple paths because we have 2 or more leaves.

If we have multiple leaves, the 'level' variable keeps getting incremented
in each iteration of the while loop at btrfs_is_data_extent_shared(),
which means we will treat the second leaf in the 'tmp' ulist as a level 1
node, and so forth. In the worst case this can lead to getting a level
greater than or equals to BTRFS_MAX_LEVEL (8), which will trigger a
WARN_ON_ONCE() in the functions to lookup from or store in the path cache
(lookup_backref_shared_cache() and store_backref_shared_cache()). If the
current level never goes beyond 8, due to shared nodes in the paths and
a fs tree height smaller than 8, it can still result in incorrectly
marking one leaf as shared because some other leaf is shared and is stored
one level below that other leaf, as when storing a true sharedness value
in the cache results in updating the sharedness to true of all entries in
the cache below the current level.

Having multiple leaves happens in a case like the following:

  - We have a file extent item point to data extent at bytenr X, for
    a file range [0, 1M[ for example;

  - At this moment we have an extent data ref for the extent, with
    an offset of 0 and a count of 1;

  - A write into the middle of the extent happens, file range [64K, 128K)
    so the file extent item is split into two (at btrfs_drop_extents()):

    1) One for file range [0, 64K), with a length (num_bytes field) of
       64K and an extent offset of 0;

    2) Another one for file range [128K, 1M), with a length of 896K
       (1M - 128K) and an extent offset of 128K.

  - At this moment the two file extent items are located in the same
    leaf;

  - A new file extent item for the range [64K, 128K), pointing to a new
    data extent, is inserted in the leaf. This results in a leaf split
    and now those two file extent items pointing to data extent X end
    up located in different leaves;

  - Once delayed refs are run, we still have a single extent data ref
    item for our data extent at bytenr X, for offset 0, but now with a
    count of 2 instead of 1;

  - So during fiemap, at btrfs_is_data_extent_shared(), after we call
    find_parent_nodes() for the data extent, we get two leaves, since
    we have two file extent items point to data extent at bytenr X that
    are located in two different leaves.

So skip the use of the path cache when we get more than one leaf.

Fixes: 12a824dc67a61e ("btrfs: speedup checking for extent sharedness during fiemap")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c | 25 +++++++++++++++++++++++++
 fs/btrfs/backref.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 4e29ccb234c0..4ec18ceb2f21 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1536,6 +1536,9 @@ static bool lookup_backref_shared_cache(struct btrfs_backref_shared_cache *cache
 {
 	struct btrfs_backref_shared_cache_entry *entry;
 
+	if (!cache->use_cache)
+		return false;
+
 	if (WARN_ON_ONCE(level >= BTRFS_MAX_LEVEL))
 		return false;
 
@@ -1600,6 +1603,9 @@ static void store_backref_shared_cache(struct btrfs_backref_shared_cache *cache,
 	struct btrfs_backref_shared_cache_entry *entry;
 	u64 gen;
 
+	if (!cache->use_cache)
+		return;
+
 	if (WARN_ON_ONCE(level >= BTRFS_MAX_LEVEL))
 		return;
 
@@ -1697,6 +1703,7 @@ int btrfs_is_data_extent_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
 	/* -1 means we are in the bytenr of the data extent. */
 	level = -1;
 	ULIST_ITER_INIT(&uiter);
+	cache->use_cache = true;
 	while (1) {
 		bool is_shared;
 		bool cached;
@@ -1726,6 +1733,24 @@ int btrfs_is_data_extent_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
 		    extent_gen > btrfs_root_last_snapshot(&root->root_item))
 			break;
 
+		/*
+		 * If our data extent was not directly shared (without multiple
+		 * reference items), than it might have a single reference item
+		 * with a count > 1 for the same offset, which means there are 2
+		 * (or more) file extent items that point to the data extent -
+		 * this happens when a file extent item needs to be split and
+		 * then one item gets moved to another leaf due to a b+tree leaf
+		 * split when inserting some item. In this case the file extent
+		 * items may be located in different leaves and therefore some
+		 * of the leaves may be referenced through shared subtrees while
+		 * others are not. Since our extent buffer cache only works for
+		 * a single path (by far the most common case and simpler to
+		 * deal with), we can not use it if we have multiple leaves
+		 * (which implies multiple paths).
+		 */
+		if (level == -1 && tmp->nnodes > 1)
+			cache->use_cache = false;
+
 		if (level >= 0)
 			store_backref_shared_cache(cache, root, bytenr,
 						   level, false);
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 52ae6957b414..8e69584d538d 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -29,6 +29,7 @@ struct btrfs_backref_shared_cache {
 	 * a given data extent should never exceed the maximum b+tree height.
 	 */
 	struct btrfs_backref_shared_cache_entry entries[BTRFS_MAX_LEVEL];
+	bool use_cache;
 };
 
 typedef int (iterate_extent_inodes_t)(u64 inum, u64 offset, u64 root,
-- 
2.35.1

