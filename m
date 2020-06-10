Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3F81F54E3
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 14:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgFJMdZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 08:33:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12377 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbgFJMdW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 08:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591792401; x=1623328401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EhNkqgJ46efGnAO7HtDNZHOEZXR0Z++zoyYswjc/ojo=;
  b=MmH+pGxI4v6l7O/CYwWtmOLz7dUOXgHyDwd8wWe5R71fEoMhvKwdZHzV
   CNyhtJBjcIjlneoqCMX9vghY7t4rS89znTffWVR4N/jMpGEzlbaqprObP
   K8k35MSRSpfPeUSBPkVbVK7lJylzcAMQd8f41ax0Z30yd/CFEMb6ZiaD2
   49jAy5bjSGyDpvIY2bmc8vPoC1qHmgEUAtIBtO2nD31Ym1PMOcV9l9u0O
   tOq4OvKK3X5u8wXVOdIrRiP6p+kv6h3zvk3iWSIEJ67kq3fj/S/HSbtIS
   9iaPpZqTqlxgJ3IiYnKXU6n9KegTGktcGjB/cthITuPBxJ3XTznrMKM65
   A==;
IronPort-SDR: mZD2SAlArANxUZ4lg4bfYd5VFy8OxtgGWGI62p25/r/6Th7RD5+avQb+s9r/3Jo43v4YMk2G+V
 VJeA46Uq9kOINc8bKkRhPv7N30fgLEAxk38159FMKI2k2euAryN4GPwYXTvPzlXSwmzQRKYTNr
 8NF1jp+5uOL+Tbuwo6iuYbcYR020KqGF/OuADlwmM+28gN4vlwXMDFb4lONmt7Lt6TptAp9RO/
 k8/Ppul0DNjk2MgTDuW7xG7k3v+pNH7CUGoNTIKWjOmx6Pxh/cuy6/wZbeBpoiOfydQBRFhuGY
 7mk=
X-IronPort-AV: E=Sophos;i="5.73,496,1583164800"; 
   d="scan'208";a="139632687"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2020 20:33:06 +0800
IronPort-SDR: 8veiBgNbGOdFnJYlvc/qYINC2pZaXlUSoYYVIHup7kzazk7fyuAT6WAQpUsp2zyL9qdPvtzqh9
 HmrdiZKKroRNYWuscBDs8TDUsGAAnrKBo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 05:22:32 -0700
IronPort-SDR: ayNCbeJ9OfHyM056KApBvMhh5r7B0R1RBYROPCEJzPJucH6/1VFByfMWLT4WyJW8BgzRS2vF5p
 7TkWYLm9dRVg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jun 2020 05:33:05 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 02/15] btrfs-progs: simplify assignment of number of RAID stripes
Date:   Wed, 10 Jun 2020 21:32:45 +0900
Message-Id: <20200610123258.12382-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
References: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Simplify the assignment of the used number of RAID stripes in chunk
allocation.

For RAID Levels 0, 5, 6 and 10 we first assigned it to the number of
devices in the file-system and afterwards capped it to the upper bound of
max_stripes. We can just use the max() macro for this.

This will help in furhter refactorings.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 volumes.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/volumes.c b/volumes.c
index 089363f66473..2a33dc09d7e7 100644
--- a/volumes.c
+++ b/volumes.c
@@ -1079,16 +1079,14 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		min_stripes = 2;
 	}
 	if (type & (BTRFS_BLOCK_GROUP_RAID0)) {
-		num_stripes = btrfs_super_num_devices(info->super_copy);
-		if (num_stripes > max_stripes)
-			num_stripes = max_stripes;
+		num_stripes = min_t(u64, max_stripes,
+				    btrfs_super_num_devices(info->super_copy));
 		min_stripes = 2;
 	}
 	if (type & (BTRFS_BLOCK_GROUP_RAID10)) {
 		min_stripes = 4;
-		num_stripes = btrfs_super_num_devices(info->super_copy);
-		if (num_stripes > max_stripes)
-			num_stripes = max_stripes;
+		num_stripes = min_t(u64, max_stripes,
+				    btrfs_super_num_devices(info->super_copy));
 		if (num_stripes < min_stripes)
 			return -ENOSPC;
 		num_stripes &= ~(u32)1;
@@ -1096,9 +1094,8 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	}
 	if (type & (BTRFS_BLOCK_GROUP_RAID5)) {
 		min_stripes = 2;
-		num_stripes = btrfs_super_num_devices(info->super_copy);
-		if (num_stripes > max_stripes)
-			num_stripes = max_stripes;
+		num_stripes = min_t(u64, max_stripes,
+				    btrfs_super_num_devices(info->super_copy));
 		if (num_stripes < min_stripes)
 			return -ENOSPC;
 		stripe_len = find_raid56_stripe_len(num_stripes - 1,
@@ -1106,9 +1103,8 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	}
 	if (type & (BTRFS_BLOCK_GROUP_RAID6)) {
 		min_stripes = 3;
-		num_stripes = btrfs_super_num_devices(info->super_copy);
-		if (num_stripes > max_stripes)
-			num_stripes = max_stripes;
+		num_stripes = min_t(u64, max_stripes,
+				    btrfs_super_num_devices(info->super_copy));
 		if (num_stripes < min_stripes)
 			return -ENOSPC;
 		stripe_len = find_raid56_stripe_len(num_stripes - 2,
-- 
2.26.2

