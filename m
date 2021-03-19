Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E822341A6B
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Mar 2021 11:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhCSKtf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Mar 2021 06:49:35 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6295 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhCSKtD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Mar 2021 06:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616150943; x=1647686943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=piyeTvHSJUN0S+eLJ04sY3ShhzxrDIpEP6u9gFmL9Uo=;
  b=Cd6Lk6ckQqUyv7Yt8wFHHrj2JjK61BN4HnU53680Iu152yat3lnqEGPI
   3/Puy3CAs/fWC9Fc/fIyzb7dwyVEPgf2qAv7ml49zD0koMRdTfHgxO31b
   B27/PoNKYyILQD+EX8xSJVh9O81Uzi4eRM7ZOc+uUZf302Q/ZFrpPIB/h
   wVQpTpG++MPuCd1ZdKBUgIAYoDgt3jZwYcfwpqRumWhvriVUhcCRoAwXe
   PPjj3F4tSYpRpqXlXlo3xxXBkPQgydzx8IZNKZaBGjZ1sqjqwVRqM2okq
   PXNhSqE8EYzv4nbWoDBZ4zMaTfXIbUTWMciWwD9Nhbx8uieWw8DH9dGvC
   w==;
IronPort-SDR: nhgo15ThvUIpHtnPJ5fNNSSSMcTjgrZNvOUSYewY3qT8lwIVX968PhcJmdAVtf5r/c82rE7OsF
 kmUGIt3ee0D/9KFDnwM2V9rlDv78vSaYROcgS162RdJDFUw4A1H/xjtX86ewHc/9vvCsEjg7tQ
 9RM2hjUiU62DpBCg2QXkLBgprESo0jv0EmXXsy6H4bZwivDGanpu1eIf5NtJ9BjzJMZ4K6IKut
 asjak07Eq2tT0myBS2OD4lvo2n4OrTLVyY2krahqvtUS5nTsTrLhpQj81D55Sh/70ffEFx62/g
 hqc=
X-IronPort-AV: E=Sophos;i="5.81,261,1610380800"; 
   d="scan'208";a="167028614"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2021 18:49:02 +0800
IronPort-SDR: TGVtxbYlh66o82C4lNqPqN1IXl6dWwPcaJbUXvIBI7+CIFjbTdJvDKsjxXw7Pj5enev8MUvGqA
 w6sStA6DvL4DgXkAdhwVaX8Ms/pvBw1eqs3BPXtDLlrIe6JaTqSDhm6ji4gVDkI3YG+7PIQ3vb
 erH04A0NSZL/IwPr1jMRgoy1saZgRdX8rb2VeokKRQh5naeu0cf0H/w5F5NBHoJEA6gzHAsrHP
 Tc9raX3B2dxv/eFjfvAHaA+4KesYmqk8R2uMCRDKCv2vC6GCpvUdwHnQdwkY/S4Hc8+9DNEm4G
 8ctJYPalxQa40PSBsS5Xuh0I
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 03:29:36 -0700
IronPort-SDR: OaWtOncfl1U4YmvPd7UleqdJJQsxBz2LQ7rWfffja7f2O2azqXz0DqH/0WGKRNn4j+dTHdALYe
 hf8QkEKAxcOmsyLnxDxtIMfD/VmA68woknqhFIQAt9sK6XOlIMAeSz9XSyVSdPK28vfwz9/iEd
 QWZ4/fnC/OKoweVTu3eYHkSaqcI8SlclRxf36PCM0xbMnyDbWIkfD1YRbN8bM+S6LFJ/Syxql3
 Bdvzezoi76Ir4ZQ+6f44rCEDog3LFL0ptdumDzMEBpurmImHvuyq2bVbv+3Qijn4movAG4mV5a
 FT0=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Mar 2021 03:49:02 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 2/2] btrfs: zoned: automatically reclaim zones
Date:   Fri, 19 Mar 2021 19:48:52 +0900
Message-Id: <58648eb48c6cb2b35d201518c8dc430b7797bcaa.1616149060.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1616149060.git.johannes.thumshirn@wdc.com>
References: <cover.1616149060.git.johannes.thumshirn@wdc.com>
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

AFAICT sysfs_create_files() does not have the ability to provide a is_visible
callback, so the bg_reclaim_threshold sysfs file is visible for non zoned
filesystems as well, even though only for zoned filesystems we're adding block
groups to the reclaim list. I'm all ears for a approach that is sensible in
this regard.


 fs/btrfs/block-group.c       | 84 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/block-group.h       |  2 +
 fs/btrfs/ctree.h             |  3 ++
 fs/btrfs/disk-io.c           | 11 +++++
 fs/btrfs/free-space-cache.c  |  9 +++-
 fs/btrfs/sysfs.c             | 35 +++++++++++++++
 fs/btrfs/volumes.c           |  2 +-
 fs/btrfs/volumes.h           |  1 +
 include/trace/events/btrfs.h | 12 ++++++
 9 files changed, 157 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9ae3ac96a521..af9026795ddd 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1485,6 +1485,80 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
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
+		mutex_lock(&fs_info->reclaim_bgs_lock);
+	}
+	mutex_unlock(&fs_info->reclaim_bgs_lock);
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
@@ -3390,6 +3464,16 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
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
index 34ec82d6df3e..0b438b97fed4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -938,6 +938,7 @@ struct btrfs_fs_info {
 	struct list_head unused_bgs;
 	struct mutex unused_bg_unpin_mutex;
 	struct mutex reclaim_bgs_lock;
+	struct list_head reclaim_bgs;
 
 	/* Cached block sizes */
 	u32 nodesize;
@@ -978,6 +979,8 @@ struct btrfs_fs_info {
 	spinlock_t treelog_bg_lock;
 	u64 treelog_bg;
 
+	int bg_reclaim_threshold;
+
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f9250f14fc1e..d4fccf113df1 100644
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
@@ -2797,12 +2804,14 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
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
@@ -2891,6 +2900,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
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
index fb785ff53a27..c78b5ce49d47 100644
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

