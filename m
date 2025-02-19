Return-Path: <linux-btrfs+bounces-11558-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D8AA3B2EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 08:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69EB83B2089
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 07:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504131C5D6F;
	Wed, 19 Feb 2025 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Nfx3T6Gv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A371C3C12
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951905; cv=none; b=tTXxNxF8NErM2Fb/qQ3gJxd6h74FkotK3I+8TveciA26PGkh1MZw9vrX9HCEbIpZ7ym67DCpA8V831GZCWlQKvNXuEJbyUl7QvVOvsGfreufbD2K6JJl7hpzCbR6GY3XU6qVWHjSN1gUFFwmk8FCKYTV0CwbaKct/SjX4zSroHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951905; c=relaxed/simple;
	bh=9ZCYiRJ9PFdL67rXBN3m5N7l9Wz7CJZZ76R7QtZnCJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftacvkm4lT9hzy4g+HrEwZKTFWQ13nZ8LMNz4zHuXTILkIjx5bNjbPlFryk4wFpIbT9GNnon//QcNXCvqgHcHM6OQOXtXCS/5kxoejn8hKni1MmuR5GRcHQ8+nYBr+SQi+ZCGQAunBm9JwIDnNlzBoJ8+aqvk0x7uPgdKu6A3io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Nfx3T6Gv; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739951900; x=1771487900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9ZCYiRJ9PFdL67rXBN3m5N7l9Wz7CJZZ76R7QtZnCJk=;
  b=Nfx3T6GvZ7oyhqwUGmUsWpMNMk1sw5yy+FjiqEitK7drMwSoIhyvvLs9
   z8/CTVYSK7Q0YFonpVE1Wj0SpEajRfZQQI+64wEybHtKzYrbQkRQHCTie
   0vDy8Mb1XAU2ASZRkYBJXgJ8MEybnUdWMq+s/2jHorVam8Bcym/hTCerj
   RUW6n8QiIOCh9WdHLzKmX0LyMLRvY842jcn18wq/LqMGoXLSa3/Xlvq2b
   t7S5HI4EAQJze2R6O0CIS/HJdZUxgRPbewy3foKzYXoG3qpJoWsJakGLl
   wQFX6VfclTwtLoJ4fDQAVm1jTWSsSouL/+SzsPE3fwpiN7YJeh6MtvkfH
   A==;
X-CSE-ConnectionGUID: 1eL6fzhZRMe8TpXe20/frg==
X-CSE-MsgGUID: G8KkHyzQSQaputxAUTI2GA==
X-IronPort-AV: E=Sophos;i="6.13,298,1732550400"; 
   d="scan'208";a="38310813"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2025 15:58:10 +0800
IronPort-SDR: 67b58157_5VDVOYMGIM170JrgdSl1zovF6nFaQNKuvaT6HGn4UVMUk71
 I4+X0MZ1qHaDvhokA16h5GnCIuMW9y50dOB3DIQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Feb 2025 22:59:35 -0800
WDCIronportException: Internal
Received: from 5cg20343qs.ad.shared (HELO naota-xeon..) ([10.224.109.7])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Feb 2025 23:58:09 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 08/12] btrfs-progs: zoned: implement DUP zone info loading
Date: Wed, 19 Feb 2025 16:57:52 +0900
Message-ID: <927039bcd75a21e173f732929dc883fd010ab456.1739951758.git.naohiro.aota@wdc.com>
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

DUP support is added like the kernel side.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/zoned.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index e3240714b415..f0a44587679b 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -977,6 +977,46 @@ static int btrfs_load_block_group_single(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+static int btrfs_load_block_group_dup(struct btrfs_fs_info *fs_info,
+				      struct btrfs_block_group *bg,
+				      struct map_lookup *map,
+				      struct zone_info *zone_info,
+				      unsigned long *active)
+{
+	if ((map->type & BTRFS_BLOCK_GROUP_DATA) && !fs_info->stripe_root) {
+		btrfs_err(fs_info, "zoned: data DUP profile needs raid-stripe-tree");
+		return -EINVAL;
+	}
+
+	bg->zone_capacity = min_not_zero(zone_info[0].capacity, zone_info[1].capacity);
+
+	if (zone_info[0].alloc_offset == WP_MISSING_DEV) {
+		btrfs_err(fs_info,
+			  "zoned: cannot recover write pointer for zone %llu",
+			  zone_info[0].physical);
+		return -EIO;
+	}
+	if (zone_info[1].alloc_offset == WP_MISSING_DEV) {
+		btrfs_err(fs_info,
+			  "zoned: cannot recover write pointer for zone %llu",
+			  zone_info[1].physical);
+		return -EIO;
+	}
+	if (zone_info[0].alloc_offset != zone_info[1].alloc_offset) {
+		btrfs_err(fs_info,
+			  "zoned: write pointer offset mismatch of zones in DUP profile");
+		return -EIO;
+	}
+
+	if (test_bit(0, active) != test_bit(1, active)) {
+		return -EIO;
+	} else if (test_bit(0, active)) {
+		bg->zone_is_active = 1;
+	}
+
+	bg->alloc_offset = zone_info[0].alloc_offset;
+	return 0;
+}
 
 int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 				     struct btrfs_block_group *cache)
@@ -1067,6 +1107,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 		ret = btrfs_load_block_group_single(fs_info, cache, &zone_info[0], active);
 		break;
 	case BTRFS_BLOCK_GROUP_DUP:
+		ret = btrfs_load_block_group_dup(fs_info, cache, map, zone_info, active);
+		break;
 	case BTRFS_BLOCK_GROUP_RAID1:
 	case BTRFS_BLOCK_GROUP_RAID1C3:
 	case BTRFS_BLOCK_GROUP_RAID1C4:
-- 
2.48.1


