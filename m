Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB0F3117626
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 20:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfLITq1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 14:46:27 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34000 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfLITq0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Dec 2019 14:46:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id n13so7761500pff.1
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2019 11:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=r4YcEWKtuD5/J+rWfpmmH6rNeVHA4/MUTPR8T5Tke48=;
        b=mw65VzgTQcAwArXE7zeYi3S5SY7E5TRuWUjohXSKJVvoiml7X2Tad+s9XYdu4QUi4a
         Me1kjTox//1X+1LzufcuX8ZVhwAIXtFg0nwLE6mvVVauawwRGG6bKWA1MXwzIJ1xmUuP
         urWbUvkjHgnVgZ3M6ehM8HJ9p0vFtiZ2d3927znMAhZ/bWxvuhwgH37HOVoNqk024J+O
         cxz+1VHXpgLDYyxHC+/gmXvg0JObKJPD7NSbsHEDdL9VFT/AOm4+FVmjKbtuZQxlDrSh
         Rpxt0pmGyBibwuBseR12e3XJx2PrSp108ZMdpDcjvBOZBbA35d66Rmwv8HWjwocnuYxY
         xhBw==
X-Gm-Message-State: APjAAAWHtFgidyHX8UoWaCcrZm/bT8lVnX7r0Zkdpe+ZUwheLz1IipZo
        zaBO9aZRQHouwqtSxUdmI/dJAyMj26A=
X-Google-Smtp-Source: APXvYqzwDk7W5xizmWN5IWdW8VQsEiIg05X1xxu7y08NVLI+OSDb+91YPrc/mmqSQYzPel/PYpneJQ==
X-Received: by 2002:a63:6d4f:: with SMTP id i76mr18439352pgc.301.1575920784874;
        Mon, 09 Dec 2019 11:46:24 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id b190sm282956pfg.66.2019.12.09.11.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 11:46:24 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 13/22] btrfs: calculate discard delay based on number of extents
Date:   Mon,  9 Dec 2019 11:45:58 -0800
Message-Id: <e73a0b58d92cea79ba7dc8784cdaae51f3d203bc.1575919745.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use the number of discardable extents to help guide our discard delay
interval. This value is reevaluated every transaction commit.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/discard.c     | 53 ++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/discard.h     |  1 +
 fs/btrfs/extent-tree.c |  4 +++-
 fs/btrfs/sysfs.c       | 31 ++++++++++++++++++++++++
 5 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 31b15e60f1d3..ae21e5659dd8 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -469,6 +469,8 @@ struct btrfs_discard_ctl {
 	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
 	atomic_t discardable_extents;
 	atomic64_t discardable_bytes;
+	u32 delay;
+	u32 iops_limit;
 };
 
 /* delayed seq elem */
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index e8c2623617fd..160713e04d0c 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -15,6 +15,11 @@
 #define BTRFS_DISCARD_DELAY		(120ULL * NSEC_PER_SEC)
 #define BTRFS_DISCARD_UNUSED_DELAY	(10ULL * NSEC_PER_SEC)
 
+/* Target completion latency of discarding all discardable extents. */
+#define BTRFS_DISCARD_TARGET_MSEC	(6 * 60 * 60UL * MSEC_PER_SEC)
+#define BTRFS_DISCARD_MAX_DELAY		(10000UL)
+#define BTRFS_DISCARD_MAX_IOPS		(10UL)
+
 static struct list_head *get_discard_list(struct btrfs_discard_ctl *discard_ctl,
 					  struct btrfs_block_group *block_group)
 {
@@ -239,11 +244,18 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 
 	block_group = find_next_block_group(discard_ctl, now);
 	if (block_group) {
-		u64 delay = 0;
+		u32 delay = discard_ctl->delay;
+
+		/*
+		 * This timeout is to hopefully prevent immediate discarding
+		 * in a recently allocated block group.
+		 */
+		if (now < block_group->discard_eligible_time) {
+			u64 bg_timeout = (block_group->discard_eligible_time -
+					  now);
 
-		if (now < block_group->discard_eligible_time)
-			delay = nsecs_to_jiffies(
-				block_group->discard_eligible_time - now);
+			delay = max_t(u64, delay, nsecs_to_jiffies(bg_timeout));
+		}
 
 		mod_delayed_work(discard_ctl->discard_workers,
 				 &discard_ctl->work,
@@ -348,6 +360,37 @@ bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl)
 		test_bit(BTRFS_FS_DISCARD_RUNNING, &fs_info->flags));
 }
 
+/**
+ * btrfs_discard_calc_delay - recalculate the base delay
+ * @discard_ctl: discard control
+ *
+ * Recalculate the base delay which is based off the total number of
+ * discardable_extents.  Clamp this with the iops_limit and
+ * BTRFS_DISCARD_MAX_DELAY.
+ */
+void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
+{
+	s32 discardable_extents =
+		atomic_read(&discard_ctl->discardable_extents);
+	s32 iops_limit;
+	unsigned long delay;
+
+	if (!discardable_extents)
+		return;
+
+	spin_lock(&discard_ctl->lock);
+
+	iops_limit = READ_ONCE(discard_ctl->iops_limit);
+	if (iops_limit)
+		iops_limit = MSEC_PER_SEC / iops_limit;
+
+	delay = BTRFS_DISCARD_TARGET_MSEC / discardable_extents;
+	delay = clamp_t(s32, delay, iops_limit, BTRFS_DISCARD_MAX_DELAY);
+	discard_ctl->delay = msecs_to_jiffies(delay);
+
+	spin_unlock(&discard_ctl->lock);
+}
+
 /**
  * btrfs_discard_update_discardable - propagate discard counters
  * @block_group: block_group of interest
@@ -476,6 +519,8 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 
 	atomic_set(&discard_ctl->discardable_extents, 0);
 	atomic64_set(&discard_ctl->discardable_bytes, 0);
+	discard_ctl->delay = BTRFS_DISCARD_MAX_DELAY;
+	discard_ctl->iops_limit = BTRFS_DISCARD_MAX_IOPS;
 }
 
 void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index 7e3680dd82ce..3ed6855e24da 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -17,6 +17,7 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl);
 
 /* Update operations. */
+void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl);
 void btrfs_discard_update_discardable(struct btrfs_block_group *block_group,
 				      struct btrfs_free_space_ctl *ctl);
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 574be68e9659..dd51ea6a21e7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2935,8 +2935,10 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 		cond_resched();
 	}
 
-	if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
+	if (btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
+		btrfs_discard_calc_delay(&fs_info->discard_ctl);
 		btrfs_discard_schedule_work(&fs_info->discard_ctl, true);
+	}
 
 	/*
 	 * Transaction is finished.  We don't need the lock anymore.  We
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e799d4488d72..79139b4b4f0a 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -344,6 +344,36 @@ static const struct attribute_group btrfs_static_feature_attr_group = {
  */
 #define discard_to_fs_info(_kobj)	to_fs_info((_kobj)->parent->parent)
 
+static ssize_t btrfs_discard_iops_limit_show(struct kobject *kobj,
+					     struct kobj_attribute *a,
+					     char *buf)
+{
+	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n",
+			READ_ONCE(fs_info->discard_ctl.iops_limit));
+}
+
+static ssize_t btrfs_discard_iops_limit_store(struct kobject *kobj,
+					      struct kobj_attribute *a,
+					      const char *buf, size_t len)
+{
+	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
+	struct btrfs_discard_ctl *discard_ctl = &fs_info->discard_ctl;
+	u32 iops_limit;
+	int ret;
+
+	ret = kstrtou32(buf, 10, &iops_limit);
+	if (ret)
+		return -EINVAL;
+
+	WRITE_ONCE(discard_ctl->iops_limit, iops_limit);
+
+	return len;
+}
+BTRFS_ATTR_RW(discard, iops_limit, btrfs_discard_iops_limit_show,
+	      btrfs_discard_iops_limit_store);
+
 static ssize_t btrfs_discardable_extents_show(struct kobject *kobj,
 					      struct kobj_attribute *a,
 					      char *buf)
@@ -367,6 +397,7 @@ static ssize_t btrfs_discardable_bytes_show(struct kobject *kobj,
 BTRFS_ATTR(discard, discardable_bytes, btrfs_discardable_bytes_show);
 
 static const struct attribute *discard_debug_attrs[] = {
+	BTRFS_ATTR_PTR(discard, iops_limit),
 	BTRFS_ATTR_PTR(discard, discardable_extents),
 	BTRFS_ATTR_PTR(discard, discardable_bytes),
 	NULL,
-- 
2.17.1

