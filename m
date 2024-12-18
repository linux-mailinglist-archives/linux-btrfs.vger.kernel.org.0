Return-Path: <linux-btrfs+bounces-10558-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB159F6BE6
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9F8B7A4C08
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB53B1F8F0B;
	Wed, 18 Dec 2024 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o43hnF/E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F26A1F8918
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541614; cv=none; b=Pbqit6y091DPxKHR4Jx2BGheqLAgjJBqKks+AgUQrFIW7BD0mnmIDMEIkslK80IfDBa1WLxA01AYv3ISS52FVYZnmQCPc89d6KV0yyXv7zsqoAOT7ku5zHrzBeKicUZbJwkNSyhoMR6OP8oGEIIt9dw0isw5vpu1otkyZIULfDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541614; c=relaxed/simple;
	bh=BwUAXHhOA7D9Kal0sVDx/HFoLX29NSdBRrKZ0XfCpLY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cBb7UHKrIqufTT8AWBK0J9XCo00kTlbT2+ErC77nv8OyyB98otKoEXJjyMG52YR2WUEV7K2DPoXFncYQaKLQKpoCHbVLKBWLOKLl1gsZPFTIo1tYnXaIS6kJN+neFEK1ohdYnHJG6X9gO1rtNilHznQRGKXam37p7qSfe6kmHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o43hnF/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCC7C4CEDC
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734541613;
	bh=BwUAXHhOA7D9Kal0sVDx/HFoLX29NSdBRrKZ0XfCpLY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=o43hnF/EI+jzTJ+RS17HNtL2ROJzNka4Bb5AubqFZKnbrYEaRE5hxlWnDIO/EkTc4
	 rHTlsEgdjpzTECOI0gOaYLUAoBCcMgGdY39MDYlTLmsA1F8RQeEcg9mSARLNzCE/Vo
	 uvMV7gJTL4n3+J9qT6x20PCPJKQZ+rybmUZ2m9oxKs7IB4NtFp4s7j/7YDyd9dJZAb
	 Hbw+eLAQqb24aykrlIpB+Ii6DnnLQE4d8I8AhaLz0Yjc8evdsf9G0vx3DhFBBUYsje
	 q3Rrxh2dHgi3cjADYNCK8/Z4GxTFBmcpmpZa1DNhKXaJzcNyK4k//i/uqSmO82oMDJ
	 LhO9ZM8smyjWw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 02/20] btrfs: free-space-tree: remove unnecessary calls to btrfs_mark_buffer_dirty()
Date: Wed, 18 Dec 2024 17:06:29 +0000
Message-Id: <40d7047ff0a3a423e2b6cc371895a4b4ff9708d3.1734527445.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734527445.git.fdmanana@suse.com>
References: <cover.1734527445.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have several places explicitly calling btrfs_mark_buffer_dirty() but
that is not necessarily since the target leaf came from a path that was
obtained for a btree search function that modifies the btree, something
ike btrfs_insert_empty_item() or anything else that ends up calling
btrfs_search_slot() with a value of 1 for its 'cow' argument.

These just make the code more verbose, confusing and add a little extra
overhead and well as increase the module's text size, so remove them.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-tree.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 7ba50e133921..710205799409 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -89,7 +89,6 @@ static int add_new_free_space_info(struct btrfs_trans_handle *trans,
 			      struct btrfs_free_space_info);
 	btrfs_set_free_space_extent_count(leaf, info, 0);
 	btrfs_set_free_space_flags(leaf, info, 0);
-	btrfs_mark_buffer_dirty(trans, leaf);
 
 	ret = 0;
 out:
@@ -287,7 +286,6 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 	flags |= BTRFS_FREE_SPACE_USING_BITMAPS;
 	btrfs_set_free_space_flags(leaf, info, flags);
 	expected_extent_count = btrfs_free_space_extent_count(leaf, info);
-	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
 
 	if (extent_count != expected_extent_count) {
@@ -324,7 +322,6 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 		ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
 		write_extent_buffer(leaf, bitmap_cursor, ptr,
 				    data_size);
-		btrfs_mark_buffer_dirty(trans, leaf);
 		btrfs_release_path(path);
 
 		i += extent_size;
@@ -430,7 +427,6 @@ int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 	flags &= ~BTRFS_FREE_SPACE_USING_BITMAPS;
 	btrfs_set_free_space_flags(leaf, info, flags);
 	expected_extent_count = btrfs_free_space_extent_count(leaf, info);
-	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
 
 	nrbits = block_group->length >> block_group->fs_info->sectorsize_bits;
@@ -495,7 +491,6 @@ static int update_free_space_extent_count(struct btrfs_trans_handle *trans,
 
 	extent_count += new_extents;
 	btrfs_set_free_space_extent_count(path->nodes[0], info, extent_count);
-	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
 	btrfs_release_path(path);
 
 	if (!(flags & BTRFS_FREE_SPACE_USING_BITMAPS) &&
-- 
2.45.2


