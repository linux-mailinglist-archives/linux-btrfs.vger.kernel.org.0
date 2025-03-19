Return-Path: <linux-btrfs+bounces-12407-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 234C9A684E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 07:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C59C07AA7CD
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 06:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1942A24EF7D;
	Wed, 19 Mar 2025 06:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FAgyKdc+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38550212B0E
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 06:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364903; cv=none; b=J1rQZRV1hAoyw9j8CbAAJb5OmZTuFYGUrus0QBijg/CJByHMl7uEv/YG1frCTqLiedf0aU0PG+7MAB4eHnZZfJtOpAjqQI82w4LkDywfffcIeJ2x6V/XPX2CyHVI+MP/TSneAog4fdfwIbhsn9PEcbci4/UreT+Y/zuJgVym2eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364903; c=relaxed/simple;
	bh=zKCHCNZawBJM6dDEkaVLMZo4bmkQXBDFYpIAh4QGK1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8IDxXsh8E6o+iD/i2mSzEHIoDdjOD4ywwKdjQerGzjIPcpq9ntc0sIwV2Ju3DG0M1485CWbfWPSxujEnvJ6tvhoh3k3RpopB+HmICuOWmc5rDxb3D9+xv0iz2quLINvL6M3v8OyUmspvmPMIG1MaTcCzbcS4E5bteE45b8kHj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FAgyKdc+; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742364900; x=1773900900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zKCHCNZawBJM6dDEkaVLMZo4bmkQXBDFYpIAh4QGK1I=;
  b=FAgyKdc+Yk8xgCdlxSGBYfh6ybxb5cZAk6gufMIPMcdDHaCq+wP3szj6
   b4CDYMwRgtZxixbjeNSrqcQiM9Lr6mqvL0P+aLtbfLcPJRrDJCWIShCAf
   rIr3OlP6MUyadHYJSRVCPnfITQwgQQNbE5FsNGBSf04icBzoJFY580wnx
   FnEiL+RUHxLhaL9QTezXHxnEehFjOPKb65SJio2ZxgVilCrKZmrl28hfT
   9/5dwcSt7lRacohMrQMRpFMoyQ83XHkOd7vl7gLxXKkn7kna61QVGsmMJ
   sBu91eLGqAW+qsLLG2EiprCUIRqUeLwyIdUx7M3ko0sZMtKlVXcuA9lar
   w==;
X-CSE-ConnectionGUID: Knk/5K7GSXWYwcZB+g/lhg==
X-CSE-MsgGUID: RYT+6oU7S52Qj5kQHTevpw==
X-IronPort-AV: E=Sophos;i="6.14,258,1736784000"; 
   d="scan'208";a="55227168"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2025 14:14:59 +0800
IronPort-SDR: 67da5303_4XW1B6b6SUeUGuwyyBZmHYwRaGJVFnH9T+9IZp3mMNNvaxO
 aXJPJqerPIb4WUtjoilMihqHjYvgFedc7Ucqtqg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2025 22:15:47 -0700
WDCIronportException: Internal
Received: from gbdn3z2.ad.shared (HELO naota-xeon..) ([10.224.109.136])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Mar 2025 23:14:58 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 02/13] btrfs: take struct btrfs_inode in btrfs_free_reserved_data_space_noquota
Date: Wed, 19 Mar 2025 15:14:33 +0900
Message-ID: <8a68a284a3bf14a38a38fafd746d24705a0bee4d.1742364593.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1742364593.git.naohiro.aota@wdc.com>
References: <cover.1742364593.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As well as the last patch, take struct btrfs_inode in the function and let
it distinguish which data space it is working on in a later patch. There is
no functional change with this commit.

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
index 2a5f74133e69..de3aa4eff2eb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2617,7 +2617,7 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 		    !btrfs_is_free_space_inode(inode) &&
 		    !(state->state & EXTENT_NORESERVE) &&
 		    (bits & EXTENT_CLEAR_DATA_RESV))
-			btrfs_free_reserved_data_space_noquota(fs_info, len);
+			btrfs_free_reserved_data_space_noquota(inode, len);
 
 		percpu_counter_add_batch(&fs_info->delalloc_bytes, -len,
 					 fs_info->delalloc_batch);
@@ -9766,7 +9766,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	 * bytes_may_use.
 	 */
 	if (!extent_reserved)
-		btrfs_free_reserved_data_space_noquota(fs_info, disk_num_bytes);
+		btrfs_free_reserved_data_space_noquota(inode, disk_num_bytes);
 out_unlock:
 	unlock_extent(io_tree, start, end, &cached_state);
 out_folios:
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f948f4f6431c..f9bc2e107a22 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2751,8 +2751,7 @@ static noinline_for_stack int prealloc_file_extent_cluster(struct reloc_control
 	btrfs_inode_unlock(inode, 0);
 
 	if (cur_offset < prealloc_end)
-		btrfs_free_reserved_data_space_noquota(inode->root->fs_info,
-					       prealloc_end + 1 - cur_offset);
+		btrfs_free_reserved_data_space_noquota(inode, prealloc_end + 1 - cur_offset);
 	return ret;
 }
 
-- 
2.49.0


