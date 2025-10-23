Return-Path: <linux-btrfs+bounces-18208-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3E2C024BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28E7F54191D
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57697298CDE;
	Thu, 23 Oct 2025 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsLY0UUg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDE42989B4
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235225; cv=none; b=bIdlm1xzUawwZSvHxU/YdcHqBvvA+1gKVC+O2ipoY2ZqPIr/va3hFD7IjBB2+Sv1Yh3EYjmh+afMTVsZuzky6bPGnpsF3jG2nllKQAK/NoVQKaxlsLiuZP9Nb3Yub2fN4TGcSfTNbGF5kVmKEhO+wsOtwzp+zjiHIjd7m+HIAfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235225; c=relaxed/simple;
	bh=nO276Vc2yEMrTTsRrOuZHmINdg8NgaCuflz9ixZNQVw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJNZeNVQi3IJlSsEnkMoWlxfcGCL4qeVGb+0oXYu72lLdqKQi+Hymm8aO50RfqglbMqLnlWjaESHZ9lMH1CG1pSJXr9LZ+J2jWGLKvgYUEj0/pe9AOWN+QLKytX2yym7e1iuB+CC3bzTlr3U5nfDnZtrsQkPkOi/vqYM7JOge3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsLY0UUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B91C4CEFD
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235225;
	bh=nO276Vc2yEMrTTsRrOuZHmINdg8NgaCuflz9ixZNQVw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IsLY0UUgOyUOSJuZLdWYoOpkeP9A3PoCqPhsbsOh1VISKsvgRO1y5xFCZpMQewROx
	 LMSZHQhUMjd065STxyON+9xXuktCjWbgWaySxyazzSzAi75I9fjAsh7PD0VrQexFUV
	 jSWjM2DRqYgcvPwCSrczZJsTzGiVvsBjEtp7+BeiY2NBiLzjHW0updMkVCYKdR0e1D
	 5gsXqbIXtr9KLqM+1MoAbcFl7pK1f7e4S9/oDj0eY8MnFWX/A4FTog1ZLvIBlQ/6nP
	 7OJlAueZPowqN6ELGnBlIc9gzSuOwu55srJYpRM189V2Nlp+a4BkYnw6UAc159axNo
	 rUUh+Bkul5Sew==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 21/28] btrfs: remove 'reserved' argument from btrfs_pin_extent()
Date: Thu, 23 Oct 2025 16:59:54 +0100
Message-ID: <60e36ea0a51a7215e3099c76948901b5e69c1795.1761234581.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1761234580.git.fdmanana@suse.com>
References: <cover.1761234580.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

All callers pass a value of 1 (true) to it, so remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 15 +++++++--------
 fs/btrfs/extent-tree.h |  3 +--
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 4be20949f0ba..21420dc26a50 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1764,7 +1764,7 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
 
 	if (TRANS_ABORTED(trans)) {
 		if (insert_reserved) {
-			btrfs_pin_extent(trans, node->bytenr, node->num_bytes, 1);
+			btrfs_pin_extent(trans, node->bytenr, node->num_bytes);
 			free_head_ref_squota_rsv(trans->fs_info, href);
 		}
 		return 0;
@@ -1783,7 +1783,7 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
 	else
 		BUG();
 	if (ret && insert_reserved)
-		btrfs_pin_extent(trans, node->bytenr, node->num_bytes, 1);
+		btrfs_pin_extent(trans, node->bytenr, node->num_bytes);
 	if (ret < 0)
 		btrfs_err(trans->fs_info,
 "failed to run delayed ref for logical %llu num_bytes %llu type %u action %u ref_mod %d: %d",
@@ -1890,7 +1890,7 @@ static int cleanup_ref_head(struct btrfs_trans_handle *trans,
 	spin_unlock(&delayed_refs->lock);
 
 	if (head->must_insert_reserved) {
-		btrfs_pin_extent(trans, head->bytenr, head->num_bytes, 1);
+		btrfs_pin_extent(trans, head->bytenr, head->num_bytes);
 		if (head->is_data) {
 			struct btrfs_root *csum_root;
 
@@ -2611,15 +2611,14 @@ static int pin_down_extent(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-int btrfs_pin_extent(struct btrfs_trans_handle *trans,
-		     u64 bytenr, u64 num_bytes, int reserved)
+int btrfs_pin_extent(struct btrfs_trans_handle *trans, u64 bytenr, u64 num_bytes)
 {
 	struct btrfs_block_group *cache;
 
 	cache = btrfs_lookup_block_group(trans->fs_info, bytenr);
 	BUG_ON(!cache); /* Logic error */
 
-	pin_down_extent(trans, cache, bytenr, num_bytes, reserved);
+	pin_down_extent(trans, cache, bytenr, num_bytes, 1);
 
 	btrfs_put_block_group(cache);
 	return 0;
@@ -3538,7 +3537,7 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
 	 * tree, just update pinning info and exit early.
 	 */
 	if (ref->ref_root == BTRFS_TREE_LOG_OBJECTID) {
-		btrfs_pin_extent(trans, ref->bytenr, ref->num_bytes, 1);
+		btrfs_pin_extent(trans, ref->bytenr, ref->num_bytes);
 		ret = 0;
 	} else if (ref->type == BTRFS_REF_METADATA) {
 		ret = btrfs_add_delayed_tree_ref(trans, ref, NULL);
@@ -5022,7 +5021,7 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
 	ret = alloc_reserved_file_extent(trans, 0, root_objectid, 0, owner,
 					 offset, ins, 1, root_objectid);
 	if (ret)
-		btrfs_pin_extent(trans, ins->objectid, ins->offset, 1);
+		btrfs_pin_extent(trans, ins->objectid, ins->offset);
 	ret = btrfs_record_squota_delta(fs_info, &delta);
 	btrfs_put_block_group(block_group);
 	return ret;
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index e970ac42a871..e573509c5a71 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -110,8 +110,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			     struct btrfs_fs_info *fs_info, u64 bytenr,
 			     u64 offset, int metadata, u64 *refs, u64 *flags,
 			     u64 *owner_root);
-int btrfs_pin_extent(struct btrfs_trans_handle *trans, u64 bytenr, u64 num,
-		     int reserved);
+int btrfs_pin_extent(struct btrfs_trans_handle *trans, u64 bytenr, u64 num);
 int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
 				    const struct extent_buffer *eb);
 int btrfs_exclude_logged_extents(struct extent_buffer *eb);
-- 
2.47.2


