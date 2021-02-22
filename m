Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E41321D3F
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 17:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhBVQmI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 11:42:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:45986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231432AbhBVQlh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 11:41:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614012050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EKilcul9G/e4GH+A6FMT6v3EeVvYjNLbh5syLphAIZE=;
        b=s5l13WL7NnPDMYW6FGJMvXRQ/H6PpMj19ttFJaBp7pM2dHFWio+W2S5fnkar9JenaX2RzB
        wKDz8fRnnLIkbMzH3UEBj/ufuKZx4tNz+ugJW7Qbgj0k4anc0RP1y3TmINvMjNKtI5SmM3
        vPckalVi7DIhaGCd7IRe1KallWL8lrE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 119ACB117;
        Mon, 22 Feb 2021 16:40:50 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4/6] btrfs: Cleanup try_flush_qgroup
Date:   Mon, 22 Feb 2021 18:40:45 +0200
Message-Id: <20210222164047.978768-5-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210222164047.978768-1-nborisov@suse.com>
References: <20210222164047.978768-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's no longer expected to call this function with an open transaction
so all the hacks concerning this can be removed. In fact it'll
constitute a bug to call this function with a transaction already held
so WARN in this case.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/qgroup.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index fbef95bc3557..c9e82e0c88e3 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3535,37 +3535,19 @@ static int try_flush_qgroup(struct btrfs_root *root)
 {
 	struct btrfs_trans_handle *trans;
 	int ret;
-	bool can_commit = true;
 
-	/*
-	 * If current process holds a transaction, we shouldn't flush, as we
-	 * assume all space reservation happens before a transaction handle is
-	 * held.
-	 *
-	 * But there are cases like btrfs_delayed_item_reserve_metadata() where
-	 * we try to reserve space with one transction handle already held.
-	 * In that case we can't commit transaction, but at least try to end it
-	 * and hope the started data writes can free some space.
-	 */
-	if (current->journal_info &&
-	    current->journal_info != BTRFS_SEND_TRANS_STUB)
-		can_commit = false;
+	/* Can't hold an open transaction or we run the risk of deadlocking. */
+	ASSERT(current->journal_info == NULL ||
+	       current->journal_info == BTRFS_SEND_TRANS_STUB);
+	if (WARN_ON(current->journal_info &&
+		     current->journal_info != BTRFS_SEND_TRANS_STUB))
+		return 0;
 
 	/*
 	 * We don't want to run flush again and again, so if there is a running
 	 * one, we won't try to start a new flush, but exit directly.
 	 */
 	if (test_and_set_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state)) {
-		/*
-		 * We are already holding a transaction, thus we can block other
-		 * threads from flushing.  So exit right now. This increases
-		 * the chance of EDQUOT for heavy load and near limit cases.
-		 * But we can argue that if we're already near limit, EDQUOT is
-		 * unavoidable anyway.
-		 */
-		if (!can_commit)
-			return 0;
-
 		wait_event(root->qgroup_flush_wait,
 			!test_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state));
 		return 0;
@@ -3582,10 +3564,7 @@ static int try_flush_qgroup(struct btrfs_root *root)
 		goto out;
 	}
 
-	if (can_commit)
-		ret = btrfs_commit_transaction(trans);
-	else
-		ret = btrfs_end_transaction(trans);
+	ret = btrfs_commit_transaction(trans);
 out:
 	clear_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state);
 	wake_up(&root->qgroup_flush_wait);
-- 
2.25.1

