Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1118E72216F
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 10:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjFEIvb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 04:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjFEIv3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 04:51:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B434DCD
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 01:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JizsXWu8mUyd3+gCTtmhEg0QYIhavi1Fgs7HBHhrzQU=; b=YbFlKz8nLxZ+FFKO+0AYrIJbDx
        /IHi2DfCKqvTFXh8xbRGCKkR7eyEskZq90XJE6FLNPApzUNb/7SeLAtCr3ALQipe6SjsdLn8IXhQw
        7ANi9sOMpJ4X/GcEwKdGPWOBpuqpQ5NxafWaxWKY36ty5k3TpEOcs9QNx8slbVTQknrWOUFFydmrj
        SNLVnv2GUv/wsXW0WXUbroLkOAJkgjhU/os6vvB3IiUC/1UfOykTTKUWz1lUFOZtk8BQwqzNNSLy0
        TU7FFlGhHaD+WIkk2QueoMHMK0iFtXYZCdw79UaLpvf97r9t7IMSIcHbNVaPmjAwyCFOm1Hz7WOju
        mV8njatA==;
Received: from [2001:4bb8:191:e9d5:e931:d7f5:9239:69f3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q65vy-00ElJH-1L;
        Mon, 05 Jun 2023 08:51:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: split out a helper to handle dup BGs from btrfs_load_block_group_zone_info
Date:   Mon,  5 Jun 2023 10:51:08 +0200
Message-Id: <20230605085108.580976-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230605085108.580976-1-hch@lst.de>
References: <20230605085108.580976-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Split the code handling a type dup block group from
btrfs_load_block_group_zone_info to make the code more readable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/zoned.c | 80 +++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index ea1f7f26a42249..7b575aca06236f 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1391,6 +1391,47 @@ static int btrfs_load_block_group_single(struct btrfs_block_group *bg,
 	return 0;
 }
 
+static int btrfs_load_block_group_dup(struct btrfs_block_group *bg,
+				      struct map_lookup *map,
+				      struct zone_info *zone_info,
+				      unsigned long *active)
+{
+	if (map->type & BTRFS_BLOCK_GROUP_DATA) {
+		btrfs_err(bg->fs_info,
+			  "zoned: profile DUP not yet supported on data bg");
+		return -EINVAL;
+	}
+
+	if (zone_info[0].alloc_offset == WP_MISSING_DEV) {
+		btrfs_err(bg->fs_info,
+			  "zoned: cannot recover write pointer for zone %llu",
+			  zone_info[0].physical);
+		return -EIO;
+	}
+	if (zone_info[1].alloc_offset == WP_MISSING_DEV) {
+		btrfs_err(bg->fs_info,
+			  "zoned: cannot recover write pointer for zone %llu",
+			  zone_info[1].physical);
+		return -EIO;
+	}
+	if (zone_info[0].alloc_offset != zone_info[1].alloc_offset) {
+		btrfs_err(bg->fs_info,
+			  "zoned: write pointer offset mismatch of zones in DUP profile");
+		return -EIO;
+	}
+
+	if (test_bit(0, active) != test_bit(1, active)) {
+		if (!btrfs_zone_activate(bg))
+			return -EIO;
+	} else if (test_bit(0, active)) {
+		set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &bg->runtime_flags);
+	}
+
+	bg->alloc_offset = zone_info[0].alloc_offset;
+	bg->zone_capacity = min(zone_info[0].capacity, zone_info[1].capacity);
+	return 0;
+}
+
 int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
@@ -1482,44 +1523,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 						    active);
 		break;
 	case BTRFS_BLOCK_GROUP_DUP:
-		if (map->type & BTRFS_BLOCK_GROUP_DATA) {
-			btrfs_err(fs_info, "zoned: profile DUP not yet supported on data bg");
-			ret = -EINVAL;
-			goto out;
-		}
-		if (zone_info[0].alloc_offset == WP_MISSING_DEV) {
-			btrfs_err(fs_info,
-			"zoned: cannot recover write pointer for zone %llu",
-				zone_info[0].physical);
-			ret = -EIO;
-			goto out;
-		}
-		if (zone_info[1].alloc_offset == WP_MISSING_DEV) {
-			btrfs_err(fs_info,
-			"zoned: cannot recover write pointer for zone %llu",
-				zone_info[1].physical);
-			ret = -EIO;
-			goto out;
-		}
-		if (zone_info[0].alloc_offset != zone_info[1].alloc_offset) {
-			btrfs_err(fs_info,
-			"zoned: write pointer offset mismatch of zones in DUP profile");
-			ret = -EIO;
-			goto out;
-		}
-		if (test_bit(0, active) != test_bit(1, active)) {
-			if (!btrfs_zone_activate(cache)) {
-				ret = -EIO;
-				goto out;
-			}
-		} else {
-			if (test_bit(0, active))
-				set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
-					&cache->runtime_flags);
-		}
-		cache->alloc_offset = zone_info[0].alloc_offset;
-		cache->zone_capacity = min(zone_info[0].capacity,
-					   zone_info[1].capacity);
+		ret = btrfs_load_block_group_dup(cache, map, zone_info, active);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID1:
 	case BTRFS_BLOCK_GROUP_RAID0:
-- 
2.39.2

