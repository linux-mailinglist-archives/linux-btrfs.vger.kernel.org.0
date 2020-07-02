Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D40E212517
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgGBNqy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:46:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:45806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729047AbgGBNqx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 09:46:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CE2CBADC4;
        Thu,  2 Jul 2020 13:46:52 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 02/10] btrfs: raid56: Remove redundant check in rbio_add_io_page
Date:   Thu,  2 Jul 2020 16:46:42 +0300
Message-Id: <20200702134650.16550-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702134650.16550-1-nborisov@suse.com>
References: <20200702134650.16550-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The merging logic is always executed if the current stripe's device
is not missing. So there's no point in duplicating the check. Simply
remove it, while at it reduce the scope of the 'last_end' variable.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/raid56.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 4efd9ed1a30e..f21bab45b7ce 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1083,7 +1083,6 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
 			    unsigned long bio_max_len)
 {
 	struct bio *last = bio_list->tail;
-	u64 last_end = 0;
 	int ret;
 	struct bio *bio;
 	struct btrfs_bio_stripe *stripe;
@@ -1098,15 +1097,14 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
 
 	/* see if we can add this page onto our existing bio */
 	if (last) {
-		last_end = (u64)last->bi_iter.bi_sector << 9;
+		u64 last_end = (u64)last->bi_iter.bi_sector << 9;
 		last_end += last->bi_iter.bi_size;
 
 		/*
 		 * we can't merge these if they are from different
 		 * devices or if they are not contiguous
 		 */
-		if (last_end == disk_start && stripe->dev->bdev &&
-		    !last->bi_status &&
+		if (last_end == disk_start && !last->bi_status &&
 		    last->bi_disk == stripe->dev->bdev->bd_disk &&
 		    last->bi_partno == stripe->dev->bdev->bd_partno) {
 			ret = bio_add_page(last, page, PAGE_SIZE, 0);
-- 
2.17.1

