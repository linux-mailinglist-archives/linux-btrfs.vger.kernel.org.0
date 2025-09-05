Return-Path: <linux-btrfs+bounces-16665-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DEDB45D9A
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5621621FB
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D4231326E;
	Fri,  5 Sep 2025 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0tP0hfQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F714313269
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088658; cv=none; b=spdReLBWxcq7KkknUyJKeV+61jcRxHTpSCcbI812SwNTxYyKvyN+oTUHvRw68YXviGt9y/dPFjZlY0sttcGonDnC5mqP07fth1CvY77H1fB70XcAZM28UXcKmrRAWJ8xJMmnRE5WhuctdISHBYp9gF9lPRW2XquTvuIhtfnsnhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088658; c=relaxed/simple;
	bh=Yf+7tdg6PyAzvJpid1TYysrW3etLRx+/F93GpVxtlpk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joqs7LC22TzBZzq3evbjyhiMGO7bi3fJKqFHunQsvhIR/kiCmP1+jWr7aXrTZ5TRqUtwF/QYCrBGQ9oDVn8Zk7Nm2fu0hctTtCimkE751B/vaS5fNyfCg9UfHgA72rHD1YmM9TA5Eys6fXDZ4l5QQDWBK+ibDFEIVEJ7i69qAMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0tP0hfQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C899C4CEF7
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088657;
	bh=Yf+7tdg6PyAzvJpid1TYysrW3etLRx+/F93GpVxtlpk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=T0tP0hfQ8TH4rbXnzCJGvcbPCbzma3969Pxpzdtzd4KmGGfERVQUt+gYzpodHpsil
	 1Lu8VK3gEjNLePeg5stmxL7VdYXebqP8JrYBvO6nQn2Ri2Aje+5I50g8LNqsQrkXHZ
	 wYVSGQsQQWGHYUBA9kbmAkow83EgNj8Rb6owtnNdJ0d196R9BxagypJ9tjXrTi5oCd
	 kFta7AUuoZcZYegG+D/YIVEOGRZhVwOuxPuSIIgQaOMRilz+bFcm0FzJEa2nJiVrsv
	 /pTjYaj8u2p4W9jy9E7Uz6G7fAkaJxct+kqq1j8+QGgThE30A0nDjDBBb16cW/nCwG
	 t7COXxr2OSSRw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 21/33] btrfs: use the inode item boolean everywhere in overwrite_item()
Date: Fri,  5 Sep 2025 17:10:09 +0100
Message-ID: <c810baf7f315a032115c62e2435e9891b338ab6a.1757075118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757075118.git.fdmanana@suse.com>
References: <cover.1757075118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have this boolean 'inode_item' to tell if we are processing an inode
item key and we use it in a couple of places while in another two places
we open code by checking if the key type matches the inode item type.
Make this consistent and use the boolean everywhere. Also rename it from
'inode_item' to 'is_inode_item', which makes it more clear that it's a
boolean and not an instance of struct btrfs_inode_item, and make it const
too.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 88e813bb28d8..d830c33be7c6 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -424,7 +424,7 @@ static int overwrite_item(struct walk_control *wc,
 	unsigned long dst_ptr;
 	struct extent_buffer *dst_eb;
 	int dst_slot;
-	bool inode_item = key->type == BTRFS_INODE_ITEM_KEY;
+	const bool is_inode_item = (key->type == BTRFS_INODE_ITEM_KEY);
 
 	/*
 	 * This is only used during log replay, so the root is always from a
@@ -486,7 +486,7 @@ static int overwrite_item(struct walk_control *wc,
 		 * We need to load the old nbytes into the inode so when we
 		 * replay the extents we've logged we get the right nbytes.
 		 */
-		if (inode_item) {
+		if (is_inode_item) {
 			struct btrfs_inode_item *item;
 			u64 nbytes;
 			u32 mode;
@@ -507,7 +507,7 @@ static int overwrite_item(struct walk_control *wc,
 			if (S_ISDIR(mode))
 				btrfs_set_inode_size(eb, item, 0);
 		}
-	} else if (inode_item) {
+	} else if (is_inode_item) {
 		struct btrfs_inode_item *item;
 		u32 mode;
 
@@ -561,7 +561,7 @@ static int overwrite_item(struct walk_control *wc,
 	 * state of the tree found in the subvolume, and i_size is modified
 	 * as it goes
 	 */
-	if (key->type == BTRFS_INODE_ITEM_KEY && ret == -EEXIST) {
+	if (is_inode_item && ret == -EEXIST) {
 		struct btrfs_inode_item *src_item;
 		struct btrfs_inode_item *dst_item;
 
@@ -602,7 +602,7 @@ static int overwrite_item(struct walk_control *wc,
 	}
 
 	/* make sure the generation is filled in */
-	if (key->type == BTRFS_INODE_ITEM_KEY) {
+	if (is_inode_item) {
 		struct btrfs_inode_item *dst_item;
 
 		dst_item = (struct btrfs_inode_item *)dst_ptr;
-- 
2.47.2


