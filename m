Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E954365F2D
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Apr 2021 20:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhDTS2H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 14:28:07 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54900 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbhDTS2F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 14:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618943269; x=1650479269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=snkbfLTMmb+J00gCebKmkAXShrSp5+iVqpXVlbanstg=;
  b=UFLqLcDrFABpIdRS00GeUULM6AE+4Rk37FL9FpMdJLXFMV2yg95KFhRh
   q99kuy3uUdidMvP/M5tl5QVZ2gLDA+ija2cCELHABCTDiDq4Nz+KNQQNM
   IkpIZXRjLzPhUbxrVYpcixq2Pr3dJoNrnhlI+vtVLvRfzJzerEuIIwoyj
   IJrjplw+KFtYknfzNOI2Lmfh735azituJiZzUOyCfjOmXa/vFoakn0dqb
   lxbtiqMrzYgs0KSBgQ8TW4E1nP6vNTsju59fEKEzqcXBX9RN5xQvAgbcq
   hjQcoKxxOnpUWOCvMibBWBbg4TDEQ2bopwb5oX9ppTWgkS41Sb8h/7bBC
   Q==;
IronPort-SDR: 8xuKeFJ3dcMYn3i4CjHGwOy0cnZW6ib+Ub8Bi4uUNEvggDRuPKuhkgKeXk2SnTOWpwTO9zO1IF
 X+lqePxVn3lLE7Cz2oQoXuCR3TVQCqiDPOdgMDXjZ2IdAfarL3IuZo5Swk6ZBnYbp1nlOKhda9
 hn67YFQKqH6SwWXZPg/CYWTasd7YELJT8uJyzT0I542I/um79krcHgYUTIyuy6OZ7q8QzWUuNo
 rNSP7UhLwsVXZ90oMkZhZR4B1mWuTVVXehoP1kqhq8+Aj9zC3+RPFaLVSx2HuM1pfG0Gag4Lo3
 odU=
X-IronPort-AV: E=Sophos;i="5.82,237,1613404800"; 
   d="scan'208";a="269507073"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Apr 2021 02:27:48 +0800
IronPort-SDR: kwVqpX+JeLuJKfBcqYuPn8UNvWlJ8/ws4II1wYUYjzXbuxYPWgSmqpM1ZI7DMC8rmnx/7YjHHC
 rFagljTJjdDhJBYllyDlyOWLBH49USjtknb8RRlJQBPyukaSJQcNIt+fre4ZMdAR7sq2HVU+k+
 jaTPDMy049RW9ecVqTEFUsXx23kLFJDTLxvxCEILYdcljXcnGuMjc3W/oIeSqaHOx2QaMtqiO5
 85rvg+7altmig2IKEa4tFEtnxPWek/4BYtsCXJ5rOokel+AHRFfG6Y3Nlb2z5EIsA1ATM4T+WC
 3W/XWVGOH7t/XJFBFumockGr
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 11:08:12 -0700
IronPort-SDR: AlXUiHRbB+hxop6YvVmxIQJksatxsel6mWFbzyC6lrChfXh01pH2Wxh3t+NX7CuHecMcUEGoUq
 mm4XjsJY6zB7+dDaoNdoiDQNA49C7IuLfsQJb+r5YvVYXt/P4e8B2Vquc3l1WItf6+7CZAKkv9
 sMlj6kj+EkWcaBqezf1S0qik8UZnMsZ6f2dO/KTLa5RouzlnKeAA3Ne28ZdeIc0xoUEUi0XfZB
 wLnnuNgDFuXm0+B5+mrlVPH3WTn4h8VMEPXl44L2NFjtk3HEu9pSl3rp4DzDeqUa589uy/f/7v
 lAk=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Apr 2021 11:27:32 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v6 2/3] btrfs: rename delete_unused_bgs_mutex
Date:   Wed, 21 Apr 2021 03:27:24 +0900
Message-Id: <23585e42f33553e9683005328ca326ab8fc2fa3f.1618943115.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1618943115.git.johannes.thumshirn@wdc.com>
References: <cover.1618943115.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As a preparation for another user, rename the unused_bgs_mutex into
reclaim_bgs_lock.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c |  6 +++---
 fs/btrfs/ctree.h       |  3 ++-
 fs/btrfs/disk-io.c     |  6 +++---
 fs/btrfs/volumes.c     | 46 +++++++++++++++++++++---------------------
 4 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 293f3169be80..bbb5a6e170c7 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1289,7 +1289,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 	 * Long running balances can keep us blocked here for eternity, so
 	 * simply skip deletion if we're unable to get the mutex.
 	 */
-	if (!mutex_trylock(&fs_info->delete_unused_bgs_mutex))
+	if (!mutex_trylock(&fs_info->reclaim_bgs_lock))
 		return;
 
 	spin_lock(&fs_info->unused_bgs_lock);
@@ -1462,12 +1462,12 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		spin_lock(&fs_info->unused_bgs_lock);
 	}
 	spin_unlock(&fs_info->unused_bgs_lock);
-	mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+	mutex_unlock(&fs_info->reclaim_bgs_lock);
 	return;
 
 flip_async:
 	btrfs_end_transaction(trans);
-	mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+	mutex_unlock(&fs_info->reclaim_bgs_lock);
 	btrfs_put_block_group(block_group);
 	btrfs_discard_punt_unused_bgs_list(fs_info);
 }
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2c858d5349c8..68ee130b5a2a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -957,7 +957,8 @@ struct btrfs_fs_info {
 	spinlock_t unused_bgs_lock;
 	struct list_head unused_bgs;
 	struct mutex unused_bg_unpin_mutex;
-	struct mutex delete_unused_bgs_mutex;
+	/* protects about to be deleted block groups */
+	struct mutex reclaim_bgs_lock;
 
 	/* Cached block sizes */
 	u32 nodesize;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0a1182694f48..e52b89ad0a61 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1890,10 +1890,10 @@ static int cleaner_kthread(void *arg)
 		btrfs_run_defrag_inodes(fs_info);
 
 		/*
-		 * Acquires fs_info->delete_unused_bgs_mutex to avoid racing
+		 * Acquires fs_info->reclaim_bgs_lock to avoid racing
 		 * with relocation (btrfs_relocate_chunk) and relocation
 		 * acquires fs_info->cleaner_mutex (btrfs_relocate_block_group)
-		 * after acquiring fs_info->delete_unused_bgs_mutex. So we
+		 * after acquiring fs_info->reclaim_bgs_lock. So we
 		 * can't hold, nor need to, fs_info->cleaner_mutex when deleting
 		 * unused block groups.
 		 */
@@ -2876,7 +2876,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	spin_lock_init(&fs_info->treelog_bg_lock);
 	rwlock_init(&fs_info->tree_mod_log_lock);
 	mutex_init(&fs_info->unused_bg_unpin_mutex);
-	mutex_init(&fs_info->delete_unused_bgs_mutex);
+	mutex_init(&fs_info->reclaim_bgs_lock);
 	mutex_init(&fs_info->reloc_mutex);
 	mutex_init(&fs_info->delalloc_root_mutex);
 	mutex_init(&fs_info->zoned_meta_io_lock);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 124c17ec53e9..c6568f61b2b0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3118,7 +3118,7 @@ static int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	 * we release the path used to search the chunk/dev tree and before
 	 * the current task acquires this mutex and calls us.
 	 */
-	lockdep_assert_held(&fs_info->delete_unused_bgs_mutex);
+	lockdep_assert_held(&fs_info->reclaim_bgs_lock);
 
 	/* step one, relocate all the extents inside this chunk */
 	btrfs_scrub_pause(fs_info);
@@ -3187,10 +3187,10 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 	key.type = BTRFS_CHUNK_ITEM_KEY;
 
 	while (1) {
-		mutex_lock(&fs_info->delete_unused_bgs_mutex);
+		mutex_lock(&fs_info->reclaim_bgs_lock);
 		ret = btrfs_search_slot(NULL, chunk_root, &key, path, 0, 0);
 		if (ret < 0) {
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			goto error;
 		}
 		BUG_ON(ret == 0); /* Corruption */
@@ -3198,7 +3198,7 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 		ret = btrfs_previous_item(chunk_root, path, key.objectid,
 					  key.type);
 		if (ret)
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 		if (ret < 0)
 			goto error;
 		if (ret > 0)
@@ -3219,7 +3219,7 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 			else
 				BUG_ON(ret);
 		}
-		mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+		mutex_unlock(&fs_info->reclaim_bgs_lock);
 
 		if (found_key.offset == 0)
 			break;
@@ -3759,10 +3759,10 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 			goto error;
 		}
 
-		mutex_lock(&fs_info->delete_unused_bgs_mutex);
+		mutex_lock(&fs_info->reclaim_bgs_lock);
 		ret = btrfs_search_slot(NULL, chunk_root, &key, path, 0, 0);
 		if (ret < 0) {
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			goto error;
 		}
 
@@ -3776,7 +3776,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 		ret = btrfs_previous_item(chunk_root, path, 0,
 					  BTRFS_CHUNK_ITEM_KEY);
 		if (ret) {
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			ret = 0;
 			break;
 		}
@@ -3786,7 +3786,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 		btrfs_item_key_to_cpu(leaf, &found_key, slot);
 
 		if (found_key.objectid != key.objectid) {
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			break;
 		}
 
@@ -3803,12 +3803,12 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 
 		btrfs_release_path(path);
 		if (!ret) {
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			goto loop;
 		}
 
 		if (counting) {
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			spin_lock(&fs_info->balance_lock);
 			bctl->stat.expected++;
 			spin_unlock(&fs_info->balance_lock);
@@ -3833,7 +3833,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 					count_meta < bctl->meta.limit_min)
 				|| ((chunk_type & BTRFS_BLOCK_GROUP_SYSTEM) &&
 					count_sys < bctl->sys.limit_min)) {
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			goto loop;
 		}
 
@@ -3847,7 +3847,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 			ret = btrfs_may_alloc_data_chunk(fs_info,
 							 found_key.offset);
 			if (ret < 0) {
-				mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+				mutex_unlock(&fs_info->reclaim_bgs_lock);
 				goto error;
 			} else if (ret == 1) {
 				chunk_reserved = 1;
@@ -3855,7 +3855,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 		}
 
 		ret = btrfs_relocate_chunk(fs_info, found_key.offset);
-		mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+		mutex_unlock(&fs_info->reclaim_bgs_lock);
 		if (ret == -ENOSPC) {
 			enospc_errors++;
 		} else if (ret == -ETXTBSY) {
@@ -4740,16 +4740,16 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 	key.type = BTRFS_DEV_EXTENT_KEY;
 
 	do {
-		mutex_lock(&fs_info->delete_unused_bgs_mutex);
+		mutex_lock(&fs_info->reclaim_bgs_lock);
 		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 		if (ret < 0) {
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			goto done;
 		}
 
 		ret = btrfs_previous_item(root, path, 0, key.type);
 		if (ret) {
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			if (ret < 0)
 				goto done;
 			ret = 0;
@@ -4762,7 +4762,7 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 		btrfs_item_key_to_cpu(l, &key, path->slots[0]);
 
 		if (key.objectid != device->devid) {
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			btrfs_release_path(path);
 			break;
 		}
@@ -4771,7 +4771,7 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 		length = btrfs_dev_extent_length(l, dev_extent);
 
 		if (key.offset + length <= new_size) {
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			btrfs_release_path(path);
 			break;
 		}
@@ -4787,12 +4787,12 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 		 */
 		ret = btrfs_may_alloc_data_chunk(fs_info, chunk_offset);
 		if (ret < 0) {
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			goto done;
 		}
 
 		ret = btrfs_relocate_chunk(fs_info, chunk_offset);
-		mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+		mutex_unlock(&fs_info->reclaim_bgs_lock);
 		if (ret == -ENOSPC) {
 			failed++;
 		} else if (ret) {
@@ -8018,7 +8018,7 @@ static int relocating_repair_kthread(void *data)
 		return -EBUSY;
 	}
 
-	mutex_lock(&fs_info->delete_unused_bgs_mutex);
+	mutex_lock(&fs_info->reclaim_bgs_lock);
 
 	/* Ensure block group still exists */
 	cache = btrfs_lookup_block_group(fs_info, target);
@@ -8040,7 +8040,7 @@ static int relocating_repair_kthread(void *data)
 out:
 	if (cache)
 		btrfs_put_block_group(cache);
-	mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+	mutex_unlock(&fs_info->reclaim_bgs_lock);
 	btrfs_exclop_finish(fs_info);
 
 	return ret;
-- 
2.30.0

