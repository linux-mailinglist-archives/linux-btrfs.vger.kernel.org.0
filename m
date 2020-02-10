Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D15E15825E
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 19:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgBJSce (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 13:32:34 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:25711 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgBJSce (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 13:32:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581359553; x=1612895553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vQK7f590uXyS4KfFENEdWXR1w8x+Y6JgvW+SsUuXZXs=;
  b=nXO8UEheYK6KVr9jG0Tmb6h865P1qKAanD/yOxKvCB9qw+M/9al92SEn
   xz1kHd4os+0bhrZm9FShxHeipnAJV7voMEYIztNtQRxZFAyIAm7vKKCMo
   QscwLHa3GmGPka8SL59xrAnXGfeSeP8+f3rvOrNIPL+V5MqE0Atz0Tygv
   HXe1Q/n379Np0NZ37h/8e8SjbdNZ/wqlwk6ukjF4jcQlYFXsBjXQPPW8P
   Y/sa4iG3Mwo4mAt+JP2FuUfRrzK1y3tiIAGR8v5YTiLHOQgS/oZs0jEkn
   jSRm5UH0sZ2qFurAJ4lTWsk5OlJCBzD+Lk65Q84NS9qK5Roh/UBn+Zgrk
   g==;
IronPort-SDR: 7r3xajdUuRdrbHpu3FxDELlHBXMp9xjr7U2XVD4XjhOuNOpe0T7SLoYgpsdFA+1uQCTDRk8yD+
 J2pZTXzngGyqyfxRFQbfjrwGKsUaTPwd/w6h9LZLEQ+hwzpyG4mLqSIOJXvpZ6LHix7Iqaz5dY
 hrRNpFA+Ns3ANIgDTgtwGKQ2OK15UJ4K28R6fKdZ1BNNotLE2ouG3Py8t8FvgfgH3DUn4UbEex
 v72HWWuo8Hi5yfLBMTkuknCP8mcGi67AKH04dLpkSiNrM+mGMZDrnayTaznsbxz7yXkA6+xlDI
 Rg8=
X-IronPort-AV: E=Sophos;i="5.70,425,1574092800"; 
   d="scan'208";a="237529180"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2020 02:32:33 +0800
IronPort-SDR: Wn04wXPxUH2fcgd2V4/IxMlbiJkHn4mnM9VpA7XymglQILGwI2vGiU/uXx2hsgYpA5wdBLepyh
 piWH0XdqlVdBjvpY2fOZ5bNMGfZOesoz+HRzDwl3gnfqKnHA5FjqUK5NDc4Jje4+P4fwzodvVO
 /r9kg3c8pcZnx4Rxg/RiVCTPKW5WOgSyiSHTrQIDrN9BZ9F/O5kebpZpgDpM7idFO4v+avNyOs
 3s7fMKuh6VzIUexoD0S3ow4z5+KhX8sQ0kxgNFjcX4gHdO6UtaZzoeNNprX6JPduGsB5pPuS3U
 KiJRKhcU78qQ9RLEwOcmtKL4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 10:25:25 -0800
IronPort-SDR: XRcdI8cpoKVYBoWR3pVKhxk6N4Ya3W1Ypz5tipTpKPuL4Z8y8iSKahNviwOSF+EPwPuKFPoWdJ
 SrleKFFWTZbCw9DuAgmhI16ZiXSyVYynTAxQ52JtOB9J0Xf77BlyjmNRVtdsim+FSqDFXTvxox
 uzDRuYQhz8b669fkZUw0OUo6znPEEGQW59GM4mMj9ecHl3F5armT731V8uRQFXYIahUbFUPnJ7
 Z5wYzBpQIARqSCi10Jo580QDdcgVYQvcjhe2nXmEWDGJzg0HmIoe0y79qF3qQAXUuSFuyYni97
 a/g=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Feb 2020 10:32:32 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 2/7] btrfs: don't kmap() pages from block devices
Date:   Tue, 11 Feb 2020 03:32:20 +0900
Message-Id: <20200210183225.10137-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200210183225.10137-1-johannes.thumshirn@wdc.com>
References: <20200210183225.10137-1-johannes.thumshirn@wdc.com>
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

