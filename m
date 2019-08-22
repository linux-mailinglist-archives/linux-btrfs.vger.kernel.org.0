Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1904498C65
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 09:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbfHVHZQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 03:25:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:36182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728104AbfHVHZQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 03:25:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E0C9FAE1C
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 07:25:14 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: transaction: Add comment for btrfs transaction lifespan
Date:   Thu, 22 Aug 2019 15:24:59 +0800
Message-Id: <20190822072500.22730-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just a overview of the basic btrfs transaction lifespan, including the
following states:
- No transaction states
- Transaction N [[TRANS_STATE_RUNNING]]
- Transaction N [[TRANS_STATE_COMMIT_START]]
- Transaction N [[TRANS_STATE_COMMIT_DOING]]
- Transaction N [[TRANS_STATE_UNBLOCKED]]
- Transaction N [[TRANS_STATE_COMPLETED]]

For each states, the comment will include:
- Basic explaination about current state
- How to go next stage
- What will happen if we call variant start_transaction() functions
- Relationship to transaction N+1

This doesn't provide much tech details, but just a cheat sheet for
reader to get into the code a little easier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/transaction.c | 70 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index e3adb714c04b..6568eca28b43 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -22,6 +22,76 @@
 
 #define BTRFS_ROOT_TRANS_TAG 0
 
+/*
+ * About btrfs transaction lifespan.
+ *
+ * No running transaction (fs tree blocks are not modified)
+ * |
+ * | To next stage:
+ * |  Call start_transaction() variants. Except btrfs_join_transaction_nostart().
+ * V
+ * Transaction N [[TRANS_STATE_RUNNING]]
+ * |
+ * | New trans handles can be attached to transaction N by calling all
+ * | start_transaction() variants.
+ * |
+ * | To next stage:
+ * |  Call btrfs_commit_transaction() on any trans handler attached to
+ * |  transaction N
+ * V
+ * Transaction N [[TRANS_STATE_COMMIT_START]]
+ * |
+ * | Will wait previous running transaction to completely finish if we have.
+ * |
+ * | Then either:
+ * | - Wait all other trans handler holder to release.
+ * |   This btrfs_commit_transaction() caller will do the commit work.
+ * | - Wait current transaction to be committed by others.
+ * |   Other btrfs_commit_transaction() caller will do the commit work.
+ * |
+ * | At this stage, only btrfs_join_transaction*() variants can attach
+ * | to this running transaction.
+ * | All other variants will wait current one to finish and attach to
+ * | transaction N+1.
+ * |
+ * | To next stage:
+ * |  Caller is chosen to commit transaction N, and all other trans handlers
+ * |  haven been release.
+ * V
+ * Transaction N [[TRANS_STATE_COMMIT_DOING]]
+ * |
+ * | Heavy lift transaction is started.
+ * | From running delayed refs (modifying extent tree) to creating pending
+ * | snapshots, running qgroups.
+ * | In short, modify supporting trees to reflect modifications of subvolume
+ * | trees.
+ * |
+ * | At this stage, all start_transaction() calls will wait this transaction
+ * | to finish and attach to transaction N+1.
+ * |
+ * | To next stage:
+ * |  Until all supporting trees are updated.
+ * V
+ * Transaction N [[TRANS_STATE_UNBLOCKED]]
+ * |						    Transaction N+1
+ * | All needed trees are modified, thus only	    [[TRANS_STATE_RUNNING]]
+ * | need to write them back to disk and update	    |
+ * | super blocks.				    |
+ * |						    |
+ * | At this stage, new transaction is allowed to   |
+ * | start.					    |
+ * | All new start_transaction() calls will be	    |
+ * | attached to transid N+1.			    |
+ * |						    |
+ * | To next stage:				    |
+ * |  Until all tree blocks are super blocks are    |
+ * |  written to block device(s)		    |
+ * V						    |
+ * Transaction N [[TRANS_STATE_COMPLETED]]	    V
+ *   All tree blocks and super blocks are written.  Transaction N+1
+ *   This transaction is finished and all its	    [[TRANS_STATE_COMMIT_START]]
+ *   data structures will be cleaned up.	    | Life goes on
+ */
 static const unsigned int btrfs_blocked_trans_types[TRANS_STATE_MAX] = {
 	[TRANS_STATE_RUNNING]		= 0U,
 	[TRANS_STATE_BLOCKED]		=  __TRANS_START,
-- 
2.23.0

