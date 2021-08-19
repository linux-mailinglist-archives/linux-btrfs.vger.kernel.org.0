Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDCD3F1920
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 14:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbhHSM1t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 08:27:49 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46871 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhHSM1s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629376031; x=1660912031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9ygmk8frqqRLA+R0ay5h/OXXHb75Rhv1gfiXwm49eok=;
  b=k80kRhvFZMC4f129FHjemA05Rgn67zmzmnmjMRsWn0wnnf7llGKbNL+S
   YJ/b+9yumh44GE03oKs2/ZCjOVL0XRngcqmfiV3LuSwWYLFjcnATyIW3Q
   i9FhS4jO4KlL+OBRgV9k/pfT0iYQNaWCNbhwCsyzbchHYzRsOW2+trBy2
   5flKY457nRVsIkrLsgF95+kaHCu7L86lMcP4S/4z1dvDRIxRpeRWXJ0F2
   10RmPd893Js+rLTYKWzGnszZB7zr440vV+33sEYhdGU9a0chmPadOyrU7
   d5gQGaoC4tWVpki3luOHVmymNw4HSZB1XE8Kk7D2XiCIbV3krl8rn9N4Y
   w==;
X-IronPort-AV: E=Sophos;i="5.84,334,1620662400"; 
   d="scan'208";a="177773545"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2021 20:27:12 +0800
IronPort-SDR: MzHXS4qZRjUUX47jalDoRIiA3slKyE7vd8F6ey1V29XrIxGJ+6wwymWzVdKk+K48PY60506Min
 mQJfbLdXISEz0UJx95QgzlVSCm/+8FS37BEAF0d9eqvJFJhcltTQIdQui4XQCuXcn+1lX5ns5u
 3Kfc/LJMeTSZ7TzaFhWSWm+DE/SCqWdf0Zs8yM3hJmG442rVPCfVZETs0ns2gLc+Uxzm0ReDP0
 qtTIPZ7TxoEAWMZmk5Vg8qiONl8lf9cQOjvwXVJNtf6lZXAxhR9DEpkIV7yDZ1gxa+0FqLM3AF
 EY1dNOKQrvj4GwF4EhZf+KOQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 05:04:19 -0700
IronPort-SDR: iJ0EfRfsn9R4+omtMG7bEOb0TBxQaCyU0/rzpKy1OXVVTwAYlwUq4wBYxbNHzIQFVWjS9X6VMk
 8sFRZgY9Z7bjASP18i9WrPjWc7gMLciaOINKhteuj6/tvmUbc6N+E4Zj+95huDqurs6ilQn1o0
 ht6h9gjlcOmSvCmkvSMrB2DEJ+lrH/8wnHINfYhHeNOBqPPrqG7at2VE8DyHtDzC11tuwx3+p4
 hcDF23vfnVJjT4iI59icddAHJyx04krmOMq9LxYPsHSSxWSkM2FYwZOZSlaSkJjR8IPz+L5Yk5
 zRg=
WDCIronportException: Internal
Received: from gkg9hr2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.52.110])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2021 05:27:11 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 04/17] btrfs: zoned: tweak reclaim threshold for zone capacity
Date:   Thu, 19 Aug 2021 21:19:11 +0900
Message-Id: <7af8015000f794f3481a2a36a25391dea0d8124f.1629349224.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1629349224.git.naohiro.aota@wdc.com>
References: <cover.1629349224.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the introduction of zone capacity, bytes [capacity, length] are always
zone unusable. Counting this region as a reclaim target will cause
reclaiming too early. Reclaim block groups based on bytes that can be
usable after resetting.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/free-space-cache.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index bb2536c745cd..772485c39e45 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2540,6 +2540,7 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 	u64 to_free, to_unusable;
 	const int bg_reclaim_threshold = READ_ONCE(fs_info->bg_reclaim_threshold);
 	bool initial = (size == block_group->length);
+	u64 reclaimable_unusable;
 
 	WARN_ON(!initial && offset + size > block_group->zone_capacity);
 
@@ -2570,12 +2571,15 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 		spin_unlock(&block_group->lock);
 	}
 
+	reclaimable_unusable = block_group->zone_unusable -
+		(block_group->length - block_group->zone_capacity);
 	/* All the region is now unusable. Mark it as unused and reclaim */
 	if (block_group->zone_unusable == block_group->length) {
 		btrfs_mark_bg_unused(block_group);
 	} else if (bg_reclaim_threshold &&
-		   block_group->zone_unusable >=
-		   div_factor_fine(block_group->length, bg_reclaim_threshold)) {
+		   reclaimable_unusable >=
+		   div_factor_fine(block_group->zone_capacity,
+				   bg_reclaim_threshold)) {
 		btrfs_mark_bg_to_reclaim(block_group);
 	}
 
-- 
2.33.0

