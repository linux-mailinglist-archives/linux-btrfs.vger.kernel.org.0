Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3A70837EF
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 19:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbfHFRfC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 13:35:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35504 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbfHFRfC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Aug 2019 13:35:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so41901032pfn.2
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2019 10:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hg13ycSoVuOhgBDbF5aB//LdUT21VGJu5PgfZk+vIis=;
        b=Oz0uxAGzE9N6vEdoc5bG+caraSmlUWbqjKferBXGIOgTjS3C8UKtqXrqBeDF6amr5T
         uoRE9clbhck0brEGP3xBf8XyXE5ebGA6gEO04I87zBGVTHvd6w1jGdsZbNHzG8VnmaSo
         EbVuPop26feWFdK9uST5RCqQJR5HRB4c0T3TTAk/4bzA3N8IYgkYAjp/Ey3s3KeEs6FB
         VX+w5PRZBurH5fEMn4hyvzwuV1VAnpX7mkslMkax1MHOdm5ZHZTznqrfJ30HNpDeLjzR
         IWKnAtq8GXRE59a8/r38yLrrL3sdMA2P/mpbF41zosQCMkQIlC5IL5ae1k6jpmHwS3OH
         E7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hg13ycSoVuOhgBDbF5aB//LdUT21VGJu5PgfZk+vIis=;
        b=KKWbm38vQrxvz5tnT1CsLgITo4EaA+yNMf7hE9y1SENovAEpIUbNhx2tPUpOLTaJRR
         aks9GhnAgVVQ+uSz98KewVfIi4PrE+bKo481PBgcXOX7J0nne7bfFGXQYlRQ4saA7DyS
         mL9XhoE3KOWLNJvdnXjk3zefle4TkplLX/2oMwFH71WSPMhkWDIJowRdM6THuQkTbVmm
         VzZfyc9vvM553HQQzAppebDPcg5OmflOvyNGjzGMojrTVnkI/kHUTf+55DoqqmMFW+MK
         4cAkiNYp3N+l23cOOMgtMjCojLbxZbQ0p8atKyKIZFgQJaT920en2wc99tbJVY3SEdSG
         CASA==
X-Gm-Message-State: APjAAAXXOVD+KinIOKnhnm+uU4BZVxVpyyySZ87s8iKsuqTNledzPawf
        S4H7H+FJIwBzwCyMqB9pdeqjx6VlVK0=
X-Google-Smtp-Source: APXvYqzU2oDEs5YKlL3JNQk5CRdf8hIesaC6RszW+Ix3kZydfmrsVISOXazpXnpjLg60tPDtMbjmCA==
X-Received: by 2002:a17:90a:5207:: with SMTP id v7mr4137579pjh.127.1565112900393;
        Tue, 06 Aug 2019 10:35:00 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::aa33])
        by smtp.gmail.com with ESMTPSA id v63sm90486586pfv.174.2019.08.06.10.34.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 10:34:59 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH] Btrfs: fix workqueue deadlock on dependent filesystems
Date:   Tue,  6 Aug 2019 10:34:52 -0700
Message-Id: <0bea516a54b26e4e1c42e6fe47548cb48cc4172b.1565112813.git.osandov@fb.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

We hit a the following very strange deadlock on a system with Btrfs on a
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
index 122cb97c7909..b2bfde560331 100644
--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -250,16 +250,17 @@ static inline void thresh_exec_hook(struct __btrfs_workqueue *wq)
 	}
 }
 
-static void run_ordered_work(struct __btrfs_workqueue *wq)
+static void run_ordered_work(struct btrfs_work *self)
 {
+	struct __btrfs_workqueue *wq = self->wq;
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
@@ -285,16 +286,47 @@ static void run_ordered_work(struct __btrfs_workqueue *wq)
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
@@ -322,7 +354,7 @@ static void normal_work_helper(struct btrfs_work *work)
 	work->func(work);
 	if (need_order) {
 		set_bit(WORK_DONE_BIT, &work->flags);
-		run_ordered_work(wq);
+		run_ordered_work(work);
 	}
 	if (!need_order)
 		trace_btrfs_all_work_done(wq->fs_info, wtag);
-- 
2.22.0

