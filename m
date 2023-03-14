Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9886B9C5E
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 17:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCNQ7p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 12:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjCNQ7n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 12:59:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136079CFE4
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 09:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=HqZMJ7pJ8tE8ru4VSLxwj2oeVhU4JPUFstfsVphke0k=; b=SQDOWXwC8cVgFAaaJxaDRKW3Tt
        O0rrvkyPwqK5jRzKITzvfZWoOlIE4yv6rBwV/tYdS9Xqf0ExKWRLkH08lHwzdRczvVYjBOh4GMC6W
        7w40Zg2FNfD4nGW9dfxQsMG1UkVgATEgU8oMT3MICJkcWKc8yOZMRDHh7feL/ywd0PuiBeNm1Sxci
        kMgmfMZoq5WhCwplcVPuwD3absHSP4O5MB4oCMdiG5GxsieVd7tPpK+U0W/haR61SS/CIYsXcLtVO
        wMpgzJIVknHkcpKjFVBr7Sjd9tLK+9tB52EvB1DHXIaFeH2ZSLQjsBQiWxzbHTwaoQDjTwj/C7Ay+
        U6/vOBDQ==;
Received: from [2001:4bb8:182:2e36:91ea:d0e2:233a:8356] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pc7zu-00Avov-0M;
        Tue, 14 Mar 2023 16:59:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH 05/10] btrfs: remove irq disabling for btrfs_workqueue.list_lock
Date:   Tue, 14 Mar 2023 17:59:05 +0100
Message-Id: <20230314165910.373347-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314165910.373347-1-hch@lst.de>
References: <20230314165910.373347-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_queue_work with an ordered_func is never called from irq
context, so remove the irq disabling for btrfs_workqueue.list_lock.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/async-thread.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
index aac240430efe13..91ec1e2fea0c69 100644
--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -179,11 +179,10 @@ static void run_ordered_work(struct btrfs_workqueue *wq,
 	struct list_head *list = &wq->ordered_list;
 	struct btrfs_work *work;
 	spinlock_t *lock = &wq->list_lock;
-	unsigned long flags;
 	bool free_self = false;
 
 	while (1) {
-		spin_lock_irqsave(lock, flags);
+		spin_lock(lock);
 		if (list_empty(list))
 			break;
 		work = list_entry(list->next, struct btrfs_work,
@@ -207,13 +206,13 @@ static void run_ordered_work(struct btrfs_workqueue *wq,
 		if (test_and_set_bit(WORK_ORDER_DONE_BIT, &work->flags))
 			break;
 		trace_btrfs_ordered_sched(work);
-		spin_unlock_irqrestore(lock, flags);
+		spin_unlock(lock);
 		work->ordered_func(work);
 
 		/* now take the lock again and drop our item from the list */
-		spin_lock_irqsave(lock, flags);
+		spin_lock(lock);
 		list_del(&work->ordered_list);
-		spin_unlock_irqrestore(lock, flags);
+		spin_unlock(lock);
 
 		if (work == self) {
 			/*
@@ -248,7 +247,7 @@ static void run_ordered_work(struct btrfs_workqueue *wq,
 			trace_btrfs_all_work_done(wq->fs_info, work);
 		}
 	}
-	spin_unlock_irqrestore(lock, flags);
+	spin_unlock(lock);
 
 	if (free_self) {
 		self->ordered_free(self);
@@ -307,14 +306,12 @@ void btrfs_init_work(struct btrfs_work *work, btrfs_func_t func,
 
 void btrfs_queue_work(struct btrfs_workqueue *wq, struct btrfs_work *work)
 {
-	unsigned long flags;
-
 	work->wq = wq;
 	thresh_queue_hook(wq);
 	if (work->ordered_func) {
-		spin_lock_irqsave(&wq->list_lock, flags);
+		spin_lock(&wq->list_lock);
 		list_add_tail(&work->ordered_list, &wq->ordered_list);
-		spin_unlock_irqrestore(&wq->list_lock, flags);
+		spin_unlock(&wq->list_lock);
 	}
 	trace_btrfs_work_queued(work);
 	queue_work(wq->normal_wq, &work->normal_work);
-- 
2.39.2

