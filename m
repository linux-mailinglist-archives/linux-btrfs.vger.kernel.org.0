Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5084145B777
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 10:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbhKXJeO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 04:34:14 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32168 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbhKXJeN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637746264; x=1669282264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xE+TYty/OMsXJfgya3A49OLsuQBhGBt3WDaA3c96EoU=;
  b=pRTlXLKox74MEGinZ8XDpbX2iac3fbqXNc36PJZPmNu/VFqtGIq2kr8e
   83iyeOGhJge+gXJFpT4+UkiFLSVJAv3EFFyh1t0qWrl/snS4gH9EOfstw
   JDRFFOFJoRLAYDlIHLCwxpGVsdEDP+iOH1ag2U3NFvzj1dBRzZv8ojQ2n
   4GR3Ab4Y4RY2MGLfAKTO0MDME7akL6ahnQUpd1fHVu1x9GY3f9BUkNHPO
   SUCqjyMlY/t/tQ3SHQcRw/KL370S5oPZcbHRENfTCd/4FqcLZhk66Ae32
   I8EJGNwc4Y3KOr7RefvjroWINiJQXLoi6XJxkVfmI6vQrTSBtqOdePdaZ
   w==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631548800"; 
   d="scan'208";a="185499379"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 17:31:04 +0800
IronPort-SDR: UCpdzJ84MDgOyxTtCrtuVHyf91BhLregw0NIyb1G21Ux3i6rt4zU9r0xWCIzLf8eSvtKcjKPoA
 IfvqOIi2LRslZhltrzTnX8Q4KZJETLwfhwqLKH/cE95u+4Lajw2HxDplROz+pHchymycdkGuYe
 MGb9Q81s0LwrhflL9SFob4XCQIyZiSPftpv9zod9JRhQLfRkQg4lsbr6Mn2Pv0ajrQyu+/3Lov
 6KfTh5dPr9QpiA/5XmEvtdC66oQzJ4VHT355k2rbmxtrhrevm8xYCUVEK/kTWVEYzM070X6u2U
 F/J31cytNKjPLvMt+j+X+REa
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:05:57 -0800
IronPort-SDR: ErxljmQbX7DjuqOEB6gHf3ZAFKplY9eD7X2nlPgewWAil/rgIFgcHo/b87yKY/bJ2MerRcMKBi
 oe1ZTjWTrDXHyI8Qg2HcrfWrQQFT9fxRVPe79vvNMpHOy/G/w0M2Oxr3uqMzt5GmOZiqKZLiYw
 xvt6iGr3scEY9qHPmucIto7W6uUNNlBnC7Ais2rAILZOw2X/JocbmiEWty8hGyEovPqp1LD+8X
 xpBL/Nuypb+MxagfqyUcz/lSrr6WEgpoFbH3PiS7SmMBvkI9q9zMxVY2qijjvMqVjFwrdp9UWF
 oig=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2021 01:31:04 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 08/21] btrfs: zoned: move is_block_group_to_copy to zoned code
Date:   Wed, 24 Nov 2021 01:30:34 -0800
Message-Id: <d0c9c72f4ecaf1998ba41f12628ca2262ec2040e.1637745470.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637745470.git.johannes.thumshirn@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

is_block_group_to_copy() is only used in a zoned filesystem, so move the
code to zoned code.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 22 ++--------------------
 fs/btrfs/zoned.c   | 19 +++++++++++++++++++
 fs/btrfs/zoned.h   |  7 +++++++
 3 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d0615256dacc3..23459328d19bc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6171,25 +6171,6 @@ static int get_extra_mirror_from_replace(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
-static bool is_block_group_to_copy(struct btrfs_fs_info *fs_info, u64 logical)
-{
-	struct btrfs_block_group *cache;
-	bool ret;
-
-	/* Non zoned filesystem does not use "to_copy" flag */
-	if (!btrfs_is_zoned(fs_info))
-		return false;
-
-	cache = btrfs_lookup_block_group(fs_info, logical);
-
-	spin_lock(&cache->lock);
-	ret = cache->to_copy;
-	spin_unlock(&cache->lock);
-
-	btrfs_put_block_group(cache);
-	return ret;
-}
-
 static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 				      struct btrfs_io_context **bioc_ret,
 				      struct btrfs_dev_replace *dev_replace,
@@ -6210,7 +6191,8 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 		 * A block group which have "to_copy" set will eventually
 		 * copied by dev-replace process. We can avoid cloning IO here.
 		 */
-		if (is_block_group_to_copy(dev_replace->srcdev->fs_info, logical))
+		if (btrfs_is_block_group_to_copy(dev_replace->srcdev->fs_info,
+						 logical))
 			return;
 
 		/*
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 893d025069275..61d1e1c67a742 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2214,3 +2214,22 @@ bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
 
 	return true;
 }
+
+bool btrfs_is_block_group_to_copy(struct btrfs_fs_info *fs_info, u64 logical)
+{
+	struct btrfs_block_group *cache;
+	bool ret;
+
+	/* Non zoned filesystem does not use "to_copy" flag */
+	if (!btrfs_is_zoned(fs_info))
+		return false;
+
+	cache = btrfs_lookup_block_group(fs_info, logical);
+
+	spin_lock(&cache->lock);
+	ret = cache->to_copy;
+	spin_unlock(&cache->lock);
+
+	btrfs_put_block_group(cache);
+	return ret;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index bc9482cceadc4..487c699f152d4 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -84,6 +84,7 @@ int btrfs_mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
 bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
 				      struct btrfs_block_group *cache,
 				      u64 physical);
+bool btrfs_is_block_group_to_copy(struct btrfs_fs_info *fs_info, u64 logical);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -255,6 +256,12 @@ static inline bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
 {
 	return true;
 }
+
+static bool btrfs_is_block_group_to_copy(struct btrfs_fs_info *fs_info,
+					 u64 logical)
+{
+	return false;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.31.1

