Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECD536FB97
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Apr 2021 15:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhD3NgU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Apr 2021 09:36:20 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28821 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbhD3NgT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Apr 2021 09:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619789731; x=1651325731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CRwDSG8D520fS1AGzZ+KpGCHUQq3yQx3xzOQrnDg8W8=;
  b=h1dJ6bTDSzMb71niq0LcyIMw0K2DVEWfeG0XzuGbfcTRETB6N0iAkW+c
   nnTF2w9UjsQCD5BDpW0QGohCUqaxtE3lJ6V3lGd6j1wFCX58cCUSB2Arf
   OASOihBwaL0Jlt/DX0p2YT6PGPppaXlcWj2sPKNqpObJH/2fdCiOzxe35
   /I7UOvjlVFQ94W+Z94qCB23lN0tNKdi9fQfHAWvQUGvwMFrSiPQ5MHduZ
   NyYBajnalzDmXxo0B+KX+kjqfu57O1aCenOtWC+wCvq3qDoyh9leNQv9F
   B/NHH24Y94tI6I3jjsu6PTMM4zzxa1esQhlncVwVer8SixMo9OqRjfoOV
   Q==;
IronPort-SDR: AZSvkICWmBpDKCnhjPpU2odHnGL+M6XUupRKLkPFl7WMFX02jE6vXJSxF8oH7CZeGhJzgbJcmc
 QIqJ6PwFgBrWc6QMyJrGJ+wR5iTJKENKUXb0ZS9AZKWo/YMrPaTaH24Qd3Ek8Ksur4NZfC0c5U
 b6dnOUR4BX+QRmDpPa8oa84y0OOMAESsEJBh3zpclXKAiZr1sp3072ATwv6zkw4ZPiFsF538nJ
 ssLNBan6NPGqCZbYE+ED7qbvy1xMhZA8IQDZOjzGddZF1HK3z6DGrjlANFk3tj75SRyEjpMKre
 O4Y=
X-IronPort-AV: E=Sophos;i="5.82,262,1613404800"; 
   d="scan'208";a="166128998"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2021 21:35:31 +0800
IronPort-SDR: /vphdRGbVQ/SOa2MlysFyYJV8Zt2Pyyj8TiCtK46h0uCOrl0D9xeU9+wl9IuFbCE7UykNNct1x
 Omv332D8/lorl3LkOO/EFowwwy++foa4j9KzUi7dz+vlJjDw2Sqo7IS8yUEq8QLwSBoZkWefCA
 xUcr0v9+Ddswk0HSyLcOzyg4NPR0rh2hrhXnPMwZ6NgrhIQCXl3yGlABAahgt+49AbuvQtTG+u
 AxH/dCeLAH4kWFTBTyce2LP/XJe4vFbF9wkFvdeMzlyR80BkxvEesstHvt27zveukzam2/kbBY
 VFt4x9iiuRfVRkGktCXWTDhu
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 06:14:18 -0700
IronPort-SDR: 2HygJMyXs1DMDmn/b+ViktyKdzEIk4Srl7Bf4r+lidJGHtdnDkMrar3NXwa+TLPr2fWinMqWMm
 pgeDKS12FB5ypONaoADSS6l/DooQMzhdgwJo/1jEUK7u1oKMSQCRA9Z0yREisjmXpKZup4jN16
 nmXPFsljWibj5xqUUA1ohbjfl1yIn4LrdroCvhz5vLhxvEmITjTq3uzpIFW1pUwYN1wXwQXeNP
 w3sW0BoxhxdV9iCB1MRn6wQJeY9+wsddniFbtX1LsbJoQ8FrO1kSuESSpR3DJbF0gCXpoU0pbU
 /5I=
WDCIronportException: Internal
Received: from deb000468.ad.shared (HELO localhost.localdomain) ([10.225.0.10])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2021 06:35:31 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/2] btrfs: zoned: bail out if we can't read a reliable write pointer
Date:   Fri, 30 Apr 2021 15:34:18 +0200
Message-Id: <20210430133418.4100-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210430133418.4100-1-johannes.thumshirn@wdc.com>
References: <20210430133418.4100-1-johannes.thumshirn@wdc.com>
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
 fs/btrfs/zoned.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 304ce64c70a4..29adf846f33b 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1187,6 +1187,12 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 
 	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
 	case 0: /* single */
+		if (alloc_offsets[0] == WP_MISSING_DEV) {
+			btrfs_err(fs_info,
+				  "zoned: cannot recover write pointer");
+			ret = -EIO;
+			goto out;
+		}
 		cache->alloc_offset = alloc_offsets[0];
 		break;
 	case BTRFS_BLOCK_GROUP_DUP:
@@ -1204,6 +1210,12 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	}
 
 out:
+	if (cache->alloc_offset > fs_info->zone_size) {
+		btrfs_err(fs_info, "zoned: invalid write pointer: %llu",
+			  cache->alloc_offset);
+		ret = -EIO;
+	}
+
 	/* An extent is allocated after the write pointer */
 	if (!ret && num_conventional && last_alloc > cache->alloc_offset) {
 		btrfs_err(fs_info,
-- 
2.31.1

