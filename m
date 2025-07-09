Return-Path: <linux-btrfs+bounces-15368-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F1CAFE285
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 10:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF001BC72E8
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 08:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F7E2741AC;
	Wed,  9 Jul 2025 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQmxvhLV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37101273D71
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049565; cv=none; b=D1diSle7YI+e8lmE7xM/sEtqgUZ+1JluZZ9D3WU/1Yrv+MNDxSiNLcTVeQNgPQMSxXRkjS/JsejrvrKOS/pZX+Px8QB1MHSXVbsmtkswVwdD59zzqy/QqRUg4vkxmOF8b2rnQgiaobZNeLG/ZJ8gWTvj3Y51Xhfr2h9ZUsSafn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049565; c=relaxed/simple;
	bh=MjICc524kAGffGLK4fitSVYgsPXAEIbUEKkQTWrBR1o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Bq6tMY875jNspMfONJ+Qk+tkTwj3KN5qx+Bw3blrmDzVjK+3wmQD1mf1DZiJ0RnZxAC+SbeMYONtYzVXnh9Ymb5FUDfOWq5ZUsALNYRXfYP9/CS8n6NH0XoSUlZzRpAOmz6PnANdq9PI6R0f1xZgYR/QMCN1h2VGtOnYV7HAh/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQmxvhLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7E5C4CEEF
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 08:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752049565;
	bh=MjICc524kAGffGLK4fitSVYgsPXAEIbUEKkQTWrBR1o=;
	h=From:To:Subject:Date:From;
	b=HQmxvhLVw/rZTjzyLi1G9QGD8ZsB+tOa7Qamf12C4xnAm+GAAmIX+3ATp/y2YxHW4
	 oJVR4pHoz1sLrqoD4861kG0kvhBfn77F/Oc2/gP4HC1l0FcVLZkdvMGwBmla4nEnhC
	 tzrDCt+0aXuBFOVQ8HYvF6hONfxSz9PqLZP1rZSqG4cwm8SyMhJL5SSCCv0uFyOQSj
	 8PVtD4aOdi/IFzB/L65XZYTG9c4kGeAEEQes3qUEByfBHN+RIpedPCtZ8WflPITzxa
	 aqlpVdHfUzi5YO3rMQoASMAE8qQhZ47cXBilbnPadzcLMsvGbnocOcp+ryKCZ6KJzz
	 eLB/ddcGOlQRg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: set EXTENT_NORESERVE before range unlock in btrfs_truncate_block()
Date: Wed,  9 Jul 2025 09:26:01 +0100
Message-ID: <b780ff5c6ffae11065555177e508a1c78cdf9ad9.1752049280.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Set the EXTENT_NORESERVE bit in the io tree before unlocking the range so
that we can use the cached state and speedup the operation, since the
unlock operation releases the cached state.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d7a2ea7d121f..d060a64f8808 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4999,11 +4999,12 @@ int btrfs_truncate_block(struct btrfs_inode *inode, u64 offset, u64 start, u64 e
 				  block_end + 1 - block_start);
 	btrfs_folio_set_dirty(fs_info, folio, block_start,
 			      block_end + 1 - block_start);
-	btrfs_unlock_extent(io_tree, block_start, block_end, &cached_state);
 
 	if (only_release_metadata)
 		btrfs_set_extent_bit(&inode->io_tree, block_start, block_end,
-				     EXTENT_NORESERVE, NULL);
+				     EXTENT_NORESERVE, &cached_state);
+
+	btrfs_unlock_extent(io_tree, block_start, block_end, &cached_state);
 
 out_unlock:
 	if (ret) {
-- 
2.47.2


