Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 042721646AC
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 15:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgBSORk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 09:17:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:35298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgBSORk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 09:17:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 26694AEFB;
        Wed, 19 Feb 2020 14:17:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 60CD5DA70E; Wed, 19 Feb 2020 15:17:21 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: raid56: simplify tracking of Q stripe presence
Date:   Wed, 19 Feb 2020 15:17:20 +0100
Message-Id: <20200219141720.21549-1-dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are temporary variables tracking the index of P and Q stripes, but
none of them is really used as such, merely for determining if the Q
stripe is present. This leads to compiler warnings with
-Wunused-but-set-variable and has been reported several times.

fs/btrfs/raid56.c: In function ‘finish_rmw’:
fs/btrfs/raid56.c:1199:6: warning: variable ‘p_stripe’ set but not used [-Wunused-but-set-variable]
 1199 |  int p_stripe = -1;
      |      ^~~~~~~~
fs/btrfs/raid56.c: In function ‘finish_parity_scrub’:
fs/btrfs/raid56.c:2356:6: warning: variable ‘p_stripe’ set but not used [-Wunused-but-set-variable]
 2356 |  int p_stripe = -1;
      |      ^~~~~~~~

Replace the two variables with one that has a clear meaning and also get
rid of the warnings. The logic that verifies that there are only 2
valid cases is unchanged.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/raid56.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index a8e53c8e7b01..406b1efd3ba5 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1196,22 +1196,19 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 	int nr_data = rbio->nr_data;
 	int stripe;
 	int pagenr;
-	int p_stripe = -1;
-	int q_stripe = -1;
+	bool has_qstripe;
 	struct bio_list bio_list;
 	struct bio *bio;
 	int ret;
 
 	bio_list_init(&bio_list);
 
-	if (rbio->real_stripes - rbio->nr_data == 1) {
-		p_stripe = rbio->real_stripes - 1;
-	} else if (rbio->real_stripes - rbio->nr_data == 2) {
-		p_stripe = rbio->real_stripes - 2;
-		q_stripe = rbio->real_stripes - 1;
-	} else {
+	if (rbio->real_stripes - rbio->nr_data == 1)
+		has_qstripe = false;
+	else if (rbio->real_stripes - rbio->nr_data == 2)
+		has_qstripe = true;
+	else
 		BUG();
-	}
 
 	/* at this point we either have a full stripe,
 	 * or we've read the full stripe from the drive.
@@ -1255,7 +1252,7 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 		SetPageUptodate(p);
 		pointers[stripe++] = kmap(p);
 
-		if (q_stripe != -1) {
+		if (has_qstripe) {
 
 			/*
 			 * raid6, add the qstripe and call the
@@ -2353,8 +2350,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 	int nr_data = rbio->nr_data;
 	int stripe;
 	int pagenr;
-	int p_stripe = -1;
-	int q_stripe = -1;
+	bool has_qstripe;
 	struct page *p_page = NULL;
 	struct page *q_page = NULL;
 	struct bio_list bio_list;
@@ -2364,14 +2360,12 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 
 	bio_list_init(&bio_list);
 
-	if (rbio->real_stripes - rbio->nr_data == 1) {
-		p_stripe = rbio->real_stripes - 1;
-	} else if (rbio->real_stripes - rbio->nr_data == 2) {
-		p_stripe = rbio->real_stripes - 2;
-		q_stripe = rbio->real_stripes - 1;
-	} else {
+	if (rbio->real_stripes - rbio->nr_data == 1)
+		has_qstripe = false;
+	else if (rbio->real_stripes - rbio->nr_data == 2)
+		has_qstripe = true;
+	else
 		BUG();
-	}
 
 	if (bbio->num_tgtdevs && bbio->tgtdev_map[rbio->scrubp]) {
 		is_replace = 1;
@@ -2393,7 +2387,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 		goto cleanup;
 	SetPageUptodate(p_page);
 
-	if (q_stripe != -1) {
+	if (has_qstripe) {
 		q_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
 		if (!q_page) {
 			__free_page(p_page);
@@ -2416,8 +2410,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 		/* then add the parity stripe */
 		pointers[stripe++] = kmap(p_page);
 
-		if (q_stripe != -1) {
-
+		if (has_qstripe) {
 			/*
 			 * raid6, add the qstripe and call the
 			 * library function to fill in our p/q
-- 
2.25.0

