Return-Path: <linux-btrfs+bounces-19735-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC19CBD33F
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 10:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 945873017381
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 09:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F78329E7C;
	Mon, 15 Dec 2025 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/ix+HX1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548A12DC352
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765791514; cv=none; b=qVO+W0+CcbdE0lCfjTLc+Qwc2SS+bUgFpWIbRZ3AlBTynHb1p40UeM7Fn4YctQNJgO5137ILde257xllnE5G54TNOg/hQzCFU5G9j3Iv7it88TYmu9xkElM+Oyq93zI8YMNrlWXqSb338iZeSrtwppeg8yF5zmzfrAF2x6u5wRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765791514; c=relaxed/simple;
	bh=ssojhsNSwNgkhrRY6bHEljf9kr/VidLlRAnAegiR+cg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZkiCcweX0EJhjKAPLUMe+Cu0JPWF9yrPBXSfT3K4iBoi7XH/ek6Pxt3n3Obu0cc37HQ0B2TSQobbUqq8hCdn2laYrGq+ufokUn/gCKNtPOUDZmb8p31S7Gdp41l6KOvW3C/JLt3cncD+b7JJGno4opPjCbNF+nUk7gTcw2Z0xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/ix+HX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2BFC19425
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 09:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765791512;
	bh=ssojhsNSwNgkhrRY6bHEljf9kr/VidLlRAnAegiR+cg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=p/ix+HX18irbg9pXkCQSublbsAugLpRAAyq6s4xYsqqmc3AnD/UmP2w8ijyEkpSnN
	 AjiZNkfF4sdDkus8Fev0I+Q4vHpJTeK6jnal3CKMhvloNarjzjcXY5B1KnzOY571TV
	 +VDZMgstTOGbH+5SKrs64+pvrdeYIOX2D9BDo3H3TYfGdodqYWeHyY8z1mVUTGrQZj
	 ldnYfX3JqPUMLtwd2ebxh29OZeCRzPRy4zwj4gYcS5RyNqgmSn+HNwSxASvXawc1Z4
	 mDN4owBcxnQTeJZAoCijW8dQ90EG/RH9sGg4hQPgarnh6wfccBLv+wN/LWRRAaAMyU
	 SliHoadVoPiNA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: fix reservation leak in some error paths when inserting inline extent
Date: Mon, 15 Dec 2025 09:38:26 +0000
Message-ID: <2b8666d39b9c50459a1ef6468d4db175bd1016f0.1765743479.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1765743479.git.fdmanana@suse.com>
References: <cover.1765743479.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we fail to allocate a path or join a transaction, we return from
__cow_file_range_inline() without freeing the reserved qgroup data,
resulting in a leak. Fix this by ensuring we call btrfs_qgroup_free_data()
in such cases.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 605589f29da7..f1ead789146b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -619,19 +619,22 @@ static noinline int __cow_file_range_inline(struct btrfs_inode *inode,
 	struct btrfs_drop_extents_args drop_args = { 0 };
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_trans_handle *trans;
+	struct btrfs_trans_handle *trans = NULL;
 	u64 data_len = (compressed_size ?: size);
 	int ret;
 	struct btrfs_path *path;
 
 	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
+	if (!path) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	trans = btrfs_join_transaction(root);
 	if (IS_ERR(trans)) {
-		btrfs_free_path(path);
-		return PTR_ERR(trans);
+		ret = PTR_ERR(trans);
+		trans = NULL;
+		goto out;
 	}
 	trans->block_rsv = &inode->block_rsv;
 
@@ -682,7 +685,8 @@ static noinline int __cow_file_range_inline(struct btrfs_inode *inode,
 	if (ret <= 0)
 		btrfs_qgroup_free_data(inode, NULL, 0, fs_info->sectorsize, NULL);
 	btrfs_free_path(path);
-	btrfs_end_transaction(trans);
+	if (trans)
+		btrfs_end_transaction(trans);
 	return ret;
 }
 
-- 
2.47.2


