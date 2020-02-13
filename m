Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1AFF15C66A
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 17:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgBMQAc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 11:00:32 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43900 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbgBMPYr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581607488; x=1613143488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Uv1J16vyERjQrFnyemT8NsEtR8xlBwSfNrtMPfZ+YY=;
  b=JzbFSn+YSor1/66u+ip3M0/ZF31aymSJRdwlqv1RKJRPup1nb04EUvcJ
   ZdjrqAILjmGrtpAiIYjiqQ++53fw+ewg9V65e9fawOVMVnyk6yOAS9Ox8
   6sgq/LYg2p0f/KWXFmI0yU1Lov0SqlEJGneRXngHc4L7QFMUHnMY6dhss
   7WA2SaW1VcV3tJIUw9h2Aabx8LjPz8r8XdrmN0hhv6tkZ1nwiTEKb7KT/
   fwjbeIOSAFKoJarvDVVGntq1drm/9Sohw6pTZR6Yl4jWjuvxeytwxXXKB
   aCofsFC5cdfRJ1k+CoNH5OovYCHng8PaFg0YOwq3aCg94moXSk4qwtiXn
   w==;
IronPort-SDR: 3mqWA1DPzR7fqhAry3t0VFCWetaEGM9WDL7c3V12oy3JmKY5068IOZ0oA+5dr4/bJWz7ivDsaE
 WCIPwYvgl1+6DY2j9sDnftfY6XnwID159FHGpOOYUswz4AM7fvst2EVIqY1FBv4ibb09jxdar0
 H33L1h1TEyy4CDmZA1Sn6ulcdNjKNd+x9rTyUleL2xJZnznaOC0ijk5fDJt5N89nABKJi41Y+f
 Y4gWRuu8Rpn7SIbTqde+AGkX6qO3Sa9W4bczle3LtEw18aBw3+BLAPrQnY0uXVcO838HX6AXEO
 gNY=
X-IronPort-AV: E=Sophos;i="5.70,437,1574092800"; 
   d="scan'208";a="131227885"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2020 23:24:47 +0800
IronPort-SDR: W9QxjDCvzs4Eg+EKXvo0+dnrL+GjRwKJelssoKA4d5yBP3DSXEcdPv7Ly7vnwwm1UH6PoFeIkM
 pp9DX0RSosE7qlthCnulAMX27nVHePuTMdKsQJ/BXo4xIQQvEBfs2Ji1EhOea8yxNSSGUUjyuj
 cGkI42l/k9qpmr6d8APP/0IkSka5SNRq8JeYOdVU0UxUavtm+8/Qp9flKjPw3CBvYP6wvopEgL
 /8Uk26CYIDLWYmYWKJ16TpPjPxdg4UTc4a96/V8A6vbh+sFh5UHyBf1qHEOXW07JwrB3lxaD7U
 9pEuRIVhcrVKiKyxPaYwRogO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 07:17:34 -0800
IronPort-SDR: zxPZPllmfHYm4IEqkF+jkVI8qOSpXLjHxYL+qDmmIEXWkc1a8L6vXEusaT8FUIScLzfSHzhS9A
 NVSFhSqF5nXRMKlM+EMk8XhogWdmNXFJcV6rklAWqKDT/Xjk/Lh4CPHUig/Ze6axKklSTyR+R6
 Pj3LsKPNnUvk3Xgwu7GAp2uEvvMXzWgKLggT5Z17XvALVVzA3CSPNCXnEYbfeqt6wLSSqfV6v5
 xreUTSK2xFOq0+OYXgkfG1TamcvFXmOEWC+XQUaA6twGDj6WetulW/LeRqRbqU1BCwuPOxwo+h
 VjA=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Feb 2020 07:24:45 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v8 2/8] btrfs: don't kmap() pages from block devices
Date:   Fri, 14 Feb 2020 00:24:30 +0900
Message-Id: <20200213152436.13276-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213152436.13276-1-johannes.thumshirn@wdc.com>
References: <20200213152436.13276-1-johannes.thumshirn@wdc.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>

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

