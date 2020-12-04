Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E1F2CE51A
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Dec 2020 02:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbgLDBZk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 20:25:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:43152 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgLDBZk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 20:25:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607045092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5PIpvmuZaDl9VaVMxnTTmEm2h7TrzkcCBH86M+MKl58=;
        b=q5KO7h1JynlRoZbrICEg2FNskAiWYTveg5kTolC5Eh49fEeT72trUuODbWZhJbSafXsNXI
        NgjbI5GZoj0Mg3Azd1kwjVWdm3QqEUbEJKENRemEsm+XorV+yCKkG2v9WKixfNgvyRr36K
        iUs6PzR2aKgCNJveDjXTOpl9bCoCXYc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B61C0ACBA
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Dec 2020 01:24:52 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: qgroup: don't try to wait flushing if we're already holding a transaction
Date:   Fri,  4 Dec 2020 09:24:47 +0800
Message-Id: <20201204012448.26546-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a chance of racing for qgroup flushing which may lead to
deadlock:

	Thread A		|	Thread B
   (no trans handler hold)	|  (already hold a trans handler)
--------------------------------+--------------------------------
__btrfs_qgroup_reserve_meta()   | __btrfs_qgroup_reserve_meta()
|- try_flush_qgroup()		| |- try_flushing_qgroup()
   |- QGROUP_FLUSHING bit set   |    |
   |				|    |- test_and_set_bit()
   |				|    |- wait_event()
   |- btrfs_join_transaction()	|
   |- btrfs_commit_transaction()|

			!!! DEAD LOCK !!!

Since thread A want to commit transaction, but thread B is hold a
transaction handler, blocking the commit.
At the same time, thread B is waiting thread A to finish it commit.

This is just a hot fix, and would lead to more EDQUOT when we're near
the qgroup limit.

The root fix would to make all metadata/data reservation to happen
without a transaction handler hold.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index fe3046007f52..7785dfa348d2 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3530,16 +3530,6 @@ static int try_flush_qgroup(struct btrfs_root *root)
 	int ret;
 	bool can_commit = true;
 
-	/*
-	 * We don't want to run flush again and again, so if there is a running
-	 * one, we won't try to start a new flush, but exit directly.
-	 */
-	if (test_and_set_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state)) {
-		wait_event(root->qgroup_flush_wait,
-			!test_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state));
-		return 0;
-	}
-
 	/*
 	 * If current process holds a transaction, we shouldn't flush, as we
 	 * assume all space reservation happens before a transaction handle is
@@ -3554,6 +3544,27 @@ static int try_flush_qgroup(struct btrfs_root *root)
 	    current->journal_info != BTRFS_SEND_TRANS_STUB)
 		can_commit = false;
 
+	/*
+	 * We don't want to run flush again and again, so if there is a running
+	 * one, we won't try to start a new flush, but exit directly.
+	 */
+	if (test_and_set_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state)) {
+		/*
+		 * We are already holding a trans, thus we can block other
+		 * threads from flushing.
+		 * So exit right now. This increases the chance of EDQUOT for
+		 * heavy load and near limit cases.
+		 * But we can argue that if we're already near limit, EDQUOT
+		 * is unavoidable anyway.
+		 */
+		if (!can_commit)
+			return 0;
+
+		wait_event(root->qgroup_flush_wait,
+			!test_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state));
+		return 0;
+	}
+
 	ret = btrfs_start_delalloc_snapshot(root);
 	if (ret < 0)
 		goto out;
-- 
2.29.2

