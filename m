Return-Path: <linux-btrfs+bounces-13315-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFC2A98CC3
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2A31882282
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 14:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAE1280A3A;
	Wed, 23 Apr 2025 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVzaOtND"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8FD280CD6
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418025; cv=none; b=VKMidDLWrwBEOkjIS5GVdFOi/24sPrcV5FdzkEDXdW5abvWzdSVIHr/g1Ml9HZJ5dSp14dd1HjMaLxrvtfvHylIC2t6yvhRcQP8K8CFQvl+ldip5fg0+othKCbFQ5hpu5Bie+RZ3wannbJG6ev+HD/0GEmzN9IZNpeI5YJ4ehPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418025; c=relaxed/simple;
	bh=PyXJ37N1h63glh4aejYwFILtVk52rmjG7eP4cJDnitc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O0oD3SsrdSre4n6ZPK/e9Kui81zmtOLijcPbNcAcobuw3bAw7nePpq1y3qgFSbfsvmLgX23PkoLoGclpUomcq03shL7vvjwx1tAKXCkUbJgkX/eIDVqXW8d4PZN+I+BldXlokGKVFdZtuWs/9s2Y372NlGzoinywmpmSiQqybpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVzaOtND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D2CC4CEE2
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745418025;
	bh=PyXJ37N1h63glh4aejYwFILtVk52rmjG7eP4cJDnitc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aVzaOtNDO7z00BROs67EgEvz8vkQIQOnUxWvZIJ1x64LAfLDVWX7l2HmugMz6NUpr
	 nnl9SPH4zZaVhaxQ2zPNc9SSZ21jS4LD7rkLomaPG+EtJKnccveATPOPYVRG/5KHsf
	 pg55UXl3KlCa3m9Iabxz+nAlo60oxFvqIUEB8xslNEkzvU0qbCxGsXcyL/cE2iaAVb
	 4zZhjYvMLSgHekx73emqanCNif4q0lrvna56zhVjr5rV3J1EmMJDgvgf67ufCnoWh1
	 iBF/i0UhFFlqK/54ZFxwdefGllQKCg5PhehfVgaQbvFRMr8SfRLZTmmdkpPjLkbcpu
	 TqWxFjrt4uWeA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 19/22] btrfs: remove unnecessary NULL checks before freeing extent state
Date: Wed, 23 Apr 2025 15:19:59 +0100
Message-Id: <2566a24238b8ced06140e1e8c63c06e48f005e4a.1745401628.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745401627.git.fdmanana@suse.com>
References: <cover.1745401627.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When manipulating extent bits for an io tree range, we have this pattern:

   if (prealloc)
          btrfs_free_extent_state(prealloc);

but this is not needed nowadays since btrfs_free_extent_state() ignores
a NULL pointer argument, following the common pattern of kernel and btrfs
freeing functions, as well as libc and other user space libraries.
So remove the NULL checks, reducing source code and object size.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 7271d6356c32..f7fe7d23b40a 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -758,8 +758,7 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
 
 out:
 	spin_unlock(&tree->lock);
-	if (prealloc)
-		btrfs_free_extent_state(prealloc);
+	btrfs_free_extent_state(prealloc);
 
 	return ret;
 
@@ -1282,8 +1281,7 @@ static int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 
 out:
 	spin_unlock(&tree->lock);
-	if (prealloc)
-		btrfs_free_extent_state(prealloc);
+	btrfs_free_extent_state(prealloc);
 
 	return ret;
 
@@ -1527,8 +1525,7 @@ int btrfs_convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 
 out:
 	spin_unlock(&tree->lock);
-	if (prealloc)
-		btrfs_free_extent_state(prealloc);
+	btrfs_free_extent_state(prealloc);
 
 	return ret;
 }
-- 
2.47.2


