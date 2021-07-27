Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F373D731A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbhG0KZA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:25:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236288AbhG0KYt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:24:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A8B8615E6
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 10:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627381489;
        bh=/iqA1sigBkzrt7RdQ9RM0tmbFRD2Z8F5kwMoqPwGJ+A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oJEF55rcw25CLzCoLMffTuvNjwh9NPqan695zTjgLDsYrXdSj7pUhHHgQrkLAiAzY
         ShgYRr1u+k0gW3V7qJzwdO+e5ElHd0SeEVrBK97Vcrp5qlAdG87yYwyEYsHUqYt+Ff
         5BHYy2i8ksPkZVbtjqVp5rwfkp/h+memXrlJzSbXL5FTQ1AcvjoU4S0dmimUfWjGmE
         i4Zrgvd/WFk9ZhKvVBogxgHB/PvnSZ7uwC8x6QSlEXiVrIdEXQIkmqTm+k7aNZLgMY
         NyNeau691vlxj5z3Lx+1Is20tHiLoMkrsYWZNPgvoPNJqbUNBqjHjQLyfED5PVIhtr
         nRxwAkV37aI5w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: eliminate some false positives when checking if inode was logged
Date:   Tue, 27 Jul 2021 11:24:44 +0100
Message-Id: <307aaa44d39ad115e299bfe7d1f7e3eb4e991374.1627379796.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1627379796.git.fdmanana@suse.com>
References: <cover.1627379796.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When checking if an inode was previously logged in the current transaction
through the helper inode_logged(), we can return some false positives that
can be easily eliminated. These correspond to the cases where an inode has
a ->logged_trans value that is not zero and its value is smaller then the
ID of the current transaction. This means we know exactly that the inode
was never logged before in the current transaction, so we can return false
and avoid the callers to do extra work:

1) Having btrfs_del_dir_entries_in_log() and btrfs_del_inode_ref_in_log()
   unnecessarily join a log transaction and do deletion searches in a log
   tree that will not find anything. This just adds unnecessary contention
   on extent buffer locks;

2) Having btrfs_log_new_name() unnecessarily log an inode when it is not
   needed. If the inode was not logged before, we don't need to log it in
   LOG_INODE_EXISTS mode.

So just make sure that any false positive only happens when ->logged_trans
has a value of 0.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8dde5c08a48f..fc98b7a7a8e6 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3421,14 +3421,10 @@ int btrfs_free_log_root_tree(struct btrfs_trans_handle *trans,
 }
 
 /*
- * Check if an inode was logged in the current transaction. We can't always rely
- * on an inode's logged_trans value, because it's an in-memory only field and
- * therefore not persisted. This means that its value is lost if the inode gets
- * evicted and loaded again from disk (in which case it has a value of 0, and
- * certainly it is smaller then any possible transaction ID), when that happens
- * the full_sync flag is set in the inode's runtime flags, so on that case we
- * assume eviction happened and ignore the logged_trans value, assuming the
- * worst case, that the inode was logged before in the current transaction.
+ * Check if an inode was logged in the current transaction. This may often
+ * return some false positives, because logged_trans is an in memory only field,
+ * not persisted anywhere. This is meant to be used in contexts where a false
+ * positive has no functional consequences.
  */
 static bool inode_logged(struct btrfs_trans_handle *trans,
 			 struct btrfs_inode *inode)
@@ -3436,7 +3432,18 @@ static bool inode_logged(struct btrfs_trans_handle *trans,
 	if (inode->logged_trans == trans->transid)
 		return true;
 
-	if (inode->last_trans == trans->transid &&
+	/*
+	 * The inode's logged_trans is always 0 when we load it (because it is
+	 * not persisted in the inode item or elsewhere). So if it is 0, the
+	 * inode was last modified in the current transaction and has the
+	 * full_sync flag set, then the inode may have been logged before in
+	 * the current transaction, then evicted and loaded again in the current
+	 * transaction - or may have never been logged in the current transaction,
+	 * but since we can not be sure, we have to assume it was, otherwise our
+	 * callers can leave an inconsistent log.
+	 */
+	if (inode->logged_trans == 0 &&
+	    inode->last_trans == trans->transid &&
 	    test_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags) &&
 	    !test_bit(BTRFS_FS_LOG_RECOVERING, &trans->fs_info->flags))
 		return true;
-- 
2.28.0

