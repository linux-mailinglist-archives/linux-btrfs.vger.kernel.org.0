Return-Path: <linux-btrfs+bounces-8241-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FC598704F
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 11:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71FA7B271BC
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 09:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B95E1AC8B3;
	Thu, 26 Sep 2024 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooYOgNrS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F61AC8A8
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343206; cv=none; b=rc13c34VC8IEu2V20DA/ePg5yWt2fchuXWkiZGvsPbtW2CTpwKn4Ucupmrd2tdreJCxxRsbenD1fgqhjJS7dLRPZcI4y6iSC61G3NidqAoc/HR8P5FeEHv3SqeqF5OfXHNLijWiUqBNJKDdd2AgFvDo7gKsxGwGB/TC6v5FHzUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343206; c=relaxed/simple;
	bh=i9LAUyxUoA3OaQjX49pEGHwxBjafYA88ls6ZvpUwszU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iEZyEaFuxZdATAxZv/gb9sWaE/v5GyRUF09dc+67xsx/nvvfra8M4y/yzRpggVue4nHHsgkTm5mNFnTQaRjY2YfDbmJ2gj2Bg6z+pNkitW6l1x3cUYdwU0imYuOBxfkENVgDPSJtzhAE+O0e5OoAYFfFB4/VIVE1a3y0wMtf988=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooYOgNrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60C5C4CECD
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 09:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727343206;
	bh=i9LAUyxUoA3OaQjX49pEGHwxBjafYA88ls6ZvpUwszU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ooYOgNrSpEMSXUPmovTks0C2wRnQnvq3EOmbvaHa/KRJham9mwiOMGF8iFTUnBxDI
	 ufdLkbSAsWn3P+FwB/GzCjwniVpvo3eCc2jvJJha7qTKrk0pDRTMKmjhXet2XlbrWr
	 V+57aLv2cEsIiydlfOAY+/KVyjz3kPKuWX/OdxQgNhiJ/4GCu2ZytYZOH6pEdZ2Mru
	 gmnsB4c0iUxeCTTgFzOi400HJPR57QBR4P09b+tJsgdDh4WvSEFNx7lUXxecLU1VGg
	 LddUDeijPlrv5FyqASCLpR8Fa9vya4uO2KSPZw8x1BgMTkmg7KMsCpyyVAIyc9C3pc
	 PtGgYZFZo3slw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/8] btrfs: fix missing error handling when adding delayed ref with qgroups enabled
Date: Thu, 26 Sep 2024 10:33:15 +0100
Message-Id: <7e4b248dad75a0f0dd3a41b4a3af138a418b05d8.1727342969.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727342969.git.fdmanana@suse.com>
References: <cover.1727342969.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When adding a delayed ref head, at delayed-ref.c:add_delayed_ref_head(),
if we fail to insert the qgroup record we don't error out, we ignore it.
In fact we treat it as if there was no error and there was already an
existing record - we don't distinguish between the cases where
btrfs_qgroup_trace_extent_nolock() returns 1, meaning a record already
existed and we can free the given record, and the case where it returns
a negative error value, meaning the insertion into the xarray that is
used to track records failed.

Effectively we end up ignoring that we are lacking qgroup record in the
dirty extents xarray, resulting in incorrect qgroup accounting.

Fix this by checking for errors and return them to the callers.

Fixes: 3cce39a8ca4e ("btrfs: qgroup: use xarray to track dirty extents in transaction")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index ad9ef8312e41..32f719b9e661 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -840,6 +840,8 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
  * helper function to actually insert a head node into the rbtree.
  * this does all the dirty work in terms of maintaining the correct
  * overall modification count.
+ *
+ * Returns an error pointer in case of an error.
  */
 static noinline struct btrfs_delayed_ref_head *
 add_delayed_ref_head(struct btrfs_trans_handle *trans,
@@ -862,6 +864,9 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 		if (ret) {
 			/* Clean up if insertion fails or item exists. */
 			xa_release(&delayed_refs->dirty_extents, qrecord->bytenr);
+			/* Caller responsible for freeing qrecord on error. */
+			if (ret < 0)
+				return ERR_PTR(ret);
 			kfree(qrecord);
 		} else {
 			qrecord_inserted = true;
@@ -1000,27 +1005,35 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_delayed_ref_node *node;
 	struct btrfs_delayed_ref_head *head_ref;
+	struct btrfs_delayed_ref_head *new_head_ref;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_qgroup_extent_record *record = NULL;
 	bool qrecord_inserted;
 	int action = generic_ref->action;
 	bool merged;
+	int ret;
 
 	node = kmem_cache_alloc(btrfs_delayed_ref_node_cachep, GFP_NOFS);
 	if (!node)
 		return -ENOMEM;
 
 	head_ref = kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_NOFS);
-	if (!head_ref)
+	if (!head_ref) {
+		ret = -ENOMEM;
 		goto free_node;
+	}
 
 	if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_qgroup) {
 		record = kzalloc(sizeof(*record), GFP_NOFS);
-		if (!record)
+		if (!record) {
+			ret = -ENOMEM;
 			goto free_head_ref;
+		}
 		if (xa_reserve(&trans->transaction->delayed_refs.dirty_extents,
-			       generic_ref->bytenr, GFP_NOFS))
+			       generic_ref->bytenr, GFP_NOFS)) {
+			ret = -ENOMEM;
 			goto free_record;
+		}
 	}
 
 	init_delayed_ref_common(fs_info, node, generic_ref);
@@ -1034,8 +1047,14 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 	 * insert both the head node and the new ref without dropping
 	 * the spin lock
 	 */
-	head_ref = add_delayed_ref_head(trans, head_ref, record,
-					action, &qrecord_inserted);
+	new_head_ref = add_delayed_ref_head(trans, head_ref, record,
+					    action, &qrecord_inserted);
+	if (IS_ERR(new_head_ref)) {
+		spin_unlock(&delayed_refs->lock);
+		ret = PTR_ERR(new_head_ref);
+		goto free_record;
+	}
+	head_ref = new_head_ref;
 
 	merged = insert_delayed_ref(trans, head_ref, node);
 	spin_unlock(&delayed_refs->lock);
@@ -1063,7 +1082,7 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 	kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
 free_node:
 	kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
-	return -ENOMEM;
+	return ret;
 }
 
 /*
@@ -1094,6 +1113,7 @@ int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
 				struct btrfs_delayed_extent_op *extent_op)
 {
 	struct btrfs_delayed_ref_head *head_ref;
+	struct btrfs_delayed_ref_head *head_ref_ret;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_ref generic_ref = {
 		.type = BTRFS_REF_METADATA,
@@ -1113,11 +1133,15 @@ int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
 	delayed_refs = &trans->transaction->delayed_refs;
 	spin_lock(&delayed_refs->lock);
 
-	add_delayed_ref_head(trans, head_ref, NULL, BTRFS_UPDATE_DELAYED_HEAD,
-			     NULL);
-
+	head_ref_ret = add_delayed_ref_head(trans, head_ref, NULL,
+					    BTRFS_UPDATE_DELAYED_HEAD, NULL);
 	spin_unlock(&delayed_refs->lock);
 
+	if (IS_ERR(head_ref_ret)) {
+		kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
+		return PTR_ERR(head_ref_ret);
+	}
+
 	/*
 	 * Need to update the delayed_refs_rsv with any changes we may have
 	 * made.
-- 
2.43.0


