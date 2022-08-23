Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D64759EC6F
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 21:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiHWTfE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 15:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiHWTeh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 15:34:37 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD2341D2E
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 11:28:24 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id p13so2180809pld.6
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 11:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=OsPOMeumfvgP/SFfFblsfBcSvrgBzUFUOGd6Mh3wnBk=;
        b=0KccSHDKqZocyEbtxgGbir2OU8jgu2G+iVWLkGL7sinb/arVz6n1aHV4B6Y2qzf8fN
         fkGHI3o8Te7AxYB0SwfHc2JjBZPoE0TbshKMliAFC7YUlBRSuIiShfaTZyoyRfgp6WWf
         lKuJdeTeLdHtvPSGCvCcfr8bvPqeoLp3Tk/olCgGQBs6rgl7R/4C3Q4YfSPEjZKzFQaV
         Dz0U/lWOCkKR5wstiGYL5DUFad95vGREGTTRJb7lzH/iGeUkwexU+KvPl7JRcbQxpLH1
         sXV5YZBEKumCDXDOGLsiPg+KcL0rcl9/YlPMNBnj95VNBS8qSDNyz2BATSBm91G47BXI
         1TYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=OsPOMeumfvgP/SFfFblsfBcSvrgBzUFUOGd6Mh3wnBk=;
        b=FYynodf0ZXhtBLpkg74JzsEsH3lxAeBee3g38AdMJyEd2P/2bIpD6N2N2bDdLuHCu0
         TGGHpGZQ8+SBl9zejZgkMC+NCkxsFgWb1JvhbTqhkFS434/KXgQ77mI/G+BLa6/1KJOM
         EKQFBCklnoU9KF5JpYENNH3CmrnCtRcGR30mBuEQ7nmFCXeCGWXVnrBcruk0yNSat8uU
         7ofnhOvKCiDlscSnjXleUpbHV286PujL8zDKUw4rWwkgPZuUPxcgG+CvKnsc9uyDKykP
         KrVm2wWxqTlrOaW57eSeZFM21rYnETQL+a1bKNG9on9epIUBJgTmPLRFzfoAqTfAN63d
         bJLA==
X-Gm-Message-State: ACgBeo2J2egOVKTpPtZqpwCPJ72BmgTWMRIlPzMMfSj/FLsiRKvqDtMO
        BteCkOoN3bVWnCVVGOgyKO/x08kXAsvpfg==
X-Google-Smtp-Source: AA6agR4H5hZExSTgOeEItaknl5GnkHrZLWPElJgPx19jdtA+Og0rMpFRvFduZF3dLtaUOZGeyJ7/zQ==
X-Received: by 2002:a17:902:b104:b0:172:f66d:6604 with SMTP id q4-20020a170902b10400b00172f66d6604mr7113804plr.117.1661279302694;
        Tue, 23 Aug 2022 11:28:22 -0700 (PDT)
Received: from relinquished.thefacebook.com ([2620:10d:c090:500::2:9aae])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902f39100b0016bedcced2fsm7168184ple.35.2022.08.23.11.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:28:22 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH for 6.0] btrfs: fix space cache corruption and potential double allocations
Date:   Tue, 23 Aug 2022 11:28:13 -0700
Message-Id: <0319c896ec0f6928082173fb7a839772232ac7b5.1661278864.git.osandov@fb.com>
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
index 993aca2f1e18..e0375ba9d0fe 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -440,39 +440,26 @@ void btrfs_wait_block_group_cache_progress(struct btrfs_block_group *cache,
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
@@ -750,9 +737,8 @@ static noinline void caching_thread(struct btrfs_work *work)
 	btrfs_put_block_group(block_group);
 }
 
-int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only)
+int btrfs_cache_block_group(struct btrfs_block_group *cache, bool wait)
 {
-	DEFINE_WAIT(wait);
 	struct btrfs_fs_info *fs_info = cache->fs_info;
 	struct btrfs_caching_control *caching_ctl = NULL;
 	int ret = 0;
@@ -785,10 +771,7 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
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
 
@@ -801,8 +784,8 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
 
 	btrfs_queue_work(fs_info->caching_workers, &caching_ctl->work);
 out:
-	if (load_cache_only && caching_ctl)
-		btrfs_wait_space_cache_v1_finished(cache, caching_ctl);
+	if (wait && caching_ctl)
+		ret = btrfs_caching_ctl_wait_done(cache, caching_ctl);
 	if (caching_ctl)
 		btrfs_put_caching_control(caching_ctl);
 
@@ -3312,7 +3295,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		 * space back to the block group, otherwise we will leak space.
 		 */
 		if (!alloc && !btrfs_block_group_done(cache))
-			btrfs_cache_block_group(cache, 1);
+			btrfs_cache_block_group(cache, true);
 
 		byte_in_group = bytenr - cache->start;
 		WARN_ON(byte_in_group > cache->length);
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 35e0e860cc0b..6b3cdc4cbc41 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -263,9 +263,7 @@ void btrfs_dec_nocow_writers(struct btrfs_block_group *bg);
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
index 4edb4bfb2166..9ef162dbd4bc 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -505,7 +505,6 @@ struct btrfs_free_cluster {
 enum btrfs_caching_type {
 	BTRFS_CACHE_NO,
 	BTRFS_CACHE_STARTED,
-	BTRFS_CACHE_FAST,
 	BTRFS_CACHE_FINISHED,
 	BTRFS_CACHE_ERROR,
 };
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ab944d1f94ef..6914cd8024ba 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2551,17 +2551,10 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
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
 
@@ -2584,12 +2577,7 @@ static int __exclude_logged_extent(struct btrfs_fs_info *fs_info,
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
 
@@ -4399,7 +4387,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		ffe_ctl->cached = btrfs_block_group_done(block_group);
 		if (unlikely(!ffe_ctl->cached)) {
 			ffe_ctl->have_caching_bg = true;
-			ret = btrfs_cache_block_group(block_group, 0);
+			ret = btrfs_cache_block_group(block_group, false);
 
 			/*
 			 * If we get ENOMEM here or something else we want to
@@ -6169,13 +6157,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 
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

