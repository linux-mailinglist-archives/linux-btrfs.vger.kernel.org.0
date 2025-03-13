Return-Path: <linux-btrfs+bounces-12271-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB838A5FEA7
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 18:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657F53BB2FE
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 17:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0474A1EBA09;
	Thu, 13 Mar 2025 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtS2yd5p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450111EB5E9
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741888543; cv=none; b=tzP7Q6alVEVOESCx7j195snOX2RYiBqBHxF+UPUV93Y2d+nSKn58jP6jwJ3okvarbbBiBELmnC6Www6SoZJ9RkOVdCLTy30cfPIaECUZnHdpZCv5B9l8Rv67FkiRy2wFEuuyks2Bl+AMcIcQ4WGkVpffOcWkAm13YP5R+T0GHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741888543; c=relaxed/simple;
	bh=DxOkrvm4vUv7n1tceL96XOTjO2VtqouVzsU1xnS+YzY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WiZGBmw9uvvTMzfG65D5k5CnSDpsyDoXrTkT1pS9Kphxe2aGaTrLkoFLcRpDPC+rcz4qC+ZpRrIpyWAvymsXp76rJqr9OFZZ6ndHaGFfEIu2Y0J7FqdRrXn9UWoPz01dlcrU1DHzjPgG2AmRXjNyq73LbcoryWVjhoNwGG98G/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtS2yd5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC9FC4CEEB
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 17:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741888542;
	bh=DxOkrvm4vUv7n1tceL96XOTjO2VtqouVzsU1xnS+YzY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mtS2yd5pzdFLT/zF7kK4bRH1do3zdFWw0oI6g7fV1AJ7jg5Wk+1iPQfZVFpcvcyV5
	 uuusXrUBfBEtfhlea34T3ymfpYguc0UnICRvIuWmDrLSfma6V1bVyzqWZv0ULHg4Xn
	 d+LuCKoqkSS8CcKrqd23fr7lskh5NNqUEuUadD48COVX/rSzWE4tomJTZx9DS+rd8e
	 2Sbzdzp9C+sDbQqdGNAfZGuvXLVVQU0dfHX6cYBdCQCAWpbxUODwshRzBUgOZAzpEK
	 fhFpZpbAXA7HWuNnqAZ4uMnJyw+avLOCS2t4L4pLYwZF66FJ+zZhBDMMnoG/DNqOq8
	 QOQotUGppkF6w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/7] btrfs: use variables to store extent buffer and slot at overwrite_item()
Date: Thu, 13 Mar 2025 17:55:32 +0000
Message-Id: <db437d092ee330d9445de9d06399be7e64390757.1741887949.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741887949.git.fdmanana@suse.com>
References: <cover.1741887949.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of referring to path->nodes[0] and path->slots[0] multiple times,
which is verbose and confusing since we have an 'eb' and 'slot' variables
as well, introduce local variables 'dst_eb' to point to path->nodes[0] and
'dst_slot' to have path->slots[0], reducing verbosity and making it more
obvious about which extent buffer and slot we are referring to.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 47 ++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 91278cc83bd4..f23feddb41c5 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -401,6 +401,8 @@ static int overwrite_item(struct btrfs_trans_handle *trans,
 	int save_old_i_size = 0;
 	unsigned long src_ptr;
 	unsigned long dst_ptr;
+	struct extent_buffer *dst_eb;
+	int dst_slot;
 	bool inode_item = key->type == BTRFS_INODE_ITEM_KEY;
 
 	/*
@@ -420,10 +422,13 @@ static int overwrite_item(struct btrfs_trans_handle *trans,
 	if (ret < 0)
 		return ret;
 
+	dst_eb = path->nodes[0];
+	dst_slot = path->slots[0];
+
 	if (ret == 0) {
 		char *src_copy;
-		u32 dst_size = btrfs_item_size(path->nodes[0],
-						  path->slots[0]);
+		const u32 dst_size = btrfs_item_size(dst_eb, dst_slot);
+
 		if (dst_size != item_size)
 			goto insert;
 
@@ -438,8 +443,8 @@ static int overwrite_item(struct btrfs_trans_handle *trans,
 		}
 
 		read_extent_buffer(eb, src_copy, src_ptr, item_size);
-		dst_ptr = btrfs_item_ptr_offset(path->nodes[0], path->slots[0]);
-		ret = memcmp_extent_buffer(path->nodes[0], src_copy, dst_ptr, item_size);
+		dst_ptr = btrfs_item_ptr_offset(dst_eb, dst_slot);
+		ret = memcmp_extent_buffer(dst_eb, src_copy, dst_ptr, item_size);
 
 		kfree(src_copy);
 		/*
@@ -462,9 +467,9 @@ static int overwrite_item(struct btrfs_trans_handle *trans,
 			u64 nbytes;
 			u32 mode;
 
-			item = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			item = btrfs_item_ptr(dst_eb, dst_slot,
 					      struct btrfs_inode_item);
-			nbytes = btrfs_inode_nbytes(path->nodes[0], item);
+			nbytes = btrfs_inode_nbytes(dst_eb, item);
 			item = btrfs_item_ptr(eb, slot,
 					      struct btrfs_inode_item);
 			btrfs_set_inode_nbytes(eb, item, nbytes);
@@ -506,11 +511,13 @@ static int overwrite_item(struct btrfs_trans_handle *trans,
 				      key, item_size);
 	path->skip_release_on_error = 0;
 
+	dst_eb = path->nodes[0];
+	dst_slot = path->slots[0];
+
 	/* make sure any existing item is the correct size */
 	if (ret == -EEXIST || ret == -EOVERFLOW) {
-		u32 found_size;
-		found_size = btrfs_item_size(path->nodes[0],
-						path->slots[0]);
+		const u32 found_size = btrfs_item_size(dst_eb, dst_slot);
+
 		if (found_size > item_size)
 			btrfs_truncate_item(trans, path, item_size, 1);
 		else if (found_size < item_size)
@@ -518,8 +525,7 @@ static int overwrite_item(struct btrfs_trans_handle *trans,
 	} else if (ret) {
 		return ret;
 	}
-	dst_ptr = btrfs_item_ptr_offset(path->nodes[0],
-					path->slots[0]);
+	dst_ptr = btrfs_item_ptr_offset(dst_eb, dst_slot);
 
 	/* don't overwrite an existing inode if the generation number
 	 * was logged as zero.  This is done when the tree logging code
@@ -538,7 +544,6 @@ static int overwrite_item(struct btrfs_trans_handle *trans,
 		dst_item = (struct btrfs_inode_item *)dst_ptr;
 
 		if (btrfs_inode_generation(eb, src_item) == 0) {
-			struct extent_buffer *dst_eb = path->nodes[0];
 			const u64 ino_size = btrfs_inode_size(eb, src_item);
 
 			/*
@@ -556,30 +561,28 @@ static int overwrite_item(struct btrfs_trans_handle *trans,
 		}
 
 		if (S_ISDIR(btrfs_inode_mode(eb, src_item)) &&
-		    S_ISDIR(btrfs_inode_mode(path->nodes[0], dst_item))) {
+		    S_ISDIR(btrfs_inode_mode(dst_eb, dst_item))) {
 			save_old_i_size = 1;
-			saved_i_size = btrfs_inode_size(path->nodes[0],
-							dst_item);
+			saved_i_size = btrfs_inode_size(dst_eb, dst_item);
 		}
 	}
 
-	copy_extent_buffer(path->nodes[0], eb, dst_ptr,
-			   src_ptr, item_size);
+	copy_extent_buffer(dst_eb, eb, dst_ptr, src_ptr, item_size);
 
 	if (save_old_i_size) {
 		struct btrfs_inode_item *dst_item;
+
 		dst_item = (struct btrfs_inode_item *)dst_ptr;
-		btrfs_set_inode_size(path->nodes[0], dst_item, saved_i_size);
+		btrfs_set_inode_size(dst_eb, dst_item, saved_i_size);
 	}
 
 	/* make sure the generation is filled in */
 	if (key->type == BTRFS_INODE_ITEM_KEY) {
 		struct btrfs_inode_item *dst_item;
+
 		dst_item = (struct btrfs_inode_item *)dst_ptr;
-		if (btrfs_inode_generation(path->nodes[0], dst_item) == 0) {
-			btrfs_set_inode_generation(path->nodes[0], dst_item,
-						   trans->transid);
-		}
+		if (btrfs_inode_generation(dst_eb, dst_item) == 0)
+			btrfs_set_inode_generation(dst_eb, dst_item, trans->transid);
 	}
 no_copy:
 	btrfs_release_path(path);
-- 
2.45.2


