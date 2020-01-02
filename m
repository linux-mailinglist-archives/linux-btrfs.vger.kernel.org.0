Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 284A312EB4D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 22:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgABV0x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 16:26:53 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35443 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgABV0x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 16:26:53 -0500
Received: by mail-qt1-f196.google.com with SMTP id e12so35611975qto.2
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 13:26:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=RaWEyrwdMVsq+Nf1/ZtjAs8mbWCFevwKXtmeu9yks4g=;
        b=HtrZ4jyK/qrVVPJjTacP6TjvdjikAlDND/oyv5MuvXdE+KjvYcZtPHCObn70OMYAJa
         d1HwYAFs4Cy3VrRF/CWJlavJdnTO0/X6lav9uILBNotiSoPigjQody0ORTCfuh5kD56q
         YrtGPct3W3tt7WmtNSd1zpXGZynC/eLCZxaPOKzYhZVJXR+re1UlH7XhJjoKrZLGxDkn
         9Us0sTAOX8As0Mu5EraRz3YSNjC0hbtgje10FhlrjpFW2oLYmAD2Y4iyKZYRTcr8Xopp
         D7dmq4cfNYaIQeKK7BwDQnRaQgcwq64KLmBnHsM9jJzJTsY1qIKxprWA8uARPeV12aHJ
         IYtw==
X-Gm-Message-State: APjAAAUWwq1x5AzPDtVD3Fy0SiX3wvFLAitZ3LzR0Ml8BwtyA/6ZWoW1
        Dp3BpEsVLs2oRMf57Q85ZRk=
X-Google-Smtp-Source: APXvYqw4gty4fpjip/T4EIMUIvmg1oSbiAwr2s8VHmmk4SC9D6l6g/g15YzXT8SKNmH8NsWlTXByrQ==
X-Received: by 2002:ac8:4647:: with SMTP id f7mr61416874qto.361.1578000411898;
        Thu, 02 Jan 2020 13:26:51 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id f42sm17553933qta.0.2020.01.02.13.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jan 2020 13:26:51 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 01/12] btrfs: calculate discard delay based on number of extents
Date:   Thu,  2 Jan 2020 16:26:35 -0500
Message-Id: <d9cfb7e7a23e60845e6fc6213ee34e77946849a6.1577999991.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1577999991.git.dennis@kernel.org>
References: <cover.1577999991.git.dennis@kernel.org>
In-Reply-To: <cover.1577999991.git.dennis@kernel.org>
References: <cover.1577999991.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

An earlier patch keeps track of discardable_extents. These are
undiscarded extents managed by the free space cache. Here, we will use
this to dynamically calculate the discard delay interval.

There are 3 rate to consider. The first is the target convergence rate,
the rate to discard all discardable_extents over the
BTRFS_DISCARD_TARGET_MSEC time frame. This is clamped by the lower
limit, the iops limit or BTRFS_DISCARD_MIN_DELAY (1ms), and the upper
limit, BTRFS_DISCARD_MAX_DELAY (1s). We reevaluate this delay every
transaction commit.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/discard.c     | 55 +++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/discard.h     |  1 +
 fs/btrfs/extent-tree.c |  4 ++-
 fs/btrfs/sysfs.c       | 31 ++++++++++++++++++++++++
 5 files changed, 88 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 7c1c236d13ae..c73bbc7e4491 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -468,6 +468,8 @@ struct btrfs_discard_ctl {
 	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
 	atomic_t discardable_extents;
 	atomic64_t discardable_bytes;
+	unsigned long delay;
+	unsigned iops_limit;
 };
 
 /* delayed seq elem */
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 173770bf8a2d..abcc3b2189d1 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -15,6 +15,12 @@
 #define BTRFS_DISCARD_DELAY		(120ULL * NSEC_PER_SEC)
 #define BTRFS_DISCARD_UNUSED_DELAY	(10ULL * NSEC_PER_SEC)
 
+/* Target completion latency of discarding all discardable extents */
+#define BTRFS_DISCARD_TARGET_MSEC	(6 * 60 * 60UL * MSEC_PER_SEC)
+#define BTRFS_DISCARD_MIN_DELAY_MSEC	(1UL)
+#define BTRFS_DISCARD_MAX_DELAY_MSEC	(1000UL)
+#define BTRFS_DISCARD_MAX_IOPS		(10U)
+
 static struct list_head *get_discard_list(struct btrfs_discard_ctl *discard_ctl,
 					  struct btrfs_block_group *block_group)
 {
@@ -235,11 +241,18 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 
 	block_group = find_next_block_group(discard_ctl, now);
 	if (block_group) {
-		u64 delay = 0;
+		unsigned long delay = discard_ctl->delay;
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
+			delay = max(delay, nsecs_to_jiffies(bg_timeout));
+		}
 
 		mod_delayed_work(discard_ctl->discard_workers,
 				 &discard_ctl->work, delay);
@@ -342,6 +355,38 @@ bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl)
 		test_bit(BTRFS_FS_DISCARD_RUNNING, &fs_info->flags));
 }
 
+/**
+ * btrfs_discard_calc_delay - recalculate the base delay
+ * @discard_ctl: discard control
+ *
+ * Recalculate the base delay which is based off the total number of
+ * discardable_extents.  Clamp this between the lower_limit (iops_limit or 1ms)
+ * and the upper_limit (BTRFS_DISCARD_MAX_DELAY_MSEC).
+ */
+void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
+{
+	s32 discardable_extents =
+		atomic_read(&discard_ctl->discardable_extents);
+	unsigned iops_limit;
+	unsigned long delay, lower_limit = BTRFS_DISCARD_MIN_DELAY_MSEC;
+
+	if (!discardable_extents)
+		return;
+
+	spin_lock(&discard_ctl->lock);
+
+	iops_limit = READ_ONCE(discard_ctl->iops_limit);
+	if (iops_limit)
+		lower_limit = max_t(unsigned long, lower_limit,
+				    MSEC_PER_SEC / iops_limit);
+
+	delay = BTRFS_DISCARD_TARGET_MSEC / discardable_extents;
+	delay = clamp(delay, lower_limit, BTRFS_DISCARD_MAX_DELAY_MSEC);
+	discard_ctl->delay = msecs_to_jiffies(delay);
+
+	spin_unlock(&discard_ctl->lock);
+}
+
 /**
  * btrfs_discard_update_discardable - propagate discard counters
  * @block_group: block_group of interest
@@ -464,6 +509,8 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 
 	atomic_set(&discard_ctl->discardable_extents, 0);
 	atomic64_set(&discard_ctl->discardable_bytes, 0);
+	discard_ctl->delay = BTRFS_DISCARD_MAX_DELAY_MSEC;
+	discard_ctl->iops_limit = BTRFS_DISCARD_MAX_IOPS;
 }
 
 void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index 0f2f89b1b0b9..5250fe178e49 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -17,6 +17,7 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl);
 
 /* Update operations */
+void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl);
 void btrfs_discard_update_discardable(struct btrfs_block_group *block_group,
 				      struct btrfs_free_space_ctl *ctl);
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 2c12366cfde5..0163fdd59f8f 100644
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
index e9dbdbbbebeb..e175aaf7a1e6 100644
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
+	unsigned iops_limit;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &iops_limit);
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

