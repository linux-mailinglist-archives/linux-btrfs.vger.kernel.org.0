Return-Path: <linux-btrfs+bounces-14925-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982A8AE69C7
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 16:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635F36A43AE
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 14:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981922E11C5;
	Tue, 24 Jun 2025 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bF1p2Dnn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3AC2E11B0
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776156; cv=none; b=kzf7dLZX0+M5zvKxnMMecytlv4EM4hfGx44dgH8Yrlt81MmC6EMMe4da/3D2HHGFWlZq80KDQYrWgEKnW8UkG7yI0NcWJ9JWVoIc1gVW7UhziItqq+lrkkEBfZJEx/B7OZ4WnuS54offhSpgPNPbOGi5pJCDByDlrPVCcjmN7CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776156; c=relaxed/simple;
	bh=mcBY3+1bUfxAcupfVTQzMW06RSO+kYfl1Fen6k55KcI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FoH2dwyS8ARaIBQdF+G9IfvveCPQPf6FTmncj1OhXkb/Qj7SriOSxWRvw9a9QgsVi+AnswxSfXBXiij/Qkor9KQGIUks0nY3Qzx2MN8lJQXyZeIQJWoN/Dqa1zJ/ZLDy8VF4s9Z5RLRWe75x++/0u2azFCdVposDeyWevDbOGXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bF1p2Dnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9B8C4CEE3
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750776156;
	bh=mcBY3+1bUfxAcupfVTQzMW06RSO+kYfl1Fen6k55KcI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bF1p2Dnnwb4lmBkzv7X/DCI+swsvqhjkUj30vM+hgZTkK57DfIptgSV53CH25b9g+
	 hCbZd3UDQ2E4ld+x4On/XvvueoKS/h+pishSgjeuaIG/qtpZ4iNEPDR68tPjDPPNxl
	 aXhkLjNVyICP3Jzm4K7Lo/Y44i19K1FaM+dClYyFI8qa67HbEIiG5s8EvRcAN+xZ9Q
	 AqirjN3NQqA7tfF/U4PJAv8zhFRp4LWnde6fcEt+YHyDwnYAupBopex8F3cigGChdS
	 DEEU1j9v6jKihwi9Sjv4aYGyrXA96u5VfFgAgakTGe+QZitsM1Y/Nd+zKM/O/ohThW
	 NXsNjb/tjGVcw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 10/12] btrfs: split inode rextef processing from __add_inode_ref() into a helper
Date: Tue, 24 Jun 2025 15:42:20 +0100
Message-ID: <77fb4fa12feec93ced283745958274bf33747104.1750709411.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1750709410.git.fdmanana@suse.com>
References: <cover.1750709410.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The __add_inode_ref() function is quite big and with too much nesting, so
move the code that processes inode extrefs into a helper function, to make
the function easier to read and reduce the level of indentation too.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 131 +++++++++++++++++++++++++-------------------
 1 file changed, 74 insertions(+), 57 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 648e1705c1c4..82664bb79d36 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1094,6 +1094,73 @@ static int unlink_refs_not_in_log(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
+static int unlink_extrefs_not_in_log(struct btrfs_trans_handle *trans,
+				     struct btrfs_path *path,
+				     struct btrfs_root *root,
+				     struct btrfs_root *log_root,
+				     struct btrfs_key *search_key,
+				     struct btrfs_inode *inode,
+				     u64 inode_objectid,
+				     u64 parent_objectid)
+{
+	struct extent_buffer *leaf = path->nodes[0];
+	const unsigned long base = btrfs_item_ptr_offset(leaf, path->slots[0]);
+	const u32 item_size = btrfs_item_size(leaf, path->slots[0]);
+	u32 cur_offset = 0;
+
+	while (cur_offset < item_size) {
+		struct btrfs_inode_extref *extref;
+		struct btrfs_inode *victim_parent;
+		struct fscrypt_str victim_name;
+		int ret;
+
+		extref = (struct btrfs_inode_extref *)(base + cur_offset);
+		victim_name.len = btrfs_inode_extref_name_len(leaf, extref);
+
+		if (btrfs_inode_extref_parent(leaf, extref) != parent_objectid)
+			goto next;
+
+		ret = read_alloc_one_name(leaf, &extref->name, victim_name.len,
+					  &victim_name);
+		if (ret)
+			return ret;
+
+		search_key->objectid = inode_objectid;
+		search_key->type = BTRFS_INODE_EXTREF_KEY;
+		search_key->offset = btrfs_extref_hash(parent_objectid,
+						       victim_name.name,
+						       victim_name.len);
+		ret = backref_in_log(log_root, search_key, parent_objectid, &victim_name);
+		if (ret) {
+			kfree(victim_name.name);
+			if (ret < 0)
+				return ret;
+next:
+			cur_offset += victim_name.len + sizeof(*extref);
+			continue;
+		}
+
+		victim_parent = btrfs_iget_logging(parent_objectid, root);
+		if (IS_ERR(victim_parent)) {
+			kfree(victim_name.name);
+			return PTR_ERR(victim_parent);
+		}
+
+		inc_nlink(&inode->vfs_inode);
+		btrfs_release_path(path);
+
+		ret = unlink_inode_for_log_replay(trans, victim_parent, inode,
+						  &victim_name);
+		iput(&victim_parent->vfs_inode);
+		kfree(victim_name.name);
+		if (ret)
+			return ret;
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
 static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 				  struct btrfs_root *root,
 				  struct btrfs_path *path,
@@ -1104,7 +1171,6 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 				  u64 ref_index, struct fscrypt_str *name)
 {
 	int ret;
-	struct extent_buffer *leaf;
 	struct btrfs_dir_item *di;
 	struct btrfs_key search_key;
 	struct btrfs_inode_extref *extref;
@@ -1139,62 +1205,13 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 	if (IS_ERR(extref)) {
 		return PTR_ERR(extref);
 	} else if (extref) {
-		u32 item_size;
-		u32 cur_offset = 0;
-		unsigned long base;
-		struct btrfs_inode *victim_parent;
-
-		leaf = path->nodes[0];
-
-		item_size = btrfs_item_size(leaf, path->slots[0]);
-		base = btrfs_item_ptr_offset(leaf, path->slots[0]);
-
-		while (cur_offset < item_size) {
-			struct fscrypt_str victim_name;
-
-			extref = (struct btrfs_inode_extref *)(base + cur_offset);
-			victim_name.len = btrfs_inode_extref_name_len(leaf, extref);
-
-			if (btrfs_inode_extref_parent(leaf, extref) != parent_objectid)
-				goto next;
-
-			ret = read_alloc_one_name(leaf, &extref->name,
-						  victim_name.len, &victim_name);
-			if (ret)
-				return ret;
-
-			search_key.objectid = inode_objectid;
-			search_key.type = BTRFS_INODE_EXTREF_KEY;
-			search_key.offset = btrfs_extref_hash(parent_objectid,
-							      victim_name.name,
-							      victim_name.len);
-			ret = backref_in_log(log_root, &search_key,
-					     parent_objectid, &victim_name);
-			if (ret < 0) {
-				kfree(victim_name.name);
-				return ret;
-			} else if (!ret) {
-				victim_parent = btrfs_iget_logging(parent_objectid, root);
-				if (IS_ERR(victim_parent)) {
-					ret = PTR_ERR(victim_parent);
-				} else {
-					inc_nlink(&inode->vfs_inode);
-					btrfs_release_path(path);
-
-					ret = unlink_inode_for_log_replay(trans,
-							victim_parent,
-							inode, &victim_name);
-					iput(&victim_parent->vfs_inode);
-				}
-				kfree(victim_name.name);
-				if (ret)
-					return ret;
-				goto again;
-			}
-			kfree(victim_name.name);
-next:
-			cur_offset += victim_name.len + sizeof(*extref);
-		}
+		ret = unlink_extrefs_not_in_log(trans, path, root, log_root,
+						&search_key, inode,
+						inode_objectid, parent_objectid);
+		if (ret == -EAGAIN)
+			goto again;
+		else if (ret)
+			return ret;
 	}
 	btrfs_release_path(path);
 
-- 
2.47.2


