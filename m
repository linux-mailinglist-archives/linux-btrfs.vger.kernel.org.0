Return-Path: <linux-btrfs+bounces-16673-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 357EDB45DA2
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0D61611E3
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9989535207B;
	Fri,  5 Sep 2025 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQ+8Jff6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1CD322C83
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088666; cv=none; b=gLfN95iOlZf+36FDT9R2UTXFaJDrUkiGVWxhmJIs1IR3vpVDWawQ/y/gBPE7RUmc9zZOQ3y98hkFzdVEfvlVBFtKqq1KasXR5+NbXR/jML050dPr5rIcODYFVMD5mSYnPULTPtuyjuqetaZEXP61sIsGj0AbE4gOoMqfaXmMs+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088666; c=relaxed/simple;
	bh=dGADm53eRdRjR9cB/cJgO0GSC8p/3IaeukwtDO422Pw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQJTPzD2i65kLxA0Q2DMXqXTjBZ4Np+txca/HDTzkklR0G5+qxy0jSrfkEKPFld7hJ+bXY+ufRuw6ZlrV8XVVRc9T12PxiEA6rZD1/jR+TN7JwUCIvlmUSAKCZuWS+Io6UEBRmecJR5tgZlLy97OCcvaOmjIYrWN1zF7OHTWQG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQ+8Jff6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E90EC4CEF4
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088666;
	bh=dGADm53eRdRjR9cB/cJgO0GSC8p/3IaeukwtDO422Pw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rQ+8Jff6+2ZVLQB5zcGMtJHEdN3mdWrjE8YP2+r0Uz8CRJ89oRoy/en8ROg0QgewO
	 RhDceCyqdQ9k7SNjai1CQ0LUHxcrk67+J7Z4I52a+vH8KA2D1Qv4k7oY4Qhn3Lbb+6
	 DMC9KJP9neIfa8fkRts1cVbSWa02Eb8eNkSKoLC6MhSLjdx2uI7eFz99NzM9SUe59u
	 cZ4RqiFC2shTDagyOn2RZRqsZb1WQgNyXcm/Xc/VBRPq4FSFSPjyHUaHHPRgvl/Pcv
	 DGHWzqjCAcF1kMjnpDzVxCt/3XeOXlHGTwyNn6tlYtQXXuv2FcEmqttqMBUZJ4DBqz
	 JR3bv7jvp04HQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 29/33] btrfs: stop passing inode object IDs to __add_inode_ref() in log replay
Date: Fri,  5 Sep 2025 17:10:17 +0100
Message-ID: <edadc40101be88541d5ce6fd577cc9d502f30099.1757075118.git.fdmanana@suse.com>
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

There's no point in passing the inode and parent inode object IDs to
__add_inode_ref() and its helpers because we can get them by calling
btrfs_ino() against the inode and the directory inode, and we pass both
inodes to __add_inode_ref() and its helpers. So remove the object IDs
parameters to reduce arguments passed and to make things less confusing.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 747daaaaf332..6186300923b7 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1101,8 +1101,7 @@ static noinline int backref_in_log(struct btrfs_root *log,
 static int unlink_refs_not_in_log(struct walk_control *wc,
 				  struct btrfs_key *search_key,
 				  struct btrfs_inode *dir,
-				  struct btrfs_inode *inode,
-				  u64 parent_objectid)
+				  struct btrfs_inode *inode)
 {
 	struct extent_buffer *leaf = wc->subvol_path->nodes[0];
 	unsigned long ptr;
@@ -1130,7 +1129,7 @@ static int unlink_refs_not_in_log(struct walk_control *wc,
 			return ret;
 		}
 
-		ret = backref_in_log(wc->log, search_key, parent_objectid, &victim_name);
+		ret = backref_in_log(wc->log, search_key, btrfs_ino(dir), &victim_name);
 		if (ret) {
 			kfree(victim_name.name);
 			if (ret < 0) {
@@ -1156,9 +1155,8 @@ static int unlink_refs_not_in_log(struct walk_control *wc,
 
 static int unlink_extrefs_not_in_log(struct walk_control *wc,
 				     struct btrfs_key *search_key,
-				     struct btrfs_inode *inode,
-				     u64 inode_objectid,
-				     u64 parent_objectid)
+				     struct btrfs_inode *dir,
+				     struct btrfs_inode *inode)
 {
 	struct extent_buffer *leaf = wc->subvol_path->nodes[0];
 	const unsigned long base = btrfs_item_ptr_offset(leaf, wc->subvol_path->slots[0]);
@@ -1177,7 +1175,7 @@ static int unlink_extrefs_not_in_log(struct walk_control *wc,
 		extref = (struct btrfs_inode_extref *)(base + cur_offset);
 		victim_name.len = btrfs_inode_extref_name_len(leaf, extref);
 
-		if (btrfs_inode_extref_parent(leaf, extref) != parent_objectid)
+		if (btrfs_inode_extref_parent(leaf, extref) != btrfs_ino(dir))
 			goto next;
 
 		ret = read_alloc_one_name(leaf, &extref->name, victim_name.len,
@@ -1187,12 +1185,12 @@ static int unlink_extrefs_not_in_log(struct walk_control *wc,
 			return ret;
 		}
 
-		search_key->objectid = inode_objectid;
+		search_key->objectid = btrfs_ino(inode);
 		search_key->type = BTRFS_INODE_EXTREF_KEY;
-		search_key->offset = btrfs_extref_hash(parent_objectid,
+		search_key->offset = btrfs_extref_hash(btrfs_ino(dir),
 						       victim_name.name,
 						       victim_name.len);
-		ret = backref_in_log(log_root, search_key, parent_objectid, &victim_name);
+		ret = backref_in_log(log_root, search_key, btrfs_ino(dir), &victim_name);
 		if (ret) {
 			kfree(victim_name.name);
 			if (ret < 0) {
@@ -1204,7 +1202,7 @@ static int unlink_extrefs_not_in_log(struct walk_control *wc,
 			continue;
 		}
 
-		victim_parent = btrfs_iget_logging(parent_objectid, root);
+		victim_parent = btrfs_iget_logging(btrfs_ino(dir), root);
 		if (IS_ERR(victim_parent)) {
 			kfree(victim_name.name);
 			ret = PTR_ERR(victim_parent);
@@ -1230,7 +1228,6 @@ static int unlink_extrefs_not_in_log(struct walk_control *wc,
 static inline int __add_inode_ref(struct walk_control *wc,
 				  struct btrfs_inode *dir,
 				  struct btrfs_inode *inode,
-				  u64 inode_objectid, u64 parent_objectid,
 				  u64 ref_index, struct fscrypt_str *name)
 {
 	int ret;
@@ -1242,9 +1239,9 @@ static inline int __add_inode_ref(struct walk_control *wc,
 
 again:
 	/* Search old style refs */
-	search_key.objectid = inode_objectid;
+	search_key.objectid = btrfs_ino(inode);
 	search_key.type = BTRFS_INODE_REF_KEY;
-	search_key.offset = parent_objectid;
+	search_key.offset = btrfs_ino(dir);
 	ret = btrfs_search_slot(NULL, root, &search_key, wc->subvol_path, 0, 0);
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
@@ -1257,8 +1254,7 @@ static inline int __add_inode_ref(struct walk_control *wc,
 		if (search_key.objectid == search_key.offset)
 			return 1;
 
-		ret = unlink_refs_not_in_log(wc, &search_key, dir, inode,
-					     parent_objectid);
+		ret = unlink_refs_not_in_log(wc, &search_key, dir, inode);
 		if (ret == -EAGAIN)
 			goto again;
 		else if (ret)
@@ -1268,12 +1264,11 @@ static inline int __add_inode_ref(struct walk_control *wc,
 
 	/* Same search but for extended refs */
 	extref = btrfs_lookup_inode_extref(root, wc->subvol_path, name,
-					   inode_objectid, parent_objectid);
+					   btrfs_ino(inode), btrfs_ino(dir));
 	if (IS_ERR(extref)) {
 		return PTR_ERR(extref);
 	} else if (extref) {
-		ret = unlink_extrefs_not_in_log(wc, &search_key, inode,
-						inode_objectid, parent_objectid);
+		ret = unlink_extrefs_not_in_log(wc, &search_key, dir, inode);
 		if (ret == -EAGAIN)
 			goto again;
 		else if (ret)
@@ -1559,8 +1554,7 @@ static noinline int add_inode_ref(struct walk_control *wc)
 			 * overwrite any existing back reference, and we don't
 			 * want to create dangling pointers in the directory.
 			 */
-			ret = __add_inode_ref(wc, dir, inode, inode_objectid,
-					      parent_objectid, ref_index, &name);
+			ret = __add_inode_ref(wc, dir, inode, ref_index, &name);
 			if (ret) {
 				if (ret == 1)
 					ret = 0;
-- 
2.47.2


