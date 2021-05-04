Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A4E372745
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 May 2021 10:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhEDIcg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 May 2021 04:32:36 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:37723 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhEDIce (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 May 2021 04:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620117100; x=1651653100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a7XdCwomArwNPXdM3EViH5UWqoR4yXld9K4+2ErhB0U=;
  b=ctLJZRxvibOy4bKm6YrqA1SLl3+DVt4/iGqNleHJkMLX7tQiXubw/K6A
   PPeSMAmxTfI+uRoBgm8qpaP/hjgZ5rCEXbWcomkEbBqkRYESHHz1zGyKx
   CiJ55dVj8cm/w33yCXuIArRo7jTN9EXb8FWo9O0XBZzZSK3kBDjvjZn53
   RNfYCnDHlhO91QD6Yk9peLiHLhO/uAX6/ftSISJ50cRaeycQH3H0CvyRj
   WvdGQjp+UlP+aAUMJBUh3RQVrQyPx5+GJ35GAeFZaGe74y3g4PAvcEDea
   eYvgk9BQh+QFuuQ4GqT0cAZOvu9z3HKfwC4n4vtOl2XtTzBh/mLQnOAY/
   g==;
IronPort-SDR: 9p6UvDwWZykkqmCydOoLzB49qfQGOFCP3G4yfbZivtFT/Us5GF19EbtwY0pjFd2Ha5jCie8tGx
 rVfnkOWXcrhtKHcN0uW0msEGn3VQPknUpbot1gBvb3Bm2CPJnLaz0jiHSY/DwADq3IO3YsfPqD
 /oFTXR3o8Rdr7AiwFlx/FgpDe6ukAIttud2lqVl005JxSHXo+j+lAVJPW90dp3KvyAgIo8wuvD
 DNqe0Xti8VkMsNP65kReyKQNJ+H/69S84hF1rOHeKvqKPukCgr7OkCjlNddtmXDA2RMOC9zNH5
 b8I=
X-IronPort-AV: E=Sophos;i="5.82,271,1613404800"; 
   d="scan'208";a="167614002"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2021 16:31:39 +0800
IronPort-SDR: 0LQl5PMGwxRcwElyVJYMJWiYGVMP8ABhxm5MQKLDGNtRATDnPtO5Lt/jsL5M3w/QlXUtuu6WsX
 uc0lOllRAL3KCyJJXttfGv6VDao6R716y+iKhgwSsiYonWK/wLVuDKY6xHDy/USnNtv68mfmaK
 v3QCWzxw/dRnLmbM6E/JVl1xUjz1lfV8vg9RmtoUCcaGJcooekLvl5AqJxDsFKpFiCMkrGjhcl
 ZGA8x4HnT/XudeSjJxkQGpHb6THYQeRLxXpgMpIr3OV0eO1PUGXHoV0XDIgVHmDe1uv+w9DagM
 rjSnxvdKmM++uhbNakpQbHWP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 01:10:21 -0700
IronPort-SDR: KwL38rWRol577bpjf4JMPSSCXcjuVixN7hDQx2tshqyqEJpO/Plol7qjAz0xr29rcWO8Ic9ymi
 lVAwp05qIPZCp9jcLHsfaCi0XxmYVM7bJq4IyZNzGlSssAjg3j3cvgUN6e5G5HoJLiz+tOP6Mm
 0DflpTH47gBJVhmsTSWapyee9GXlQdwOs2qp6nhlL1Er4sG7r1p0qiK4ssfJZVWcFRejcKeSuj
 aCci332KGjehnyiejwlFhEoCFKb7vGXDkHAL4LrwazT0kiVl01a0mV9SGZ6AUXu9n1S87CMLp6
 fiQ=
WDCIronportException: Internal
Received: from 3x7y6s2.ad.shared (HELO localhost.localdomain) ([10.225.32.59])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 May 2021 01:31:36 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/2] btrfs: zoned: bail out if we can't read a reliable write pointer
Date:   Tue,  4 May 2021 10:30:24 +0200
Message-Id: <20210504083024.28072-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210504083024.28072-1-johannes.thumshirn@wdc.com>
References: <20210504083024.28072-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we can't read a reliable write pointer from a sequential zone fail
creating the block group with an I/O error.

Also if the read write pointer is beyond the end of the respective zone,
fail the creation of the block group on this zone with an I/O error.

While this could also happen in real world scenarios with misbehaving
drives, this issue addresses a problem uncovered by xfstest's test case
generic/475.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 6edf88580f47..743334cf8bdd 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1191,6 +1191,13 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 
 	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
 	case 0: /* single */
+		if (alloc_offsets[0] == WP_MISSING_DEV) {
+			btrfs_err(fs_info,
+				  "zoned: cannot read write pointer for zone %llu",
+				  physical >> ilog2(fs_info->zone_size));
+			ret = -EIO;
+			goto out;
+		}
 		cache->alloc_offset = alloc_offsets[0];
 		break;
 	case BTRFS_BLOCK_GROUP_DUP:
@@ -1208,6 +1215,13 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	}
 
 out:
+	if (cache->alloc_offset > fs_info->zone_size) {
+		btrfs_err(fs_info,
+			  "zoned: write pointer %llu in BG %llu behind end of zone",
+			  cache->alloc_offset, logical);
+		ret = -EIO;
+	}
+
 	/* An extent is allocated after the write pointer */
 	if (!ret && num_conventional && last_alloc > cache->alloc_offset) {
 		btrfs_err(fs_info,
-- 
2.31.1

