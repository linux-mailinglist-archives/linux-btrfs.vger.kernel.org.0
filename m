Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67F22DC49C
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgLPQuW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgLPQuW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:50:22 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5C6C0617A7
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:49:41 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id 186so23146738qkj.3
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9CeSOnTCiDSiiYTmZsB59g/wxyjTSvdjd2ghnfRV0Lo=;
        b=vTwJdAL/gSVT897eY8kuccI4Vlw9YfRTe5JPnll1PVjR7/U8yvVQnDdx+2gPEbmnKH
         dPB9FD8UbTn0ctjYVdnR14zR7SPZeSjPYWqPrANxROerpPtY74htaPDzgAW42kllrhjS
         o0IpjW7/qdYsXiydZsbbNa0uaXmqt+LZnyCFtS+MibZzrOgkEqKPiF0ETqe805YbEWe6
         QQY5ZEM8uUP6QEmGGxOVy+llKUo1Xn5nvZwzCsC2jvHYn7TJvJpx/9IeuQykfm0oFE96
         hjtDK6IbkWbr/SswWKZALyGViX+7+NpUrrwNLU8uVJA+ooGGMvvPvaQmRksjxTvgmRLr
         sabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9CeSOnTCiDSiiYTmZsB59g/wxyjTSvdjd2ghnfRV0Lo=;
        b=qroM7yzcwIaou4m9V5Jh6kRtGjJpN0Z4q2FQkvR7NIfsy4pE4IhFB4vKxMXoLoCdyJ
         ogWfgc6sMOxPc4gCjLeTxHuaeV9Hd6q8TgHV5l0gYCHiUL7unx5I927OjyjT5/dN0cP4
         JhNWK6bpi7Y/XJBJVDuiLx6EpbBskvBlkW5YZYmI3x+UsKHxtbg4gPLP212oiVg9faIw
         W6kRvdsh5TSlhCSP0rwaZyRL8dUr8wTihZKgqCLjZRca9GhYqgfQarPXg76v+1Tu21FU
         fwMupEDuKXDSfzsOkQW7ZS8mcgF1iSGrE9i7KSPIcy1DBNDdremMDdPS8j10hdpcPO4r
         iphQ==
X-Gm-Message-State: AOAM532n7C0no2ZX0V34aQlLxyAvzI6dH7lAZlbFjb5MJSuGB+EMg+W7
        O/4QR4EImf4HYQOSeC8SsROaLfFQYgyvDzmv
X-Google-Smtp-Source: ABdhPJzK46mG2BSHhTWnu+fd5n6CcRlZDW9nge+oJcbEF0ymg0uGs0lZ2crQSyhrSCU+gJYdyh53TA==
X-Received: by 2002:a37:6c1:: with SMTP id 184mr42617755qkg.381.1608137380271;
        Wed, 16 Dec 2020 08:49:40 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h26sm1270164qtq.18.2020.12.16.08.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:49:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 2/6] btrfs: only let one thread pre-flush delayed refs in commit
Date:   Wed, 16 Dec 2020 11:49:30 -0500
Message-Id: <22da6e5f334b5ec148147c8382033e849cf0d7e9.1608137316.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608137316.git.josef@toxicpanda.com>
References: <cover.1608137316.git.josef@toxicpanda.com>
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
index f51f9e39bcee..9c39b5c3f0fc 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -911,7 +911,8 @@ bool btrfs_should_end_transaction(struct btrfs_trans_handle *trans)
 
 	smp_mb();
 	if (cur_trans->state >= TRANS_STATE_COMMIT_START ||
-	    cur_trans->delayed_refs.flushing)
+	    test_bit(BTRFS_DELAYED_REFS_FLUSHING,
+		     &cur_trans->delayed_refs.flags))
 		return true;
 
 	return should_end_transaction(trans);
@@ -2043,23 +2044,22 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
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

