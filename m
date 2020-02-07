Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50BE31552D4
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 08:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgBGHVE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 02:21:04 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:2752 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBGHU7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 02:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581060064; x=1612596064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DY2WAUOAB3R4OVQ1t9StJaVgz7kaMPPbDphATbQMRVE=;
  b=kobkRPq5QCQ+CWheJPl3+X8SDxfX4J46Ft9TxxFA80tvB8G6anrt0JsJ
   2O9o/DsTRiQnDZ0mezTxyMqvNr5MYgChA14iSrGN8aw8mLI6BcC0mLIKB
   0A6snmmW2UdoWektbtNZDMb5/VAr59U0XKsqUIwAppt9So6mSD8n+LCvq
   uW7nb8wPWAJYehrQiGKJ7hTmb3DmjfQMTF7KEX83MDuZwAZoGFrUb6PXy
   uqD7Z9crzcZwvSTPsz3/T0bytIWpuhZ/i7WBwumHWWo62rkAzXLx5LAYy
   BU0ya0O5SWrxKuotMZ5yRRquT6Jcxu0Y2tASvv/Slhuhf1eRMvUAHvKqY
   A==;
IronPort-SDR: P7SaYdZs6w2oVR5cbVHpMDiRDQ4UYAz6+6l5iihr97QDPiNuxDgmDZ066p750BZSRIWcDGX10d
 5F97RyLgCWTH7B7WnA4lUIrkfK1Jheou3sqiuj9AQZlqTeNEogHCtkBkgbQl6+26RuooQ2Qd6n
 RM5EeAS8rEABCTDpR53ofy6HyB6UhbHKIHjdWF1XILSpR+PtO75PmTdTMxmkmtBmRnJiIUxYny
 cjc3w5v1KC7lCfZo5dT2WEAAhIgLShQrbMJghWRlSF9eDymoI4Xrj1W+Axgqqah4/mqx9WsjI8
 m5Q=
X-IronPort-AV: E=Sophos;i="5.70,412,1574092800"; 
   d="scan'208";a="231092232"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2020 15:20:25 +0800
IronPort-SDR: 4yDGYP2QbvHbuq7rRWO8Ne2MpZdST9ZuV3YJLJWUulVqo7R2JJV96s7TgfwFAdYwrtXWwA8FqW
 G3BlckPDfIKMK+BPw1L3o7GylBjg71igGlryp03FKzW9jWbAqNH1kIEGcC35RScqGwxJc1GBrN
 H2mIRO1ZslauvY89DCcEwyklALPeBuQbjRCUvkuQ71ik22P/n6kjx1dFqC/SF9dwDrWjnXed23
 rXvZY8xgHKTI5JvEo6Am8O3WZZ5FQ69Ll7sG8GaqbrotdFR/hH1S6u7ELgzoyCnIyu3oSfx+ji
 t+s095j0v5uYVgClrIzAbw+f
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 23:13:14 -0800
IronPort-SDR: Y2stc2+ZfAQiZjVwHo1oAvB9nyWlrPIdGDoF6x47x5CU/yY2VpW5qXeOnpqRd5/C+WNBvvPk/z
 gC/hcVAhGeVpaAuGZPESm2BQtmgs+i14WmE4QuDXDjQl/04IkpuVcapYeJn4cXcHFTotld7M3D
 Yu0+ZyaOxNW2s08tDxsCLwP8gc94VUFA+aM53UqkFWqDi0N8Hhvc/eBvkUBH6HSA+BuIje3cCI
 QVUcojvcxTY1Hjp2mrrfGWNnTgaNR7ZBEQWKUNf2fo7F3koXLeOqfqdnzwJNx67ZNKPNyXoRbr
 ZFY=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Feb 2020 23:20:17 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 5/7] btrfs: remove btrfsic_submit_bh()
Date:   Fri,  7 Feb 2020 16:20:03 +0900
Message-Id: <20200207072005.22867-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207072005.22867-1-johannes.thumshirn@wdc.com>
References: <20200207072005.22867-1-johannes.thumshirn@wdc.com>
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

