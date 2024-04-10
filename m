Return-Path: <linux-btrfs+bounces-4108-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B7189F0E4
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 13:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0EBFB223BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 11:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAF415ECF4;
	Wed, 10 Apr 2024 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPHEql/b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A1715ECE5
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748537; cv=none; b=fkdxSzXg9nYkv6lwOfL555S72nJyueL/m2ltY6M/R2qdHdIuFlksnsp4lmlpnxLVksUAVJfjVvYAIVV04ETyLRH68wTCOiUEjH20503ADHnYhF66+t71DX1PGJpC6r7uB8eU103RuTq0H1Eyg6bNRgqs4yRsVPj2e6dljc+TQJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748537; c=relaxed/simple;
	bh=67jWQQ9sTDxMQWCgMTV9sLUnQFeO9k20o3t6eEgqmUw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hgMTCvdSETa5RzU9NzrRtw2Fz7mH5GLyDtXLamx3LptccFnP/D2g9K/HVNzIWKYGa5xGx0M/W4XZKTCGOiYgqT9GEXMHRm1745UxeEPoKkkfO1+SDVAT1dV+ZbSTSrH/ln852axqEUfXHjdmHnIsE2jrcArgSTCgd5FmF76jR7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPHEql/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B2DC433C7
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 11:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712748537;
	bh=67jWQQ9sTDxMQWCgMTV9sLUnQFeO9k20o3t6eEgqmUw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aPHEql/b2ZWbpjcBc+gaXvdJ5ec37eu4MUzGPKwud4D41awDArrupmXyYVehVThed
	 TqOWAB5lXZ08bKKQFnVam6jreNZz4/qEXbcXj7P55YeREvbNUegw4gdKp3rjiWh24Y
	 ibU7N6l4g+ldaPci6/1Wh2SItbWPPn48nrojnS74OZzczu95H80B2wpB5Or8vJZjAS
	 62E07RsmZiS7FLsLTpmVePiIQxg8tkk/3+SRrcKDXoccuOO8nc/HLHbLod/R60YFXo
	 a2BfvReT6ovbeGjNEC0YqQ3GOepG9UiLpY83Y3p+v+Bdv4ko87tWhPA+PeVc0d8B2E
	 kUPO3c9UgHVuw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 10/11] btrfs: update comment for btrfs_set_inode_full_sync() about locking
Date: Wed, 10 Apr 2024 12:28:42 +0100
Message-Id: <5011cf788a2c295a13040bc3b1af9e56c33553a0.1712748143.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712748143.git.fdmanana@suse.com>
References: <cover.1712748143.git.fdmanana@suse.com>
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
index 100020ca4658..ce01709e372f 100644
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


