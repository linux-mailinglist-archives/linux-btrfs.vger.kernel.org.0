Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5800714A7A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2020 16:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgA0P7l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jan 2020 10:59:41 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:39169 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbgA0P7k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jan 2020 10:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580140781; x=1611676781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DY2WAUOAB3R4OVQ1t9StJaVgz7kaMPPbDphATbQMRVE=;
  b=A0GMGudSNqeBrzuZJkZdRYeavJZ665TgWg/tzHw7xLVxiGh4XIB0kB8f
   UQhQLzO4SMtZTISqV5JLFMEmpvfXNYn3FRKdj6rg6LLu78ETTrKSzPjp5
   zk4ckQlJB1C4KSOp0LjqXi6ahthLSDnrWbEjyjKQ+FEYharhSpLzX/m83
   94NpQScWT6A93aBtTZ+oRiK9Jhppcm5WnZi+esVT/vyohW1DJku6GDOx9
   xeHLfUWNFTsU7mMNPwt1k9StUlmgHa6oSevYZO0YPGL9B8VoPvgs1eciv
   fLx4A9QIUIVvx+1Rv1OT6xDuBNTAevU1MNrpq6htjo9bTjaTdACRo564C
   w==;
IronPort-SDR: 4AYFCiT5t6O5gGS5Ql6jkQChAdaef994mewbhRyGiexVQYT9BRGf8BELConCYUDA5fwkE1hurR
 S6NHZQKCvPDvRWSCHPaPLu1eec2tPfG3NZFUEZrxkCG6B4DiQKvGfBBQsZBJy9gFEZ//esmXW3
 jjiFPbbt+AcgFIkOjSSPKHHU9pWDb+Nhn4IOjAMr7TnI9AjAB8Bkuhjy8XvgEktPYCqLd7r5UH
 Uv7p5N/Thj9kiIxzIwsp3OnZxMoLhAfhKDX/WhJM47ZU/rhwG8Gttb+LPUw31D1lT96fOqa1MP
 b4Q=
X-IronPort-AV: E=Sophos;i="5.70,370,1574092800"; 
   d="scan'208";a="132851977"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2020 23:59:40 +0800
IronPort-SDR: 3ntxeP7sZPJ9in/1nHkUyU+681fvweowUMF6Hm5j7Aj3+5wfXdc4HhNh/G425kJWnZRlS5jEZg
 ZeLNFfUM0I5EClWoPMo+t9qvUd91cQXT5j76j6uvnpK9htiyZO5rlD26cEQ5vYX3jtKBp0h38B
 d5Z1Crne0OCbUQYT564SCHkSHrUbfuslc+dIqHUJE1zjPnHz9nO2K99WkUPK7f/aSgreEb/BZY
 89cOR3LpUGZG+K7qkI3ROeWSRDR2771B8AGhonR5ipgZxDoiaIDVob/v6171nWkJyX8dkl8DVm
 f78JyzVnv1o48tgYAiGDyLwb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 07:52:55 -0800
IronPort-SDR: SGRcN3s3h7iI6KV9gNzqQUJcpEoRO65+Gh/6s48cYYOxe93wsGPdMKgBGXD63ZJKoQl0tbmGa0
 no7WQWB2Ec1ocR3OH/nf20FGZlbLjVnOBGZiWk6TUJG8m4h2fumMmXTrAVmKB3ArF91Ssomg5r
 Zl3HBDOei5GAqfPQTKMCmYBXWXEJ9eMvmT8tylgqk6REdwvLlgpX0gbl9iS8rJ0eGWAg5CkeuL
 8tLsyml3P+n/4CE/WGvlBYsX4L1X2BpldQM0PAk6bPeBYc1F9B8uhgoS9BgJdS3OWr4zdZPt6G
 Lw0=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2020 07:59:39 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v3 3/5] btrfs: remove btrfsic_submit_bh()
Date:   Tue, 28 Jan 2020 00:59:29 +0900
Message-Id: <20200127155931.10818-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127155931.10818-1-johannes.thumshirn@wdc.com>
References: <20200127155931.10818-1-johannes.thumshirn@wdc.com>
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

