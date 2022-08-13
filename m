Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7028459195E
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 10:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbiHMIHR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Aug 2022 04:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMIHQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 04:07:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68821F2DB
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 01:07:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 531F73F759;
        Sat, 13 Aug 2022 08:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660378033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=m8z/TH0zlk4E5643aoIHVDMaY4KGDtNCnholj440Ym8=;
        b=qB+70ESQuhWug5+ohJZeNUr5TDEr80+xinQB9+JiCgKIF55YlPcXforDrrbTk/dfH0rBGu
        bx8CbdCAQmvnOFr9D6k6k+fEp4gfD/OEWrIF3IK2hgmFUDJcCkLyd1jaCTddBWNiGKnXXe
        w7XGUuTIStX87Iq2dEanc7htGB1ZCRM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A750213A0D;
        Sat, 13 Aug 2022 08:07:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1AqfGq9b92I6HQAAMHmgww
        (envelope-from <wqu@suse.com>); Sat, 13 Aug 2022 08:07:11 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] btrfs: don't merge pages into bio if their page offset is not continuous
Date:   Sat, 13 Aug 2022 16:06:53 +0800
Message-Id: <1d9b69af6ce0a79e54fbaafcc65ead8f71b54b60.1660377678.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.1
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

[BUG]
Zygo reported on latest devel branch, he can hit ASSERT()/BUG_ON()
caused crash when doing RAID5 recovery (intentionally corrupt one disk,
and let btrfs to recovery the data during read/scrub).

And The following minimal reproducer can cause extent state leakage at
rmmod time:

  mkfs.btrfs -f -d raid5 -m raid5 $dev1 $dev2 $dev3 -b 1G > /dev/null
  mount $dev1 $mnt
  fsstress -w -d $mnt -n 25 -s 1660807876
  sync
  fssum -A -f -w /tmp/fssum.saved $mnt
  umount $mnt

  # Wipe the dev1 but keeps its super block
  xfs_io -c "pwrite -S 0x0 1m 1023m" $dev1
  mount $dev1 $mnt
  fssum -r /tmp/fssum.saved $mnt > /dev/null
  umount $mnt
  rmmod btrfs

This will lead to the following extent states leakage:

 BTRFS: state leak: start 499712 end 503807 state 5 in tree 1 refs 1
 BTRFS: state leak: start 495616 end 499711 state 5 in tree 1 refs 1
 BTRFS: state leak: start 491520 end 495615 state 5 in tree 1 refs 1
 BTRFS: state leak: start 487424 end 491519 state 5 in tree 1 refs 1
 BTRFS: state leak: start 483328 end 487423 state 5 in tree 1 refs 1
 BTRFS: state leak: start 479232 end 483327 state 5 in tree 1 refs 1
 BTRFS: state leak: start 475136 end 479231 state 5 in tree 1 refs 1
 BTRFS: state leak: start 471040 end 475135 state 5 in tree 1 refs 1

[CAUSE]
Since commit 7aa51232e204 ("btrfs: pass a btrfs_bio to
btrfs_repair_one_sector"), we always use btrfs_bio->file_offset to
determine the file offset of a page.

But that usage assume that, one bio has all its page having a continuous
page offsets.

Unfortunately that's not true, btrfs only requires the logical bytenr
continuous when assembling its bios.

From above script, we have one bio looks like this:
  fssum-27671  submit_one_bio: bio logical=217739264 len=36864
  fssum-27671  submit_one_bio:   r/i=5/261 page_offset=466944 <<<
  fssum-27671  submit_one_bio:   r/i=5/261 page_offset=724992 <<<
  fssum-27671  submit_one_bio:   r/i=5/261 page_offset=729088
  fssum-27671  submit_one_bio:   r/i=5/261 page_offset=733184
  fssum-27671  submit_one_bio:   r/i=5/261 page_offset=737280
  fssum-27671  submit_one_bio:   r/i=5/261 page_offset=741376
  fssum-27671  submit_one_bio:   r/i=5/261 page_offset=745472
  fssum-27671  submit_one_bio:   r/i=5/261 page_offset=749568
  fssum-27671  submit_one_bio:   r/i=5/261 page_offset=753664

Note that the 1st and the 2nd page has non-continuous page offsets.

This means, at repair time, we will have completely wrong file offset
passed in:

   kworker/u32:2-19927  btrfs_repair_one_sector: r/i=5/261 page_off=729088 file_off=475136 bio_offset=8192

Since the file offset is incorrect, we latter incorrectly set the extent
states, and no way to really release them.

Thus later it causes the leakage.

In fact, this can be even worse, since the file offset is incorrect, we
can hit cases like the incorrect file offset belongs to a HOLE, and
later cause btrfs_num_copies() to trigger error, finally hit
BUG_ON()/ASSERT() later.

[FIX]
This patch will add an extra condition in btrfs_bio_add_page() for
uncompressed IO.

Now we will have more strict requirement for bio pages:

- They should all have the same mapping
  (the mapping check is already implied by the call chain)

- Their logical bytenr should be adjacent
  This is the same as the old condition.

- Their page_offset() (file offset) should be adjacent
  This is the new check.
  This would result a slightly increased amount of bios from btrfs
  (needs holes and inside the same stripe boundary to trigger).

  But this would greatly reduce the confusion, as it's pretty common
  to assume a btrfs bio would only contain continuous page cache.

Later we may need extra cleanups, as we no longer needs to handle gaps
between page offsets in endio functions.

Currently this should be the minimal patch to fix commit 7aa51232e204
("btrfs: pass a btrfs_bio to btrfs_repair_one_sector").

Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc: Christoph Hellwig <hch@lst.de>
Fixes: 7aa51232e204 ("btrfs: pass a btrfs_bio to btrfs_repair_one_sector")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
- Code style cleanups to improve readability
---
 fs/btrfs/extent_io.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bc30c0a4a7f2..56dd6997c0ec 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3256,7 +3256,7 @@ static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 	u32 bio_size = bio->bi_iter.bi_size;
 	u32 real_size;
 	const sector_t sector = disk_bytenr >> SECTOR_SHIFT;
-	bool contig;
+	bool contig = false;
 	int ret;
 
 	ASSERT(bio);
@@ -3265,10 +3265,34 @@ static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 	if (bio_ctrl->compress_type != compress_type)
 		return 0;
 
-	if (bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
+
+	if (bio->bi_iter.bi_size == 0) {
+		/* We can always add a page into an empty bio. */
+		contig = true;
+	} else if (bio_ctrl->compress_type == BTRFS_COMPRESS_NONE) {
+		struct bio_vec *bvec = bio_last_bvec_all(bio);
+
+		/*
+		 * The contig check requires the following conditions to be met:
+		 * 1) The pages are belonging to the same inode
+		 *    This is implied by the call chain.
+		 *
+		 * 2) The range has adjacent logical bytenr
+		 *
+		 * 3) The range has adjacent file offset (NEW)
+		 *    This is required for the usage of btrfs_bio->file_offset.
+		 */
+		contig = bio_end_sector(bio) == sector &&
+			 page_offset(bvec->bv_page) + bvec->bv_offset +
+			 bvec->bv_len == page_offset(page) + pg_offset;
+	} else {
+		/*
+		 * For compression, all IO should have its logical bytenr
+		 * set to the starting bytenr of the compressed extent.
+		 */
 		contig = bio->bi_iter.bi_sector == sector;
-	else
-		contig = bio_end_sector(bio) == sector;
+	}
+
 	if (!contig)
 		return 0;
 
-- 
2.37.1

