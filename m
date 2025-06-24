Return-Path: <linux-btrfs+bounces-14926-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A61AE69B8
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 16:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7793B9F4A
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 14:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185672E11AC;
	Tue, 24 Jun 2025 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVFjO3JG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C86E2E11BE
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776157; cv=none; b=eqDTaPj5kQQd3E50rkEeqxE7QZOjJciKHYr/ROVS6giIthOvJckxB+g+Ml/MZIXIwJWO5t4W2TB2XoTXU2KOfSYCHabXcz68DOi4E1q3AkDoURXtt9GcV0uO376g+BoSao+nj4DUTGUlB3IUIVqTdFAwrz/58M6d8furTcHXkuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776157; c=relaxed/simple;
	bh=HlEenotTioa0WaIyHRbQydM4zRzLWnCcyGgORc/NpX4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5v0mhtTwYvgyiGIYERWpIA9q5LVVsDbjidhlxZtJ/hGG1FwnWDjW5D4lGugmoYyX0xnFzlnPRqx+tM6OxUJyPCCYhV4kLzIYJMGeOTQrRr49ACN0mDlI4c5WeEzJ5S7Av3XlETvYpRdKm4Md9NlmduCXLQQTZW6kF3Pt9y8+uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVFjO3JG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C94BC4CEEE
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750776155;
	bh=HlEenotTioa0WaIyHRbQydM4zRzLWnCcyGgORc/NpX4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VVFjO3JGTLsER/3V75/u/C9XOKfkfGehc4Cxn/Hagxni99jJSLkM8A+HIuslKiPzx
	 eM3Jwfm+AAZFciWTysE4gu3eONIXC8PjrB3YXuXbjJObfVnVSow/U6h3Hz8Evo/Oig
	 44oPanN1p7RthMKs8wQ5HpEPnka6BVK83rIifZTqNBiT3nC1Wfzu5vkWODf8XDIMJQ
	 Gy+g4xuu6uy9mph3WuEt2owGnk9LV0xcCvHAgJkj28nMYCP5sXK3RBxJR6rTbwfPBU
	 x46qNUwpyeh9TKrX/mNafC8uykQ80FyX2/cUkn8mB0l2om4oNRWRy6VZd0kP25IDVu
	 mQ8wcmPl8eUmg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 09/12] btrfs: split inode ref processing from __add_inode_ref() into a helper
Date: Tue, 24 Jun 2025 15:42:19 +0100
Message-ID: <d9b05a7bce29f816bd1880b2395cb1e49a925660.1750709411.git.fdmanana@suse.com>
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
move the code that processes inode refs into a helper function, to make
the function easier to read and reduce the level of indentation too.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 106 ++++++++++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 44 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 7ccf513d7ec8..648e1705c1c4 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1041,6 +1041,59 @@ static noinline int backref_in_log(struct btrfs_root *log,
 	return ret;
 }
 
+static int unlink_refs_not_in_log(struct btrfs_trans_handle *trans,
+				  struct btrfs_path *path,
+				  struct btrfs_root *log_root,
+				  struct btrfs_key *search_key,
+				  struct btrfs_inode *dir,
+				  struct btrfs_inode *inode,
+				  u64 parent_objectid)
+{
+	struct extent_buffer *leaf = path->nodes[0];
+	unsigned long ptr;
+	unsigned long ptr_end;
+
+	/*
+	 * Check all the names in this back reference to see if thet are in the
+	 * log. If so, we allow them to stay otherwise they must be unlinked as
+	 * a conflict.
+	 */
+	ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
+	ptr_end = ptr + btrfs_item_size(leaf, path->slots[0]);
+	while (ptr < ptr_end) {
+		struct fscrypt_str victim_name;
+		struct btrfs_inode_ref *victim_ref;
+		int ret;
+
+		victim_ref = (struct btrfs_inode_ref *)ptr;
+		ret = read_alloc_one_name(leaf, (victim_ref + 1),
+					  btrfs_inode_ref_name_len(leaf, victim_ref),
+					  &victim_name);
+		if (ret)
+			return ret;
+
+		ret = backref_in_log(log_root, search_key, parent_objectid, &victim_name);
+		if (ret) {
+			kfree(victim_name.name);
+			if (ret < 0)
+				return ret;
+			ptr = (unsigned long)(victim_ref + 1) + victim_name.len;
+			continue;
+		}
+
+		inc_nlink(&inode->vfs_inode);
+		btrfs_release_path(path);
+
+		ret = unlink_inode_for_log_replay(trans, dir, inode, &victim_name);
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
@@ -1065,54 +1118,19 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 	if (ret < 0) {
 		return ret;
 	} else if (ret == 0) {
-		struct btrfs_inode_ref *victim_ref;
-		unsigned long ptr;
-		unsigned long ptr_end;
-
-		leaf = path->nodes[0];
-
-		/* are we trying to overwrite a back ref for the root directory
-		 * if so, just jump out, we're done
+		/*
+		 * Are we trying to overwrite a back ref for the root directory?
+		 * If so, we're done.
 		 */
 		if (search_key.objectid == search_key.offset)
 			return 1;
 
-		/* check all the names in this back reference to see
-		 * if they are in the log.  if so, we allow them to stay
-		 * otherwise they must be unlinked as a conflict
-		 */
-		ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
-		ptr_end = ptr + btrfs_item_size(leaf, path->slots[0]);
-		while (ptr < ptr_end) {
-			struct fscrypt_str victim_name;
-
-			victim_ref = (struct btrfs_inode_ref *)ptr;
-			ret = read_alloc_one_name(leaf, (victim_ref + 1),
-				 btrfs_inode_ref_name_len(leaf, victim_ref),
-				 &victim_name);
-			if (ret)
-				return ret;
-
-			ret = backref_in_log(log_root, &search_key,
-					     parent_objectid, &victim_name);
-			if (ret < 0) {
-				kfree(victim_name.name);
-				return ret;
-			} else if (!ret) {
-				inc_nlink(&inode->vfs_inode);
-				btrfs_release_path(path);
-
-				ret = unlink_inode_for_log_replay(trans, dir, inode,
-						&victim_name);
-				kfree(victim_name.name);
-				if (ret)
-					return ret;
-				goto again;
-			}
-			kfree(victim_name.name);
-
-			ptr = (unsigned long)(victim_ref + 1) + victim_name.len;
-		}
+		ret = unlink_refs_not_in_log(trans, path, log_root, &search_key,
+					     dir, inode, parent_objectid);
+		if (ret == -EAGAIN)
+			goto again;
+		else if (ret)
+			return ret;
 	}
 	btrfs_release_path(path);
 
-- 
2.47.2


