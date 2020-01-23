Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A996C14633E
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 09:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgAWITB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 03:19:01 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43991 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgAWITA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 03:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579767540; x=1611303540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gIeOkhqO8OgsauT36wGVsj0GSaydPzDuX9+wi0vVzPA=;
  b=qA6jubNmM50wwlLuG69NB3A4Tp0tJ72FeLQthzFIrxfPxnNlMUmYOPDa
   WtEJxbXvydsMsG5I8qfc8WHmKUQwBPPgGTMnkNUDDBXn0mLA+UUKG48z3
   VcKxE+CbwOTcluJwsyqoH87HzJVzxndB13T9J3oyf+WSvzDY9OUezHkJt
   RvqYZKO4KJXiDoMCKLG4ltRvu0fUF5gyckrEPhsLrycitzo3LckhysBs+
   aUVxaMgsMYko0qv1522vvyQl4krKRnYJNEG3EVyvKErYuXqJZYsI6czSN
   6Ufyy1dYnRtWGuelUklGjqhvNwKr5buGStRRh6aS2fCSn7fe8Rgwsl/a2
   A==;
IronPort-SDR: DmPoeqI6oldQNsHLb6TocppcVW2rKaCMNXX4DErQbccqEXVOYQclg0w7Gtmt+Fpsl8eU8aiKNV
 R/9um3ATJx4yRqlSTKnEDhJahl3Y0ZF1r5twInO6f0vArjW/l5H2WfJYYQDY2gcQ2F8epOmoZf
 /te3MUPI/yMAOCTp1EIz/RMIzmabBjCwHgY+S9JpUEN4RXH5e9aYX9R9RTskSEpqd9fHZ6bqDM
 4aMkst2wiSPxVhH99XKVYetVlf3lhJJY6BFuIhbVYdrag4DHKyFUMngX14AVG6w7jjP3n51iLM
 xNs=
X-IronPort-AV: E=Sophos;i="5.70,353,1574092800"; 
   d="scan'208";a="129708694"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2020 16:19:00 +0800
IronPort-SDR: 4h9tKIqEVxQps+zshon9GF59c3DJNh+ho90IsiRKLUhqq8OlFkon5pFrNUIjPaE2lsKPBsHCOE
 nS+549N4MUqQKrexXyQWl2BKPeuh6FhUQ5EYC1KLfV/FoADF+ck6lhUdvfWKqOvSISMwNVLcp/
 o6t9yAMcCLy1fpb2qHknsXznzJwKcXXMq11p4JlHEJWN3X8FBrX30/TWDrTv3xn9C9kZJXzl21
 kk9lZJlc7AKKPH1gBosit0TiahBepYbdpAfcg/xL+Ri+4lOW9SBOH46DEhTMQbxbPSCidCgScH
 hxm5k6a1ngf7wFZLSBdzxZEr
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 00:12:22 -0800
IronPort-SDR: hYHwnjbp0Vse9SWP3DCVbv8KQm68FmjZzjH4F3KkVMUPCqjqyK+IUn7kyprOetP4b1+30W7bG4
 sZ/9OhtSCLhe646Y4BAR6nUXfqWL5CEerIHFdl/crhGUbgGXw85dg5RqMoaAwRz+5DJXUPi+tp
 oXBDIeQvW/hNgX2Lz9f6X9VDNFv9kMpmH/6JeLYCrNCy1SZAe6B175DRbgkqFj+MPHdkctUTjY
 PXxRDW+zudyPKwVuV1UdLXyvUUQYthvOfPd2ClIuJmfZTOBkk03oeY6DSN0pE+1yNaLEKWgyRJ
 hQY=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jan 2020 00:18:59 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 4/6] btrfs: remove btrfsic_submit_bh()
Date:   Thu, 23 Jan 2020 17:18:47 +0900
Message-Id: <20200123081849.23397-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123081849.23397-1-johannes.thumshirn@wdc.com>
References: <20200123081849.23397-1-johannes.thumshirn@wdc.com>
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

