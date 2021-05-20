Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9836E389DB3
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 08:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhETGYi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 02:24:38 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:32509 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhETGYh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 02:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621491796; x=1653027796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sR7awTp6tvG6knNm/CLdZaoHbIxGL6Q0IVY+Ihe8dnQ=;
  b=itKJWnXky9TMylvyorybEyc0OCCelUR9fO/WQMz1Ix6N+8MnjEB+GULz
   hFFiOVZC2jaz2W+s5B+lFniOFA6nediQDlFJrgA0iAvfULbONJ5M5a5GS
   g+PMzfnIvZjKajHSzs8j7GDneRSLonvmfNW0/5Dupyw/DKUIfuEUYCRc+
   WbzKyxhD9QP5TQQVBqteBJgKWjQDH5At7Ua8DK+T5Pf4vI9ff4MAKcI11
   2+OfDMaYGP2HWAqn7dYEe7kvXJCkuXFYrry30RFyPfU4Odpuv4R+1Holv
   Um6hnMrToabLul1Xe/CawQ5J3+tohMZKf2vV2mI+rMeWy5dFzf6HEaMyg
   g==;
IronPort-SDR: 9bASrgzLmxOlU/CX1kl+QdrIb0yJ5FQE7CG/8AesBLxu2/y9AJ5M+C1ardeuX0q8ukdpELpmq5
 D2mUOkTX5vIrPnXhg2Zj/k1zeyHoy/6gY7amwrSzKeBM/IfIu2bsKKWMJrTKMXkcEHNlq+Q1HW
 o+TqAN+mXDFk8lv0stFBUuGz8q3W7K3/wgx/iCc+jyUCQAWwTrv3PmFtSqsWJvHpVwfZD4QEhX
 VY9mwY58ZfpELMvKv9lVZUA1Mk1HgDleJERa466T6Mb/YhHO49REtVMMS+dV+CZFMdU+g+LFVA
 rDw=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="280053549"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 14:23:16 +0800
IronPort-SDR: wNMHIgvJSHN4K0fFz+zwzc+DoMvJEzf07ocolkHAzbJZUbMW4w0rZv2f5pAYsBELXViYuPodk9
 KwfBbgCFCjx+ySCKioKJPcsI66z8+M404fKNuAhk1SLaQtmGeYkfiossmflAtxB8LDLMbBoeVB
 mTorJUQxIbU+/sXA3ISTMC/Lg0epZQ7NJj/vbunVrGW4jt/wKN5oMPOoJ3CzB+2qYqEaw9F1DC
 mpjXO5hMLivdme0MrVd2d8caqCDubFnxEPEDugWOTauBlRKtS1PMhPGQrp5LbHLt+qc5XBQ2ZI
 LQDM69fqVOyXz0+wow73sGBZ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 23:01:39 -0700
IronPort-SDR: +cA50KmUZEek1zNyKbgHSwJq3ivCCzPmFEpIZhoxWBWiW6RTI78wxdnlRdBL6dNfZ1rXoDbLa4
 5Y6eVkCh2SE0iMIfEbQB5FJPJKtfAYixeEWkQUAmSrROSZmOTcTOxLIA/E4iw5KMYAn3ulNeqa
 PZfBy/Vd+gf8uZADUW2YvFUnwnp42tuFWmuifVNx3BfddIrJF+O0+NUPqC2Tr7TSsfh3exEmtE
 dasoPnFOKq7/i36mTcSznyUuMjEI2Sp3YwbpaP+Z1gDJRLBzDsZ3Bm3queylYlgWO+UtnlJ/9m
 iWI=
WDCIronportException: Internal
Received: from wdsc_char_051.sc.wdc.com (HELO xfs.sc.wdc.com) ([10.4.170.150])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 May 2021 23:23:16 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     axboe@kernel.dk, mb@lightnvm.io, martin.petersen@oracle.com,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        johannes.thumshirn@wdc.com, ming.lei@redhat.com, osandov@fb.com,
        willy@infradead.org, jefflexu@linux.alibaba.com, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 2/8] block: fix return type of bio_add_pc_page()
Date:   Wed, 19 May 2021 23:22:49 -0700
Message-Id: <20210520062255.4908-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
References: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix bio_add_pc_page() return type to unsigned int as it returns the
length which is of type unsigned int and not int.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/bio.c         | 5 +++--
 include/linux/bio.h | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 531dbf15c0d9..803a0b5894bc 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -799,8 +799,9 @@ unsigned int bio_add_hw_page(struct request_queue *q, struct bio *bio,
  *
  * This should only be used by passthrough bios.
  */
-int bio_add_pc_page(struct request_queue *q, struct bio *bio,
-		struct page *page, unsigned int len, unsigned int offset)
+unsigned int bio_add_pc_page(struct request_queue *q, struct bio *bio,
+			     struct page *page, unsigned int len,
+			     unsigned int offset)
 {
 	bool same_page = false;
 	return bio_add_hw_page(q, bio, page, len, offset,
diff --git a/include/linux/bio.h b/include/linux/bio.h
index a0b4cfdf62a4..72b28d06064c 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -467,8 +467,8 @@ extern void bio_reset(struct bio *);
 void bio_chain(struct bio *, struct bio *);
 
 extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
-extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
-			   unsigned int, unsigned int);
+unsigned int bio_add_pc_page(struct request_queue *, struct bio *,
+			     struct page *, unsigned int, unsigned int);
 int bio_add_zone_append_page(struct bio *bio, struct page *page,
 			     unsigned int len, unsigned int offset);
 bool __bio_try_merge_page(struct bio *bio, struct page *page,
-- 
2.24.0

