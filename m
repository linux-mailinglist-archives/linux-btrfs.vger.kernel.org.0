Return-Path: <linux-btrfs+bounces-14371-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF27EACAC8A
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 12:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FCD0401101
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 10:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA01020B7F4;
	Mon,  2 Jun 2025 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGAhxOVu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0493209F46
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860404; cv=none; b=sQJ8pnUFwXy8awDJIfUuIVNx9ub2nYO6gK8ho1Gr8xeYb780j6NFqrJq7Mfek9PkDp3ls2eyNa2jBaSgKtIQNi3b/i0yOnGTHE9C8aNkhpEjcLTdP4LoHyQ0FYZ1hQ/G5BuAoOVekexhYM50EQJnGxC6T9qSXXqdid5MbWpUxSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860404; c=relaxed/simple;
	bh=+ylb58G8zMhlqa/LJdbvKP6ArqsgwEtvkoYwVFJRoRI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hI3ALceCK2pNWvaWPrXqxVmpCzVfZxniQ3tZoODmdmBq2P2avK94sC2kPpBpthpxVCRDwhoqIYLGSqssg7lMvA5jegyy+gDktnqijJt1x+iODAogYzsJMUAXeUdV7RfUjDMQt67zS7wmVaaCGy5GLMmh40Rebm3HTzhhZ6Z6Z9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGAhxOVu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE30EC4CEED
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748860403;
	bh=+ylb58G8zMhlqa/LJdbvKP6ArqsgwEtvkoYwVFJRoRI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tGAhxOVub65YnbBPRaelRL4VWs2+P4ghAKNUK+4K8TpfjMFHYhMme+kW9e6b5XOYu
	 Tkne/bs3yi9sy5i4mnL9hds63cGxw/Glx4j9arpxK3vs7/FXKOR0QqrepRlO6Nd3qw
	 TS1DZMCZb7mtYQT+JyF9mxS5J0zyU79rXfPV7cYOPOiU8yymfdwhD1na/h9sv9NpuA
	 YTotB3BSuQxsxTF8h1q3Gd8Jn9sxXtTGCAjygVE7LYKJhgWyOK6DxehoTlelhTvq9x
	 0wyDCaRAEZ5Y/Grr60sQR+k7SgowPgjyFRf1VLJyQt7GK7L1hHEoSZdm6UNV+DPfah
	 jJlFnX34MwiGA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 09/14] btrfs: pass NULL index to btrfs_del_inode_ref() where not needed
Date: Mon,  2 Jun 2025 11:33:02 +0100
Message-ID: <65d85410763104c6823d06288d0094ec56cd80ea.1748789125.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1748789125.git.fdmanana@suse.com>
References: <cover.1748789125.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There are two callers of btrfs_del_inode_ref() that declare a local index
variable and then pass a pointer for it to btrfs_del_inode_ref(), but then
don't use that index at all. Since btrfs_del_inode_ref() accepts a NULL
index pointer, pass NULL instead and stop declaring those useless index
variables.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c    | 4 +---
 fs/btrfs/tree-log.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a9a37553bc45..890d20868250 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6711,11 +6711,9 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 		if (err)
 			btrfs_abort_transaction(trans, err);
 	} else if (add_backref) {
-		u64 local_index;
 		int err;
 
-		err = btrfs_del_inode_ref(trans, root, name, ino, parent_ino,
-					  &local_index);
+		err = btrfs_del_inode_ref(trans, root, name, ino, parent_ino, NULL);
 		if (err)
 			btrfs_abort_transaction(trans, err);
 	}
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index a40afb44702c..c639fe492a25 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3502,7 +3502,6 @@ void btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
 				struct btrfs_inode *inode, u64 dirid)
 {
 	struct btrfs_root *log;
-	u64 index;
 	int ret;
 
 	ret = inode_logged(trans, inode, NULL);
@@ -3520,8 +3519,7 @@ void btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
 	log = root->log_root;
 	mutex_lock(&inode->log_mutex);
 
-	ret = btrfs_del_inode_ref(trans, log, name, btrfs_ino(inode),
-				  dirid, &index);
+	ret = btrfs_del_inode_ref(trans, log, name, btrfs_ino(inode), dirid, NULL);
 	mutex_unlock(&inode->log_mutex);
 	if (ret < 0 && ret != -ENOENT)
 		btrfs_set_log_full_commit(trans);
-- 
2.47.2


