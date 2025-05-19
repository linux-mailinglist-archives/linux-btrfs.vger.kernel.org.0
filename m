Return-Path: <linux-btrfs+bounces-14118-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14174ABBBFF
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 13:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B5C07A4AF0
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 11:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69149274650;
	Mon, 19 May 2025 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VC3OQRUo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0861F462C
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747652911; cv=none; b=emuhLywSt0LPiZEFOt97U++bHQuxKUr/cxQZAiHLhu9VA8hRbI3EmLvQVY01kjFSx2YwJu7FqIAboEvoaTGiWgtsBVOVFWChtCG+zftKDIHf1U3TRplmfBam6zf1qkM2at4eKfnwvYp2MmAPyVs88ZRK7p5PmeoPgz8+SD4nn2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747652911; c=relaxed/simple;
	bh=PSJPp5dsEIHO83FWP8572PJ49X8gxlFu8UhZ36FRN24=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=OPY/NQtQMLCNxpv0GrXlThLCQrFR7khnMWtZBfPpDG9u6Gl6pSdSxxD6bV89Zki3e5qIF7l45p7Xr7jH2SZ16RrplaC70SgnEBaBPibMhbFLqrm7akdiCttOZxWF1p4KMoUJaiQ1MDZA8tDi4gAH5WmjZ7mD9W7wpcRwTMdQc6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VC3OQRUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E56C4CEEB
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 11:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747652910;
	bh=PSJPp5dsEIHO83FWP8572PJ49X8gxlFu8UhZ36FRN24=;
	h=From:To:Subject:Date:From;
	b=VC3OQRUoDKXlxME4vaaMrcfrgb/F36dhHhIuxBpR/ufU4hDgwkyWANj+nsMBqDI6u
	 4ZeEEpQw2ewWMvMVj2bZDAiIqulPtXObuR4LzbsZ84ywheY3mN55Fc5PLzl6iVBaSZ
	 nl9ANKz+7XJXMvFBuebhGJaykZ6cBQVR0gnCSaMwE/otTOpp/jyB721J/493IWGypu
	 WoyMLBLa2hViM8E9r33ftUYwC87IpRz4fjfKezv1heZpgrgbpI0+UYNFzeWOeR3/PV
	 UXZ0oLY1gT19YCZ26aQoDdUknOx4qD3tMknQsspIMC5vONCaT14IT9Dd+YC0J5MIpf
	 X5LlsZHiyGqMw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: unfold transaction abort at __btrfs_update_delayed_inode()
Date: Mon, 19 May 2025 12:08:26 +0100
Message-Id: <a6bf92c79d644323883eb18bbde8f45dde8e6476.1747652848.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have a common error path where we abort the transaction, but like this
in case we get a transaction abort stack trace we don't know exactly which
previous function call failed. Instead abort the transaction after any
function call that returns an error, so that we can easily indentify which
function failed.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index c7cc24a5dd5e..3d25510db388 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1008,8 +1008,16 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
 	ret = btrfs_lookup_inode(trans, root, path, &key, mod);
 	if (ret > 0)
 		ret = -ENOENT;
-	if (ret < 0)
+	if (ret < 0) {
+		/*
+		 * If we fail to update the delayed inode we need to abort the
+		 * transaction, because we could leave the inode with the
+		 * improper counts behind.
+		 */
+		if (ret != -ENOENT)
+			btrfs_abort_transaction(trans, ret);
 		goto out;
+	}
 
 	leaf = path->nodes[0];
 	inode_item = btrfs_item_ptr(leaf, path->slots[0],
@@ -1034,8 +1042,10 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
 
 		btrfs_release_path(path);
 		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
-		if (ret < 0)
+		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
 			goto err_out;
+		}
 		ASSERT(ret > 0);
 		ASSERT(path->slots[0] > 0);
 		ret = 0;
@@ -1057,21 +1067,14 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
 	 * in the same item doesn't exist.
 	 */
 	ret = btrfs_del_item(trans, root, path);
+	if (ret < 0)
+		btrfs_abort_transaction(trans, ret);
 out:
 	btrfs_release_delayed_iref(node);
 	btrfs_release_path(path);
 err_out:
 	btrfs_delayed_inode_release_metadata(fs_info, node, (ret < 0));
 	btrfs_release_delayed_inode(node);
-
-	/*
-	 * If we fail to update the delayed inode we need to abort the
-	 * transaction, because we could leave the inode with the improper
-	 * counts behind.
-	 */
-	if (ret && ret != -ENOENT)
-		btrfs_abort_transaction(trans, ret);
-
 	return ret;
 }
 
-- 
2.47.2


