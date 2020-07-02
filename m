Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1A721251B
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgGBNq5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:46:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:45832 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729434AbgGBNqy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 09:46:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 83ADBAF55;
        Thu,  2 Jul 2020 13:46:53 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 05/10] btrfs: raid56: Use in_range where applicable
Date:   Thu,  2 Jul 2020 16:46:45 +0300
Message-Id: <20200702134650.16550-6-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702134650.16550-1-nborisov@suse.com>
References: <20200702134650.16550-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While at it use the opportunity to simplify find_logical_bio_stripe by
reducing the scope of 'stripe_start' variable and squash the
sector-to-bytes conversion on one line.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/raid56.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index d9415a22617b..d89dd3030bba 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1349,7 +1349,6 @@ static int find_bio_stripe(struct btrfs_raid_bio *rbio,
 			   struct bio *bio)
 {
 	u64 physical = bio->bi_iter.bi_sector;
-	u64 stripe_start;
 	int i;
 	struct btrfs_bio_stripe *stripe;
 
@@ -1357,9 +1356,7 @@ static int find_bio_stripe(struct btrfs_raid_bio *rbio,
 
 	for (i = 0; i < rbio->bbio->num_stripes; i++) {
 		stripe = &rbio->bbio->stripes[i];
-		stripe_start = stripe->physical;
-		if (physical >= stripe_start &&
-		    physical < stripe_start + rbio->stripe_len &&
+		if (in_range(physical, stripe->physical, rbio->stripe_len) &&
 		    stripe->dev->bdev &&
 		    bio->bi_disk == stripe->dev->bdev->bd_disk &&
 		    bio->bi_partno == stripe->dev->bdev->bd_partno) {
@@ -1377,18 +1374,13 @@ static int find_bio_stripe(struct btrfs_raid_bio *rbio,
 static int find_logical_bio_stripe(struct btrfs_raid_bio *rbio,
 				   struct bio *bio)
 {
-	u64 logical = bio->bi_iter.bi_sector;
-	u64 stripe_start;
+	u64 logical = bio->bi_iter.bi_sector << 9;
 	int i;
 
-	logical <<= 9;
-
 	for (i = 0; i < rbio->nr_data; i++) {
-		stripe_start = rbio->bbio->raid_map[i];
-		if (logical >= stripe_start &&
-		    logical < stripe_start + rbio->stripe_len) {
+		u64 stripe_start = rbio->bbio->raid_map[i];
+		if (in_range(logical, stripe_start, rbio->stripe_len))
 			return i;
-		}
 	}
 	return -1;
 }
-- 
2.17.1

