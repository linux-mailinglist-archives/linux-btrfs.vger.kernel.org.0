Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6831811E352
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2019 13:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfLMMI7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 07:08:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7686 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726851AbfLMMI6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 07:08:58 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F0669C5A3E685E51EC9F;
        Fri, 13 Dec 2019 20:08:54 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Fri, 13 Dec 2019
 20:08:48 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC:     <yukuai3@huawei.com>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>, <linux-btrfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] btrfs: raid56: remove set but not used variable 'p_stripe'
Date:   Fri, 13 Dec 2019 20:08:21 +0800
Message-ID: <20191213120821.7239-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

fs/btrfs/raid56.c: In function ‘finish_rmw’:
fs/btrfs/raid56.c:1199:6: warning: variable ‘p_stripe’ set
but not used [-Wunused-but-set-variable]
fs/btrfs/raid56.c: In function ‘finish_parity_scrub’:
fs/btrfs/raid56.c:2356:6: warning: variable ‘p_stripe’ set
but not used [-Wunused-but-set-variable]

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 fs/btrfs/raid56.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index a8e53c8e7b01..b59999b02516 100644
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
+	else if (rbio->real_stripes - rbio->nr_data != 1)
 		BUG();
-	}
 
 	/* at this point we either have a full stripe,
 	 * or we've read the full stripe from the drive.
@@ -2353,7 +2348,6 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 	int nr_data = rbio->nr_data;
 	int stripe;
 	int pagenr;
-	int p_stripe = -1;
 	int q_stripe = -1;
 	struct page *p_page = NULL;
 	struct page *q_page = NULL;
@@ -2364,14 +2358,10 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 
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
2.17.2

