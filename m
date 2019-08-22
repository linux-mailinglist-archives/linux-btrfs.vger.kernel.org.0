Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1C7498A32
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 06:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfHVEKm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 00:10:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4757 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725932AbfHVEKm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 00:10:42 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6AA24D5DC2ACA3025AB4;
        Thu, 22 Aug 2019 12:10:39 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 22 Aug 2019
 12:10:30 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH] fs/btrfs/raid56.c: remove set but not used variables 'p_stripe'
Date:   Thu, 22 Aug 2019 12:17:01 +0800
Message-ID: <1566447421-16137-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

fs/btrfs/raid56.c: In function finish_rmw:
fs/btrfs/raid56.c:1185:6: warning: variable p_stripe set but not used [-Wunused-but-set-variable]
fs/btrfs/raid56.c: In function finish_parity_scrub:
fs/btrfs/raid56.c:2343:6: warning: variable p_stripe set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/btrfs/raid56.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index f3d0576..2603f99 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1182,7 +1182,6 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 	int nr_data = rbio->nr_data;
 	int stripe;
 	int pagenr;
-	int p_stripe = -1;
 	int q_stripe = -1;
 	struct bio_list bio_list;
 	struct bio *bio;
@@ -1190,14 +1189,10 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)

 	bio_list_init(&bio_list);

-	if (rbio->real_stripes - rbio->nr_data == 1) {
-		p_stripe = rbio->real_stripes - 1;
-	} else if (rbio->real_stripes - rbio->nr_data == 2) {
-		p_stripe = rbio->real_stripes - 2;
+	if (rbio->real_stripes - rbio->nr_data == 2)
 		q_stripe = rbio->real_stripes - 1;
-	} else {
+	else if (rbio->real_stripes - rbio->nr_data != 1)
 		BUG();
-	}

 	/* at this point we either have a full stripe,
 	 * or we've read the full stripe from the drive.
@@ -2340,7 +2335,6 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 	int nr_data = rbio->nr_data;
 	int stripe;
 	int pagenr;
-	int p_stripe = -1;
 	int q_stripe = -1;
 	struct page *p_page = NULL;
 	struct page *q_page = NULL;
@@ -2351,14 +2345,10 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,

 	bio_list_init(&bio_list);

-	if (rbio->real_stripes - rbio->nr_data == 1) {
-		p_stripe = rbio->real_stripes - 1;
-	} else if (rbio->real_stripes - rbio->nr_data == 2) {
-		p_stripe = rbio->real_stripes - 2;
+	if (rbio->real_stripes - rbio->nr_data == 2)
 		q_stripe = rbio->real_stripes - 1;
-	} else {
+	else if (rbio->real_stripes - rbio->nr_data != 1)
 		BUG();
-	}

 	if (bbio->num_tgtdevs && bbio->tgtdev_map[rbio->scrubp]) {
 		is_replace = 1;
--
2.7.4

