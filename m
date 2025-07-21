Return-Path: <linux-btrfs+bounces-15600-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A5CB0C96A
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 19:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0053AA7B9
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 17:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53AC2E2666;
	Mon, 21 Jul 2025 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAbGix63"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6DB2D9EF2
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118208; cv=none; b=GunXmDzdd6paU3VfcyEh9vkxc22K42B+l3ATshtoj0uxP7RCgX6GbHgeaTGlh6qmoYPLFxnflqFNPlNxwSqNaU6SrFQi5ZEVTs9TWdpx/meFGXHAflm1qd0GKdQ3tEAl0vZi1M9dzA+9QBq4cGyYEcmqgY0vRxfCs9DnlUEy5xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118208; c=relaxed/simple;
	bh=WNVvGga14quuQ309r8e7WkcjEtH6xzb1APeMT3Ib1A0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpqU/vcPVH1kW73x8aYwUiaDDAWWCQLVEWhHb6ff4sOo9udM5iyJ180fr2F9mY25mGG77dNrqWcxI2v0OGAFg9oL4r8ESzuVABW1ZxA5mATtJlk5ANfjJnVwn3fMMpxLTHBKuE1HelO9HDksQJCJcs2xPVRzT0RMvznXITtNEeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAbGix63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFC9C4CEF4
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753118207;
	bh=WNVvGga14quuQ309r8e7WkcjEtH6xzb1APeMT3Ib1A0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rAbGix63b5HgZ18w6mDeKLtk/8uILU5/MCqoWoTuwxTR2Mxz3UfKlX3GNZBZSOZ0W
	 HnF+6/4QC9toQcCK1vA/Oen7ixkE0/Wah4eHLS9t5wK+PuYascPT6GRX4Xy6wbTgni
	 oHtmia1w2yfmM28Mmqr3E5gvSdR2MZxBUkFc+pnSGTnfOpPdAKERPKV8qaNE7+hEgZ
	 MQahuy1gHJg9h0kDTyaIkU+e3QyCyMjoezPMvGrPgzup9yaortu3Z+aOFV4wy9SpRY
	 m2oTV6giOVH7AKZlNyTIiOfP4hgL4CI//awFdgjq38EtzLsYJQ11VUBsTLla4WfOjn
	 4ZbwQ2T2OPoIA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 04/10] btrfs: use local variable for the transaction handle in replay_one_buffer()
Date: Mon, 21 Jul 2025 18:16:31 +0100
Message-ID: <bd9e5e7a0d4eb661d11a0179de9ce48a4c9e24df.1753117707.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1753117707.git.fdmanana@suse.com>
References: <cover.1753117707.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of keep dereferencing the walk_control structure to extract the
transaction handle whenever is needed, do it once by storing it in a local
variable and then use the variable everywhere. This reduces code verbosity
and eliminates the need for some split lines.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 5e0c4c0595a7..0fff6716a7ed 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2464,6 +2464,7 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 	};
 	struct btrfs_path *path;
 	struct btrfs_root *root = wc->replay_dest;
+	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_key key;
 	int i;
 	int ret;
@@ -2507,19 +2508,17 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 			} else {
 				wc->ignore_cur_inode = false;
 			}
-			ret = replay_xattr_deletes(wc->trans, root, log,
-						   path, key.objectid);
+			ret = replay_xattr_deletes(trans, root, log, path, key.objectid);
 			if (ret)
 				break;
 			mode = btrfs_inode_mode(eb, inode_item);
 			if (S_ISDIR(mode)) {
-				ret = replay_dir_deletes(wc->trans, root, log, path,
+				ret = replay_dir_deletes(trans, root, log, path,
 							 key.objectid, false);
 				if (ret)
 					break;
 			}
-			ret = overwrite_item(wc->trans, root, path,
-					     eb, i, &key);
+			ret = overwrite_item(trans, root, path, eb, i, &key);
 			if (ret)
 				break;
 
@@ -2546,21 +2545,19 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 				drop_args.start = from;
 				drop_args.end = (u64)-1;
 				drop_args.drop_cache = true;
-				ret = btrfs_drop_extents(wc->trans, root, inode,
-							 &drop_args);
+				ret = btrfs_drop_extents(trans, root, inode,  &drop_args);
 				if (!ret) {
 					inode_sub_bytes(&inode->vfs_inode,
 							drop_args.bytes_found);
 					/* Update the inode's nbytes. */
-					ret = btrfs_update_inode(wc->trans, inode);
+					ret = btrfs_update_inode(trans, inode);
 				}
 				iput(&inode->vfs_inode);
 				if (ret)
 					break;
 			}
 
-			ret = link_to_fixup_dir(wc->trans, root,
-						path, key.objectid);
+			ret = link_to_fixup_dir(trans, root, path, key.objectid);
 			if (ret)
 				break;
 		}
@@ -2570,8 +2567,7 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 
 		if (key.type == BTRFS_DIR_INDEX_KEY &&
 		    wc->stage == LOG_WALK_REPLAY_DIR_INDEX) {
-			ret = replay_one_dir_item(wc->trans, root, path,
-						  eb, i, &key);
+			ret = replay_one_dir_item(trans, root, path, eb, i, &key);
 			if (ret)
 				break;
 		}
@@ -2581,19 +2577,16 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 
 		/* these keys are simply copied */
 		if (key.type == BTRFS_XATTR_ITEM_KEY) {
-			ret = overwrite_item(wc->trans, root, path,
-					     eb, i, &key);
+			ret = overwrite_item(trans, root, path, eb, i, &key);
 			if (ret)
 				break;
 		} else if (key.type == BTRFS_INODE_REF_KEY ||
 			   key.type == BTRFS_INODE_EXTREF_KEY) {
-			ret = add_inode_ref(wc->trans, root, log, path,
-					    eb, i, &key);
+			ret = add_inode_ref(trans, root, log, path, eb, i, &key);
 			if (ret)
 				break;
 		} else if (key.type == BTRFS_EXTENT_DATA_KEY) {
-			ret = replay_one_extent(wc->trans, root, path,
-						eb, i, &key);
+			ret = replay_one_extent(trans, root, path, eb, i, &key);
 			if (ret)
 				break;
 		}
-- 
2.47.2


