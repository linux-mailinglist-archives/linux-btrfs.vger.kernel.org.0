Return-Path: <linux-btrfs+bounces-15475-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F90B025C2
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 22:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9E75A5622
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 20:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4981FBC8C;
	Fri, 11 Jul 2025 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQv+CZ4K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FB61F582A
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752265578; cv=none; b=SbPAoLmo9luZiqskygiVd2qG/o1XiY6ZFJRsjyf/6R4aYIWBWaE7h2bsoIEtNvdYlD0OeAdRrjZolHuQtBe985cqvxhdRrFjNcWrFljgGSv5Zzb0VSoVcjhbZ34qvpVnGeIX3uytr3LMIaT4xWRkR5CpGye4iAOosw1ajaFhtSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752265578; c=relaxed/simple;
	bh=kc9jKNRk2jtARdthmt22W2ocoIX24z8B6wC7+jgQrAU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2SjqUUeS1MWH3y1oj0ioZT6DGEGORx5Vw2kQ3xJx/K2tPl7YNBdLxdLWw5L0mDjdAuqfWEhI1pmx0gmzRYgz7ZzoGSdE3etSlP3VhwPVrCRNgTXEEp6Q1EVRMjcP6dHW6obf4hBu2iNHU7Z061lDHO7CrKvrGbZ2itTWlojAi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQv+CZ4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60907C4CEF4
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 20:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752265577;
	bh=kc9jKNRk2jtARdthmt22W2ocoIX24z8B6wC7+jgQrAU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jQv+CZ4KLRLV1fmh+DuaD99lTJH2j52k2OR1zTsBleqrsjWYFReqphhRMn9bGMd8R
	 AMfghZUrI51Hu8Clq4tQkiE+mEluc55YixhDW23fRaRr6dHpatDDAMgxHPm71TkSBT
	 dbRr1OBpgCFMITPbsgNwTgs70p8CDSpZNCjhJs0ATHUg+kj1XAGvGTuIl+ORs3hNMX
	 Kgq58KI+k2bwka/oYdShc0SPhaIhi3senDgnTDGouLADqICq5cEgwr3xFkrF6Rk6wB
	 44YSbzlBzwnXXVfqF31f+HDY9y1HPbi6dPV/u3/x0vHkBrU7Sv+E/HIo7aCLFt93Mk
	 7GobjGW2GaAdQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: don't ignore inode missing when replaying log tree
Date: Fri, 11 Jul 2025 21:26:10 +0100
Message-ID: <3ece7725d5f2e0b73443a1a5dfea9485341d34fd.1752265165.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1752265165.git.fdmanana@suse.com>
References: <cover.1752265165.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

During log replay, at add_inode_ref(), we return -ENOENT if our current
inode isn't found on the subvolume tree or if a parent directory isn't
found. The error comes from btrfs_iget_logging() <- btrfs_iget() <-
btrfs_read_locked_inode().

The single caller of add_inode_ref(), replay_one_buffer(), ignores an
-ENOENT error because it expects that error to mean only that a parent
directory wasn't found and that is ok.

Before commit 5f61b961599a ("btrfs: fix inode lookup error handling during
log replay") we were converting any error when getting a parent directory
to -ENOENT and any error when getting the current inode to -EIO, so our
caller would fail log replay in case we can't find the current inode.
After that commit however in case the current inode is not found we return
-ENOENT to the caller and therefore it ignores the critical fact that the
current inode was not found in the subvolume tree.

Fix this by converting -ENOENT to 0 when we don't find a parent directory,
returning -ENOENT when we don't find the current inode and making the
caller, replay_one_buffer(), not ignore -ENOENT anymore.

Fixes: 5f61b961599a ("btrfs: fix inode lookup error handling during log replay")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 5bdd89c44193..beb47a603411 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1416,6 +1416,8 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 	dir = btrfs_iget_logging(parent_objectid, root);
 	if (IS_ERR(dir)) {
 		ret = PTR_ERR(dir);
+		if (ret == -ENOENT)
+			ret = 0;
 		dir = NULL;
 		goto out;
 	}
@@ -1440,6 +1442,15 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 				if (IS_ERR(dir)) {
 					ret = PTR_ERR(dir);
 					dir = NULL;
+					/*
+					 * A new parent dir may have not been
+					 * logged and not exist in the subvolume
+					 * tree, see the comment above before
+					 * the loop when getting the first
+					 * parent dir.
+					 */
+					if (ret == -ENOENT)
+						ret = 0;
 					goto out;
 				}
 			}
@@ -2551,9 +2562,8 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 			   key.type == BTRFS_INODE_EXTREF_KEY) {
 			ret = add_inode_ref(wc->trans, root, log, path,
 					    eb, i, &key);
-			if (ret && ret != -ENOENT)
+			if (ret)
 				break;
-			ret = 0;
 		} else if (key.type == BTRFS_EXTENT_DATA_KEY) {
 			ret = replay_one_extent(wc->trans, root, path,
 						eb, i, &key);
-- 
2.47.2


