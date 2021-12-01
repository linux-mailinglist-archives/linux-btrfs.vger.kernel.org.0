Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C51A464654
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 06:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346667AbhLAFVj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 00:21:39 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37834 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhLAFVi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 00:21:38 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C358B1FD2F;
        Wed,  1 Dec 2021 05:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638335897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lx7lzt2Kk/DUrxzR8la+HHM7k9uVIizWO00hxKSvzhI=;
        b=UC6C/vAb7VWnxzndZRhwexMj0pksCXGUoQ7zqXOTBHtAnRHSSmYMgskrXbkLkiXjILPDEU
        66I8/yiiGvr+R4KT4n+JX4SzjWNhCYyeDkuT04MUFU0QZ0tI9w2ieFbWjzHt3NttMX8NkH
        vq8F+i26ptaFu4ENxa+raMUOnTmvDJk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C84D113425;
        Wed,  1 Dec 2021 05:18:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4EeAJZgFp2EGbwAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 01 Dec 2021 05:18:16 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 02/17] btrfs: save bio::bi_iter into btrfs_bio::iter before submitting
Date:   Wed,  1 Dec 2021 13:17:41 +0800
Message-Id: <20211201051756.53742-3-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201051756.53742-1-wqu@suse.com>
References: <20211201051756.53742-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since block layer will advance bio::bi_iter, at endio time we can no
longer rely on bio::bi_iter for split bio.

But for the incoming btrfs_bio split at btrfs_map_bio() time, we have to
ensure endio function is only executed for the split range, not the
whole original bio.

Thus this patch will introduce a new helper, btrfs_bio_save_iter(), to
save bi_iter into btrfs_bio::iter.

The following call sites need this helper call:

- btrfs_submit_compressed_read()
  For compressed read. For compressed write it doesn't really care as
  they use ordered extent.

- raid56_parity_write()
- raid56_parity_recovery()
  For RAID56.

- submit_stripe_bio()
  For all other cases.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c |  3 +++
 fs/btrfs/raid56.c      |  2 ++
 fs/btrfs/volumes.c     | 14 ++++++++++++++
 fs/btrfs/volumes.h     | 18 ++++++++++++++++++
 4 files changed, 37 insertions(+)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index e776956d5bc9..cc8d13369f53 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -870,6 +870,9 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	/* include any pages we added in add_ra-bio_pages */
 	cb->len = bio->bi_iter.bi_size;
 
+	/* Save bi_iter so that end_bio_extent_readpage() won't freak out. */
+	btrfs_bio_save_iter(btrfs_bio(bio));
+
 	while (cur_disk_byte < disk_bytenr + compressed_len) {
 		u64 offset = cur_disk_byte - disk_bytenr;
 		unsigned int index = offset >> PAGE_SHIFT;
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 0e239a4c3b26..13e726c88a81 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1731,6 +1731,7 @@ int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc,
 		return PTR_ERR(rbio);
 	}
 	bio_list_add(&rbio->bio_list, bio);
+	btrfs_bio_save_iter(btrfs_bio(bio));
 	rbio->bio_list_bytes = bio->bi_iter.bi_size;
 	rbio->operation = BTRFS_RBIO_WRITE;
 
@@ -2135,6 +2136,7 @@ int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 
 	rbio->operation = BTRFS_RBIO_READ_REBUILD;
 	bio_list_add(&rbio->bio_list, bio);
+	btrfs_bio_save_iter(btrfs_bio(bio));
 	rbio->bio_list_bytes = bio->bi_iter.bi_size;
 
 	rbio->faila = find_logical_bio_stripe(rbio, bio);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f38c230111be..b70037cc1a51 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6829,6 +6829,20 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		BUG();
 	}
 
+	/*
+	 * At endio time, bi_iter is no longer reliable, thus we have to save
+	 * current bi_iter into btrfs_bio so that even for split bio we can
+	 * iterate only the split part.
+	 *
+	 * And this has to be done before any bioc error, as endio functions
+	 * will rely on bbio::iter.
+	 *
+	 * For bio create by btrfs_bio_slit() or btrfs_bio_clone*(), it's
+	 * already set, but we can still have original bio which has its
+	 * iter not initialized.
+	 */
+	btrfs_bio_save_iter(btrfs_bio(bio));
+
 	for (dev_nr = 0; dev_nr < total_devs; dev_nr++) {
 		dev = bioc->stripes[dev_nr].dev;
 		if (!dev || !dev->bdev || test_bit(BTRFS_DEV_STATE_MISSING,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 3b8130680749..f9178d2c2fd6 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -334,6 +334,12 @@ struct btrfs_bio {
 	struct btrfs_device *device;
 	u8 *csum;
 	u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
+	/*
+	 * Saved bio::bi_iter before submission.
+	 *
+	 * This allows us to interate the cloned/split bio properly, as at
+	 * endio time bio::bi_iter is no longer reliable.
+	 */
 	struct bvec_iter iter;
 
 	/*
@@ -356,6 +362,18 @@ static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)
 	}
 }
 
+/*
+ * To save bbio::bio->bi_iter into bbio::iter so for callers who need the
+ * original bi_iter can access the original part of the bio.
+ * This is especially important for the incoming split btrfs_bio, which needs
+ * to call its endio for and only for the split range.
+ */
+static inline void btrfs_bio_save_iter(struct btrfs_bio *bbio)
+{
+	if (!bbio->iter.bi_size)
+		bbio->iter = bbio->bio.bi_iter;
+}
+
 struct btrfs_io_stripe {
 	struct btrfs_device *dev;
 	u64 physical;
-- 
2.34.1

