Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96A23B405C
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2019 20:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390442AbfIPSbX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Sep 2019 14:31:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36635 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390349AbfIPSbX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Sep 2019 14:31:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so439006pfr.3
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2019 11:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CqW3yzKWfh5qIJfXWfSEnO/Y10xnVsvvDDsW8CFW01g=;
        b=nc1shtZHAaJCgRORIKFW9UCOnNsrP26ScKEubZZR9sy7GLHh+6AvkgN7azqQPYgrd3
         cLSUX+UcqsfIBMLLuccFfQuinFEplxbgfcvx4oB5v0JsnsJBd+RPdg2a93kQ1IrAdA+K
         GafeySlDBlvyzmDg89Cstb3HqsQMkJmVlTC36765dgCHnvEQbumVAhSCG/zVKGLJGeCa
         P/wK/VicQ8nkKmRjdnTXdO8u1A8oJn1sDXUDZtpxRLasr47FrYAXzCNHD/IMWOJkoCSf
         nPFMAlEFrI3+DxVzxeyCrRTRqVW+C6SvXv4bKxKD0bnvK79nsiW13wc8iJP5SgJBIDQf
         DItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CqW3yzKWfh5qIJfXWfSEnO/Y10xnVsvvDDsW8CFW01g=;
        b=WdVyDeMZsEYetY7DTGElzjRjAw4vud+l9ynYL5E60ubKunkZ2sQ3cIZAFLkF6W1z8H
         8MjNbFAP4g0l2Jv27eiKRQnoxJaFQMGbgQ8LoGY0ZNKS0BD6aLMThjBrvDfRUIWg6ccF
         hg1NWXn72pxQNc82WHEikJoO4BCxXf0Rchh6V1Yc+N6Z3GFuI/wToTiqK5HUKwuVufHi
         ox5C2u5+pZ1IHRqM7cB/a06lDAtpxr+1gtFafOrjcIjeiO7O2Kj3OBk54g5hxRkWZe3z
         RJE3rEJq5F8wFnNRJP3pKvyw9f906EL46KE0TZWwXYhTCWBE6KsxlEYEKfjXdN+Iy+4a
         R4/Q==
X-Gm-Message-State: APjAAAW5Lr16cV36Bsa3XD/0OTO82+GZfVSDL6bQwmxKGMHE+G5DQEoP
        Zw5Y961FmyfdYAt53eVwK6uFCJwpIOs=
X-Google-Smtp-Source: APXvYqy6EejtLc6IE1JpYWRP+04JONqyfdwWBZHWuivIV8Ua/FJ9SWji+J5X9l6GZiwccIicVGQg0A==
X-Received: by 2002:a63:791:: with SMTP id 139mr413102pgh.199.1568658679790;
        Mon, 16 Sep 2019 11:31:19 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::3:d0da])
        by smtp.gmail.com with ESMTPSA id i7sm24231385pfd.126.2019.09.16.11.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 11:31:19 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Nikolay Borisov <nborisov@suse.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 7/7] btrfs: get rid of pointless wtag variable in async-thread.c
Date:   Mon, 16 Sep 2019 11:30:58 -0700
Message-Id: <99354a5c9ec204d73d7355594486af70ad11e73f.1568658527.git.osandov@fb.com>
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

Commit ac0c7cf8be00 ("btrfs: fix crash when tracepoint arguments are
freed by wq callbacks") added a void pointer, wtag, which is passed into
trace_btrfs_all_work_done() instead of the freed work item. This is
silly for a few reasons:

1. The freed work item still has the same address.
2. work is still in scope after it's freed, so assigning wtag doesn't
   stop anyone from using it.
3. The tracepoint has always taken a void * argument, so assigning wtag
   doesn't actually make things any more type-safe. (Note that the
   original bug in commit bc074524e123 ("btrfs: prefix fsid to all trace
   events") was that the void * was implicitly casted when it was passed
   to btrfs_work_owner() in the trace point itself).

Instead, let's add some clearer warnings as comments.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/async-thread.c      | 21 ++++++++-------------
 include/trace/events/btrfs.h |  6 +++---
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
index 3f3110975f88..b97ae1b03417 100644
--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -226,7 +226,6 @@ static void run_ordered_work(struct __btrfs_workqueue *wq,
 	struct btrfs_work *work;
 	spinlock_t *lock = &wq->list_lock;
 	unsigned long flags;
-	void *wtag;
 	bool free_self = false;
 
 	while (1) {
@@ -281,21 +280,19 @@ static void run_ordered_work(struct __btrfs_workqueue *wq,
 		} else {
 			/*
 			 * We don't want to call the ordered free functions with
-			 * the lock held though. Save the work as tag for the
-			 * trace event, because the callback could free the
-			 * structure.
+			 * the lock held.
 			 */
-			wtag = work;
 			work->ordered_free(work);
-			trace_btrfs_all_work_done(wq->fs_info, wtag);
+			/* NB: work must not be dereferenced past this point. */
+			trace_btrfs_all_work_done(wq->fs_info, work);
 		}
 	}
 	spin_unlock_irqrestore(lock, flags);
 
 	if (free_self) {
-		wtag = self;
 		self->ordered_free(self);
-		trace_btrfs_all_work_done(wq->fs_info, wtag);
+		/* NB: self must not be dereferenced past this point. */
+		trace_btrfs_all_work_done(wq->fs_info, self);
 	}
 }
 
@@ -304,7 +301,6 @@ static void btrfs_work_helper(struct work_struct *normal_work)
 	struct btrfs_work *work = container_of(normal_work, struct btrfs_work,
 					       normal_work);
 	struct __btrfs_workqueue *wq;
-	void *wtag;
 	int need_order = 0;
 
 	/*
@@ -318,8 +314,6 @@ static void btrfs_work_helper(struct work_struct *normal_work)
 	if (work->ordered_func)
 		need_order = 1;
 	wq = work->wq;
-	/* Safe for tracepoints in case work gets freed by the callback */
-	wtag = work;
 
 	trace_btrfs_work_sched(work);
 	thresh_exec_hook(wq);
@@ -327,9 +321,10 @@ static void btrfs_work_helper(struct work_struct *normal_work)
 	if (need_order) {
 		set_bit(WORK_DONE_BIT, &work->flags);
 		run_ordered_work(wq, work);
+	} else {
+		/* NB: work must not be dereferenced past this point. */
+		trace_btrfs_all_work_done(wq->fs_info, work);
 	}
-	if (!need_order)
-		trace_btrfs_all_work_done(wq->fs_info, wtag);
 }
 
 void btrfs_init_work(struct btrfs_work *work, btrfs_func_t func,
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 5df604de4f11..c60cf281cb86 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1389,9 +1389,9 @@ DECLARE_EVENT_CLASS(btrfs__work,
 );
 
 /*
- * For situiations when the work is freed, we pass fs_info and a tag that that
- * matches address of the work structure so it can be paired with the
- * scheduling event.
+ * For situations when the work is freed, we pass fs_info and a tag that matches
+ * the address of the work structure so it can be paired with the scheduling
+ * event. DO NOT add anything here that dereferences wtag.
  */
 DECLARE_EVENT_CLASS(btrfs__work__done,
 
-- 
2.23.0

