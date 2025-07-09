Return-Path: <linux-btrfs+bounces-15403-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7BAAFF2DB
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 22:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339CD3B7F9D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 20:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC8A244679;
	Wed,  9 Jul 2025 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fxob1hd+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CEA242D73
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752092440; cv=none; b=TZO47IrShO3tdhzJaE4KyWgGIqjyqTVGPqrD1le+Fn8Epr6fMQsb8aUhjgPkpQnqFQCBkQpWsLbLoxMhDG1qxPyCR9sNgicEK8lUomVJKhLhDZ99QI6O5G5Dy37yb18CKeouKQeGNkKX0fGLYg9mLuuQnLc65JoYsAW+TQO+3Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752092440; c=relaxed/simple;
	bh=eafg7lGjrlf+ehCeleHeuKqEXgU5BllKJUbrCWxjaqw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPVXdEbKk9riPGSofxn+HJ819ReInQLfCtQQTEaE7u7zehJMcmcgZCXhaXMcJUHBwzmoXLbyAcjDgWtavlelFtObV5ldfMu3FZLHBc0PW+HvJ+YmHCMC8eMShXyxdyyHO7z0PXP7dsI96IwpKRGs5iPSoUjPF4IHFeiQFgO4jEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fxob1hd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB42C4CEEF
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 20:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752092438;
	bh=eafg7lGjrlf+ehCeleHeuKqEXgU5BllKJUbrCWxjaqw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Fxob1hd+A0hVv+cU6srfDvgfEYRgyI45v/EHrN6MhuYGbzd7+e48x4A1va21nwIgM
	 UCpb3LvwXy/B4K756XgqE6ulLFpD56+6eElM4RQ3Vl0NJhwDXDJS4pBI7kS19Q3W2U
	 qC6WM5gnEBx+qvzZ5esoV/Rh6sAurL8X8wEh+0gVdW5GpVauoOzX4zlk8U9eAbaeb8
	 eChrojgEc1I0fRPNEh/urt6OsYfziwYFxqD1ghEKdKjoe3rBZRp67x6WCK/XkKVoYE
	 NegFftu9G9JVbxyejkwwGrsOZAjpk43yjwVJUeU6QRwaAklFdQg5YhO7oEknvpHMdk
	 L9GWTZP6S7v9w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: make btrfs_check_nocow_lock() check more than one extent
Date: Wed,  9 Jul 2025 21:20:30 +0100
Message-ID: <aa1e1c24d69b22311f32c70d8fb2d629ba71173b.1752092303.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1752092303.git.fdmanana@suse.com>
References: <cover.1752092303.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently btrfs_check_nocow_lock() stops at the first extent it finds and
that extent may be smaller than the target range we want to NOCOW into.
But we can have multiple consecutive extents which we can NOCOW into, so
by stopping at the first one we find we just make the caller do more work
by splitting the write into multiple ones, or in the case of mmap writes
with large folios we fail with -ENOSPC in case the folio's range is
covered by more than one extent (the fallback to NOCOW for mmap writes in
case there's no available data space to reserve/allocate was recently
added by the patch "btrfs: fix -ENOSPC mmap write failure on NOCOW
files/extents").

Improve on this by checking for multiple consecutive extents.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c2e83babdb8d..bc1e00db96c9 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -984,8 +984,8 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 	struct btrfs_root *root = inode->root;
 	struct extent_state *cached_state = NULL;
 	u64 lockstart, lockend;
-	u64 num_bytes;
-	int ret;
+	u64 cur_offset;
+	int ret = 0;
 
 	if (!(inode->flags & (BTRFS_INODE_NODATACOW | BTRFS_INODE_PREALLOC)))
 		return 0;
@@ -996,7 +996,6 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 	lockstart = round_down(pos, fs_info->sectorsize);
 	lockend = round_up(pos + *write_bytes,
 			   fs_info->sectorsize) - 1;
-	num_bytes = lockend - lockstart + 1;
 
 	if (nowait) {
 		if (!btrfs_try_lock_ordered_range(inode, lockstart, lockend,
@@ -1008,14 +1007,36 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 		btrfs_lock_and_flush_ordered_range(inode, lockstart, lockend,
 						   &cached_state);
 	}
-	ret = can_nocow_extent(inode, lockstart, &num_bytes, NULL, nowait);
-	if (ret <= 0)
-		btrfs_drew_write_unlock(&root->snapshot_lock);
-	else
-		*write_bytes = min_t(size_t, *write_bytes ,
-				     num_bytes - pos + lockstart);
+
+	cur_offset = lockstart;
+	while (cur_offset < lockend) {
+		u64 num_bytes = lockend - cur_offset + 1;
+
+		ret = can_nocow_extent(inode, cur_offset, &num_bytes, NULL, nowait);
+		if (ret <= 0) {
+			/*
+			 * If cur_offset == lockstart it means we haven't found
+			 * any extent against which we can NOCOW, so unlock the
+			 * snapshot lock.
+			 */
+			if (cur_offset == lockstart)
+				btrfs_drew_write_unlock(&root->snapshot_lock);
+			break;
+		}
+		cur_offset += num_bytes;
+	}
+
 	btrfs_unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 
+	/*
+	 * cur_offset > lockstart means there's at least a partial range we can
+	 * NOCOW, and that range can cover one or more extents.
+	 */
+	if (cur_offset > lockstart) {
+		*write_bytes = min_t(size_t, *write_bytes, cur_offset - pos);
+		return 1;
+	}
+
 	return ret;
 }
 
-- 
2.47.2


