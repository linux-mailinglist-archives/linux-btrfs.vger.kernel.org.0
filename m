Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8D3450B0
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2019 02:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfFNAeE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jun 2019 20:34:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37522 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfFNAeC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jun 2019 20:34:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id 20so466050pgr.4;
        Thu, 13 Jun 2019 17:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n3Cqzxv6aTGPD2mSNBYzcUSmQ9497Z24wwCs2a6QkSk=;
        b=SCib9XfntYcn4LcVls7DGrduqu9RTCtFqpZHTyb/qLI0lY2kANW4iijqmCQUxyknSk
         KMvulF1Ve+rXxV49s4csFqHDwf0rU6UEFdf3YJV1chwPkaWVKOG9L4sLxOj3Idl5fNMz
         I1fuswDCDx5Vi+l0RZKENjE8pGym0asVZLSrHfeu1ycoyL7cZ5xR3m6FQ1GeYrojGhvI
         BYGOVqorb4nk5XS9XZuVZ3e5V0cCSDNCZ8TNlVK9UIMO7vPoYg3x+a/bNsKuy4e/QidM
         QroIDSZkQtGCEgUy/BrHIAXTtzFYBXF7cSmnPgsZS/s3hvBZAjaE/ZViGJzBYgQA80vq
         niVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=n3Cqzxv6aTGPD2mSNBYzcUSmQ9497Z24wwCs2a6QkSk=;
        b=MZTF+e93PAwnalKd8XxtU+Ifspq/ODyHpU1Y6vzRCv6EeA5FYzphYmJ8LcL8+Ed5P7
         ZDhY3HKuReDfgxrfH+zRFbwBGUDSoHqY4RJP2Mnfq+pFKQDlhsCzmzfvp1oAzxBRlkz8
         e/b/uTS6sbQ3jdWWF/DjLv2boCoh+qEmiKTENkmrE/+EFcpi44hjKXtg02dkDyFcTxQ7
         7DxUBQUm6bTrhKAF/p7dh1A/zi7Yb24HWOAEDPtrATKLcIN67tyEEZDWbloa4BAOQxQM
         P2j2+lW3RXqezuYbpfRMvUWzborBol90yO5NjtWCDtw4iOtudSeVkNsIlWwl9OoFnTvA
         xuxw==
X-Gm-Message-State: APjAAAWeOYiJhHAbxJdfEJZu8ZOuNcgwZ+uzYnKbRI3BJEetKKZ1g8Si
        7i6SZ98V4sOmkw4wjMxyOAw=
X-Google-Smtp-Source: APXvYqwyu8WX98uWyN1Y3bw4gfznBIi9+crjgWsT1IpQAEADSMGX+rMye9WPQ0sR/VTOl4e8tvuRow==
X-Received: by 2002:a65:5685:: with SMTP id v5mr33607678pgs.184.1560472441269;
        Thu, 13 Jun 2019 17:34:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:9d14])
        by smtp.gmail.com with ESMTPSA id t5sm832075pgh.46.2019.06.13.17.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 17:34:00 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/8] blkcg: implement REQ_CGROUP_PUNT
Date:   Thu, 13 Jun 2019 17:33:45 -0700
Message-Id: <20190614003350.1178444-4-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614003350.1178444-1-tj@kernel.org>
References: <20190614003350.1178444-1-tj@kernel.org>
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
Cc: Chris Mason <clm@fb.com>
---
 block/blk-cgroup.c          | 56 +++++++++++++++++++++++++++++++++++--
 block/blk-core.c            |  3 ++
 include/linux/backing-dev.h |  1 +
 include/linux/blk-cgroup.h  | 16 ++++++++++-
 include/linux/blk_types.h   | 10 +++++++
 include/linux/writeback.h   | 13 +++++++--
 6 files changed, 92 insertions(+), 7 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 617a2b3f7582..64d80a661205 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -46,12 +46,10 @@ struct blkcg blkcg_root;
 EXPORT_SYMBOL_GPL(blkcg_root);
 
 struct cgroup_subsys_state * const blkcg_root_css = &blkcg_root.css;
-
 static struct blkcg_policy *blkcg_policy[BLKCG_MAX_POLS];
-
 static LIST_HEAD(all_blkcgs);		/* protected by blkcg_pol_mutex */
-
 static bool blkcg_debug_stats = false;
+static struct workqueue_struct *blkcg_punt_bio_wq;
 
 static bool blkcg_policy_enabled(struct request_queue *q,
 				 const struct blkcg_policy *pol)
@@ -87,6 +85,8 @@ static void __blkg_release(struct rcu_head *rcu)
 
 	percpu_ref_exit(&blkg->refcnt);
 
+	WARN_ON(!bio_list_empty(&blkg->async_bios));
+
 	/* release the blkcg and parent blkg refs this blkg has been holding */
 	css_put(&blkg->blkcg->css);
 	if (blkg->parent)
@@ -112,6 +112,23 @@ static void blkg_release(struct percpu_ref *ref)
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
@@ -137,6 +154,9 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 
 	blkg->q = q;
 	INIT_LIST_HEAD(&blkg->q_node);
+	spin_lock_init(&blkg->async_bio_lock);
+	bio_list_init(&blkg->async_bios);
+	INIT_WORK(&blkg->async_bio_work, blkg_async_bio_workfn);
 	blkg->blkcg = blkcg;
 
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
@@ -1582,6 +1602,25 @@ void blkcg_policy_unregister(struct blkcg_policy *pol)
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
@@ -1782,5 +1821,16 @@ void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta)
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
index 1c85563f035d..be602c42aab8 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -11,6 +11,7 @@
 #include <linux/flex_proportions.h>
 #include <linux/backing-dev-defs.h>
 #include <linux/blk_types.h>
+#include <linux/blk-cgroup.h>
 
 struct bio;
 
@@ -69,6 +70,7 @@ struct writeback_control {
 	unsigned range_cyclic:1;	/* range_start is cyclic */
 	unsigned for_sync:1;		/* sync(2) WB_SYNC_ALL writeback */
 	unsigned no_wbc_acct:1;		/* skip wbc IO accounting */
+	unsigned punt_to_cgroup:1;	/* cgrp punting, see __REQ_CGROUP_PUNT */
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct bdi_writeback *wb;	/* wb this writeback is issued under */
 	struct inode *inode;		/* inode being written out */
@@ -85,12 +87,17 @@ struct writeback_control {
 
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

