Return-Path: <linux-btrfs+bounces-11559-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91FAA3B2EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 08:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246191886CD8
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 07:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D4D1C6FE3;
	Wed, 19 Feb 2025 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VyMwiYlo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBC51C54A5
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951906; cv=none; b=p9CJyYL5EW3MQnKlIxoak0RfyEmN9IPP190uJJq2lYqZ1mpwlHgJNWVNCuphPkIrIGuV7Aq9dwiED7eXA13jHoGAOoh8GmJHm4zT6pCJfXsrQyeZYztkbwj5onIod3KaXIUVqH/BSjqj2PzgtiHOAlTBfBjHEvfIJH4B7d9RhkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951906; c=relaxed/simple;
	bh=5u8ScMQqwj3zbKZ4tGZAkxHjJl4hMxRUyCQc4ft3HD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhkY8UKMzul2AuxwpDhSRVRyuLqiso+1Q4+C2zODhthbQrmL0PMpknb8szVAAONEZzTC6bP0Olx9vUdlBhpgVwSA4n+gs5tSCXwATENTTvG/XzUygjvbqDMHYdlSA04EI0tFfrcmsuuIfu3msDhRY3WHEViH1i/k+VkLh1qK+3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VyMwiYlo; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739951905; x=1771487905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5u8ScMQqwj3zbKZ4tGZAkxHjJl4hMxRUyCQc4ft3HD0=;
  b=VyMwiYloTsT17F6FGIFJOKUJEZjzUzBgA1ISA/u1TsiVDDty8bDocGzx
   EUYbaHlBwO3/eK9Z2NjJD8ZCcI9wsVM3wvrvRxixqIOfJhl/EM8La0Wrd
   n31Xsc1j4QJCraIKo6HRKCQJxIOqlpX6bJePk0KQcSS5dw6c8xGy0+x/F
   PCNhI90WjiiQ/gSD7+Vg1uo591QP9snBoQ/7FvuTI+tuEk5mk8XMyN/VV
   W4kexzHwhEi9z5/aQFf/8TqdEdxU0d8Fzz0MyO6Ae0v3HDjI0CV5OXyKs
   kLYa+iFXN00X2PN4dSE7avvn4rR1uHPFf9bzILUwH+gJCW9263EPmssNn
   Q==;
X-CSE-ConnectionGUID: x22sfK1pQuSwnViSYLAqlw==
X-CSE-MsgGUID: 8GQJgHvRTCCZdWaztuP96Q==
X-IronPort-AV: E=Sophos;i="6.13,298,1732550400"; 
   d="scan'208";a="38310818"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2025 15:58:12 +0800
IronPort-SDR: 67b58159_nt2sGs7w/o4G+Q/A6CD6VHWLZMYqTkD5eMwofMvjoSkuwhC
 PNlyjwRUBfBLPQCzAHnHW7p7NiFrE+mLe8MGNUQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Feb 2025 22:59:37 -0800
WDCIronportException: Internal
Received: from 5cg20343qs.ad.shared (HELO naota-xeon..) ([10.224.109.7])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Feb 2025 23:58:11 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 11/12] btrfs-progs: implement RAID10 zone info loading
Date: Wed, 19 Feb 2025 16:57:55 +0900
Message-ID: <6c6dbc1e3396ac30723de8b74e40aa4fe9a59a1a.1739951758.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739951758.git.naohiro.aota@wdc.com>
References: <cover.1739951758.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just same as the kernel side.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/zoned.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 10e59b837efd..484bade1d2ed 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -1092,6 +1092,39 @@ static int btrfs_load_block_group_raid0(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+static int btrfs_load_block_group_raid10(struct btrfs_fs_info *fs_info,
+					 struct btrfs_block_group *bg,
+					 struct map_lookup *map,
+					 struct zone_info *zone_info,
+					 unsigned long *active)
+{
+	if ((map->type & BTRFS_BLOCK_GROUP_DATA) && !fs_info->stripe_root) {
+		btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
+			  btrfs_bg_type_to_raid_name(map->type));
+		return -EINVAL;
+	}
+
+	for (int i = 0; i < map->num_stripes; i++) {
+		if (zone_info[i].alloc_offset == WP_MISSING_DEV ||
+		    zone_info[i].alloc_offset == WP_CONVENTIONAL)
+			continue;
+
+		if (test_bit(0, active) != test_bit(i, active)) {
+			return -EIO;
+		} else {
+			if (test_bit(0, active))
+				bg->zone_is_active = 1;
+		}
+
+		if ((i % map->sub_stripes) == 0) {
+			bg->zone_capacity += zone_info[i].capacity;
+			bg->alloc_offset += zone_info[i].alloc_offset;
+		}
+	}
+
+	return 0;
+}
+
 int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 				     struct btrfs_block_group *cache)
 {
@@ -1192,8 +1225,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 		ret = btrfs_load_block_group_raid0(fs_info, cache, map, zone_info, active);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID10:
-		/* Temporarily fails these case, until following commits. */
-		fallthrough;
+		ret = btrfs_load_block_group_raid10(fs_info, cache, map, zone_info, active);
+		break;
 	case BTRFS_BLOCK_GROUP_RAID5:
 	case BTRFS_BLOCK_GROUP_RAID6:
 	default:
-- 
2.48.1


