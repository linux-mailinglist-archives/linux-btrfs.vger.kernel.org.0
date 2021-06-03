Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FDC39A47F
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jun 2021 17:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhFCPYz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Jun 2021 11:24:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46786 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhFCPYz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Jun 2021 11:24:55 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9124221A01;
        Thu,  3 Jun 2021 15:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622733789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/uGzbvHi07RSQCm2ksenXVfLi37DX4LI6jdkL0poEA=;
        b=NFiCN8hFKJQtQvi0L9WD5mIA0xnS7CD52YLleVXhqFrzE2NC3y30ZjSFGimXklOE3DTgPH
        6hPv5+UPTVKH2ywXLZ6vcr6Ke33nEDgjmJQArixJmEINevAdGx9z+XyH2cEgmxQHgk6ACU
        CHAe8xNU+HosMS6CG9r+53BmwhuE2uc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8A338A3B96;
        Thu,  3 Jun 2021 15:23:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A090DDA734; Thu,  3 Jun 2021 17:20:28 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/4] btrfs: remove fs_info::transaction_blocked_wait
Date:   Thu,  3 Jun 2021 17:20:28 +0200
Message-Id: <2451f25c6c27f0e3e51774b95efc709bc9abf572.1622733245.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622733245.git.dsterba@suse.com>
References: <cover.1622733245.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Previous commit removed last use of transaction_blocked_wait. There were
still the waking call sites, that are now without use as there's nothing
populating the wait list.

As wake_up has a memory barrier semantics, it's directly replaced by
smp_mb. The transaction state TRANS_STATE_COMMIT_START is now perhaps
trivial, but there's more code relying on that, it's left in place to
keep the behaviour as close as possible to the original code.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h       | 1 -
 fs/btrfs/disk-io.c     | 5 ++---
 fs/btrfs/super.c       | 1 -
 fs/btrfs/transaction.c | 3 ++-
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c601f6733576..384c00c982ab 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -683,7 +683,6 @@ struct btrfs_fs_info {
 	struct btrfs_transaction *running_transaction;
 	wait_queue_head_t transaction_throttle;
 	wait_queue_head_t transaction_wait;
-	wait_queue_head_t transaction_blocked_wait;
 	wait_queue_head_t async_submit_wait;
 
 	/*
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d1d5091a8385..bad7df788458 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2986,7 +2986,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 
 	init_waitqueue_head(&fs_info->transaction_throttle);
 	init_waitqueue_head(&fs_info->transaction_wait);
-	init_waitqueue_head(&fs_info->transaction_blocked_wait);
 	init_waitqueue_head(&fs_info->async_submit_wait);
 	init_waitqueue_head(&fs_info->delayed_iputs_wait);
 
@@ -4918,8 +4917,8 @@ void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans,
 	btrfs_destroy_delayed_refs(cur_trans, fs_info);
 
 	cur_trans->state = TRANS_STATE_COMMIT_START;
-	wake_up(&fs_info->transaction_blocked_wait);
-
+	/* Serialize state change, but there are no waiters */
+	smp_mb();
 	cur_trans->state = TRANS_STATE_UNBLOCKED;
 	wake_up(&fs_info->transaction_wait);
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index bc613218c8c5..8d87da2b2377 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -302,7 +302,6 @@ void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
 	WRITE_ONCE(trans->transaction->aborted, errno);
 	/* Wake up anybody who may be waiting on this transaction */
 	wake_up(&fs_info->transaction_wait);
-	wake_up(&fs_info->transaction_blocked_wait);
 	__btrfs_handle_fs_error(fs_info, function, line, errno, NULL);
 }
 /*
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 5f3c95c876c8..1fd04170b0bf 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2057,7 +2057,8 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	}
 
 	cur_trans->state = TRANS_STATE_COMMIT_START;
-	wake_up(&fs_info->transaction_blocked_wait);
+	/* Serialize state change, but there are no waiters */
+	smp_mb();
 
 	if (cur_trans->list.prev != &fs_info->trans_list) {
 		enum btrfs_trans_state want_state = TRANS_STATE_COMPLETED;
-- 
2.31.1

