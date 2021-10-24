Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689A943866F
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Oct 2021 05:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhJXDfA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Oct 2021 23:35:00 -0400
Received: from out20-87.mail.aliyun.com ([115.124.20.87]:47132 "EHLO
        out20-87.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhJXDe7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Oct 2021 23:34:59 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1369999|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00928972-0.000809152-0.989901;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.LgqBnXw_1635046357;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.LgqBnXw_1635046357)
          by smtp.aliyun-inc.com(10.147.41.158);
          Sun, 24 Oct 2021 11:32:37 +0800
From:   wangyugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Cc:     wangyugui <wangyugui@e16-tech.com>
Subject: [PATCH] btrfs: fix a check-integrity warning on write caching disabled disk
Date:   Sun, 24 Oct 2021 11:32:37 +0800
Message-Id: <20211024033237.23662-1-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

xfstest/btrfs/220 tigger a check-integrity warning
  btrfs: attempt to write superblock which references block which is not flushed
    out of disk's write cache (block flush_gen=1, dev->flush_gen=0)!
  WARNING: at fs/btrfs/check-integrity.c:2196
    btrfsic_process_written_superblock+0x22a/0x2a0 [btrfs]
when
1) CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
2) on a disk with WCE=0

When a disk has write caching disabled, we skip submission of a bio
with flush and sync requests before writing the superblock, since
it's not needed. However when the integrity checker is enabled,
this results in reports that there are metadata blocks referred
by a superblock that were not properly flushed. So don't skip the
bio submission only when the integrity checker is enabled
for the sake of simplicity, since this is a debug tool and
not meant for use in non-debug builds.

Signed-off-by: wangyugui <wangyugui@e16-tech.com>
---
Changes since v1:
- update the changlog/code comment. (Filipe Manana)
- var(struct request_queue *q) is only needed when
   !CONFIG_BTRFS_FS_CHECK_INTEGRITY
---
 fs/btrfs/disk-io.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 355ea88d5c5f..4ef06d0555b0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3968,11 +3968,23 @@ static void btrfs_end_empty_barrier(struct bio *bio)
  */
 static void write_dev_flush(struct btrfs_device *device)
 {
-	struct request_queue *q = bdev_get_queue(device->bdev);
 	struct bio *bio = device->flush_bio;
 
+	#ifndef CONFIG_BTRFS_FS_CHECK_INTEGRITY
+	/*
+	* When a disk has write caching disabled, we skip submission of a bio
+	* with flush and sync requests before writing the superblock, since
+	* it's not needed. However when the integrity checker is enabled,
+	* this results in reports that there are metadata blocks referred
+	* by a superblock that were not properly flushed. So don't skip the
+	* bio submission only when the integrity checker is enabled
+	* for the sake of simplicity, since this is a debug tool and
+	* not meant for use in non-debug builds.
+	*/
+	struct request_queue *q = bdev_get_queue(device->bdev);
 	if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags))
 		return;
+	#endif
 
 	bio_reset(bio);
 	bio->bi_end_io = btrfs_end_empty_barrier;
-- 
2.32.0

