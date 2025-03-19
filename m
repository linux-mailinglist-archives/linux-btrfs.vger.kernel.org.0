Return-Path: <linux-btrfs+bounces-12414-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FE2A684FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 07:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602B71B60002
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 06:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71452505B8;
	Wed, 19 Mar 2025 06:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IwcCUTr7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907A224EF91
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 06:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364910; cv=none; b=aokC5eMg0izI2YQiYM6hJeS0QGf6UAUppMTcdOY6RzE6hi9YkvmxZrgO2k0XoJjljnrZ78i0hAY18PsJ1wqTHpZgvMWNmJmA/z1qD+SYKUcw2mNU0gxCg3AfVf0kKgSoTYLOrQI6WUx1jW9po+ZaoqzvRXJJpOTiKCbsJx8e4F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364910; c=relaxed/simple;
	bh=ND+aV7bzkhxk5FWFs3EFXqoVXMiEtCxYhlDG6Rf/QTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESYPEDefiJUwxy5xyE5NJXbSWfRiDwC8/8O1sb/1XLl5a5iNJUXLBfGYlgj83jHu7FOwZ3330OWYwQZyynPWPukQ6qRKtp4LkNDdcQ16I5MwqhPrvjtXt2gQyDQRJFnOQn98PkVFGCZRdl4gYn2YdZ557SNTBDGwc09SjPLo6oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IwcCUTr7; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742364908; x=1773900908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ND+aV7bzkhxk5FWFs3EFXqoVXMiEtCxYhlDG6Rf/QTo=;
  b=IwcCUTr7wngaFnWECQNbjB9FxiSYW82lc+MnB00wW/9M1x5pcazzQzxX
   03o3FyJbBzuq3umoxovfZhNe2sOjYKDkxdmgnL6M6yckVf1sW3hWwtqC1
   +a8j+HuIL2K/s2uJW2qGhsZUq4Qdpdfx5yJP9Ng0KYqN91xf5aVpJWsjW
   9dhJndMEYHr7uPabGo7bS0fiNcKY9hzAnXat1wzuNcdQV/3OjzK3HelEm
   T6gOVcmnB8jLSBTDe0jypArBa4uHS+NH5WWHsWDiygdKxbDg7DBNQ0urp
   fA0apZUqZ4bs6Cix2voCNZxo1ZC5XFKW3mahX19v5sWGyFD6FGAa95ltI
   A==;
X-CSE-ConnectionGUID: /JB0JgB6Q+2rBfYKD/g2Wg==
X-CSE-MsgGUID: Vi9+2n8oQJ6KyrffeqymjA==
X-IronPort-AV: E=Sophos;i="6.14,258,1736784000"; 
   d="scan'208";a="55227260"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2025 14:15:07 +0800
IronPort-SDR: 67da530b_Xv/cx7DgtHFxhWStgP2cl5+4pDqgY7hx9GrOGUgjborpM/H
 cf9SSTr9rsA9eHEI0iHD6zNOAeoGICjBNEQGKsg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2025 22:15:56 -0700
WDCIronportException: Internal
Received: from gbdn3z2.ad.shared (HELO naota-xeon..) ([10.224.109.136])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Mar 2025 23:15:06 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 10/13] btrfs: tweak extent/chunk allocation for space_info sub-space
Date: Wed, 19 Mar 2025 15:14:41 +0900
Message-ID: <a56b3607591af4c7ad9cd2f289e22c56ed7df8bf.1742364593.git.naohiro.aota@wdc.com>
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

Make the extent allocator and the chunk allocator aware of the sub-space.
It now uses SUB_GROUP_DATA_RELOC sub-space for data relocation block group,
and uses SUB_GROUP_METADATA_TREELOG for metadata tree-log block group.

And, it needs to check the space_info is the right one when a block group
candidate is given. Also, new block group should now belong to the
specified one.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 18 ++++++++++++++----
 fs/btrfs/space-info.c  |  4 +++-
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 062f860ec379..5767a9ef39c7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4353,7 +4353,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	int ret = 0;
 	int cache_block_group_error = 0;
 	struct btrfs_block_group *block_group = NULL;
-	struct btrfs_space_info *space_info;
+	struct btrfs_space_info *space_info = NULL;
 	bool full_search = false;
 
 	WARN_ON(ffe_ctl->num_bytes < fs_info->sectorsize);
@@ -4384,10 +4384,19 @@ static noinline int find_free_extent(struct btrfs_root *root,
 
 	trace_find_free_extent(root, ffe_ctl);
 
-	space_info = btrfs_find_space_info(fs_info, ffe_ctl->flags);
+	if (btrfs_is_zoned(fs_info)) {
+		/* Use dedicated sub-space_info for dedicated block group users. */
+		if (ffe_ctl->for_data_reloc)
+			space_info = space_info->sub_group[SUB_GROUP_DATA_RELOC];
+		else if (ffe_ctl->for_treelog)
+			space_info = space_info->sub_group[SUB_GROUP_METADATA_TREELOG];
+	}
 	if (!space_info) {
-		btrfs_err(fs_info, "No space info for %llu", ffe_ctl->flags);
-		return -ENOSPC;
+		space_info = btrfs_find_space_info(fs_info, ffe_ctl->flags);
+		if (!space_info) {
+			btrfs_err(fs_info, "No space info for %llu", ffe_ctl->flags);
+			return -ENOSPC;
+		}
 	}
 
 	ret = prepare_allocation(fs_info, ffe_ctl, space_info, ins);
@@ -4408,6 +4417,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		 * picked out then we don't care that the block group is cached.
 		 */
 		if (block_group && block_group_bits(block_group, ffe_ctl->flags) &&
+		    block_group->space_info == space_info &&
 		    block_group->cached != BTRFS_CACHE_NO) {
 			down_read(&space_info->groups_sem);
 			if (list_empty(&block_group->list) ||
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 3c775c76e2af..730763be4276 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -351,7 +351,9 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 
 	factor = btrfs_bg_type_to_factor(block_group->flags);
 
-	found = btrfs_find_space_info(info, block_group->flags);
+	found = block_group->space_info;
+	if (!found)
+		found = btrfs_find_space_info(info, block_group->flags);
 	ASSERT(found);
 	spin_lock(&found->lock);
 	found->total_bytes += block_group->length;
-- 
2.49.0


