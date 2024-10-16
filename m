Return-Path: <linux-btrfs+bounces-8960-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE869A0C76
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 16:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CA31C21F58
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 14:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B3C20ADE7;
	Wed, 16 Oct 2024 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKgIhtsD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C3D20966A
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088429; cv=none; b=e05+Bft94ki3BuJl3F08hIbXuwozGrgsci6wY1R5qNLTEdR1/mCiG7sSjE4AqmWJTLGeMTv3i+D+1wAvYVU9j0zl2YHTk6bNVmshCG4VzZzIQpdpx6DYaL6KJWAuvxYh8X51aMO/Mr84OMmLxF6UHXf1WpTlfNEJKy2Zd+Rnz60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088429; c=relaxed/simple;
	bh=b/x7Q8KRxQMVrbhCD078lZnJzk6LpXtuMI0WtccXevI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MaxYUYHZhxtbjj68Qdqoi9qhHPX8wqDnbOFgDO3Z6bfW4v+sNsUuxFbOXI6sQGp4vqEWQeXWT0w6PAw36NpPWaz5eX1PO1KAtgps7jfvQHsohOzuqpU7m9HXhk233tuJT1ymfmYNREmDwn9GRA5iFROlybFLu7Rx078yiIZ2Zzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKgIhtsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983BBC4CEC7
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 14:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729088429;
	bh=b/x7Q8KRxQMVrbhCD078lZnJzk6LpXtuMI0WtccXevI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VKgIhtsDvIQ6s6/P2bvK3KdxQkc4DbFogleKgYI5advLg/7qPzdFUg6KFqJZPuvci
	 L3Ik9I5m+NSQb2iNryNBMPHDFLr3tdahR9VudTUjUWOGpOBTrPiEBdSPRfoXttSdSA
	 CMus6kZ2gQnYIDSseCcYIUtaONiJPxQIIlcuYyWW2Y0V4X9/Lqo8QCSM7bpn1XwFhb
	 +3nKXns7Ig/C0fwjN23df/KmLTD4eWqLEwyOvrtTlFuwR9DQaZrwjRKgqIQh1wYJRd
	 qp6EnFzp7Cj5huCC+ZhHmMYhPPOI8CCjzbZknyCiYiqMLm/5nNHcrMkGRoWc7JH52u
	 34cJlEvC9wzWg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: simplify arguments for btrfs_verify_level_key()
Date: Wed, 16 Oct 2024 15:20:21 +0100
Message-Id: <8127692fa51b37be7d2e1e770a56f6ab53f75002.1729075703.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729075703.git.fdmanana@suse.com>
References: <cover.1729075703.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The only caller of btrfs_verify_level_key() is read_block_for_search() and
it's passing 3 arguments to it that can be extracted from its on stack
variable of type struct btrfs_tree_parent_check.

So change btrfs_verify_level_key() to accept an argument of type
struct btrfs_tree_parent_check instead of level, first key and parent
transid arguments.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c        |  3 +--
 fs/btrfs/tree-checker.c | 16 ++++++++--------
 fs/btrfs/tree-checker.h |  4 ++--
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 428c5650559a..f68a9b586079 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1551,8 +1551,7 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 			 * being cached, read from scrub, or have multiple
 			 * parents (shared tree blocks).
 			 */
-			if (btrfs_verify_level_key(tmp,
-					parent_level - 1, &check.first_key, gen)) {
+			if (btrfs_verify_level_key(tmp, &check)) {
 				ret = -EUCLEAN;
 				goto out;
 			}
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 7b50263723bc..148d8cefa40e 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -2183,8 +2183,8 @@ int btrfs_check_eb_owner(const struct extent_buffer *eb, u64 root_owner)
 	return 0;
 }
 
-int btrfs_verify_level_key(struct extent_buffer *eb, int level,
-			   struct btrfs_key *first_key, u64 parent_transid)
+int btrfs_verify_level_key(struct extent_buffer *eb,
+			   const struct btrfs_tree_parent_check *check)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	int found_level;
@@ -2192,16 +2192,16 @@ int btrfs_verify_level_key(struct extent_buffer *eb, int level,
 	int ret;
 
 	found_level = btrfs_header_level(eb);
-	if (found_level != level) {
+	if (found_level != check->level) {
 		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
 		     KERN_ERR "BTRFS: tree level check failed\n");
 		btrfs_err(fs_info,
 "tree level mismatch detected, bytenr=%llu level expected=%u has=%u",
-			  eb->start, level, found_level);
+			  eb->start, check->level, found_level);
 		return -EIO;
 	}
 
-	if (!first_key)
+	if (!check->has_first_key)
 		return 0;
 
 	/*
@@ -2226,15 +2226,15 @@ int btrfs_verify_level_key(struct extent_buffer *eb, int level,
 		btrfs_node_key_to_cpu(eb, &found_key, 0);
 	else
 		btrfs_item_key_to_cpu(eb, &found_key, 0);
-	ret = btrfs_comp_cpu_keys(first_key, &found_key);
+	ret = btrfs_comp_cpu_keys(&check->first_key, &found_key);
 
 	if (ret) {
 		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
 		     KERN_ERR "BTRFS: tree first key check failed\n");
 		btrfs_err(fs_info,
 "tree first key mismatch detected, bytenr=%llu parent_transid=%llu key expected=(%llu,%u,%llu) has=(%llu,%u,%llu)",
-			  eb->start, parent_transid, first_key->objectid,
-			  first_key->type, first_key->offset,
+			  eb->start, check->transid, check->first_key.objectid,
+			  check->first_key.type, check->first_key.offset,
 			  found_key.objectid, found_key.type,
 			  found_key.offset);
 	}
diff --git a/fs/btrfs/tree-checker.h b/fs/btrfs/tree-checker.h
index 01669cfa6578..db67f96cbe4b 100644
--- a/fs/btrfs/tree-checker.h
+++ b/fs/btrfs/tree-checker.h
@@ -69,7 +69,7 @@ int btrfs_check_node(struct extent_buffer *node);
 int btrfs_check_chunk_valid(struct extent_buffer *leaf,
 			    struct btrfs_chunk *chunk, u64 logical);
 int btrfs_check_eb_owner(const struct extent_buffer *eb, u64 root_owner);
-int btrfs_verify_level_key(struct extent_buffer *eb, int level,
-			   struct btrfs_key *first_key, u64 parent_transid);
+int btrfs_verify_level_key(struct extent_buffer *eb,
+			   const struct btrfs_tree_parent_check *check);
 
 #endif
-- 
2.43.0


