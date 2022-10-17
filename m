Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D1E600E48
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 13:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiJQLzs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 07:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiJQLzm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 07:55:42 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6988A57E12
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 04:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666007741; x=1697543741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/KOh8Qx+nBF4bAugvGLl8O8BjRxQzjcCHYVCq7TdJ/0=;
  b=fUuLAoM551dN2ZwRsXiB49vQIYe7K5vvGXxPCf51st5j7qBSnLZunZZX
   GeqUow/FtlKn+XLwdSz9DrCdmGDE5k88pLSODuAWQR+L/3cDKv4mjsmrQ
   hq7sm9mLW1L2UPkumEvnLW/zWhJvowE27zweczkUIdWfBH0Nuu8EPfEVa
   GCKzVLG7+KHU27kZTolGOnDXc4cuMYD3BaUZ4/1edNHtSrSJ9nq26HSqr
   gkNJYJneb08CBlLiND6cXT6c9KHttzcAHvDtzgoO2yP5BN0CSG6f4x8gW
   i1ky48Pa1hMmDP9S4Z4L1bTp0GTnGKoZFlvDuQ+54LA4buWx/k/O0vCiV
   g==;
X-IronPort-AV: E=Sophos;i="5.95,191,1661788800"; 
   d="scan'208";a="212337164"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 19:55:39 +0800
IronPort-SDR: Dq6VxkwMrD4VueIH7z3qJRvFjVhlffq7EhCJqXiPphGkrj3efqckyl3CngUMMVTYbreFzTj6wE
 QhWWSlX5JcTm7PdZOHS27/uyRUDAiV6H0O8SgYhK4U4VBJIdq6iyfiq+WrSuDYk6XCUh32uqrO
 j5rvz7WPkW+BXuUcf3+MYCtjz+8YCtS+SoQ/ocmtsGQk5s5n1V+CfooR4yY0CfCjN2M+l4Ssde
 w/4Wp5vGJmnZhK62hc4NKbj+wUT/7MtxMY8A69P4Tc19Y3obYkWsF03McfATJcS1/WYfYJf3zK
 2Ce4hBuTVcaTwnxvfsQVzwBZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2022 04:15:12 -0700
IronPort-SDR: aXBmOl684flRDbV6AKVNi6Z9ZpC7iQhwvGZXWQcGiuGkqBs61JTD4n3rtAQLcQEAJVNpis8/ld
 Z0CjYTRWLesdvH1lBfePQRNc4BpCuYFAu/LDmHpXAR2MnB8zd3e2z1RbZOs2JT7EiSAwYo+wII
 CkXg8N10OviuojsIV63iGuZh3tMOJWU7TQ50SNjkMII87yu0/8iln/qmZQz7AmkyxZo5W5ndP8
 2YsJZgJajaEs35dOph0vYSmi55liIWi51ipgpVKrNSfqvomi3K6PBBsk/IgFC8RVILbZ9Foh+r
 IM4=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Oct 2022 04:55:40 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC v3 07/11] btrfs: zoned: allow zoned RAID1
Date:   Mon, 17 Oct 2022 04:55:25 -0700
Message-Id: <ae7eefe6f2862c14b5fbb15a7445d0bf2956acc3.1666007330.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666007330.git.johannes.thumshirn@wdc.com>
References: <cover.1666007330.git.johannes.thumshirn@wdc.com>
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

When we have a raid-stripe-tree, we can do RAID1 on zoned devices for data
block-groups. For meta-data block-groups, we don't actually need
anything special, as all meta-data I/O is protected by the
btrfs_zoned_meta_io_lock() already.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 286b99f04ae2..f4ce39169468 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1486,6 +1486,45 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		cache->zone_capacity = min(caps[0], caps[1]);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID1:
+	case BTRFS_BLOCK_GROUP_RAID1C3:
+	case BTRFS_BLOCK_GROUP_RAID1C4:
+		if (map->type & BTRFS_BLOCK_GROUP_DATA &&
+		    !fs_info->stripe_root) {
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
 	case BTRFS_BLOCK_GROUP_RAID0:
 	case BTRFS_BLOCK_GROUP_RAID10:
 	case BTRFS_BLOCK_GROUP_RAID5:
-- 
2.37.3

