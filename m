Return-Path: <linux-btrfs+bounces-19742-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC10CBD632
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 11:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41555300E02E
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 10:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA91B3164D8;
	Mon, 15 Dec 2025 10:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gFgpepEk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6EA3164DB
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765795191; cv=none; b=LFcZZDUB/3PIKn18okmAlsHv+mMo1oupJWhmwRgfHeCHFM/4YeZ4p9+LIT+jGBapHOrpHTR0AFs3jemauyg7lLuYcRgmL6S7ePoiGSW+ittzHeCZCuXz61lkXFA5Il35GCrHVvyhDOt8bXbCMwluy+m6kDrN8GfOb8DNatHgffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765795191; c=relaxed/simple;
	bh=WJY69FlQKW7A7Pkne7m64bDzpumnJJcLjR+pp7u+16Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XqaOoBxvmcjl97xD6xTQqId4vUW+DWZOLNnsEqW421RUwqlWEnGGPz2WxW/JV4TKpcXFbs5BLdzr5qe8pmh3KSBYOJglTnuDcAUAmk6m4P2UoKRPlCtGYnKXq9jLQ9WvQWHoMFSVpEGzO28D4Oknnddnmo9s8YGvUk7VCEyfw3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gFgpepEk; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765795188; x=1797331188;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WJY69FlQKW7A7Pkne7m64bDzpumnJJcLjR+pp7u+16Q=;
  b=gFgpepEk0QybVKVfvGEKzShEeQV+j/jpiXRfCMUL6fCu5tZGcsMioA8x
   Y3YTRxLYAZ9sttVqXfhjq0Bl01zFqf+dE2bU/mAFEEncmlSyleA71+Wo6
   jzahcCj0Feal452diW/+vc82Gum0ba6PTuUxkYUgFNjtcaggA8sZBZEyw
   TWVggPUpL+jPZBCEzeKVrz5npasPnMAFf1DYxHMUrbh5qDdKGw6YKZK0h
   nxOuClCemPFVKoHY85VTIko5EVL0+RubrZNg9J1otrwH/iVX5EouFYfvQ
   85VkBoJ1gobUs22xkIekevhJLXXgauNM9xh8tevgnvgQYXZSIIVz5nW1d
   w==;
X-CSE-ConnectionGUID: Q5xzFVrzQZSBBK7DnwRgLQ==
X-CSE-MsgGUID: pKlWH/pWTM2+Qat6UHO+Hw==
X-IronPort-AV: E=Sophos;i="6.21,150,1763395200"; 
   d="scan'208";a="137087618"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2025 18:39:41 +0800
IronPort-SDR: 693fe56e_naubvbzbKsnq9HcalDkqBfgmD0kWA0MxQvvchyhi7g2ABCz
 mWFDsEFb4JoxWzWqLwHjy5/X1smSrV6G1HvxUiA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2025 02:39:43 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.124])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Dec 2025 02:38:36 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: zoned: re-flow prepare_allocation_zoned
Date: Mon, 15 Dec 2025 11:38:18 +0100
Message-ID: <20251215103818.39805-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Re-flow prepare allocation zoned to make it a bit more readable by
returning early and removing unnecessary indentations.

This patch does not change any functionality.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent-tree.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 04a266bb189b..726aa30642c4 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4288,36 +4288,43 @@ static int prepare_allocation_zoned(struct btrfs_fs_info *fs_info,
 				    struct find_free_extent_ctl *ffe_ctl,
 				    struct btrfs_space_info *space_info)
 {
+	struct btrfs_block_group *block_group;
+
 	if (ffe_ctl->for_treelog) {
 		spin_lock(&fs_info->treelog_bg_lock);
 		if (fs_info->treelog_bg)
 			ffe_ctl->hint_byte = fs_info->treelog_bg;
 		spin_unlock(&fs_info->treelog_bg_lock);
-	} else if (ffe_ctl->for_data_reloc) {
+		return 0;
+	}
+
+	if (ffe_ctl->for_data_reloc) {
 		spin_lock(&fs_info->relocation_bg_lock);
 		if (fs_info->data_reloc_bg)
 			ffe_ctl->hint_byte = fs_info->data_reloc_bg;
 		spin_unlock(&fs_info->relocation_bg_lock);
-	} else if (ffe_ctl->flags & BTRFS_BLOCK_GROUP_DATA) {
-		struct btrfs_block_group *block_group;
+		return 0;
+	}
 
-		spin_lock(&fs_info->zone_active_bgs_lock);
-		list_for_each_entry(block_group, &fs_info->zone_active_bgs, active_bg_list) {
-			/*
-			 * No lock is OK here because avail is monotonically
-			 * decreasing, and this is just a hint.
-			 */
-			u64 avail = block_group->zone_capacity - block_group->alloc_offset;
+	if (!(ffe_ctl->flags & BTRFS_BLOCK_GROUP_DATA))
+		return 0;
 
-			if (block_group_bits(block_group, ffe_ctl->flags) &&
-			    block_group->space_info == space_info &&
-			    avail >= ffe_ctl->num_bytes) {
-				ffe_ctl->hint_byte = block_group->start;
-				break;
-			}
+	spin_lock(&fs_info->zone_active_bgs_lock);
+	list_for_each_entry(block_group, &fs_info->zone_active_bgs, active_bg_list) {
+		/*
+		 * No lock is OK here because avail is monotonically
+		 * decreasing, and this is just a hint.
+		 */
+		u64 avail = block_group->zone_capacity - block_group->alloc_offset;
+
+		if (block_group_bits(block_group, ffe_ctl->flags) &&
+				block_group->space_info == space_info &&
+				avail >= ffe_ctl->num_bytes) {
+			ffe_ctl->hint_byte = block_group->start;
+			break;
 		}
-		spin_unlock(&fs_info->zone_active_bgs_lock);
 	}
+	spin_unlock(&fs_info->zone_active_bgs_lock);
 
 	return 0;
 }
-- 
2.52.0


