Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DE74289E0
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 11:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbhJKJpG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 05:45:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51604 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbhJKJpF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 05:45:05 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3B556220EE
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 09:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633945385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oR89M/HqteMcGxoGBohR4w7EHBcFt7BgKqnzbXloCR4=;
        b=QX2ebswVk1nnvhbeMFuibB1SuIHuyns1bmrUkJs0yXvoXrhUpogsC2PZB/B0La0Vlg2zTY
        UTgtLr1MgqJe2hHgTPCu1P8FYZ8ZK99DYRQz6RECS8S2e3V3oZImue/HPttdcR7cBGKarX
        a85T1E5UVKbm4wTupbbuTyHceYp7n1I=
Received: from adam-pc.lan (unknown [10.163.34.62])
        by relay2.suse.de (Postfix) with ESMTP id 55471A3C2B
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 09:43:04 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: rename @data parameter to @profile in extent allocation path
Date:   Mon, 11 Oct 2021 17:42:58 +0800
Message-Id: <20211011094300.97504-2-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011094300.97504-1-wqu@suse.com>
References: <20211011094300.97504-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In function btrfs_reserve_extent(), we call find_free_extent() passing
"u64 profile" into "int data".

This is definitely a width reduction, but when looking further into the
code, it's more serious than that, in fact the "int data" parameter is
not really to indicate whether it's data extent, but really a block
group profile (with block group type).

This is not only width reduction, but also confusing.

Thankfully so for we don't have any BLOCK_GROUP bits beyond 32 bits, so
the width reduction is not causing a big problem.

This patch will rename the "int data" parameter to a more proper one,
"u64 profile" in all involved call paths.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/extent-tree.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 0d62a14ea723..436948624843 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -54,7 +54,7 @@ static int __free_extent(struct btrfs_trans_handle *trans,
 			 u64 owner_offset, int refs_to_drop);
 static struct btrfs_block_group *
 btrfs_find_block_group(struct btrfs_root *root, struct btrfs_block_group
-		       *hint, u64 search_start, int data, int owner);
+		       *hint, u64 search_start, u64 profile, int owner);
 
 static int remove_sb_from_cache(struct btrfs_root *root,
 				struct btrfs_block_group *cache)
@@ -264,7 +264,7 @@ static int block_group_bits(struct btrfs_block_group *cache, u64 bits)
 
 static int noinline find_search_start(struct btrfs_root *root,
 			      struct btrfs_block_group **cache_ret,
-			      u64 *start_ret, int num, int data)
+			      u64 *start_ret, int num, u64 profile)
 {
 	int ret;
 	struct btrfs_block_group *cache = *cache_ret;
@@ -282,7 +282,7 @@ again:
 		goto out;
 
 	last = max(search_start, cache->start);
-	if (cache->ro || !block_group_bits(cache, data))
+	if (cache->ro || !block_group_bits(cache, profile))
 		goto new_group;
 
 	if (btrfs_is_zoned(root->fs_info)) {
@@ -339,7 +339,7 @@ wrapped:
 
 static struct btrfs_block_group *
 btrfs_find_block_group(struct btrfs_root *root, struct btrfs_block_group
-		       *hint, u64 search_start, int data, int owner)
+		       *hint, u64 search_start, u64 profile, int owner)
 {
 	struct btrfs_block_group *cache;
 	struct btrfs_block_group *found_group = NULL;
@@ -357,7 +357,7 @@ btrfs_find_block_group(struct btrfs_root *root, struct btrfs_block_group
 	if (search_start) {
 		struct btrfs_block_group *shint;
 		shint = btrfs_lookup_block_group(info, search_start);
-		if (shint && !shint->ro && block_group_bits(shint, data)) {
+		if (shint && !shint->ro && block_group_bits(shint, profile)) {
 			used = shint->used;
 			if (used + shint->pinned <
 			    div_factor(shint->length, factor)) {
@@ -365,7 +365,7 @@ btrfs_find_block_group(struct btrfs_root *root, struct btrfs_block_group
 			}
 		}
 	}
-	if (hint && !hint->ro && block_group_bits(hint, data)) {
+	if (hint && !hint->ro && block_group_bits(hint, profile)) {
 		used = hint->used;
 		if (used + hint->pinned <
 		    div_factor(hint->length, factor)) {
@@ -390,7 +390,7 @@ again:
 		last = cache->start + cache->length;
 		used = cache->used;
 
-		if (!cache->ro && block_group_bits(cache, data)) {
+		if (!cache->ro && block_group_bits(cache, profile)) {
 			if (full_search)
 				free_check = cache->length;
 			else
@@ -2177,7 +2177,7 @@ static int noinline find_free_extent(struct btrfs_trans_handle *trans,
 				     u64 search_start, u64 search_end,
 				     u64 hint_byte, struct btrfs_key *ins,
 				     u64 exclude_start, u64 exclude_nr,
-				     int data)
+				     u64 profile)
 {
 	int ret;
 	u64 orig_search_start = search_start;
@@ -2198,11 +2198,11 @@ static int noinline find_free_extent(struct btrfs_trans_handle *trans,
 		if (!block_group)
 			hint_byte = search_start;
 		block_group = btrfs_find_block_group(root, block_group,
-						     hint_byte, data, 1);
+						     hint_byte, profile, 1);
 	} else {
 		block_group = btrfs_find_block_group(root,
 						     trans->block_group,
-						     search_start, data, 1);
+						     search_start, profile, 1);
 	}
 
 	total_needed += empty_size;
@@ -2217,7 +2217,7 @@ check_failed:
 						       orig_search_start);
 	}
 	ret = find_search_start(root, &block_group, &search_start,
-				total_needed, data);
+				total_needed, profile);
 	if (ret)
 		goto new_group;
 
@@ -2255,7 +2255,7 @@ check_failed:
 		goto new_group;
 	}
 
-	if (!(data & BTRFS_BLOCK_GROUP_DATA)) {
+	if (!(profile & BTRFS_BLOCK_GROUP_DATA)) {
 		if (check_crossing_stripes(info, ins->objectid, num_bytes)) {
 			struct btrfs_block_group *bg_cache;
 			u64 bg_offset;
@@ -2295,7 +2295,7 @@ new_group:
 	}
 	cond_resched();
 	block_group = btrfs_find_block_group(root, block_group,
-					     search_start, data, 0);
+					     search_start, profile, 0);
 	goto check_failed;
 
 error:
-- 
2.33.0

