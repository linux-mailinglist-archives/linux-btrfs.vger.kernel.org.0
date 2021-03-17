Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D126F33EE68
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 11:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhCQKif (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 06:38:35 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6831 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhCQKiS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 06:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615977500; x=1647513500;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FauGPrU2GZA5RVrK8xlj1dq6RoMiUgfc9SeumuQ3gOI=;
  b=Q1eoAmA/x9lh6U9iU3eeyXMGLDGaTtkL8M/u8n9lsYmRtwfbdPRl5/5N
   CRn4l3XtpougUyiDBplZQMHCT9zGYUXRVhvLqz2J18tvrIWuKAQ7LHnRc
   FiGnEuYapADIitnIt1W1QuBB538WM9sagD4e9ZsljFoUnn3smeGUZA6dn
   bw3Ii6XJS5WHkQNnHiJ0Th2ibgg06Arp8LhU/iCQdmZCWL7bTNsHzvm/t
   jV7sgpSVoRjNblgbEIX69L9E7L74loObel4Koef5E/QDvcP+LNeyzpUZN
   JKcIK5EadUk5NXTqVcrROHSzYMyL6ntb4AbVdQt5QP+wRfmTgeFxgCqfb
   w==;
IronPort-SDR: 9H8s0BuQYRjRKeZOtZXJA5OrTyujdrcWSAl9VTNaAo7K29AV6FcqbhPYtfYosLr7o81nURMtDb
 KqTjCN9Ws7mT9IJdU7+8EQzPbW5cJlJ6hs3s8ywHB9EeZoZd6yk2lb/shYp9VCpKLO0mwEKV8t
 j5AucKEZoh+xwyxKwVIwX6CSdVHNOHUkakpCq58I0T1L3CPwulGnMoIRJ+dagzbhUFs/rXz+o2
 PWQ0JeYTvmeUUV8iqgD2FUxl+FiK32Zbw9NU8xDFajR11vYlMujb5fmES2pDceuvzxUzDlF3+m
 pqo=
X-IronPort-AV: E=Sophos;i="5.81,256,1610380800"; 
   d="scan'208";a="163496577"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2021 18:38:19 +0800
IronPort-SDR: nhFWLC7ds0OgVayIm7pFJfAzcjhPBvfCLJkbl+eEKowxywMBMtq0AUcUQvIAyDo+8365Mxip/+
 dVnylNiU+MjS8kKS+xFtC/hNvxmlfa4lOopxBx70QIUH6HfmDFauFCXiitOlBGR6+W5tDU0lPy
 Z1zYWvt4A/x0vdVEBZIOpRdgXQlvh+msxIjqASivVBknkhk8JSAODbURw0YmlwG/s+HxexDWHm
 GRe9EY98ip7JvTFX8CYXE4DUp8AwEl2km2CSbFXT38cGotL3+kwkUUG2J6SbzyAGqOchXalqR5
 AHHY6xXAvPO2jlOjAgB5Vw95
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 03:18:54 -0700
IronPort-SDR: fX8bDqCZswtNPq4hV6Cs1STPb3H6/if+0HFP0Ig3xtd4M2pITQvQAol0W3KtVF1AJSCEYWNOwe
 cnG4GSjwr+HtexwqBy+lPILsc5A6etIRWVLoEwm1xd0I/s6QR2li0nrukgUz+K5Pa/oPrkijlF
 IKMMJ2YpLa4n+JXahJV4SLrGK/kPp80DT3z4h3DfQD3L0QB9Stj/Aa8GHAYK22udstLHnh61uw
 7dmU7E3TZYMP44m4849LkgBmC13fnfBFyyNBjDQ4975xA2grxFivZMz7jUgLld53NEuX1x8Z6X
 5m0=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Mar 2021 03:38:17 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH] btrfs: zoned: automatically reclaim zones
Date:   Wed, 17 Mar 2021 19:38:11 +0900
Message-Id: <321e2ff322469047563dfce030814d58a8632a60.1615977471.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When a file gets deleted on a zoned file system, the space freed is no
returned back into the block group's free space, but is migrated to
zone_unusable.

As this zone_unusable space is behind the current write pointer it is not
possible to use it for new allocations. In the current implementation a
zone is reset once all of the block group's space is accounted as zone
unusable.

This behaviour can lead to premature ENOSPC errors on a busy file system.

Instead of only reclaiming the zone once it is completely unusable,
kick off a reclaim job once the amount of unusable bytes exceeds a user
configurable threshold between 51% and 100%.

Similar to reclaiming unused block groups, these dirty block groups are
added to a to_reclaim list and then on a transaction commit, the reclaim
process is triggered but after we deleted unused block groups, which will
free space for the relocation process.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c       | 85 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/block-group.h       |  2 +
 fs/btrfs/ctree.h             |  5 +++
 fs/btrfs/disk-io.c           | 11 +++++
 fs/btrfs/free-space-cache.c  |  9 +++-
 fs/btrfs/sysfs.c             | 35 +++++++++++++++
 fs/btrfs/volumes.c           |  2 +-
 fs/btrfs/volumes.h           |  1 +
 include/trace/events/btrfs.h | 12 +++++
 9 files changed, 160 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 85077c95b4f7..7f8ea2888e4c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1485,6 +1485,81 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
 	spin_unlock(&fs_info->unused_bgs_lock);
 }
 
+void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_block_group *bg;
+	struct btrfs_space_info *space_info;
+	int ret = 0;
+
+	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
+		return;
+
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
+		return;
+
+	mutex_lock(&fs_info->delete_unused_bgs_mutex);
+	mutex_lock(&fs_info->reclaim_bgs_lock);
+	while (!list_empty(&fs_info->reclaim_bgs)) {
+		bg = list_first_entry(&fs_info->reclaim_bgs,
+				      struct btrfs_block_group,
+				      bg_list);
+		list_del_init(&bg->bg_list);
+
+		space_info = bg->space_info;
+		mutex_unlock(&fs_info->reclaim_bgs_lock);
+
+		down_write(&space_info->groups_sem);
+
+		spin_lock(&bg->lock);
+		if (bg->reserved || bg->pinned || bg->ro ||
+		    list_is_singular(&bg->list)) {
+			/*
+			 * We want to bail if we made new allocations or have
+			 * outstanding allocations in this block group.  We do
+			 * the ro check in case balance is currently acting on
+			 * this block group.
+			 */
+			spin_unlock(&bg->lock);
+			up_write(&space_info->groups_sem);
+			goto next;
+		}
+		spin_unlock(&bg->lock);
+
+		ret = inc_block_group_ro(bg, 0);
+		up_write(&space_info->groups_sem);
+		if (ret < 0) {
+			ret = 0;
+			goto next;
+		}
+
+		trace_btrfs_reclaim_block_group(bg);
+		ret = btrfs_relocate_chunk(fs_info, bg->start);
+		if (ret)
+			btrfs_err(fs_info, "error relocating chunk %llu",
+				  bg->start);
+
+next:
+		btrfs_put_block_group(bg);
+		mutex_lock(&fs_info->reclaim_bgs_lock);
+	}
+	mutex_unlock(&fs_info->reclaim_bgs_lock);
+	mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+	btrfs_exclop_finish(fs_info);
+}
+
+void btrfs_mark_bg_to_reclaim(struct btrfs_block_group *bg)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+
+	mutex_lock(&fs_info->reclaim_bgs_lock);
+	if (list_empty(&bg->bg_list)) {
+		btrfs_get_block_group(bg);
+		trace_btrfs_add_reclaim_block_group(bg);
+		list_add_tail(&bg->bg_list, &fs_info->reclaim_bgs);
+	}
+	mutex_unlock(&fs_info->reclaim_bgs_lock);
+}
+
 static int read_bg_from_eb(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
 			   struct btrfs_path *path)
 {
@@ -3390,6 +3465,16 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 	}
 	spin_unlock(&info->unused_bgs_lock);
 
+	mutex_lock(&info->reclaim_bgs_lock);
+	while (!list_empty(&info->reclaim_bgs)) {
+		block_group = list_first_entry(&info->reclaim_bgs,
+					       struct btrfs_block_group,
+					       bg_list);
+		list_del_init(&block_group->bg_list);
+		btrfs_put_block_group(block_group);
+	}
+	mutex_unlock(&info->reclaim_bgs_lock);
+
 	spin_lock(&info->block_group_cache_lock);
 	while ((n = rb_last(&info->block_group_cache_tree)) != NULL) {
 		block_group = rb_entry(n, struct btrfs_block_group,
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 3ecc3372a5ce..e75c79676241 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -264,6 +264,8 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 			     u64 group_start, struct extent_map *em);
 void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info);
 void btrfs_mark_bg_unused(struct btrfs_block_group *bg);
+void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info);
+void btrfs_mark_bg_to_reclaim(struct btrfs_block_group *bg);
 int btrfs_read_block_groups(struct btrfs_fs_info *info);
 int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 			   u64 type, u64 chunk_offset, u64 size);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f2fd73e58ee6..f34dc1c61ce8 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -939,6 +939,9 @@ struct btrfs_fs_info {
 	struct mutex unused_bg_unpin_mutex;
 	struct mutex delete_unused_bgs_mutex;
 
+	struct mutex reclaim_bgs_lock;
+	struct list_head reclaim_bgs;
+
 	/* Cached block sizes */
 	u32 nodesize;
 	u32 sectorsize;
@@ -978,6 +981,8 @@ struct btrfs_fs_info {
 	spinlock_t treelog_bg_lock;
 	u64 treelog_bg;
 
+	int bg_reclaim_threshold;
+
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 41b718cfea40..defecef7296d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1815,6 +1815,13 @@ static int cleaner_kthread(void *arg)
 		 * unused block groups.
 		 */
 		btrfs_delete_unused_bgs(fs_info);
+
+		/*
+		 * Reclaim block groups in the reclaim_bgs list after we deleted
+		 * all unused block_groups. This possibly gives us some more free
+		 * space.
+		 */
+		btrfs_reclaim_bgs(fs_info);
 sleep:
 		clear_and_wake_up_bit(BTRFS_FS_CLEANER_RUNNING, &fs_info->flags);
 		if (kthread_should_park())
@@ -2796,12 +2803,14 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	mutex_init(&fs_info->reloc_mutex);
 	mutex_init(&fs_info->delalloc_root_mutex);
 	mutex_init(&fs_info->zoned_meta_io_lock);
+	mutex_init(&fs_info->reclaim_bgs_lock);
 	seqlock_init(&fs_info->profiles_lock);
 
 	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
 	INIT_LIST_HEAD(&fs_info->space_info);
 	INIT_LIST_HEAD(&fs_info->tree_mod_seq_list);
 	INIT_LIST_HEAD(&fs_info->unused_bgs);
+	INIT_LIST_HEAD(&fs_info->reclaim_bgs);
 #ifdef CONFIG_BTRFS_DEBUG
 	INIT_LIST_HEAD(&fs_info->allocated_roots);
 	INIT_LIST_HEAD(&fs_info->allocated_ebs);
@@ -2890,6 +2899,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	fs_info->swapfile_pins = RB_ROOT;
 
 	fs_info->send_in_progress = 0;
+
+	fs_info->bg_reclaim_threshold = 75;
 }
 
 static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 9988decd5717..e54466fc101f 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -11,6 +11,7 @@
 #include <linux/ratelimit.h>
 #include <linux/error-injection.h>
 #include <linux/sched/mm.h>
+#include "misc.h"
 #include "ctree.h"
 #include "free-space-cache.h"
 #include "transaction.h"
@@ -2539,6 +2540,7 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 					u64 bytenr, u64 size, bool used)
 {
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	u64 offset = bytenr - block_group->start;
 	u64 to_free, to_unusable;
@@ -2569,8 +2571,13 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 	}
 
 	/* All the region is now unusable. Mark it as unused and reclaim */
-	if (block_group->zone_unusable == block_group->length)
+	if (block_group->zone_unusable == block_group->length) {
 		btrfs_mark_bg_unused(block_group);
+	} else if (block_group->zone_unusable >=
+		   div_factor_fine(block_group->length,
+				   fs_info->bg_reclaim_threshold)) {
+		btrfs_mark_bg_to_reclaim(block_group);
+	}
 
 	return 0;
 }
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 6eb1c50fa98c..bf38c7c6b804 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -965,6 +965,40 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 }
 BTRFS_ATTR_RW(, read_policy, btrfs_read_policy_show, btrfs_read_policy_store);
 
+static ssize_t btrfs_bg_reclaim_threshold_show(struct kobject *kobj,
+					       struct kobj_attribute *a,
+					       char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
+	ssize_t ret;
+
+	ret = scnprintf(buf, PAGE_SIZE, "%d\n", fs_info->bg_reclaim_threshold);
+
+	return ret;
+}
+
+static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
+						struct kobj_attribute *a,
+						const char *buf, size_t len)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
+	int thresh;
+	int ret;
+
+	ret = kstrtoint(buf, 10, &thresh);
+	if (ret)
+		return ret;
+
+	if (thresh <= 50 || thresh > 100)
+		return -EINVAL;
+
+	fs_info->bg_reclaim_threshold = thresh;
+
+	return len;
+}
+BTRFS_ATTR_RW(, bg_reclaim_threshold, btrfs_bg_reclaim_threshold_show,
+	      btrfs_bg_reclaim_threshold_store);
+
 static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, label),
 	BTRFS_ATTR_PTR(, nodesize),
@@ -976,6 +1010,7 @@ static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, exclusive_operation),
 	BTRFS_ATTR_PTR(, generation),
 	BTRFS_ATTR_PTR(, read_policy),
+	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
 	NULL,
 };
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 995920fcce9b..7e4c9dd8fc64 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3098,7 +3098,7 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 	return ret;
 }
 
-static int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
+int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 {
 	struct btrfs_root *root = fs_info->chunk_root;
 	struct btrfs_trans_handle *trans;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index d4c3e0dd32b8..9c0d84e5ec06 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -484,6 +484,7 @@ void btrfs_describe_block_groups(u64 flags, char *buf, u32 size_buf);
 int btrfs_resume_balance_async(struct btrfs_fs_info *fs_info);
 int btrfs_recover_balance(struct btrfs_fs_info *fs_info);
 int btrfs_pause_balance(struct btrfs_fs_info *fs_info);
+int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset);
 int btrfs_cancel_balance(struct btrfs_fs_info *fs_info);
 int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info);
 int btrfs_uuid_scan_kthread(void *data);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 0551ea65374f..a41dd8a0c730 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1903,6 +1903,18 @@ DEFINE_EVENT(btrfs__block_group, btrfs_add_unused_block_group,
 	TP_ARGS(bg_cache)
 );
 
+DEFINE_EVENT(btrfs__block_group, btrfs_add_reclaim_block_group,
+	TP_PROTO(const struct btrfs_block_group *bg_cache),
+
+	TP_ARGS(bg_cache)
+);
+
+DEFINE_EVENT(btrfs__block_group, btrfs_reclaim_block_group,
+	TP_PROTO(const struct btrfs_block_group *bg_cache),
+
+	TP_ARGS(bg_cache)
+);
+
 DEFINE_EVENT(btrfs__block_group, btrfs_skip_unused_block_group,
 	TP_PROTO(const struct btrfs_block_group *bg_cache),
 
-- 
2.30.0

