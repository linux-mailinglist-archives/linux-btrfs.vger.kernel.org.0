Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10644373A3
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Oct 2021 10:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhJVI25 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Oct 2021 04:28:57 -0400
Received: from out20-97.mail.aliyun.com ([115.124.20.97]:54612 "EHLO
        out20-97.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbhJVI24 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Oct 2021 04:28:56 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2796879|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00464205-0.000276317-0.995082;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.Lg.IdEP_1634891197;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Lg.IdEP_1634891197)
          by smtp.aliyun-inc.com(10.147.41.231);
          Fri, 22 Oct 2021 16:26:37 +0800
From:   wangyugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org, l@damenly.su
Cc:     wangyugui <wangyugui@e16-tech.com>
Subject: [PATCH] btrfs: fix CHECK_INTEGRITY warning when !QUEUE_FLAG_WC
Date:   Fri, 22 Oct 2021 16:26:37 +0800
Message-Id: <20211022082637.50880-1-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211022130742.7119.409509F4@e16-tech.com>
References: <20211022130742.7119.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

xfstest/btrfs/220 tigger a check-integrity warning when
1) CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
2) xfstest/btrfs/220 run on a disk with WCE=1

In write_dev_flush(), submit_bio(REQ_SYNC | REQ_PREFLUSH) can be skipped when
!QUEUE_FLAG_WC. but btrfsic_submit_bio() != submit_bio() when CONFIG_BTRFS_FS_CHECK_INTEGRITY

Signed-off-by: wangyugui <wangyugui@e16-tech.com>
---
 fs/btrfs/disk-io.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 355ea88..7b17357 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3971,8 +3971,14 @@ static void write_dev_flush(struct btrfs_device *device)
 	struct request_queue *q = bdev_get_queue(device->bdev);
 	struct bio *bio = device->flush_bio;
 
+	#ifndef CONFIG_BTRFS_FS_CHECK_INTEGRITY
+	/*
+	* submit_bio(REQ_SYNC | REQ_PREFLUSH) can be skipped when !QUEUE_FLAG_WC.
+	* but btrfsic_submit_bio() != submit_bio() when CONFIG_BTRFS_FS_CHECK_INTEGRITY
+	*/
 	if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags))
 		return;
+	#endif
 
 	bio_reset(bio);
 	bio->bi_end_io = btrfs_end_empty_barrier;
-- 
2.32.0

