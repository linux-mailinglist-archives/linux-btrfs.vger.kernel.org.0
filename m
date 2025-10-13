Return-Path: <linux-btrfs+bounces-17722-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69919BD58D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 19:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B4240111F
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 17:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB53D2D660E;
	Mon, 13 Oct 2025 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUSocHEL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53BF3019C3
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377100; cv=none; b=JtZuEZB/vtLX2WYpoU1lSDW/+lMscZhJk6cisGsmCDLjZt+c9o7VKBqz5ksKe77BMP3upQ6kQMM1YkSZIGHNnuiyKdHe8RxdbViIhIT1YYbJ0GlJ7117eGHkLLfeCLhDZgGt1cGy6nedL8nKxN5QhgIbZ5OGwlsluIdoSasoCXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377100; c=relaxed/simple;
	bh=msR72NceCWAux0PV53zpjzg7Bs7a6vP/oJSq2SqyK1A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b99iaEmyJ9fnwLBPCZKteM+qxNF5NH1SUz/AdX8MtRLZWdmz+8qr/XVBCMZVc1eHuv2i/QYYfrEgee9TwdDKkpf5dSrI2hrGN+qYFACmBep4256WNmtP/yi+5LlMd2ltA46hswgUgYyb+19MRnY6e/5pxcxN786wKj8blaQDS0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUSocHEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48995C4CEFE
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377099;
	bh=msR72NceCWAux0PV53zpjzg7Bs7a6vP/oJSq2SqyK1A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FUSocHEL1EyXeJudzggBI27CxTzgoIXrgqR5qwTVVvJtfkNqdfpH+9NOYP6vlNQIp
	 KXxWqHV+rnPdzzdTE2+H3IJI/LBpzXhiH5dHZ8pOgA15yOJhsbOlOtlHNdWgpDMiSf
	 oDNlwTSfeMmuBEdhtlGHgtpw5LPnEZqf/Gy8ql7fgtPoOBK79Q9hCiqz5naRqvSAJk
	 z6s29mPdY2m3r4jQCO01Gitwt3tbQdoXpmz2ct4YEOcCwKQ8AV/bzlHscmTs3tR9ty
	 ia4BWAHSnSLlhGFLrGlLOlgebk2OcOQsp9lRcbiBen6sn/E4EQjq7nTfbIFDM2rBKf
	 6QW0aVnTRmCeQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 05/16] btrfs: remove fs_info argument from calc_available_free_space()
Date: Mon, 13 Oct 2025 18:38:00 +0100
Message-ID: <dd0e9ae1042108ffaae4aecb7b45ffba2122acf7.1760376569.git.fdmanana@suse.com>
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
 fs/btrfs/space-info.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 1a2566676284..88d715dcdb0e 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -421,10 +421,10 @@ static u64 calc_effective_data_chunk_size(struct btrfs_fs_info *fs_info)
 	return min_t(u64, data_chunk_size, SZ_1G);
 }
 
-static u64 calc_available_free_space(struct btrfs_fs_info *fs_info,
-			  const struct btrfs_space_info *space_info,
-			  enum btrfs_reserve_flush_enum flush)
+static u64 calc_available_free_space(const struct btrfs_space_info *space_info,
+				     enum btrfs_reserve_flush_enum flush)
 {
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	u64 profile;
 	u64 avail;
 	u64 data_chunk_size;
@@ -502,7 +502,7 @@ int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
 		return 0;
 
 	used = btrfs_space_info_used(space_info, true);
-	avail = calc_available_free_space(fs_info, space_info, flush);
+	avail = calc_available_free_space(space_info, flush);
 
 	if (used + bytes < space_info->total_bytes + avail)
 		return 1;
@@ -909,8 +909,7 @@ static u64 btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 
 	lockdep_assert_held(&space_info->lock);
 
-	avail = calc_available_free_space(fs_info, space_info,
-					  BTRFS_RESERVE_FLUSH_ALL);
+	avail = calc_available_free_space(space_info, BTRFS_RESERVE_FLUSH_ALL);
 	used = btrfs_space_info_used(space_info, true);
 
 	/*
@@ -992,8 +991,7 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 	 * much delalloc we need for the background flusher to kick in.
 	 */
 
-	thresh = calc_available_free_space(fs_info, space_info,
-					   BTRFS_RESERVE_FLUSH_ALL);
+	thresh = calc_available_free_space(space_info, BTRFS_RESERVE_FLUSH_ALL);
 	used = space_info->bytes_used + space_info->bytes_reserved +
 	       space_info->bytes_readonly + global_rsv_size;
 	if (used < space_info->total_bytes)
-- 
2.47.2


