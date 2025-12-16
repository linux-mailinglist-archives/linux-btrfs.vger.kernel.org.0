Return-Path: <linux-btrfs+bounces-19792-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6296FCC423F
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 17:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 593C830F3D72
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 16:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2366734DB56;
	Tue, 16 Dec 2025 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYvho0U1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DC834D919
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765900595; cv=none; b=cStZ0zltOfWmuHijczNY9HK58s+usB0H3w1cyoW8CGZDd7QHTEQI3pA3Gd9WlbfEObQAfpntNbMLHQEi4u28nep6DF0cKO7BL48oYVqw49z6/0fcXi+GV7DD5v3oOmumO+rXhdnCzJjK3CO0Pnxz48DieTh0r+dFl3qQQ/FDZ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765900595; c=relaxed/simple;
	bh=+9CtcWGImzwu+9fZYKtVfuR5TFTEsN8FxYu4mvf9uq0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Mu6UAZucK9DVUB9kik6dHexpsCTR8Z9Q9CuGJxImjSRPuBHw72UeP7ho85dsaX/nDpXhXNYkIQhEc4k4oAzBI+miuZ4yABbHdMZbYaBXre1CdFXZT8hAiWLpNK2WrmeskH6vZGck1Uxn1k2y1z1/LX3ydftd0gSD7wK1dEG/puk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYvho0U1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FAEC4CEF1
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 15:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765900594;
	bh=+9CtcWGImzwu+9fZYKtVfuR5TFTEsN8FxYu4mvf9uq0=;
	h=From:To:Subject:Date:From;
	b=ZYvho0U1Jk/g+04Rgl5DmOtM+xrKUSDl6oPMvpnnwBUFpERc0DXxkvZmDGf4QUJcH
	 MuGFJ0pJ/LG56Lt0XfIn6ABRcodrk8ux9aaGhWKBKxpbZNDxfKywsTGXeYZQu4ZVun
	 drGOzLJHz1Pi7eLgbds3c/vYdNIvdlMTEqNjBP63t5JRhRKCEtP7IId4hqZXbxIrZW
	 /U5f4JLdKV6eqEIJww1gCSYpK9l9Ih+owN9OlFkQOxOfshJQkokpAWTRNaRidq8t5z
	 cyC/O07LcDWQCyyY2iQiZtiGXVh2Ev7jB99TMiVKm3lYDLE0Tdn9+CxrRDkSD5HMIJ
	 zgWwmnU/KqIdw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: avoid transaction commit on error in del_balance_item()
Date: Tue, 16 Dec 2025 15:56:32 +0000
Message-ID: <de940c4488c9be72d8df22f48651b3c2f7d2978f.1765900568.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no point in committing the transaction if we failed to delete the
item, since we haven't done anything before. Also stop using two variables
for tracking the return value and use only 'ret'.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/volumes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d580d8669668..102f7b85206c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3689,7 +3689,7 @@ static int del_balance_item(struct btrfs_fs_info *fs_info)
 	struct btrfs_trans_handle *trans;
 	struct btrfs_path *path;
 	struct btrfs_key key;
-	int ret, err;
+	int ret;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -3716,9 +3716,9 @@ static int del_balance_item(struct btrfs_fs_info *fs_info)
 	ret = btrfs_del_item(trans, root, path);
 out:
 	btrfs_free_path(path);
-	err = btrfs_commit_transaction(trans);
-	if (err && !ret)
-		ret = err;
+	if (ret == 0)
+		ret = btrfs_commit_transaction(trans);
+
 	return ret;
 }
 
-- 
2.47.2


