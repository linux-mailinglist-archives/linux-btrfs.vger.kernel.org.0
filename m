Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EE2300754
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 16:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbhAVP3q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 10:29:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:51752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729062AbhAVP3U (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 10:29:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 462BF23AA1
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 15:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611329319;
        bh=EaWa5wVGN84rAWHQm4K9fRsLC36c9YB3QbKunFD3fug=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=o3r3GAdsrSSdcsBNoh+ZnxCCgAu8CV2Y3O+aHZo8zq51New43Wt2f8n0vExVRXVrz
         2SmO90WcAwNJxMq21GH3/Qtu55zHM+rOVXdeqHUf/NkeQSDBLKxrVucn35J+nxWS32
         LNNK8j6B3rCwg+wmvmAF1pEL1tXu0J2USMWekmP4ciGefcOPuxssULpMOOWQwIDpS7
         4A10fHDhG82xJdGJFmA47BOqzrdjxPYfeQ/xSwX8HX0VcSs4Mj2u7DiNSBdHgkOYQA
         tqlGFXcfFFFnbljcdl2jiKi9o4zQZHvixiVx0I+9aA79lFULUsH7bapYH79c6D28FG
         KNnPTyDXZn1Zg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: fix log replay failure when space cache needs to be rebuilt
Date:   Fri, 22 Jan 2021 15:28:35 +0000
Message-Id: <7950c4b5c5e1579b541477e27fc1e597b5fc44e3.1611327201.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1611327201.git.fdmanana@suse.com>
References: <cover.1611327201.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During log replay we first start by walking the log trees and pin the
ranges for their extent buffers, through calls to the function
btrfs_pin_extent_for_log_replay().

However if the space cache for a block group is invalid and needs to be
rebuilt, we can fail the log replay and mount with -EINVAL like this:

 [72383.415114] BTRFS: device fsid 32b95b69-0ea9-496a-9f02-3f5a56dc9322 devid 1 transid 1432 /dev/sdb scanned by mount (3816007)
 [72383.417837] BTRFS info (device sdb): disk space caching is enabled
 [72383.418536] BTRFS info (device sdb): has skinny extents
 [72383.423846] BTRFS info (device sdb): start tree-log replay
 [72383.426416] BTRFS warning (device sdb): block group 30408704 has wrong amount of free space
 [72383.427686] BTRFS warning (device sdb): failed to load free space cache for block group 30408704, rebuilding it now
 [72383.454291] BTRFS: error (device sdb) in btrfs_recover_log_trees:6203: errno=-22 unknown (Failed to pin buffers while recovering log root tree.)
 [72383.456725] BTRFS: error (device sdb) in btrfs_replay_log:2253: errno=-22 unknown (Failed to recover log tree)
 [72383.460241] BTRFS error (device sdb): open_ctree failed

This is because at the start of btrfs_pin_extent_for_log_replay() we mark
the range for the extent buffer in excluded extents io tree. That is fine
when the space cache is valid on disk and we can load it, in which case it
causes no problems - in fact it is pointless since shortly after, still at
btrfs_pin_extent_for_log_replay(), we remove the range from the free space
cache with the call to btrfs_remove_free_space(().

However, for the case where we need to rebuild the space cache, because it
is either invalid or it is missing, having the extent buffer range marked
in the excluded extents io tree leads to a -EINVAL failure from the call
to btrfs_remove_free_space(), resulting in the log replay and mount to
fail. This is because by having the range marked in the excluded extents
io tree, the caching thread ends never marking adding the range of the
extent buffer marked as free space in the block group since the calls to
add_new_free_space(), called from load_extent_tree_free(), filter out any
ranges that are marked as excluded extents.

So fix this by not marking the extent buffer range in the excluded extents
io tree at btrfs_pin_extent_for_log_replay() since it leads to the failure
when a space cache needs to be rebuilt and it is useless when we do not
need to rebuild a space cache. Also, remove the cleanup of ranges in the
excluded extents io tree at btrfs_finish_extent_commit() since they were
there to cleanup the ranges added by btrfs_pin_extent_for_log_replay().

Fixes: f2fb72983bdcf5 ("btrfs: Mark pinned log extents as excluded")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 594534482ad3..4fc3f560c3dd 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2603,8 +2603,6 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
 	struct btrfs_caching_control *caching_ctl;
 	int ret;
 
-	btrfs_add_excluded_extent(trans->fs_info, bytenr, num_bytes);
-
 	cache = btrfs_lookup_block_group(trans->fs_info, bytenr);
 	if (!cache)
 		return -EINVAL;
@@ -2871,9 +2869,6 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
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

