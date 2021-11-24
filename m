Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBA645B771
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 10:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbhKXJeH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 04:34:07 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32168 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbhKXJeG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637746257; x=1669282257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PMU6EJmLjXKKmmJRhCUmEwvGBf//yUwO4HKPwmD/JMo=;
  b=Sw8fo7ibR/KA4F4wF+vOCdJ8Puko63C8f4X7yF97Fr7Ac+SXNYIt9C8C
   ZK1uK+YxGK6K1+lSymE2SdnlkaY/yZXdCJxersfw8aXoeKJ7nwbh0Goyh
   VsLu7zhv1ZBnfq+vE+nmqgAXyLfggdUpf+an58PgTSUhkSiYzlkdwa8h4
   4M2kpuZWdNYx8pkFmt8424Y6oE8MlKyGurElmwzHwzMpBwThVRZY8wZKm
   7wxEn4Ywjgs2nDNIG4aZDXNcNJCIlMvje6EcSFISeAaFa2OsmYtaSh4Fn
   LpRRaynmPeoXznFZQm49I5YRE/mWsLCz7FVrFZlkkP45/mx47bQh5eimH
   A==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631548800"; 
   d="scan'208";a="185499355"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 17:30:57 +0800
IronPort-SDR: WiL5LIGgvKFKrxQ/WsGUhbWWSQCP4LjtTVEZ3p/Gqva3bIoiV8fWP5QrZaAnB+zrkQakT6/Cb3
 oHAjWaM3qlsFy5jscffV88+Gn8GZhfECnkCelP4xn1Nwav4iOTtvujOXY4YwANoLzfhdBaFO+b
 Zi+2/RPxqdnO9My64A1g+y1RLI+v1fry9bViILcU3Zeb3qIo4KnFo9m5CrNp8U5vvFstgM8Mvv
 +GCnpAcaOn9/m96aawNUVTrKV8rVpvkFVf5uOSe8QoYh0lQSD7ltmYv0V2bHAPYsnyx3mWiUMu
 sEEEkxxHM67aLjv3oqBlENO4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:05:50 -0800
IronPort-SDR: Kv415UFHO1i7ijLJAtZskQvu4lvxzHSe18+SkskmH+OY3em/Cqmt/CmB7htgMWL/TTTDYgJPcv
 9HBAaBEs0vKBDSd4LJb/bLJQWxfl4GkpPsC/8cAXfEaVYks7QzKKdpJaAOVVma+kAar2O8D/P/
 GOxW/1t2qW6f8dqg+8sqPRwpsHFn0RjBHy1Vonja8qTGalQZGbzjdCj4MEPU2eckbr7aFMH+Fq
 X5P5EP0kCXL/j9gaRU0ncfW8Kqk699UyW++shq9SLkcCjoiMtbBRpiQFyJycG6FyYgxS7zjFKK
 x4g=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2021 01:30:56 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 02/21] btrfs: zoned: simplify btrfs_check_meta_write_pointer
Date:   Wed, 24 Nov 2021 01:30:28 -0800
Message-Id: <afd9937c9a5374cb7766dbba5c7dd459f6529fb5.1637745470.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637745470.git.johannes.thumshirn@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_check_meta_write_pointer() will always be called with a NULL
'cache_ret' argument.

As there's no need to check if we have a valid block_group passed in
remove these checks.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 0921dbbba84d2..b0ab38a2e776e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1640,29 +1640,19 @@ bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 	if (!btrfs_is_zoned(fs_info))
 		return true;
 
-	cache = *cache_ret;
+	cache = btrfs_lookup_block_group(fs_info, eb->start);
+	if (!cache)
+		return true;
 
-	if (cache && (eb->start < cache->start ||
-		      cache->start + cache->length <= eb->start)) {
+	if (cache->meta_write_pointer != eb->start) {
 		btrfs_put_block_group(cache);
 		cache = NULL;
-		*cache_ret = NULL;
+		ret = false;
+	} else {
+		cache->meta_write_pointer = eb->start + eb->len;
 	}
 
-	if (!cache)
-		cache = btrfs_lookup_block_group(fs_info, eb->start);
-
-	if (cache) {
-		if (cache->meta_write_pointer != eb->start) {
-			btrfs_put_block_group(cache);
-			cache = NULL;
-			ret = false;
-		} else {
-			cache->meta_write_pointer = eb->start + eb->len;
-		}
-
-		*cache_ret = cache;
-	}
+	*cache_ret = cache;
 
 	return ret;
 }
-- 
2.31.1

