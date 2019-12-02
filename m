Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD09C10E63E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 08:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfLBHCo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 02:02:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:60446 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbfLBHCo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Dec 2019 02:02:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 37301B2DD
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Dec 2019 07:02:40 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: relocation: Allow 'btrfs balance cancel' to return quicker
Date:   Mon,  2 Dec 2019 15:02:35 +0800
Message-Id: <20191202070235.33099-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]
There are quite some users reporting that 'btrfs balance cancel' slow to
cancel current running balance, or even doesn't work for certain dead
balance loop.

With the following script showing how long it takes to fully stop a
balance:
  #!/bin/bash
  dev=/dev/test/test
  mnt=/mnt/btrfs

  umount $mnt &> /dev/null
  umount $dev &> /dev/null

  mkfs.btrfs -f $dev
  mount $dev -o nospace_cache $mnt

  dd if=/dev/zero bs=1M of=$mnt/large &
  dd_pid=$!

  sleep 3
  kill -KILL $dd_pid
  sync

  btrfs balance start --bg --full $mnt &
  sleep 1

  echo "cancel request" >> /dev/kmsg
  time btrfs balance cancel $mnt
  umount $mnt

It takes around 7~10s to cancel the running balance in my test
environment.

[CAUSE]
Btrfs uses btrfs_fs_info::balance_cancel_req to record how many cancel
request are queued.

And btrfs checks this value only in the following call sites:
btrfs_balance()
|- atomic_read(&fs_info->balance_cancel_req); <<< 1
|- __btrfs_balance()
   |- while (1) {
   |  /* Per chunk iteration */
   |-    atomic_read(&fs_info->balance_cancel_req); <<< 2

The first check is near useless, as it happens at the very beginning of
balance, thus it's too rare to hit.

The sencond check is the most common hit, but it's too slow, only hit
after each chunk get relocated.

For certain bug reports, like "Found 1 extents" loop where we are
dead-looping inside btrfs_relocate_block_group(), it's useless.

[FIX]
This patch will introduce more cancel check at the following call sites:
btrfs_balance()
|- __btrfs_balance()
   |- btrfs_relocate_block_group()
      |- while (1) { /* Per relocation-stage loop, 2~3 runs */
      |-    should_cancel_balance()	<<< 1
      |-    balance_block_group()
      |- }

/* Call site 1 workaround dead balance loop */
Call site 1 will allow user to workaround the mentioned dead balance
loop by properly canceling it.

balance_block_group()
|- while (1) { /* Per-extent iteration */
|-    relocate_data_extent()
|     |- relocate_file_extent_cluster()
|        |- should_cancel_balance()	<<< 2
|-    should_cancel_balance()		<<< 3
|- }
|- relocate_file_extent_cluster()

/* Call site 2 for data heavy relocation */
As we spend a lot of time doing page reading for data relocation, such
check can make exit much quicker for data relocation.
This check has a bytes based filter (every 32M) to prevent wasting too
much CPU time checking it.

/* Call site 3 for meta heavy relocation */
The check has a nr_extent based filter (every 256 extents) to prevent
wasting too much CPU time.

/* Error injection to do full coverage test */
This patch packs the regular atomic_read() into a separate function,
should_cancel_balance() to allow error injection.
So we can do a full coverage test.

With this patch, the response time has reduced from 7~10s to 0.5~1.5s for
data relocation.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h      |  1 +
 fs/btrfs/relocation.c | 41 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c    |  6 +++---
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b2e8fd8a8e59..a712c18d2da2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3352,6 +3352,7 @@ void btrfs_reloc_pre_snapshot(struct btrfs_pending_snapshot *pending,
 			      u64 *bytes_to_reserve);
 int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 			      struct btrfs_pending_snapshot *pending);
+int should_cancel_balance(struct btrfs_fs_info *fs_info);
 
 /* scrub.c */
 int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d897a8e5e430..c42616750e4b 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -9,6 +9,7 @@
 #include <linux/blkdev.h>
 #include <linux/rbtree.h>
 #include <linux/slab.h>
+#include <linux/error-injection.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
@@ -3223,6 +3224,16 @@ int setup_extent_mapping(struct inode *inode, u64 start, u64 end,
 	return ret;
 }
 
+int should_cancel_balance(struct btrfs_fs_info *fs_info)
+{
+	return atomic_read(&fs_info->balance_cancel_req);
+}
+/* Allow us to do error injection test to cover all cancel exit branches */
+ALLOW_ERROR_INJECTION(should_cancel_balance, TRUE);
+
+/* Thresholds of when to check if the balance is canceled */
+#define RELOC_CHECK_INTERVAL_NR_EXTENTS		(256)
+#define RELOC_CHECK_INTERVAL_BYTES		(SZ_32M)
 static int relocate_file_extent_cluster(struct inode *inode,
 					struct file_extent_cluster *cluster)
 {
@@ -3230,6 +3241,7 @@ static int relocate_file_extent_cluster(struct inode *inode,
 	u64 page_start;
 	u64 page_end;
 	u64 offset = BTRFS_I(inode)->index_cnt;
+	u64 checked_bytes = 0;
 	unsigned long index;
 	unsigned long last_index;
 	struct page *page;
@@ -3344,6 +3356,14 @@ static int relocate_file_extent_cluster(struct inode *inode,
 		btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
 		balance_dirty_pages_ratelimited(inode->i_mapping);
 		btrfs_throttle(fs_info);
+
+		checked_bytes += PAGE_SIZE;
+		if (checked_bytes >= RELOC_CHECK_INTERVAL_BYTES &&
+		    should_cancel_balance(fs_info)) {
+			ret = -ECANCELED;
+			goto out;
+		}
+		checked_bytes %= RELOC_CHECK_INTERVAL_BYTES;
 	}
 	WARN_ON(nr != cluster->nr);
 out:
@@ -4016,7 +4036,10 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	struct btrfs_path *path;
 	struct btrfs_extent_item *ei;
 	u64 flags;
+	u64 checked_bytes = 0;
+	u64 checked_nr_extents = 0;
 	u32 item_size;
+	u32 extent_size;
 	int ret;
 	int err = 0;
 	int progress = 0;
@@ -4080,11 +4103,14 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		}
 
 		if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
+			extent_size = fs_info->nodesize;
 			ret = add_tree_block(rc, &key, path, &blocks);
 		} else if (rc->stage == UPDATE_DATA_PTRS &&
 			   (flags & BTRFS_EXTENT_FLAG_DATA)) {
+			extent_size = key.offset;
 			ret = add_data_references(rc, &key, path, &blocks);
 		} else {
+			extent_size = key.offset;
 			btrfs_release_path(path);
 			ret = 0;
 		}
@@ -4125,6 +4151,17 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 				break;
 			}
 		}
+		checked_bytes += extent_size;
+		checked_nr_extents++;
+
+		if ((checked_bytes >= RELOC_CHECK_INTERVAL_BYTES ||
+		     checked_nr_extents >= RELOC_CHECK_INTERVAL_NR_EXTENTS) &&
+		    should_cancel_balance(fs_info)) {
+			err = -ECANCELED;
+			break;
+		}
+		checked_bytes %= RELOC_CHECK_INTERVAL_BYTES;
+		checked_nr_extents %= RELOC_CHECK_INTERVAL_NR_EXTENTS;
 	}
 	if (trans && progress && err == -ENOSPC) {
 		ret = btrfs_force_chunk_alloc(trans, rc->block_group->flags);
@@ -4365,6 +4402,10 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 				 rc->block_group->length);
 
 	while (1) {
+		if (should_cancel_balance(fs_info)) {
+			err= -ECANCELED;
+			goto out;
+		}
 		mutex_lock(&fs_info->cleaner_mutex);
 		ret = relocate_block_group(rc);
 		mutex_unlock(&fs_info->cleaner_mutex);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d8e5560db285..afa3ed1b066d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3505,7 +3505,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 
 	while (1) {
 		if ((!counting && atomic_read(&fs_info->balance_pause_req)) ||
-		    atomic_read(&fs_info->balance_cancel_req)) {
+		    should_cancel_balance(fs_info)) {
 			ret = -ECANCELED;
 			goto error;
 		}
@@ -3670,7 +3670,7 @@ static int alloc_profile_is_valid(u64 flags, int extended)
 static inline int balance_need_close(struct btrfs_fs_info *fs_info)
 {
 	/* cancel requested || normal exit path */
-	return atomic_read(&fs_info->balance_cancel_req) ||
+	return should_cancel_balance(fs_info) ||
 		(atomic_read(&fs_info->balance_pause_req) == 0 &&
 		 atomic_read(&fs_info->balance_cancel_req) == 0);
 }
@@ -3856,7 +3856,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 
 	if (btrfs_fs_closing(fs_info) ||
 	    atomic_read(&fs_info->balance_pause_req) ||
-	    atomic_read(&fs_info->balance_cancel_req)) {
+	    should_cancel_balance(fs_info)) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.24.0

