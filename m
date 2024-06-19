Return-Path: <linux-btrfs+bounces-5815-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF3C90E8F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 13:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 954A3B213BB
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 11:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2DF139563;
	Wed, 19 Jun 2024 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQupMaHY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA3A136E2C
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795209; cv=none; b=brr12QHwGP0lZAl/7i1xSInpMGEo4rFNDacxJL9zrxmk9yRWGVLp/wIPFDoYqaoVcicyohRuwRZiYNoU8mGCTyPv2ozrw+oayvNqaBq/9bMfOPb/uuO1kyRtYC138VmqBFH7g7L6D6QNNm8RyOO5PRyNobK8OeGk9Ymx4NXB8mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795209; c=relaxed/simple;
	bh=xKlfs9QamTKzn2pmngIB+tTSvA0otkice90N/pdYA6I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LkLSr2pFZSaBSR0lzySBi/0pzvH70XzB5zcx5GVdf487Mur8VZV67Pnmg+E4D1TUaZ7vdKkQKZlPrDllU7i6l6kGjqdL556iQ6bfe81ximPoSyPPpa2hbu+PdsW5yYZwILKufCA++CmMrxNq8NoxBO52sl9DLbANQySBNx90oic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQupMaHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4B2C2BBFC
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 11:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718795209;
	bh=xKlfs9QamTKzn2pmngIB+tTSvA0otkice90N/pdYA6I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VQupMaHY4uRRGecjDK6QC+54DPF0/DWLufchXNJOiUyGUsp/HhV965pO4rq6itiyV
	 qd5y6gmfsRKn8sMtIA3tHdjQkXx8ojBi/uJBK1VmC9fUw9fBn4Oh63KCRzs3NXyhya
	 ba3Ayktn18XN0gFWD4qDYa1WJ7A7YbQZp4VfjmmYgvrmpP9h0EayNThCne2+xqiJM2
	 wYeQin9pXAU6VSSbR/xLrn7uwMEW/OmuPCXY2GXAspwIHxQkGeJ6RO0zfwiyZpFxF+
	 IAjwHN3weFcvXX+mCbIi2hfDQ9zCoTUDHeEISzghEIT8a2+btfJacY9dqfOX6RFMua
	 6/2yC3OFmFoKg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: reduce nesting for extent processing at btrfs_lookup_extent_info()
Date: Wed, 19 Jun 2024 12:06:43 +0100
Message-Id: <5be9e81e355e5e763a401ef38add72841bfdacd4.1718794792.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718794792.git.fdmanana@suse.com>
References: <cover.1718794792.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of using an if-else statement when processing the extent item at
btrfs_lookup_extent_info(), use a single if statement for the error case
since it does a goto at the end and leave the success (expected) case
following the if statement, reducing indentation and making the logic a
bit easier to follow. Also make the if statement's condition as unlikely
since it's not expected to ever happen, as it signals some corruption,
making it clear and hint the compiler to generate more efficient code.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a14d2a74d7fd..94dffe6b6252 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -104,10 +104,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 	struct btrfs_delayed_ref_head *head;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_path *path;
-	struct btrfs_extent_item *ei;
-	struct extent_buffer *leaf;
 	struct btrfs_key key;
-	u32 item_size;
 	u64 num_refs;
 	u64 extent_flags;
 	u64 owner = 0;
@@ -152,16 +149,11 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 	}
 
 	if (ret == 0) {
-		leaf = path->nodes[0];
-		item_size = btrfs_item_size(leaf, path->slots[0]);
-		if (item_size >= sizeof(*ei)) {
-			ei = btrfs_item_ptr(leaf, path->slots[0],
-					    struct btrfs_extent_item);
-			num_refs = btrfs_extent_refs(leaf, ei);
-			extent_flags = btrfs_extent_flags(leaf, ei);
-			owner = btrfs_get_extent_owner_root(fs_info, leaf,
-							    path->slots[0]);
-		} else {
+		struct extent_buffer *leaf = path->nodes[0];
+		struct btrfs_extent_item *ei;
+		const u32 item_size = btrfs_item_size(leaf, path->slots[0]);
+
+		if (unlikely(item_size < sizeof(*ei))) {
 			ret = -EUCLEAN;
 			btrfs_err(fs_info,
 			"unexpected extent item size, has %u expect >= %zu",
@@ -170,6 +162,10 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			goto out_free;
 		}
 
+		ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
+		num_refs = btrfs_extent_refs(leaf, ei);
+		extent_flags = btrfs_extent_flags(leaf, ei);
+		owner = btrfs_get_extent_owner_root(fs_info, leaf, path->slots[0]);
 		BUG_ON(num_refs == 0);
 	} else {
 		num_refs = 0;
-- 
2.43.0


