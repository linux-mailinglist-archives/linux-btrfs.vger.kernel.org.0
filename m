Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EE12DD311
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 15:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgLQOgw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 09:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgLQOgt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 09:36:49 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEA7C0617B0
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 06:36:09 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id s6so13345805qvn.6
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 06:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f0i7UcDlMhrQzsDs99QH8S1W6OSPcU/bY7DVRv5GcPQ=;
        b=c4zZECijaT58ScphE2hJ5zR52dDcPMLMJqTN08qB4hs6ekjsftubh6nQf7pVQTP4V9
         mw6nO/kr/qcC+Dm3Tg9eiJo5wfSY2cxnkmOw5zVgOvtCtwaEk3NXFeHtZB0TeUrv2kpA
         jGfAWYcaBnaraFO0yToGjMmdp2DifeH9mvA3/qwPsJLNpBf8WVLxlCvZtmSa8qGYMkVA
         ARGtl65tDbDa+QqAzpXiE1I6+qVHrcMqjt/DeT+y78Ex0OBTk9Ox6TsiS3SPXj3qAHie
         OmopOS6yGBMDISkVjUd8qnhvBrA7+vAubydAPAVbAO1xDUxhYIbI5u+GR8IX+WQah3ol
         TG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f0i7UcDlMhrQzsDs99QH8S1W6OSPcU/bY7DVRv5GcPQ=;
        b=bET+ZnO9oZVVXh8eCbenpaexbJSvePAq0I6vXHEMrq+dYYKrNXGSKSc2IsSyIARNUK
         wXOG+dvU4w3n1KkK81fZNgk89Pmkf/fKZvsm6tMuYESnUT5HbuOPdQrlj1dVV8JiCTAy
         LNEfp9TNhUaf3bv+bOQ/5N+F2jsPrW1Xq3YLpFZtiQySekY9cNIFUioK8Sv+lGhFeJGd
         W9xVE23MGDI76ZzQ+Fxz49IQ/Z+zFgIESXSB2H6dUaB5PPqg7rH88nxq6db3Q2XHY4/+
         GePdqmeM2tywnVaaTqtrTPIDqwyPpuHcpQsXe39SQslRjkSaJQTL102shZqCTGQWOLS7
         ZpHQ==
X-Gm-Message-State: AOAM531oEap5VpF3ibZCWEROsTGpxr0pNflyGgar7vFYrPwYFqn5j7WO
        x7q6fz/iqNfpt61G7efl1juL+KA6+KJXybk5
X-Google-Smtp-Source: ABdhPJy7k4jKsMmXSJj3/C1kwVsQ7zDkV7MQbVZbwOP2jqdHhYO0GTuriC1bwirI6tWbp9Jn4++TTA==
X-Received: by 2002:ad4:4aac:: with SMTP id i12mr45897162qvx.10.1608215768008;
        Thu, 17 Dec 2020 06:36:08 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y187sm3607742qkc.120.2020.12.17.06.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:36:07 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v4 2/6] btrfs: only let one thread pre-flush delayed refs in commit
Date:   Thu, 17 Dec 2020 09:35:58 -0500
Message-Id: <9e47b11bdfe5b4905fdaa81e952de2e2466c6335.1608215738.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608215738.git.josef@toxicpanda.com>
References: <cover.1608215738.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've been running a stress test that runs 20 workers in their own
subvolume, which are running an fsstress instance with 4 threads per
worker, which is 80 total fsstress threads.  In addition to this I'm
running balance in the background as well as creating and deleting
snapshots.  This test takes around 12 hours to run normally, going
slower and slower as the test goes on.

The reason for this is because fsstress is running fsync sometimes, and
because we're messing with block groups we often fall through to
btrfs_commit_transaction, so will often have 20-30 threads all calling
btrfs_commit_transaction at the same time.

These all get stuck contending on the extent tree while they try to run
delayed refs during the initial part of the commit.

This is suboptimal, really because the extent tree is a single point of
failure we only want one thread acting on that tree at once to reduce
lock contention.  Fix this by making the flushing mechanism a bit
operation, to make it easy to use test_and_set_bit() in order to make
sure only one task does this initial flush.

Once we're into the transaction commit we only have one thread doing
delayed ref running, it's just this initial pre-flush that is
problematic.  With this patch my stress test takes around 90 minutes to
run, instead of 12 hours.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.h | 12 ++++++------
 fs/btrfs/transaction.c | 33 ++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 1c977e6d45dc..6e414785b56f 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -135,6 +135,11 @@ struct btrfs_delayed_data_ref {
 	u64 offset;
 };
 
+enum btrfs_delayed_ref_flags {
+	/* Used to indicate that we are flushing delayed refs for the commit. */
+	BTRFS_DELAYED_REFS_FLUSHING,
+};
+
 struct btrfs_delayed_ref_root {
 	/* head ref rbtree */
 	struct rb_root_cached href_root;
@@ -158,12 +163,7 @@ struct btrfs_delayed_ref_root {
 
 	u64 pending_csums;
 
-	/*
-	 * set when the tree is flushing before a transaction commit,
-	 * used by the throttling code to decide if new updates need
-	 * to be run right away
-	 */
-	int flushing;
+	unsigned long flags;
 
 	u64 run_delayed_start;
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index f51f9e39bcee..ccd37fbe5db1 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -909,9 +909,9 @@ bool btrfs_should_end_transaction(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_transaction *cur_trans = trans->transaction;
 
-	smp_mb();
 	if (cur_trans->state >= TRANS_STATE_COMMIT_START ||
-	    cur_trans->delayed_refs.flushing)
+	    test_bit(BTRFS_DELAYED_REFS_FLUSHING,
+		     &cur_trans->delayed_refs.flags))
 		return true;
 
 	return should_end_transaction(trans);
@@ -2043,23 +2043,22 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	btrfs_trans_release_metadata(trans);
 	trans->block_rsv = NULL;
 
-	/* make a pass through all the delayed refs we have so far
-	 * any runnings procs may add more while we are here
-	 */
-	ret = btrfs_run_delayed_refs(trans, 0);
-	if (ret) {
-		btrfs_end_transaction(trans);
-		return ret;
-	}
-
-	cur_trans = trans->transaction;
-
 	/*
-	 * set the flushing flag so procs in this transaction have to
-	 * start sending their work down.
+	 * We only want one transaction commit doing the flushing so we do not
+	 * waste a bunch of time on lock contention on the extent root node.
 	 */
-	cur_trans->delayed_refs.flushing = 1;
-	smp_wmb();
+	if (!test_and_set_bit(BTRFS_DELAYED_REFS_FLUSHING,
+			      &cur_trans->delayed_refs.flags)) {
+		/*
+		 * make a pass through all the delayed refs we have so far
+		 * any runnings procs may add more while we are here
+		 */
+		ret = btrfs_run_delayed_refs(trans, 0);
+		if (ret) {
+			btrfs_end_transaction(trans);
+			return ret;
+		}
+	}
 
 	btrfs_create_pending_block_groups(trans);
 
-- 
2.26.2

