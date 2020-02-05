Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27D9415332F
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 15:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgBEOil (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 09:38:41 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34709 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgBEOik (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Feb 2020 09:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580913521; x=1612449521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DY2WAUOAB3R4OVQ1t9StJaVgz7kaMPPbDphATbQMRVE=;
  b=W2Z56I7qp9Y5ahy+q6SHtPQoqgaP5MqKIlTNCzi2Usoc8pOE55oo8VnE
   gbf+akdmuRirzzyFYdfWSDCsBRFpsmspIgV6pKvYeSxAt2yWDC4fb1Djo
   AFexYNb6GuBF6ZOHauwo9EDdK+vo19pSx5oYapu527Re1grotxMMohU8M
   9c56NbpcqLBfx01NYMFw8+3l6OIaIjbZF1h58XrpCsnssDHvjjmvbbIhj
   IigDbvOQx24nBpZAEJ5HbP4+b3hpZLlq9Ebi/KE2te14CHmdjQJAFpFgs
   e3V0BZl73s8iPNecbmoNkfRNe+BXkXPW/zdHErPDmHMKdD/vJdcqY9nh2
   w==;
IronPort-SDR: EtkxF4GjBeC4LkQn3581jDaRwQ21B/axmD45iybEPdWW/5O8+2H2YVnDok78VZglT5TXhcsuTb
 6nYZI5DqxrIQIHoceQ2uqBikeUCmoqEqr4wgrwRuzgP+MylwK1wi9rrRdF06iH8kCRsfEeUKfk
 i+nDgq+MUr0ZBpTvTtVrQGKGmoR6oM7/etoo2t86atPulF1mMRCnnoWXb8NS+Yy1yurzoks5LL
 R/EPSQ2fl1rm0WSYhq8b3+5Hhu9Sa/m1k2GkzG8l2Ik0ArWIQPskIbFPVNU7npd+eNWGuzMj/V
 p90=
X-IronPort-AV: E=Sophos;i="5.70,405,1574092800"; 
   d="scan'208";a="133512047"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 22:38:40 +0800
IronPort-SDR: 7J0urVQANGJwy7raod4c27AhNWH0YekActrakM4t91ds7pauZZrhR6gRLxSS2Hm2b7i9l5Lb1h
 xoG+VTmuBeKyhwHU35tCukVo2jwPVsOH2QZXZc3lJtfHKGotICn7E5czCrjc4rIkzIGaqgv49F
 L/5mAzLs+4NVFcMZMey9lSxauCAaFtclapcJyfM9qu8wfr+vCjrvUdqbbSQymPrkdsCdhy2ma2
 uMODSoKfwZe1hRTA0fmVr0wKPFRKfsNSp3r3dXVZeFyZ8uOwt+13c3SmiZ2ZPcutXU5tVdEpSS
 DQNgM37kKS1XfF8AVkuNOGeg
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 06:31:41 -0800
IronPort-SDR: LngEHN7g14yG3q3K5JtChDS7pM2PKMNH4ImP58ypKqqqpzqyESyWQP9gUeFIj9wU3TJbJtniXS
 SzF0KkrUPc4XlBKbFjeJZvExqk+wQqfChBMsn9uM4oeZMTr9su07UQXF0oAMTf5ortqe6b/gl6
 ktEy3el1JqFrsaZnDPW9DUqckp1Na80wAuHFXEloxa4IbiZku1n+ccgNZtnaEC7PRL4O+Oj8nr
 jkFiRklEdM20VOn7yP4kOdTJk3A3OMwk4suGwdPapvcdgVeKOoF1dz4GbB56X56x/5MKDb3JfG
 +OY=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Feb 2020 06:38:39 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 3/5] btrfs: remove btrfsic_submit_bh()
Date:   Wed,  5 Feb 2020 23:38:29 +0900
Message-Id: <20200205143831.13959-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205143831.13959-1-johannes.thumshirn@wdc.com>
References: <20200205143831.13959-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that the last use of btrfsic_submit_bh() is gone, remove the function
as well.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/check-integrity.c | 57 --------------------------------------
 fs/btrfs/check-integrity.h |  2 --
 2 files changed, 59 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index a0ce69f2d27c..e7507985435e 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -2730,63 +2730,6 @@ static struct btrfsic_dev_state *btrfsic_dev_state_lookup(dev_t dev)
 						  &btrfsic_dev_state_hashtable);
 }
 
-int btrfsic_submit_bh(int op, int op_flags, struct buffer_head *bh)
-{
-	struct btrfsic_dev_state *dev_state;
-
-	if (!btrfsic_is_initialized)
-		return submit_bh(op, op_flags, bh);
-
-	mutex_lock(&btrfsic_mutex);
-	/* since btrfsic_submit_bh() might also be called before
-	 * btrfsic_mount(), this might return NULL */
-	dev_state = btrfsic_dev_state_lookup(bh->b_bdev->bd_dev);
-
-	/* Only called to write the superblock (incl. FLUSH/FUA) */
-	if (NULL != dev_state &&
-	    (op == REQ_OP_WRITE) && bh->b_size > 0) {
-		u64 dev_bytenr;
-
-		dev_bytenr = BTRFS_BDEV_BLOCKSIZE * bh->b_blocknr;
-		if (dev_state->state->print_mask &
-		    BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH)
-			pr_info("submit_bh(op=0x%x,0x%x, blocknr=%llu (bytenr %llu), size=%zu, data=%p, bdev=%p)\n",
-			       op, op_flags, (unsigned long long)bh->b_blocknr,
-			       dev_bytenr, bh->b_size, bh->b_data, bh->b_bdev);
-		btrfsic_process_written_block(dev_state, dev_bytenr,
-					      &bh->b_data, 1, NULL,
-					      NULL, bh, op_flags);
-	} else if (NULL != dev_state && (op_flags & REQ_PREFLUSH)) {
-		if (dev_state->state->print_mask &
-		    BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH)
-			pr_info("submit_bh(op=0x%x,0x%x FLUSH, bdev=%p)\n",
-			       op, op_flags, bh->b_bdev);
-		if (!dev_state->dummy_block_for_bio_bh_flush.is_iodone) {
-			if ((dev_state->state->print_mask &
-			     (BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH |
-			      BTRFSIC_PRINT_MASK_VERBOSE)))
-				pr_info("btrfsic_submit_bh(%s) with FLUSH but dummy block already in use (ignored)!\n",
-				       dev_state->name);
-		} else {
-			struct btrfsic_block *const block =
-				&dev_state->dummy_block_for_bio_bh_flush;
-
-			block->is_iodone = 0;
-			block->never_written = 0;
-			block->iodone_w_error = 0;
-			block->flush_gen = dev_state->last_flush_gen + 1;
-			block->submit_bio_bh_rw = op_flags;
-			block->orig_bio_bh_private = bh->b_private;
-			block->orig_bio_bh_end_io.bh = bh->b_end_io;
-			block->next_in_same_bio = NULL;
-			bh->b_private = block;
-			bh->b_end_io = btrfsic_bh_end_io;
-		}
-	}
-	mutex_unlock(&btrfsic_mutex);
-	return submit_bh(op, op_flags, bh);
-}
-
 static void __btrfsic_submit_bio(struct bio *bio)
 {
 	struct btrfsic_dev_state *dev_state;
diff --git a/fs/btrfs/check-integrity.h b/fs/btrfs/check-integrity.h
index 9bf4359cc44c..bcc730a06cb5 100644
--- a/fs/btrfs/check-integrity.h
+++ b/fs/btrfs/check-integrity.h
@@ -7,11 +7,9 @@
 #define BTRFS_CHECK_INTEGRITY_H
 
 #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
-int btrfsic_submit_bh(int op, int op_flags, struct buffer_head *bh);
 void btrfsic_submit_bio(struct bio *bio);
 int btrfsic_submit_bio_wait(struct bio *bio);
 #else
-#define btrfsic_submit_bh submit_bh
 #define btrfsic_submit_bio submit_bio
 #define btrfsic_submit_bio_wait submit_bio_wait
 #endif
-- 
2.24.1

