Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAC08B0C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2019 09:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfHMH0Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 03:26:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33128 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbfHMH0P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 03:26:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so9981008pgn.0
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2019 00:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QJEBZdBhwOzm4V0eRy962KEnWJglzmEvU/Dvj9SwEs4=;
        b=O5OqVadpzlOAz+c+xKa3yzYCjx563DHLu36fJWZtmbRrUrKWDP45bNet3xEclVMZKR
         05IAvbZdZ5cAmlHy3vwDnymlVc/E/0HhKzoZJ01izcl7geNfaogBUR3F8Qs9vhX25/nK
         2tP7xaRXfZ+jxi7AsO1Zemd3Y1VySgHTM0M2nUe1fybGQanjYqODADWTVWA79YxuGsSn
         CPH1z1Q0Y+DGk+4NwHxwTzgGq/Vupv6n8b859htJiI1ADxZVaTiHp1RY96wH5M6C06ij
         CvH5GVT0HtzXzsBfE5jAXW3LbpqVkKCIOP4x+DfiyJUiygPGBchqeU7l0EzY1PxiHTXM
         zIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QJEBZdBhwOzm4V0eRy962KEnWJglzmEvU/Dvj9SwEs4=;
        b=uV2k/DDKM4CgWZI/zeu3hizTT8fu+l2oyA6Fu4JsCIHMZb+jOLqNVnHfFQAiklkija
         pduzgjXY8V36CY+iVk9jjXP8e0JB9SSTBEtg43mh5esz3ZiukbDd+xngTo0Ka3ByFFDD
         s8jxJdYQBoltEfT8blommWk6VMCANMivGtgYWjQydrLvKIxeiqN+jLPejNGrjhxz1a8m
         6x0e8eZWMI8QHE4uqgQZ8SGtFONURkFgUauJC/kSzihCXiFufLqpLNDJ0LhmwbY5q9Ry
         ZU8cJQJrrTwjtb1n3AbBHzzxLzkKGrTosONExfR+5g6fqn/qHm2lt7K79HeMfQrEdL/+
         hwrA==
X-Gm-Message-State: APjAAAWr757g1myyCMdq4u/X8X793x2xUGQ6ZHZaWsD/TqyOp1G9kYTq
        A043tAnL0bfFnJ52B/JHmdsDLmttHuU=
X-Google-Smtp-Source: APXvYqxEdOJ27zPhxxTL4fItnOdMYIja/UbMEbrGt7UnUps7mb3I8Ah9LZ6ozBO6r8irDbRAv58iGw==
X-Received: by 2002:a63:755e:: with SMTP id f30mr33409698pgn.246.1565681173929;
        Tue, 13 Aug 2019 00:26:13 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:180::66b8])
        by smtp.gmail.com with ESMTPSA id b14sm43528151pga.20.2019.08.13.00.26.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 00:26:13 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 2/2] Btrfs: get rid of pointless wtag variable in async-thread.c
Date:   Tue, 13 Aug 2019 00:26:04 -0700
Message-Id: <958fe7c61896c82b35b5c552d3fb5bfd4df62627.1565680721.git.osandov@fb.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1565680721.git.osandov@fb.com>
References: <cover.1565680721.git.osandov@fb.com>
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

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/async-thread.c      | 21 ++++++++-------------
 include/trace/events/btrfs.h |  6 +++---
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
index d105d3df6fa6..baeb4058e9dc 100644
--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -226,7 +226,6 @@ static void run_ordered_work(struct btrfs_work *self)
 	struct btrfs_work *work;
 	spinlock_t *lock = &wq->list_lock;
 	unsigned long flags;
-	void *wtag;
 	bool free_self = false;
 
 	while (1) {
@@ -281,21 +280,19 @@ static void run_ordered_work(struct btrfs_work *self)
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
+			/* work must not be dereferenced past this point. */
+			trace_btrfs_all_work_done(wq->fs_info, work);
 		}
 	}
 	spin_unlock_irqrestore(lock, flags);
 
 	if (free_self) {
-		wtag = self;
 		self->ordered_free(self);
-		trace_btrfs_all_work_done(wq->fs_info, wtag);
+		/* self must not be dereferenced past this point. */
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
 		run_ordered_work(work);
+	} else {
+		/* work must not be dereferenced past this point. */
+		trace_btrfs_all_work_done(wq->fs_info, work);
 	}
-	if (!need_order)
-		trace_btrfs_all_work_done(wq->fs_info, wtag);
 }
 
 void btrfs_init_work(struct btrfs_work *work, btrfs_func_t func,
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 5cb95646b94e..3d61e80d3c6e 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1388,9 +1388,9 @@ DECLARE_EVENT_CLASS(btrfs__work,
 );
 
 /*
- * For situiations when the work is freed, we pass fs_info and a tag that that
- * matches address of the work structure so it can be paired with the
- * scheduling event.
+ * For situations when the work is freed, we pass fs_info and a tag that that
+ * matches address of the work structure so it can be paired with the scheduling
+ * event. DO NOT add anything here that dereferences wtag.
  */
 DECLARE_EVENT_CLASS(btrfs__work__done,
 
-- 
2.22.0

