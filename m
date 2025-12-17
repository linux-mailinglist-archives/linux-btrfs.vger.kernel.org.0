Return-Path: <linux-btrfs+bounces-19840-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B80BCC7F5A
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 14:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A14F3115192
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 13:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D4834AB1E;
	Wed, 17 Dec 2025 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mtrbyYiL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2E53491FB
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765978913; cv=none; b=l4JqnbSHKC7tYXhDm/QFOegEiyjiIVt4184hPTPczsRxv3+xDW9/iQA+BOkDb9YY8UtOzrQDDXq0omucZx5PcffiAbSZl7xpUSO7fttyY3d64PkPgEosm2yxKcEfc/lAX8CdgmUu0kwOB62MFOl3wFediM0HFxwJI1HcqN8zjbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765978913; c=relaxed/simple;
	bh=Q3nsd48XAX84zI68ajT8bNDBCnJ2QylQwneGHGz8PX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rj1eOe6r3LPLSXDl84dM7VTvQ7lb2PKQUsZz+7NdalLModf4xBQ3P6QpRY5B2oIaLJujkcHqdK+QxxHpzJVmg1ByfS+LOKVYpu4Cl0p9k2zk/+OpX9DBpRNYWTNqZsl7+uvYb2TBSf199p02QhImO6umkXYQ/T297gRdXxXzn0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mtrbyYiL; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765978911; x=1797514911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q3nsd48XAX84zI68ajT8bNDBCnJ2QylQwneGHGz8PX4=;
  b=mtrbyYiLyQw8w0fB6sRNB/6pDRV4vgWYX/5cL/ngDvG2xEIlOrMj30CQ
   7bPuDo/kcK+9gCloIX6/bCogqggaej1kGYVlV4pi/ovdeLuevOv+LJqPk
   hC56LMAtmIrAnTqDiAWwsziOpBXBMbW1zQADbrCgAKwVZuj3AqyI8jSFs
   +sPHJLAbMv5g4/LtLMGjLonvLAPaSfddQmk3YrDB1Ja10o4692IjjxjaK
   R8qBU5+pW+/LOwl1becwy/w4AwKjfKU8n2vXcqazxz4X2B1c+/7KG1IwE
   fsN/eypljZLgP4i/+/mMUXFN8ZlUihcqKQWKXXTzyqKCVsul8G61538eJ
   g==;
X-CSE-ConnectionGUID: PkseBIyJQca3xB3gWavHLA==
X-CSE-MsgGUID: CIZOaoo4RB2MMtFcbm3JtA==
X-IronPort-AV: E=Sophos;i="6.21,155,1763395200"; 
   d="scan'208";a="136693801"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2025 21:41:51 +0800
IronPort-SDR: 6942b31f_I5ibzpzkAAlj8hSqHXN54RzHID7BGGHf19Tr0UHU2cngbmC
 p1WgxuLpl6s+uVR2Ex763ogIHvwiqm/BURE+qGw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2025 05:41:51 -0800
WDCIronportException: Internal
Received: from 5cg1443rm2.ad.shared (HELO neo.fritz.box) ([10.224.28.135])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Dec 2025 05:41:50 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 4/4] btrfs: zoned: print block-group type for zoned statistics
Date: Wed, 17 Dec 2025 14:41:39 +0100
Message-ID: <20251217134139.275174-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217134139.275174-1-johannes.thumshirn@wdc.com>
References: <20251217134139.275174-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When printing the zoned statistics, also include the block-group type in
the block-group listing output.

The updated output looks as follows:

 device /dev/vda mounted on /mnt with fstype btrfs
   zoned statistics:
         active block-groups: 9
           reclaimable: 0
           unused: 2
           need reclaim: false
         data relocation block-group: 3221225472
         active zones:
           start: 1073741824, wp: 268419072 used: 268419072, reserved: 0, unusable: 0 (DATA)
           start: 1342177280, wp: 0 used: 0, reserved: 0, unusable: 0 (DATA)
           start: 1610612736, wp: 81920 used: 16384, reserved: 16384, unusable: 49152 (SYSTEM)
           start: 1879048192, wp: 2031616 used: 1458176, reserved: 65536, unusable: 507904 (METADATA)
           start: 2147483648, wp: 268419072 used: 268419072, reserved: 0, unusable: 0 (DATA)
           start: 2415919104, wp: 268419072 used: 268419072, reserved: 0, unusable: 0 (DATA)
           start: 2684354560, wp: 268419072 used: 268419072, reserved: 0, unusable: 0 (DATA)
           start: 2952790016, wp: 65536 used: 65536, reserved: 0, unusable: 0 (DATA)
           start: 3221225472, wp: 0 used: 0, reserved: 0, unusable: 0 (DATA)

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index fa61276058d8..60543cbee6d0 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -3023,6 +3023,7 @@ void btrfs_show_zoned_stats(struct btrfs_fs_info *fs_info, struct seq_file *s)
 		u64 used;
 		u64 reserved;
 		u64 zone_unusable;
+		const char *typestr = btrfs_space_info_type_str(bg->space_info);
 
 		spin_lock(&bg->lock);
 		start = bg->start;
@@ -3033,8 +3034,8 @@ void btrfs_show_zoned_stats(struct btrfs_fs_info *fs_info, struct seq_file *s)
 		spin_unlock(&bg->lock);
 
 		seq_printf(s,
-			   "\t  start: %llu, wp: %llu used: %llu, reserved: %llu, unusable: %llu\n",
-			   start, alloc_offset, used, reserved, zone_unusable);
+			   "\t  start: %llu, wp: %llu used: %llu, reserved: %llu, unusable: %llu (%s)\n",
+			   start, alloc_offset, used, reserved, zone_unusable, typestr);
 	}
 	spin_unlock(&fs_info->zone_active_bgs_lock);
 }
-- 
2.52.0


