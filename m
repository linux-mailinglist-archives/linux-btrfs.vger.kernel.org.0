Return-Path: <linux-btrfs+bounces-19750-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0780CBEE79
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 17:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88F1C3050F74
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 16:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B58A30FC1F;
	Mon, 15 Dec 2025 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TeH3Q+Xy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AD730FF1D
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765815879; cv=none; b=AH29yOyO8ecUql25gbZVULo7EojQv53tVia4tu5ACUV3IdmsOzu8E1zqVypFRlVq7pQlvo2rftRLsyk11aHSaN/dDP4Nd9i1KhC+wShkQfZdqLMN/ZinQxvYUPKgMbuMSCGgnohbvmxH8epvddy/4XuR+zUWJpVHJoQJ4kqtiZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765815879; c=relaxed/simple;
	bh=bUt68zIj4gWMRPWlS+6snZGubMzUnKs5q3+ZVXyFZTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=md9ojS+Wpjyht6lZpUBdB7EF8oel47HHvSSpxkWFsSxL3ixhxCQG3WST3VS4271qgFpY/vBU23RRZMiwX5XxyXmkhTzkpAv6ZVI80HV+kGq6rWO9FuHez3ZwsXcybDn90uB9BKcPsIMjTQFFkHNrNbzQlhARRPSe1TLSw0NuTJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TeH3Q+Xy; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765815878; x=1797351878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bUt68zIj4gWMRPWlS+6snZGubMzUnKs5q3+ZVXyFZTA=;
  b=TeH3Q+Xy3DTEhPPzFXnYr1ct/VMa2Su9Npnyg7xwv9L7i3hZlu9Rflrj
   AbUud9R6JKW18d0C7mKxaGcOpeEK2naa1w664FQD8SZtPkReTZL8oDaPD
   +mpaYs+rxFSm/hf+I2YmJBCZXVEWAoNvsAIDwO+xDTcmB2ZgXkeeLToI3
   D3qS5H6hLWPYw10P5hbAWRsyh2rimq2j6Zg/KBU/Oagitxo4KuQZB+CLk
   rs/NSG6/r+hsnr2QxEl/ksekbmwuBsnjQ/TjulIHNjNwEPsD3bMLc+LXv
   1HiB7Tb5NHdh3lqpiy4UYjL2NS7K1BlQdwHD4eEimJUHP6WOVlRoTQOOC
   g==;
X-CSE-ConnectionGUID: d6Ek6SzNRrmXehgz4WUkuA==
X-CSE-MsgGUID: mW/v7zShRMaOVwzxgXkqtw==
X-IronPort-AV: E=Sophos;i="6.21,151,1763395200"; 
   d="scan'208";a="137916737"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Dec 2025 00:24:36 +0800
IronPort-SDR: 69403643_9rL+QgfqfGlYJnmQY0uxNACr43XWpvcQAQCy7ARFbAiqrd2
 ZJ7RQXWVf47Lj5rbzDZIFeuWsYzCIueutJaASHQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2025 08:24:36 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.125])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Dec 2025 08:24:33 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 3/3] btrfs: zoned: print block-group type for zoned statistics
Date: Mon, 15 Dec 2025 17:24:20 +0100
Message-ID: <20251215162420.238275-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215162420.238275-1-johannes.thumshirn@wdc.com>
References: <20251215162420.238275-1-johannes.thumshirn@wdc.com>
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
index 6125df428568..2aa3fa3cef2c 100644
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


