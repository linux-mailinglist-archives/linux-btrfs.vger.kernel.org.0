Return-Path: <linux-btrfs+bounces-16884-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E4EB7E1D5
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 14:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65DB46170C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 07:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA83305959;
	Wed, 17 Sep 2025 07:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mocm+Vpd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B60D3054FF
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095571; cv=none; b=bb5DXu9GxPNLFH1ewCQDTN8/7aiS+N4fvBPEXZjpq0wrKqgP6FEQAs9M9qUh0cAebBNNt0pkJHSMAoBNYPmluZZGOseDokdTS+6XK10ZpAdAgXy6kTyTyxxWYCBfL9LUlwJDicY/MbdbRKrYMghMLFKMOkTxI+pclcvDvrm06ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095571; c=relaxed/simple;
	bh=6cL53NxSFgu6CiCclcjkra/W/nJGYYdT2hJQqkZ7cQA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqWT/PfcecsUOy7RKkxR6n4JS1unlruwCBorJvOU/6c0lmMhxwoU+hhQICtEkgZH9VaJZtXR9I7hE5wI3kqWkfXY3cnKVLyJas94TH/nPXlZ+iCTuZSyvx4qTJx8Yxmrs3+dvCoAaKAu43N1PCTkSYTcqN9+xBpVNGCvYwC10pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mocm+Vpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FBFC4CEF5
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 07:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758095570;
	bh=6cL53NxSFgu6CiCclcjkra/W/nJGYYdT2hJQqkZ7cQA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Mocm+VpdQ4pOw3z9wiNiQLaxhKsZWAxlCf3iSVj8i7QTT35ORjpjaTvG6H/qNhb4b
	 zaQs3umeGy8TgrLpl1JKSYvN+jgBvv+Em4H0F8enhTFSigF3CFV8/dGRHjxJPdMH/y
	 2vPdiVuRfINKUKyZn22gM2433fyNZxP8h8cF/eW+oSBkTfbww8N8V3fj0K9v838QMx
	 tfWNNdUUnDKiOcL8JXy6cmDny33lr7i/7ckUz6CyuXNYAj43SC6qpRlPQOkmOBNZz+
	 kqKm+7RSXCAZqqV/fPNg0VMMH82COaLsSX1FEmnngGbCF0cGk11qaHQjJYU8wKdgNh
	 kDoyeOl6Lu7Kg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs: mark leaf space and overflow checks as unlikely on insert and extension
Date: Wed, 17 Sep 2025 08:52:42 +0100
Message-ID: <4debbb91f2cddbd07a4ff06bdd7662cd9668b1d2.1758095164.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1758095164.git.fdmanana@suse.com>
References: <cover.1758095164.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have several sanity checks when inserting or extending items in a btree
that verify we didn't overflow the leaf or access a slot beyond the last
one. These are cases that are never expected to be hit so mark them as
unlikely, allowing the compiler to potentially generate better code.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index f6d2a4a4b9eb..dc185322362b 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3086,7 +3086,7 @@ int btrfs_leaf_free_space(const struct extent_buffer *leaf)
 	int ret;
 
 	ret = BTRFS_LEAF_DATA_SIZE(fs_info) - leaf_space_used(leaf, 0, nritems);
-	if (ret < 0) {
+	if (unlikely(ret < 0)) {
 		btrfs_crit(fs_info,
 			   "leaf free space ret %d, leaf data size %lu, used %d nritems %d",
 			   ret,
@@ -4075,7 +4075,7 @@ void btrfs_truncate_item(struct btrfs_trans_handle *trans,
 	btrfs_set_item_size(leaf, slot, new_size);
 	btrfs_mark_buffer_dirty(trans, leaf);
 
-	if (btrfs_leaf_free_space(leaf) < 0) {
+	if (unlikely(btrfs_leaf_free_space(leaf) < 0)) {
 		btrfs_print_leaf(leaf);
 		BUG();
 	}
@@ -4108,7 +4108,7 @@ void btrfs_extend_item(struct btrfs_trans_handle *trans,
 	old_data = btrfs_item_data_end(leaf, slot);
 
 	BUG_ON(slot < 0);
-	if (slot >= nritems) {
+	if (unlikely(slot >= nritems)) {
 		btrfs_print_leaf(leaf);
 		btrfs_crit(leaf->fs_info, "slot %d too large, nritems %d",
 			   slot, nritems);
@@ -4135,7 +4135,7 @@ void btrfs_extend_item(struct btrfs_trans_handle *trans,
 	btrfs_set_item_size(leaf, slot, old_size + data_size);
 	btrfs_mark_buffer_dirty(trans, leaf);
 
-	if (btrfs_leaf_free_space(leaf) < 0) {
+	if (unlikely(btrfs_leaf_free_space(leaf) < 0)) {
 		btrfs_print_leaf(leaf);
 		BUG();
 	}
@@ -4183,7 +4183,7 @@ static void setup_items_for_insert(struct btrfs_trans_handle *trans,
 	data_end = leaf_data_end(leaf);
 	total_size = batch->total_data_size + (batch->nr * sizeof(struct btrfs_item));
 
-	if (btrfs_leaf_free_space(leaf) < total_size) {
+	if (unlikely(btrfs_leaf_free_space(leaf) < total_size)) {
 		btrfs_print_leaf(leaf);
 		btrfs_crit(fs_info, "not enough freespace need %u have %d",
 			   total_size, btrfs_leaf_free_space(leaf));
@@ -4193,7 +4193,7 @@ static void setup_items_for_insert(struct btrfs_trans_handle *trans,
 	if (slot != nritems) {
 		unsigned int old_data = btrfs_item_data_end(leaf, slot);
 
-		if (old_data < data_end) {
+		if (unlikely(old_data < data_end)) {
 			btrfs_print_leaf(leaf);
 			btrfs_crit(fs_info,
 		"item at slot %d with data offset %u beyond data end of leaf %u",
@@ -4232,7 +4232,7 @@ static void setup_items_for_insert(struct btrfs_trans_handle *trans,
 	btrfs_set_header_nritems(leaf, nritems + batch->nr);
 	btrfs_mark_buffer_dirty(trans, leaf);
 
-	if (btrfs_leaf_free_space(leaf) < 0) {
+	if (unlikely(btrfs_leaf_free_space(leaf) < 0)) {
 		btrfs_print_leaf(leaf);
 		BUG();
 	}
-- 
2.47.2


