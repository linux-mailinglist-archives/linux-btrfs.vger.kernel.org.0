Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47EB28F877
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Oct 2020 20:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733088AbgJOS0K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Oct 2020 14:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733081AbgJOS0J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Oct 2020 14:26:09 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA58C061755
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Oct 2020 11:26:09 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id t6so6457qvz.4
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Oct 2020 11:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UK/iyurwWNC+uA4M3W6MmFdqBhdlEybcQk2Y2OWSCNk=;
        b=ciySUZN9dVWGhdUnJv3cbZZQ451czuGevtVRVkZsbi/zYjfNXLMfSysijDaw/Hs/jK
         4ZckZc+CIqMOFlfAYJyhu2FaVXMQvfXbuYVasAx7fTKxCO4pJo66fPkkmJK9Vqy8nA7b
         CD0K8IvPD5y5cgkjbu0nZmP3Go+6hr1Ph92J1ZVlMHG1poEe+Yt6msFiq3jenoRiDu2f
         wdT8pBlHopuB4p3K6TN+AbWJ9r3U+9rDkYpTfn4bgmH2JWV86WTxIbzLEO94F/asR//G
         K+hLqxSizsrBTEYk2xUnsfVfpZtV6I+6g2IbW12X/jnJ/qswpBsmoygnoiQEY3AYyFEH
         Ek9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UK/iyurwWNC+uA4M3W6MmFdqBhdlEybcQk2Y2OWSCNk=;
        b=klqoSIri4fXpzkACV1BZRcNqhAKqI5JfQKDRleCNxGq7Db43Kosx2KnN+PwLitZGl0
         CRCqtmOTs+s2lVm8h8gymnpYxXO+aw6mftjOAaxvVRqHCYSFv3muAv2urCTm/BdPE/cC
         IqHqXg70dBB/fNd0T3yZeOJl6EobB/NJrVQLoeRKmoXsv3o0WeFI94qhhdVjK+CyN06z
         kkWw/eJAq+GuB5oYJkdrJ62Jjx5s/zRmrXb2efcpf17MwtcZ8RFB5msxRBW2J9bZBm7B
         cr7eOlTiVGbQ5W7B19jpBHVC9WRRSyyDxRVViYiFVsSD64vP3+2QEDATmi5wKlkvtPTp
         6JzQ==
X-Gm-Message-State: AOAM533O+vuD5gtDuFABpzIH0I2rFb0gdQTbGcMXKa0DpqcTNwQ5dsDm
        4kkrqHZADAtzRLihRyA6yIfvOSinGoXXrpOL
X-Google-Smtp-Source: ABdhPJxbdyn1s+tMpJGv//89EbZHqnNOCD7BxUDBQ7cW7uwNyM+ANc3/xk5ZIWnQFx0DuBhovmzX4Q==
X-Received: by 2002:ad4:42ae:: with SMTP id e14mr46656qvr.44.1602786368254;
        Thu, 15 Oct 2020 11:26:08 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k5sm1474463qkc.45.2020.10.15.11.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 11:26:07 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/6] btrfs: only let one thread pre-flush delayed refs in commit
Date:   Thu, 15 Oct 2020 14:25:58 -0400
Message-Id: <10113ed0453832382bc350f15758f871db43b5d9.1602786206.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1602786206.git.josef@toxicpanda.com>
References: <cover.1602786206.git.josef@toxicpanda.com>
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

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.h | 12 ++++++------
 fs/btrfs/transaction.c | 32 ++++++++++++++++----------------
 2 files changed, 22 insertions(+), 22 deletions(-)

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
index 52ada47aff50..e8e706def41c 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -872,7 +872,8 @@ int btrfs_should_end_transaction(struct btrfs_trans_handle *trans)
 
 	smp_mb();
 	if (cur_trans->state >= TRANS_STATE_COMMIT_START ||
-	    cur_trans->delayed_refs.flushing)
+	    test_bit(BTRFS_DELAYED_REFS_FLUSHING,
+		     &cur_trans->delayed_refs.flags))
 		return 1;
 
 	return should_end_transaction(trans);
@@ -2042,23 +2043,22 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
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
2.24.1

