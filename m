Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E56959EC73
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 21:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiHWTfJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 15:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiHWTel (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 15:34:41 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD2178212
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 11:28:26 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id d71so12959466pgc.13
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 11:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=I2TJV1dX4RRMPDmYlqi8qLyE6vDuVBlWzphYwN/lozc=;
        b=PyZ6P4IVQ9MukZVCmrDW2jmpbG8/uMC457niLjrjVeLZiiQPCb7TG903TQmHySTi/G
         7CIxAoH6puDd6AEgA3GdQizdjEvR5tPbnC0J+AwbLQkhQiK5UCQbgAlmDzNciK/436z5
         V98BvSvqXUeQd52fhyDLKbeY5nQnIcTqk9FcGKypoN0WmX+gYcHbbauu1aTg9QlRmBsy
         DCUZ9K96TwsFCBeDJAcTMwUr/1xY6ebME5ZeMXPH1V1M3EWhnHVGZyNgApj191hf/ifv
         ieUqh5QcjXSZ051kpR36kY/0U4tM1yW0pO7eXxeRD8ufaax4f3jibxgZBiWww+zGL7I7
         FgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=I2TJV1dX4RRMPDmYlqi8qLyE6vDuVBlWzphYwN/lozc=;
        b=3E0cbtYZ+mNvFIB1yT7Zoc1uBoLNmM3WmimOpEBZPCpJuYDj1TiMhPS0sqZnTuTRvC
         hrsttu3yxuzqlYYlcwPmjq9UTvbyT3g0SwJyq6tuAF3S3h9Awwbsy/QiPbs3pSOtulFc
         b9KQZ6jKYQDX/qpg2fEWP7AkQRHt3f3MlkgJqPOxwCwnZkj4evpXz4uvbopIDG0Tx7bk
         Va3DHtfTpVau0iifeNhk28O/dQ2adqvO3KXZH6Wgl5TQ2o98REPRXl4pxa3Oo6d7tceD
         /xZ2v5ZDLv9BV3AEPv4+3bL51AZeeYU38TecV9E2s7WfwnvOBOE0Uxo5EmPQMr1Cot+X
         1m3w==
X-Gm-Message-State: ACgBeo1A06jzwRhDscR6OAgg7c4+Lk7vJEAMwZM0TKHGeqF64N7kAaEc
        u2oOfa0da+aeaN5+4Ln/o5fxZG0EUkc6zQ==
X-Google-Smtp-Source: AA6agR4PNvtXiS/ugtCDr6qPq4Wx16Nt6Qack5jr5/VSFhyZSxAUUuQbko7cD4+zDoXo5fiaSl78QA==
X-Received: by 2002:a63:8b44:0:b0:41c:df4c:7275 with SMTP id j65-20020a638b44000000b0041cdf4c7275mr22057265pge.434.1661279304087;
        Tue, 23 Aug 2022 11:28:24 -0700 (PDT)
Received: from relinquished.thefacebook.com ([2620:10d:c090:500::2:9aae])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902f39100b0016bedcced2fsm7168184ple.35.2022.08.23.11.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:28:23 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH for 5.15] btrfs: fix space cache corruption and potential double allocations
Date:   Tue, 23 Aug 2022 11:28:14 -0700
Message-Id: <24f0ad243a15ce80edf77620981a1a097acca297.1661278864.git.osandov@fb.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1661278864.git.osandov@fb.com>
References: <cover.1661278864.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

When testing space_cache v2 on a large set of machines, we encountered a
few symptoms:

1. "unable to add free space :-17" (EEXIST) errors.
2. Missing free space info items, sometimes caught with a "missing free
   space info for X" error.
3. Double-accounted space: ranges that were allocated in the extent tree
   and also marked as free in the free space tree, ranges that were
   marked as allocated twice in the extent tree, or ranges that were
   marked as free twice in the free space tree. If the latter made it
   onto disk, the next reboot would hit the BUG_ON() in
   add_new_free_space().
4. On some hosts with no on-disk corruption or error messages, the
   in-memory space cache (dumped with drgn) disagreed with the free
   space tree.

All of these symptoms have the same underlying cause: a race between
caching the free space for a block group and returning free space to the
in-memory space cache for pinned extents causes us to double-add a free
range to the space cache. This race exists when free space is cached
from the free space tree (space_cache=v2) or the extent tree
(nospace_cache, or space_cache=v1 if the cache needs to be regenerated).
struct btrfs_block_group::last_byte_to_unpin and struct
btrfs_block_group::progress are supposed to protect against this race,
but commit d0c2f4fa555e ("btrfs: make concurrent fsyncs wait less when
waiting for a transaction commit") subtly broke this by allowing
multiple transactions to be unpinning extents at the same time.

Specifically, the race is as follows:

1. An extent is deleted from an uncached block group in transaction A.
2. btrfs_commit_transaction() is called for transaction A.
3. btrfs_run_delayed_refs() -> __btrfs_free_extent() runs the delayed
   ref for the deleted extent.
4. __btrfs_free_extent() -> do_free_extent_accounting() ->
   add_to_free_space_tree() adds the deleted extent back to the free
   space tree.
5. do_free_extent_accounting() -> btrfs_update_block_group() ->
   btrfs_cache_block_group() queues up the block group to get cached.
   block_group->progress is set to block_group->start.
6. btrfs_commit_transaction() for transaction A calls
   switch_commit_roots(). It sets block_group->last_byte_to_unpin to
   block_group->progress, which is block_group->start because the block
   group hasn't been cached yet.
7. The caching thread gets to our block group. Since the commit roots
   were already switched, load_free_space_tree() sees the deleted extent
   as free and adds it to the space cache. It finishes caching and sets
   block_group->progress to U64_MAX.
8. btrfs_commit_transaction() advances transaction A to
   TRANS_STATE_SUPER_COMMITTED.
9. fsync calls btrfs_commit_transaction() for transaction B. Since
   transaction A is already in TRANS_STATE_SUPER_COMMITTED and the
   commit is for fsync, it advances.
10. btrfs_commit_transaction() for transaction B calls
    switch_commit_roots(). This time, the block group has already been
    cached, so it sets block_group->last_byte_to_unpin to U64_MAX.
11. btrfs_commit_transaction() for transaction A calls
    btrfs_finish_extent_commit(), which calls unpin_extent_range() for
    the deleted extent. It sees last_byte_to_unpin set to U64_MAX (by
    transaction B!), so it adds the deleted extent to the space cache
    again!

This explains all of our symptoms above:

* If the sequence of events is exactly as described above, when the free
  space is re-added in step 11, it will fail with EEXIST.
* If another thread reallocates the deleted extent in between steps 7
  and 11, then step 11 will silently re-add that space to the space
  cache as free even though it is actually allocated. Then, if that
  space is allocated *again*, the free space tree will be corrupted
  (namely, the wrong item will be deleted).
* If we don't catch this free space tree corruption, it will continue
  to get worse as extents are deleted and reallocated.

The v1 space_cache is synchronously loaded when an extent is deleted
(btrfs_update_block_group() with alloc=0 calls btrfs_cache_block_group()
with load_cache_only=1), so it is not normally affected by this bug.
However, as noted above, if we fail to load the space cache, we will
fall back to caching from the extent tree and may hit this bug.

The easiest fix for this race is to also make caching from the free
space tree or extent tree synchronous. Josef tested this and found no
performance regressions.

A few extra changes fall out of this change. Namely, this fix does the
following, with step 2 being the crucial fix:

1. Factor btrfs_caching_ctl_wait_done() out of
   btrfs_wait_block_group_cache_done() to allow waiting on a caching_ctl
   that we already hold a reference to.
2. Change the call in btrfs_cache_block_group() of
   btrfs_wait_space_cache_v1_finished() to
   btrfs_caching_ctl_wait_done(), which makes us wait regardless of the
   space_cache option.
3. Delete the now unused btrfs_wait_space_cache_v1_finished() and
   space_cache_v1_done().
4. Change btrfs_cache_block_group()'s `int load_cache_only` parameter to
   `bool wait` to more accurately describe its new meaning.
5. Change a few callers which had a separate call to
   btrfs_wait_block_group_cache_done() to use wait = true instead.
6. Make btrfs_wait_block_group_cache_done() static now that it's not
   used outside of block-group.c anymore.

Fixes: d0c2f4fa555e ("btrfs: make concurrent fsyncs wait less when waiting for a transaction commit")
CC: stable@vger.kernel.org # 5.12+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/block-group.c | 47 ++++++++++++++----------------------------
 fs/btrfs/block-group.h |  4 +---
 fs/btrfs/ctree.h       |  1 -
 fs/btrfs/extent-tree.c | 30 ++++++---------------------
 4 files changed, 22 insertions(+), 60 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 4b2282aa274e..182ffa46fb7b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -418,39 +418,26 @@ void btrfs_wait_block_group_cache_progress(struct btrfs_block_group *cache,
 	btrfs_put_caching_control(caching_ctl);
 }
 
-int btrfs_wait_block_group_cache_done(struct btrfs_block_group *cache)
+static int btrfs_caching_ctl_wait_done(struct btrfs_block_group *cache,
+				       struct btrfs_caching_control *caching_ctl)
+{
+	wait_event(caching_ctl->wait, btrfs_block_group_done(cache));
+	return cache->cached == BTRFS_CACHE_ERROR ? -EIO : 0;
+}
+
+static int btrfs_wait_block_group_cache_done(struct btrfs_block_group *cache)
 {
 	struct btrfs_caching_control *caching_ctl;
-	int ret = 0;
+	int ret;
 
 	caching_ctl = btrfs_get_caching_control(cache);
 	if (!caching_ctl)
 		return (cache->cached == BTRFS_CACHE_ERROR) ? -EIO : 0;
-
-	wait_event(caching_ctl->wait, btrfs_block_group_done(cache));
-	if (cache->cached == BTRFS_CACHE_ERROR)
-		ret = -EIO;
+	ret = btrfs_caching_ctl_wait_done(cache, caching_ctl);
 	btrfs_put_caching_control(caching_ctl);
 	return ret;
 }
 
-static bool space_cache_v1_done(struct btrfs_block_group *cache)
-{
-	bool ret;
-
-	spin_lock(&cache->lock);
-	ret = cache->cached != BTRFS_CACHE_FAST;
-	spin_unlock(&cache->lock);
-
-	return ret;
-}
-
-void btrfs_wait_space_cache_v1_finished(struct btrfs_block_group *cache,
-				struct btrfs_caching_control *caching_ctl)
-{
-	wait_event(caching_ctl->wait, space_cache_v1_done(cache));
-}
-
 #ifdef CONFIG_BTRFS_DEBUG
 static void fragment_free_space(struct btrfs_block_group *block_group)
 {
@@ -727,9 +714,8 @@ static noinline void caching_thread(struct btrfs_work *work)
 	btrfs_put_block_group(block_group);
 }
 
-int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only)
+int btrfs_cache_block_group(struct btrfs_block_group *cache, bool wait)
 {
-	DEFINE_WAIT(wait);
 	struct btrfs_fs_info *fs_info = cache->fs_info;
 	struct btrfs_caching_control *caching_ctl = NULL;
 	int ret = 0;
@@ -762,10 +748,7 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
 	}
 	WARN_ON(cache->caching_ctl);
 	cache->caching_ctl = caching_ctl;
-	if (btrfs_test_opt(fs_info, SPACE_CACHE))
-		cache->cached = BTRFS_CACHE_FAST;
-	else
-		cache->cached = BTRFS_CACHE_STARTED;
+	cache->cached = BTRFS_CACHE_STARTED;
 	cache->has_caching_ctl = 1;
 	spin_unlock(&cache->lock);
 
@@ -778,8 +761,8 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
 
 	btrfs_queue_work(fs_info->caching_workers, &caching_ctl->work);
 out:
-	if (load_cache_only && caching_ctl)
-		btrfs_wait_space_cache_v1_finished(cache, caching_ctl);
+	if (wait && caching_ctl)
+		ret = btrfs_caching_ctl_wait_done(cache, caching_ctl);
 	if (caching_ctl)
 		btrfs_put_caching_control(caching_ctl);
 
@@ -3198,7 +3181,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		 * space back to the block group, otherwise we will leak space.
 		 */
 		if (!alloc && !btrfs_block_group_done(cache))
-			btrfs_cache_block_group(cache, 1);
+			btrfs_cache_block_group(cache, true);
 
 		byte_in_group = bytenr - cache->start;
 		WARN_ON(byte_in_group > cache->length);
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index d73db0dfacb2..a15868d607a9 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -251,9 +251,7 @@ void btrfs_dec_nocow_writers(struct btrfs_fs_info *fs_info, u64 bytenr);
 void btrfs_wait_nocow_writers(struct btrfs_block_group *bg);
 void btrfs_wait_block_group_cache_progress(struct btrfs_block_group *cache,
 				           u64 num_bytes);
-int btrfs_wait_block_group_cache_done(struct btrfs_block_group *cache);
-int btrfs_cache_block_group(struct btrfs_block_group *cache,
-			    int load_cache_only);
+int btrfs_cache_block_group(struct btrfs_block_group *cache, bool wait);
 void btrfs_put_caching_control(struct btrfs_caching_control *ctl);
 struct btrfs_caching_control *btrfs_get_caching_control(
 		struct btrfs_block_group *cache);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d1838de0b39c..8dafb6bf62bd 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -462,7 +462,6 @@ struct btrfs_free_cluster {
 enum btrfs_caching_type {
 	BTRFS_CACHE_NO,
 	BTRFS_CACHE_STARTED,
-	BTRFS_CACHE_FAST,
 	BTRFS_CACHE_FINISHED,
 	BTRFS_CACHE_ERROR,
 };
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 248ea15c9734..8c007abf81f0 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2572,17 +2572,10 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
 		return -EINVAL;
 
 	/*
-	 * pull in the free space cache (if any) so that our pin
-	 * removes the free space from the cache.  We have load_only set
-	 * to one because the slow code to read in the free extents does check
-	 * the pinned extents.
+	 * Fully cache the free space first so that our pin removes the free space
+	 * from the cache.
 	 */
-	btrfs_cache_block_group(cache, 1);
-	/*
-	 * Make sure we wait until the cache is completely built in case it is
-	 * missing or is invalid and therefore needs to be rebuilt.
-	 */
-	ret = btrfs_wait_block_group_cache_done(cache);
+	ret = btrfs_cache_block_group(cache, true);
 	if (ret)
 		goto out;
 
@@ -2605,12 +2598,7 @@ static int __exclude_logged_extent(struct btrfs_fs_info *fs_info,
 	if (!block_group)
 		return -EINVAL;
 
-	btrfs_cache_block_group(block_group, 1);
-	/*
-	 * Make sure we wait until the cache is completely built in case it is
-	 * missing or is invalid and therefore needs to be rebuilt.
-	 */
-	ret = btrfs_wait_block_group_cache_done(block_group);
+	ret = btrfs_cache_block_group(block_group, true);
 	if (ret)
 		goto out;
 
@@ -4324,7 +4312,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		ffe_ctl.cached = btrfs_block_group_done(block_group);
 		if (unlikely(!ffe_ctl.cached)) {
 			ffe_ctl.have_caching_bg = true;
-			ret = btrfs_cache_block_group(block_group, 0);
+			ret = btrfs_cache_block_group(block_group, false);
 
 			/*
 			 * If we get ENOMEM here or something else we want to
@@ -6066,13 +6054,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 
 		if (end - start >= range->minlen) {
 			if (!btrfs_block_group_done(cache)) {
-				ret = btrfs_cache_block_group(cache, 0);
-				if (ret) {
-					bg_failed++;
-					bg_ret = ret;
-					continue;
-				}
-				ret = btrfs_wait_block_group_cache_done(cache);
+				ret = btrfs_cache_block_group(cache, true);
 				if (ret) {
 					bg_failed++;
 					bg_ret = ret;
-- 
2.30.2

