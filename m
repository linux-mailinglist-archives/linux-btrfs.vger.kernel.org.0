Return-Path: <linux-btrfs+bounces-15741-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1427CB151CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 19:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B299174CE9
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 17:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3F928DF27;
	Tue, 29 Jul 2025 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+Uece/p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADF522B594
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Jul 2025 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753808541; cv=none; b=b9zZ6URQWfEd0ZOU7p3Ek1mtz0ZorVf17O9/MhUlyHkRn1sXZCHmZZF8jjxtunjlaPcu1WuvFBb+r9WZAxP+6QO4uEyYkx331Hzlgvtttq3443YfECJC+UVEARUHOW/hKCPNQ6cWKpsx4Sc6x9jGs/sum2weR6dXHf5g9TJOads=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753808541; c=relaxed/simple;
	bh=FScdU0ywJAOENpD3J7uqADOOLh1qIErqRJGz/i08+ss=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JzHSPdGrph7FoECXiQj3SuHa7ogc8vksXllzoBU3akDXRRSZjRU2XrxdEqzbFvOTyVOSHtMdxy3VPc8yiUo4iNIecp/eAE/VrE82bXPR7PInZM8kH/tBpGhGiz+K4M3dU7r0IfSKJUcKG+t6INTX5wz0YBLRDKm0umsatv4+NeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+Uece/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C72C4CEEF
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Jul 2025 17:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753808540;
	bh=FScdU0ywJAOENpD3J7uqADOOLh1qIErqRJGz/i08+ss=;
	h=From:To:Subject:Date:From;
	b=K+Uece/p3/+sn/GK28LN+P84zxbKc1UyTP06hE9ITodEzqNvAIWYVtYCNQS3hjSZI
	 DZ+O8uryAKHzW2spzetMS7LQSsw7fj5tXYlbOV0Hs7y+dqIM5wUFna2XqFYpM56dzA
	 fBtgmipc5Lq996yJ1MeC5rm/T6DwV3kj4TMV1HdkwQpLHaQtllz1la5TP0FADL6VtY
	 17GO/fG1rGn2oZ1jYk7S0q/wIUrCLRV65vwcwChcCwtR1RRJa2c9Gks8WSNs5dksCm
	 Op45EFSjWhHEkUJYT7x5g2k2XS5MjNQO9/WxCAluVnY2PrDRCDBtWYQ9MWDLpG8NBD
	 kid+c8heN8Rkg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix race between logging inode and checking if it was logged before
Date: Tue, 29 Jul 2025 18:02:05 +0100
Message-ID: <7585d15c0e9c163d5cdf32307014a4e792e62541.1753807163.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's a race between checking if an inode was logged before and logging
an inode that can cause us to mark an inode as not logged just after it
was logged by a concurrent task:

1) We have inode X which was not logged before neither in the current
   transaction not in past transaction since the inode was loaded into
   memory, so it's ->logged_trans value is 0;

2) We are at transaction N;

3) Task A calls inode_logged() against inode X, sees that ->logged_trans
   is 0 and there is a log tree and so it proceeds to search in the log
   tree for an inode item for inode X. It doesn't see any, but before
   it sets ->logged_trans to N - 1...

3) Task B calls btrfs_log_inode() against inode X, logs the inode and
   sets ->logged_trans to N;

4) Task A now sets ->logged_trans to N - 1;

5) At this point anyone calling inode_logged() gets 0 (inode not logged)
   since ->logged_trans is greater than 0 and less than N, but our inode
   was really logged. As a consequence operations like rename, unlink and
   link that happen afterwards in the current transaction end up not
   updating the log when they should.

The same type of race happens in case our inode is a directory when we
update the inode's ->last_dir_index_offset field at inode_logged() to
(u64)-1, and in that case such a race could make directory logging skip
logging new entries at process_dir_items_leaf(), since any new dir entry
has an index less than (u64).

Fix this by ensuring inode_logged() is always called while holding the
inode's log_mutex.

Fixes: 0f8ce49821de ("btrfs: avoid inode logging during rename and link when possible")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 43a96fb27bce..8c6d1eb84d0e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3485,14 +3485,27 @@ int btrfs_free_log_root_tree(struct btrfs_trans_handle *trans,
  * Returns 1 if the inode was logged before in the transaction, 0 if it was not,
  * and < 0 on error.
  */
-static int inode_logged(const struct btrfs_trans_handle *trans,
-			struct btrfs_inode *inode,
-			struct btrfs_path *path_in)
+static int inode_logged_locked(const struct btrfs_trans_handle *trans,
+			       struct btrfs_inode *inode,
+			       struct btrfs_path *path_in)
 {
 	struct btrfs_path *path = path_in;
 	struct btrfs_key key;
 	int ret;
 
+	/*
+	 * The log_mutex must be taken to prevent races with concurrent logging
+	 * as we may see the inode not logged when we are called but it gets
+	 * logged right after we did not find it in the log tree and we end up
+	 * setting inode->logged_trans to a value less than trans->transid after
+	 * the concurrent logging task has set it to trans->transid. As a
+	 * consequence, subsequent rename, unlink and link operations may end up
+	 * not logging new names and removing old names from the log.
+	 * The same type of race also happens if out inode is a directory when
+	 * we update inode->last_dir_index_offset below.
+	 */
+	lockdep_assert_held(&inode->log_mutex);
+
 	if (inode->logged_trans == trans->transid)
 		return 1;
 
@@ -3594,6 +3607,19 @@ static int inode_logged(const struct btrfs_trans_handle *trans,
 	return 1;
 }
 
+static inline int inode_logged(const struct btrfs_trans_handle *trans,
+			       struct btrfs_inode *inode,
+			       struct btrfs_path *path)
+{
+	int ret;
+
+	mutex_lock(&inode->log_mutex);
+	ret = inode_logged_locked(trans, inode, path);
+	mutex_unlock(&inode->log_mutex);
+
+	return ret;
+}
+
 /*
  * Delete a directory entry from the log if it exists.
  *
@@ -6678,7 +6704,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	 * inode_logged(), because after that we have the need to figure out if
 	 * the inode was previously logged in this transaction.
 	 */
-	ret = inode_logged(trans, inode, path);
+	ret = inode_logged_locked(trans, inode, path);
 	if (ret < 0)
 		goto out_unlock;
 	ctx->logged_before = (ret == 1);
-- 
2.47.2


