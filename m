Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B678C471AA
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jun 2019 20:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfFOSZP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jun 2019 14:25:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35386 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfFOSZO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jun 2019 14:25:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id d23so6372238qto.2;
        Sat, 15 Jun 2019 11:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3gUlErPb54sHgERuHjLiYsVshuw0uLtH/4nFqCCKsLw=;
        b=UxrapmyZh0lqq8LkK6li6+LW2vRLaEnbzYVXhx4e+CL8muZo7ZwTcx4V7FrS12oI6e
         ehNVwzyCRpAjeIfzYI5NCkoskEnrBizCRFDXwDntl6/wPLwfXFhwzaER8wasIH58h/tO
         bChxCGMLVJKlOIHB6p0TxNKHAf9navOQrr5w31ThlaS8HlmqYKAX7cYTD7xV5NEz8hqg
         SWT0v6TO7qZ8ZzwY8MIyxe03njU3GpngLlr3yw5l17ZFNl2taNzwqm/Y6i45ub+Ov8UB
         gKGePRfyJ+mRZdrdx6u4Yg360t9XVTSY15EEOOiO+EtcvXcGT0G+AVB68AonLBbbYqCq
         h/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=3gUlErPb54sHgERuHjLiYsVshuw0uLtH/4nFqCCKsLw=;
        b=ZokJLgmVYr6QVYaC5heRj9Ekx32M4dsZ+/sxV+GPoaOCQo8KdIQXOC9VQE8KcNRh7J
         Scj1coi3/Fj0MFSHIe7xP/Nk7NHNBaV74NfwcCGgACvN5HBFms4KJZMFt9HsiDOltxV5
         F7d4NPMuMk3MRvBIsL3IGCgxZDvuFqKpjaJrQXAIZ5o80zmC1wRSEd8NoyrIjOtbdp46
         XU8/GP01muNqvCr16HJUdM5RGh5ftDs/Tt13tcIslWPI/8A/rcUAnOgV0el8DJwkKePC
         OMGRmV+aNsezcwpk2YU6dj0QUH+Iys9RipI0reKD/wwAAThKyaU/rXvTzK0FI+7ndhdu
         Pejg==
X-Gm-Message-State: APjAAAXwPk5jdN3wj6X+2tth+NcQoYH8qoK/uGHlsMgnkJgZHb2XHYrN
        eu5JRteE42xHb5xmMhR1OdM=
X-Google-Smtp-Source: APXvYqyM9/s6TwD7Ab3f2m2xIMZjb7wiSj685X/0KO1fCEa04MNyg7afUcXoRc8vSvI4djF32xVaGg==
X-Received: by 2002:a0c:b902:: with SMTP id u2mr14101419qvf.151.1560623112865;
        Sat, 15 Jun 2019 11:25:12 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4883])
        by smtp.gmail.com with ESMTPSA id r40sm3923177qtr.57.2019.06.15.11.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 11:25:12 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/9] blkcg: implement REQ_CGROUP_PUNT
Date:   Sat, 15 Jun 2019 11:24:48 -0700
Message-Id: <20190615182453.843275-5-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190615182453.843275-1-tj@kernel.org>
References: <20190615182453.843275-1-tj@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When a shared kthread needs to issue a bio for a cgroup, doing so
synchronously can lead to priority inversions as the kthread can be
trapped waiting for that cgroup.  This patch implements
REQ_CGROUP_PUNT flag which makes submit_bio() punt the actual issuing
to a dedicated per-blkcg work item to avoid such priority inversions.

This will be used to fix priority inversions in btrfs compression and
should be generally useful as we grow filesystem support for
comprehensive IO control.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Cc: Chris Mason <clm@fb.com>
---
 block/blk-cgroup.c          | 53 +++++++++++++++++++++++++++++++++++++
 block/blk-core.c            |  3 +++
 include/linux/backing-dev.h |  1 +
 include/linux/blk-cgroup.h  | 16 ++++++++++-
 include/linux/blk_types.h   | 10 +++++++
 include/linux/writeback.h   | 12 ++++++---
 6 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 07600d3c9520..48239bb93fbe 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -53,6 +53,7 @@ static struct blkcg_policy *blkcg_policy[BLKCG_MAX_POLS];
 static LIST_HEAD(all_blkcgs);		/* protected by blkcg_pol_mutex */
 
 static bool blkcg_debug_stats = false;
+static struct workqueue_struct *blkcg_punt_bio_wq;
 
 static bool blkcg_policy_enabled(struct request_queue *q,
 				 const struct blkcg_policy *pol)
@@ -88,6 +89,8 @@ static void __blkg_release(struct rcu_head *rcu)
 
 	percpu_ref_exit(&blkg->refcnt);
 
+	WARN_ON(!bio_list_empty(&blkg->async_bios));
+
 	/* release the blkcg and parent blkg refs this blkg has been holding */
 	css_put(&blkg->blkcg->css);
 	if (blkg->parent)
@@ -113,6 +116,23 @@ static void blkg_release(struct percpu_ref *ref)
 	call_rcu(&blkg->rcu_head, __blkg_release);
 }
 
+static void blkg_async_bio_workfn(struct work_struct *work)
+{
+	struct blkcg_gq *blkg = container_of(work, struct blkcg_gq,
+					     async_bio_work);
+	struct bio_list bios = BIO_EMPTY_LIST;
+	struct bio *bio;
+
+	/* as long as there are pending bios, @blkg can't go away */
+	spin_lock_bh(&blkg->async_bio_lock);
+	bio_list_merge(&bios, &blkg->async_bios);
+	bio_list_init(&blkg->async_bios);
+	spin_unlock_bh(&blkg->async_bio_lock);
+
+	while ((bio = bio_list_pop(&bios)))
+		submit_bio(bio);
+}
+
 /**
  * blkg_alloc - allocate a blkg
  * @blkcg: block cgroup the new blkg is associated with
@@ -138,6 +158,9 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 
 	blkg->q = q;
 	INIT_LIST_HEAD(&blkg->q_node);
+	spin_lock_init(&blkg->async_bio_lock);
+	bio_list_init(&blkg->async_bios);
+	INIT_WORK(&blkg->async_bio_work, blkg_async_bio_workfn);
 	blkg->blkcg = blkcg;
 
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
@@ -1583,6 +1606,25 @@ void blkcg_policy_unregister(struct blkcg_policy *pol)
 }
 EXPORT_SYMBOL_GPL(blkcg_policy_unregister);
 
+bool __blkcg_punt_bio_submit(struct bio *bio)
+{
+	struct blkcg_gq *blkg = bio->bi_blkg;
+
+	/* consume the flag first */
+	bio->bi_opf &= ~REQ_CGROUP_PUNT;
+
+	/* never bounce for the root cgroup */
+	if (!blkg->parent)
+		return false;
+
+	spin_lock_bh(&blkg->async_bio_lock);
+	bio_list_add(&blkg->async_bios, bio);
+	spin_unlock_bh(&blkg->async_bio_lock);
+
+	queue_work(blkcg_punt_bio_wq, &blkg->async_bio_work);
+	return true;
+}
+
 /*
  * Scale the accumulated delay based on how long it has been since we updated
  * the delay.  We only call this when we are adding delay, in case it's been a
@@ -1783,5 +1825,16 @@ void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta)
 	atomic64_add(delta, &blkg->delay_nsec);
 }
 
+static int __init blkcg_init(void)
+{
+	blkcg_punt_bio_wq = alloc_workqueue("blkcg_punt_bio",
+					    WQ_MEM_RECLAIM | WQ_FREEZABLE |
+					    WQ_UNBOUND | WQ_SYSFS, 0);
+	if (!blkcg_punt_bio_wq)
+		return -ENOMEM;
+	return 0;
+}
+subsys_initcall(blkcg_init);
+
 module_param(blkcg_debug_stats, bool, 0644);
 MODULE_PARM_DESC(blkcg_debug_stats, "True if you want debug stats, false if not");
diff --git a/block/blk-core.c b/block/blk-core.c
index a55389ba8779..5879c1ec044d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1165,6 +1165,9 @@ EXPORT_SYMBOL_GPL(direct_make_request);
  */
 blk_qc_t submit_bio(struct bio *bio)
 {
+	if (blkcg_punt_bio_submit(bio))
+		return BLK_QC_T_NONE;
+
 	/*
 	 * If it's a regular read/write or a barrier with data attached,
 	 * go through the normal accounting stuff before submission.
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index f9b029180241..35b31d176f74 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -48,6 +48,7 @@ extern spinlock_t bdi_lock;
 extern struct list_head bdi_list;
 
 extern struct workqueue_struct *bdi_wq;
+extern struct workqueue_struct *bdi_async_bio_wq;
 
 static inline bool wb_has_dirty_io(struct bdi_writeback *wb)
 {
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 76c61318fda5..ffb2f88e87c6 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -134,13 +134,17 @@ struct blkcg_gq {
 
 	struct blkg_policy_data		*pd[BLKCG_MAX_POLS];
 
-	struct rcu_head			rcu_head;
+	spinlock_t			async_bio_lock;
+	struct bio_list			async_bios;
+	struct work_struct		async_bio_work;
 
 	atomic_t			use_delay;
 	atomic64_t			delay_nsec;
 	atomic64_t			delay_start;
 	u64				last_delay;
 	int				last_use;
+
+	struct rcu_head			rcu_head;
 };
 
 typedef struct blkcg_policy_data *(blkcg_pol_alloc_cpd_fn)(gfp_t gfp);
@@ -763,6 +767,15 @@ static inline bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg
 				  struct bio *bio) { return false; }
 #endif
 
+bool __blkcg_punt_bio_submit(struct bio *bio);
+
+static inline bool blkcg_punt_bio_submit(struct bio *bio)
+{
+	if (bio->bi_opf & REQ_CGROUP_PUNT)
+		return __blkcg_punt_bio_submit(bio);
+	else
+		return false;
+}
 
 static inline void blkcg_bio_issue_init(struct bio *bio)
 {
@@ -910,6 +923,7 @@ static inline char *blkg_path(struct blkcg_gq *blkg) { return NULL; }
 static inline void blkg_get(struct blkcg_gq *blkg) { }
 static inline void blkg_put(struct blkcg_gq *blkg) { }
 
+static inline bool blkcg_punt_bio_submit(struct bio *bio) { return false; }
 static inline void blkcg_bio_issue_init(struct bio *bio) { }
 static inline bool blkcg_bio_issue_check(struct request_queue *q,
 					 struct bio *bio) { return true; }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 791fee35df88..e8b42a786315 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -321,6 +321,14 @@ enum req_flag_bits {
 	__REQ_RAHEAD,		/* read ahead, can fail anytime */
 	__REQ_BACKGROUND,	/* background IO */
 	__REQ_NOWAIT,           /* Don't wait if request will block */
+	/*
+	 * When a shared kthread needs to issue a bio for a cgroup, doing
+	 * so synchronously can lead to priority inversions as the kthread
+	 * can be trapped waiting for that cgroup.  CGROUP_PUNT flag makes
+	 * submit_bio() punt the actual issuing to a dedicated per-blkcg
+	 * work item to avoid such priority inversions.
+	 */
+	__REQ_CGROUP_PUNT,
 
 	/* command specific flags for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
@@ -347,6 +355,8 @@ enum req_flag_bits {
 #define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
 #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
 #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
+#define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
+
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
 #define REQ_HIPRI		(1ULL << __REQ_HIPRI)
 
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 800ee031e88a..be602c42aab8 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -70,6 +70,7 @@ struct writeback_control {
 	unsigned range_cyclic:1;	/* range_start is cyclic */
 	unsigned for_sync:1;		/* sync(2) WB_SYNC_ALL writeback */
 	unsigned no_wbc_acct:1;		/* skip wbc IO accounting */
+	unsigned punt_to_cgroup:1;	/* cgrp punting, see __REQ_CGROUP_PUNT */
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct bdi_writeback *wb;	/* wb this writeback is issued under */
 	struct inode *inode;		/* inode being written out */
@@ -86,12 +87,17 @@ struct writeback_control {
 
 static inline int wbc_to_write_flags(struct writeback_control *wbc)
 {
+	int flags = 0;
+
+	if (wbc->punt_to_cgroup)
+		flags = REQ_CGROUP_PUNT;
+
 	if (wbc->sync_mode == WB_SYNC_ALL)
-		return REQ_SYNC;
+		flags |= REQ_SYNC;
 	else if (wbc->for_kupdate || wbc->for_background)
-		return REQ_BACKGROUND;
+		flags |= REQ_BACKGROUND;
 
-	return 0;
+	return flags;
 }
 
 static inline struct cgroup_subsys_state *
-- 
2.17.1

