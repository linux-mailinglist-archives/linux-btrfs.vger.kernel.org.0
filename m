Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A408110946B
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 20:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfKYTrY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 14:47:24 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44837 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbfKYTrX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 14:47:23 -0500
Received: by mail-qt1-f193.google.com with SMTP id g24so11749887qtq.11
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 11:47:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=yGC/Pq+tnj/7aNVBYYJDP8+R4STEJhY4WcWAt+ulph8=;
        b=jcOOYHKAMl2Xkn5OSGeSbyGcRJyu8zZsmTwVLutz/kyLKVtFl2lWci1x8EP3uRy9Xf
         hqcKuq2f0TYALa0FQukd5x6VNSlq7p9guUkBhXozjM4i6hVPCyLenvf8Sa9PFrr98tBX
         scRadvN3GjFheDVcUYQV24/KqIUzMkEge9MwwDRqh879bwjIpAAWMzCr9hEnCPsuMaRQ
         bjxgi6NAGPI6Eqt0F3qBRPp3E1Ni3S7VzwilpTv5eUHRouHq3Uezpr/IOaYEFIw11Yhh
         fNGg6XKy0KNK63ABwWpSKBi3mEtxMKSkWhDzzg/mQ9LQHPNuwLDG0bnjimJJ671H3gDB
         bK/Q==
X-Gm-Message-State: APjAAAVMgiCQqw7BWG8w/qlOX1p86aj2qCgeR4FNkMcpKRRg8MzjPm40
        DtLKH+7muOMuPZiJU4Cu3Ag=
X-Google-Smtp-Source: APXvYqxSppfLMpciEqV5UW1BmpWeJHYjFSi1d5GtZwWDwH5yABX4es+SLKNaqwHhi27bbJEvfLrwhQ==
X-Received: by 2002:ac8:607:: with SMTP id d7mr30857306qth.186.1574711242161;
        Mon, 25 Nov 2019 11:47:22 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id o13sm4481033qto.96.2019.11.25.11.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Nov 2019 11:47:21 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 13/22] btrfs: calculate discard delay based on number of extents
Date:   Mon, 25 Nov 2019 14:46:53 -0500
Message-Id: <9171398d2ba16bc6b2b41a3d4982acf9ae27417d.1574709825.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
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
index 5b13bda52ab7..78b970cfd108 100644
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
index 074341c8242a..ddd5cc303b1e 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -14,6 +14,11 @@
 /* This is an initial delay to give some chance for lba reuse. */
 #define BTRFS_DISCARD_DELAY		(120ULL * NSEC_PER_SEC)
 
+/* Target completion latency of discarding all discardable extents. */
+#define BTRFS_DISCARD_TARGET_MSEC	(6 * 60 * 60UL * MSEC_PER_SEC)
+#define BTRFS_DISCARD_MAX_DELAY		(10000UL)
+#define BTRFS_DISCARD_MAX_IOPS		(10UL)
+
 static struct list_head *btrfs_get_discard_list(
 					struct btrfs_discard_ctl *discard_ctl,
 					struct btrfs_block_group *block_group)
@@ -231,11 +236,18 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 
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
@@ -341,6 +353,37 @@ bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl)
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
@@ -470,6 +513,8 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 
 	atomic_set(&discard_ctl->discardable_extents, 0);
 	atomic64_set(&discard_ctl->discardable_bytes, 0);
+	discard_ctl->delay = BTRFS_DISCARD_MAX_DELAY;
+	discard_ctl->iops_limit = BTRFS_DISCARD_MAX_IOPS;
 }
 
 void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index 75f00a84d540..88f1363aa4e4 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -23,6 +23,7 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl);
 
 /* Update operations. */
+void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl);
 void btrfs_discard_update_discardable(struct btrfs_block_group *block_group,
 				      struct btrfs_free_space_ctl *ctl);
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 857642dc8589..27ca833c11c8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2941,8 +2941,10 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
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
index 07098f6d62bd..043430ae3818 100644
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

