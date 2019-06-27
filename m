Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 505D858BDC
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2019 22:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfF0UkM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jun 2019 16:40:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39475 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfF0UkM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jun 2019 16:40:12 -0400
Received: by mail-qt1-f193.google.com with SMTP id i34so3979365qta.6;
        Thu, 27 Jun 2019 13:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=asaU2u3+qE2V/tXvNuPV0itByGZXwrnNGauZ3AE0x8Q=;
        b=mWIjFi6ksn5M294UtD6OzjBoCcGAe+stAI7ZEU++C0SLPFQDR1HBVYjwQJCYLPaUlL
         wgPZe4orHMigt/L29ffRXdcLiUyd+1zty+hko8XcOLFP85nKpVkRPaPWPYiDj5H7iqgx
         pC5XDK6I0MHokMJ5E9gVGffJBBFLXPtPkpPIgs3jRXt/bDf2pgkCQzNKfnoO9D+ag2Ph
         jybYItkKi6WJHM/vxAeDgtZ3bh0bYcGRZ1anuBwPj2iQLxLyDoXSINEpVF/8d5j1QYSq
         cU7qp5tB9tLDjlvEdqwP04/TIf4lVNRgweY1tu98OiJaJnAyqchLjGCv4bqCEnCvy01F
         838A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=asaU2u3+qE2V/tXvNuPV0itByGZXwrnNGauZ3AE0x8Q=;
        b=j7IFaXETdf2cwn7kxQM9KmimTzNeWAc7LvlM9Vb2VFRIsVN/pVzMPaUrU7Px2ah0f2
         3KgHkbXIgyI3BbDPOYD2hzyQixjjj15BTzuAEmABLLDCbJVN9ZYjcmfol9Zn3W0P329E
         OM0IjqWAAvN2qyv6HZt8YuLgTl+sjTwhA5NxE9X4mTvGFD03gJpMoCGesrnA2hxYOD8D
         v6f4YTh47YLb2KLf9ufG414nks/4z+46fO8HOqeLgmdNqk2lRHOmmf1OKO0Rdnm56Yhe
         RkslnWIhlSgRLxVe5YXVCKZ6poHlUWJYrQ8N47Dur09o7cN0F5rtwwRO0I5H8gxo0xu/
         N1xw==
X-Gm-Message-State: APjAAAUQi4I4wF8bygQwmwed4ldiLJ3vxJQcEl+MCm9jFx4KhHaqHrnC
        KQ5cL2v3KyRbJlsTgHFoznk=
X-Google-Smtp-Source: APXvYqxEisVOKnA5w+z3iVn+487JJc2VnADsPPw/D/sgNAIpFIMI0h6sXlh2IuEY4rPXtLOql2AbEA==
X-Received: by 2002:a0c:93a3:: with SMTP id f32mr5198677qvf.14.1561668010735;
        Thu, 27 Jun 2019 13:40:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::5a51])
        by smtp.gmail.com with ESMTPSA id h18sm60802qkj.134.2019.06.27.13.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 13:40:10 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     jack@suse.cz, josef@toxicpanda.com, clm@fb.com, dsterba@suse.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/5] blkcg: implement REQ_CGROUP_PUNT
Date:   Thu, 27 Jun 2019 13:39:52 -0700
Message-Id: <20190627203952.386785-6-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190627203952.386785-1-tj@kernel.org>
References: <20190627203952.386785-1-tj@kernel.org>
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
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Chris Mason <clm@fb.com>
---
 block/blk-cgroup.c          | 53 +++++++++++++++++++++++++++++++++++++
 block/blk-core.c            |  3 +++
 include/linux/backing-dev.h |  1 +
 include/linux/blk-cgroup.h  | 16 ++++++++++-
 include/linux/blk_types.h   | 10 +++++++
 include/linux/writeback.h   | 13 ++++++---
 6 files changed, 92 insertions(+), 4 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3319ab4ff262..921a3ef329aa 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -54,6 +54,7 @@ static struct blkcg_policy *blkcg_policy[BLKCG_MAX_POLS];
 static LIST_HEAD(all_blkcgs);		/* protected by blkcg_pol_mutex */
 
 static bool blkcg_debug_stats = false;
+static struct workqueue_struct *blkcg_punt_bio_wq;
 
 static bool blkcg_policy_enabled(struct request_queue *q,
 				 const struct blkcg_policy *pol)
@@ -88,6 +89,8 @@ static void __blkg_release(struct rcu_head *rcu)
 {
 	struct blkcg_gq *blkg = container_of(rcu, struct blkcg_gq, rcu_head);
 
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
@@ -141,6 +161,9 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 
 	blkg->q = q;
 	INIT_LIST_HEAD(&blkg->q_node);
+	spin_lock_init(&blkg->async_bio_lock);
+	bio_list_init(&blkg->async_bios);
+	INIT_WORK(&blkg->async_bio_work, blkg_async_bio_workfn);
 	blkg->blkcg = blkcg;
 
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
@@ -1527,6 +1550,25 @@ void blkcg_policy_unregister(struct blkcg_policy *pol)
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
@@ -1727,5 +1769,16 @@ void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta)
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
index 5d1fc8e17dd1..812052c835fc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1127,6 +1127,9 @@ EXPORT_SYMBOL_GPL(direct_make_request);
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
index 33f23a858438..689a58231288 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -132,13 +132,17 @@ struct blkcg_gq {
 
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
@@ -701,6 +705,15 @@ static inline bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg
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
@@ -848,6 +861,7 @@ static inline char *blkg_path(struct blkcg_gq *blkg) { return NULL; }
 static inline void blkg_get(struct blkcg_gq *blkg) { }
 static inline void blkg_put(struct blkcg_gq *blkg) { }
 
+static inline bool blkcg_punt_bio_submit(struct bio *bio) { return false; }
 static inline void blkcg_bio_issue_init(struct bio *bio) { }
 static inline bool blkcg_bio_issue_check(struct request_queue *q,
 					 struct bio *bio) { return true; }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 6a53799c3fe2..feff3fe4467e 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -311,6 +311,14 @@ enum req_flag_bits {
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
@@ -337,6 +345,8 @@ enum req_flag_bits {
 #define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
 #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
 #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
+#define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
+
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
 #define REQ_HIPRI		(1ULL << __REQ_HIPRI)
 
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index e056a22075cf..8945aac31392 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -78,6 +78,8 @@ struct writeback_control {
 	 */
 	unsigned no_cgroup_owner:1;
 
+	unsigned punt_to_cgroup:1;	/* cgrp punting, see __REQ_CGROUP_PUNT */
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct bdi_writeback *wb;	/* wb this writeback is issued under */
 	struct inode *inode;		/* inode being written out */
@@ -94,12 +96,17 @@ struct writeback_control {
 
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

