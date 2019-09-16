Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41C33B4057
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2019 20:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390416AbfIPSbO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Sep 2019 14:31:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38191 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390406AbfIPSbN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Sep 2019 14:31:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id w10so276921plq.5
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2019 11:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Fr7hEBAJqdKnZsqh7Z+MAEHnPmRL9Z4CkXa5IIktrs=;
        b=0pah0NIpVjYAyadQRLZk4utRyhidNz8Xk8X0u5bWTd30R0faNzdrKDI8ddY5nzc/OU
         XbbJ2cvXpdFjyaeOXuPqaviHKkpKWUxUcXwkGCvw5zSfByf2nGRYX/9n/r7bntU2co8m
         4fpjl9nSbQHx4uTa46bZepAq1ZMsKSGpx4b9u9WfZORDaElad/fer0cRG19ZsVzMq650
         cT0xwrRv6wlUT13Zyzrz8Hbux0UsKa+lvBN9ManS95NHTqzcp7I4Oh5A7eE4rENZZimd
         mVBERo2ND4aIfU7dtBBbPH3jJCadEVVueiKbd6gWvvyY0qr/xWoCm60TaQvfnWejLlSe
         Uyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Fr7hEBAJqdKnZsqh7Z+MAEHnPmRL9Z4CkXa5IIktrs=;
        b=cpBmC+yJOJBGjTZUQEvqNuvkqvlahy/ttnKVOSSaKVtzuzZQD0pgC9J5dyDUOB8ZtX
         4MKCs2fic7GdQjOsdafiKnk6KhNY7L6Iv5jlscrD8gN2j6c51fTDK5rAaBAL6CpBKreh
         TcAGRBwlyCQXlCnMXjuVCAbzlaoROycadG8wtGcsxb4RSiayfsh9sB0JqCHzemqQu064
         zVv/8jPLavkFNRgu+sGN18LI+lnXo8t0og9LukKF8iAldNWf4DwKm05I45ztC2R2UlP7
         SeOGFBHsthzVFxLFwzSROqGFOW1H8+9MJFZODA9obzpWI8D6HsVXh94rX1SM8IJWVjzv
         yOEg==
X-Gm-Message-State: APjAAAXt3qHvbzZvDgVggtdVb2I0WK0KhvzYPpXSMq9y3j3g8IpwNFNB
        wbNEQlivawEgARNNkyQkYZfXTXXZeG4=
X-Google-Smtp-Source: APXvYqzzT9XNo2agfQSe7kRa92RcHVf+Fcey/UDMkDdb9JX+ZYiXiBEgs+p0dqitmSAsP0hr+3KWjQ==
X-Received: by 2002:a17:902:7615:: with SMTP id k21mr1186468pll.116.1568658672176;
        Mon, 16 Sep 2019 11:31:12 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::3:d0da])
        by smtp.gmail.com with ESMTPSA id i7sm24231385pfd.126.2019.09.16.11.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 11:31:11 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/7] btrfs: don't prematurely free work in run_ordered_work()
Date:   Mon, 16 Sep 2019 11:30:53 -0700
Message-Id: <ec398300e5e36b6f7ab209f082faf5994be723d4.1568658527.git.osandov@fb.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568658527.git.osandov@fb.com>
References: <cover.1568658527.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

We hit the following very strange deadlock on a system with Btrfs on a
loop device backed by another Btrfs filesystem:

1. The top (loop device) filesystem queues an async_cow work item from
   cow_file_range_async(). We'll call this work X.
2. Worker thread A starts work X (normal_work_helper()).
3. Worker thread A executes the ordered work for the top filesystem
   (run_ordered_work()).
4. Worker thread A finishes the ordered work for work X and frees X
   (work->ordered_free()).
5. Worker thread A executes another ordered work and gets blocked on I/O
   to the bottom filesystem (still in run_ordered_work()).
6. Meanwhile, the bottom filesystem allocates and queues an async_cow
   work item which happens to be the recently-freed X.
7. The workqueue code sees that X is already being executed by worker
   thread A, so it schedules X to be executed _after_ worker thread A
   finishes (see the find_worker_executing_work() call in
   process_one_work()).

Now, the top filesystem is waiting for I/O on the bottom filesystem, but
the bottom filesystem is waiting for the top filesystem to finish, so we
deadlock.

This happens because we are breaking the workqueue assumption that a
work item cannot be recycled while it still depends on other work. Fix
it by waiting to free the work item until we are done with all of the
related ordered work.

P.S.:

One might ask why the workqueue code doesn't try to detect a recycled
work item. It actually does try by checking whether the work item has
the same work function (find_worker_executing_work()), but in our case
the function is the same. This is the only key that the workqueue code
has available to compare, short of adding an additional, layer-violating
"custom key". Considering that we're the only ones that have ever hit
this, we should just play by the rules.

Unfortunately, we haven't been able to create a minimal reproducer other
than our full container setup using a compress-force=zstd filesystem on
top of another compress-force=zstd filesystem.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/async-thread.c | 56 ++++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
index 2e9e13ffbd08..10a04b99798a 100644
--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -252,16 +252,17 @@ static inline void thresh_exec_hook(struct __btrfs_workqueue *wq)
 	}
 }
 
-static void run_ordered_work(struct __btrfs_workqueue *wq)
+static void run_ordered_work(struct __btrfs_workqueue *wq,
+			     struct btrfs_work *self)
 {
 	struct list_head *list = &wq->ordered_list;
 	struct btrfs_work *work;
 	spinlock_t *lock = &wq->list_lock;
 	unsigned long flags;
+	void *wtag;
+	bool free_self = false;
 
 	while (1) {
-		void *wtag;
-
 		spin_lock_irqsave(lock, flags);
 		if (list_empty(list))
 			break;
@@ -287,16 +288,47 @@ static void run_ordered_work(struct __btrfs_workqueue *wq)
 		list_del(&work->ordered_list);
 		spin_unlock_irqrestore(lock, flags);
 
-		/*
-		 * We don't want to call the ordered free functions with the
-		 * lock held though. Save the work as tag for the trace event,
-		 * because the callback could free the structure.
-		 */
-		wtag = work;
-		work->ordered_free(work);
-		trace_btrfs_all_work_done(wq->fs_info, wtag);
+		if (work == self) {
+			/*
+			 * This is the work item that the worker is currently
+			 * executing.
+			 *
+			 * The kernel workqueue code guarantees non-reentrancy
+			 * of work items. I.e., if a work item with the same
+			 * address and work function is queued twice, the second
+			 * execution is blocked until the first one finishes. A
+			 * work item may be freed and recycled with the same
+			 * work function; the workqueue code assumes that the
+			 * original work item cannot depend on the recycled work
+			 * item in that case (see find_worker_executing_work()).
+			 *
+			 * Note that the work of one Btrfs filesystem may depend
+			 * on the work of another Btrfs filesystem via, e.g., a
+			 * loop device. Therefore, we must not allow the current
+			 * work item to be recycled until we are really done,
+			 * otherwise we break the above assumption and can
+			 * deadlock.
+			 */
+			free_self = true;
+		} else {
+			/*
+			 * We don't want to call the ordered free functions with
+			 * the lock held though. Save the work as tag for the
+			 * trace event, because the callback could free the
+			 * structure.
+			 */
+			wtag = work;
+			work->ordered_free(work);
+			trace_btrfs_all_work_done(wq->fs_info, wtag);
+		}
 	}
 	spin_unlock_irqrestore(lock, flags);
+
+	if (free_self) {
+		wtag = self;
+		self->ordered_free(self);
+		trace_btrfs_all_work_done(wq->fs_info, wtag);
+	}
 }
 
 static void normal_work_helper(struct btrfs_work *work)
@@ -324,7 +356,7 @@ static void normal_work_helper(struct btrfs_work *work)
 	work->func(work);
 	if (need_order) {
 		set_bit(WORK_DONE_BIT, &work->flags);
-		run_ordered_work(wq);
+		run_ordered_work(wq, work);
 	}
 	if (!need_order)
 		trace_btrfs_all_work_done(wq->fs_info, wtag);
-- 
2.23.0

