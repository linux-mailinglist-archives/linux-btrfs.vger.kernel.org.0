Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DDD359C5D
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Apr 2021 12:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhDIKxh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Apr 2021 06:53:37 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19455 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbhDIKxd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Apr 2021 06:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617965600; x=1649501600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iZEDdSSqa0NYmJRj9NS/SjABTEukMbn2oqLyH0VUbUs=;
  b=QHY0KnYsS4wJQVwn6/9XMvd6B9p8AxDXMZ+lit4CjD7CScJei0SwsUHB
   FrhThOLAvHW2nW1PB2JxPCpRyGHp9EhgXgJfc4qMCOKHN6PxUhdFxny0h
   nKjN8rXxuD17EFJbdjbAJuUKHKLNzCWxtO/nd7QogI7b//5p1A1cyIG1Z
   vjkzSJpx+fizBlpaBOIGm7e3PbpBFS3OEw/WVo5tGFTA1wXmtlZmbkAuQ
   rIZkEj7Az51XEp/GCWNbu+T8A21POyKop24V1BjbDYrlrOZ3FDSi2MyvP
   qsYf/Dh7I8I3uNqYbp2Cp5LO33tAehEkJP0m8rRVbuyxIAWEnRdupaFRl
   w==;
IronPort-SDR: 13pGaiG8VCWIm02X3k/8k2HUH2TzKFJ1Xd2cwGdc7ZPk2PFu12DXt/vMKtz7S++YRX6sFgLaa7
 dXcIKqgci3ViNJ5vd0g0zxwSguQWv3o4qTyun1W8qGfpqgFPA8BnrbreaCMvzFd206EkIz+R+E
 L4evDOHUG2IcfS7u6do6R5tgyI4HxIH9ZB7KEkBH+p2S2gIhNPMxruWOgzLhVx3rfM/3FGKtEN
 OPVFMFjIz+VLUOqlvT04vdecns899PphrXnCtigs1B40E6EWvh69V0cF2eIkeUOCTG5L8q+Z7A
 OT8=
X-IronPort-AV: E=Sophos;i="5.82,209,1613404800"; 
   d="scan'208";a="168797962"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2021 18:53:20 +0800
IronPort-SDR: 5e1whX63RIyeWZ/3xAr2jSvAf/7hQRknrE8V7Cacoje5xSG2z6bo8D+5LtQ9oyEu7R32+8jODz
 v5HeC7r0koYYDwLGuIlR6LCIAH1cTOmqF09uIAmn/+Fpmsnc4o0h7DiDzUb7fvToxDRZGKvTsR
 MHJomEgquw54jdOuIH/9DB7QRVxAmx8e/h7mLjgdnZBVK7TcUbQqZOjUX2STVA52Dms2Y9pBSj
 u82Untcl938qyZvh2/suNTIxdb8/+QUm+jhf6gABEPrSceBTj1CsXHtnu7o6t9qKWWg3pYN5Y9
 vzmz/CpAYaiPEDG7WGWOx1z6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 03:32:56 -0700
IronPort-SDR: YMuOT5LVhY9yx1nwBkuhfkYnwTgZmWzTJbfJjdyVgragYz+nbeJZmIk2MNzDWCwlTIJGn8nubg
 JX1fzR0wa4Kt7l/aQ83KBfwP1shr8DO+UWqvQ/QmiSSI18Yw2r3MfWy6tnGoVhfQUg97GOm75C
 b3GMQCKEvwcHPaAII4soH60SldwiUQYYnUNZtORQqLBE63YYpTTD5PSYmkJ9/g3ffnSsQOv4PC
 uYie3q5bPjOx32jZv2eAmeWamUbMyHMqjljECXY8QKXibhxLC7onUViA4ruT50rTOP1kYY74Ee
 ra4=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Apr 2021 03:53:19 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 3/3] btrfs: zoned: automatically reclaim zones
Date:   Fri,  9 Apr 2021 19:53:09 +0900
Message-Id: <cc5bd0cd8ec08e1199c74293fd98e0019e75fd62.1617962110.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1617962110.git.johannes.thumshirn@wdc.com>
References: <cover.1617962110.git.johannes.thumshirn@wdc.com>
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
---
 fs/btrfs/block-group.c       | 96 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/block-group.h       |  3 ++
 fs/btrfs/ctree.h             |  6 +++
 fs/btrfs/disk-io.c           | 13 +++++
 fs/btrfs/free-space-cache.c  |  9 +++-
 fs/btrfs/sysfs.c             | 35 +++++++++++++
 fs/btrfs/volumes.c           |  2 +-
 fs/btrfs/volumes.h           |  1 +
 include/trace/events/btrfs.h | 12 +++++
 9 files changed, 175 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index bbb5a6e170c7..3f06ea42c013 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1485,6 +1485,92 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
 	spin_unlock(&fs_info->unused_bgs_lock);
 }
 
+void btrfs_reclaim_bgs_work(struct work_struct *work)
+{
+	struct btrfs_fs_info *fs_info =
+		container_of(work, struct btrfs_fs_info, reclaim_bgs_work);
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
+		ret = inc_block_group_ro(bg, 0);
+		up_write(&space_info->groups_sem);
+		if (ret < 0) {
+			ret = 0;
+			goto next;
+		}
+
+		btrfs_info(fs_info, "reclaiming chunk %llu", bg->start);
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
@@ -3446,6 +3532,16 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
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
index c80302564e6b..88531c1fbcdf 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -954,10 +954,14 @@ struct btrfs_fs_info {
 	struct work_struct async_data_reclaim_work;
 	struct work_struct preempt_reclaim_work;
 
+	/* Used to reclaim data space in the background */
+	struct work_struct reclaim_bgs_work;
+
 	spinlock_t unused_bgs_lock;
 	struct list_head unused_bgs;
 	struct mutex unused_bg_unpin_mutex;
 	struct mutex reclaim_bgs_lock;
+	struct list_head reclaim_bgs;
 
 	/* Cached block sizes */
 	u32 nodesize;
@@ -998,6 +1002,8 @@ struct btrfs_fs_info {
 	spinlock_t treelog_bg_lock;
 	u64 treelog_bg;
 
+	int bg_reclaim_threshold;
+
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e52b89ad0a61..942d894ec175 100644
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
+	fs_info->bg_reclaim_threshold = 75;
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
index f69c1cec5ef7..1212c169f7cf 100644
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

