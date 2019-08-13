Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3614F8BFAB
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2019 19:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfHMReX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 13:34:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40702 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfHMReX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 13:34:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so49504539pla.7
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2019 10:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iX2r593VPRXLULs7VIWnVWdzALx6APHItNgGEBV+fKs=;
        b=m6ZUt7QcyxYnzng+T4CKa5MtQm9ecrpt4zjUzhQli0Mo9ME01mQ+HuLOO+taEMBa0S
         WyODgp6Teu6qHhdGXdeN27ToehpGqyYQd5eTZZ8meQrSs3JHNiZukB2tA7gnetyyRRe/
         VZ6fOyNALsFeCsj5pveazdfsYkI8Dg9H0gbmfMJ8Jxz2m6g+FNQ3yIxKY0HnrS76sP6D
         TOiLbW/kViEqZV24HwJXi4iJcptnHTWVebTbxQrAUkKPX97igZJFX/HK07EG9lPMsvbb
         mWMa7ZAXB8Gkz/JhDFOgI17bCOSo4MV4BgUPgCJ2qmRQ6k62x2Ky8roToxn2mvFacc8Y
         dg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iX2r593VPRXLULs7VIWnVWdzALx6APHItNgGEBV+fKs=;
        b=Nfwuhxy7wNiso3p96wXQYJ/MyGr4i2H7VnJ9fJ6WxK38obakqrTEO+HbXmCWfm8cfh
         jWtl9IR9xrq1QcjisnoWPc3Z152tBPfh1PZittPFQlcNaDn/uC9obRQPfoLhnRZVWS72
         rmOwqHObD/JihLjQsyW52/h7ffAcVEwQGQCRKdGqdkWjX4vOiNE2wdENurWWFzQJUtBa
         Dam/JxdKMAf8GbXozrGnMk+F7pWT1B3mTE6p/z2Qqz5sEflcZ7miAl2G5j41SZnSE+2A
         +mJh/g2xf7APx3R32AkK5mSBadlUPO3azSkawH72i/YhAORFfgOJB9Ki3OxAf7k6h1Pc
         +m9w==
X-Gm-Message-State: APjAAAWtjjSgv9NTLku/elZoevxbhN7DPDb2lDpqeGS4qgwxLy5HwTMe
        3k1nI7t/I54ZvUxdnWQEmpgR0oBFf0A=
X-Google-Smtp-Source: APXvYqwi5zlblA4/ei3qATdCubHTWs2hjinpqyzM/RpvR/XEteiKkt04bE7RDcYdaRpJY2WlziIzdQ==
X-Received: by 2002:a17:902:2be8:: with SMTP id l95mr36457705plb.231.1565717661679;
        Tue, 13 Aug 2019 10:34:21 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::1:f9b5])
        by smtp.gmail.com with ESMTPSA id x17sm11076151pff.62.2019.08.13.10.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 10:34:20 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Nikolay Borisov <nborisov@suse.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 2/2] Btrfs: get rid of pointless wtag variable in async-thread.c
Date:   Tue, 13 Aug 2019 10:33:44 -0700
Message-Id: <d4fa1870ffce027ada265a67f4e00d397b683241.1565717248.git.osandov@fb.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1565717247.git.osandov@fb.com>
References: <cover.1565717247.git.osandov@fb.com>
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
index d105d3df6fa6..60319075b781 100644
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
 		run_ordered_work(work);
+	} else {
+		/* NB: work must not be dereferenced past this point. */
+		trace_btrfs_all_work_done(wq->fs_info, work);
 	}
-	if (!need_order)
-		trace_btrfs_all_work_done(wq->fs_info, wtag);
 }
 
 void btrfs_init_work(struct btrfs_work *work, btrfs_func_t func,
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 5cb95646b94e..2618a7f532c0 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1388,9 +1388,9 @@ DECLARE_EVENT_CLASS(btrfs__work,
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
2.22.0

