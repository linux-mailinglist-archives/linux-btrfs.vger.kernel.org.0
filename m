Return-Path: <linux-btrfs+bounces-19693-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3881CB812E
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 08:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C9D0301D61B
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 07:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9736B30F81A;
	Fri, 12 Dec 2025 07:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="njULPAFc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55E830F545
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 07:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765523428; cv=none; b=mVwgNA7MCkHRa8caRnanYndEYKp0VcDWStSK3AliqMj6GkJepdvLT4YYM8NCg6KtMrt9laoCkzqr8viIfliR7GS3X41Q/IV9fPM6NaYuY/IhKNP1AGPDGoo31TBp2JZTmqhFo7+0zvsCUyAXlzyG0+WQX1i5JetcU8XJoXx+7TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765523428; c=relaxed/simple;
	bh=KC6ePjQQOwur8anDNubLoOZNb0dHWlC/8VTYyUYwRMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbOCw7nl5fs5rp9GA4i7RRlSa/HlSXZIYXLZ1bzNEPYbJwZlSw2j2h9PZwXIW1aIO03fu+MMSicgHgg5N7joQKbClrL25jeUx9QiTbQHzzJaDQVRspOCj+lL+YAnd2+lS65cLKCtiNFSpYtFSZfwvkjOGds2QM5nAWDWzjFdxb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=njULPAFc; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765523425; x=1797059425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KC6ePjQQOwur8anDNubLoOZNb0dHWlC/8VTYyUYwRMQ=;
  b=njULPAFcLNEyZmR8v8Cc7UP920J2A2YEPahTF4vrT8F2j04dL/TCu2KH
   w2nc5sWWqfkAooE/kYwZaZJGWn5oH/eIIOkdjW4kHmdA81IpdYrnJUxjo
   im6mPXZzRFsvImtoXmb/mzZ+r0ESTPozG/LEkcdqdRM62C7cqGybC15Q9
   emP7CSu3EfESpqo/Qvwoj+SLH0CF2k/VJYlX5aLku4qTGR9d6dOSqrwy6
   SNOvAnlQHsBYakN9zo0CJNHpDAlIHcZHhnyeSF+Kw0gg05DsQJ68ABnyM
   /JoqPKMatKrd7+O/jcFYpgIXissuGsPX4rHzEiRuDrO1g6wiKF9EDcGUr
   g==;
X-CSE-ConnectionGUID: uvOUKqTaTpOmpA7VjPumxw==
X-CSE-MsgGUID: RwPlZM7pTNyxWz5oBwZcgw==
X-IronPort-AV: E=Sophos;i="6.21,143,1763395200"; 
   d="scan'208";a="136927280"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2025 15:10:25 +0800
IronPort-SDR: 693bbfe1_xzcmTEsdcd+K/O7QVyBdgvAGH35uhgOei2ieam6eV4u0syO
 5DOqcj1aQHLeveQhCeoHisSkqA/gzdLilPoIX+g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2025 23:10:26 -0800
WDCIronportException: Internal
Received: from 5cg1430htq.ad.shared (HELO neo.wdc.com) ([10.224.28.119])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Dec 2025 23:10:21 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 4/4] btrfs: zoned: also print stats for reclaimable zones
Date: Fri, 12 Dec 2025 08:10:00 +0100
Message-ID: <20251212071000.135950-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251212071000.135950-1-johannes.thumshirn@wdc.com>
References: <20251212071000.135950-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the zoned stats are confined to the filesystems active zones
and not to the reclaimable zones.

Also print the zone information for the reclaimable zones.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 63588f445268..b3e523e6d6fd 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2988,6 +2988,7 @@ int btrfs_reset_unused_block_groups(struct btrfs_space_info *space_info, u64 num
 void btrfs_show_zoned_stats(struct btrfs_fs_info *fs_info, struct seq_file *s)
 {
 	struct btrfs_block_group *bg;
+	size_t reclaimable;
 
 	seq_puts(s, "\n");
 
@@ -2998,8 +2999,8 @@ void btrfs_show_zoned_stats(struct btrfs_fs_info *fs_info, struct seq_file *s)
 
 	mutex_lock(&fs_info->reclaim_bgs_lock);
 	spin_lock(&fs_info->unused_bgs_lock);
-	seq_printf(s, "\t  reclaimable: %zu\n",
-			     list_count_nodes(&fs_info->reclaim_bgs));
+	reclaimable = list_count_nodes(&fs_info->reclaim_bgs);
+	seq_printf(s, "\t  reclaimable: %zu\n", reclaimable);
 	seq_printf(s, "\t  unused: %zu\n", list_count_nodes(&fs_info->unused_bgs));
 	spin_unlock(&fs_info->unused_bgs_lock);
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
@@ -3023,4 +3024,18 @@ void btrfs_show_zoned_stats(struct btrfs_fs_info *fs_info, struct seq_file *s)
 			   bg->zone_unusable, btrfs_space_info_type_str(bg->space_info));
 	}
 	spin_unlock(&fs_info->zone_active_bgs_lock);
+
+	if (reclaimable) {
+		seq_puts(s, "\treclaimable zones:\n");
+		mutex_lock(&fs_info->reclaim_bgs_lock);
+		spin_lock(&fs_info->unused_bgs_lock);
+		list_for_each_entry(bg, &fs_info->reclaim_bgs, list) {
+			seq_printf(s,
+					"\t    start: %llu, wp: %llu used: %llu, reserved: %llu, unusable: %llu (%s)\n",
+					bg->start, bg->alloc_offset, bg->used, bg->reserved,
+					bg->zone_unusable, btrfs_space_info_type_str(bg->space_info));
+		}
+		spin_unlock(&fs_info->unused_bgs_lock);
+		mutex_unlock(&fs_info->reclaim_bgs_lock);
+	}
 }
-- 
2.52.0


