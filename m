Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674C62DE9BC
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 20:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733102AbgLRTZP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Dec 2020 14:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732799AbgLRTZN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Dec 2020 14:25:13 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE351C06138C
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 11:24:32 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 19so3045784qkm.8
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 11:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f0i7UcDlMhrQzsDs99QH8S1W6OSPcU/bY7DVRv5GcPQ=;
        b=WwciSwZ92dTBE+8I5PSX6JvU1DW9zckpNPntR5RCTHxwH0pdwjPG8//kbK3gSYcjJS
         BueAyuzNXpNMOL13GPYup7/DRKtfMXMjzJ5rqhQlcrLyZibbbogxlDIn+sFGF1s2/Nru
         THbKn7A0FS01FzT3t8Xn27XnbFJKHAU1Wo+k0pzATrJuG3Xp0DNw+LiG9I0LL64Q7kl3
         MUQgaDB0IDw1y8ORR+7roKQXliVOe09uM8B03JCpbSSq9fEtNotw3of/fB1aH/Hblxiz
         3dv3Aw2gth2cgXUG4bkUxlLu4vkX0oFgtP33r9ipBW/ztyEGE9Jk5JGlj8bRIx36oItA
         2D4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f0i7UcDlMhrQzsDs99QH8S1W6OSPcU/bY7DVRv5GcPQ=;
        b=mpReJc93QSn8SXdEzeDO3JYlVkcW+3GeLEVnk/cL2J4HuNEuuFM3fd71s6Uym3HdQz
         zzBXJZyVRK2kGkjoKpfco+r2YLSl8kZyrPPbuGQJRKGMeUaug+bZoQsGPXWK/sth0bL7
         i8WQ2Wo0CWqZd42fY85HZd6sSUuzoXNKDHkdP/o5Itz2ikqUkx85GsFNfIulsaoMfqp3
         4Gjqv80Bb9/pGV7kKdY/zx0aOA46t+Tt6SnU1PdR85fUp3gtb5IThY4hSw1Ci+l26BLe
         znvBTvJ+2bzf/hSWZkcIrIic+hTF6AWsMwrQPv/IURdub2AF2mHpLF3rEWNETpY0QiXr
         0pRw==
X-Gm-Message-State: AOAM533mI7Fz/wJ0Kbrs7pN/W4h2CemmxWC5KjBfiKYjcZjmLUz/c03y
        mEkX2pnVqO1Z2KLB3bZzaBkJUDEsljHVF8Sk
X-Google-Smtp-Source: ABdhPJwo1J98W8UV94Obg9hhRHvjASJyT/c1lG4PfTUrOVwdXSqYl/LGgX9Oos/ST5E51dml+eZa3Q==
X-Received: by 2002:a37:809:: with SMTP id 9mr6420198qki.156.1608319471655;
        Fri, 18 Dec 2020 11:24:31 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l1sm5913527qtb.42.2020.12.18.11.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 11:24:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v5 2/8] btrfs: only let one thread pre-flush delayed refs in commit
Date:   Fri, 18 Dec 2020 14:24:20 -0500
Message-Id: <9e47b11bdfe5b4905fdaa81e952de2e2466c6335.1608319304.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608319304.git.josef@toxicpanda.com>
References: <cover.1608319304.git.josef@toxicpanda.com>
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

