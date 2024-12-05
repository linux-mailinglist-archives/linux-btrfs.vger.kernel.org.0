Return-Path: <linux-btrfs+bounces-10071-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6AC9E4EE5
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 08:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5B216524D
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 07:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20321C3C1F;
	Thu,  5 Dec 2024 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q1p4QWr7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BD81917EE
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Dec 2024 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384967; cv=none; b=ookjk3Pf9qx3qH1/z4thoLeLO3M5GkDFBzZMw8Qt1L3tJjso5ZbkQpaeiL4IEA4XKmKwtztWGTCxfIzFSrNN7kklx4oatx6v+y9UGMDCDm0VP8c3wLgOQdnV01WIuWCSxtXqr6RBFe/jquPP9c88FuAZBJexmyeX35AAObc7x+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384967; c=relaxed/simple;
	bh=oXKGifZDNTPXMwkxKmhIsPbAT3cxcevpsRdIunfQg4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0jJSe3Eh4UO1GBR95+35hFPJoFu+izf8c9jHYvnxJXmeoGEyeCSW4V+TabPlB2xbyRO+eYvfc7IhucAko/SbkqkkSZ1+DWP89NWI2seMSlNg5ciEVviwsSLh3JAN2Rkq5Uq3oWVhSmRh/YWBLP1muvPdIGoF1/q8Qb/6Ktd8v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=q1p4QWr7; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733384966; x=1764920966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oXKGifZDNTPXMwkxKmhIsPbAT3cxcevpsRdIunfQg4Q=;
  b=q1p4QWr7OCnaOj8WjuER3G93lHLFabglat2G9CAiqWSJiiNVMcnQbNF7
   tJmzxfZZyaQ0VhtiWfD+o8zcrzLez3VAZPh/0evZzQ0SMrMbAig5oJeo0
   rnvQ3iOlff87ZmKDlm3+eNj86iu+8EieIgYRRnBFCJuKKZPn5loO9A3hB
   uOpyoLRx5qtAzWNA6pK+c09Wp+Cndt+WhsuCL7qNGFb8LYgaZeKkPkxcF
   AIHSAGdOOUfaBF788qlk9TEiR4YJMSnAvemvcX6amdwN3pH5r7kh4uKNn
   B3tbtAK/Nja44HblZPM9FmHCLU31E0bQwbGyznHcjslI4IbxwYeKBQixu
   w==;
X-CSE-ConnectionGUID: 4tTk+s1zSoO5VyRNISXJWA==
X-CSE-MsgGUID: PLXJEomQTj6grEF5pWDuQg==
X-IronPort-AV: E=Sophos;i="6.12,209,1728921600"; 
   d="scan'208";a="33626118"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2024 15:49:23 +0800
IronPort-SDR: 67514c5e_/qYJ8XD7Gsh1eaMWkjW6W3FB4w886g2X8VHSs9J4+96IxLy
 84FDI2bvegiqgk3AnlCRNnKJSOOAici5+Apr3Jw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2024 22:46:54 -0800
WDCIronportException: Internal
Received: from naota-x1.dhcp.fujisawa.hgst.com (HELO naota-x1.ad.shared) ([10.89.81.175])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2024 23:49:23 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 09/11] btrfs: tweak extent/chunk allocation for space_info sub-space
Date: Thu,  5 Dec 2024 16:48:25 +0900
Message-ID: <8bc8fa625af5d29a6863e3864d5c8b371f913fdc.1733384172.git.naohiro.aota@wdc.com>
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

Make the extent allocator and the chunk allocator aware of the sub-space.
It now uses SUB_GROUP_DATA_RELOC sub-space for data relocation block group.
And, it needs to check the space_info is the right one when a block group
candidate is given. Also, new block group should now belong to the
specified one.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 3 +++
 fs/btrfs/space-info.c  | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 334a1701ff33..2f32497d2577 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4342,6 +4342,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		btrfs_err(fs_info, "No space info for %llu", ffe_ctl->flags);
 		return -ENOSPC;
 	}
+	if (btrfs_is_zoned(fs_info) && ffe_ctl->for_data_reloc)
+		space_info = space_info->sub_group[SUB_GROUP_DATA_RELOC];
 
 	ret = prepare_allocation(fs_info, ffe_ctl, space_info, ins);
 	if (ret < 0)
@@ -4361,6 +4363,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		 * picked out then we don't care that the block group is cached.
 		 */
 		if (block_group && block_group_bits(block_group, ffe_ctl->flags) &&
+		    block_group->space_info == space_info &&
 		    block_group->cached != BTRFS_CACHE_NO) {
 			down_read(&space_info->groups_sem);
 			if (list_empty(&block_group->list) ||
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 16beb25be4b0..cfc59123b00c 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -337,7 +337,9 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 
 	factor = btrfs_bg_type_to_factor(block_group->flags);
 
-	found = btrfs_find_space_info(info, block_group->flags);
+	found = block_group->space_info;
+	if (!found)
+		found = btrfs_find_space_info(info, block_group->flags);
 	ASSERT(found);
 	spin_lock(&found->lock);
 	found->total_bytes += block_group->length;
-- 
2.47.1


