Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEB9341A69
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Mar 2021 11:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhCSKte (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Mar 2021 06:49:34 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6295 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhCSKtC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Mar 2021 06:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616150941; x=1647686941;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fs+M56z/E0o3BVf2n40mS/yUsNv9C26IEd6XBxvdH4g=;
  b=foMkNlRImzX70Cvaha2W17mZBBo+iCQUPzVs3umxcuBiwKe7LF1Sohhb
   LFSPyb0Q2DjvCCrb0qdMjijvEBVrrQNHdaf2AaO2t5ZM+NnjCnHfNQin0
   3sisDNmfmWmDGfEGns4fajYLvX43Noa4gnU5QRrIJTs5LhJVnFOHnpoi8
   XCIw0Lcjh+Nb1/cx3Ojk4KuPVguRgySJk6oOL47cqUs55bgiLzUI58Fnw
   QAPVP+HCoLcuXzv0/dxpAMenpQ5wZUMmjulzV3zE0Nw5qouUtbX9R7sQI
   F04tU+x9Q9HKOOhN6XXWYLeNbZZfuth2IKWsnbRI1dueLPVZ5L8bL4uy9
   g==;
IronPort-SDR: JcfdYzgfEJoZfSQ7jCCBGQAHNgph84UmEUcc0VRa9jLPUYOX80l3ekumcPm+JNbxkzRthx60mc
 mhQTZBrmMT+746rquwlrgCfh3avE30nLIEPlKPy4DyaIdOCVCQsk/kR1uj4Oa8cjoWNCikATlm
 ctqL0mhOwb141dxK8kz2nLLQNFXV1BGv2Gn0vLecWDEzI7tHOq5vV6bPV9Us0ABHYKty3PRREA
 GRtT2IaCOx6fv+bORiRh4jPIP9pEDvdOnpGv1JruNbC0wjRC1pUYFPBfTZNykjFw0dbX+7NdC7
 y/0=
X-IronPort-AV: E=Sophos;i="5.81,261,1610380800"; 
   d="scan'208";a="167028611"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2021 18:49:01 +0800
IronPort-SDR: sGtCt7bsjF+ICQ2H/nntUxC0REBQ2jGEkp4mJnnrQahyzYKpg1VKxuDPMrxpnoWp7c9qApiPjs
 jf0b3bfz5B3X91y3gn/CfEFeSY3JSZp0j6IPVDPxLgF8baiuH550hTLUCUOcsPNsERoh/2zI0S
 lpHec63Q3kDh92MVuSd0VTnWF7kLYnG4oRttgL7brNRPfuSXorPcbppA57BeVLYh4ln/YrHtt5
 0jTS8hNGKbPwXHjOs5H17GLmnWcCaAhFireESj2+l12hQDHJpWP3beG8NJVt4eneDJp12GyaEd
 yXdPRKu88cdd9g0KmeIP+Wav
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 03:29:35 -0700
IronPort-SDR: adbCLCvVQiNhlL2nqiqFvjef+VTOzEO8JDWrb0uMMeOsJgKRZcHi+nff91hOQunE5M4FJGEhNK
 iMYaIzJBs81uC4QXwqJMdX+U4tg6E5T6MC90THscIw5KXd+yS6M574PbjW+2zYWYPXOBNxNyDq
 Xjp0euJmPz6eH75i/uSUNbtxfLLDUIiJlf7gQWrxNeIXDxPmUbffeyQ08z45lwlkqDk5z+wGyU
 pchtSdpyxfRFzR+G5bBx6rR6BinXlF1e4Q+p4XqMbSP9L+p655WOZXSAmywdV9pWOKVV4N0Qi8
 xbc=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Mar 2021 03:49:01 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 1/2] btrfs: rename delete_unused_bgs_mutex
Date:   Fri, 19 Mar 2021 19:48:51 +0900
Message-Id: <e08335fd919473b3da296514c4148f9fc9461cfc.1616149060.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1616149060.git.johannes.thumshirn@wdc.com>
References: <cover.1616149060.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As a preparation for another user, rename the unused_bgs_mutex into
reclaim_bgs_lock.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c |  6 +++---
 fs/btrfs/ctree.h       |  2 +-
 fs/btrfs/disk-io.c     |  6 +++---
 fs/btrfs/volumes.c     | 46 +++++++++++++++++++++---------------------
 4 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 85077c95b4f7..9ae3ac96a521 100644
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
index f2fd73e58ee6..34ec82d6df3e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -937,7 +937,7 @@ struct btrfs_fs_info {
 	spinlock_t unused_bgs_lock;
 	struct list_head unused_bgs;
 	struct mutex unused_bg_unpin_mutex;
-	struct mutex delete_unused_bgs_mutex;
+	struct mutex reclaim_bgs_lock;
 
 	/* Cached block sizes */
 	u32 nodesize;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 289f1f09481d..f9250f14fc1e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1807,10 +1807,10 @@ static int cleaner_kthread(void *arg)
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
@@ -2793,7 +2793,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	spin_lock_init(&fs_info->treelog_bg_lock);
 	rwlock_init(&fs_info->tree_mod_log_lock);
 	mutex_init(&fs_info->unused_bg_unpin_mutex);
-	mutex_init(&fs_info->delete_unused_bgs_mutex);
+	mutex_init(&fs_info->reclaim_bgs_lock);
 	mutex_init(&fs_info->reloc_mutex);
 	mutex_init(&fs_info->delalloc_root_mutex);
 	mutex_init(&fs_info->zoned_meta_io_lock);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d4ca721c1d91..fb785ff53a27 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3117,7 +3117,7 @@ static int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	 * we release the path used to search the chunk/dev tree and before
 	 * the current task acquires this mutex and calls us.
 	 */
-	lockdep_assert_held(&fs_info->delete_unused_bgs_mutex);
+	lockdep_assert_held(&fs_info->reclaim_bgs_lock);
 
 	/* step one, relocate all the extents inside this chunk */
 	btrfs_scrub_pause(fs_info);
@@ -3172,10 +3172,10 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
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
@@ -3183,7 +3183,7 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 		ret = btrfs_previous_item(chunk_root, path, key.objectid,
 					  key.type);
 		if (ret)
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 		if (ret < 0)
 			goto error;
 		if (ret > 0)
@@ -3204,7 +3204,7 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 			else
 				BUG_ON(ret);
 		}
-		mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+		mutex_unlock(&fs_info->reclaim_bgs_lock);
 
 		if (found_key.offset == 0)
 			break;
@@ -3744,10 +3744,10 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
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
 
@@ -3761,7 +3761,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 		ret = btrfs_previous_item(chunk_root, path, 0,
 					  BTRFS_CHUNK_ITEM_KEY);
 		if (ret) {
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			ret = 0;
 			break;
 		}
@@ -3771,7 +3771,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 		btrfs_item_key_to_cpu(leaf, &found_key, slot);
 
 		if (found_key.objectid != key.objectid) {
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			break;
 		}
 
@@ -3788,12 +3788,12 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 
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
@@ -3818,7 +3818,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 					count_meta < bctl->meta.limit_min)
 				|| ((chunk_type & BTRFS_BLOCK_GROUP_SYSTEM) &&
 					count_sys < bctl->sys.limit_min)) {
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			goto loop;
 		}
 
@@ -3832,7 +3832,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 			ret = btrfs_may_alloc_data_chunk(fs_info,
 							 found_key.offset);
 			if (ret < 0) {
-				mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+				mutex_unlock(&fs_info->reclaim_bgs_lock);
 				goto error;
 			} else if (ret == 1) {
 				chunk_reserved = 1;
@@ -3840,7 +3840,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 		}
 
 		ret = btrfs_relocate_chunk(fs_info, found_key.offset);
-		mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+		mutex_unlock(&fs_info->reclaim_bgs_lock);
 		if (ret == -ENOSPC) {
 			enospc_errors++;
 		} else if (ret == -ETXTBSY) {
@@ -4725,16 +4725,16 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
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
@@ -4747,7 +4747,7 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 		btrfs_item_key_to_cpu(l, &key, path->slots[0]);
 
 		if (key.objectid != device->devid) {
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			btrfs_release_path(path);
 			break;
 		}
@@ -4756,7 +4756,7 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 		length = btrfs_dev_extent_length(l, dev_extent);
 
 		if (key.offset + length <= new_size) {
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			btrfs_release_path(path);
 			break;
 		}
@@ -4772,12 +4772,12 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
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
@@ -8001,7 +8001,7 @@ static int relocating_repair_kthread(void *data)
 		return -EBUSY;
 	}
 
-	mutex_lock(&fs_info->delete_unused_bgs_mutex);
+	mutex_lock(&fs_info->reclaim_bgs_lock);
 
 	/* Ensure block group still exists */
 	cache = btrfs_lookup_block_group(fs_info, target);
@@ -8023,7 +8023,7 @@ static int relocating_repair_kthread(void *data)
 out:
 	if (cache)
 		btrfs_put_block_group(cache);
-	mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+	mutex_unlock(&fs_info->reclaim_bgs_lock);
 	btrfs_exclop_finish(fs_info);
 
 	return ret;
-- 
2.30.0

