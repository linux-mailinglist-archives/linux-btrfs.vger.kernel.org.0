Return-Path: <linux-btrfs+bounces-15204-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77EBAF5D5A
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 17:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07AE94E2549
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 15:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D572F1988;
	Wed,  2 Jul 2025 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgDx/+V8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22945289836
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Jul 2025 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470719; cv=none; b=lCMlHCxft6q9gtGYguorvBT4aRwDQ3UhvtgpSvRBqbJNDVIl79mtLzYGwN9Umxn3xY+ZxbsE1zPVld8eqHH7iqeEF1H5mWRPe/WRNg6heGq/iNe6oOB8bJ/Ol0vpUlpUxnzKqDm7z/xn8PHbkOEZluvkKzIrpjhkvxRvW1o9t38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470719; c=relaxed/simple;
	bh=FF7H/hQPNeSADOR9yj0nwLXKrI9e84Rnr0EpiyRJn8Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IEeSkXnn4cWQh1AoLRq0OiGsF8qGoRkN52TCc30lVaK5n0asCGuNX8g6rI0jfKJQHXSwNDtHZJ6+LQTT2SNbWvHwqdbP+8fUzj9DW93a468VFGWNRaHj6PNILkryVk5T87mAojdpjWTMoqV7lycgrw+mgjpYwp7ZejZpevSkrq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgDx/+V8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6F1C4CEE7
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Jul 2025 15:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751470718;
	bh=FF7H/hQPNeSADOR9yj0nwLXKrI9e84Rnr0EpiyRJn8Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DgDx/+V8kvn6zBDxmW7byNbSWw1+KSClwFGEqR0j4uD4xY9hpQlKMwYRqJCMagpLl
	 FchYdoo25W5LYCCXXr5WRdWcDXQzztnx0hun8niiYL7ObT0STFEUr8mv+nMe0yAFFH
	 8lIREzUc1/rCQWazaSnj3k/grWokIHoy0EPc1JKhgrpwPlQvRTUf4F2z9XDEMiQbah
	 pEIzU3dVlNjPQMTOo68/VnaWqODnl2zfEUCu9LalUMOx5KyuXHp07nH+OB9UpQ8fL1
	 17qZwGfXUZ1XoowGHAqCxswL7/aG0wSZbFs1p/QJaS7RnU5d3LI4EiMHzkNmKdF22c
	 LFhjw8GHbIFKw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: reduce size of struct tree_mod_elem
Date: Wed,  2 Jul 2025 16:38:31 +0100
Message-ID: <2917b083c5d147a0b60bceb23ca33fb49059e16d.1751460099.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1751460099.git.fdmanana@suse.com>
References: <cover.1751460099.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Several members are used for specific types of tree mod log operations so
they can be placed in a union in order to reduce the structure's size.

This reduces the structure size from 112 bytes to 88 bytes on x86_64,
so we can now use the kmalloc-96 slab instead of the kmalloc-128 slab.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-mod-log.c | 53 +++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index 41dcd296b003..d15a84f695e4 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -27,18 +27,29 @@ struct tree_mod_elem {
 	/* This is used for BTRFS_MOD_LOG_KEY* and BTRFS_MOD_LOG_ROOT_REPLACE. */
 	u64 generation;
 
-	/* Those are used for op == BTRFS_MOD_LOG_KEY_{REPLACE,REMOVE}. */
-	struct btrfs_disk_key key;
-	u64 blockptr;
-
-	/* This is used for op == BTRFS_MOD_LOG_MOVE_KEYS. */
-	struct {
-		int dst_slot;
-		int nr_items;
-	} move;
-
-	/* This is used for op == BTRFS_MOD_LOG_ROOT_REPLACE. */
-	struct tree_mod_root old_root;
+	union {
+		/*
+		 * This is used for the following op types:
+		 *
+		 *    BTRFS_MOD_LOG_KEY_REMOVE_WHILE_FREEING
+		 *    BTRFS_MOD_LOG_KEY_REMOVE_WHILE_MOVING
+		 *    BTRFS_MOD_LOG_KEY_REMOVE
+		 *    BTRFS_MOD_LOG_KEY_REPLACE
+		 */
+		struct {
+			struct btrfs_disk_key key;
+			u64 blockptr;
+		} slot_change;
+
+		/* This is used for op == BTRFS_MOD_LOG_MOVE_KEYS. */
+		struct {
+			int dst_slot;
+			int nr_items;
+		} move;
+
+		/* This is used for op == BTRFS_MOD_LOG_ROOT_REPLACE. */
+		struct tree_mod_root old_root;
+	};
 };
 
 /*
@@ -228,15 +239,17 @@ static struct tree_mod_elem *alloc_tree_mod_elem(const struct extent_buffer *eb,
 {
 	struct tree_mod_elem *tm;
 
+	/* Can't be one of these types, due to union on struct tree_mod_elem. */
+	ASSERT(op != BTRFS_MOD_LOG_MOVE_KEYS);
+	ASSERT(op != BTRFS_MOD_LOG_ROOT_REPLACE);
+
 	tm = kzalloc(sizeof(*tm), GFP_NOFS);
 	if (!tm)
 		return NULL;
 
 	tm->logical = eb->start;
-	if (op != BTRFS_MOD_LOG_KEY_ADD) {
-		btrfs_node_key(eb, &tm->key, slot);
-		tm->blockptr = btrfs_node_blockptr(eb, slot);
-	}
+	btrfs_node_key(eb, &tm->slot_change.key, slot);
+	tm->slot_change.blockptr = btrfs_node_blockptr(eb, slot);
 	tm->op = op;
 	tm->slot = slot;
 	tm->generation = btrfs_node_ptr_generation(eb, slot);
@@ -854,8 +867,8 @@ static void tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
 			fallthrough;
 		case BTRFS_MOD_LOG_KEY_REMOVE_WHILE_MOVING:
 		case BTRFS_MOD_LOG_KEY_REMOVE:
-			btrfs_set_node_key(eb, &tm->key, tm->slot);
-			btrfs_set_node_blockptr(eb, tm->slot, tm->blockptr);
+			btrfs_set_node_key(eb, &tm->slot_change.key, tm->slot);
+			btrfs_set_node_blockptr(eb, tm->slot, tm->slot_change.blockptr);
 			btrfs_set_node_ptr_generation(eb, tm->slot,
 						      tm->generation);
 			n++;
@@ -864,8 +877,8 @@ static void tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
 			break;
 		case BTRFS_MOD_LOG_KEY_REPLACE:
 			BUG_ON(tm->slot >= n);
-			btrfs_set_node_key(eb, &tm->key, tm->slot);
-			btrfs_set_node_blockptr(eb, tm->slot, tm->blockptr);
+			btrfs_set_node_key(eb, &tm->slot_change.key, tm->slot);
+			btrfs_set_node_blockptr(eb, tm->slot, tm->slot_change.blockptr);
 			btrfs_set_node_ptr_generation(eb, tm->slot,
 						      tm->generation);
 			break;
-- 
2.47.2


