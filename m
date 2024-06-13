Return-Path: <linux-btrfs+bounces-5709-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9627906AB4
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 13:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64A88B221DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 11:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE8D142E73;
	Thu, 13 Jun 2024 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUoHwD85"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7507143750
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276735; cv=none; b=eyLgGIN/BP1pilpRA742FFidfqVm7QHuT4kbe8fVgzUbeEkpzQMBYr54hWVjLkGbNxzc6xQM2vlDiztnXOsWjKmbKDezMHbRBUOleO8MP+CgbKKmswsiZ8n9qrr5HFM16ImcpNjJvbqMXBmVXTtLJvFxttc1SKurm7YZ+pVX+LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276735; c=relaxed/simple;
	bh=xPpmEZehvQK6DIFLGSLLZQaQFfANbmFS5ARe5Uk2lqs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jne+fBZ18dPYruT1m+Ph8FY3rFRZTqoaq5JMDw8+kQG7utowPgIOns9Ro9EerpqCy5mSIpS9qWF0es7mkG6RsIax3foLxSUiEB7XVTYknV2qgVzMs95NrMHZ1EV3K4uBj5AQD+lCCVvsfvBU3nzF4HXp2kxbxHSR0AKvVqkovS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUoHwD85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4EFC4AF1A
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 11:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718276735;
	bh=xPpmEZehvQK6DIFLGSLLZQaQFfANbmFS5ARe5Uk2lqs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bUoHwD85SXYbxkVU6bhjrEsZTSaruVTuK9wRf4UE5e03cG3t7M8FL5eBufCqcWF5H
	 4XHThfHAgaA4rkNuen5yGThw/1/+Qe9SNPqRcFTf/CWX/yZA8/1U2ty+0Eu8VD1UaU
	 eZ479ahxV2YNvMDqkdV51HMqmVZZo5M72vyMEDC2dJNuqHM3h4mIPYSwvjjTdtLRgi
	 gNe9u2XbqALUckZ5dgMihRQ1pbxMQp/N8uzTKmPvKGPXZjwcpQDXhlwfXNa2qQAUro
	 GnnzmNBMQIprSoGRGcrG05dyR2Zc/PYlkj8Ik2A/gt52lg9a3gLTcIPTPA+Ns2hnLB
	 58bFr1l5BeBow==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: remove super block argument from btrfs_iget_locked()
Date: Thu, 13 Jun 2024 12:05:28 +0100
Message-Id: <bc57111ab84d909339f77cedaecb3e3a6088189d.1718276261.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718276261.git.fdmanana@suse.com>
References: <cover.1718276261.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's pointless to pass a super block argument to btrfs_iget_locked()
because we always pass a root and from it we can get the super block
through:

   root->fs_info->sb

So remove the super block argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 43cedb8ff14c..d6c43120c5d3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5573,8 +5573,7 @@ static int btrfs_find_actor(struct inode *inode, void *opaque)
 		args->root == BTRFS_I(inode)->root;
 }
 
-static struct inode *btrfs_iget_locked(struct super_block *s, u64 ino,
-				       struct btrfs_root *root)
+static struct inode *btrfs_iget_locked(u64 ino, struct btrfs_root *root)
 {
 	struct inode *inode;
 	struct btrfs_iget_args args;
@@ -5583,7 +5582,7 @@ static struct inode *btrfs_iget_locked(struct super_block *s, u64 ino,
 	args.ino = ino;
 	args.root = root;
 
-	inode = iget5_locked(s, hashval, btrfs_find_actor,
+	inode = iget5_locked(root->fs_info->sb, hashval, btrfs_find_actor,
 			     btrfs_init_locked_inode,
 			     (void *)&args);
 	return inode;
@@ -5601,7 +5600,7 @@ struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
 	struct inode *inode;
 	int ret;
 
-	inode = btrfs_iget_locked(root->fs_info->sb, ino, root);
+	inode = btrfs_iget_locked(ino, root);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.43.0


