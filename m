Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C7E622149
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Nov 2022 02:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiKIBTc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Nov 2022 20:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKIBTb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Nov 2022 20:19:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ECC5F85D
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Nov 2022 17:19:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A738F22560;
        Wed,  9 Nov 2022 01:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667956768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=IL/aDBH8teNh+P41g2ho0BgOB5neZAnAUshxK6YW6m0=;
        b=sAps5sdj9PNiE4lpJzQuCHd6e9mvzqMhXZt6pELjmxlcOeF+VL45DSgmzPYseyGWgV9QgU
        9KvumJtf/w2GNMxXtUB9pA3fKuzwK5J5RS7xlPYAHLEy5r0aLZhmTzUMl1R2WMw1ppb6s3
        gsAc7B9I6XQM3vdG2TOp9y6y6oPPn1A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB33513479;
        Wed,  9 Nov 2022 01:19:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NfUhIB8Aa2OJAwAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 09 Nov 2022 01:19:27 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: [PATCH] btrfs: raid56: debug: verify all the pointers for generate_pq_vertical()
Date:   Wed,  9 Nov 2022 09:19:10 +0800
Message-Id: <0cb5e2dcb02a3f6f8f7ec1f42543d146bed31b51.1667956749.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

!!! DON'T MERGE !!!

David reported a KASAN error that raid6 gen_syndrome() is accessing
beyond slab boundary:

 ==================================================================
 BUG: KASAN: slab-out-of-bounds in raid6_avx5121_gen_syndrome+0xa7/0x1c0 [raid6_pq]
 Read of size 8 at addr ffff8881070b1918 by task kworker/u8:8/28383

 CPU: 1 PID: 28383 Comm: kworker/u8:8 Not tainted 6.1.0-rc4-default+ #51
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552-rebuilt.opensuse.org 04/01/2014
 Workqueue: btrfs-rmw rmw_rbio_work [btrfs]
 Call Trace:
  <TASK>
  dump_stack_lvl+0x4c/0x5f
  print_report+0x196/0x48e
  ? __virt_addr_valid+0xc3/0x100
  ? kasan_addr_to_slab+0x9/0xb0
  ? raid6_avx5121_gen_syndrome+0xa7/0x1c0 [raid6_pq]
  kasan_report+0xbb/0xf0
  ? raid6_avx5121_gen_syndrome+0xa7/0x1c0 [raid6_pq]
  raid6_avx5121_gen_syndrome+0xa7/0x1c0 [raid6_pq]
  ? sector_in_rbio+0xd2/0x120 [btrfs]
  ? raid6_avx5121_xor_syndrome+0x1a0/0x1a0 [raid6_pq]
  rmw_rbio.part.0+0xdfb/0x1200 [btrfs]
  ? recover_rbio+0xd20/0xd20 [btrfs]
  ? index_stripe_sectors+0x12f/0x150 [btrfs]
  rmw_rbio_work+0x9d/0xc0 [btrfs]
  process_one_work+0x557/0x9d0
  ? pwq_dec_nr_in_flight+0x100/0x100
  ? lock_acquired+0xb3/0x5b0
  ? __list_add_valid+0x3f/0x70
  worker_thread+0x8f/0x630
  ? process_one_work+0x9d0/0x9d0
  kthread+0x146/0x180
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30

 Allocated by task 28383:

  kasan_save_stack+0x1c/0x40
  kasan_set_track+0x21/0x30
  __kasan_kmalloc+0x86/0x90
  __kmalloc+0x55/0x90
  alloc_rbio+0x163/0x470 [btrfs]
  raid56_parity_write+0x2d/0x270 [btrfs]
  btrfs_submit_bio+0x38b/0x410 [btrfs]
  btrfs_work_helper+0x154/0x600 [btrfs]
  process_one_work+0x557/0x9d0

Unfortunately I can not really find out what's wrong nor reproduce it.

This patch is a mostly debugging one, including the following changes:

- Try to access the beginning and end of a sector
  To make sure we have correct sector assembled.

- Avoid "pointers[stripe++]" usage
  This is super common question for every C language learner, but for
  real practice usage, it should be avoided, as it takes reader extra
  seconds to consider when the value really get increased.

  Instead let's use rbio->nr_data to grab P/Q stripe number.

And to no one's surprise, I can not reproduce it even with the debug
patch.

If even with the patch, there is no error triggered from
generate_pq_vertical() itself, then it has a high chance it's something
deeper other than btrfs causing the problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 4a7932240d42..84e236ebb96c 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1176,9 +1176,24 @@ static void bio_get_trace_info(struct btrfs_raid_bio *rbio, struct bio *bio,
 	trace_info->stripe_nr = -1;
 }
 
+#define BUFFER_SIZE	8
+
+static void check_sector_range(struct btrfs_fs_info *fs_info,
+			       struct sector_ptr *sector)
+{
+	u8 buffer[BUFFER_SIZE * 2];
+
+	ASSERT(sector->page);
+	memcpy_from_page(buffer, sector->page, sector->pgoff, BUFFER_SIZE);
+	memcpy_from_page(buffer + BUFFER_SIZE, sector->page,
+			 sector->pgoff + fs_info->sectorsize - BUFFER_SIZE,
+			 BUFFER_SIZE);
+}
+
 /* Generate PQ for one veritical stripe. */
 static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
 {
+	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
 	void **pointers = rbio->finish_pointers;
 	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
 	struct sector_ptr *sector;
@@ -1188,14 +1203,16 @@ static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
 	/* First collect one sector from each data stripe */
 	for (stripe = 0; stripe < rbio->nr_data; stripe++) {
 		sector = sector_in_rbio(rbio, stripe, sectornr, 0);
+		check_sector_range(fs_info, sector);
 		pointers[stripe] = kmap_local_page(sector->page) +
 				   sector->pgoff;
 	}
 
 	/* Then add the parity stripe */
 	sector = rbio_pstripe_sector(rbio, sectornr);
+	check_sector_range(fs_info, sector);
 	sector->uptodate = 1;
-	pointers[stripe++] = kmap_local_page(sector->page) + sector->pgoff;
+	pointers[rbio->nr_data] = kmap_local_page(sector->page) + sector->pgoff;
 
 	if (has_qstripe) {
 		/*
@@ -1203,9 +1220,10 @@ static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
 		 * to fill in our p/q
 		 */
 		sector = rbio_qstripe_sector(rbio, sectornr);
+		check_sector_range(fs_info, sector);
 		sector->uptodate = 1;
-		pointers[stripe++] = kmap_local_page(sector->page) +
-				     sector->pgoff;
+		pointers[rbio->nr_data + 1] = kmap_local_page(sector->page) +
+					      sector->pgoff;
 
 		raid6_call.gen_syndrome(rbio->real_stripes, sectorsize,
 					pointers);
@@ -1214,7 +1232,7 @@ static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
 		memcpy(pointers[rbio->nr_data], pointers[0], sectorsize);
 		run_xor(pointers + 1, rbio->nr_data - 1, sectorsize);
 	}
-	for (stripe = stripe - 1; stripe >= 0; stripe--)
+	for (stripe = rbio->real_stripes - 1; stripe >= 0; stripe--)
 		kunmap_local(pointers[stripe]);
 }
 
-- 
2.38.1

