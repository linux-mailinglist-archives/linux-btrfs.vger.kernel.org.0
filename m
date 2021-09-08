Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2D6403D7D
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 18:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349188AbhIHQU6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 12:20:58 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:3327 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349026AbhIHQU5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Sep 2021 12:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631117989; x=1662653989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d5cX5u9vwWMMNdTUQn+OLlUtTFaftwzMlH81YJ6zSEE=;
  b=YZQAlRpfwQXVJ18pmUgexXjnDCWGLRSFWh5PZzKQiT/6pFaMmlTATIoA
   +S+LUU1sjlKxTVsRbI+/czEUjECDrkwbG037hSvEqW429JvieSktoM6nz
   7P0lIYKE/LTXLvuv/m5IPe0JP5wSIXT+ywzjK28ECtqkgEK3XAfy1nZo5
   yLfRCEA5DCFcE3eZ6sKUAdMj+HaBkaEKDDen3omhOmP1IFMI/RcDrYSVh
   zskhl44d7PLP9eAPKA+iC6lBZSJsMtjlv11U2S6UFQbpWfzgV6rkvZxab
   ux9qCKQWgeLabJiqNL7fv/aNLySJeqlus0GRVgBfBmK69j5BGFgJOkbO+
   A==;
X-IronPort-AV: E=Sophos;i="5.85,278,1624291200"; 
   d="scan'208";a="179493945"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2021 00:19:48 +0800
IronPort-SDR: aqGDc6jr4T18w2Qw9xEYbAC26cGIayFScJP+IMxB+PCGfTZqzVKRBSkmCblckpHQ7vZ5GZ99Jh
 jR1FG4QYUwSl9eRu0bSkCy4M5zzOAEl0n1JMWYs251eD5Tizla/mcI01KBha1Yb07ZG4cgngHh
 cZs8iymKAnhh0LxoOnYWtcN6yLH4dP4IvsneB7x/Qs/NHhkuCx3T5wYc307cJqifpWkD7lKt/d
 Qi5uHLUGWhezV3F/5yzgeyw1y+u8X9+UGHEP1I5clxPVmidBf6QmExVT5E2LJjgxg/0kIBbboh
 AwcE2of49OJKUqJWlkNXpmNw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 08:54:45 -0700
IronPort-SDR: NzdMupWaXDmNzqq/V3Q80eREymtVDEmdt/tlvlN8A+6swNN4xRTxYyrlsPNFNTd6ZCj/W7BxLT
 WH+zJVwr9UQTN5G6dtnaGlIOeD18uK/VIROp3+powsiacNAn09Oxiu5tzMZDB3yAtVTiKOQQTR
 tXkocEaHZOFN+rdE3/iL+Yj8dQEErGKaZ4Hoc8TyvMtuCzJF0GinydeMpj2A2xbuTC5IGNVNr0
 4NjsyHlI0seu3/avnhjQFswsOPlqw4j/HIEb1jpQENKc+tMYCCnUdUaVYskv0Pb6mg2rsTjEvh
 g1o=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Sep 2021 09:19:48 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 5/8] btrfs: check for relocation inodes on zoned btrfs in should_nocow
Date:   Thu,  9 Sep 2021 01:19:29 +0900
Message-Id: <9facc2896434f78cd72f5147948db55786bf1150.1631117101.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1631117101.git.johannes.thumshirn@wdc.com>
References: <cover.1631117101.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Prepare for allowing preallocation for relocation inodes.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e89e16a9c56c..4eb64753382c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1944,7 +1944,15 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 	const bool zoned = btrfs_is_zoned(inode->root->fs_info);
 
 	if (should_nocow(inode, start, end)) {
-		ASSERT(!zoned);
+		/*
+		 * Normally on a zoned device we're only doing CoW writes, but
+		 * in case of relocation on a zoned FS we have taken precaution,
+		 * that we're only writing sequentially. It's safe to use
+		 * run_delalloc_nocow() here, like for  regular preallocated
+		 * inodes.
+		 */
+		ASSERT(!zoned ||
+		       (zoned && btrfs_is_data_reloc_root(inode->root)));
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
 					 page_started, nr_written);
 	} else if (!inode_can_compress(inode) ||
-- 
2.32.0

