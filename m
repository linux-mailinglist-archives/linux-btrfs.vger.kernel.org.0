Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A99F538D9B
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 11:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242782AbiEaJXV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 05:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbiEaJXU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 05:23:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C55344CF
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 02:23:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2C88721AFD
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 09:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653988995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hfpMJB9/Ipar6Oqjoo/omUq+D9DU2New8CXBvO9T3vM=;
        b=pE6Zn22bIst30Ppmzi5bbzrYZzZTOcLNjVUXFT0drj5jDQcfpNYsiGaDcWd+3OKaC7aAM0
        n61FyoY64v9gYbghFMpwbQZphlkHnV6E/h4pDq7cmc7Lf6OIbCPPyOCbm6XNz1Tw6Ipdya
        vCUyezydqyFzlCgSSmA4Yn4KAKzhArM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FC39132F9
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 09:23:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D4yiEYLelWLIDwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 09:23:14 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add btrfs_debug() output for every bio submitted by btrfs RAID56
Date:   Tue, 31 May 2022 17:22:56 +0800
Message-Id: <de8cc48c6141a20fb2ccf2b774981b150caee27b.1653988869.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For the later incoming RAID56J, it's better to know each bio we're
submitting from btrfs RAID56 layer.

The output will look like this:

 BTRFS debug (device dm-4): partial rmw, full stripe=389152768 opf=0x0 devid=3 type=1 offset=16384 physical=323043328 len=49152
 BTRFS debug (device dm-4): partial rmw, full stripe=389152768 opf=0x0 devid=1 type=2 offset=0 physical=67174400 len=65536
 BTRFS debug (device dm-4): full stripe rmw, full stripe=389152768 opf=0x1 devid=3 type=1 offset=0 physical=323026944 len=16384
 BTRFS debug (device dm-4): full stripe rmw, full stripe=389152768 opf=0x1 devid=2 type=-1 offset=0 physical=323026944 len=16384

The above debug output is from a 16K data write into an empty RAID56
data chunk.

Some explanation on them:
 opf:		bio operation
 devid:		btrfs devid
 type:		raid stripe type.
		>=1 are the Nth data stripe.
		-1 for P stripe, -2 for Q stripe.
		0 for error (btrfs device not found)
 offset:	the offset inside the stripe.
 physical:	the physical offset the bio is for
 len:		the lenghth of the bio

The first two lines are from partial RMW read, which is reading the
remaining data stripes from disks.

The last two lines are for full stripe RMW write, which is writing the
involved two 16K stripes (one for data1, one for parity).
The stripe for data2 is doesn't need to be written.

To enable any btrfs_debug() output, it's recommended to use kernel
dynamic debug interface.

For this RAID56 example:

  # echo 'file fs/btrfs/raid56.c +p' > /sys/kernel/debug/dynamic_debug/control

Above command will enable all `btrfs_debug()` in fs/btrfs/raid56.c,
currently there is only one callsite inside that file.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 88640f7e1622..65073abd92ab 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1257,6 +1257,82 @@ static void index_rbio_pages(struct btrfs_raid_bio *rbio)
 	spin_unlock_irq(&rbio->bio_list_lock);
 }
 
+/*
+ * Return 0 if we can not get the device for it.
+ * Return >=1 for the nth data stripe.
+ * Return -1 for P stripe.
+ * Return -2 for Q stripe.
+ */
+static int bio_get_stripe_type(struct btrfs_raid_bio *rbio, struct bio *bio)
+{
+	int i;
+
+	if (!bio->bi_bdev)
+		return 0;
+
+	for (i = 0; i < rbio->bioc->num_stripes; i++) {
+		if (bio->bi_bdev == rbio->bioc->stripes[i].dev->bdev) {
+			/* For data stripe, we need to add one. */
+			if (i < rbio->nr_data)
+				return i + 1;
+
+			/* P stripe. */
+			if (i == rbio->nr_data)
+				return -1;
+			/* Q stripe. */
+			return -2;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Return the devid of a bio for RAID56 profile.
+ * Return (u64)-1 if we can not find the btrfs device for it.
+ */
+static u64 bio_get_btrfs_devid(struct btrfs_raid_bio *rbio, struct bio *bio)
+{
+	int i;
+
+	if (!bio->bi_bdev)
+		return -1;
+
+	for (i = 0; i < rbio->bioc->num_stripes; i++) {
+		if (bio->bi_bdev == rbio->bioc->stripes[i].dev->bdev)
+			return rbio->bioc->stripes[i].dev->devid;
+	}
+	return -1;
+}
+
+/* Return the offset inside its (data/P/Q) stripe */
+static int bio_get_offset(struct btrfs_raid_bio *rbio, struct bio *bio)
+{
+	int i;
+
+	if (!bio->bi_bdev)
+		return -1;
+
+	for (i = 0; i < rbio->bioc->num_stripes; i++) {
+		if (bio->bi_bdev == rbio->bioc->stripes[i].dev->bdev)
+			return (bio->bi_iter.bi_sector << SECTOR_SHIFT) -
+				rbio->bioc->stripes[i].physical;
+	}
+	return -1;
+}
+
+static void debug_raid_bio(struct btrfs_raid_bio *rbio, struct bio *bio,
+			   const char *prefix)
+{
+	btrfs_debug(rbio->bioc->fs_info,
+		"%s, full stripe=%llu opf=0x%x devid=%lld type=%d offset=%d physical=%llu len=%u",
+		prefix, rbio->bioc->raid_map[0], bio_op(bio),
+		bio_get_btrfs_devid(rbio, bio),
+		bio_get_stripe_type(rbio, bio),
+		bio_get_offset(rbio, bio),
+		bio->bi_iter.bi_sector << SECTOR_SHIFT,
+		bio->bi_iter.bi_size);
+}
+
 /*
  * this is called from one of two situations.  We either
  * have a full stripe from the higher layers, or we've read all
@@ -1422,6 +1498,7 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 	while ((bio = bio_list_pop(&bio_list))) {
 		bio->bi_end_io = raid_write_end_io;
 
+		debug_raid_bio(rbio, bio, "full stripe rmw");
 		submit_bio(bio);
 	}
 	return;
@@ -1683,6 +1760,7 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 
 		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
 
+		debug_raid_bio(rbio, bio, "partial rmw");
 		submit_bio(bio);
 	}
 	/* the actual write will happen once the reads are done */
@@ -2256,6 +2334,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 
 		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
 
+		debug_raid_bio(rbio, bio, "parity recover");
 		submit_bio(bio);
 	}
 
@@ -2625,6 +2704,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 	while ((bio = bio_list_pop(&bio_list))) {
 		bio->bi_end_io = raid_write_end_io;
 
+		debug_raid_bio(rbio, bio, "scrub parity");
 		submit_bio(bio);
 	}
 	return;
@@ -2804,6 +2884,7 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
 
 		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
 
+		debug_raid_bio(rbio, bio, "scrub stripe");
 		submit_bio(bio);
 	}
 	/* the actual write will happen once the reads are done */
-- 
2.36.1

