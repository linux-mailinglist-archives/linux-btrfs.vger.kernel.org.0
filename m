Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47C25965E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 01:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbiHPXM3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 19:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237491AbiHPXM0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 19:12:26 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77AD923E3
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 16:12:23 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s206so10575633pgs.3
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 16:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3a4TqtkHcbsVC/tLvafFZxS6Ql3tQG6iF3M5JznUDrE=;
        b=bU5AqjggHqiK4UKq5WuJwZaFJ7MWt8+2E/xjzHhfwcsCzvtOjUqRm7UvHr+j/4sH/Z
         KHo/LPDzrW7+C5xr7u2l2E5SXeTpDnV/h5MzllkD+ttz68x/PvlzrRBGhR0f+6gwsjot
         kxVFi3df4BFdcxPCtazSca7dtn2cOkk8k7tLJI1UANFel4U/M6WwVYSIbeBdlyOxRF2Q
         npFtot3sfE4Z8Q9+dprkxMKq1obOm1aKWlV8MU1eZinYv78V2WtcTNf96fkpTVrpUcOv
         astAw/uJxhSyrdQNhQxKhIR1hsBsvQ/q9XdRB5aCnqDnqJTDYvUGftIpGvgGfwFevx+e
         UOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3a4TqtkHcbsVC/tLvafFZxS6Ql3tQG6iF3M5JznUDrE=;
        b=SJlmMuYuVGlyr3DCqwmO3VInZWBt5YPzpyme7mudp9NzdKflVI+p9Ium0JV+57Ng9C
         y+6SqK4A8FwfBTOZV/GGGRbLDEw2NTgnc8O3cFK0Yv3FXC9Iv0G5Etc2lKnKE7vKgsL9
         I0SmIzI5UELGXKJ1rYmM0Zu5t+2ypvTpKMxWBhnt1kG0cYOKI0qTqdIso7l3bZtQrbIi
         mAh8/9Hnfb+EJ+87QvADlyysL+N2JUHtlrj1nxA1S56uywuyDQ9fi+YaGDOdbelRztua
         DJ1mTkZnC+xii+67L7l7eI9pgU7EgAFIb2BHMIHvG0Wl9ZuWC226NETtw4j7C/036phl
         Zp5w==
X-Gm-Message-State: ACgBeo3xoLvBNyzqFDSW4A0ladzU/pgv8NuCyXpv2aIx4nom+6bnjBnN
        aWDgoTEU3c+07ebLmmpjCC2uBgCmpAD7dg==
X-Google-Smtp-Source: AA6agR4P8GawT46JaZhgdgJy9gI7GPjrL9IdhL78OGEewyVVfFEHVGJclLEsmKSQaE/nNugDrISVnA==
X-Received: by 2002:a05:6a00:a19:b0:535:49ee:da43 with SMTP id p25-20020a056a000a1900b0053549eeda43mr3321689pfh.53.1660691542998;
        Tue, 16 Aug 2022 16:12:22 -0700 (PDT)
Received: from relinquished.hsd1.wa.comcast.net ([2601:602:a300:cc0::f972])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902e74300b0016c4f0065b4sm9721316plf.84.2022.08.16.16.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 16:12:22 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: fix space cache corruption and potential double allocations
Date:   Tue, 16 Aug 2022 16:12:15 -0700
Message-Id: <9ee45db86433bb8e4d7daff35502db241c69ad16.1660690698.git.osandov@fb.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1660690698.git.osandov@fb.com>
References: <cover.1660690698.git.osandov@fb.com>
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
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/block-group.c | 36 ++++++++++++++----------------------
 fs/btrfs/block-group.h |  3 +--
 fs/btrfs/extent-tree.c | 30 ++++++------------------------
 3 files changed, 21 insertions(+), 48 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c8162b8d85a2..1af6fc395a52 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -440,33 +440,26 @@ void btrfs_wait_block_group_cache_progress(struct btrfs_block_group *cache,
 	btrfs_put_caching_control(caching_ctl);
 }
 
-int btrfs_wait_block_group_cache_done(struct btrfs_block_group *cache)
+static int btrfs_caching_ctl_wait_done(struct btrfs_block_group *cache,
+				      struct btrfs_caching_control *caching_ctl)
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
 #ifdef CONFIG_BTRFS_DEBUG
 static void fragment_free_space(struct btrfs_block_group *block_group)
 {
@@ -744,9 +737,8 @@ static noinline void caching_thread(struct btrfs_work *work)
 	btrfs_put_block_group(block_group);
 }
 
-int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only)
+int btrfs_cache_block_group(struct btrfs_block_group *cache, bool wait)
 {
-	DEFINE_WAIT(wait);
 	struct btrfs_fs_info *fs_info = cache->fs_info;
 	struct btrfs_caching_control *caching_ctl = NULL;
 	int ret = 0;
@@ -794,8 +786,8 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
 
 	btrfs_queue_work(fs_info->caching_workers, &caching_ctl->work);
 out:
-	if (load_cache_only && caching_ctl)
-		wait_event(caching_ctl->wait, space_cache_v1_done(cache));
+	if (wait && caching_ctl)
+		ret = btrfs_caching_ctl_wait_done(cache, caching_ctl);
 	if (caching_ctl)
 		btrfs_put_caching_control(caching_ctl);
 
@@ -3288,7 +3280,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		 * space back to the block group, otherwise we will leak space.
 		 */
 		if (!alloc && !btrfs_block_group_done(cache))
-			btrfs_cache_block_group(cache, 1);
+			btrfs_cache_block_group(cache, true);
 
 		byte_in_group = bytenr - cache->start;
 		WARN_ON(byte_in_group > cache->length);
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index b5c8425839dc..9dba28bb1806 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -267,9 +267,8 @@ void btrfs_dec_nocow_writers(struct btrfs_block_group *bg);
 void btrfs_wait_nocow_writers(struct btrfs_block_group *bg);
 void btrfs_wait_block_group_cache_progress(struct btrfs_block_group *cache,
 				           u64 num_bytes);
-int btrfs_wait_block_group_cache_done(struct btrfs_block_group *cache);
 int btrfs_cache_block_group(struct btrfs_block_group *cache,
-			    int load_cache_only);
+			    bool wait);
 void btrfs_put_caching_control(struct btrfs_caching_control *ctl);
 struct btrfs_caching_control *btrfs_get_caching_control(
 		struct btrfs_block_group *cache);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 7bb05d49809b..86ac953c69ac 100644
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
 
@@ -4400,7 +4388,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		ffe_ctl->cached = btrfs_block_group_done(block_group);
 		if (unlikely(!ffe_ctl->cached)) {
 			ffe_ctl->have_caching_bg = true;
-			ret = btrfs_cache_block_group(block_group, 0);
+			ret = btrfs_cache_block_group(block_group, false);
 
 			/*
 			 * If we get ENOMEM here or something else we want to
@@ -6170,13 +6158,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 
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
2.37.2

