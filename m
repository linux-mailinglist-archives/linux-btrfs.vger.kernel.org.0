Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B0446BDAF
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 15:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbhLGOcb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 09:32:31 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19470 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237947AbhLGOcO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 09:32:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638887324; x=1670423324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wITIB6M1U2DL2VHvvb/GawAI5cc/q8x6EKRWjDVKxFo=;
  b=U+wQfIDwURFu3Ng3hqvf6zJPbVNxXYcrA0BEMQmrlY1+lw/9kiMf3OFc
   CA/JqTK1AVWRQfYamXWu4rloyfRqipFC8bIyJwxSai6MeF+mMn9h9xYZj
   CJt5gZ9Z6mBrLoC5yxs7GdeYU6/wH9tCxbEGWzKSaOWxL/rliapOka/nm
   F6biXcBy70zmY0qsd+UsI9MuTBSxVCe5MySpfFjMWAABfMn6JQv+PB+4Z
   DZ2NC6PzOF0Joj26QeLC6aHUPcXk4YLgqaZxOAyW2ZBSpYhhP/z0dGPFA
   ge/Te9JFdmidK9LJsz6eNfh/t64u6kWJBlawoMG07oV5O9naLNTMdCA7q
   g==;
X-IronPort-AV: E=Sophos;i="5.87,293,1631548800"; 
   d="scan'208";a="299501477"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2021 22:28:44 +0800
IronPort-SDR: dp0YLbt0WJKnWBhVYI79cP8CgAHjaFZ+HE+zQOCQsHI35hSWfLDaduWd0LvpCViK1MKZ/+XQzH
 mC8ArT7Q5jC4VIjq+gyTUWdV6yszKinRxdpdPQpEM1nllDQj3aXaI9GkGAhbCe/Xev5G/Xl/cn
 nun3tXg4uCq7YSoTy9ZHfVHDEVf5AmFdIZTLs35cWhEQAlZcfkmPfswq7j45bwZOf1RqI14rgP
 X4z5/U6kboIb90Ml28SpLBMnMAik8yCg8lU2RNZh8dBCoFTlGzvUYJ+gC9Gm2m+qaXVZ4C/rji
 QDcCFG9rPo2/BWJzwaaWTzJq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 06:01:49 -0800
IronPort-SDR: T1DCd7+kzzwAXSU453hQVIGR9yf3PJFfcmXJRpFEYP3IqNJS6b04BIgvQlFMrmqcyIbrO/hDHh
 v7XFZKu6/d5P1I/YgDcNaxWpym6rT1ZI8+FHQ0JzpDyuO8SHUMCdlPg6DyPOsUyZiQClHsVTRa
 5k/Xykh5Pt+kip9ZgE+etixw+jt1bXhNZO4YS2EF24mDP2ajFSsZCH171UninudJmT6nE4ETH5
 SqDGmDudJ3IIMvBj4iJ8g3lxjmTNuMdpPwbbrvwSFqPNIv7OOBU4LM7fvbMfAczTNbnRDr6e65
 5lE=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Dec 2021 06:28:44 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 2/4] btrfs: zoned: simplify btrfs_check_meta_write_pointer
Date:   Tue,  7 Dec 2021 06:28:35 -0800
Message-Id: <0330e97246527726dd7741650065c0b8a5844df5.1638886948.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1638886948.git.johannes.thumshirn@wdc.com>
References: <cover.1638886948.git.johannes.thumshirn@wdc.com>
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/zoned.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 9cdef5e8f6b7..39bce555d3c6 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1641,29 +1641,19 @@ bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
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

