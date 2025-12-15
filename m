Return-Path: <linux-btrfs+bounces-19754-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DEBCBF734
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 19:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2778B3010AA6
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 18:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B863112B3;
	Mon, 15 Dec 2025 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeQS7847"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7661A20DD48
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765823949; cv=none; b=CLaarr8kiIFM0UC9UpY7uD6jJ8yx0HRy0BC7C55GJQvXeKCdTTYop9Diih485oLIC9or4qf90MaZbZR2FnWnQB/WN64ziVoHt1iKwHhuZJklaublhoxSRHz4RZmsqzoHx7S5R0HBhfOLxsrYC2rm60oZJCvD4l7Vq2JrLrLPzjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765823949; c=relaxed/simple;
	bh=xirRZvdH4juQM4utEdr+BHJJw6NFjO4Tuvf8ohi7R2E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=M8NefmM1kKx6p05tKsrFpuo5IC8xbPamlHhWBq5e12A58qWG+sqq4kIVrzlkSRMFiLqqy6rwsbOtfTBzfRQu1FhW5LtLaNTybGM2LyCMqCN2S+UtOznzgwROK0cEiq7o01LS20YwgZZplPCvgycWnGXkFzVP8XkdQ4Fp+ucaNQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeQS7847; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747ABC4CEF5
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 18:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765823948;
	bh=xirRZvdH4juQM4utEdr+BHJJw6NFjO4Tuvf8ohi7R2E=;
	h=From:To:Subject:Date:From;
	b=qeQS7847ba0lUwI4BTEreaT5b/KJKb+LqxZfRxdTLmpm0bBPA8ClG6LvMHsY4cGQp
	 l6g10qRZePQPKfIvwaGdlxV0QklqoGCBEcTZUl/5SuGskCrL8NWdMpi5jeicwVRQ7c
	 aFRo75Ex3FHwsnK6bx3PdOm8H6TgBBB7T7IK2X8Z6GtCGUbN95uh7pJ6RqN8cqbnZD
	 gQpXi8MlMyL0DBd7VHJt9bLOUkqEOd3MVGShgHpA///8o1r86fAn5afItdW8xan3FQ
	 IKqxHrtPYRhEX5qualRgsovuAd1h890pHKhWbk0Myi8ylo/B+MWhx8GvvE7yqVqGBk
	 NkBO9hZJMjd8w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove duplicated root key setup in btrfs_create_tree()
Date: Mon, 15 Dec 2025 18:39:04 +0000
Message-ID: <f16be2a792f62fbb6db98a77e7c2b2946b0a6cc9.1765823910.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need for an on stack key to define the root's key as we have
already defined the key in the root itself. So remove the stack variable
and use the key in the root.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 49c4f111e674..e5535bdc5b0c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -824,7 +824,6 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	struct btrfs_root *tree_root = fs_info->tree_root;
 	struct btrfs_root *root;
-	struct btrfs_key key;
 	unsigned int nofs_flag;
 	int ret = 0;
 
@@ -873,10 +872,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 
 	btrfs_tree_unlock(leaf);
 
-	key.objectid = objectid;
-	key.type = BTRFS_ROOT_ITEM_KEY;
-	key.offset = 0;
-	ret = btrfs_insert_root(trans, tree_root, &key, &root->root_item);
+	ret = btrfs_insert_root(trans, tree_root, &root->root_key, &root->root_item);
 	if (ret)
 		goto fail;
 
-- 
2.47.2


