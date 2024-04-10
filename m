Return-Path: <linux-btrfs+bounces-4105-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1802E89F0E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 13:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48CFA1C20DD1
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 11:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0BB15ECD5;
	Wed, 10 Apr 2024 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4CDnulA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8D415ECCB
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748535; cv=none; b=fNz+tB0sSqdfZCWE+icmSkUJFIo8yCcQQwcN749PQ+TN13EidrK8R5UqpBR9GlzyT1jbjrY0L5JWWUtIy1q3ZFisCf7wyRYQuRr3e6MCgl2mGCUJR3XPxXH5WZ277aJIug3BXUe8zf4J02kl3AFqzJa75uTpz0+8vHe37xA65aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748535; c=relaxed/simple;
	bh=0t3zjz760py2aauv7Z725DD4gYKRxEhOiE2A6E/q/2s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cI8KAdsecv1/LvUZsxRrXmAUxfoImIDe6/EU3HS0ocRfsFEV+9mvfqhy0HBPLkZxDNxWQV3CZZm+AlMkaam8PM/NHK9e3lx5aQb/u4k/IzlzHy0nA0kDFLqm1hRh57ckPcJdbmqUuma5Y3ukjT03yH44CkilSglGSGjyUoghVVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4CDnulA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D7CC433C7
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 11:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712748534;
	bh=0t3zjz760py2aauv7Z725DD4gYKRxEhOiE2A6E/q/2s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=m4CDnulABPOpDsqe0czpDukAmvgfv7M9Gdo9X/qIEMk7sEvMjqPxOJKHfxDzMr2tb
	 05b1XTl2XNkd/ER1dBPfCeeKZDlIFu4GnIVhDVLxIgKyM4+0vg1i+CusFZH3DFIEMQ
	 re1J3RmvkdZiAUWbrVXKwJM4tbbBvp9xMBlOHyOOxdMnCHfb33LxHYOOjFx+38t8Px
	 /nB5gtrN9KU9Q+XHovd9p48vG8E5V12deQJLXJ5uSY3iIap04CgMSiiPZM8cHpwJ5g
	 L8lJSelVpIZAXDHlackpybvD3VgPz3B9e+4lBc+MAYkXnYseL2G6D2hDFXfwHhiqCk
	 vkqEkTE7bQ8OA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 07/11] btrfs: pass the extent map tree's inode to replace_extent_mapping()
Date: Wed, 10 Apr 2024 12:28:39 +0100
Message-Id: <d039a978998dc14ad9df5846c3c18b40682cf72a.1712748143.git.fdmanana@suse.com>
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

Extent maps are always associated to an inode's extent map tree, so
there's no need to pass the extent map tree explicitly to
replace_extent_mapping().

In order to facilitate an upcoming change that adds a shrinker for extent
maps, change replace_extent_mapping() to receive the inode instead of its
extent map tree.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 289669763965..15817b842c24 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -470,11 +470,13 @@ void remove_extent_mapping(struct btrfs_inode *inode, struct extent_map *em)
 	RB_CLEAR_NODE(&em->rb_node);
 }
 
-static void replace_extent_mapping(struct extent_map_tree *tree,
+static void replace_extent_mapping(struct btrfs_inode *inode,
 				   struct extent_map *cur,
 				   struct extent_map *new,
 				   int modified)
 {
+	struct extent_map_tree *tree = &inode->extent_tree;
+
 	lockdep_assert_held_write(&tree->lock);
 
 	WARN_ON(cur->flags & EXTENT_FLAG_PINNED);
@@ -777,7 +779,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 
 			split->generation = gen;
 			split->flags = flags;
-			replace_extent_mapping(em_tree, em, split, modified);
+			replace_extent_mapping(inode, em, split, modified);
 			free_extent_map(split);
 			split = split2;
 			split2 = NULL;
@@ -818,8 +820,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			}
 
 			if (extent_map_in_tree(em)) {
-				replace_extent_mapping(em_tree, em, split,
-						       modified);
+				replace_extent_mapping(inode, em, split, modified);
 			} else {
 				int ret;
 
@@ -977,7 +978,7 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_pre->flags = flags;
 	split_pre->generation = em->generation;
 
-	replace_extent_mapping(em_tree, em, split_pre, 1);
+	replace_extent_mapping(inode, em, split_pre, 1);
 
 	/*
 	 * Now we only have an extent_map at:
-- 
2.43.0


