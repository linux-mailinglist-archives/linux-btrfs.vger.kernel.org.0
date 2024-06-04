Return-Path: <linux-btrfs+bounces-5438-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EBF8FB0BE
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 13:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242B51C210FD
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 11:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64601459F8;
	Tue,  4 Jun 2024 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXZ6Ncrv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5501459E2
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499339; cv=none; b=G45Bu86p6gMNJ/FwhmNhNvhPhd1Ix850/0CZBjHwrAzIc/4bM9bOPztjXUPpQaImHCg0uO098sNZfSxnfOqmczJhrumzrQY4lBGVu0aicJlu2h/i58HTzKamf3n2zT8zpL2DlxcwjrN/PtWCOtx/46GZp+xNhOLtx7fH7+9YoxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499339; c=relaxed/simple;
	bh=Chjy3SkgdSQsHUK2iMkDTS2biXS0HdkaxBm+CGH7rE4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FWAf6lPLRnmDWMrWQQKl2/C2wFUHFS04v0gNXIIuuGFJz0ZZwEhve3mb11PKRxQ/GzVlWHYlECqPJMpaoKJsAGElvO3L53znM+poUs/Ky/PdgesTszNYU3nT5EOWB0nr9qd7yjZCHUYWRgjOju+JfptKZLxfUFwyXW6ik421GrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXZ6Ncrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22791C32782
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 11:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717499338;
	bh=Chjy3SkgdSQsHUK2iMkDTS2biXS0HdkaxBm+CGH7rE4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PXZ6Ncrvg4OA2GPHkWWMSAgKRhxaY8vBry5tXH9C2B2Ut0griQpUDBRcQDGUwc+/b
	 Zi7+Sp7WZqAWiZiqVLNzQ7gm5LLhPPuxYLaFDboxU+X2JbVriLViDQryBgvawOp25E
	 fi05HYQU9oHwpHfUhy7uLl4dok/OnCv2wEEEQOqe3rGjN9PK97zDedikYksykP83SR
	 zjXSbokMbrveBGEkYjR1Xc5dVYM/yiAxRZefYyNrCto2vw6VNy9fbhu91OZ+SO8Scw
	 /YGx84Tj3yOsnA6/AtE39mAkAnn7Ce7eFZEDzGG38XiqCY1bUgJ9PB9+9A5X4czNLg
	 Jpo3p3xi40I2w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs: add comment about locking to btrfs_split_ordered_extent()
Date: Tue,  4 Jun 2024 12:08:49 +0100
Message-Id: <cffe79bcb3e39dba73e6119945e1ca58a56c5cc0.1717495660.git.fdmanana@suse.com>
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

There are subtle details about why the root's ordered_extent_lock is held,
so add a comment mentioning them.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ordered-data.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 1cabcfa85e7c..1f7f6720b2ea 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1247,6 +1247,23 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 	/* One ref for the tree. */
 	refcount_inc(&new->refs);
 
+	/*
+	 * Take the root's ordered_extent_lock to avoid a race with
+	 * btrfs_wait_ordered_extents() when updating the disk_bytenr and
+	 * disk_num_bytes fields of the ordered extent below. And we disable
+	 * IRQs because the inode's ordered_tree_lock is used in IRQ context
+	 * elsewhere.
+	 *
+	 * There's no concern about a previous caller of
+	 * btrfs_wait_ordered_extents() getting the trimmed ordered extent
+	 * before we insert the new one, because even if it gets the ordered
+	 * extent before it's trimmed and the new one inserted, right before it
+	 * uses it or during its use, the ordered extent might have been
+	 * trimmed in the meanwhile, and it missed the new ordered extent.
+	 * There's no way around this and it's harmless for current use cases,
+	 * so we take the root's ordered_extent_lock to fix that race during
+	 * trimming and silence tools like KCSAN.
+	 */
 	spin_lock_irq(&root->ordered_extent_lock);
 	spin_lock(&inode->ordered_tree_lock);
 	/* Remove from tree once */
-- 
2.43.0


