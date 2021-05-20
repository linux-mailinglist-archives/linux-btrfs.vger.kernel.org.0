Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF443389DB7
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 08:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhETGYo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 02:24:44 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:34428 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhETGYo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 02:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621491803; x=1653027803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cq98Q4TNoXcvhzaG/L8JwnMdCWcDvxDn82lEph32H5A=;
  b=V7qdyzrfCDMD57ObSjd6qVGergkSJsreJuJ/TW/Pl6pLWZiZBGKLOx1n
   R4Domw70+p6IW2pMaN1Eig8+GDZ1ZiWJr3yCpMnnVKZvvwKVhOYb5rdpf
   X7t2oSwSygkr3D9VFylSPHnyw9hGukNvSQ0QY/u6NSajQ4gT40eCwpHzz
   BaU5P4WCTkWxu8MGSDUbn3Ekxz31yzYdcmQl+pfU+R2nUOw9L8utgv3yc
   8qn45QeBUKLI3b3wizwF3DWVz+absxlgdZkSW1ZVeXwLFtS7XDxTgRqC0
   cWe5N9Ke/u9WjJ8rQo/xtiiZSAzSnMSlDIlc/tZnS8Rz8sbt//fDZ/E8Y
   Q==;
IronPort-SDR: ctv2DqldVcLK+dX39iRBmdyEL+qT4LNFSzbx1+gyJ0oJZNVZ/1BitOy5ywZaT2X3BiZopTRIZm
 R+/eALl7YDVZ0lpJMpQfV9Q70DBCI9lKLcJ83bGqAaM2qoF19T/9s8K57R8uaVVK3OjMswp2Jy
 eyZpH48dNLWip59e5C6dcOZQapivZEm4Awrs+Y5ZIxsX1QTtflwfp+G8kpLfcADCzR7zdWu3s2
 fQSj0cW9WiczEUynHvcg4QavTEuIuVlEQrAftPiyuK92NTt6lHjWjryM9XeSF+jZjdHSJd0FvG
 GKA=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168116735"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 14:23:22 +0800
IronPort-SDR: AQLxtqfNx43M21xbimAdiMyv37wys4k5XTf6fpC5vRFFTUVZafwiGQ5RPZuN4SRsUJzwDcB2iT
 cmpY51VK//4fYI9J69VYteJkFXPaBCp5gU+Ye8Qh9ibObOH4dq15XzHAIb9jBvpIQ/hvkwTmSd
 53uiLt1avIFZI9zY5Qhb4vU8Dc1WPvIVxCqzm8w4hbXkb2eSnt89URYcmbxSRZYaD0T3hKic2s
 lmkFqEG1hOCva3uapErZDWNJGw25eI26vkIR+1NI6yAIJ4xyFvB18NajucVK3x3OJaXzmJIeVn
 1khwNyMWEJ81k4COpElM0Gcc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 23:01:46 -0700
IronPort-SDR: uI6KSgMQkV/rnmEu1CszatES/Ih3EpyY3Jfp+jBF8dKzY4PE+zQ1eCsa5IUK3OvK1oy0zMnm2z
 +uvpgvksAUkiKqn/dbr1q2CaYwmO3Aa28G0R8aVrUF5Kz41FlG3m1uJb7W53lUPthNMgC0FYfC
 19l1zthdKuiAIOP1dmnokIZT0ajZRGsu5dbj5Bo4L/zPXWH3flMO+18DW4RMjEh/dnZ/DefHDb
 ypZ1rgDOig8p5F2Us+RZ1LpYBSlRnMycRe1dtOTJbZoHcVc2SmPyEwy4Dpd/3X/dBzsZgff5AU
 VC4=
WDCIronportException: Internal
Received: from wdsc_char_051.sc.wdc.com (HELO xfs.sc.wdc.com) ([10.4.170.150])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 May 2021 23:23:23 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     axboe@kernel.dk, mb@lightnvm.io, martin.petersen@oracle.com,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        johannes.thumshirn@wdc.com, ming.lei@redhat.com, osandov@fb.com,
        willy@infradead.org, jefflexu@linux.alibaba.com, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 3/8] block: fix return type of bio_add_zone_append_page
Date:   Wed, 19 May 2021 23:22:50 -0700
Message-Id: <20210520062255.4908-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
References: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix bio_add_zone_append_page() return type to unsigned int as it
returns the length which is of type unsigned int and not int.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/bio.c         | 4 ++--
 include/linux/bio.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 803a0b5894bc..bc0e6e93ed58 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -825,8 +825,8 @@ EXPORT_SYMBOL(bio_add_pc_page);
  *
  * Returns: number of bytes added to the bio, or 0 in case of a failure.
  */
-int bio_add_zone_append_page(struct bio *bio, struct page *page,
-			     unsigned int len, unsigned int offset)
+unsigned int bio_add_zone_append_page(struct bio *bio, struct page *page,
+				      unsigned int len, unsigned int offset)
 {
 	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
 	bool same_page = false;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 72b28d06064c..548d6a3342c3 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -469,8 +469,8 @@ void bio_chain(struct bio *, struct bio *);
 extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
 unsigned int bio_add_pc_page(struct request_queue *, struct bio *,
 			     struct page *, unsigned int, unsigned int);
-int bio_add_zone_append_page(struct bio *bio, struct page *page,
-			     unsigned int len, unsigned int offset);
+unsigned int bio_add_zone_append_page(struct bio *bio, struct page *page,
+				      unsigned int len, unsigned int offset);
 bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off, bool *same_page);
 void __bio_add_page(struct bio *bio, struct page *page,
-- 
2.24.0

