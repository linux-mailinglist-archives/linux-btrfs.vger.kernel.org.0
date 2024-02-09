Return-Path: <linux-btrfs+bounces-2282-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 783FA84FB65
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 19:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190A71F22FEC
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 18:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAB482862;
	Fri,  9 Feb 2024 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJ5OVB/E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8653780C18
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501656; cv=none; b=HyImtMrzz/RpdyBQ9TGTQuJ+Lqhy1qW2EBqN/gNnpny8856Ffr+LwE5ZPo5TTK4GlgXyfMTFzOFm+Lr2/dQj6BVOHGBSBz3+SkUkww0wCbAJ8v+qX6A5rzdxPhIQE3vCLwfB9qp4dxeSv5ZxfGUNpRj4SKYx7l29itD3VgZabjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501656; c=relaxed/simple;
	bh=Ofp21nVBhJDES24+EW8lDlEy07Ep3WZ260dklk9rgMQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d8rDBChpcQKJn7q1e6PjoEAO50B/omMVQQ6LluAXVj3Sz9OKjPj9F5DsIDrD68YaYhxk4yzjcaeMPS5r8/9sg/phe8LRq4gcshglOUx11dESa0+dz/Jx7feZB6CCVV7YxgjjylDszrhRGmkWjoLvqtnltMeyMJtmgK6gne1dmv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJ5OVB/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E827C43394
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707501656;
	bh=Ofp21nVBhJDES24+EW8lDlEy07Ep3WZ260dklk9rgMQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GJ5OVB/EaQ28cAwFSwDW7XK/WQ32OvGmjRKKYeudpUq2hXYRRAFF1y0ppdUzDQu7H
	 JU5muprvZheKqqztxedGYgGU3+hMxdq63uXYTrjiaNwHqqo4VH73LV3QFz6KYLSiVX
	 kvp8pKHnn0iVldZ2zVtAkYXZBcTnsDIXSfFMxYROM2wmkCsTLbCOjNmzf3Ul02fhsT
	 6NpwTIH1vgxaoDatEQJFhrehMm7xngnHvD9fFkCXCAWdg4Q0BlzUMYc8NRr1rQcmZf
	 03kbw2Dp5j8wGbKHntjUBXxuai9WW4oeJ82lxeEwiVEPtym/DpqCiRSbz8VQIipgYc
	 4XHmqTTP/JZBA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/9] btrfs: stop passing root argument to btrfs_add_delalloc_inodes()
Date: Fri,  9 Feb 2024 18:00:43 +0000
Message-Id: <5cfceac9f43f2e296437b01f940dd668208c4b98.1707491248.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707491248.git.fdmanana@suse.com>
References: <cover.1707491248.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to pass a root argument to btrfs_add_delalloc_inodes(), we
can just pass the inode since the root is always the root associated to
the inode in the context it's called. So remove it and have the single
caller pass only the inode.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2d16bb08e905..e3d12d8cf088 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2385,10 +2385,10 @@ void btrfs_merge_delalloc_extent(struct btrfs_inode *inode, struct extent_state
 	spin_unlock(&inode->lock);
 }
 
-static void btrfs_add_delalloc_inodes(struct btrfs_root *root,
-				      struct btrfs_inode *inode)
+static void btrfs_add_delalloc_inodes(struct btrfs_inode *inode)
 {
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 
 	spin_lock(&root->delalloc_lock);
 	if (list_empty(&inode->delalloc_inodes)) {
@@ -2451,7 +2451,6 @@ void btrfs_set_delalloc_extent(struct btrfs_inode *inode, struct extent_state *s
 	 * bit, which is only set or cleared with irqs on
 	 */
 	if (!(state->state & EXTENT_DELALLOC) && (bits & EXTENT_DELALLOC)) {
-		struct btrfs_root *root = inode->root;
 		u64 len = state->end + 1 - state->start;
 		u32 num_extents = count_max_extents(fs_info, len);
 		bool do_list = !btrfs_is_free_space_inode(inode);
@@ -2472,7 +2471,7 @@ void btrfs_set_delalloc_extent(struct btrfs_inode *inode, struct extent_state *s
 			inode->defrag_bytes += len;
 		if (do_list && !test_bit(BTRFS_INODE_IN_DELALLOC_LIST,
 					 &inode->runtime_flags))
-			btrfs_add_delalloc_inodes(root, inode);
+			btrfs_add_delalloc_inodes(inode);
 		spin_unlock(&inode->lock);
 	}
 
-- 
2.40.1


