Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABB56E135
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2019 08:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfGSGvy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jul 2019 02:51:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:38676 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726709AbfGSGvy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jul 2019 02:51:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD23CAC8F
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2019 06:51:52 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/4] btrfs: volumes: Remove ENOSPC-prone btrfs_can_relocate()
Date:   Fri, 19 Jul 2019 14:51:44 +0800
Message-Id: <20190719065144.15263-5-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190719065144.15263-1-wqu@suse.com>
References: <20190719065144.15263-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Test case btrfs/156 fails since commit 302167c50b32 ("btrfs: don't end
the transaction for delayed refs in throttle") with ENOSPC.

[CAUSE]
The ENOSPC is reported from btrfs_can_relocate().

This function will check:
- If this block group is empty, we can relocate
- If we can enough free space, we can relocate

Above checks are valid but the following check is vague due to its
implementation:
- If and only if we can allocated a new block group to contain all the
  used space, we can relocate

This design itself is OK, but the way to determine if we can allocate a
new block group is problematic.

btrfs_can_relocate() uses find_free_dev_extent() to find free space on a
device.
However find_free_dev_extent() only searches commit root and excludes
dev extents allocated in current trans, this makes it unable to use dev
extent just freed in current transaction.

So for the following example, btrfs_can_relocate() will report ENOSPC:
The example block group layout:
1M      129M        257M       385M      513M       550M
|///////|///////////|//////////|         |          |
// = Used bg, consider all bg is 100% used for easy calculation.
And all block groups are SINGLE, on-disk bytenr is the same as the
logical bytenr.

1) Bg in [129M, 257M) get relocated to [385M, 513M), transid=100
1M      129M        257M       385M      513M       550M
|///////|           |//////////|/////////|
In transid 100, bg in [129M, 257M) get relocated to [385M, 513M)

However transid 100 is not committed yet, so in dev commit tree, we
still have the old dev extents layout:
1M      129M        257M       385M      513M       550M
|///////|///////////|//////////|         |          |

2) Try to relocate bg [257M, 385M)
We goes into btrfs_can_relocate(), no free space in current bgs, so we
check if we can find large enough free dev extents.

The first slot is [385M, 513M), but that is already used by new bg at
[385M, 513M), so we continue search.

The remaining slot is [512M, 550M), smaller than the bg's length 128M.
So btrfs_can_relocate report ENOSPC.

However this is over killed, in fact if we just skip btrfs_can_relocate()
check, and go into regular relocation routine, at extent reservation time,
if we can't find free extent, then we fallback to commit transaction,
which will free up the dev extents and allow new block group to be created.

[FIX]
The fix here is to remove btrfs_can_relocate() completely.

If we hit the false ENOSPC case just like btrfs/156, extent allocator
will push harder by committing transaction and we will have space for
new block group, avoiding the false ENOSPC.

If we really ran out of space, we will hit ENOSPC at
relocate_block_group(), and btrfs will just reports the ENOSPC error as
usual.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h       |   1 -
 fs/btrfs/extent-tree.c | 141 -----------------------------------------
 fs/btrfs/volumes.c     |   4 --
 3 files changed, 146 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0a61dff27f57..965d1e5a4af7 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2772,7 +2772,6 @@ int btrfs_setup_space_cache(struct btrfs_trans_handle *trans);
 int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr);
 int btrfs_free_block_groups(struct btrfs_fs_info *info);
 int btrfs_read_block_groups(struct btrfs_fs_info *info);
-int btrfs_can_relocate(struct btrfs_fs_info *fs_info, u64 bytenr);
 int btrfs_make_block_group(struct btrfs_trans_handle *trans,
 			   u64 bytes_used, u64 type, u64 chunk_offset,
 			   u64 size);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 156ef906885f..32fea01d28b7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -9793,147 +9793,6 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache)
 	spin_unlock(&sinfo->lock);
 }
 
-/*
- * Checks to see if it's even possible to relocate this block group.
- *
- * @return - -1 if it's not a good idea to relocate this block group, 0 if its
- * ok to go ahead and try.
- */
-int btrfs_can_relocate(struct btrfs_fs_info *fs_info, u64 bytenr)
-{
-	struct btrfs_block_group_cache *block_group;
-	struct btrfs_space_info *space_info;
-	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
-	struct btrfs_device *device;
-	u64 min_free;
-	u64 dev_min = 1;
-	u64 dev_nr = 0;
-	u64 target;
-	int debug;
-	int index;
-	int full = 0;
-	int ret = 0;
-
-	debug = btrfs_test_opt(fs_info, ENOSPC_DEBUG);
-
-	block_group = btrfs_lookup_block_group(fs_info, bytenr);
-
-	/* odd, couldn't find the block group, leave it alone */
-	if (!block_group) {
-		if (debug)
-			btrfs_warn(fs_info,
-				   "can't find block group for bytenr %llu",
-				   bytenr);
-		return -1;
-	}
-
-	min_free = btrfs_block_group_used(&block_group->item);
-
-	/* no bytes used, we're good */
-	if (!min_free)
-		goto out;
-
-	space_info = block_group->space_info;
-	spin_lock(&space_info->lock);
-
-	full = space_info->full;
-
-	/*
-	 * if this is the last block group we have in this space, we can't
-	 * relocate it unless we're able to allocate a new chunk below.
-	 *
-	 * Otherwise, we need to make sure we have room in the space to handle
-	 * all of the extents from this block group.  If we can, we're good
-	 */
-	if ((space_info->total_bytes != block_group->key.offset) &&
-	    (btrfs_space_info_used(space_info, false) + min_free <
-	     space_info->total_bytes)) {
-		spin_unlock(&space_info->lock);
-		goto out;
-	}
-	spin_unlock(&space_info->lock);
-
-	/*
-	 * ok we don't have enough space, but maybe we have free space on our
-	 * devices to allocate new chunks for relocation, so loop through our
-	 * alloc devices and guess if we have enough space.  if this block
-	 * group is going to be restriped, run checks against the target
-	 * profile instead of the current one.
-	 */
-	ret = -1;
-
-	/*
-	 * index:
-	 *      0: raid10
-	 *      1: raid1
-	 *      2: dup
-	 *      3: raid0
-	 *      4: single
-	 */
-	target = get_restripe_target(fs_info, block_group->flags);
-	if (target) {
-		index = btrfs_bg_flags_to_raid_index(extended_to_chunk(target));
-	} else {
-		/*
-		 * this is just a balance, so if we were marked as full
-		 * we know there is no space for a new chunk
-		 */
-		if (full) {
-			if (debug)
-				btrfs_warn(fs_info,
-					   "no space to alloc new chunk for block group %llu",
-					   block_group->key.objectid);
-			goto out;
-		}
-
-		index = btrfs_bg_flags_to_raid_index(block_group->flags);
-	}
-
-	if (index == BTRFS_RAID_RAID10) {
-		dev_min = 4;
-		/* Divide by 2 */
-		min_free >>= 1;
-	} else if (index == BTRFS_RAID_RAID1) {
-		dev_min = 2;
-	} else if (index == BTRFS_RAID_DUP) {
-		/* Multiply by 2 */
-		min_free <<= 1;
-	} else if (index == BTRFS_RAID_RAID0) {
-		dev_min = fs_devices->rw_devices;
-		min_free = div64_u64(min_free, dev_min);
-	}
-
-	mutex_lock(&fs_info->chunk_mutex);
-	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list) {
-		u64 dev_offset;
-
-		/*
-		 * check to make sure we can actually find a chunk with enough
-		 * space to fit our block group in.
-		 */
-		if (device->total_bytes > device->bytes_used + min_free &&
-		    !test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state)) {
-			ret = find_free_dev_extent(device, min_free,
-						   &dev_offset, NULL);
-			if (!ret)
-				dev_nr++;
-
-			if (dev_nr >= dev_min)
-				break;
-
-			ret = -1;
-		}
-	}
-	if (debug && ret == -1)
-		btrfs_warn(fs_info,
-			   "no space to allocate a new chunk for block group %llu",
-			   block_group->key.objectid);
-	mutex_unlock(&fs_info->chunk_mutex);
-out:
-	btrfs_put_block_group(block_group);
-	return ret;
-}
-
 static int find_first_block_group(struct btrfs_fs_info *fs_info,
 				  struct btrfs_path *path,
 				  struct btrfs_key *key)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 41811522c4a3..431cabdcbd33 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3078,10 +3078,6 @@ static int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	 */
 	lockdep_assert_held(&fs_info->delete_unused_bgs_mutex);
 
-	ret = btrfs_can_relocate(fs_info, chunk_offset);
-	if (ret)
-		return -ENOSPC;
-
 	/* step one, relocate all the extents inside this chunk */
 	btrfs_scrub_pause(fs_info);
 	ret = btrfs_relocate_block_group(fs_info, chunk_offset);
-- 
2.22.0

