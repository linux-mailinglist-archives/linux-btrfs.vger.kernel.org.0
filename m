Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3DE15A19F
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 08:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgBLHRP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 02:17:15 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46465 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbgBLHRO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 02:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581491848; x=1613027848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DY2WAUOAB3R4OVQ1t9StJaVgz7kaMPPbDphATbQMRVE=;
  b=X9M9gZMrof3tCredoxaq0K27+bgIQFAm9VcdCfEspN2+K4snwtyjkvTx
   +FMX62gFL873x+lZjeQrYmUodrIjk6bXwD0wl4wjmjdMY8nO5UFRdYc0S
   BFd8hLaGfb/3B4ZdPOwTR75aupmFQcHplbJV820R+0I3oKT9GGpyVSQIM
   tp8Ac+DcFMqyZSyGJyxIIIe7bu1P61cG8lcjlWjyTInDdolfisHPfWmxO
   haQnJ7peGaLPIPAfyEotRDR92r2o2Pz5DDh1qXtq03TEyDgpyZTi5bKcp
   HN+VEz6d3GOQIwII8Z3MMmDXSq1SDIjYLxkHWR76SK2CkVEFFCE3E/voF
   w==;
IronPort-SDR: rvxGu/WxtBi1CE6gxhMwgmmRdimE8vW+JP0qa41GkYyk/Us1gpO9+zUVqKlflTtwXI6vDcpQnC
 Yp9lVnwamY3xpOK4X6/Jg9gllWKx87GNCFxFQcT5nMGpilawf5cV1STJERUWG4/Sy0fF7HVGqz
 BYmV+eIsfHDdnz0gIJFHly2rPCGYZznn3GasuyFtIi2/etzofhImMyqGB0kevT/OL++W3F/nn3
 yzqGWXNA4NHoZw1lp0xCT5W5tdJp+g2iff56u14vTwzct82M4VI9u+qbvA7y+lyjJC9LVQ0YEh
 IsU=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448465"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:17:28 +0800
IronPort-SDR: +CoYsO8u1+kiU8RfHrVkga/szGgNVlW/mScefG6CbeJtaFZov1QhtKV0Ht5h+qQOxDtJhqmr6O
 kbmunwiH55+Gcv1HU39mHIF5vrgj7HR75M2kkgki7VXbAslq5JsCyyqQ5UpOYHLJNn32Siey6j
 NKJtau7LhgMfSOxfY2pA0V1BCu+KqiXdcKr1HkTawsTPLaneXkFFIjxJBddSFRJjdqwNP0y44c
 zD+0F/Ks1t1h4Y3+Gh7j1spG8F2DMVDfp87meQQVOX4FXxHXdx3PWAvHlyBjmJs10ooSwuA6HL
 NpnIRhZWQYiCS1qsrdetX+gZ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:10:03 -0800
IronPort-SDR: gc9AAr/xZRWGOy7OFWwBqXkmOJnXiKYCIAkNMkGIZjT5YixdIe8+MF804GFE3rrI77Nt1C3vrN
 bD/R9V/viqae38bl43AA32lE6nsTG4PHIIlvxAtZ94QW+p4Z3lLGdLpJUNDuEMhgaSGB/RXL1J
 z4rcG+j0VmK1HW6RGS2En2SLeEFyB8E0S2h6+tucwHsZnPsUK4C5bJ37sDPiP1Wmc1JtqIaO0C
 hCvBYBVJKY5zhcwYTQWGhFhhFStLb3JIHiJKkiUxBUWSlrAGQ8TA5/FCIck/J3AcsWJEGlHw06
 5nQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Feb 2020 23:17:13 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v7 6/8] btrfs: remove btrfsic_submit_bh()
Date:   Wed, 12 Feb 2020 16:17:02 +0900
Message-Id: <20200212071704.17505-7-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200212071704.17505-1-johannes.thumshirn@wdc.com>
References: <20200212071704.17505-1-johannes.thumshirn@wdc.com>
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

