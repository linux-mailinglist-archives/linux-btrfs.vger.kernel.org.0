Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F982389DCC
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 08:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhETGZS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 02:25:18 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:61904 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbhETGZS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 02:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621491838; x=1653027838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wp6HwlIcg67ctqyVvHN7QMtvugFozUtOOg6ywvP2lgA=;
  b=LKQGu6PlM4phPeMcSNc03sSZ3t20u7/r5ymix/PfMnwyoeg9zY/rU7zA
   e19UQM4qTcyQS3JQ1p/w6mNYASWmKN7Qe+U3S/5bZx8ZsPEEGVKfqYPW9
   A6zckwPMaL05LLIQej9N13Ru88aTo3GdAojWhNJ1VQn2UTb9A7yn6n//u
   Pb/R6HF49SUR3a0JAUisoskX9O+CqD8zzasnvaZBcYNXYsPn5LV9JumDU
   QzBTTWfaABdQsi3bQ1DJVHix5Se5DRoZk9O5LUzTGpygWF5pjO+ZtEaQH
   GY/NvLxgklY9t+4tJm1LAZJDCvF5CxFemA0HfudUxLgjVpoDE/bmM8zcR
   A==;
IronPort-SDR: 6U1IpFbD++LZRsvm0qUmRWpdg0soqgFdDvo8A75wsUYFQRTlDHJ77Sa/qJrVrxj4dR1RhcQVYK
 cjNIg+k2PoAvXxnodtptoP8xGflgEpE6P7+G0aBXG4vBssi28e7aAwHH4zkJQKnJrdMArcsHIo
 V8xqDL2FXRU3JZmrNbgWyuNvjpBL/iNVOhRUZpW5+lVzqde0mfb5zQMcK39NSN6tqKqki/8X9S
 6BzeNp0/XNBjjgIdjOUj+1uVMVz+YSpIA5Fu2v7oHWnYMbXej2EduT/dczpNNJBf/2rn9SmWyB
 i4k=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="169351439"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 14:23:58 +0800
IronPort-SDR: J82/g+aE3N3k32qb/6ktjHN3i8uo47juXMP12tVcKnAsAeLXm8qAmfUgRr7J/S2YOB7QZkxcDu
 iIsLeiyD0gR5YWWCBGc/qAORPG4jnCN3AVoNffkLUyC7IAAIkAv0q6Y8wEfAONr9e2SyrfMbjW
 dXThIcpmJOjIF8WgBVBOPTrqY821QHoDrZg/HJuwzDfKWp6HXoXnMaDOqXkJaTtNJE+/96gj0l
 gVxCNJ6FH6yPVeNmn//SvWslQPSLlvXN4Xz6I5uuxjsKpDICPw9YHsRHU22Bx53oz/038NaoBB
 C0n/U4NfLYoGzHDhN9hXgLIq
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 23:02:20 -0700
IronPort-SDR: WpzxWyMAbGCiCjCDX1m2OE/AlVYYI1Yp3LjmHmYPU9Z0UBKpknSQyelu3Yd7YCKQXx9MvmqtVW
 0KPUMbVojiCh8NAfembYOfqATi1ga3LdqAIyniinkmzV7MVbZ9muVS3LBDkmeSlBZQiATT0zAD
 U4rIhpY4tolb8m7ttIlqBfvbJaI40lLnQwV1voqBm5YmrmMAoPgs+iFe9zsmqkjIz7QRU6uWec
 fqVUNSqtcsKLiPtM8zCe+CJ4zOCD2Nxb9VbxvM1reXK5M6UiQRCk1q3H/PR7Pl9mcUmmQxID5c
 uOY=
WDCIronportException: Internal
Received: from wdsc_char_051.sc.wdc.com (HELO xfs.sc.wdc.com) ([10.4.170.150])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 May 2021 23:23:57 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     axboe@kernel.dk, mb@lightnvm.io, martin.petersen@oracle.com,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        johannes.thumshirn@wdc.com, ming.lei@redhat.com, osandov@fb.com,
        willy@infradead.org, jefflexu@linux.alibaba.com, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 8/8] block: fix variable type for zero pages
Date:   Wed, 19 May 2021 23:22:55 -0700
Message-Id: <20210520062255.4908-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
References: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Make variable bi_size unsigned int since bio_add_page() now returns
unsigned int.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 7b256131b20b..67062066c293 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -305,7 +305,7 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 	struct bio *bio = *biop;
-	int bi_size = 0;
+	unsigned int bi_size = 0;
 	unsigned int sz;
 
 	if (!q)
-- 
2.24.0

