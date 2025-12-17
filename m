Return-Path: <linux-btrfs+bounces-19842-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 18665CC8B69
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 17:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90FA13022F8F
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 16:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27F632D0E2;
	Wed, 17 Dec 2025 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knMsZLdZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8985327219
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765987593; cv=none; b=gKcsWvrAZHjEMqk1Zvh7rNGchtW2aSeCt1SYErKDQ1Cr/62fsfSeff8yo8seRYv7Jm0n/n9ooxtnUQMMpItRRJjWmKcmh/vu7M7oLjHgDhHxqUG3mrr/KQD7x84kP05QumvbwKxicqBrxBr1GYpQz8KuX4Th+Pc8SaeESIY4YH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765987593; c=relaxed/simple;
	bh=CIkAeU1mpEtsX7FKf7lmh4hfOGPwRSe307l6aeK5MFg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=js92Gc9RYROML/738nKZproZdQ0jGk48sTF8vZqAmdb7GIMZmRqxsvqxir7WU3o/XON1h+fJDVdmp28du4kKAEdROKA4WPB6OWotv/iS86uuezLRanZ9OD+dQOQxdZc9BBU72uKWqpdE3i0h4ptIz9vUuU+VwKdy79d7n16Hxuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knMsZLdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57C3C4CEF5
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 16:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765987592;
	bh=CIkAeU1mpEtsX7FKf7lmh4hfOGPwRSe307l6aeK5MFg=;
	h=From:To:Subject:Date:From;
	b=knMsZLdZOg6qO6Qr9nRhPJo3NE+9igmXG8R47Nwj4gSgVMhD6IUptgFiHXFZDxfoR
	 BdJQISqXeOjrtPmlS5FQeh376w+aIS7bODMfHox1BkGsmf3BIsFFrXtmdYKunnhG8c
	 JU5S0x/Hqumatv7TROQtOp1luHsTpDkFkmTRM0aB4e7tqLYi+A/t6vM3eZoahZwJa4
	 6H3nbTxuVjH++LgTXNBmd/ubnzUAfUnZxN9vldKYTRVXcQFj6xI7YxWScApmTE9Rqy
	 fTtpa/+PYDXdmpeSMKF0N1Xv7YYJKyVkaMmJcncLkD/57/D0rNNlOxlIdnJeN2Yu1Q
	 1aQItQqW7Ag5A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: avoid transaction commit on error in insert_balance_item()
Date: Wed, 17 Dec 2025 16:06:28 +0000
Message-ID: <d5f264d5a8be85998a6b65c5be122e56dbea5647.1765987488.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no point in committing the transaction if we failed to insert the
balance item, since we haven't done anything else after we started/joined
the transaction. Also stop using two variables for tracking the return
value and use only 'ret'.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/volumes.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 072f01b973a1..ce0535c0264d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3642,7 +3642,7 @@ static int insert_balance_item(struct btrfs_fs_info *fs_info,
 	struct btrfs_path *path;
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
-	int ret, err;
+	int ret;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -3677,9 +3677,11 @@ static int insert_balance_item(struct btrfs_fs_info *fs_info,
 	btrfs_set_balance_flags(leaf, item, bctl->flags);
 out:
 	btrfs_free_path(path);
-	err = btrfs_commit_transaction(trans);
-	if (err && !ret)
-		ret = err;
+	if (ret == 0)
+		ret = btrfs_commit_transaction(trans);
+	else
+		btrfs_end_transaction(trans);
+
 	return ret;
 }
 
-- 
2.47.2


