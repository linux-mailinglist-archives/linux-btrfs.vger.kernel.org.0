Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B83645C5F
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 15:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiLGOXM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 09:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiLGOWf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 09:22:35 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80727F32
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 06:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670422954; x=1701958954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DO/jZ/XQcPDQzmymQx7NqlewyRAyloRSjYgdXbGnFQU=;
  b=bT+GmtGvBlEgP7FcnjSqeV6qm+mX/Ac1RXPbWCJxlYR9ldO4/HJGzyqg
   UPC3FLhdd5jkO97wNT6XDPsmvZW7UYdcb6UcWo8IkvZzmZ7YhV67vaP6n
   21kW0/TZhzPlDilnv9Xat4XSiAGRJVxO1FQ+eADTbDKo19OFSXqileD6H
   ZrL8d2XNrxO0y5ZBUAWQHyffpDQvIey1he4gPFLXX/rE6HLVTkm2iyHbj
   RJTRmVIfvf/NI/R8E+9M1t3Jh5cqHZOWzTk73pWvZqqtQYi6NpkjDY7jz
   tKV9OwOn28tfa3dtjpvXKi650v5m0n+W9pdykufNsxkbC+N5OlsW1aiGi
   A==;
X-IronPort-AV: E=Sophos;i="5.96,225,1665417600"; 
   d="scan'208";a="218099489"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2022 22:22:33 +0800
IronPort-SDR: 9hZi+yZsQB63yFCkRE6HFT0SXulkQGdnt+hAsSlAeyPtws4x8JUzlmIvT9zu8CUfDUTqiLMafj
 E86jAFmGJWM5odpgYVvwMFGcvmeMzYtC6f5luXYxV2FTM2eC1+N99Thsv79mvp2ZgwSAvIyTSr
 3hgOFDdUNE7JuiJCmZhk4L0tcr5kKbDcacD/Ya5/7tOkGqJBGso4Pb9WiGZRGm1496PysmCoSj
 XdM8DsT+Ud4gsPUa4v7xI24ZoRntloUTNik5VMpdV4KBmaBXdl+eCd7E/6ZCX5eJMq6I8WimL2
 x7I=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2022 05:35:19 -0800
IronPort-SDR: 5WLdg269tddTjR8irAMyIJS7oY1tLm40yQQjeLJ1MHnoBAF5N1nbsOH0BMyf4WjPajKE4Llgso
 YzYDDdCQujWGncSZduLLP/oDVIyeRuynTirQa2H9XTQ1KWVfxmwV0EW4tLLGy6dj5A3sTlSasl
 H9Cmi9VTvohNw2eMlLAHu4VtR5QduMtCp097bQVyRYgzIFG92Kc/XIccr1Za4a+Zx50TUSOp+j
 +5PpwF20QPsR9QakAKQPSB5MOeXkW+YCojxCJ7MXKPxZ/jtMLpH0eLe+URvXFMiYid9Wm64zzg
 03E=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Dec 2022 06:22:32 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH v4 7/9] btrfs: zoned: allow zoned RAID
Date:   Wed,  7 Dec 2022 06:22:16 -0800
Message-Id: <54ae9043ea789786b636886aa29dee10f504514f.1670422590.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1670422590.git.johannes.thumshirn@wdc.com>
References: <cover.1670422590.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we have a raid-stripe-tree, we can do RAID0/1/10 on zoned devices for
data block-groups. For meta-data block-groups, we don't actually need
anything special, as all meta-data I/O is protected by the
btrfs_zoned_meta_io_lock() already.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.h |  6 ++++++
 fs/btrfs/volumes.c          |  2 ++
 fs/btrfs/zoned.c            | 39 +++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index d227299e8865..73167c775f66 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -52,6 +52,12 @@ static inline bool btrfs_need_stripe_tree_update(struct btrfs_fs_info *fs_info,
 	if (profile & BTRFS_BLOCK_GROUP_RAID1_MASK)
 		return true;
 
+	if (profile & BTRFS_BLOCK_GROUP_RAID0)
+		return true;
+
+	if (profile & BTRFS_BLOCK_GROUP_RAID10)
+		return true;
+
 	return false;
 }
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index be4f5075214c..385dcf8b2cc4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6495,6 +6495,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	 * I/O context structure.
 	 */
 	if (smap && num_alloc_stripes == 1 &&
+	    !(btrfs_need_stripe_tree_update(fs_info, map->type) &&
+	      op != BTRFS_MAP_READ) &&
 	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1) &&
 	    (!need_full_stripe(op) || !dev_replace_is_ongoing ||
 	     !dev_replace->tgtdev)) {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e5a083a9fd0f..d05b1180580d 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1510,8 +1510,47 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		cache->zone_capacity = min(caps[0], caps[1]);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID1:
+	case BTRFS_BLOCK_GROUP_RAID1C3:
+	case BTRFS_BLOCK_GROUP_RAID1C4:
 	case BTRFS_BLOCK_GROUP_RAID0:
 	case BTRFS_BLOCK_GROUP_RAID10:
+		if (map->type & BTRFS_BLOCK_GROUP_DATA &&
+		    !btrfs_stripe_tree_root(fs_info)) {
+			btrfs_err(fs_info,
+				  "zoned: data RAID1 needs stripe_root");
+			ret = -EIO;
+			goto out;
+
+		}
+
+		for (i = 0; i < map->num_stripes; i++) {
+			if (alloc_offsets[i] == WP_MISSING_DEV ||
+			    alloc_offsets[i] == WP_CONVENTIONAL)
+				continue;
+
+			if (i == 0)
+				continue;
+
+			if (alloc_offsets[0] != alloc_offsets[i]) {
+				btrfs_err(fs_info,
+					  "zoned: write pointer offset mismatch of zones in RAID profile");
+				ret = -EIO;
+				goto out;
+			}
+			if (test_bit(0, active) != test_bit(i, active)) {
+				if (!btrfs_zone_activate(cache)) {
+					ret = -EIO;
+					goto out;
+				}
+			} else {
+				if (test_bit(0, active))
+					set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+						&cache->runtime_flags);
+			}
+			cache->zone_capacity = min(caps[0], caps[i]);
+		}
+		cache->alloc_offset = alloc_offsets[0];
+		break;
 	case BTRFS_BLOCK_GROUP_RAID5:
 	case BTRFS_BLOCK_GROUP_RAID6:
 		/* non-single profiles are not supported yet */
-- 
2.38.1

