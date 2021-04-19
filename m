Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01086363CDE
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 09:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237955AbhDSHmK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 03:42:10 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:21561 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237918AbhDSHmC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 03:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618818094; x=1650354094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=snkbfLTMmb+J00gCebKmkAXShrSp5+iVqpXVlbanstg=;
  b=iLdIudM4N1/4DFVatSeiLKLvi/lJiqs8tPJm1AkwNBT/VrOVTged3mM8
   KtB7wtumNDTU4BSqFO5zI2hwgF9JBknzcrfI0vUjUF2XKvS/wdeYJncV4
   s3/04HbADqQEKJdVxuJ76jsbwNjcx8i8fvH0InOAFnccxDLBi1oHQe9H9
   8Xi+FFxiVraVI8q73QXS14mDu29LSm1SdLDHRbQj/UJKSQWnL43558xCW
   h6bsYQq8y06zK/AQ4tWIHEHgxNpTnfcMZW4u7uVNFZqENFNGc6rKJtouM
   GK5Ycv7bG1DuNTc0dX6L+VrDBsIgee6b01DSvpp8BcDOhHUj8rEyzpe9V
   A==;
IronPort-SDR: AjTrksLpfb0lZuFyKw95dNIu8dp9umfeW4noUXnbVLyEMwvirZgn8jnmlc6oxdn4FdqBpzmZwI
 DP8BwzVrjbjWjq27O/wvefPbeZbdt+HDefVE0RJNyjvxklQHsjYBnNfmviyHphFA+YyeQ+KOsr
 V1oN0TNCxERXjNrINRjc2xeWCs1CZmpm2AdhyC+v8zlGKkatjAkrSvd/suavzE9puu4O6iVMjq
 p9lRTgpFpsz73qpemhcB63ss7DFRchE3Pdr85uDDqL0YJOrcgjDfQr1bii0zkKJyVJonzz34br
 YTc=
X-IronPort-AV: E=Sophos;i="5.82,233,1613404800"; 
   d="scan'208";a="165966780"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2021 15:41:15 +0800
IronPort-SDR: +o3zo3VxF4TjxDAgV/nW3Qk/+Oq9z/9NwMIckQarwb/hTsxCaaYreU9BwHMRT8IDF9SFUWtzVO
 8TcamRUOSTYMw/HVZe1Owy2XQkiMoVs/PSLCLaic4E0k4Foc/yNyqGDzdhG/Fe5OLOglfmuTC9
 HiFTd9p7K9lUJDsr+HeFPikhD3ESQ5XoJ4jy8z92+iAw5B93iqqYCMooeKtUrEKY4zkY/Uv7BO
 jHnx7+Q7UnIYm3VNh+wRQTTfBz5+4e+dLnYoLvIWIUMQlGxXJcA/AKEAOqfuAcVH5qpbxkb8h3
 a/fpBoqCK5Mm7fHdUmi9bsRF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 00:21:55 -0700
IronPort-SDR: xQZvFEOyTXAYZrX5KyL9w4RGl66iQNX5y0dCz+pQCMyk1eTo1mbGBzDNu9JkmJRxHG4cC0r16j
 VtxhHdWiI+nJqfZlxMIMJWuOyEb+/GD3RzZ1n3BfFRWB3DHPP1rsShn/nfsIHvMsFtiUDQZuYa
 gWKwboK4BANiuTWdcZ8VrKuVHQEV12dcVsE3X+I366s/zfPIG8GGgsIfXgJpWju9hNQAfXda9a
 u/Jw5MGsihKnmeJKMylPF3DTvDUeTUPNopf6MRjLJNyfKJ2m8zImXKeXhi6cDQ+idZ3pHgx9Kk
 Hcg=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Apr 2021 00:41:13 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v5 2/3] btrfs: rename delete_unused_bgs_mutex
Date:   Mon, 19 Apr 2021 16:41:01 +0900
Message-Id: <23585e42f33553e9683005328ca326ab8fc2fa3f.1618817864.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1618817864.git.johannes.thumshirn@wdc.com>
References: <cover.1618817864.git.johannes.thumshirn@wdc.com>
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

