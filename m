Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A48C1437B2
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 08:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgAUHe0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 02:34:26 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:51053 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727453AbgAUHe0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 02:34:26 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0ToHCg0j_1579592053;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHCg0j_1579592053)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 15:34:13 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs/raid56: remove unused actions
Date:   Tue, 21 Jan 2020 15:34:10 +0800
Message-Id: <1579592050-86280-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

No one care p_stripe in its functions. Guess it's safe to remove.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Chris Mason <clm@fb.com> 
Cc: Josef Bacik <josef@toxicpanda.com> 
Cc: David Sterba <dsterba@suse.com> 
Cc: linux-btrfs@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 fs/btrfs/raid56.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index a8e53c8e7b01..fbee5681e690 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1196,7 +1196,6 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 	int nr_data = rbio->nr_data;
 	int stripe;
 	int pagenr;
-	int p_stripe = -1;
 	int q_stripe = -1;
 	struct bio_list bio_list;
 	struct bio *bio;
@@ -1204,14 +1203,10 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 
 	bio_list_init(&bio_list);
 
-	if (rbio->real_stripes - rbio->nr_data == 1) {
-		p_stripe = rbio->real_stripes - 1;
-	} else if (rbio->real_stripes - rbio->nr_data == 2) {
-		p_stripe = rbio->real_stripes - 2;
+	if (rbio->real_stripes - rbio->nr_data == 2)
 		q_stripe = rbio->real_stripes - 1;
-	} else {
+	else
 		BUG();
-	}
 
 	/* at this point we either have a full stripe,
 	 * or we've read the full stripe from the drive.
-- 
1.8.3.1

