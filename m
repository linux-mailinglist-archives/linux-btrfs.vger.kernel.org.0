Return-Path: <linux-btrfs+bounces-17733-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E1FBD58AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 19:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E3A18A5D43
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 17:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1A4309EF2;
	Mon, 13 Oct 2025 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rwd0qxPj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17B73093D5
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377110; cv=none; b=F473ONQyGuxZ09nnIb2WVMsrmt3NoIM7t2g1fajq3XQCq+qD3EJykWoPc3TDBjxGhbPdAieglS/HZs3ElKQo7j3JQHMK2cTFariRwhkCIHvnAMoInPZpU0yBT5WwAzWA1EDhMPcHKPuapSK1OYFac6tzxAh4uipo/muweHg6QZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377110; c=relaxed/simple;
	bh=qSFx+LLN02G3NpbdBt/KbwA4dITXajlBweLiZXi03B4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyCuhDT0SgPN5BTtciLFXSdImDedVfbjBmi03xg4Kqbdwg4gPKQ3pDvJnbmy1Xux1RHlTxFQoQwHADh7G9G+a4rBs4dEIx/e9K7VpnpTAgHkMkkLW0dAlloXyAkPXxIDqelGPwSshC8RyeVfFaoB1EKAHj7X7BoWW28s3XF79eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rwd0qxPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E71FC4CEFE
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377109;
	bh=qSFx+LLN02G3NpbdBt/KbwA4dITXajlBweLiZXi03B4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Rwd0qxPj3fooGe9u4BwTYd6FtmdAtI1qFuWH65E15afyduXeTXDgfAcoNR3vuDaYi
	 0dWNvs5egdsFvY6uBhLcuP/coEKz4tn/ZS/uzFKfo6FcCo5O+zHbcHeuq937zXEC0e
	 9OcjcXMvDM/2vxGY684cg2uRRr7m7PcxQ2z0j9YBQOHJgqGzXDsZ5yw9zQ9i6uQZoH
	 n+x5aD3/4XItVTKjzCCCO/kQAkpKGzLHdVhXMnJHtTRL4IdG/Xokss45ADnrh5z2n7
	 vPEkkCylkvV0P4c4CuyIOEk8eH8WqtF6P1W+Dis0sy+Bi0UNrDe/Ckr56pl9ra2Qk2
	 dDBzHhNye6kHQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 16/16] btrfs: remove fs_info argument from btrfs_reserve_metadata_bytes()
Date: Mon, 13 Oct 2025 18:38:11 +0100
Message-ID: <b8fcde93eae08e68952fa8da8587883d9e8da1c4.1760376569.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1760376569.git.fdmanana@suse.com>
References: <cover.1760376569.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We don't need it since we can grab fs_info from the given space_info.
So remove the fs_info argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-rsv.c      | 12 +++++-------
 fs/btrfs/delalloc-space.c |  4 ++--
 fs/btrfs/delayed-ref.c    |  2 +-
 fs/btrfs/space-info.c     |  6 +++---
 fs/btrfs/space-info.h     |  3 +--
 fs/btrfs/transaction.c    |  4 ++--
 6 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 75cd35570a28..96cf7a162987 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -218,8 +218,7 @@ int btrfs_block_rsv_add(struct btrfs_fs_info *fs_info,
 	if (num_bytes == 0)
 		return 0;
 
-	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv->space_info,
-					   num_bytes, flush);
+	ret = btrfs_reserve_metadata_bytes(block_rsv->space_info, num_bytes, flush);
 	if (!ret)
 		btrfs_block_rsv_add_bytes(block_rsv, num_bytes, true);
 
@@ -259,8 +258,7 @@ int btrfs_block_rsv_refill(struct btrfs_fs_info *fs_info,
 	if (!ret)
 		return 0;
 
-	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv->space_info,
-					   num_bytes, flush);
+	ret = btrfs_reserve_metadata_bytes(block_rsv->space_info, num_bytes, flush);
 	if (!ret) {
 		btrfs_block_rsv_add_bytes(block_rsv, num_bytes, false);
 		return 0;
@@ -530,8 +528,8 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
 				block_rsv->type, ret);
 	}
 try_reserve:
-	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv->space_info,
-					   blocksize, BTRFS_RESERVE_NO_FLUSH);
+	ret = btrfs_reserve_metadata_bytes(block_rsv->space_info, blocksize,
+					   BTRFS_RESERVE_NO_FLUSH);
 	if (!ret)
 		return block_rsv;
 	/*
@@ -552,7 +550,7 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
 	 * one last time to force a reservation if there's enough actual space
 	 * on disk to make the reservation.
 	 */
-	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv->space_info, blocksize,
+	ret = btrfs_reserve_metadata_bytes(block_rsv->space_info, blocksize,
 					   BTRFS_RESERVE_FLUSH_EMERGENCY);
 	if (!ret)
 		return block_rsv;
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 288e1776c02d..0970799d0aa4 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -358,8 +358,8 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
 						 noflush);
 	if (ret)
 		return ret;
-	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv->space_info,
-					   meta_reserve, flush);
+	ret = btrfs_reserve_metadata_bytes(block_rsv->space_info, meta_reserve,
+					   flush);
 	if (ret) {
 		btrfs_qgroup_free_meta_prealloc(root, qgroup_reserve);
 		return ret;
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index f8fc26272f76..e8bc37453336 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -228,7 +228,7 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 	if (!num_bytes)
 		return 0;
 
-	ret = btrfs_reserve_metadata_bytes(fs_info, space_info, num_bytes, flush);
+	ret = btrfs_reserve_metadata_bytes(space_info, num_bytes, flush);
 	if (ret)
 		return ret;
 
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d65b2e25d4b7..dba28e969f65 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1848,7 +1848,6 @@ static int __reserve_bytes(struct btrfs_space_info *space_info, u64 orig_bytes,
 /*
  * Try to reserve metadata bytes from the block_rsv's space.
  *
- * @fs_info:    the filesystem
  * @space_info: the space_info we're allocating for
  * @orig_bytes: number of bytes we want
  * @flush:      whether or not we can flush to make our reservation
@@ -1860,8 +1859,7 @@ static int __reserve_bytes(struct btrfs_space_info *space_info, u64 orig_bytes,
  * regain reservations will be made and this will fail if there is not enough
  * space already.
  */
-int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
-				 struct btrfs_space_info *space_info,
+int btrfs_reserve_metadata_bytes(struct btrfs_space_info *space_info,
 				 u64 orig_bytes,
 				 enum btrfs_reserve_flush_enum flush)
 {
@@ -1869,6 +1867,8 @@ int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 
 	ret = __reserve_bytes(space_info, orig_bytes, flush);
 	if (ret == -ENOSPC) {
+		struct btrfs_fs_info *fs_info = space_info->fs_info;
+
 		trace_btrfs_space_reservation(fs_info, "space_info:enospc",
 					      space_info->flags, orig_bytes, 1);
 
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index a88cf71b3d3a..2fad2e4c2252 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -278,8 +278,7 @@ u64 __pure btrfs_space_info_used(const struct btrfs_space_info *s_info,
 void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
 void btrfs_dump_space_info(struct btrfs_space_info *info, u64 bytes,
 			   bool dump_block_groups);
-int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
-				 struct btrfs_space_info *space_info,
+int btrfs_reserve_metadata_bytes(struct btrfs_space_info *space_info,
 				 u64 orig_bytes,
 				 enum btrfs_reserve_flush_enum flush);
 void btrfs_try_granting_tickets(struct btrfs_space_info *space_info);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 89ae0c7a610a..6607e354eae5 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -575,7 +575,7 @@ static int btrfs_reserve_trans_metadata(struct btrfs_fs_info *fs_info,
 	 * We want to reserve all the bytes we may need all at once, so we only
 	 * do 1 enospc flushing cycle per transaction start.
 	 */
-	ret = btrfs_reserve_metadata_bytes(fs_info, si, bytes, flush);
+	ret = btrfs_reserve_metadata_bytes(si, bytes, flush);
 
 	/*
 	 * If we are an emergency flush, which can steal from the global block
@@ -585,7 +585,7 @@ static int btrfs_reserve_trans_metadata(struct btrfs_fs_info *fs_info,
 	if (ret && flush == BTRFS_RESERVE_FLUSH_ALL_STEAL) {
 		bytes -= *delayed_refs_bytes;
 		*delayed_refs_bytes = 0;
-		ret = btrfs_reserve_metadata_bytes(fs_info, si, bytes, flush);
+		ret = btrfs_reserve_metadata_bytes(si, bytes, flush);
 	}
 
 	return ret;
-- 
2.47.2


