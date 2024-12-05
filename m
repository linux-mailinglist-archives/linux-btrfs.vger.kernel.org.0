Return-Path: <linux-btrfs+bounces-10076-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A159E4EEE
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 08:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F611881A50
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 07:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB78C1B6CE3;
	Thu,  5 Dec 2024 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LmNezw+N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682721C3BEF
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Dec 2024 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733385029; cv=none; b=GL3sV+IPi0mk59ZE4pY4fLUrtwypc3GsP54uEEMAqhbOTFJwRA/lUQgLhaX/4WlKKiTpNVwi1xKmSOI2nNwO41wQHp9uPd+0Rd+xro1HL9XnAkLNuNUGgQVn+00lTPX0OY7RElakTtlEOlLoeWznKE7uMUatBvhb1j3m/vDucxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733385029; c=relaxed/simple;
	bh=JZ6gIsb/gUBOJXCjjL+njWjuSlcmCFqNY2hYIXXCUBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XosLleDlfc/70nzDlnLyy6djA5lToy9/oq0GhvLubajh66m8+6MKroVcK9HUGrkVQRfs/iRswo5Zjs3SeP/k3I32s0h9nSc+PJ6ajNro2ZVqvwxQl3CLw6W7iqdM3z6xU9RS6A9DRcPFCsWZ0feTZL/iYKDW9sTFZDv/2c4yJ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LmNezw+N; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733385027; x=1764921027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JZ6gIsb/gUBOJXCjjL+njWjuSlcmCFqNY2hYIXXCUBs=;
  b=LmNezw+NtYVVsEOHa6cHynSvXOiKLbn1AIWHEwAaYdR2b39miopTdaY3
   9F+xaHmbZhyaICKN4pFUzpCgLTVwSM9SrT7+XJgEexhUhgYB98rqlfgRk
   5QdZrJ5gROxpRBLTkMfmpsRnyVwXJSsX3r+kBWr+n2Dh3vFExOK7pyBUr
   GXswqZiNd2fSu5NaVUv4PPtifOk05Qf0UQLwKHy9QQDaA6kdLQtn5IYh/
   EUv6OaRQRWA00vvBRrrAi5UyszT3D6T+Cq0KVZCK+kPf6JrPvN+s+1w1W
   B+NgwoTcv2G/5Ap207qjRjLRiMgk3yJN9GIgRnL774qG5UMrQLpPX/inP
   g==;
X-CSE-ConnectionGUID: fONgq3zEQCCvihJpmjCK/w==
X-CSE-MsgGUID: HDtVRW9WT6uMcKuitfrPxg==
X-IronPort-AV: E=Sophos;i="6.12,209,1728921600"; 
   d="scan'208";a="33626104"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2024 15:49:17 +0800
IronPort-SDR: 67514c58_6xYeuVneTnExcf4HDWrP6xuaLKihg4cQ5cdtYVSSZBNrB2u
 KqjVqqfMr+oOma8fzlMY/4tOJuWXbI4EyYmpCLw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2024 22:46:48 -0800
WDCIronportException: Internal
Received: from naota-x1.dhcp.fujisawa.hgst.com (HELO naota-x1.ad.shared) ([10.89.81.175])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2024 23:49:17 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 02/11] btrfs: take struct btrfs_inode in btrfs_free_reserved_data_space_noquota
Date: Thu,  5 Dec 2024 16:48:18 +0900
Message-ID: <49c05fff4552b688e962e540328d2631b4814d63.1733384171.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733384171.git.naohiro.aota@wdc.com>
References: <cover.1733384171.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As well as the last patch, take struct btrfs_inode in the function and let it
distinguish which data space it is working on in a later patch. There is no
functional change with this commit.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/delalloc-space.c | 7 ++++---
 fs/btrfs/delalloc-space.h | 3 +--
 fs/btrfs/inode.c          | 4 ++--
 fs/btrfs/relocation.c     | 3 +--
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index e9750f96f86c..918ba2ab1d5f 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -151,7 +151,7 @@ int btrfs_check_data_free_space(struct btrfs_inode *inode,
 	/* Use new btrfs_qgroup_reserve_data to reserve precious data space. */
 	ret = btrfs_qgroup_reserve_data(inode, reserved, start, len);
 	if (ret < 0) {
-		btrfs_free_reserved_data_space_noquota(fs_info, len);
+		btrfs_free_reserved_data_space_noquota(inode, len);
 		extent_changeset_free(*reserved);
 		*reserved = NULL;
 	} else {
@@ -168,9 +168,10 @@ int btrfs_check_data_free_space(struct btrfs_inode *inode,
  * which we can't sleep and is sure it won't affect qgroup reserved space.
  * Like clear_bit_hook().
  */
-void btrfs_free_reserved_data_space_noquota(struct btrfs_fs_info *fs_info,
+void btrfs_free_reserved_data_space_noquota(struct btrfs_inode *inode,
 					    u64 len)
 {
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_space_info *data_sinfo;
 
 	ASSERT(IS_ALIGNED(len, fs_info->sectorsize));
@@ -196,7 +197,7 @@ void btrfs_free_reserved_data_space(struct btrfs_inode *inode,
 	      round_down(start, fs_info->sectorsize);
 	start = round_down(start, fs_info->sectorsize);
 
-	btrfs_free_reserved_data_space_noquota(fs_info, len);
+	btrfs_free_reserved_data_space_noquota(inode, len);
 	btrfs_qgroup_free_data(inode, reserved, start, len, NULL);
 }
 
diff --git a/fs/btrfs/delalloc-space.h b/fs/btrfs/delalloc-space.h
index 3f32953c0a80..d582779dac5a 100644
--- a/fs/btrfs/delalloc-space.h
+++ b/fs/btrfs/delalloc-space.h
@@ -18,8 +18,7 @@ void btrfs_free_reserved_data_space(struct btrfs_inode *inode,
 void btrfs_delalloc_release_space(struct btrfs_inode *inode,
 				  struct extent_changeset *reserved,
 				  u64 start, u64 len, bool qgroup_free);
-void btrfs_free_reserved_data_space_noquota(struct btrfs_fs_info *fs_info,
-					    u64 len);
+void btrfs_free_reserved_data_space_noquota(struct btrfs_inode *inode, u64 len);
 void btrfs_delalloc_release_metadata(struct btrfs_inode *inode, u64 num_bytes,
 				     bool qgroup_free);
 int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c4997200dbb2..e553264eaa0f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2556,7 +2556,7 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 		    !btrfs_is_free_space_inode(inode) &&
 		    !(state->state & EXTENT_NORESERVE) &&
 		    (bits & EXTENT_CLEAR_DATA_RESV))
-			btrfs_free_reserved_data_space_noquota(fs_info, len);
+			btrfs_free_reserved_data_space_noquota(inode, len);
 
 		percpu_counter_add_batch(&fs_info->delalloc_bytes, -len,
 					 fs_info->delalloc_batch);
@@ -9644,7 +9644,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	 * bytes_may_use.
 	 */
 	if (!extent_reserved)
-		btrfs_free_reserved_data_space_noquota(fs_info, disk_num_bytes);
+		btrfs_free_reserved_data_space_noquota(inode, disk_num_bytes);
 out_unlock:
 	unlock_extent(io_tree, start, end, &cached_state);
 out_folios:
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index bf267bdfa8f8..d60e118e88a3 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2828,8 +2828,7 @@ static noinline_for_stack int prealloc_file_extent_cluster(struct reloc_control
 	btrfs_inode_unlock(inode, 0);
 
 	if (cur_offset < prealloc_end)
-		btrfs_free_reserved_data_space_noquota(inode->root->fs_info,
-					       prealloc_end + 1 - cur_offset);
+		btrfs_free_reserved_data_space_noquota(inode, prealloc_end + 1 - cur_offset);
 	return ret;
 }
 
-- 
2.47.1


