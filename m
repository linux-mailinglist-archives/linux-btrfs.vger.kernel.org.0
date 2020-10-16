Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6132908E2
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 17:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408856AbgJPPwp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 11:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410434AbgJPPwm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 11:52:42 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9DDC0613D3
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:52:42 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b69so2273513qkg.8
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=u29MibVRrdeOz/BunwXkCITdu8XVwuKE95DxmNprRV4=;
        b=BT/xPyWBTPNbnpHX10JbDI0X99G+K96x0CaHEHLlMJqgH+kG+jl6AIpZ9VrgCTEHgo
         1QyHwnw1sEhrGdZjUR/IvhtLB4Fjg7xmf2FgR2qcMphHWwlYHVaqo8BBlSyFMhwwQwaZ
         jauu19SKv/aU0v9rVEOk2TIJpz67YRAk4ASLxBhyrA6FXvKCgF9cH/NK72/gAQtz7A86
         YajLmzBelqpG1uKBtIcar1ICkxjb1KYYJRFf950pM/MUQj7v00+jufnTkz1zNeMRE8UO
         UTgYA1IL6Adr2oUqn6QUfZNn+w2WL3XgBVN3uD7rDn56lzVOHYhrZiek5D7FmMZDUgwC
         MLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u29MibVRrdeOz/BunwXkCITdu8XVwuKE95DxmNprRV4=;
        b=b1HOeIof9z72KekY96ZzehPNwy543OFjr5OebSgrZlzw3Qrj2s/4nMTjYwyarSgOLm
         D5fcf8nty+nBoNOCtbY3sf4NDPfociNVGcxxNEwIEG3w92cgqjHjkOCQHl+FW8j+7tpW
         2xceyJ0bU54WggBVg9+QyCQ+oAgMmp/8xAThxi8LOcJTTQVNZTbzp4ULPPenr/1BKsA9
         cp2i1e8FONPK3eDgEmIW3MtKAxT51PTPHW35rQV6xyv3kFlgZmqt/NtqLoJyKCr5ZLeh
         gt/S4uZQ9BDYNiV4uart6N5dRwaY/XRBxEO36WZlQsecZx3M8XLHwKqzHomYE6kVbAVd
         caEg==
X-Gm-Message-State: AOAM530zyfmZvTPFxh2zxVexl7SX/nETqRL56sGXZH7IdHWPD4j30IHt
        laqUdXMsMB2zV2BUdo2T2K8CeECbsQVRLAC3
X-Google-Smtp-Source: ABdhPJwhv+oNbQDWnpAqixddVQLSaeaLOB/SS+CRbCwrB8qkNyxhYqv1uFem+Zjp4xYWv9Y2vjvWxQ==
X-Received: by 2002:a05:620a:19:: with SMTP id j25mr4545614qki.498.1602863560977;
        Fri, 16 Oct 2020 08:52:40 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j16sm1013082qkg.26.2020.10.16.08.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 08:52:40 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/6] btrfs: only let one thread pre-flush delayed refs in commit
Date:   Fri, 16 Oct 2020 11:52:31 -0400
Message-Id: <67141376f81981ed0a54df7c002a9599f48d7ee2.1602863482.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1602863482.git.josef@toxicpanda.com>
References: <cover.1602863482.git.josef@toxicpanda.com>
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
index 52ada47aff50..f73f3c7aeda2 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -870,9 +870,9 @@ int btrfs_should_end_transaction(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_transaction *cur_trans = trans->transaction;
 
-	smp_mb();
 	if (cur_trans->state >= TRANS_STATE_COMMIT_START ||
-	    cur_trans->delayed_refs.flushing)
+	    test_bit(BTRFS_DELAYED_REFS_FLUSHING,
+		     &cur_trans->delayed_refs.flags))
 		return 1;
 
 	return should_end_transaction(trans);
@@ -2042,23 +2042,22 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
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

