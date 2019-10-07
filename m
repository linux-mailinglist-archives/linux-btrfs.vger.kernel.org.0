Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1293CED4C
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 22:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfJGUSH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 16:18:07 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42276 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbfJGUSG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 16:18:06 -0400
Received: by mail-qk1-f193.google.com with SMTP id f16so13910144qkl.9
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 13:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=pFrOtMC1OaM1f7SjzSV9uatJzpYwvrI5BTRglYiLU7Q=;
        b=lLDheAOYPCwnd0FKMJeHjFlmAFu2S5wgwp/tMAac0sXcMVFjYPQez66VfCm+l6MQYW
         6j9r5AI8ZbI1VtZEs1pfneRy1Lei3g1v85V8H8fNMqChw1WAb9xpwbh3KWTP0P0VKTFD
         ZKDStPmANAqPqkeT/iYgr6V5c9mmD7d24NqeQuqqBO0yHOplv8yvepy2EWmkYOIGAfNV
         uqdQEtVZFtlXWfDO6ms1aU68vLtPosGcQzpI+SQaWG0ETLJAarHXqN6WoxLq2ihUpJKE
         s3TdoX+2nNnKtY7s2TOWGBLoQGptVY1YPIn84/kQDZ/tb1VFPp/TPa3s4TbRIdtie/S5
         AWmg==
X-Gm-Message-State: APjAAAU12tgGi9ilEjZN6wM+X3Aoepdn3cZ5Ij4HWJgIMQGmcekw7WC5
        NAb6ZBadkPQGR9p4ZLgH9jk=
X-Google-Smtp-Source: APXvYqydA5kmPCs2yCTdIhbRAZtm2wHQ85bI/V8WGsNsEMHEF5FJ7+OLlTc3RYFtUIeUs1Rg7CG6xQ==
X-Received: by 2002:a37:a849:: with SMTP id r70mr25242221qke.37.1570479485003;
        Mon, 07 Oct 2019 13:18:05 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id k2sm6904005qtm.42.2019.10.07.13.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Oct 2019 13:18:04 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 10/19] btrfs: calculate discard delay based on number of extents
Date:   Mon,  7 Oct 2019 16:17:41 -0400
Message-Id: <37690bf17c3b3c9f20137fb186c7af4021bb664b.1570479299.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use the number of discardable extents to help guide our discard delay
interval. This value is reevaluated every transaction commit.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/discard.c     | 31 +++++++++++++++++++++++++++++--
 fs/btrfs/discard.h     |  3 +++
 fs/btrfs/extent-tree.c |  4 +++-
 fs/btrfs/sysfs.c       | 30 ++++++++++++++++++++++++++++++
 5 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8479ab037812..b0823961d049 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -449,6 +449,8 @@ struct btrfs_discard_ctl {
 	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
 	atomic_t discard_extents;
 	atomic64_t discardable_bytes;
+	atomic_t delay;
+	atomic_t iops_limit;
 };
 
 /* delayed seq elem */
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 75a2ff14b3c0..c7afb5f8240d 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -15,6 +15,11 @@
 
 #define BTRFS_DISCARD_DELAY		(300ULL * NSEC_PER_SEC)
 
+/* target discard delay in milliseconds */
+#define BTRFS_DISCARD_TARGET_MSEC	(6 * 60 * 60ULL * MSEC_PER_SEC)
+#define BTRFS_DISCARD_MAX_DELAY		(10000UL)
+#define BTRFS_DISCARD_MAX_IOPS		(10UL)
+
 static struct list_head *
 btrfs_get_discard_list(struct btrfs_discard_ctl *discard_ctl,
 		       struct btrfs_block_group_cache *cache)
@@ -170,10 +175,12 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 
 	cache = find_next_cache(discard_ctl, now);
 	if (cache) {
-		u64 delay = 0;
+		u64 delay = atomic_read(&discard_ctl->delay);
 
 		if (now < cache->discard_delay)
-			delay = nsecs_to_jiffies(cache->discard_delay - now);
+			delay = max_t(u64, delay,
+				      nsecs_to_jiffies(cache->discard_delay -
+						       now));
 
 		mod_delayed_work(discard_ctl->discard_workers,
 				 &discard_ctl->work,
@@ -232,6 +239,24 @@ static void btrfs_discard_workfn(struct work_struct *work)
 	btrfs_discard_schedule_work(discard_ctl, false);
 }
 
+void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
+{
+	s32 discard_extents = atomic_read(&discard_ctl->discard_extents);
+	s32 iops_limit;
+	unsigned long delay;
+
+	if (!discard_extents)
+		return;
+
+	iops_limit = atomic_read(&discard_ctl->iops_limit);
+	if (iops_limit)
+		iops_limit = MSEC_PER_SEC / iops_limit;
+
+	delay = BTRFS_DISCARD_TARGET_MSEC / discard_extents;
+	delay = clamp_t(s32, delay, iops_limit, BTRFS_DISCARD_MAX_DELAY);
+	atomic_set(&discard_ctl->delay, msecs_to_jiffies(delay));
+}
+
 void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_block_group_cache *cache, *next;
@@ -301,6 +326,8 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 
 	atomic_set(&discard_ctl->discard_extents, 0);
 	atomic64_set(&discard_ctl->discardable_bytes, 0);
+	atomic_set(&discard_ctl->delay, BTRFS_DISCARD_MAX_DELAY);
+	atomic_set(&discard_ctl->iops_limit, BTRFS_DISCARD_MAX_IOPS);
 }
 
 void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index d55a9a9f8ad8..acaf56f63b1c 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -7,6 +7,8 @@
 #define BTRFS_DISCARD_H
 
 #include <linux/kernel.h>
+#include <linux/jiffies.h>
+#include <linux/time.h>
 #include <linux/workqueue.h>
 
 #include "ctree.h"
@@ -39,6 +41,7 @@ void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
 			       struct btrfs_block_group_cache *cache);
 void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 				 bool override);
+void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl);
 void btrfs_discard_resume(struct btrfs_fs_info *fs_info);
 void btrfs_discard_stop(struct btrfs_fs_info *fs_info);
 void btrfs_discard_init(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ff42e4abb01d..ab0d46da3771 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2920,8 +2920,10 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
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
index a2852706ec6c..b9a62e470316 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -493,9 +493,39 @@ static ssize_t btrfs_discardable_bytes_show(struct kobject *kobj,
 }
 BTRFS_ATTR(discard, discardable_bytes, btrfs_discardable_bytes_show);
 
+static ssize_t btrfs_discard_iops_limit_show(struct kobject *kobj,
+					     struct kobj_attribute *a,
+					     char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj->parent);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			atomic_read(&fs_info->discard_ctl.iops_limit));
+}
+
+static ssize_t btrfs_discard_iops_limit_store(struct kobject *kobj,
+					      struct kobj_attribute *a,
+					      const char *buf, size_t len)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj->parent);
+	s32 iops_limit;
+	int ret;
+
+	ret = kstrtos32(buf, 10, &iops_limit);
+	if (ret || iops_limit < 0)
+		return -EINVAL;
+
+	atomic_set(&fs_info->discard_ctl.iops_limit, iops_limit);
+
+	return len;
+}
+BTRFS_ATTR_RW(discard, iops_limit, btrfs_discard_iops_limit_show,
+	      btrfs_discard_iops_limit_store);
+
 static const struct attribute *discard_attrs[] = {
 	BTRFS_ATTR_PTR(discard, discard_extents),
 	BTRFS_ATTR_PTR(discard, discardable_bytes),
+	BTRFS_ATTR_PTR(discard, iops_limit),
 	NULL,
 };
 
-- 
2.17.1

