Return-Path: <linux-btrfs+bounces-16656-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B907B45D8C
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9941C8071A
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0214530B50E;
	Fri,  5 Sep 2025 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFUD3Uzd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F64302145
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088649; cv=none; b=YyLY2Vz11WBNG8IsDkTff4amb1wL2qDWo/amYaRrDfpOcSqQxU1RWj6s9xjoYIZQyQHfSMSDggWwwkHye5e8BYcABRiBa9yf7O8BOrBn45Fb+O62kCO5iclkZu+1w5bttI+3SHxCJMAlUpjV/RjKIjb2oJcvKHMuRZIJc9a32HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088649; c=relaxed/simple;
	bh=4xxrQWf593XOTxYj3rfQlOtkZWgy9ifieezTBvowdWM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsJTwoQ9p7guDcUnG1KSOjb+gMlgfaFXTNdOWRLEWNvZJ8vrnz4OLGQbqajcYD7XlTE+6FYcXa4FvUTFFE3bgf9o55UmG/FO9W5hNsxwbXDFEA//XXf4AfojAT0gsI2WxHnJMIuBPHINoJmCb2aGXUrBnae9fmZn1CawQZ1TLH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFUD3Uzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EA5C4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088649;
	bh=4xxrQWf593XOTxYj3rfQlOtkZWgy9ifieezTBvowdWM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iFUD3UzduqzCFAuLr1kWotrTwhRjybVCfewK1WW+hZZneTjizK0/zW8wQEqQMBzyC
	 dk7GHnr77uEYhHR03OBJAzR4X1E2u/Bm66ElBxZuKlGOio2/Hpn/AUCCh422ykeX+R
	 NvLniUFKbnmOUC2ZbHFFBaOhwnGV+y0ayNzVx37SzhXMV+PYmrvSLp9+AMAn0BqQRq
	 4WIJteM2BFIhElnG9XhNWH3QcRLlyMknXp4ygnCkeXDEqwCdx1MyixBg9vK51RY9o/
	 fkoDYcTB3DzBTpohZb5lw0iJnM5qvdxeOX11t224/kCFU0xvW+tljzOJI5h0EvDcEB
	 Nv7NP6QyyhQGQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 12/33] btrfs: pass walk_control structure to replay_dir_deletes()
Date: Fri,  5 Sep 2025 17:10:00 +0100
Message-ID: <6c85664cf3460d9c56ea48d1debca9f09cf0e5e2.1757075118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757075118.git.fdmanana@suse.com>
References: <cover.1757075118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of passing the transaction, subvolume root and log tree as
arguments to replay_dir_deletes(), pass the walk_control structure as
we can grab all of those from the structure. This reduces the number of
arguments passed and it's going to be needed by an incoming change that
improves error reporting for log replay. This also requires changing
fixup_inode_link_counts() and fixup_inode_link_count() to take that
structure as an argument since fixup_inode_link_count() makes a call
to replay_dir_deletes().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 2780f0e1db01..460dc51e8c82 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -159,9 +159,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 static int link_to_fixup_dir(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
 			     struct btrfs_path *path, u64 objectid);
-static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
-				       struct btrfs_root *root,
-				       struct btrfs_root *log,
+static noinline int replay_dir_deletes(struct walk_control *wc,
 				       struct btrfs_path *path,
 				       u64 dirid, bool del_all);
 static void wait_log_commit(struct btrfs_root *root, int transid);
@@ -1727,9 +1725,10 @@ static int count_inode_refs(struct btrfs_inode *inode, struct btrfs_path *path)
  * number of back refs found.  If it goes down to zero, the iput
  * will free the inode.
  */
-static noinline int fixup_inode_link_count(struct btrfs_trans_handle *trans,
+static noinline int fixup_inode_link_count(struct walk_control *wc,
 					   struct btrfs_inode *inode)
 {
+	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_root *root = inode->root;
 	struct btrfs_path *path;
 	int ret;
@@ -1765,7 +1764,7 @@ static noinline int fixup_inode_link_count(struct btrfs_trans_handle *trans,
 
 	if (inode->vfs_inode.i_nlink == 0) {
 		if (S_ISDIR(inode->vfs_inode.i_mode)) {
-			ret = replay_dir_deletes(trans, root, NULL, path, ino, true);
+			ret = replay_dir_deletes(wc, path, ino, true);
 			if (ret)
 				goto out;
 		}
@@ -1779,8 +1778,7 @@ static noinline int fixup_inode_link_count(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static noinline int fixup_inode_link_counts(struct btrfs_trans_handle *trans,
-					    struct btrfs_root *root,
+static noinline int fixup_inode_link_counts(struct walk_control *wc,
 					    struct btrfs_path *path)
 {
 	int ret;
@@ -1790,6 +1788,8 @@ static noinline int fixup_inode_link_counts(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_ORPHAN_ITEM_KEY;
 	key.offset = (u64)-1;
 	while (1) {
+		struct btrfs_trans_handle *trans = wc->trans;
+		struct btrfs_root *root = wc->root;
 		struct btrfs_inode *inode;
 
 		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
@@ -1819,7 +1819,7 @@ static noinline int fixup_inode_link_counts(struct btrfs_trans_handle *trans,
 			break;
 		}
 
-		ret = fixup_inode_link_count(trans, inode);
+		ret = fixup_inode_link_count(wc, inode);
 		iput(&inode->vfs_inode);
 		if (ret)
 			break;
@@ -2455,12 +2455,13 @@ static int replay_xattr_deletes(struct walk_control *wc,
  * Anything we don't find in the log is unlinked and removed from the
  * directory.
  */
-static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
-				       struct btrfs_root *root,
-				       struct btrfs_root *log,
+static noinline int replay_dir_deletes(struct walk_control *wc,
 				       struct btrfs_path *path,
 				       u64 dirid, bool del_all)
 {
+	struct btrfs_trans_handle *trans = wc->trans;
+	struct btrfs_root *root = wc->root;
+	struct btrfs_root *log = (del_all ? NULL : wc->log);
 	u64 range_start;
 	u64 range_end;
 	int ret = 0;
@@ -2650,8 +2651,7 @@ static int replay_one_buffer(struct extent_buffer *eb,
 				break;
 			mode = btrfs_inode_mode(eb, inode_item);
 			if (S_ISDIR(mode)) {
-				ret = replay_dir_deletes(trans, root, log, path,
-							 key.objectid, false);
+				ret = replay_dir_deletes(wc, path, key.objectid, false);
 				if (ret)
 					break;
 			}
@@ -7530,7 +7530,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		if (wc.stage == LOG_WALK_REPLAY_ALL) {
 			struct btrfs_root *root = wc.root;
 
-			ret = fixup_inode_link_counts(trans, root, path);
+			ret = fixup_inode_link_counts(&wc, path);
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
 				goto next;
-- 
2.47.2


