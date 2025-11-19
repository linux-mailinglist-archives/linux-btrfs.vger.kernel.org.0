Return-Path: <linux-btrfs+bounces-19148-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5DFC6EE6F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 14:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6212634B07C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 13:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD0335A953;
	Wed, 19 Nov 2025 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXesJ7fA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25C935FF4B
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558372; cv=none; b=TtDExE8lGb6H0XBvVqes7Pgd9fWVG0Dh4CD5qmtVHDXWFqMg9yIypbbfE2wiaHP0p/TF/Z+4mVS088mB7Q9yOlQHrqZ9P3FEKiyAEBLB/aOoIr9IuwMkb5FuAfeJyfmYPYZwSYroUrOkTXHeHKI/aY0wa9UVP5ZLTclaH3S3SaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558372; c=relaxed/simple;
	bh=UNeusGO6MP/KL2juv+632/mfTrzqcAqAf7Amzyw9kz0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFkKsAB54CwYk8YZBfeOmPKS1VbtDP4pjkhkW02XQ54Dp1uOPNDtgU45o18XspenzBMMK5c+Jhm2RWdU00tBDVScfgzzUAhvOTLDcxBhQMzvnTARie3JKJX65AKisw2EkK4rbCGJMirnG2MDvMkt8WnYmHcmrnedCiP80za6Mh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXesJ7fA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90083C2BCFA
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 13:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763558372;
	bh=UNeusGO6MP/KL2juv+632/mfTrzqcAqAf7Amzyw9kz0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RXesJ7fAQwWjKgsPeQujkEfwVdFA6hElTG8Fu6Re/WFz26krGCiiiQ63OGk5F/LG9
	 GXFL89AMppPBTvJtqDt8O0l66DvwXLFEmteWcsHqOZCleKJzniCTLjle03j/J0izkJ
	 d8EqPiEq1jzVvzbrGo2IVSokDarLdwl84zHFRF6FtyhKLipODlqQizbiksp9/g5da9
	 DkWBH1JKFFQBdVcivv7sW5YprcimiqQiGW6MZfbgLxdbqOMDvrq3zJRIHUev24VrCS
	 qO3cmYM/krTEQ0jgUfFdVA51WNu15nbWoXPGzQnJawFI34Ob4KCmSUSkgarOZkt+Fr
	 GuowAjsYfaPnA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: remove root argument from btrfs_del_dir_entries_in_log()
Date: Wed, 19 Nov 2025 13:19:07 +0000
Message-ID: <87035f445363dbac0f1d5cc5717fc0f520a273e4.1763557872.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1763557872.git.fdmanana@suse.com>
References: <cover.1763557872.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to pass the root as we can extract it from the directory
inode, so remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c    | 2 +-
 fs/btrfs/tree-log.c | 2 +-
 fs/btrfs/tree-log.h | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f71a5f7f55b9..16d416fe536b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4359,7 +4359,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	 */
 	if (!rename_ctx) {
 		btrfs_del_inode_ref_in_log(trans, root, name, inode, dir_ino);
-		btrfs_del_dir_entries_in_log(trans, root, name, dir, index);
+		btrfs_del_dir_entries_in_log(trans, name, dir, index);
 	}
 
 	/*
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index cc27f87c4904..c2e45e64ab6c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3900,10 +3900,10 @@ static int del_logged_dentry(struct btrfs_trans_handle *trans,
  * or the entire directory.
  */
 void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
-				  struct btrfs_root *root,
 				  const struct fscrypt_str *name,
 				  struct btrfs_inode *dir, u64 index)
 {
+	struct btrfs_root *root = dir->root;
 	BTRFS_PATH_AUTO_FREE(path);
 	int ret;
 
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index 4f149d7d4fde..a0aeec2448c0 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -79,7 +79,6 @@ int btrfs_log_dentry_safe(struct btrfs_trans_handle *trans,
 			  struct dentry *dentry,
 			  struct btrfs_log_ctx *ctx);
 void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
-				  struct btrfs_root *root,
 				  const struct fscrypt_str *name,
 				  struct btrfs_inode *dir, u64 index);
 void btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
-- 
2.47.2


