Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3C3389DAF
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 08:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhETGYb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 02:24:31 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49715 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhETGYa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 02:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621491789; x=1653027789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VGRek1gFfC/wRW7zk79gY062QbIZScEOrynJQdteIqg=;
  b=ledrMQzLZ0P1r6uKH6NPhZW2QzGXw2fVztPpWhMoNYwfi2RSaUfyZVwR
   1bT2xWKsCOrFBxu7PZHY+LOT4+KYv7P8mNct5nVriHP28iUPg4gdhqzT+
   w6N17n0uO43Qpgyfct438vzkVflydSrTPf4vZnjYAOLazpu+C+PNe1pO0
   0NSM22t1ZDe1xiIayIKPnCAvod3Izsjc/EAcYaf6P6wdIrVtjkJd2h/NO
   7CjEG/+V4ockdNhHE7+71pd4fFdhPMuYLz+pKDveWxox/IUhtWkbdVsHw
   MSbNs39u7SVlg3ONaMDfkh7aGzxYattKoYjEIP43NNREA+psyp/9UCW0+
   w==;
IronPort-SDR: Mj/FmcwrV+946VKIdJ/3MqzDoduWuaL8eC01r/PXWTcZ0nR7pNJ5ofYO/onKInTsxYuyibFc70
 BK8/PkT6HXloShKCLqHHL62XbaRTAJ3Q3HOcJBenVNIPjbWZmMvR4SXOWi35oVxMA5OmZREdi2
 +QOVEkR+hKFwY6IE+oLRrr904b3qqv+pEJ0ckBUJouR5zVj7vZSuuxPDXnyw02TWKJ29miuWPR
 q5IgRBMa0lkgmCwUIuA6zcAzNsT8nNgeGQuzBQ21xauf6cmER+020b9OTlK9r1SMmF0cHakq57
 IiE=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="173439983"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 14:23:09 +0800
IronPort-SDR: Kpg0V9LONdhGEwbCg3f7KaFkxf43XbfLBNsH8FapDpTfJxCGmooADTPUZETNzXwAqePbYaNIOf
 aJ46lLJ00iUuqVQYHvLKAfO9MebHojGi2taV/ACCbVx5ZsUp9ABKs2dH2eILqyQw/69RmRVkhr
 qAxxlfcBgll/KzYgRVMK6q0sYdS+d7CdcWMHkIbFi4rJfJ/ogGiL9zzu8goEis7wlTAFfUCQro
 KzZSRMZ7AkfRvlROX965hnfktGXmxlLCObjQboGW/OYCbmR9T6XM7+L4eg987C9oAmxfZJ4Ws/
 vHim/qUJVYfaWEH41aRCW1af
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 23:02:46 -0700
IronPort-SDR: dRngKsbH+q1CrRL2WQTxUMrY9YgNLOY68BEHkyuWRPYuzw2DRJAQIYajpLBnlUCxztHYgaNT7i
 2Ukcly0phu37Y1V2SmPnDJA0swchi5sOM6NhT8eSaG6+R2J2NJRvJwtotrphJgxusPzbpOedZ1
 sTkiE8rTX0s/UnjWSjoaE7uDawooRhJ2cSpFDsjJXBqTUGtXcWWYH0RBpKYkwOCtY8cbDHvUYt
 RWbWYR4T6ZFF5sDEHL2OUD5/4GtWQSaORduUWIR1tWQm98EToPFe1utEJ9c0TTYEDIIEjkRHDo
 KHM=
WDCIronportException: Internal
Received: from wdsc_char_051.sc.wdc.com (HELO xfs.sc.wdc.com) ([10.4.170.150])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 May 2021 23:23:09 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     axboe@kernel.dk, mb@lightnvm.io, martin.petersen@oracle.com,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        johannes.thumshirn@wdc.com, ming.lei@redhat.com, osandov@fb.com,
        willy@infradead.org, jefflexu@linux.alibaba.com, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 1/8] block: fix return type of bio_add_hw_page()
Date:   Wed, 19 May 2021 23:22:48 -0700
Message-Id: <20210520062255.4908-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
References: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix bio_add_hw_page() return type to unsigned int as it returns the
length which is of type unsigned int and not int.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/bio.c | 7 ++++---
 block/blk.h | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 44205dfb6b60..531dbf15c0d9 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -743,9 +743,10 @@ static bool bio_try_merge_hw_seg(struct request_queue *q, struct bio *bio,
  * Add a page to a bio while respecting the hardware max_sectors, max_segment
  * and gap limitations.
  */
-int bio_add_hw_page(struct request_queue *q, struct bio *bio,
-		struct page *page, unsigned int len, unsigned int offset,
-		unsigned int max_sectors, bool *same_page)
+unsigned int bio_add_hw_page(struct request_queue *q, struct bio *bio,
+			     struct page *page, unsigned int len,
+			     unsigned int offset, unsigned int max_sectors,
+			     bool *same_page)
 {
 	struct bio_vec *bvec;
 
diff --git a/block/blk.h b/block/blk.h
index 8b3591aee0a5..a8930ecd4a5e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -355,8 +355,9 @@ int bdev_del_partition(struct block_device *bdev, int partno);
 int bdev_resize_partition(struct block_device *bdev, int partno,
 		sector_t start, sector_t length);
 
-int bio_add_hw_page(struct request_queue *q, struct bio *bio,
-		struct page *page, unsigned int len, unsigned int offset,
-		unsigned int max_sectors, bool *same_page);
+unsigned int bio_add_hw_page(struct request_queue *q, struct bio *bio,
+			     struct page *page, unsigned int len,
+			     unsigned int offset, unsigned int max_sectors,
+			     bool *same_page);
 
 #endif /* BLK_INTERNAL_H */
-- 
2.24.0

