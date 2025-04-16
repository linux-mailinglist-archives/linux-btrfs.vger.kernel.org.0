Return-Path: <linux-btrfs+bounces-13086-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717F3A9068F
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 16:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFEE53AA1A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 14:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3451FF7B0;
	Wed, 16 Apr 2025 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UkB26WRc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D144E1FC7D2
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813722; cv=none; b=lkOcqG7m4zaU1jDIRSQddfsQfcu68UOyRMyLHB5YxNQgJg/xpiEq1GrGfEb/SSUTRput4F/c52vdBVIUxPdUfJBd+gcsMBHUFCWqjJaSwD8eBVnDCuFCw20em2sspQIq4qNWeiyPmMx8RT45CO6wwROZ/21BnN9ShVFDLzzgYiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813722; c=relaxed/simple;
	bh=U0iKqlhYRr1nofNy7aE9+3JNfru99hYNbCUopsqLeYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UREDKrF2i/HzL8VuKRE/zXeElhNQaofzuJNfw9ak7jrbJ5yxUdTAmvue69s/od5+oUNhweqBA+ju7wkl6C3e1M+ReIuIbHf92mQ4Sra1GjVmlxGYYcpXe8y/+tWQfDZe5+HE9GUFA9NpJSijUQQaj8Kl5k861di/VwU508Dyw1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UkB26WRc; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744813720; x=1776349720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U0iKqlhYRr1nofNy7aE9+3JNfru99hYNbCUopsqLeYU=;
  b=UkB26WRcvT5/L/WMIPNrwxGUPVGDmTBpWZw+KBIzkztwlckUpzjHL3/9
   CZPwlz14I07fAsTUJi9BW8xR1kDV6YnVKyoicBis1NHDeOgkq7xN6BqHm
   6mMHrZeSzhNyCFrrZus51hSz78fXo1ogAslGu/klW5Rdw921mq4chrbg+
   D6m6/MIy6Qv4Y6GQNFeBcPrCsGjsyrA7lyPuPPmHIYCXCrhNIjcz3lbUs
   r5vhfd0lPJoMroTeoKe0+Z8Vo9WW5ETP1QRhgglrZTKHqGMf+a3skUhrW
   cCQIwpBljkCz3SZmI4bopfZY3YDJUvXC4qbb8EPfhwPjnYgWpYcT6EKAB
   A==;
X-CSE-ConnectionGUID: nLAt5Kc+QfWnsbNYxq97nA==
X-CSE-MsgGUID: BkuQNvwGTbW0szCn6ftDmQ==
X-IronPort-AV: E=Sophos;i="6.15,216,1739808000"; 
   d="scan'208";a="81484532"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2025 22:28:35 +0800
IronPort-SDR: 67ffb085_UY2504Z5XQhtW8aq1cHx0abf1jV0q6lWyyzHDGXAsI4lyGA
 aZSkmMC2TlWFEBEwpaEiNMuELNEImwXc9+f4Vog==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2025 06:28:38 -0700
WDCIronportException: Internal
Received: from 5cg2075gjp.ad.shared (HELO naota-xeon..) ([10.224.104.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2025 07:28:34 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 10/13] btrfs: tweak extent/chunk allocation for space_info sub-space
Date: Wed, 16 Apr 2025 23:28:15 +0900
Message-ID: <520eb9731dec3ab8b6c445bd5eb2ad7d3a1be700.1744813603.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744813603.git.naohiro.aota@wdc.com>
References: <cover.1744813603.git.naohiro.aota@wdc.com>
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent-tree.c | 18 ++++++++++++++----
 fs/btrfs/space-info.c  |  4 +++-
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1dad1a42c9c1..0744134a0000 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4347,7 +4347,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	int ret = 0;
 	int cache_block_group_error = 0;
 	struct btrfs_block_group *block_group = NULL;
-	struct btrfs_space_info *space_info;
+	struct btrfs_space_info *space_info = NULL;
 	bool full_search = false;
 
 	WARN_ON(ffe_ctl->num_bytes < fs_info->sectorsize);
@@ -4378,10 +4378,19 @@ static noinline int find_free_extent(struct btrfs_root *root,
 
 	trace_btrfs_find_free_extent(root, ffe_ctl);
 
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
@@ -4402,6 +4411,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		 * picked out then we don't care that the block group is cached.
 		 */
 		if (block_group && block_group_bits(block_group, ffe_ctl->flags) &&
+		    block_group->space_info == space_info &&
 		    block_group->cached != BTRFS_CACHE_NO) {
 			down_read(&space_info->groups_sem);
 			if (list_empty(&block_group->list) ||
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 4b2343a3a009..62dc69322b80 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -357,7 +357,9 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 
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


