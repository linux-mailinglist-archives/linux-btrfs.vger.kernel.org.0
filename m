Return-Path: <linux-btrfs+bounces-5439-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 374298FB0BF
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 13:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 413C5B2148D
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 11:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD687145A0C;
	Tue,  4 Jun 2024 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIvAU+gz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B151459FA
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499340; cv=none; b=FRyS1+qJyIrSJBqTxLYObvhZzk3+tI9fhOSnORDUx1AszTR2ZyqRIlRHthbjXfTXH2+PjPc5mX9jiSw5nIcTCMf3oRDcax6zK5JUwM78+6fIQ8u3ObRCHY7v6t0Huu7y+rGpLqE87MqM7vb7iAY3uyCfrn9lRPHHPCO4KtxqHW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499340; c=relaxed/simple;
	bh=cPTcmnI8U6SxzE92qGVVsAwENMn39oRjewrLheuXnRE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MrkQscYkG0/UE4aRw0/nVCrt/ERzGzc4DH9KEPYZ/aXMyba3i/P4JnUNbZZ5JcjArMt5WVeBae2zrVDiGIpLHBE/QP/OcrCDh+bgJk6vnEqiGqRcKS6iH6/wxr1S0oQjZaGlZQNwMjDMA1XqrLKvTp8PUBBs77GUO/+bcX7vFqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIvAU+gz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2129FC4AF07
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 11:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717499339;
	bh=cPTcmnI8U6SxzE92qGVVsAwENMn39oRjewrLheuXnRE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AIvAU+gzdOGrZg0cM+lYqhKrSa8iZ/da/4MOli8Pc8FATs0OhHwJMgFD0KSsUiNqA
	 Epv9foVWz8uP4gDMyKVtRfeImeTuUT1/Ete03gAMIwr3qFqjDXM30aPYP072bC6mS4
	 RELh0pyOAx2vbSw56KaGTwlED5zxS7i4K5GFvoZtzPi+gdGaOlgZ4BWkBnjunwQBGs
	 tkwLxVyUb7KGttgYowJTOI5zIuWAh9j2c3gDVg//qqyqtGZ1UWLL2ToNiXhfwxmltH
	 7RHen+jAGJk/zTPheODJp/JNQY3IHa2CDOODFk6emyTb6+0CV6psq2qE5Gt3fOt+OJ
	 E7OeNt0xPV7nw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/6] btrfs: avoid removal and re-insertion of split ordered extent
Date: Tue,  4 Jun 2024 12:08:50 +0100
Message-Id: <b8ceabd5826e0bf70cecf79284a47dd7101bc0a6.1717495660.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717495660.git.fdmanana@suse.com>
References: <cover.1717495660.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_split_ordered_extent(), we are removing and re-inserting the
ordered extent that we are trimming, but we don't need to since the
trimming doesn't change its position in the red black tree because we
don't have overlapping ordered extents (that would imply double allocation
of extents) and we know the split length is smaller than the ordered
extent's num_bytes field (we checked that early in the function).

So drop the remove and re-insert code for the slit ordered extent.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ordered-data.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 1f7f6720b2ea..1d7707948833 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1266,13 +1266,13 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 	 */
 	spin_lock_irq(&root->ordered_extent_lock);
 	spin_lock(&inode->ordered_tree_lock);
-	/* Remove from tree once */
-	node = &ordered->rb_node;
-	rb_erase(node, &inode->ordered_tree);
-	RB_CLEAR_NODE(node);
-	if (inode->ordered_tree_last == node)
-		inode->ordered_tree_last = NULL;
 
+	/*
+	 * We don't have overlapping ordered extents (that would imply double
+	 * allocation of extents) and we checked above that the split length
+	 * does not cross the ordered extent's num_bytes field, so there's
+	 * no need to remove it and re-insert it in the tree.
+	 */
 	ordered->file_offset += len;
 	ordered->disk_bytenr += len;
 	ordered->num_bytes -= len;
@@ -1302,14 +1302,6 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 		offset += sum->len;
 	}
 
-	/* Re-insert the node */
-	node = tree_insert(&inode->ordered_tree, ordered->file_offset,
-			   &ordered->rb_node);
-	if (node)
-		btrfs_panic(fs_info, -EEXIST,
-			"zoned: inconsistency in ordered tree at offset %llu",
-			ordered->file_offset);
-
 	node = tree_insert(&inode->ordered_tree, new->file_offset, &new->rb_node);
 	if (node)
 		btrfs_panic(fs_info, -EEXIST,
-- 
2.43.0


