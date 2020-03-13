Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF101850F9
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgCMVXs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:23:48 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:47069 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgCMVXr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:23:47 -0400
Received: by mail-qv1-f67.google.com with SMTP id m2so5427546qvu.13
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=E9U+xgn5czXQyvzyURrX/5bDLXkRhM0W1GkFT8WXhPQ=;
        b=uPHF1q5ciyP4tEbik2i3C40TA5Z//J3bH1YFbWDZwBUnQBlg4nyqYNmtWRmMjCQOvM
         1Bh81JO13eFGnGIvQBc1XIJFRDhkHq/jC7KPd/7OUg0nzys0p9XTYOWQHFd3nJCIbBOl
         GNLNHjRmoRTtSirz7uWZMFKESQcj2+bd3xeMFaszVHWqTQ8koAnfuSYLWcddX1/N1yE9
         PlP5JUwmDvRLmWnXPeelh3Iex57mmAA9MRNQqKXqQjqpHmHMZY4DsISZP4AfLeE8q+yT
         5EpE0CXlUQi08b48wOJSCjYTGVTgM4M4tmto8yPi/EYnYDXqzRoSq+ucd96k5OCJ6uG3
         NgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E9U+xgn5czXQyvzyURrX/5bDLXkRhM0W1GkFT8WXhPQ=;
        b=JLOs9KgDxr2GkN8IhMOK7E53s0zJkgu3ohleoAasVPStcWOnbkcfT0ReCgy0EGOnDn
         8OoaeIYDzuCgCKoNnM4QZg2R7dV2N2Brm6k/TQy+bCGGx3zgnKwWKiLpiD8wCPBGsQzu
         9O1wGMuw63qJtXqvNdoLK6Q0revTznYLADfG82zYBz49qBBirf7NdQAM5jz+DCWbIKaO
         FrEKp3mQgnsuIoY05Vpvr9A700HVfeMaFgzMAAfevQfJat88TbW1dQFkGrFRbjdBIhck
         JfKaQvEZxQzifnWKbojN7FDBBcf8U9MLXeqGqgu3FBAvRVukAVtt/8pOYXpCgDfumt9M
         vRPQ==
X-Gm-Message-State: ANhLgQ2NiclpN3F/6M6GqF6suo6hq7mjpl5urmxSdnc+apVsqkPaZ31d
        hsANX/VPJicHhNXTorqmBEdPTvcc1z7wAw==
X-Google-Smtp-Source: ADFU+vs6B3ZikGXSv9VdDmR8kWPxQbRxhRhMzgBEVgP+JkkAHNtlrJewiYomZa7+iTqqoYVb86tb2Q==
X-Received: by 2002:ad4:498c:: with SMTP id t12mr14605176qvx.27.1584134624931;
        Fri, 13 Mar 2020 14:23:44 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h138sm1400031qke.86.2020.03.13.14.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:23:44 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/13] btrfs: kick off async delayed ref flushing if we are over time budget
Date:   Fri, 13 Mar 2020 17:23:24 -0400
Message-Id: <20200313212330.149024-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313212330.149024-1-josef@toxicpanda.com>
References: <20200313212330.149024-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For very large file systems we cannot rely on the space reservation
system to provide enough pressure to flush delayed refs in a timely
manner.  We have the infrastructure in place to keep track of how much
theoretical time it'll take to run our outstanding delayed refs, but
unfortunately I ripped all of that out when I added the delayed refs
rsv.  This code originally was added to address the problem of too many
delayed refs building up and thus causing transaction commits to take
several minutes to finish.

Fix this by adding back the ability to flush delayed refs based on the
time budget for them.  We want to limit to around 1 seconds worth of
delayed refs to be pending at any given time.  In order to keep up with
demand we will start the async flusher once we are at the 500ms mark,
and the async flusher will attempt to keep us in this ballpark.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       |  4 ++++
 fs/btrfs/disk-io.c     |  3 +++
 fs/btrfs/extent-tree.c | 44 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/transaction.c |  8 ++++++++
 4 files changed, 59 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 992ce47977b8..2a6b2938f9ea 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -494,6 +494,7 @@ enum btrfs_orphan_cleanup_state {
 };
 
 void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
+void btrfs_init_async_delayed_ref_work(struct btrfs_fs_info *fs_info);
 
 /* fs_info */
 struct reloc_control;
@@ -924,6 +925,9 @@ struct btrfs_fs_info {
 	struct work_struct async_reclaim_work;
 	struct work_struct async_data_reclaim_work;
 
+	/* Used to run delayed refs in the background. */
+	struct work_struct async_delayed_ref_work;
+
 	spinlock_t unused_bgs_lock;
 	struct list_head unused_bgs;
 	struct mutex unused_bg_unpin_mutex;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b5846552666e..b1a9fe5a639a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2754,6 +2754,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 #endif
 	btrfs_init_balance(fs_info);
 	btrfs_init_async_reclaim_work(fs_info);
+	btrfs_init_async_delayed_ref_work(fs_info);
 
 	spin_lock_init(&fs_info->block_group_cache_lock);
 	fs_info->block_group_cache_tree = RB_ROOT;
@@ -3997,6 +3998,8 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	 */
 	kthread_park(fs_info->cleaner_kthread);
 
+	cancel_work_sync(&fs_info->async_delayed_ref_work);
+
 	/* wait for the qgroup rescan worker to stop */
 	btrfs_qgroup_wait_for_completion(fs_info, false);
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 645ae95f465e..0e81990b57e0 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2249,6 +2249,50 @@ int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
+static void btrfs_async_run_delayed_refs(struct work_struct *work)
+{
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_trans_handle *trans;
+
+	fs_info = container_of(work, struct btrfs_fs_info,
+			       async_delayed_ref_work);
+
+	while (!btrfs_fs_closing(fs_info)) {
+		unsigned long count;
+		int ret;
+
+		trans = btrfs_attach_transaction(fs_info->extent_root);
+		if (IS_ERR(trans))
+			break;
+
+		smp_rmb();
+		if (trans->transaction->delayed_refs.flushing) {
+			btrfs_end_transaction(trans);
+			break;
+		}
+
+		/* No longer over our threshold, lets bail. */
+		if (!btrfs_should_throttle_delayed_refs(trans, true)) {
+			btrfs_end_transaction(trans);
+			break;
+		}
+
+		count = atomic_read(&trans->transaction->delayed_refs.num_entries);
+		count >>= 2;
+
+		ret = btrfs_run_delayed_refs(trans, count);
+		btrfs_end_transaction(trans);
+		if (ret < 0)
+			break;
+	}
+}
+
+void btrfs_init_async_delayed_ref_work(struct btrfs_fs_info *fs_info)
+{
+	INIT_WORK(&fs_info->async_delayed_ref_work,
+		  btrfs_async_run_delayed_refs);
+}
+
 int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
 				u64 bytenr, u64 num_bytes, u64 flags,
 				int level, int is_data)
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index b0d82e1a6a6e..7f994ab73b0b 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -899,6 +899,7 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *info = trans->fs_info;
 	struct btrfs_transaction *cur_trans = trans->transaction;
 	int err = 0;
+	bool run_async = false;
 
 	if (refcount_read(&trans->use_count) > 1) {
 		refcount_dec(&trans->use_count);
@@ -906,6 +907,9 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
 		return 0;
 	}
 
+	if (btrfs_should_throttle_delayed_refs(trans, true))
+		run_async = true;
+
 	btrfs_trans_release_metadata(trans);
 	trans->block_rsv = NULL;
 
@@ -936,6 +940,10 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
 		err = -EIO;
 	}
 
+	if (run_async && !work_busy(&info->async_delayed_ref_work))
+		queue_work(system_unbound_wq,
+			   &info->async_delayed_ref_work);
+
 	kmem_cache_free(btrfs_trans_handle_cachep, trans);
 	return err;
 }
-- 
2.24.1

