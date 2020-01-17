Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89693140A29
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 13:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgAQMvP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 07:51:15 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51277 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgAQMvO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 07:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579265473; x=1610801473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hy71lNTVcbuLCRAZWfy0CvPCGTtjoMyaOm7eapCokFs=;
  b=IF0AhVTbbh6UTh044HlKDNwG+I8wjzkhAkwHZy3UR+m8hyLVu6D6vklb
   24eHK8DRZkRL79SrZd8TC8pOfOTa0rn5qI3ADAC+XjK8P1pwQnfSNvHtA
   fbjyowISqkvnIgTBdOVJhv0ZmA898bmLElAqXmkSodu1CraVdFXaPHMbK
   gBPW8AYwINY5Ml/yQofLI5oFtw1yb0qXht42V0MUGtg8vUYMnFWZ1Sg0m
   du1h244xbz4gWcJL9Pt0Fk1Uztww0x0hseu8s7+2pEz9A/IbowFJ4wg4o
   XjEkWKCV8Ev1M8GZAvtAlxWff5dNIPwgUZJiXYnGtx2RzLIU7VAZtID1z
   g==;
IronPort-SDR: QQHsi2p/bbiv74sFBZ2/ga4S7hC8UqGD8yj0qNxBFPt0q+1a4QDSoRbn9nJyuV6LZzbvjTHKmR
 GkP1nRylRT64aMMXqiwiUf04H0RB8UPDjSezZWXbl1ZXPxjCWAWYPhGZHSU1Yw5Whh+ueeUtN+
 gyV/qzbrwiz22gegiXvnnIMXcTV12Cn0ZywO4GoyHELXUkfnbyqWS6x0D6BTyOvHjKa1QYCxj/
 Cp5Z1DCvd0PoJb2mR3fMwWZ83XbZO2e1K1EfgU/HkytuSlhWQ7MVHtXK0VabCgPQ2o5ueoaT1/
 jBU=
X-IronPort-AV: E=Sophos;i="5.70,330,1574092800"; 
   d="scan'208";a="235550982"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2020 20:51:13 +0800
IronPort-SDR: Q1FqhbQq9+e+z0JTr7/h5VMbQDHvT7eVYjT4NQyW1dMP1ad0HBsX08BoDgr3RlzZzf+EZ4Ozgw
 ST1bnD0Ltr23PX2g7paqeerx5fzSEvyQVmnDErR1CSQgKrA9G23nZaHnuC06nOSUifm+K4/ZRx
 VL/X8SvuYhp4H/8R9lVQdfsPXQHcgqhc5FlDLUsd3aRuoTwBXbwiCBNtaY1TgC+kZe/2np4YV/
 ujCm0/rOtnzn4zXzwTLjfN/JgntHGLMiFPcGADGAzaF702WakkV2bUCijVtSi+9Wf6zw1vdOVX
 y01T/4Pd3lhA56jXVxG9vo2+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 04:44:46 -0800
IronPort-SDR: 7HSKw/ZWPzMTuwmilheeaROFYz3b7Hr+VSHowo8ueDE0bf/FAfEd0al4ltFPb74Z3Stutn87c/
 E/C50Mh7OlvtsPCEwtcs38hU6DOVNyokp/q29IcHzbVjnbCSNqpVRqcKP0/cdXF9YdfUOfmJ8J
 ka5TesbdxnIXgm2XWWG3bbJB1ggWhgL/ZHYmmLTivoX8p3sDwEjKBOrP02Ft2D0sFlrb294j3e
 eOCPkfAZxfgYVMU44aTA2mNPaJEVQ+70vmt8dhUQ89e8s1DnPnB0KI0HmRXUjtTOIgmyIHU1BA
 mFY=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jan 2020 04:51:13 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/5] btrfs: remove btrfsic_submit_bh()
Date:   Fri, 17 Jan 2020 21:51:03 +0900
Message-Id: <20200117125105.20989-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117125105.20989-1-johannes.thumshirn@wdc.com>
References: <20200117125105.20989-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that the last use of btrfsic_submit_bh() is gone, remove the function
as well.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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

