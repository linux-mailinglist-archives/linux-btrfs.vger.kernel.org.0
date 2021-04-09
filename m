Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D518E359C5C
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Apr 2021 12:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhDIKxc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Apr 2021 06:53:32 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19455 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDIKxb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Apr 2021 06:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617965599; x=1649501599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xV+/ERWOBglYbzjhxQTtTN4LBc35hpSx6quR2fCQzYs=;
  b=NGEk8Y2Vmlo7/7eHxSW9yYcmBUK5nQkzHD+arTQlCSMlNxnAlQqaGjqE
   va4ZTd9eZpvCsdbXJhzO06W5OF32784U7tdZymj2FR9TCiJM+fI8sjCVg
   WEZI1wsRd40fNiJ0G4yCdGHJz92PZ9IwtMagdkYixT3j2Lwoq5TJ16Y6k
   WkhLZCGwFvdyD458Ama4QOEWMI5aedCA6ARlfKByCV/LpZ0lky/8Lef55
   PI5/zo0XxiOr0Wmu8DL4tRBSULIFwPLUv5cfnuWkYq3WHOztDZmkiKwC9
   dElGAXyftj6dPRVWGgx0SG8ir7yx5xaX+XmnK7yMvW5E33pefQEzc3tWg
   w==;
IronPort-SDR: L++fxkyWBQlVg4RP45mUmHqHbWg1LxEyyKbMbp+MOFjRLfUe9Lwv4dwNz1dkQVaYZV0QPyqFPn
 wloUl+Cx9LW4o7x/QJslIO1Rze5DpMTPIXgVg+xwybd0m5Os7NPONmt00/R5Pwzur1eVYcfSqI
 wgakn/jA1wNBYx3gRlMPTq3bBJUp0hPWBeN8FZkP5AdxImTo0t42SrsHIKEO3ntnw6BkDAONq5
 3ZFM/AtYb4Tm1Mg+GFbze1zPYQxBAFainmxJeooHjx0HCcIoo21bPyqm41TJ1UTz4BpyLSv/7x
 seA=
X-IronPort-AV: E=Sophos;i="5.82,209,1613404800"; 
   d="scan'208";a="168797960"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2021 18:53:18 +0800
IronPort-SDR: 5rQ5l9JAy0CLH8cBk43Kqe9wUJeI2aY8Y7vza5Qgojp9462D9uRNwhqWvzzodHw+yXuKMBFajM
 JQONucbBrFfj5s2fg2f+W02v+kogQ6FzFCym6mWnL4fxUi7CanDzqQo+qHnTiBsYk5p9I0wQeF
 x617E7WGp+Uu0XA3IO5bDaum/x6mVV/JRobDwh273rQurkVaII0JqnoSwfTzo9aly+NgtJI664
 3zLDxffyZPvDosK5v8t75gc8iBfLGu2NfgJSaDgG2dfikY/+B2ZfgtvqjNLJIS+n+kVc4oFqSD
 w04r4WR+uZktbzW058+FG8qd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 03:32:54 -0700
IronPort-SDR: EJTNyrNTqbuTeaOiVXhh83p+5TFvvvx/y7iZPCfwmvHdeObaGFw6IQ5k8x0qa8SNOcacP3hhAH
 u7I5WYmjiVW6HhfNK0QNq5cvHse0OKySfQLyrlHcZSaxOFHUt7NO4pR3DFXGsmKeTJvh9uHEs9
 dApkrZZPK6CqCNyKQdFQQ7coaB52nb6iS6iWUfP22RY/sfht4bQDD7fl+cbqJX5KDG/WP3Q0rV
 puE31bntaBqx7/EL2oEQlbzvZQTKxXGRDdxu/miF6yT+GVMPxpwg6d2pyJ8lLxoO9KPl9hS72t
 i/Q=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Apr 2021 03:53:18 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 2/3] btrfs: rename delete_unused_bgs_mutex
Date:   Fri,  9 Apr 2021 19:53:08 +0900
Message-Id: <dabb569189159f694c4ee6befeea59458eb1e24b.1617962110.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1617962110.git.johannes.thumshirn@wdc.com>
References: <cover.1617962110.git.johannes.thumshirn@wdc.com>
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
index 2c858d5349c8..c80302564e6b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -957,7 +957,7 @@ struct btrfs_fs_info {
 	spinlock_t unused_bgs_lock;
 	struct list_head unused_bgs;
 	struct mutex unused_bg_unpin_mutex;
-	struct mutex delete_unused_bgs_mutex;
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
index d9ef8bce0cde..f69c1cec5ef7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3121,7 +3121,7 @@ static int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	 * we release the path used to search the chunk/dev tree and before
 	 * the current task acquires this mutex and calls us.
 	 */
-	lockdep_assert_held(&fs_info->delete_unused_bgs_mutex);
+	lockdep_assert_held(&fs_info->reclaim_bgs_lock);
 
 	/* step one, relocate all the extents inside this chunk */
 	btrfs_scrub_pause(fs_info);
@@ -3185,10 +3185,10 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
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
@@ -3196,7 +3196,7 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 		ret = btrfs_previous_item(chunk_root, path, key.objectid,
 					  key.type);
 		if (ret)
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 		if (ret < 0)
 			goto error;
 		if (ret > 0)
@@ -3217,7 +3217,7 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 			else
 				BUG_ON(ret);
 		}
-		mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+		mutex_unlock(&fs_info->reclaim_bgs_lock);
 
 		if (found_key.offset == 0)
 			break;
@@ -3757,10 +3757,10 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
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
 
@@ -3774,7 +3774,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 		ret = btrfs_previous_item(chunk_root, path, 0,
 					  BTRFS_CHUNK_ITEM_KEY);
 		if (ret) {
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			ret = 0;
 			break;
 		}
@@ -3784,7 +3784,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 		btrfs_item_key_to_cpu(leaf, &found_key, slot);
 
 		if (found_key.objectid != key.objectid) {
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			break;
 		}
 
@@ -3801,12 +3801,12 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 
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
@@ -3831,7 +3831,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 					count_meta < bctl->meta.limit_min)
 				|| ((chunk_type & BTRFS_BLOCK_GROUP_SYSTEM) &&
 					count_sys < bctl->sys.limit_min)) {
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			goto loop;
 		}
 
@@ -3845,7 +3845,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 			ret = btrfs_may_alloc_data_chunk(fs_info,
 							 found_key.offset);
 			if (ret < 0) {
-				mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+				mutex_unlock(&fs_info->reclaim_bgs_lock);
 				goto error;
 			} else if (ret == 1) {
 				chunk_reserved = 1;
@@ -3853,7 +3853,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 		}
 
 		ret = btrfs_relocate_chunk(fs_info, found_key.offset);
-		mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+		mutex_unlock(&fs_info->reclaim_bgs_lock);
 		if (ret == -ENOSPC) {
 			enospc_errors++;
 		} else if (ret == -ETXTBSY) {
@@ -4738,16 +4738,16 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
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
@@ -4760,7 +4760,7 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 		btrfs_item_key_to_cpu(l, &key, path->slots[0]);
 
 		if (key.objectid != device->devid) {
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			btrfs_release_path(path);
 			break;
 		}
@@ -4769,7 +4769,7 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 		length = btrfs_dev_extent_length(l, dev_extent);
 
 		if (key.offset + length <= new_size) {
-			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			btrfs_release_path(path);
 			break;
 		}
@@ -4785,12 +4785,12 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
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
@@ -8016,7 +8016,7 @@ static int relocating_repair_kthread(void *data)
 		return -EBUSY;
 	}
 
-	mutex_lock(&fs_info->delete_unused_bgs_mutex);
+	mutex_lock(&fs_info->reclaim_bgs_lock);
 
 	/* Ensure block group still exists */
 	cache = btrfs_lookup_block_group(fs_info, target);
@@ -8038,7 +8038,7 @@ static int relocating_repair_kthread(void *data)
 out:
 	if (cache)
 		btrfs_put_block_group(cache);
-	mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+	mutex_unlock(&fs_info->reclaim_bgs_lock);
 	btrfs_exclop_finish(fs_info);
 
 	return ret;
-- 
2.30.0

