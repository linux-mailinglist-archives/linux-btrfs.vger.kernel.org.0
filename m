Return-Path: <linux-btrfs+bounces-16659-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6386B45D91
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E36E1C8002A
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF0F30B525;
	Fri,  5 Sep 2025 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgNLKk3P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9BE30B51F
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088652; cv=none; b=jxY4zJ2smirIF+dqs/z4b3oinBRQBQuvYtzFBBCphLKX/0Okl/VXs82tnyqWiExt83hyRCIEznVJAzRiPleHZhr+YdtzCAVRM9+3GfgKIgqSJCWzN9dsGLHvCcggZ7qE5elS86Kprlt7B4RLpq4mtg4wqruUHH45apNogjB3hZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088652; c=relaxed/simple;
	bh=9T5oekUeuKZjA3fEg9LTDuAD4iOGGDWjfjv/Yngz/Us=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmmZSB1zmbdVJQbsdIyMSk6QG+l7OKgWDEqZSj70Qaffk2zQyek6LZZEAZlEk3A2aU5OHuWIvIUkzAxWhR/hcaR8Oy1p5r9cQaUV8FSc7hFGYvORGDtPoHLTRgcGL/7ctz3QP7Lit2SV7lwrW3WEofBK66xFo6FTWbMR4TTAANs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgNLKk3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1D8C4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088652;
	bh=9T5oekUeuKZjA3fEg9LTDuAD4iOGGDWjfjv/Yngz/Us=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kgNLKk3PcKMVht1YQ+WmpMRb9SahPnsLeMJyIxejjhNoiNZaOEqHbcdiKqnpJwDWW
	 Ei9b/ItVHAN4SBMa0gnSp246u6BWTqorX0p1hpmYGfswg+NZsuzTUn/+hGsiQP1h+6
	 eu8q8eZQvdx3PlZymdHJiwONC03NfJ3fiWzqKNj6MQKD6G0ucLyrGXNWHzB2ZvWAdA
	 vL4G6mmoUsOK2eMjKxQyq3t5+EnjFLvvuN7CHZpbDzMYstDRCKCxFm5CwWsxOmC2dQ
	 qjHHbr/5yY8yfmsfV/srZQ6IHSbatnjnxoRDJc1FeD/WF3/n0M3WFaMwDPf1skWYE7
	 MJG06TZy3BLxQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 15/33] btrfs: pass walk_control structure to add_inode_ref() and helpers
Date: Fri,  5 Sep 2025 17:10:03 +0100
Message-ID: <62f399a9c242230faa06525c1a88125a174aae7b.1757075118.git.fdmanana@suse.com>
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
arguments to add_inode_ref() and its helpers (__add_inode_ref(),
unlink_refs_not_in_log(), unlink_extrefs_not_in_log() and
unlink_old_inode_refs()), pass the walk_control structure as we can
access all of those from the structure. This reduces the number of
arguments passed and it's going to be needed by an incoming change
that improves error reporting for log replay.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 47 ++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index aac648ae30fb..2ec9252115fd 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1088,9 +1088,8 @@ static noinline int backref_in_log(struct btrfs_root *log,
 	return ret;
 }
 
-static int unlink_refs_not_in_log(struct btrfs_trans_handle *trans,
+static int unlink_refs_not_in_log(struct walk_control *wc,
 				  struct btrfs_path *path,
-				  struct btrfs_root *log_root,
 				  struct btrfs_key *search_key,
 				  struct btrfs_inode *dir,
 				  struct btrfs_inode *inode,
@@ -1108,6 +1107,7 @@ static int unlink_refs_not_in_log(struct btrfs_trans_handle *trans,
 	ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
 	ptr_end = ptr + btrfs_item_size(leaf, path->slots[0]);
 	while (ptr < ptr_end) {
+		struct btrfs_trans_handle *trans = wc->trans;
 		struct fscrypt_str victim_name;
 		struct btrfs_inode_ref *victim_ref;
 		int ret;
@@ -1121,7 +1121,7 @@ static int unlink_refs_not_in_log(struct btrfs_trans_handle *trans,
 			return ret;
 		}
 
-		ret = backref_in_log(log_root, search_key, parent_objectid, &victim_name);
+		ret = backref_in_log(wc->log, search_key, parent_objectid, &victim_name);
 		if (ret) {
 			kfree(victim_name.name);
 			if (ret < 0) {
@@ -1145,10 +1145,8 @@ static int unlink_refs_not_in_log(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-static int unlink_extrefs_not_in_log(struct btrfs_trans_handle *trans,
+static int unlink_extrefs_not_in_log(struct walk_control *wc,
 				     struct btrfs_path *path,
-				     struct btrfs_root *root,
-				     struct btrfs_root *log_root,
 				     struct btrfs_key *search_key,
 				     struct btrfs_inode *inode,
 				     u64 inode_objectid,
@@ -1160,6 +1158,9 @@ static int unlink_extrefs_not_in_log(struct btrfs_trans_handle *trans,
 	u32 cur_offset = 0;
 
 	while (cur_offset < item_size) {
+		struct btrfs_trans_handle *trans = wc->trans;
+		struct btrfs_root *root = wc->root;
+		struct btrfs_root *log_root = wc->log;
 		struct btrfs_inode_extref *extref;
 		struct btrfs_inode *victim_parent;
 		struct fscrypt_str victim_name;
@@ -1218,16 +1219,16 @@ static int unlink_extrefs_not_in_log(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
-				  struct btrfs_root *root,
+static inline int __add_inode_ref(struct walk_control *wc,
 				  struct btrfs_path *path,
-				  struct btrfs_root *log_root,
 				  struct btrfs_inode *dir,
 				  struct btrfs_inode *inode,
 				  u64 inode_objectid, u64 parent_objectid,
 				  u64 ref_index, struct fscrypt_str *name)
 {
 	int ret;
+	struct btrfs_trans_handle *trans = wc->trans;
+	struct btrfs_root *root = wc->root;
 	struct btrfs_dir_item *di;
 	struct btrfs_key search_key;
 	struct btrfs_inode_extref *extref;
@@ -1249,8 +1250,8 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 		if (search_key.objectid == search_key.offset)
 			return 1;
 
-		ret = unlink_refs_not_in_log(trans, path, log_root, &search_key,
-					     dir, inode, parent_objectid);
+		ret = unlink_refs_not_in_log(wc, path, &search_key, dir, inode,
+					     parent_objectid);
 		if (ret == -EAGAIN)
 			goto again;
 		else if (ret)
@@ -1263,8 +1264,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 	if (IS_ERR(extref)) {
 		return PTR_ERR(extref);
 	} else if (extref) {
-		ret = unlink_extrefs_not_in_log(trans, path, root, log_root,
-						&search_key, inode,
+		ret = unlink_extrefs_not_in_log(wc, path, &search_key, inode,
 						inode_objectid, parent_objectid);
 		if (ret == -EAGAIN)
 			goto again;
@@ -1349,14 +1349,15 @@ static int ref_get_fields(struct extent_buffer *eb, unsigned long ref_ptr,
  * proper unlink of that name (that is, remove its entry from the inode
  * reference item and both dir index keys).
  */
-static int unlink_old_inode_refs(struct btrfs_trans_handle *trans,
-				 struct btrfs_root *root,
+static int unlink_old_inode_refs(struct walk_control *wc,
 				 struct btrfs_path *path,
 				 struct btrfs_inode *inode,
 				 struct extent_buffer *log_eb,
 				 int log_slot,
 				 struct btrfs_key *key)
 {
+	struct btrfs_trans_handle *trans = wc->trans;
+	struct btrfs_root *root = wc->root;
 	int ret;
 	unsigned long ref_ptr;
 	unsigned long ref_end;
@@ -1441,13 +1442,13 @@ static int unlink_old_inode_refs(struct btrfs_trans_handle *trans,
  * root is the destination we are replaying into, and path is for temp
  * use by this function.  (it should be released on return).
  */
-static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
-				  struct btrfs_root *root,
-				  struct btrfs_root *log,
+static noinline int add_inode_ref(struct walk_control *wc,
 				  struct btrfs_path *path,
 				  struct extent_buffer *eb, int slot,
 				  struct btrfs_key *key)
 {
+	struct btrfs_trans_handle *trans = wc->trans;
+	struct btrfs_root *root = wc->root;
 	struct btrfs_inode *dir = NULL;
 	struct btrfs_inode *inode = NULL;
 	unsigned long ref_ptr;
@@ -1559,9 +1560,8 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 			 * overwrite any existing back reference, and we don't
 			 * want to create dangling pointers in the directory.
 			 */
-			ret = __add_inode_ref(trans, root, path, log, dir, inode,
-					      inode_objectid, parent_objectid,
-					      ref_index, &name);
+			ret = __add_inode_ref(wc, path, dir, inode, inode_objectid,
+					      parent_objectid, ref_index, &name);
 			if (ret) {
 				if (ret == 1)
 					ret = 0;
@@ -1601,7 +1601,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 	 * dir index entries exist for a name but there is no inode reference
 	 * item with the same name.
 	 */
-	ret = unlink_old_inode_refs(trans, root, path, inode, eb, slot, key);
+	ret = unlink_old_inode_refs(wc, path, inode, eb, slot, key);
 	if (ret)
 		goto out;
 
@@ -2584,7 +2584,6 @@ static int replay_one_buffer(struct extent_buffer *eb,
 	};
 	struct btrfs_path *path;
 	struct btrfs_root *root = wc->root;
-	struct btrfs_root *log = wc->log;
 	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_key key;
 	int i;
@@ -2725,7 +2724,7 @@ static int replay_one_buffer(struct extent_buffer *eb,
 				break;
 		} else if (key.type == BTRFS_INODE_REF_KEY ||
 			   key.type == BTRFS_INODE_EXTREF_KEY) {
-			ret = add_inode_ref(trans, root, log, path, eb, i, &key);
+			ret = add_inode_ref(wc, path, eb, i, &key);
 			if (ret)
 				break;
 		} else if (key.type == BTRFS_EXTENT_DATA_KEY) {
-- 
2.47.2


