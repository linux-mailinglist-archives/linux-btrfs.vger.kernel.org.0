Return-Path: <linux-btrfs+bounces-4157-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A968A1C65
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 19:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D2D1C219F6
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 17:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D413190681;
	Thu, 11 Apr 2024 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCvcPIkd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E7F18412C
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852371; cv=none; b=fcqpjFBDLVrfesVlW+Ag2DxUzeSeMliMiqtBAkAlqtaB3j/eFtsaZ1Zo3gE00NGa0PM9Lm+gvm/2PFkkQSr7EG+dDJB2krC1XHLbvZHcIp0eO6+agwge9XUvC2jcKo549rFgTk2JcvV1qXjZo2oPW0oKgahljuxUjTFFQlLXin0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852371; c=relaxed/simple;
	bh=HI3YUCV6ogY701l3EzQE6IVpXTuw0BhgDGgGeTU6C8Q=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=duJCEbj4tu9ZNVWKhVjTj9l83iwXZPILk6GVyt80cK62v4jyHvTdG+1eJfpfsocUaIQV8LfmaP6Smt9RlWT2XLAaIZ6aNYAiFaIlC9c953lVTHaNGyiJfIzKgVXei6awPXSODWnNjZ1eeDK+udKtyqa2xDgN2jJEzbufDhoOF3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCvcPIkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5B3C072AA
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712852371;
	bh=HI3YUCV6ogY701l3EzQE6IVpXTuw0BhgDGgGeTU6C8Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tCvcPIkdv5JZV9mgcb+Q1ShPBtW1qZBS6SzsEJwWGtxrkcqGgLb9xcjaFbzIA9vvn
	 ijzjanDHooUmnwmnmjYAK/MyfrsT91r+dbcVTQjk1qUbtlfXVcrIKY9xiTaQAHLAjU
	 HjyTa4xin+ABUx/KZCelC32EUDpYycPvAHuRgvdTYW7JOOQcEwYMjkEAUnI9ZAPHel
	 /ZE8NSPt8FOh3qc/LUkRCRui1CemjU3k+s7Aga2T94ff75qiM4v4zMsPPadXv+Gmhc
	 XQlc4bYPVZazyoBHvP2j0Xs36dJxJGNpvujkLOb9We6PymzbxExLpPu/V3/ZfyIGHp
	 ed+KkQiKV3KGg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 14/15] btrfs: update comment for btrfs_set_inode_full_sync() about locking
Date: Thu, 11 Apr 2024 17:19:08 +0100
Message-Id: <301cd211de3cb3854c65f937b94791d1f1dcc2ae.1712837044.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712837044.git.fdmanana@suse.com>
References: <cover.1712837044.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Nowadays we have a lock used to synchronize mmap writes with reflink and
fsync operations (struct btrfs_inode::i_mmap_lock), so update the comment
for btrfs_set_inode_full_sync() to mention that it can also be called
while holding that mmap lock. Besides being a valid alternative to the
inode's VFS lock, we already have the extent map shrinker using that mmap
lock instead.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 9a87ada7fe52..91c994b569f3 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -381,9 +381,11 @@ static inline void btrfs_set_inode_last_sub_trans(struct btrfs_inode *inode)
 }
 
 /*
- * Should be called while holding the inode's VFS lock in exclusive mode or in a
- * context where no one else can access the inode concurrently (during inode
- * creation or when loading an inode from disk).
+ * Should be called while holding the inode's VFS lock in exclusive mode, or
+ * while holding the inode's mmap lock (struct btrfs_inode::i_mmap_lock) in
+ * either shared or exclusive mode, or in a context where no one else can access
+ * the inode concurrently (during inode creation or when loading an inode from
+ * disk).
  */
 static inline void btrfs_set_inode_full_sync(struct btrfs_inode *inode)
 {
-- 
2.43.0


