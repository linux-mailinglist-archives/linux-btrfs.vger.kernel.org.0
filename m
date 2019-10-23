Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB5EE26AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 00:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436932AbfJWWxg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 18:53:36 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37098 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436922AbfJWWxf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 18:53:35 -0400
Received: by mail-qk1-f193.google.com with SMTP id u184so21518291qkd.4
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 15:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=SiPaKWN5jGt8CN9xurjK+UJhwnPg3865HBBym/X9Ps4=;
        b=gpiUfecKRUt1TZvEUauuyDIcMpJfM07Wx72syChpqLL/bRAG0UFiZ7xbgUnvIkQpbx
         pp3bqsHiLg9EKOk+XkcYARLFKcNwA71vTAlFVklB9gbq7KDuXAqrBb+Eq+SATQJbkuSO
         4dgFMQMB177o9Nb/Hhzc+6Ub1bv/BY/OvmD5k0hyxsUb4gYmGn42IU88v18DmBTRfb9+
         GJ4a8hg9IaxpIVxur/l0R1pLHApgbHkuhbjySyhGHj0b1h8/YfJqH5g6ZtLitzzuF8Jf
         7LbDHUCSWqE5KAxDSJcJbP+WTLdlKpkKPGv+jAaPIqK/71e00l7i4ZrTN8qKBma7T3Tt
         x2kQ==
X-Gm-Message-State: APjAAAX3ec15xqyDup5G8QqOhi6VA/xsNJWpFxGHQ+SpS2+/eVDT1gSz
        P7rZKMHyyXKVUkVM9g0Qfys=
X-Google-Smtp-Source: APXvYqzVPbEBl4ldgdFTjITJ/3CsgQrQFTYwcNAhLeXE3d9jTdx5wme/ovVaoEBkTa0PZk0Q13y9Zw==
X-Received: by 2002:a37:c11:: with SMTP id 17mr8322544qkm.481.1571871214243;
        Wed, 23 Oct 2019 15:53:34 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id j4sm11767542qkf.116.2019.10.23.15.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 15:53:33 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 13/22] btrfs: calculate discard delay based on number of extents
Date:   Wed, 23 Oct 2019 18:53:07 -0400
Message-Id: <684dc3c1016cf8ff4215899a5c45958204d1d6d8.1571865774.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
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
 fs/btrfs/discard.c     | 52 ++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/discard.h     |  1 +
 fs/btrfs/extent-tree.c |  4 +++-
 fs/btrfs/sysfs.c       | 31 +++++++++++++++++++++++++
 5 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 43aa355f5c37..246141e2f825 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -467,6 +467,8 @@ struct btrfs_discard_ctl {
 	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
 	atomic_t discardable_extents;
 	atomic64_t discardable_bytes;
+	u32 delay;
+	u32 iops_limit;
 };
 
 /* delayed seq elem */
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 9c561a561578..c3da4a537b5a 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -16,6 +16,11 @@
 /* This is an initial delay to give some chance for lba reuse. */
 #define BTRFS_DISCARD_DELAY		(120ULL * NSEC_PER_SEC)
 
+/* Target completion latency of discarding all discardable extents. */
+#define BTRFS_DISCARD_TARGET_MSEC	(6 * 60 * 60ULL * MSEC_PER_SEC)
+#define BTRFS_DISCARD_MAX_DELAY		(10000UL)
+#define BTRFS_DISCARD_MAX_IOPS		(10UL)
+
 static struct list_head *btrfs_get_discard_list(
 					struct btrfs_discard_ctl *discard_ctl,
 					struct btrfs_block_group_cache *cache)
@@ -232,11 +237,17 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 
 	cache = find_next_cache(discard_ctl, now);
 	if (cache) {
-		u64 delay = 0;
+		u32 delay = discard_ctl->delay;
+
+		/*
+		 * This timeout is to hopefully prevent immediate discarding
+		 * in a recently allocated block group.
+		 */
+		if (now < cache->discard_eligible_time) {
+			u64 bg_timeout = cache->discard_eligible_time - now;
 
-		if (now < cache->discard_eligible_time)
-			delay = nsecs_to_jiffies(cache->discard_eligible_time -
-						 now);
+			delay = max_t(u64, delay, nsecs_to_jiffies(bg_timeout));
+		}
 
 		mod_delayed_work(discard_ctl->discard_workers,
 				 &discard_ctl->work,
@@ -337,6 +348,37 @@ bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl)
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
  * @cache: block_group of interest
@@ -463,6 +505,8 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 
 	atomic_set(&discard_ctl->discardable_extents, 0);
 	atomic64_set(&discard_ctl->discardable_bytes, 0);
+	discard_ctl->delay = BTRFS_DISCARD_MAX_DELAY;
+	discard_ctl->iops_limit = BTRFS_DISCARD_MAX_IOPS;
 }
 
 void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index 0d453491eac1..2d933b44abd9 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -25,6 +25,7 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl);
 
 /* Update operations. */
+void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl);
 void btrfs_discard_update_discardable(struct btrfs_block_group_cache *cache,
 				      struct btrfs_free_space_ctl *ctl);
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index de00fd6e338b..81c2503b53c1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2921,8 +2921,10 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
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
index 9ebb1f1b1de6..4955afc225c7 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -341,9 +341,40 @@ static ssize_t btrfs_discardable_bytes_show(struct kobject *kobj,
 }
 BTRFS_ATTR(discard, discardable_bytes, btrfs_discardable_bytes_show);
 
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
 static const struct attribute *discard_attrs[] = {
 	BTRFS_ATTR_PTR(discard, discardable_extents),
 	BTRFS_ATTR_PTR(discard, discardable_bytes),
+	BTRFS_ATTR_PTR(discard, iops_limit),
 	NULL,
 };
 
-- 
2.17.1

