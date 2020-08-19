Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444F7249BF5
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Aug 2020 13:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgHSLi0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 07:38:26 -0400
Received: from smtp.h3c.com ([60.191.123.56]:18397 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbgHSLiZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 07:38:25 -0400
X-Greylist: delayed 4563 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Aug 2020 07:38:23 EDT
Received: from h3cspam01-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam01-ex.h3c.com with ESMTP id 07JAMIto012891
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 18:22:18 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam01-ex.h3c.com with ESMTPS id 07JALZed012120
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Aug 2020 18:21:35 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 19 Aug 2020 18:21:38 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] btrfs: prevent hung check firing during long sync IO
Date:   Wed, 19 Aug 2020 18:14:51 +0800
Message-ID: <20200819101451.24266-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 07JALZed012120
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For sync and flush io, it may take long time to complete.
So it's better to use wait_for_completion_io_timeout() in a
while loop to avoid prevent hung check and crash(when set
/proc/sys/kernel/hung_task_panic).

This is similar to prevent hung task check in submit_bio_wait(),
blk_execute_rq().

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 fs/btrfs/disk-io.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9ae25f632..1eb560de0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -17,6 +17,7 @@
 #include <linux/error-injection.h>
 #include <linux/crc32c.h>
 #include <linux/sched/mm.h>
+#include <linux/sched/sysctl.h>
 #include <asm/unaligned.h>
 #include <crypto/hash.h>
 #include "ctree.h"
@@ -3699,12 +3700,21 @@ static void write_dev_flush(struct btrfs_device *device)
 static blk_status_t wait_dev_flush(struct btrfs_device *device)
 {
 	struct bio *bio = device->flush_bio;
+	unsigned long hang_check;
 
 	if (!test_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state))
 		return BLK_STS_OK;
 
 	clear_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state);
-	wait_for_completion_io(&device->flush_wait);
+
+	/* Prevent hang_check timer from firing at us during very long I/O */
+	hang_check = sysctl_hung_task_timeout_secs;
+	if (hang_check)
+		while (!wait_for_completion_io_timeout(&device->flush_wait,
+						hang_check * (HZ/2)))
+			;
+	else
+		wait_for_completion_io(&device->flush_wait);
 
 	return bio->bi_status;
 }
-- 
2.17.1

