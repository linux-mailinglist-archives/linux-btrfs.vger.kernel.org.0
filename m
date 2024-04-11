Return-Path: <linux-btrfs+bounces-4150-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC298A1C5E
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 19:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2C11C23111
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 17:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B403181BA1;
	Thu, 11 Apr 2024 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8vO8gKG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B161802BC
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852364; cv=none; b=jd5+OzAgHJPmFWE2AXTmhAwpk8hFVEGR1PcJys9+DYh3J2wT2tnAh8ofO4NNI/3Rb5fJqf5mb2zOoPhCKGqx4WLs++RLX1alDzfnQU57sUytE03HULH3p0vjkBNtzngbvvdeFAvcOFSlRkS0AZOZ4+CtbkFg5NBaJnGHSLk7lE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852364; c=relaxed/simple;
	bh=d5RtO4GKFnslwjophoD9TBH6WRnICgUt5M4cljtjlC0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LXtIxTWGqeUvEYPZHZBMHCFl1TNPH3WF0f8bcIq1eAHyFp2Czcc0Wjm2vuCVYnn16xgdezCgbPoD2wqmYoGxottMGrq1jsN9afgzccf0uydd2sxAjjkK+3NX0pNwakAISHxKHRZ4lvlIDSQRfqc5LtItZGgmB2YiCjcCrb9GeuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8vO8gKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924E7C113CD
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712852363;
	bh=d5RtO4GKFnslwjophoD9TBH6WRnICgUt5M4cljtjlC0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=H8vO8gKGAso6wMdp9Dv4ZIrb9VsgYOwG5oEph7aR1hjzxGmEwVzis0zrqk7BCHpO1
	 X5T+LDWK9V8eE6v7p/vMxjPa24DHLhS6wMvVgCXBEEjyL+wy9o/SbcLA0AYCHDKQ2S
	 8tqSgknpc9RN7SX+9rZsZ+wxcflmBGqxeCTddqUCaKFbBe2Yd3RYMOKPDLltx7wgxn
	 YkCfSZKN/6Yc2BW0Z2QoS4brB9kawJztnev/g0L7bT/5KQHrXT20By+UpN1H2r4GlC
	 EUJj1CFbxnfQksPBvefOBWpYgyJGTDJpJFM7+raQMEYU/QrY/fj/qVuZMm+jlQ09l6
	 AeN1MmptLZhaw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 07/15] btrfs: pass the extent map tree's inode to replace_extent_mapping()
Date: Thu, 11 Apr 2024 17:19:01 +0100
Message-Id: <6ad630fcc72febd6057d098268427e3c610af5ba.1712837044.git.fdmanana@suse.com>
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

Extent maps are always associated to an inode's extent map tree, so
there's no need to pass the extent map tree explicitly to
replace_extent_mapping().

In order to facilitate an upcoming change that adds a shrinker for extent
maps, change replace_extent_mapping() to receive the inode instead of its
extent map tree.

Reviewed-by: Qu Wenruo <wqu@suse.com>
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


