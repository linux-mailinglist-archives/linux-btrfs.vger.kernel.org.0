Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9C621251C
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgGBNq5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:46:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:45814 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbgGBNqy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 09:46:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 137E0ADD6;
        Thu,  2 Jul 2020 13:46:53 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 03/10] btrfs: raid56: Assign bio in while()
Date:   Thu,  2 Jul 2020 16:46:43 +0300
Message-Id: <20200702134650.16550-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702134650.16550-1-nborisov@suse.com>
References: <20200702134650.16550-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Unify the style in the file such that return value of bio_list_pop
is assigned directly in the while loop. This is in line with the rest
of the kernel.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/raid56.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index f21bab45b7ce..a7ae4d8a47ce 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1324,11 +1324,7 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 	atomic_set(&rbio->stripes_pending, bio_list_size(&bio_list));
 	BUG_ON(atomic_read(&rbio->stripes_pending) == 0);
 
-	while (1) {
-		bio = bio_list_pop(&bio_list);
-		if (!bio)
-			break;
-
+	while ((bio = bio_list_pop(&bio_list))) {
 		bio->bi_private = rbio;
 		bio->bi_end_io = raid_write_end_io;
 		bio->bi_opf = REQ_OP_WRITE;
@@ -1566,11 +1562,7 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 	 * not to touch it after that
 	 */
 	atomic_set(&rbio->stripes_pending, bios_to_read);
-	while (1) {
-		bio = bio_list_pop(&bio_list);
-		if (!bio)
-			break;
-
+	while ((bio = bio_list_pop(&bio_list))) {
 		bio->bi_private = rbio;
 		bio->bi_end_io = raid_rmw_end_io;
 		bio->bi_opf = REQ_OP_READ;
@@ -2112,11 +2104,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 	 * not to touch it after that
 	 */
 	atomic_set(&rbio->stripes_pending, bios_to_read);
-	while (1) {
-		bio = bio_list_pop(&bio_list);
-		if (!bio)
-			break;
-
+	while ((bio = bio_list_pop(&bio_list))) {
 		bio->bi_private = rbio;
 		bio->bi_end_io = raid_recover_end_io;
 		bio->bi_opf = REQ_OP_READ;
@@ -2481,11 +2469,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 
 	atomic_set(&rbio->stripes_pending, nr_data);
 
-	while (1) {
-		bio = bio_list_pop(&bio_list);
-		if (!bio)
-			break;
-
+	while ((bio = bio_list_pop(&bio_list))) {
 		bio->bi_private = rbio;
 		bio->bi_end_io = raid_write_end_io;
 		bio->bi_opf = REQ_OP_WRITE;
@@ -2663,11 +2647,7 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
 	 * not to touch it after that
 	 */
 	atomic_set(&rbio->stripes_pending, bios_to_read);
-	while (1) {
-		bio = bio_list_pop(&bio_list);
-		if (!bio)
-			break;
-
+	while ((bio = bio_list_pop(&bio_list))) {
 		bio->bi_private = rbio;
 		bio->bi_end_io = raid56_parity_scrub_end_io;
 		bio->bi_opf = REQ_OP_READ;
-- 
2.17.1

