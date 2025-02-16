Return-Path: <linux-btrfs+bounces-11487-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 644EAA3747F
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Feb 2025 14:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E543AA98B
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Feb 2025 13:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3137D19342E;
	Sun, 16 Feb 2025 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyLOMPb1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774701922E1
	for <linux-btrfs@vger.kernel.org>; Sun, 16 Feb 2025 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739711771; cv=none; b=ibervbE8k3m3ba6xidFIuPJXZIKS0IYgfORtnMGjzUhvH/2/YMzmSxVNjvKeQjWFDvv+w+ikArcqz1aw+jozaw5YXNfXCc4/kjOCOyM1LA0zosc37Sf0PU3W1+C2w6BlJe+5JfDHf45CPbgC9jfFQUpLUgE/Lc0lK4rtpUnVEBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739711771; c=relaxed/simple;
	bh=QfHeRz8iwer6p2OtaUFeKxKIiN2+3pQ3ywUXi2DoRLE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L6SUuCGwyzDMkOsMaQDtk+d0yYZrn0zSqBl/gBzOtZHJId739YYTSr/O2Dd+puzAFkVZJZLAfPiL1LPeFU+jgXTwgUGVS8sXfN9wDqGo5GWnr53qqrhTeCJF7H6viYcP1khhas/IYCj1fQ+7w9nWOV4eQqFLDSGK+lbN8ezOcFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyLOMPb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE43C4CEE2
	for <linux-btrfs@vger.kernel.org>; Sun, 16 Feb 2025 13:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739711770;
	bh=QfHeRz8iwer6p2OtaUFeKxKIiN2+3pQ3ywUXi2DoRLE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DyLOMPb1HtvF6wAPiWOpMZa0gsrOa7Oa10+oV5hHNLuPeQIJ6LPv+YMuvFCl698ti
	 TpByok6ST6irRsjQFlCM9tUK2q6ydGHo1QjnqAUCw8fmyJk/Tas59GEETxF+n6zlwo
	 BgWGQKFslX0mTBw9K61IjnC30ju6WxLtQf6Yn3U2gVjQVlfMnGrwWYvtz00Nhbc2ae
	 PPvEPjmhmYa4RMl95sd70M2Xlo8kRM0tOKW4gnNi5fa27L1sYKzn1pPUVkP6g2qhOD
	 FkhmlSefYvR1U7rfzUNGYsheCbzbUkLRHiO3ZREZrL3TqkNmvAP2tf32CZUynNOYIJ
	 sK7PfQvxNnfCw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: fix use-after-free on inode when scanning root during em shrinking
Date: Sun, 16 Feb 2025 13:16:03 +0000
Message-Id: <38c908d189e4bd6c5d137c20d9fb905509625069.1739710434.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739710434.git.fdmanana@suse.com>
References: <cover.1739710434.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_scan_root() we are accessing the inode's root (and fs_info) in a
call to btrfs_fs_closing() after we have scheduled the inode for a delayed
iput, and that can result in a use-after-free on the inode in case the
cleaner kthread does the iput before we dereference the inode in the call
to btrfs_fs_closing().

Fix this by using the fs_info stored already in a local variable instead
of doing inode->root->fs_info.

Fixes: 102044384056 ("btrfs: make the extent map shrinker run asynchronously as a work queue job")
CC: stable@vger.kernel.org # 6.13+
Tested-by: Ivan Shapovalov <intelfx@intelfx.name>
Link: https://lore.kernel.org/linux-btrfs/0414d690ac5680d0d77dfc930606cdc36e42e12f.camel@intelfx.name/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 67ce85ff0ae2..bee1b94a1049 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1222,8 +1222,7 @@ static long btrfs_scan_root(struct btrfs_root *root, struct btrfs_em_shrink_ctx
 		fs_info->em_shrinker_last_ino = btrfs_ino(inode);
 		btrfs_add_delayed_iput(inode);
 
-		if (ctx->scanned >= ctx->nr_to_scan ||
-		    btrfs_fs_closing(inode->root->fs_info))
+		if (ctx->scanned >= ctx->nr_to_scan || btrfs_fs_closing(fs_info))
 			break;
 
 		cond_resched();
-- 
2.45.2


