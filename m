Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C09215C657
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 17:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgBMP7m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 10:59:42 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43900 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbgBMPYw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581607492; x=1613143492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DY2WAUOAB3R4OVQ1t9StJaVgz7kaMPPbDphATbQMRVE=;
  b=WCMUbmRZSXLz+lGWquwWycnSzk/X1cfkmUGuRTumNk4xDYOXh0Bmafcm
   u+OVwNWthHZWmO0wK3+ucrhgN5ME6mTUymRagfuQdy03sFCKzU1Q5A/PN
   VmjNV9ASi00C1m1hI4qwZTksR8qOEeKA0zQ3YjkJNFju2KvBOddHX1sne
   SL0e/YjP511vS/i3jmK5OkfyJ3ROTgDLFxEWhh/mCdNNjmWb4GybJa67m
   5WaPUO6MvyGevkVlufU1+P9prHyMH/SyuLayWNHdfNcqTPN0Azuiqs1V9
   Sju0RNRQklrBf2w0biMYKvUyGYXaL+2FjDSejhQiWSo/60YyoStixF9ye
   Q==;
IronPort-SDR: xhMZY4PfAHni/tbTpOZtGdn4wYSwNMBrlZ+iumy51XalGOS4fq6W3NxJfYCYrZpnGo3eBrbeWu
 eAIWMonUpQlmYF+2rBNMFLB/nPVsowXBZusozr29lGUb7DBrQg+4iN0tLEOkOwD23nZWAF+SzB
 IrOUKOLgE0AhjkLAjakLe7qz0DRKImilKvYtlUnmVLV3f6wCPRtIAMes/HSgbNQ0fZu9TxL0eS
 tLOD3lxwCHySNXjkQ7EdeTCjVUjRLJKGWL7hWUVqCf1rXxeCQ906D5c7izQMCq7sNSZeLYE0SC
 Us0=
X-IronPort-AV: E=Sophos;i="5.70,437,1574092800"; 
   d="scan'208";a="131227894"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2020 23:24:52 +0800
IronPort-SDR: MAJOikwiRoBsydhcl+ahqdYz2+avdaYUUKAyix3iSvenHpkbrre2614leFWpAxtsOZ3P0wgcJG
 txdWaVMG0rIxKPIuHGfCFvtddcfdqLzaK4N3XjwgAKRvAbi5+wfpY0takaJxsVuHiFroPWFBxY
 0Av8T27a1cTLWOpDi9G6DWCVtbfWOWDNagDBaflacS/USyN3adFy2RCJRJIWSeisEnDFQMTH+X
 RPAjxXzsUkfXNe8VPRLYBSMQjEdE7slI0Bc3VrQasyoKgSeLmwP+kdPxNHDVDon6ywWiKHVNL5
 td7gMgr5HCDSfB1USC8RtoMx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 07:17:38 -0800
IronPort-SDR: Rocs0g1Wb/KBktpkVxglhhCJBdXQXoZvHXDxzVAy3mvq4A6VnCp3pwFrA/I45syyzHL3Z3r3C5
 4GSReQPHqWEmF2Dkyz8EnF6eVRFqmIRsBOSbmkIbnbZg00cRqbVk66aOe5lE1pgY4pvfVW0c+V
 M+xdNGE9W8rE8A07H4STVlqU8s3akl6/Bg8x+koPO06gw/z18D3tVSvSWNQW76V3N5KKr1ph2i
 hfgmul37OejbSMZ3EfJt30TKK+5OfENTM1gJcMkZnZHuI6cmetAOxr3UmwmeUVdXm9fIpc3AU7
 xlw=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Feb 2020 07:24:50 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v8 6/8] btrfs: remove btrfsic_submit_bh()
Date:   Fri, 14 Feb 2020 00:24:34 +0900
Message-Id: <20200213152436.13276-7-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213152436.13276-1-johannes.thumshirn@wdc.com>
References: <20200213152436.13276-1-johannes.thumshirn@wdc.com>
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

