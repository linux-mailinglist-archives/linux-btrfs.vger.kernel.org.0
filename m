Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A47A365F2E
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Apr 2021 20:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbhDTS2H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 14:28:07 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54900 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbhDTS2G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 14:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618943270; x=1650479270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aL7+ECgZqUpfkr5yxG+iByxbZNi1+TX1UFU/svCEkQo=;
  b=Y1d1q7mwETWMNPW/RdEs1C/7PFgHeZJW6q5k0gPYYR2i2nvds9HdnpOP
   npyBPdnkQV2Aqob7phIO3I5teu+8gUffULXLSPk0jxEPQUnWcZliaJZLS
   ODyJ/F55fkAGRYXvxED1JbHJQU+mWnnnPSEQs3HfJPOjO0JihZSf+Layu
   RWWkhL90lyFUrbZpxBbKk7nEjjHckBoaezVQAI4c11Di8h13vuZmhrKk9
   pWwXr3jCUggwspI8HlsHeryiigL7nJpL0JGAWk4A7/GducuXe94q30ESi
   LC/HYvFgvbmWLHvephfZLCqffVAPHOZbHyOOhoDx//l6PYCqDTL6wGUTo
   w==;
IronPort-SDR: FN/nj0ueWG6aq2R7+xzSuywEbtok8pDquIf2XxMLhg52kRLcQdy4nBBqMcQ+bIVj32QSuq7vcn
 YV0aiJHZigy5NP8WskTBSsjOzeaI3Ei9VKnP4AVEyGcmqdwhO8wThsh0RkWLNBY1mgihMVAQOo
 f9l1l83uc4lMFQF1ootLhU5uddhtPMVQecJkJPYD49H8WZ/VCpg3o5+LTka6T9rDqKvVaDdFtR
 1ZOIhgO/bY//Y2J9WLfAIZQMKnViyNU7efuNRqY46F5xkq2zffOOgjFJK69wAwuJBkn17F2blo
 yiA=
X-IronPort-AV: E=Sophos;i="5.82,237,1613404800"; 
   d="scan'208";a="269507078"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Apr 2021 02:27:50 +0800
IronPort-SDR: eQdOzlQDTIAQmcpMDkXdXqzFV++GSLlzISoYChrUSPhJbYlkLqpN6E0uFzXhTxo7rJnp2klEBf
 e4oaLToWs8LnOqaRa742Q9nHzQhysv1+4EJDlYQP8s1q3SK/Mc94PpGJhs8z2g5Nr6Q4wgGNoY
 VcKJxEz4dmIM0LA5mYKxw85EydClDUNEuX+w/Iomy9JsUQlAol1B7v/yyXp/Jr/O8fKZicTZ4j
 5tB3ed83lAXOe2Dx8u2MyelAn9j5t1lzfi69s7Y1ezoflY2TO+8ibs7sxBRtB4syPna95SU+v8
 FrDax2rm73KlrIPLC4et1efj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 11:08:13 -0700
IronPort-SDR: QubpJy/EKoluFLuvqEijsQCdKKu6mWx3DmX+38D+q1RvJmw3+rdAdJLGjEsgVrId0uv/cbqXoH
 kdADFT2t8vbqjUgb9gVDRGV8BTDlNYIAQbEtCSf8JTWmbOq8gqYKVf8pt/c+8fnp0LHPuw6VYP
 Dw+Uuk59BryIyBVQnnUousOmrCtIoy/WPUFIhY7Ri6oMP96Udjdrr8Cdwhy+BUeFb7sM3yrkhi
 0mhK6Pez6mZmFsbJgrQIEP5JfDB8Q/m1Xjw69m0/cW0j4DH3KJAsPr77fQNAZwQTcDdTvEzsrR
 abI=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Apr 2021 11:27:34 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v6 3/3] btrfs: zoned: automatically reclaim zones
Date:   Wed, 21 Apr 2021 03:27:25 +0900
Message-Id: <00c38aba6f1904b50b53582dddb7012e862b2837.1618943115.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1618943115.git.johannes.thumshirn@wdc.com>
References: <cover.1618943115.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When a file gets deleted on a zoned file system, the space freed is not
returned back into the block group's free space, but is migrated to
zone_unusable.

As this zone_unusable space is behind the current write pointer it is not
possible to use it for new allocations. In the current implementation a
zone is reset once all of the block group's space is accounted as zone
unusable.

This behaviour can lead to premature ENOSPC errors on a busy file system.

Instead of only reclaiming the zone once it is completely unusable,
kick off a reclaim job once the amount of unusable bytes exceeds a user
configurable threshold between 51% and 100%. It can be set per mounted
filesystem via the sysfs tunable bg_reclaim_threshold which is set to 75%
per default.

Similar to reclaiming unused block groups, these dirty block groups are
added to a to_reclaim list and then on a transaction commit, the reclaim
process is triggered but after we deleted unused block groups, which will
free space for the relocation process.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c       | 101 +++++++++++++++++++++++++++++++++++
 fs/btrfs/block-group.h       |   3 ++
 fs/btrfs/ctree.h             |   5 ++
 fs/btrfs/disk-io.c           |  13 +++++
 fs/btrfs/free-space-cache.c  |   9 +++-
 fs/btrfs/sysfs.c             |  35 ++++++++++++
 fs/btrfs/volumes.c           |   2 +-
 fs/btrfs/volumes.h           |   1 +
 fs/btrfs/zoned.h             |   6 +++
 include/trace/events/btrfs.h |  12 +++++
 10 files changed, 185 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index bbb5a6e170c7..783f93fb845e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1485,6 +1485,97 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
 	spin_unlock(&fs_info->unused_bgs_lock);
 }
 
+void btrfs_reclaim_bgs_work(struct work_struct *work)
+{
+	struct btrfs_fs_info *fs_info =
+		container_of(work, struct btrfs_fs_info, reclaim_bgs_work);
+	struct btrfs_block_group *bg;
+	struct btrfs_space_info *space_info;
+	int ret;
+
+	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
+		return;
+
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
+		return;
+
+	mutex_lock(&fs_info->reclaim_bgs_lock);
+	spin_lock(&fs_info->unused_bgs_lock);
+	while (!list_empty(&fs_info->reclaim_bgs)) {
+		bg = list_first_entry(&fs_info->reclaim_bgs,
+				      struct btrfs_block_group,
+				      bg_list);
+		list_del_init(&bg->bg_list);
+
+		space_info = bg->space_info;
+		spin_unlock(&fs_info->unused_bgs_lock);
+
+		/* Don't want to race with allocators so take the groups_sem */
+		down_write(&space_info->groups_sem);
+
+		spin_lock(&bg->lock);
+		if (bg->reserved || bg->pinned || bg->ro) {
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
+		/* Get out fast, in case we're unmounting the FS. */
+		if (btrfs_fs_closing(fs_info)) {
+			up_write(&space_info->groups_sem);
+			goto next;
+		}
+
+		ret = inc_block_group_ro(bg, 0);
+		up_write(&space_info->groups_sem);
+		if (ret < 0)
+			goto next;
+
+		btrfs_info(fs_info, "reclaiming chunk %llu %2llu%% used",
+			   bg->start, div_u64(bg->used * 100, bg->length));
+		trace_btrfs_reclaim_block_group(bg);
+		ret = btrfs_relocate_chunk(fs_info, bg->start);
+		if (ret)
+			btrfs_err(fs_info, "error relocating chunk %llu",
+				  bg->start);
+
+next:
+		btrfs_put_block_group(bg);
+		spin_lock(&fs_info->unused_bgs_lock);
+	}
+	spin_unlock(&fs_info->unused_bgs_lock);
+	mutex_unlock(&fs_info->reclaim_bgs_lock);
+	btrfs_exclop_finish(fs_info);
+}
+
+void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)
+{
+	spin_lock(&fs_info->unused_bgs_lock);
+	if (!list_empty(&fs_info->reclaim_bgs))
+		queue_work(system_unbound_wq, &fs_info->reclaim_bgs_work);
+	spin_unlock(&fs_info->unused_bgs_lock);
+}
+
+void btrfs_mark_bg_to_reclaim(struct btrfs_block_group *bg)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+
+	spin_lock(&fs_info->unused_bgs_lock);
+	if (list_empty(&bg->bg_list)) {
+		btrfs_get_block_group(bg);
+		trace_btrfs_add_reclaim_block_group(bg);
+		list_add_tail(&bg->bg_list, &fs_info->reclaim_bgs);
+	}
+	spin_unlock(&fs_info->unused_bgs_lock);
+}
+
 static int read_bg_from_eb(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
 			   struct btrfs_path *path)
 {
@@ -3446,6 +3537,16 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 	}
 	spin_unlock(&info->unused_bgs_lock);
 
+	spin_lock(&info->unused_bgs_lock);
+	while (!list_empty(&info->reclaim_bgs)) {
+		block_group = list_first_entry(&info->reclaim_bgs,
+					       struct btrfs_block_group,
+					       bg_list);
+		list_del_init(&block_group->bg_list);
+		btrfs_put_block_group(block_group);
+	}
+	spin_unlock(&info->unused_bgs_lock);
+
 	spin_lock(&info->block_group_cache_lock);
 	while ((n = rb_last(&info->block_group_cache_tree)) != NULL) {
 		block_group = rb_entry(n, struct btrfs_block_group,
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 3ecc3372a5ce..7b927425dc71 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -264,6 +264,9 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 			     u64 group_start, struct extent_map *em);
 void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info);
 void btrfs_mark_bg_unused(struct btrfs_block_group *bg);
+void btrfs_reclaim_bgs_work(struct work_struct *work);
+void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info);
+void btrfs_mark_bg_to_reclaim(struct btrfs_block_group *bg);
 int btrfs_read_block_groups(struct btrfs_fs_info *info);
 int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 			   u64 type, u64 chunk_offset, u64 size);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 68ee130b5a2a..7c72dcd71547 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -954,6 +954,11 @@ struct btrfs_fs_info {
 	struct work_struct async_data_reclaim_work;
 	struct work_struct preempt_reclaim_work;
 
+	/* Used to reclaim partially filled block groups in the background */
+	struct work_struct reclaim_bgs_work;
+	struct list_head reclaim_bgs;
+	int bg_reclaim_threshold;
+
 	spinlock_t unused_bgs_lock;
 	struct list_head unused_bgs;
 	struct mutex unused_bg_unpin_mutex;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e52b89ad0a61..c9a3036c23bf 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1898,6 +1898,13 @@ static int cleaner_kthread(void *arg)
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
@@ -2886,6 +2893,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	INIT_LIST_HEAD(&fs_info->space_info);
 	INIT_LIST_HEAD(&fs_info->tree_mod_seq_list);
 	INIT_LIST_HEAD(&fs_info->unused_bgs);
+	INIT_LIST_HEAD(&fs_info->reclaim_bgs);
 #ifdef CONFIG_BTRFS_DEBUG
 	INIT_LIST_HEAD(&fs_info->allocated_roots);
 	INIT_LIST_HEAD(&fs_info->allocated_ebs);
@@ -2974,6 +2982,9 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	fs_info->swapfile_pins = RB_ROOT;
 
 	fs_info->send_in_progress = 0;
+
+	fs_info->bg_reclaim_threshold = BTRFS_DEFAULT_RECLAIM_THRESH;
+	INIT_WORK(&fs_info->reclaim_bgs_work, btrfs_reclaim_bgs_work);
 }
 
 static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
@@ -4332,6 +4343,8 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	cancel_work_sync(&fs_info->async_data_reclaim_work);
 	cancel_work_sync(&fs_info->preempt_reclaim_work);
 
+	cancel_work_sync(&fs_info->reclaim_bgs_work);
+
 	/* Cancel or finish ongoing discard work */
 	btrfs_discard_cleanup(fs_info);
 
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
index a99d1f415a7f..436ac7b4b334 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -980,6 +980,40 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
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
@@ -991,6 +1025,7 @@ static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, exclusive_operation),
 	BTRFS_ATTR_PTR(, generation),
 	BTRFS_ATTR_PTR(, read_policy),
+	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
 	NULL,
 };
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c6568f61b2b0..08541ef5fc39 100644
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
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 61e969652fe1..3c2a06d3a85b 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -9,6 +9,12 @@
 #include "disk-io.h"
 #include "block-group.h"
 
+/*
+ * Block groups filled more than this value (percents) will be scheduled for
+ * background reclaim.
+ */
+#define BTRFS_DEFAULT_RECLAIM_THRESH 75
+
 struct btrfs_zoned_device_info {
 	/*
 	 * Number of zones, zone size and types of zones if bdev is a
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

