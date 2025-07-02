Return-Path: <linux-btrfs+bounces-15203-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBF0AF5D6F
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 17:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B0F4809F9
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 15:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7392E7BCE;
	Wed,  2 Jul 2025 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u27jbZyb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29F02E7BC5
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Jul 2025 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470718; cv=none; b=fJXx83lJUowSO2NaHrnRTHT0Kmo1Yi5ENrs+uoFBDVc/WzDa9sMgug9GmUb7tQuPuYqYC9kJkTSQkIYucP9a2kVE5zvfgfB8651Jm+PFW2rhwSSshkYfRLGbT0Cecv7ZkxlE1M/qcZxnAvkHVL3YAtNv/MbYcnCPgEUZOnPNGvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470718; c=relaxed/simple;
	bh=v/PMY5xRPadkc+fUt6vc7ZG5P3Ukn+ThaZwgE+1hPd8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBQWMEEbV1VarZ1oiLyTGe9GntQUxvFVnX19tLLH0kxeRYg0Pea5fqE2Igf6hnr4aIsTq/EirJOBZu0p4VxS247ikVJqY6pYyDXD9RMGdZ+4mCLeBStenSyN4GEk9zJj/5xTtYAJNyw0KXgHLW6LmnsIuS1mEEb++LVx/FN952c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u27jbZyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D19EC4CEED
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Jul 2025 15:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751470717;
	bh=v/PMY5xRPadkc+fUt6vc7ZG5P3Ukn+ThaZwgE+1hPd8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=u27jbZyb3wE28JbqenSRvc+xe4fcyPM2UYZzN3QOvJcsnKGrrQBcOeNe2ozIvpvL/
	 GJA+6SziOWFYqtD0IdyqRLD804qIuPshc1bGVp/Fd9w1YgGoidl/mCO62K5pzy2A1f
	 +oxhhQJYf/DLx+MRH67Pj+ECRcBdg/20oYF8eEl6igdFePbaP0EsNvYlzSFzcZD880
	 +KGwTXMohU4dEuzOUo1CQHSGGk+vTWDQgDkdGWwcFfFn4D3bxCfNXOPv7ulXmxWEbu
	 uUIuDBc9d9O5jdKKk2xh30AlvB/ANS9LHKcXDeMGiGQeuLHYz7zWqUhEvfCw175Lw5
	 d/z+aOv0Lo56w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: avoid logging tree mod log elements for irrelevant extent buffers
Date: Wed,  2 Jul 2025 16:38:30 +0100
Message-ID: <ef9fd842939a1dd19ff4da7876fabf539e4e0ac1.1751460099.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1751460099.git.fdmanana@suse.com>
References: <cover.1751460099.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We are logging tree mod log operations for extent buffers from any tree
but we only need to log for the extent tree and subvolume tree, since
the tree mod log is used to get a consistent view, within a transaction,
of extents and their backrefs. So it's pointless to log operations for
trees such as the csum tree, free space tree, root tree, chunk tree,
log trees, data crelocation tree, etc, as these trees are not used for
backref walking and all tree mod log users are about backref walking.

So skip extent buffers that don't belong either to the extent or to
subvolume trees. This avoids unncessary memory allocations and having a
larger tree mod log rbtree with nodes that are never needed.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-mod-log.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index 1ac2678fc4ca..41dcd296b003 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -164,6 +164,30 @@ static noinline int tree_mod_log_insert(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+static inline bool skip_eb_logging(const struct extent_buffer *eb)
+{
+	const u64 owner = btrfs_header_owner(eb);
+
+	if (btrfs_header_level(eb) == 0)
+		return true;
+
+	/*
+	 * Tree mod logging exists so that there's a consistent view of the
+	 * extents and backrefs of inodes even if while a task is iterating over
+	 * them other tasks are modifying subvolume trees and the extent tree
+	 * (including running delayed refs). So we only need to log extent
+	 * buffers from the extent tree and subvolumes trees.
+	 */
+
+	if (owner == BTRFS_EXTENT_TREE_OBJECTID)
+		return false;
+
+	if (btrfs_is_fstree(owner))
+		return false;
+
+	return true;
+}
+
 /*
  * Determines if logging can be omitted. Returns true if it can. Otherwise, it
  * returns false with the tree_mod_log_lock acquired. The caller must hold
@@ -174,7 +198,7 @@ static bool tree_mod_dont_log(struct btrfs_fs_info *fs_info, const struct extent
 {
 	if (!test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags))
 		return true;
-	if (eb && btrfs_header_level(eb) == 0)
+	if (eb && skip_eb_logging(eb))
 		return true;
 
 	write_lock(&fs_info->tree_mod_log_lock);
@@ -192,7 +216,7 @@ static bool tree_mod_need_log(const struct btrfs_fs_info *fs_info,
 {
 	if (!test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags))
 		return false;
-	if (eb && btrfs_header_level(eb) == 0)
+	if (eb && skip_eb_logging(eb))
 		return false;
 
 	return true;
-- 
2.47.2


