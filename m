Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBD8300C1A
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 20:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbhAVTKo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 14:10:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730515AbhAVTIa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 14:08:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0E7223AC2
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 19:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611342468;
        bh=L/mhzaGufuYJMZMIuvPdH5RG+1IyZ0Z9p5nMFQFKHQk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eYld2/+NRYJg7+d66lZ3jyW685/gp9+mWSZT1lBKvb+9XWQegiUbbX+FpzbvU7T8E
         6rFY6KFMVekqn3beUo/huIVfQ265V9whLHpJ5lZWD/R1xccyFDM87G3Jh1OpbF6++j
         7ExM+9czWuaTdXbaC6OZOguTd3Kv/7frVfqF3vF4rQg0LLk/vfujZcsiAQnZ7eTMOX
         Hz2Y4z5Oq6KjuNDEq1XYTnYA+tnDX3J88hVhIVKVK7lHfVs87mgczr5GEsG1hcFlhH
         Vm935M5zb6kRjAXDPi3yilTc6DAVk2Oh0JfO6r2DDyOP6FOLomIt9M6TCGoFI1n1lA
         x1YNsImnacoLQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3] btrfs: fix log replay failure due to race with space cache rebuild
Date:   Fri, 22 Jan 2021 19:07:45 +0000
Message-Id: <afa2ccadd8add70cf742ed7943c01be6fccd13b8.1611340095.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c655306f61af9b2d75ed22053a7cdc3f21022d72.1611337435.git.fdmanana@suse.com>
References: <c655306f61af9b2d75ed22053a7cdc3f21022d72.1611337435.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

After a sudden power failure we may end up with a space cache on disk that
is not valid and needs to be rebuilt from scratch.

If that happens, during log replay when we attempt to pin an extent buffer
from a log tree, at btrfs_pin_extent_for_log_replay(), we do not wait for
the space cache to be rebuilt through the call to:

    btrfs_cache_block_group(cache, 1);

That is because that only waits for the task (work queue job) that loads
the space cache to change the cache state from BTRFS_CACHE_FAST to any
other value. That is ok when the space cache on disk exists and is valid,
but when the cache is not valid and needs to be rebuilt, it ends up
returning as soon as the cache state changes to BTRFS_CACHE_STARTED (done
at caching_thread()).

So this means that we can end up trying to unpin a range which is not yet
marked as free in the block group. This results in the call to
btrfs_remove_free_space() to return -EINVAL to
btrfs_pin_extent_for_log_replay(), which in turn makes the log replay fail
as well as mounting the filesystem. More specifically the -EINVAL comes
from free_space_cache.c:remove_from_bitmap(), because the requested range
is not marked as free space (ones in the bitmap), we have the following
condition triggered:

static noinline int remove_from_bitmap(struct btrfs_free_space_ctl *ctl,
(...)
       if (ret < 0 || search_start != *offset)
            return -EINVAL;
(...)

It's the "search_start != *offset" that results in the condition being
evaluated to true.

When this happens we got the following in dmesg/syslog:

[72383.415114] BTRFS: device fsid 32b95b69-0ea9-496a-9f02-3f5a56dc9322 devid 1 transid 1432 /dev/sdb scanned by mount (3816007)
[72383.417837] BTRFS info (device sdb): disk space caching is enabled
[72383.418536] BTRFS info (device sdb): has skinny extents
[72383.423846] BTRFS info (device sdb): start tree-log replay
[72383.426416] BTRFS warning (device sdb): block group 30408704 has wrong amount of free space
[72383.427686] BTRFS warning (device sdb): failed to load free space cache for block group 30408704, rebuilding it now
[72383.454291] BTRFS: error (device sdb) in btrfs_recover_log_trees:6203: errno=-22 unknown (Failed to pin buffers while recovering log root tree.)
[72383.456725] BTRFS: error (device sdb) in btrfs_replay_log:2253: errno=-22 unknown (Failed to recover log tree)
[72383.460241] BTRFS error (device sdb): open_ctree failed

We also mark the range for the extent buffer in the excluded extents io
tree. That is fine when the space cache is valid on disk and we can load
it, in which case it causes no problems.

However, for the case where we need to rebuild the space cache, because it
is either invalid or it is missing, having the extent buffer range marked
in the excluded extents io tree leads to a -EINVAL failure from the call
to btrfs_remove_free_space(), resulting in the log replay and mount to
fail. This is because by having the range marked in the excluded extents
io tree, the caching thread ends up never adding the range of the extent
buffer as free space in the block group since the calls to
add_new_free_space(), called from load_extent_tree_free(), filter out any
ranges that are marked as excluded extents.

So fix this by making sure that during log replay we wait for the caching
task to finish completely when we need to rebuild a space cache, and also
drop the need to mark the extent buffer range in the excluded extents io
tree, as well as clearing ranges from that tree at
btrfs_finish_extent_commit().

This started to happen with some frequency on large filesystems having
block groups with a lot of fragmentation since the recent commit
e747853cae3ae3 ("btrfs: load free space cache asynchronously"), but in
fact the issue has been there for years, it was just much less likely
to happen.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Updated patch with Josef's comments and combined both patches into a
    single one with an updated changelog.
V3: Eliminated no longer needed code, we do wait for the caching to be
    complete before removing free space, so a lot of code from
    __exclude_logged_extent() is no longer needed. Also fixed a leak of
    the block group in case an error happens.

 fs/btrfs/extent-tree.c | 61 +++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 43 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 30b1a630dc2f..0c335dae5af7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2602,8 +2602,6 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
 	struct btrfs_block_group *cache;
 	int ret;
 
-	btrfs_add_excluded_extent(trans->fs_info, bytenr, num_bytes);
-
 	cache = btrfs_lookup_block_group(trans->fs_info, bytenr);
 	if (!cache)
 		return -EINVAL;
@@ -2615,11 +2613,19 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
 	 * the pinned extents.
 	 */
 	btrfs_cache_block_group(cache, 1);
+	/*
+	 * Make sure we wait until the cache is completely built in case it is
+	 * missing or is invalid and therefore needs to be rebuilt.
+	 */
+	ret = btrfs_wait_block_group_cache_done(cache);
+	if (ret)
+		goto out;
 
 	pin_down_extent(trans, cache, bytenr, num_bytes, 0);
 
 	/* remove us from the free space cache (if we're there at all) */
 	ret = btrfs_remove_free_space(cache, bytenr, num_bytes);
+out:
 	btrfs_put_block_group(cache);
 	return ret;
 }
@@ -2629,50 +2635,22 @@ static int __exclude_logged_extent(struct btrfs_fs_info *fs_info,
 {
 	int ret;
 	struct btrfs_block_group *block_group;
-	struct btrfs_caching_control *caching_ctl;
 
 	block_group = btrfs_lookup_block_group(fs_info, start);
 	if (!block_group)
 		return -EINVAL;
 
-	btrfs_cache_block_group(block_group, 0);
-	caching_ctl = btrfs_get_caching_control(block_group);
-
-	if (!caching_ctl) {
-		/* Logic error */
-		BUG_ON(!btrfs_block_group_done(block_group));
-		ret = btrfs_remove_free_space(block_group, start, num_bytes);
-	} else {
-		/*
-		 * We must wait for v1 caching to finish, otherwise we may not
-		 * remove our space.
-		 */
-		btrfs_wait_space_cache_v1_finished(block_group, caching_ctl);
-		mutex_lock(&caching_ctl->mutex);
-
-		if (start >= caching_ctl->progress) {
-			ret = btrfs_add_excluded_extent(fs_info, start,
-							num_bytes);
-		} else if (start + num_bytes <= caching_ctl->progress) {
-			ret = btrfs_remove_free_space(block_group,
-						      start, num_bytes);
-		} else {
-			num_bytes = caching_ctl->progress - start;
-			ret = btrfs_remove_free_space(block_group,
-						      start, num_bytes);
-			if (ret)
-				goto out_lock;
+	btrfs_cache_block_group(block_group, 1);
+	/*
+	 * Make sure we wait until the cache is completely built in case it is
+	 * missing or is invalid and therefore needs to be rebuilt.
+	 */
+	ret = btrfs_wait_block_group_cache_done(block_group);
+	if (ret)
+		goto out;
 
-			num_bytes = (start + num_bytes) -
-				caching_ctl->progress;
-			start = caching_ctl->progress;
-			ret = btrfs_add_excluded_extent(fs_info, start,
-							num_bytes);
-		}
-out_lock:
-		mutex_unlock(&caching_ctl->mutex);
-		btrfs_put_caching_control(caching_ctl);
-	}
+	ret = btrfs_remove_free_space(block_group, start, num_bytes);
+out:
 	btrfs_put_block_group(block_group);
 	return ret;
 }
@@ -2863,9 +2841,6 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 			mutex_unlock(&fs_info->unused_bg_unpin_mutex);
 			break;
 		}
-		if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
-			clear_extent_bits(&fs_info->excluded_extents, start,
-					  end, EXTENT_UPTODATE);
 
 		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
 			ret = btrfs_discard_extent(fs_info, start,
-- 
2.28.0

