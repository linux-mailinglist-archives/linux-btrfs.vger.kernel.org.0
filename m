Return-Path: <linux-btrfs+bounces-4302-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 870CF8A6BDA
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 15:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8D5284E46
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 13:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE4C12C482;
	Tue, 16 Apr 2024 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDoiplLZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F7012BF2B
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272897; cv=none; b=IiqaxgmkIcDpvoMCbAphFBH3WpQ08f+OiZmBVoBLvZRw5ewEDT+sCG/sjOdqP3l1l8qgMG5dmZUmpP3ZWJpWptOOWuAjIOcli/YCkNobZJpllB2B4pfQlU/hPxj9/ifPFkfwGlJOMR8Io2qzGZtkfs+xQR4uPBdSmY3NJvrdGqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272897; c=relaxed/simple;
	bh=Znm6NR+viNsZTmYHkFKTvw+dF9PnpQb/xzVRjKDeds4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eqT3nc4TWNbzfRfKeAyQXOzGz0fNTIpx60TdGYUgXqXf9CeQQy+JsX0TmZS2KEismDnf0Yx15hf9C3eyhetry0zVAFnzifchkTwkDhwOpDV7kxcyReuflAK1EJrOEXoJ6jrXurRnb+VjLGo4jgVOi2YCgLJ2R8OlTgLhL0lSAqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDoiplLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD375C2BD11
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 13:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713272897;
	bh=Znm6NR+viNsZTmYHkFKTvw+dF9PnpQb/xzVRjKDeds4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YDoiplLZohN08GF0g+6lvAlKs5TKfLD2Q64zEHTgt+eWe0Bb7EhadlyN/HVrV852c
	 tpRI84nkp+hJYiLoRVPs6fkLosmcSTxp+MQWt+n4+zPs4GkUuHE2AcEOcTjg32Ft6c
	 0wNKiNoyKU53PiDGIoi/vhgG08clfLS8gdOtwHVpmvz3mUhqKCzY5eAa2Vk4HdrMGN
	 fx4DdYCF5iXkxXSLuJcM4ySjOlhKMOaQ4a3X4poUKt09C4FYeH8ziuL4juZuymjMo3
	 681M8ULVtkmB8ApQ7dAzWtwtc4pbuUaFptfQxCImeOk13G2tNPLyotdvAKiqbsANyI
	 8HmL+iHAJXV4Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 02/10] btrfs: pass the extent map tree's inode to clear_em_logging()
Date: Tue, 16 Apr 2024 14:08:04 +0100
Message-Id: <e65a4683c02ac3e4eb41612d3d76f665a9a72d98.1713267925.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713267925.git.fdmanana@suse.com>
References: <cover.1713267925.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Extent maps are always associated to an inode's extent map tree, so
there's no need to pass the extent map tree explicitly to
clear_em_logging().

In order to facilitate an upcoming change that adds a shrinker for extent
maps, change clear_em_logging() to receive the inode instead of its extent
map tree.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 4 +++-
 fs/btrfs/extent_map.h | 2 +-
 fs/btrfs/tree-log.c   | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index d0e0c4e5415e..7cda78d11d75 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -331,8 +331,10 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
 
 }
 
-void clear_em_logging(struct extent_map_tree *tree, struct extent_map *em)
+void clear_em_logging(struct btrfs_inode *inode, struct extent_map *em)
 {
+	struct extent_map_tree *tree = &inode->extent_tree;
+
 	lockdep_assert_held_write(&tree->lock);
 
 	em->flags &= ~EXTENT_FLAG_LOGGING;
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index f287ab46e368..732fc8d7e534 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -129,7 +129,7 @@ void free_extent_map(struct extent_map *em);
 int __init extent_map_init(void);
 void __cold extent_map_exit(void);
 int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen);
-void clear_em_logging(struct extent_map_tree *tree, struct extent_map *em);
+void clear_em_logging(struct btrfs_inode *inode, struct extent_map *em);
 struct extent_map *search_extent_mapping(struct extent_map_tree *tree,
 					 u64 start, u64 len);
 int btrfs_add_extent_mapping(struct btrfs_inode *inode,
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 1c7efb7c2160..765fbbe3ee30 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4949,7 +4949,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 		 * private list.
 		 */
 		if (ret) {
-			clear_em_logging(tree, em);
+			clear_em_logging(inode, em);
 			free_extent_map(em);
 			continue;
 		}
@@ -4958,7 +4958,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 
 		ret = log_one_extent(trans, inode, em, path, ctx);
 		write_lock(&tree->lock);
-		clear_em_logging(tree, em);
+		clear_em_logging(inode, em);
 		free_extent_map(em);
 	}
 	WARN_ON(!list_empty(&extents));
-- 
2.43.0


