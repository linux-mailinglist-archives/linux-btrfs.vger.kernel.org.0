Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C13846C8E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2019 07:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfGRFtG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jul 2019 01:49:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:42682 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725959AbfGRFtF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jul 2019 01:49:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C66C2AD05
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2019 05:49:02 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: Remove the duplicated and sometimes too cautious btrfs_can_relocate()
Date:   Thu, 18 Jul 2019 13:48:57 +0800
Message-Id: <20190718054857.8970-1-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
The following script can easily cause unexpected ENOSPC:
  umount $dev &> /dev/null
  umount $mnt &> /dev/null

  mkfs.btrfs -b 1G -m single -d single $dev -f > /dev/null

  mount $dev $mnt -o enospc_debug

  for i in $(seq -w 0 511); do
  	xfs_io -f -c "pwrite 0 1m" $mnt/inline_$i > /dev/null
  done
  sync

  btrfs balance start --full $mnt || return 1
  sync

  # This will report -ENOSPC
  btrfs balance start --full $mnt || return 1
  umount $mnt

Also, btrfs/156 can also fail due to ENOSPC.

[CAUSE]
The ENOSPC is reported by btrfs_can_relocate().

In btrfs_can_relocate(), it does the following check:
- If the block group is empty
  If empty, definitely we can relocate this block group.
- If we are not the only block group and we have enough space
  Then we can relocate this block group.

Above two checks are completely OK, although I could argue they doesn't
make much sense, but the following check is vague and even sometimes
too cautious to cause ENOSPC:
- If we can allocate a new block group as large as current one.
  If we failed previous two checks, we must pass this to relocate this
  block group.

There are several problems here:
1. We don't need to allocate as large as the source block group.
   E.g. source block group is 1G sized, but only 1M used. We only need
   to allocated a data chunk larger than 1M to continue relocation.

2. The check in btrfs_can_relocate() is vague and impossible to be as
   accurate as __btrfs_alloc_chunk()
   How could this less than 200 lines code do the same work as
   __btrfs_alloc_chunk()? And it's hard to maintain two different
   functions to do similar work.

3. We have more accurate check in btrfs_inc_block_group_ro().
   Btrfs_inc_block_group_ro() is doing similar check but much better.
   In btrfs_inc_block_group_ro() we do:
   * Forced chunk allocation if we're converting

   * Try to mark block group ro first
     in inc_btrfs_block_group_ro(), we will do comprehensive space
     check to ensure we have enough free space for the used and reserved
     space of the block group.
     If succeeded, we're done.

   * Force chunk allocation for more space
     If we failed here, we indeed hits ENOSPC.

   * Try to mark block group ro again
     As we have extra space, we can try again.
     This is the last chance, either we have enough space now and
     success, or the newly allocated space is not large enough, ENOSPC
     is returned.

   Such try-allocate-try behavior is way more accurate in every way
   compared to btrfs_can_relocate(), we can rely on
   btrfs_inc_block_group_ro() to replace btrfs_can_relocate()
   completely.

[FIX]
Since regular balance routine already has a better ENOSPC detector,
there is no need to keep the false-alert-prone btrfs_can_relocate().

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
index 5faf057f6f37..822a4102980d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -9774,147 +9774,6 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache)
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
index 1c2a6e4b39da..f209127a8bc6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3071,10 +3071,6 @@ static int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
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

