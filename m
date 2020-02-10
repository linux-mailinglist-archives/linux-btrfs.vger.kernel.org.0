Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0F59158261
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 19:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbgBJSci (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 13:32:38 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:25711 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbgBJSci (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 13:32:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581359557; x=1612895557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DY2WAUOAB3R4OVQ1t9StJaVgz7kaMPPbDphATbQMRVE=;
  b=aDXYT3RQ6VhlGcHm7kb2hOPlwlkl8R4k9uJVQgt4JSXnxWAUx9GQBmSq
   Y7jYPkX3kxweXbDyxrer8t7ZEA13zgoECTru8sV7FO1AdeIkFb39D+OCM
   I8xlyFHhKxhMbeApDNQmCCT2XvVIFeR/VpKYEY3rZJqagdXXWIdFPqY6x
   RFoZPUj3ZOVPNfSsQDL/hhNmmtrbuQabWS2iIU5fEHEvigFRurG4A38Bg
   UUX9u7lJVJP8+/BRKgH5tINqwOBEPuvUNd1JV1mv9vT2+RfL5WPiZCcz/
   KCStRtf52Y+EAwHZrqzwixnpF9zFbse/nrcKu0VlQ1es30O+Mglf8ThhA
   Q==;
IronPort-SDR: EsjIpyVPVLNahS0KTm7YeyFVjfA0ku17QZSUcJ8Cmr8hyaXuV3JtcqrE2lmLFHT4gJstX2rqfm
 fzZ1ECu0n2GOyTT4KFoSJicpq+vYH5ffDU416El7VRMlb1oXXankvbh2wMzphJf/S2+oxOj0CR
 k/z3CWv0j8sbKas0a3UMAvNnJXbwHQDAA/+xhqTFEDsmsQGN+Mz5s/QXrBArFOVppvDHbfouRS
 lXOBovTjYTaOu+2S2ZFAg98hwKOtcFzT8lG5hYXpPL8UsrNmgDQfXJaE5sWjdbMVTXFCBFj4/D
 hkY=
X-IronPort-AV: E=Sophos;i="5.70,425,1574092800"; 
   d="scan'208";a="237529187"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2020 02:32:37 +0800
IronPort-SDR: hHJWi3541O+cwVJZ34YoACZMOd1CGVviVB0jwFe9BCQiCO/bP7GYLR9DYYcA9BO5UiAkbjfNZ+
 4FKPQ46v9YtS4ArtJgxN/TYN2C/qGs/ZhroC75zBpOlLecQ266X3rQYIdx/waCCYqVureGwxWO
 53IGO5Wsntd5RglKXXWvVoREwg7/AYC6Fw3+AEUTzslMPJ9BFculicDkhl6tf2/XkzJwhyHH8a
 qtGKn7VNiBEuNeOtd5TD/3nVnwqGfDlMqF/GgYGjLUM6bRcb4cM2zvEVF767fu5xHYQAKEnli6
 z0wY/Cx4KFYveS9exegDbCC4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 10:25:29 -0800
IronPort-SDR: TXoJhZbRHXnce1fIOFhO+B/delu60DwmWM1ldBmsiIOU6bPaRDEU80SFFsWLZnaFobk9KAXByA
 7W9T67uxRcyip2MkAAevBgStLcdetX6m/5qvHBl1Lv+Bp2DpnNxNJn4gKKPJbBYkDmcfmkl0eA
 NsV7+PAFi6J01zVqED3jbLoc7hJkRe3LZnj79OjN1M6vWqX50ejxAFUy5mss/ao7KXucuCPDhU
 q61EY7ZE7dLwTkfaZWJRBC5WxtpyyAOkC3Kt9SYM5oLyFJe3TgI0+kPqe0cV199jssARFpXn8f
 Vf8=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Feb 2020 10:32:36 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 5/7] btrfs: remove btrfsic_submit_bh()
Date:   Tue, 11 Feb 2020 03:32:23 +0900
Message-Id: <20200210183225.10137-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200210183225.10137-1-johannes.thumshirn@wdc.com>
References: <20200210183225.10137-1-johannes.thumshirn@wdc.com>
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

