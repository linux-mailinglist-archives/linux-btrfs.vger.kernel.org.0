Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93CB711AB1
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 01:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbjEYXdN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 19:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjEYXdM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 19:33:12 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32316A3;
        Thu, 25 May 2023 16:33:11 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d5f65a2f7so246379b3a.1;
        Thu, 25 May 2023 16:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685057590; x=1687649590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xPl3/laWv+IxFXli3Bvh5EQ3da7eDYESqBUISQ6ysA=;
        b=jKBDZ3fXBB5VJqCyyXLV8AeYFB1n8aaPEpVZmyFSZuoar9Tr0ClFloosiIFlXkfpwW
         TpfVckn2ZBO7wGIoZ+Cxi5r/PC+8JamBGik7BJ3ilYk64CJKjnXiCGDMJbKg5fdGeEu+
         ct6bv40cQozeC9jsA9fO/ESIbsZlaCPY0hG0wpAzcFU5+2ld7GyA9TD7WvVOAPz8z7FC
         5DqqIfaZAyvK/2od9kQWlZekFUZpCSesmkFK9tuHK81+4a23SP9e3i35UBLaij+0xxsI
         7fZbE2pxxlA/stB+Z1N/e1bgbAQ7S8FVYXjX893X4KS+NnOzH0OzYhl5LUOHRP/YOCrc
         RF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685057590; x=1687649590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xPl3/laWv+IxFXli3Bvh5EQ3da7eDYESqBUISQ6ysA=;
        b=AthSnuPyVBsqCGgBpuCxkOHg83fzZ7lIhRN3W+xwEKvZWxbTrVH/XIcyWn9IABkFgW
         hz1EQjFtMUZk9dX50KTg0NEGZ3hpvWgS0FmNNyA2QiJRpaLYhE18hpmf6R6vFHw9oSfK
         MUQ9J9ebhzJ87wtMICxDWhG6xshU+tSF4m2cAy9q6+L1cLFZ6d0gcrkGmNfTQUkZrcxs
         kmr0MRWV0ZbNZf+9W5e2vbIHZVlD2APxGB+B+Gd3ItnfPgKl4EkTZJ6crqz2sLToahQU
         3guKBEzSVlg/N1Uj4FuVesbJuYUzcMLOy6ZAv4l0QSORtr16c/O1o28vG0V2c4UW+zpD
         VQSA==
X-Gm-Message-State: AC+VfDyUYfmaJI5zIv1r4PZ89Rjs0+qjH4tp5U/sBFbYj8s7z4CzXxIn
        bfNVr22BkRYpNlYrd0LfD+I=
X-Google-Smtp-Source: ACHHUZ7dpPBS0j1WZiyNOTuliAueajo8SiczUUmNvh0xxpE+kugVUxRvSyvogbmBNMabnH5XW/Fhqg==
X-Received: by 2002:a05:6a00:2e27:b0:64a:7723:fe04 with SMTP id fc39-20020a056a002e2700b0064a7723fe04mr735304pfb.4.1685057590340;
        Thu, 25 May 2023 16:33:10 -0700 (PDT)
Received: from localhost ([2600:380:b551:e8fe:da52:61ec:2b97:ae7f])
        by smtp.gmail.com with ESMTPSA id x1-20020a62fb01000000b0062dedfd3d73sm1663497pfm.95.2023.05.25.16.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 16:33:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 25 May 2023 13:33:08 -1000
From:   Tejun Heo <tj@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Wang Yugui <wangyugui@e16-tech.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 08/13] btrfs: Use alloc_ordered_workqueue() to create ordered
 workqueues
Message-ID: <ZG_wNJc_vGExt7m3@slm.duckdns.org>
References: <20230509015032.3768622-1-tj@kernel.org>
 <20230509015032.3768622-9-tj@kernel.org>
 <20230509145332.GA32559@twin.jikos.cz>
 <ZFptXG44WVoWE0s4@slm.duckdns.org>
 <20230509233620.GN32559@twin.jikos.cz>
 <ZFrbiAyCiZ2aIZ4_@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFrbiAyCiZ2aIZ4_@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

BACKGROUND
==========

When multiple work items are queued to a workqueue, their execution order
doesn't match the queueing order. They may get executed in any order and
simultaneously. When fully serialized execution - one by one in the queueing
order - is needed, an ordered workqueue should be used which can be created
with alloc_ordered_workqueue().

However, alloc_ordered_workqueue() was a later addition. Before it, an
ordered workqueue could be obtained by creating an UNBOUND workqueue with
@max_active==1. This originally was an implementation side-effect which was
broken by 4c16bd327c74 ("workqueue: restore WQ_UNBOUND/max_active==1 to be
ordered"). Because there were users that depended on the ordered execution,
5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
made workqueue allocation path to implicitly promote UNBOUND workqueues w/
@max_active==1 to ordered workqueues.

While this has worked okay, overloading the UNBOUND allocation interface
this way creates other issues. It's difficult to tell whether a given
workqueue actually needs to be ordered and users that legitimately want a
min concurrency level wq unexpectedly gets an ordered one instead. With
planned UNBOUND workqueue updates to improve execution locality and more
prevalence of chiplet designs which can benefit from such improvements, this
isn't a state we wanna be in forever.

This patch series audits all callsites that create an UNBOUND workqueue w/
@max_active==1 and converts them to alloc_ordered_workqueue() as necessary.

BTRFS
=====

* fs_info->scrub_workers initialized in scrub_workers_get() was setting
  @max_active to 1 when @is_dev_replace is set and it seems that the
  workqueue actually needs to be ordered if @is_dev_replace. Update the code
  so that alloc_ordered_workqueue() is used if @is_dev_replace.

* fs_info->discard_ctl.discard_workers initialized in
  btrfs_init_workqueues() was directly using alloc_workqueue() w/
  @max_active==1. Converted to alloc_ordered_workqueue().

* fs_info->fixup_workers and fs_info->qgroup_rescan_workers initialized in
  btrfs_queue_work() use the btrfs's workqueue wrapper, btrfs_workqueue,
  which are allocated with btrfs_alloc_workqueue().

  btrfs_workqueue implements automatic @max_active adjustment which is
  disabled when the specified max limix is below a certain threshold, so
  calling btrfs_alloc_workqueue() with @limit_active==1 yields an ordered
  workqueue whose @max_active won't be changed as the auto-tuning is
  disabled.

  This is rather brittle in that nothing clearly indicates that the two
  workqueues should be ordered or btrfs_alloc_workqueue() must disable
  auto-tuning when @limit_active==1.

  This patch factors out the common btrfs_workqueue init code into
  btrfs_init_workqueue() and add explicit btrfs_alloc_ordered_workqueue().
  The two workqueues are converted to use the new ordered allocation
  interface.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Wang Yugui <wangyugui@e16-tech.com>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
---
Hello,

David, I think this is a bit too invasive to carry through workqueue tree.
If this looks okay, can you plase apply route it through the btrfs tree?

Thanks.

 fs/btrfs/async-thread.c |   43 ++++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/async-thread.h |    3 +++
 fs/btrfs/disk-io.c      |    8 +++++---
 fs/btrfs/scrub.c        |    6 ++++--
 4 files changed, 50 insertions(+), 10 deletions(-)

--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -71,6 +71,16 @@ bool btrfs_workqueue_normal_congested(co
 	return atomic_read(&wq->pending) > wq->thresh * 2;
 }
 
+static void btrfs_init_workqueue(struct btrfs_workqueue *wq,
+				 struct btrfs_fs_info *fs_info)
+{
+	wq->fs_info = fs_info;
+	atomic_set(&wq->pending, 0);
+	INIT_LIST_HEAD(&wq->ordered_list);
+	spin_lock_init(&wq->list_lock);
+	spin_lock_init(&wq->thres_lock);
+}
+
 struct btrfs_workqueue *btrfs_alloc_workqueue(struct btrfs_fs_info *fs_info,
 					      const char *name, unsigned int flags,
 					      int limit_active, int thresh)
@@ -80,9 +90,9 @@ struct btrfs_workqueue *btrfs_alloc_work
 	if (!ret)
 		return NULL;
 
-	ret->fs_info = fs_info;
+	btrfs_init_workqueue(ret, fs_info);
+
 	ret->limit_active = limit_active;
-	atomic_set(&ret->pending, 0);
 	if (thresh == 0)
 		thresh = DFT_THRESHOLD;
 	/* For low threshold, disabling threshold is a better choice */
@@ -106,9 +116,32 @@ struct btrfs_workqueue *btrfs_alloc_work
 		return NULL;
 	}
 
-	INIT_LIST_HEAD(&ret->ordered_list);
-	spin_lock_init(&ret->list_lock);
-	spin_lock_init(&ret->thres_lock);
+	trace_btrfs_workqueue_alloc(ret, name);
+	return ret;
+}
+
+struct btrfs_workqueue *btrfs_alloc_ordered_workqueue(
+				struct btrfs_fs_info *fs_info, const char *name,
+				unsigned int flags)
+{
+	struct btrfs_workqueue *ret = kzalloc(sizeof(*ret), GFP_KERNEL);
+
+	if (!ret)
+		return NULL;
+
+	btrfs_init_workqueue(ret, fs_info);
+
+	/* ordered workqueues don't allow @max_active adjustments */
+	ret->limit_active = 1;
+	ret->current_active = 1;
+	ret->thresh = NO_THRESHOLD;
+
+	ret->normal_wq = alloc_ordered_workqueue("btrfs-%s", flags, name);
+	if (!ret->normal_wq) {
+		kfree(ret);
+		return NULL;
+	}
+
 	trace_btrfs_workqueue_alloc(ret, name);
 	return ret;
 }
--- a/fs/btrfs/async-thread.h
+++ b/fs/btrfs/async-thread.h
@@ -31,6 +31,9 @@ struct btrfs_workqueue *btrfs_alloc_work
 					      unsigned int flags,
 					      int limit_active,
 					      int thresh);
+struct btrfs_workqueue *btrfs_alloc_ordered_workqueue(
+				struct btrfs_fs_info *fs_info, const char *name,
+				unsigned int flags);
 void btrfs_init_work(struct btrfs_work *work, btrfs_func_t func,
 		     btrfs_func_t ordered_func, btrfs_func_t ordered_free);
 void btrfs_queue_work(struct btrfs_workqueue *wq,
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2177,6 +2177,7 @@ static int btrfs_init_workqueues(struct
 {
 	u32 max_active = fs_info->thread_pool_size;
 	unsigned int flags = WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_UNBOUND;
+	unsigned int ordered_flags = WQ_MEM_RECLAIM | WQ_FREEZABLE;
 
 	fs_info->workers =
 		btrfs_alloc_workqueue(fs_info, "worker", flags, max_active, 16);
@@ -2196,7 +2197,7 @@ static int btrfs_init_workqueues(struct
 		btrfs_alloc_workqueue(fs_info, "cache", flags, max_active, 0);
 
 	fs_info->fixup_workers =
-		btrfs_alloc_workqueue(fs_info, "fixup", flags, 1, 0);
+		btrfs_alloc_ordered_workqueue(fs_info, "fixup", ordered_flags);
 
 	fs_info->endio_workers =
 		alloc_workqueue("btrfs-endio", flags, max_active);
@@ -2215,9 +2216,10 @@ static int btrfs_init_workqueues(struct
 		btrfs_alloc_workqueue(fs_info, "delayed-meta", flags,
 				      max_active, 0);
 	fs_info->qgroup_rescan_workers =
-		btrfs_alloc_workqueue(fs_info, "qgroup-rescan", flags, 1, 0);
+		btrfs_alloc_ordered_workqueue(fs_info, "qgroup-rescan",
+					      ordered_flags);
 	fs_info->discard_ctl.discard_workers =
-		alloc_workqueue("btrfs_discard", WQ_UNBOUND | WQ_FREEZABLE, 1);
+		alloc_ordered_workqueue("btrfs_discard", WQ_FREEZABLE);
 
 	if (!(fs_info->workers && fs_info->hipri_workers &&
 	      fs_info->delalloc_workers && fs_info->flush_workers &&
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2734,8 +2734,10 @@ static noinline_for_stack int scrub_work
 	if (refcount_inc_not_zero(&fs_info->scrub_workers_refcnt))
 		return 0;
 
-	scrub_workers = alloc_workqueue("btrfs-scrub", flags,
-					is_dev_replace ? 1 : max_active);
+	if (is_dev_replace)
+		scrub_workers = alloc_ordered_workqueue("btrfs-scrub", flags);
+	else
+		scrub_workers = alloc_workqueue("btrfs-scrub", flags, max_active);
 	if (!scrub_workers)
 		goto fail_scrub_workers;
 
