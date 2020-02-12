Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8B215A19B
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 08:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgBLHRL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 02:17:11 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46465 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgBLHRK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 02:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581491843; x=1613027843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vQK7f590uXyS4KfFENEdWXR1w8x+Y6JgvW+SsUuXZXs=;
  b=g0Cwv36IjeJeegUL2n5tc0jcXWCtTuG5xVwCnRCYJUQUWuihOgAHVVsq
   foB6VmRGlggBUsxTlz2d9wv7BFtAAIfXt3Dqv/MvWHr6DqgUSlIe/tPuz
   XqQxaSNG45cuSxrzXV0pur7uyQK9dPrlZG/CVrACiTsTRqcDu+fTfw+Wj
   ChG4GHijx8fuet+zYEvb/2S2XIp3XXuCmzkFvE81lNejl7h/5NUJV7Y89
   CcXXCE6ezATSSYRmehSv565SykYlmHL5VuDE10AHjv1I9/qoy3v13uTPR
   gh7wzjhKOJ44IEYlyktSKM5ts95D1ANbAk2hS1qa7Z6pIniUFbDuoXfzd
   g==;
IronPort-SDR: 8xHH6EkKZq8ZZmChykc4+LUWLfT7EIBFfcUY80qoo4MuNhwq4RWU0vZuHctlayTrXcxlN/uM0I
 NzA2LJDAjU5UzPwFtfx3bLhKplhB6xClBsI8nrjKxF+9Z/UO6fwkAKAcb40OlqanQjhz516BZZ
 m09IE8MAxKcM3e+sHJkxoiLYZcihj/M9DNltepdEEY4vXz68pwAf2Xp30I/JvQI2I2baihUvci
 weeTaZ/b4H4WuJnfW6gO44sCMO/yKa7qNnxXOlYQTJLcuDx6KtDGAC29Yhrqf+MqS/5Hy0ceq0
 jxM=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448458"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:17:22 +0800
IronPort-SDR: pdg3B3YytMGQQy8NTb7T1sEkgE39YirWqk+05CX84RdnzWWxIv7qrdvKOpldh3Qoy5dknbeip9
 zaNA+qJ1BRyflTj5JYV+VXFenQ1Z1BZ5rSBqZNhqfbR+LNaSOlKa9D7BvuMvat1F9gzZVvKmxS
 xD1kzrMw7dsgDehsyYwsaCT8Tc1vWlhYrFvIpzYk/a6aUpvWqh9ObapPmzMqXCH5MKimopyNZ1
 lE29P/3cCxnSjI0YdYW8vEILdiSIxXDWy9DL7jhW3BgULcsBX6IGhoI5w/oKX3JXmEEYujs4Sh
 PCVtW8G1pyX73PG2mOZvLb5g
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:09:59 -0800
IronPort-SDR: pHZEaYUJHfeeof9yq4/HgTCswb47TckrJibIauLNMLoCKjxj6w17JorlJJpBSNgYR8ZJPmqmv8
 Rv7L0q13aVMJwVjejb55Ve/kSxzUmJVUcTmwB2TiMpNu09XpV2aAQZ1L4IakzD5masj0+w7vBI
 CWT27NrpC6yWjet4feJ0rzcWkG/wC4UibIWDIe9yZ+kgXin7YXIXmFYbjk3/P2JK01cNn4KtvD
 Bht1Y/g3BLoANqqC4gcmlLTrQpMWEqHKG0MIN2vJWlStkbi2kKaZhkJ5jC6cWCCBoGRAK8RC4V
 Zl4=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Feb 2020 23:17:10 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 2/8] btrfs: don't kmap() pages from block devices
Date:   Wed, 12 Feb 2020 16:16:58 +0900
Message-Id: <20200212071704.17505-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200212071704.17505-1-johannes.thumshirn@wdc.com>
References: <20200212071704.17505-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Block device mappings are never in highmem so kmap() / kunmap() calls for
pages from block devices are unneeded. Use page_address() instead of
kmap() to get to the virtual addreses.

While we're at it, read_cache_page_gfp() doesn't return NULL on error,
only an ERR_PTR, so use IS_ERR() to check for errors.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6ebdd95b798d..620794f1ea64 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1249,7 +1249,6 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 
 void btrfs_release_disk_super(struct page *page)
 {
-	kunmap(page);
 	put_page(page);
 }
 
@@ -1277,10 +1276,10 @@ static int btrfs_read_disk_super(struct block_device *bdev, u64 bytenr,
 	*page = read_cache_page_gfp(bdev->bd_inode->i_mapping,
 				   index, GFP_KERNEL);
 
-	if (IS_ERR_OR_NULL(*page))
+	if (IS_ERR(*page))
 		return 1;
 
-	p = kmap(*page);
+	p = page_address(*page);
 
 	/* align our pointer to the offset of the super block */
 	*disk_super = p + offset_in_page(bytenr);
-- 
2.24.1

