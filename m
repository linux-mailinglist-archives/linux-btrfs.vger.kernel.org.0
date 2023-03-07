Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6D56AD79A
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Mar 2023 07:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjCGGrO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Mar 2023 01:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCGGrN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Mar 2023 01:47:13 -0500
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [IPv6:2001:67c:2050:103:465::209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8798443479
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Mar 2023 22:47:11 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4PW5bH1xBtz9sYX;
        Tue,  7 Mar 2023 07:47:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1678171627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oQN8ES+nyzu/qyukiDr948Ag59mxtB2sb2eiN+ZV8do=;
        b=R51zwvqyka2dq6f8zULcHUF5edcPr+VBnhnz/ehTCfjuBkBeRgJb8FReOYiLOSIOGqUz2j
        wLm/bTFSIKF/ZsJS98kUkyr7GQ/B2dLurg6xDz+0vQz634jW4fmF0gn67FboKoNlBkYnQO
        rkuwm+82usEc39JTVqDY5L46kkg+Ux2YfFSr8SlFN3XgHK4DoQcn8FmTF1JOqTi3JXyqsv
        IfPg3mgkm7XtX0ZlaQbdKUnfxGiaAlncWRzdRVyVHFc8bfvVQ0MM+lNcA6ZOL07MYzZgqd
        +eSVVc4TkFucFGaATMRcBZ4a3BpgfMBok1lf253g86n4mSJ87eTMVxYjluyOfA==
Message-ID: <ee1c2db4e09997713b9a1e209c8e1e0280c0f5cc.camel@mailbox.org>
Subject: RFC PATCH v3. reduce the frequences of relink free space tree With
 benchmark data
From:   Liu Weifeng <liuwf@mailbox.org>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, Johannes.Thumshirn@wdc.com
Date:   Tue, 07 Mar 2023 01:45:55 -0500
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c123fcc3de85a93285e
X-MBO-RS-META: dimc7oaudr1165mtqmyphibuxb7y3ypp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From b5f54846c9335c7c10998fcbcdeb5004e79503f9 Mon Sep 17 00:00:00 2001
From: Liu Weifeng 4019c26b5c0d5f6b <Liuwf@mailbox.org>
Date: Mon, 6 Mar 2023 14:31:15 -0500
Subject: [RFC PATCH v3. with benchmark] reduce the frequences of relink free space tree 


Companying with the third version here are the test results that I have 
done in recent days. As showed in following, my patch on 
btrfs_find_space_for_alloc() run with nanoseconds:

	hit = 2777001, avg_ns = 93

and standard v6.1.8 resulted in

	hit = 2998001, avg_ns = 155
	
	
Note: all test times have include the overhead of ktime_get_ns() which 
requires about 50 ~ 75 ns, so the pure running time are avg 30 ns for patch, 
and avg 93 ns for standard v6.1.8. 

So, it is observed that the patch performed at 310%, or 210% faster. 


btrfs_find_space_for_alloc is less used in normal condition than clustered way
, but the patch will inprove it's performance in difficult condition. 

The improvements come from a mathematic logic: in a sorted tree/list, when a 
node get updated there is no need to resort the tree/list if the updated node 
does not change it's relative position in the series of nodes. 

In fact, alloc in cluster way (function find_free_extent_clustered) has also 
applied the logic: it does not even give a judgement whether a resort of the 
clustered tree is needed or not, before bypass the resort. 

Howevere, as for the offset indexed tree, there is a bit complexity:
many nodes may overlap with a bitmap, and this requires computing to determin 
whether it is feasible to bypass tree resort after allloc from a node.

I'm glad to use a small trick in the second version of patch that decreased 
the computing cost to the least comparing with the normal way in the first 
version.



here are the slice of final results on standard v6.1.8 running with btrfs/* :

...

some tests do not run because 'requires a valid $SCRATCH_DEV_POOL'
...
Mar  7 07:53:34 vm1 kernel: [ 1376.005431] bitmap_alloc: hit = 0, avg_ns = 0, normal_alloc: hit = 999, avg_ns ** = 64, 
Mar  7 07:53:34 vm1 kernel: [ 1376.005440] bitmap_alloc: hit = 0, avg_ns = 0, normal_alloc: hit = 2993001, avg_ns = 156, 

Mar  7 07:53:34 vm1 kernel: [ 1376.070351] bitmap_alloc: hit = 0, avg_ns = 0, normal_alloc: hit = 1999, avg_ns ** = 62, 
Mar  7 07:53:34 vm1 kernel: [ 1376.070358] bitmap_alloc: hit = 0, avg_ns = 0, normal_alloc: hit = 2994001, avg_ns = 156, 

Mar  7 07:53:34 vm1 kernel: [ 1376.128813] bitmap_alloc: hit = 0, avg_ns = 0, normal_alloc: hit = 2999, avg_ns ** = 60, 
Mar  7 07:53:34 vm1 kernel: [ 1376.128823] bitmap_alloc: hit = 0, avg_ns = 0, normal_alloc: hit = 2995001, avg_ns = 156, 

Mar  7 07:53:34 vm1 kernel: [ 1376.204516] bitmap_alloc: hit = 0, avg_ns = 0, normal_alloc: hit = 3999, avg_ns ** = 63, 
Mar  7 07:53:38 vm1 kernel: [ 1376.204523] bitmap_alloc: hit = 0, avg_ns = 0, normal_alloc: hit = 2996001, avg_ns = 156, 

Mar  7 07:53:40 vm1 kernel: [ 1382.124146] bitmap_alloc: hit = 0, avg_ns = 0, normal_alloc: hit = 1999, avg_ns ** = 123, 
Mar  7 07:53:40 vm1 kernel: [ 1382.124160] bitmap_alloc: hit = 0, avg_ns = 0, normal_alloc: hit = 2998001, avg_ns = 155, 

Failures: btrfs/219
Failed 1 of 285 tests

#--- finished ---



here are the slice of final results on my patch running with btrfs/* :

...

some tests do not run because 'requires a valid $SCRATCH_DEV_POOL'
...
Mar  7 10:35:29 vm1 kernel: [ 1382.807172] bitmap_alloc: hit = 0, avg_ns = 0, normal_alloc: hit = 999, avg_ns ** = 80, 
Mar  7 10:35:29 vm1 kernel: [ 1382.807182] bitmap_alloc: hit = 0, avg_ns = 0, normal_alloc: hit = 2773001, avg_ns = 93, 

Mar  7 10:35:29 vm1 kernel: [ 1382.870214] bitmap_alloc: hit = 0, avg_ns = 0, normal_alloc: hit = 1999, avg_ns ** = 78, 
Mar  7 10:35:29 vm1 kernel: [ 1382.870237] bitmap_alloc: hit = 0, avg_ns = 0, normal_alloc: hit = 2774001, avg_ns = 93, 

Mar  7 10:35:29 vm1 kernel: [ 1382.932837] bitmap_alloc: hit = 0, avg_ns = 0, normal_alloc: hit = 2999, avg_ns ** = 88, 
Mar  7 10:35:29 vm1 kernel: [ 1382.932847] bitmap_alloc: hit = 0, avg_ns = 0, normal_alloc: hit = 2775001, avg_ns = 93, 

Mar  7 10:35:29 vm1 kernel: [ 1383.012757] bitmap_alloc: hit = 0, avg_ns = 0, normal_alloc: hit = 3999, avg_ns ** = 86, 
Mar  7 10:35:29 vm1 kernel: [ 1383.012764] bitmap_alloc: hit = 0, avg_ns = 0, normal_alloc: hit = 2776001, avg_ns = 93, 

Mar  7 10:35:29 vm1 kernel: [ 1383.069671] bitmap_alloc: hit = 0, avg_ns = 0, normal_alloc: hit = 999, avg_ns ** = 90, 
Mar  7 10:35:33 vm1 kernel: [ 1383.069677] bitmap_alloc: hit = 0, avg_ns = 0, normal_alloc: hit = 2777001, avg_ns = 93, 

Failures: btrfs/219
Failed 1 of 285 tests

#--- finished ---



BTW: here are time correction used in my test in case of xfstests launched 
parallel tests:

t0 = ktime_get_ns();

# my patch or std code run
... 

t1 = ktime_get_ns();
while ( t1 < t0 + 50 )
	t1 = ktime_get_ns();
	
#or
while ( t1 <= t0 )
	t1 = ktime_get_ns();
	
#or do noting for time correcting


I measured ktime_get_ns() overhead on virtual machine before test, 
the avg overhead is 75 ns (with total 75xxx ns of 1000 times run). 


In either of parallel tests or seems serial test items(315 ns vs. 102 ns 
excluded ktime_get_ns() overhead), with or without time correction, I can 
always observe that patch performed at near or beyond 300% rates, that is 
200% faster than std v6.1.8. 

I'd like to post my test code if in need.

Signed-off-by: Liu Weifeng 4019c26b5c0d5f6b <Liuwf@mailbox.org>
---
 fs/btrfs/free-space-cache.c | 104 +++++++++++++++++++++++++++++++++---
 fs/btrfs/free-space-cache.h |   4 ++
 2 files changed, 102 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f4023651dd68..2954a2e0bf42 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1800,6 +1800,85 @@ tree_search_offset(struct btrfs_free_space_ctl *ctl,
 	return entry;
 }
 
+static bool _need_unlink_offset_tree(struct btrfs_free_space_ctl *ctl,
+					  struct btrfs_free_space *info,
+					  u64 new_offset, u64 new_bytes)
+{
+	struct rb_node *node = NULL;
+	struct btrfs_free_space *entry = NULL;
+
+	if (new_bytes == 0)
+		return true;
+
+	if (!(info->flags & FREE_SPACE_FLAG_CROSS_BITMAP))
+		return false;
+
+	node = rb_next(&info->offset_index);
+	if (!node)
+		return false;
+
+	entry = rb_entry(node, struct btrfs_free_space, offset_index);
+
+	if (!entry->bitmap)
+		return false;
+
+	if (new_offset <= entry->offset)
+		return false;
+
+	return true;
+}
+
+static bool _need_unlink_bytes_tree(struct btrfs_free_space_ctl *ctl,
+					 struct btrfs_free_space *info,
+					 u64 new_offset, u64 new_bytes)
+{
+	struct rb_node *node = NULL;
+	struct btrfs_free_space *entry = NULL;
+
+	if (new_bytes == 0)
+		return true;
+
+	node = rb_next(&info->bytes_index);
+	if (!node)
+		return false;
+
+	entry = rb_entry(node, struct btrfs_free_space, bytes_index);
+
+	if (new_bytes >= entry->bytes)
+		return false;
+
+	return true;
+}
+
+static void _do_alloc_and_relink_free_space(struct btrfs_free_space_ctl *ctl,
+				     struct btrfs_free_space *info,
+				     u64 new_offset, u64 new_bytes)
+{
+	bool flag_need_unlink_offset_tree;
+	bool flag_need_unlink_bytes_tree;
+
+	flag_need_unlink_offset_tree = _need_unlink_offset_tree(ctl, 
+					info, new_offset, new_bytes);
+	if (flag_need_unlink_offset_tree)
+		rb_erase(&info->offset_index, &ctl->free_space_offset);
+
+	flag_need_unlink_bytes_tree = _need_unlink_bytes_tree(ctl,
+					info, new_offset, new_bytes);
+	if (flag_need_unlink_bytes_tree)
+		rb_erase_cached(&info->bytes_index, &ctl->free_space_bytes);
+
+	info->offset = new_offset;
+	info->bytes = new_bytes;
+
+	if (flag_need_unlink_offset_tree)
+		tree_insert_offset(&ctl->free_space_offset, info->offset,
+			&info->offset_index, (info->bitmap != NULL));
+
+	if (flag_need_unlink_bytes_tree)
+		rb_add_cached(&info->bytes_index, &ctl->free_space_bytes,
+			entry_less);
+}
+
 static inline void unlink_free_space(struct btrfs_free_space_ctl *ctl,
 				     struct btrfs_free_space *info,
 				     bool update_stat)
@@ -1821,8 +1900,18 @@ static int link_free_space(struct btrfs_free_space_ctl *ctl,
 			   struct btrfs_free_space *info)
 {
 	int ret = 0;
+	u64 b_offset;
 
 	ASSERT(info->bytes || info->bitmap);
+
+	if (info->bitmap == NULL) {
+		b_offset = offset_to_bitmap(ctl, info->offset + info->bytes);
+		if (b_offset >= info->offset)
+			info->flags |= FREE_SPACE_FLAG_CROSS_BITMAP;
+		else
+			info->flags &= ~FREE_SPACE_FLAG_CROSS_BITMAP;
+	}
+
 	ret = tree_insert_offset(&ctl->free_space_offset, info->offset,
 				 &info->offset_index, (info->bitmap != NULL));
 	if (ret)
@@ -3073,6 +3162,7 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 	u64 align_gap_len = 0;
 	enum btrfs_trim_state align_gap_trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 	bool use_bytes_index = (offset == block_group->start);
+	u64 new_offset, new_bytes;
 
 	ASSERT(!btrfs_is_zoned(block_group->fs_info));
 
@@ -3093,7 +3183,6 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 		if (!entry->bytes)
 			free_bitmap(ctl, entry);
 	} else {
-		unlink_free_space(ctl, entry, true);
 		align_gap_len = offset - entry->offset;
 		align_gap = entry->offset;
 		align_gap_trim_state = entry->trim_state;
@@ -3101,14 +3190,17 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 		if (!btrfs_free_space_trimmed(entry))
 			atomic64_add(bytes, &discard_ctl->discard_bytes_saved);
 
-		entry->offset = offset + bytes;
+		new_offset = offset + bytes;
 		WARN_ON(entry->bytes < bytes + align_gap_len);
 
-		entry->bytes -= bytes + align_gap_len;
-		if (!entry->bytes)
+		new_bytes = entry->bytes - (bytes + align_gap_len);
+
+		if (!new_bytes) {
+			unlink_free_space(ctl, entry, true);
 			kmem_cache_free(btrfs_free_space_cachep, entry);
-		else
-			link_free_space(ctl, entry);
+		} else 
+			_do_alloc_and_relink_free_space(ctl, entry, 
+							new_offset, new_bytes);
 	}
 out:
 	btrfs_discard_update_discardable(block_group);
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 6d419ba53e95..0eb73ba8746e 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -20,6 +20,8 @@ enum btrfs_trim_state {
 	BTRFS_TRIM_STATE_TRIMMING,
 };
 
+#define FREE_SPACE_FLAG_CROSS_BITMAP	(1ULL << 5)
+
 struct btrfs_free_space {
 	struct rb_node offset_index;
 	struct rb_node bytes_index;
@@ -30,8 +32,10 @@ struct btrfs_free_space {
 	struct list_head list;
 	enum btrfs_trim_state trim_state;
 	s32 bitmap_extents;
+	u32 flags;
 };
 
+
 static inline bool btrfs_free_space_trimmed(struct btrfs_free_space *info)
 {
 	return (info->trim_state == BTRFS_TRIM_STATE_TRIMMED);
-- 
2.30.2


