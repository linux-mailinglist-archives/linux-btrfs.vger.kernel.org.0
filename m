Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C494774B82
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 12:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfGYK1L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 06:27:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbfGYK1L (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 06:27:11 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38E6D22BEF
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2019 10:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564050429;
        bh=zIpctvcc75vGoGrIo5OrE6cE6+ok4OOkFKzceeW0Jqs=;
        h=From:To:Subject:Date:From;
        b=Bq7YvAp5oJTZcvsDZUv03UaPrV3PhscEOAQS/DhShR1YuSiQGb2y258SspjEe7EOT
         btqqZtnRqXeQzcNY6G6ZZDwhMudeehxSftJcyiffj5vyclZXrCTS/+i2QGM7v5zEVr
         fv33vLmc40rGmFZKXnP5HJIPvwiq0nipfLIAr+zY=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix race leading to fs corruption after transaction abortion
Date:   Thu, 25 Jul 2019 11:27:04 +0100
Message-Id: <20190725102704.11404-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When one transaction is finishing its commit, it is possible for another
transaction to start and enter its initial commit phase as well. If the
first ends up getting aborted, we have a small time window where the second
transaction commit does not notice that the previous transaction aborted
and ends up committing, writing a superblock that points to btrees that
reference extent buffers (nodes and leafs) that were not persisted to disk.
The consequence is that after mounting the filesystem again, we will be
unable to load some btree nodes/leafs, either because the content on disk
is either garbage (or just zeroes) or corresponds to the old content of a
previouly COWed or deleted node/leaf, resulting in the well known error
messages "parent transid verify failed on ...".
The following sequence diagram illustrates how this can happen.

        CPU 1                                           CPU 2

 <at transaction N>

 btrfs_commit_transaction()
   (...)
   --> sets transaction state to
       TRANS_STATE_UNBLOCKED
   --> sets fs_info->running_transaction
       to NULL

                                                    (...)
                                                    btrfs_start_transaction()
                                                      start_transaction()
                                                        wait_current_trans()
                                                          --> returns immediately
                                                              because
                                                              fs_info->running_transaction
                                                              is NULL
                                                        join_transaction()
                                                          --> creates transaction N + 1
                                                          --> sets
                                                              fs_info->running_transaction
                                                              to transaction N + 1
                                                          --> adds transaction N + 1 to
                                                              the fs_info->trans_list list
                                                        --> returns transaction handle
                                                            pointing to the new
                                                            transaction N + 1
                                                    (...)

                                                    btrfs_sync_file()
                                                      btrfs_start_transaction()
                                                        --> returns handle to
                                                            transaction N + 1
                                                      (...)

   btrfs_write_and_wait_transaction()
     --> writeback of some extent
         buffer fails, returns an
	 error
   btrfs_handle_fs_error()
     --> sets BTRFS_FS_STATE_ERROR in
         fs_info->fs_state
   --> jumps to label "scrub_continue"
   cleanup_transaction()
     btrfs_abort_transaction(N)
       --> sets BTRFS_FS_STATE_TRANS_ABORTED
           flag in fs_info->fs_state
       --> sets aborted field in the
           transaction and transaction
	   handle structures, for
           transaction N only
     --> removes transaction from the
         list fs_info->trans_list
                                                      btrfs_commit_transaction(N + 1)
                                                        --> transaction N + 1 was not
							    aborted, so it proceeds
                                                        (...)
                                                        --> sets the transaction's state
                                                            to TRANS_STATE_COMMIT_START
                                                        --> does not find the previous
                                                            transaction (N) in the
                                                            fs_info->trans_list, so it
                                                            doesn't know that transaction
                                                            was aborted, and the commit
                                                            of transaction N + 1 proceeds
                                                        (...)
                                                        --> sets transaction N + 1 state
                                                            to TRANS_STATE_UNBLOCKED
                                                        btrfs_write_and_wait_transaction()
                                                          --> succeeds writing all extent
                                                              buffers created in the
                                                              transaction N + 1
                                                        write_all_supers()
                                                           --> succeeds
                                                           --> we now have a superblock on
                                                               disk that points to trees
                                                               that refer to at least one
                                                               extent buffer that was
                                                               never persisted

So fix this by updating the transaction commit path to check if the flag
BTRFS_FS_STATE_TRANS_ABORTED is set on fs_info->fs_state if after setting
the transaction to the TRANS_STATE_COMMIT_START we do not find any previous
transaction in the fs_info->trans_list. If the flag is set, just fail the
transaction commit with -EROFS, as we do in other places. The exact error
code for the previous transaction abort was already logged and reported.

Fixes: 49b25e0540904b ("btrfs: enhance transaction abort infrastructure")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 3f6811cdf803..7b8bd9046229 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2019,6 +2019,17 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 		}
 	} else {
 		spin_unlock(&fs_info->trans_lock);
+		/*
+		 * The previous transaction was aborted and was already removed
+		 * from the list of transactions at fs_info->trans_list. So we
+		 * abort to prevent writing a new superblock that reflects a
+		 * corrupt state (pointing to trees with unwritten nodes/leafs).
+		 */
+		if (test_bit(BTRFS_FS_STATE_TRANS_ABORTED,
+			     &fs_info->fs_state)) {
+			ret = -EROFS;
+			goto cleanup_transaction;
+		}
 	}
 
 	extwriter_counter_dec(cur_trans, trans->type);
-- 
2.11.0

