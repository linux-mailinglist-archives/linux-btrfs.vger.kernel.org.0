Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B73630075E
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 16:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbhAVPbr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 10:31:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:51750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729056AbhAVP3U (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 10:29:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7871123A9A
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 15:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611329318;
        bh=jpaSE8hQuWpxEMvot6uBfNaJABtEFOa5eYHrAiStXCI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TKdaYEg56ngV7DRKx9J0iFJQ5S+lTtCB/neTjMPXnQWMeVe0TyURvkk2qIYFmiS8x
         +XseRc/2Goh8Fji3jM2+pzGa1UZb13J+inQpnL2VpV7SywJ3ykC/UifmO5RYoPcQxi
         2hxhvzz1lE0FLkUHew4Bo6nL4vAeHp6h1C9+NzofLtHdG2R/LLjOietO1g6B7Og8aH
         fZfaZj9NEtQRpuFBOT95D8HTuHTnUsnKsMxwWXFsYbTdR/x5EtOUeNz1F1b1cSQWNV
         SU9OVfn3MYaAJR4cL2KIBF9PyI3sRMQUvGHf5m9o6jU5ScLz0kCDpSuZwEuhLD4aKW
         vTTc0hG/GvhMA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix log replay failure due to race with space cache rebuild
Date:   Fri, 22 Jan 2021 15:28:34 +0000
Message-Id: <d20f67adb1ab345a9af9e0262e1aba0772832751.1611327201.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1611327201.git.fdmanana@suse.com>
References: <cover.1611327201.git.fdmanana@suse.com>
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
as well as mounting the filesystem. When this happens we got the following
in dmesg/syslog:

[72383.415114] BTRFS: device fsid 32b95b69-0ea9-496a-9f02-3f5a56dc9322 devid 1 transid 1432 /dev/sdb scanned by mount (3816007)
[72383.417837] BTRFS info (device sdb): disk space caching is enabled
[72383.418536] BTRFS info (device sdb): has skinny extents
[72383.423846] BTRFS info (device sdb): start tree-log replay
[72383.426416] BTRFS warning (device sdb): block group 30408704 has wrong amount of free space
[72383.427686] BTRFS warning (device sdb): failed to load free space cache for block group 30408704, rebuilding it now
[72383.454291] BTRFS: error (device sdb) in btrfs_recover_log_trees:6203: errno=-22 unknown (Failed to pin buffers while recovering log root tree.)
[72383.456725] BTRFS: error (device sdb) in btrfs_replay_log:2253: errno=-22 unknown (Failed to recover log tree)
[72383.460241] BTRFS error (device sdb): open_ctree failed

So fix this by making sure that during log replay we wait for the caching
task to finish completely when we need to rebuild a space cache.

Fixes: e747853cae3ae3 ("btrfs: load free space cache asynchronously")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 15 ++++++++++++---
 fs/btrfs/block-group.h |  3 ++-
 fs/btrfs/extent-tree.c | 10 +++++++++-
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 0886e81e5540..895fc69543de 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -435,10 +435,19 @@ static bool space_cache_v1_done(struct btrfs_block_group *cache)
 	return ret;
 }
 
+/*
+ * Wait for the cache to be either loaded from disk only, in case it exists and
+ * is valid, or wait until the cache is fully built in case it is missing or it
+ * is invalid.
+ */
 void btrfs_wait_space_cache_v1_finished(struct btrfs_block_group *cache,
-				struct btrfs_caching_control *caching_ctl)
+				struct btrfs_caching_control *caching_ctl,
+				bool load_only)
 {
-	wait_event(caching_ctl->wait, space_cache_v1_done(cache));
+	if (load_only)
+		wait_event(caching_ctl->wait, space_cache_v1_done(cache));
+	else
+		wait_event(caching_ctl->wait, btrfs_block_group_done(cache));
 }
 
 #ifdef CONFIG_BTRFS_DEBUG
@@ -757,7 +766,7 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
 	btrfs_queue_work(fs_info->caching_workers, &caching_ctl->work);
 out:
 	if (load_cache_only && caching_ctl)
-		btrfs_wait_space_cache_v1_finished(cache, caching_ctl);
+		btrfs_wait_space_cache_v1_finished(cache, caching_ctl, true);
 	if (caching_ctl)
 		btrfs_put_caching_control(caching_ctl);
 
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 8f74a96074f7..fe4b92cdc08b 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -269,7 +269,8 @@ u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags);
 void btrfs_put_block_group_cache(struct btrfs_fs_info *info);
 int btrfs_free_block_groups(struct btrfs_fs_info *info);
 void btrfs_wait_space_cache_v1_finished(struct btrfs_block_group *cache,
-				struct btrfs_caching_control *caching_ctl);
+				struct btrfs_caching_control *caching_ctl,
+				bool load_only);
 
 static inline u64 btrfs_data_alloc_profile(struct btrfs_fs_info *fs_info)
 {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 30b1a630dc2f..594534482ad3 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2600,6 +2600,7 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
 				    u64 bytenr, u64 num_bytes)
 {
 	struct btrfs_block_group *cache;
+	struct btrfs_caching_control *caching_ctl;
 	int ret;
 
 	btrfs_add_excluded_extent(trans->fs_info, bytenr, num_bytes);
@@ -2615,6 +2616,13 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
 	 * the pinned extents.
 	 */
 	btrfs_cache_block_group(cache, 1);
+	/*
+	 * Make sure we wait until the cache is comletely built in case it is
+	 * missing or is invalid and therefore needs to be rebuilt.
+	 */
+	caching_ctl = btrfs_get_caching_control(cache);
+	if (caching_ctl)
+		btrfs_wait_space_cache_v1_finished(cache, caching_ctl, false);
 
 	pin_down_extent(trans, cache, bytenr, num_bytes, 0);
 
@@ -2647,7 +2655,7 @@ static int __exclude_logged_extent(struct btrfs_fs_info *fs_info,
 		 * We must wait for v1 caching to finish, otherwise we may not
 		 * remove our space.
 		 */
-		btrfs_wait_space_cache_v1_finished(block_group, caching_ctl);
+		btrfs_wait_space_cache_v1_finished(block_group, caching_ctl, false);
 		mutex_lock(&caching_ctl->mutex);
 
 		if (start >= caching_ctl->progress) {
-- 
2.28.0

