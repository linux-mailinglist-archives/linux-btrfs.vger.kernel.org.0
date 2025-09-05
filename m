Return-Path: <linux-btrfs+bounces-16674-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D24B45DA3
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B55D1C801F8
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAACD3568E0;
	Fri,  5 Sep 2025 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IL5b5hLd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D1E30214B
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088668; cv=none; b=BzA5aP34hnqe7DOMujdx9BoYoz3GqEDsUYbGToAp+tWnpBhYT1cDghTrz568dG4vTama+/42e8OgPvdaI2Vn0eG7stEZlqlGu7nXNtUUVTvHIjXCM9awrslGudtFsrvkL9fUlxURScT7s2EohL4qZs7SlxRRJHWt1Z2iKNHZbug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088668; c=relaxed/simple;
	bh=MnItm0esiiBsh4+m6xljYe0QZ/22Hogi3WrUWp5GBn0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKLOfmIPGRJxyshCW9ktrHzpatGFVjx/XfHhIQ2q6RUzl8km3k5dkNIZCxMDSNWIJT+GEMdipX1PffSjXLUuzxAR3EMUo/gGAlikaxCTgHWiX+rksnmkg8eq2rXZE2iakzlezEAfX1Jc4pE5gkcCbLWKEJHd9R31B7m/sXfLkiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IL5b5hLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30695C4CEF4
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088667;
	bh=MnItm0esiiBsh4+m6xljYe0QZ/22Hogi3WrUWp5GBn0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IL5b5hLdGHmGrz32wYR4MbXwVcr+/z7CTa0870cX4SmIDd0weopyAS4dHnYgeaPTW
	 ONW76LOSlnfr8iEhAboss/fNF5v+hJHHz2gK7DyRrye8fwz3gHa/xlZv52k6wTJqzF
	 RlAGIfXWr1IoM+QdMhil4kYfuiUY0NpRIXQBKAK5Gg0q8SLuyEbOr8J/8rePyJiJxz
	 Tw4+I5lERzW7zrUPelWawkxDaDd3vDCH7k2ZrGZMZm1kcRWspYTMCOQgETojv/tp0b
	 lVQjoDAfKUKmSmF+j59KppkHVVHPfBBYsQuE2HP+qgAoCq57gjEvBpLzjCh4i8icJG
	 VjBBbYNrFBLkA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 30/33] btrfs: remove pointless inode lookup when processing extrefs during log replay
Date: Fri,  5 Sep 2025 17:10:18 +0100
Message-ID: <a18bc9aaaa0d05f6545878f85a086f7709b74578.1757075118.git.fdmanana@suse.com>
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

At unlink_extrefs_not_in_log() we do an inode lookup of the directory but
we already have the directory inode accessible as a function argument, so
the lookup is redudant. Remove it and use the directory inode passed in as
an argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6186300923b7..86c595ef57f4 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1165,10 +1165,8 @@ static int unlink_extrefs_not_in_log(struct walk_control *wc,
 
 	while (cur_offset < item_size) {
 		struct btrfs_trans_handle *trans = wc->trans;
-		struct btrfs_root *root = wc->root;
 		struct btrfs_root *log_root = wc->log;
 		struct btrfs_inode_extref *extref;
-		struct btrfs_inode *victim_parent;
 		struct fscrypt_str victim_name;
 		int ret;
 
@@ -1202,20 +1200,10 @@ static int unlink_extrefs_not_in_log(struct walk_control *wc,
 			continue;
 		}
 
-		victim_parent = btrfs_iget_logging(btrfs_ino(dir), root);
-		if (IS_ERR(victim_parent)) {
-			kfree(victim_name.name);
-			ret = PTR_ERR(victim_parent);
-			btrfs_abort_transaction(trans, ret);
-			return ret;
-		}
-
 		inc_nlink(&inode->vfs_inode);
 		btrfs_release_path(wc->subvol_path);
 
-		ret = unlink_inode_for_log_replay(wc, victim_parent, inode,
-						  &victim_name);
-		iput(&victim_parent->vfs_inode);
+		ret = unlink_inode_for_log_replay(wc, dir, inode, &victim_name);
 		kfree(victim_name.name);
 		if (ret)
 			return ret;
-- 
2.47.2


