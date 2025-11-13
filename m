Return-Path: <linux-btrfs+bounces-18955-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F533C594A3
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 18:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19E78505868
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 17:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629A335F8AE;
	Thu, 13 Nov 2025 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JO6n5SSI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C6A35F8DD
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053008; cv=none; b=sFA/Ow8WazXVGVMHc4Y6bSfPwstT56wF6U2z0ERYivk4ekW803VZ6bmAEvyX44SOKKot1L6yUFxkhvDFfitOuqJl0hxeQyaVMa7GW5HMTtxU4fj6ejapdpEs9Fw423Mq1VvxxjLKjsDE4gp0OBbPQ5TFnsAiNUdxV4HuwRBwFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053008; c=relaxed/simple;
	bh=fXaMxW7oDCN2jjmLa5C+BAk/QInsRZNnZL8Wqa4L25M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hE9GNK5Yw/ekCibnFXWwYSDOzmWx2L8m9IVXra5mgDkgKS2xsdpzQF698zGAwVH2fiGU+NSyxIVFThmhmRRTNdXzGr3NR1y0lupnp0R/rAi97OwvnDQdPGexU2/bLdM4G3cZ0pJc0t3h23gV9TDl+EMZgjvT2xPCVigX/eUpcoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JO6n5SSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38C2C19424
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 16:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763053008;
	bh=fXaMxW7oDCN2jjmLa5C+BAk/QInsRZNnZL8Wqa4L25M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JO6n5SSIloNwQ8A4V4XDNdtR7v/78PvoZ5YCAuUtpfn/Ry2mQHc3oamrSEf43dMrZ
	 sWXXnee7HktFfkYs0CjG3gDshsabXIwCchOnmaNEqPEOKGVYhJGHPTJH/QaqjADvYm
	 221lDa3YRZ121q0YUoglopLAwmk0AmqDvObIZ0kXniABf/C4lhz+MzBmM51bLyxquf
	 WQBb1JuVVmFSU4z5UT5DPwcc5t3StKSKHbm/V3CaAFMuEXquLEy/TIAug8d6uj7jdQ
	 /QtFc8fMbn45UvzcfQ3vDAUSr0IoJacCdrqgZ7gSFn6jFIcU/Tjv8hGW88aS6numhu
	 u1tMMp/BJKbXw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs: remove duplicated leaf dirty status clearing in __push_leaf_right()
Date: Thu, 13 Nov 2025 16:56:36 +0000
Message-ID: <94699d0ed6ed7dd70cb2df2b53bdabcb1b81043a.1763052647.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1763052647.git.fdmanana@suse.com>
References: <cover.1763052647.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have already called btrfs_clear_buffer_dirty() against the left leaf in
the code above:

  btrfs_set_header_nritems(left, left_nritems);

  if (left_nritems)
       btrfs_mark_buffer_dirty(trans, left);
  else
       btrfs_clear_buffer_dirty(trans, left);

So remove the second check for a 0 number of items in the left leaf and
calling again btrfs_clear_buffer_dirty() against the left leaf.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index dada50d86731..7265dd661cde 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3214,8 +3214,6 @@ static noinline int __push_leaf_right(struct btrfs_trans_handle *trans,
 	/* then fixup the leaf pointer in the path */
 	if (path->slots[0] >= left_nritems) {
 		path->slots[0] -= left_nritems;
-		if (btrfs_header_nritems(left) == 0)
-			btrfs_clear_buffer_dirty(trans, left);
 		btrfs_tree_unlock(left);
 		free_extent_buffer(left);
 		path->nodes[0] = right;
-- 
2.47.2


