Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA5A4604CD
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Nov 2021 06:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhK1F6p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Nov 2021 00:58:45 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35634 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbhK1F4m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Nov 2021 00:56:42 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0F0F12170E;
        Sun, 28 Nov 2021 05:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638078806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BHixxRsRgehLMb9gkYwQrbF05g6kR7P9OlpTi4XwZuE=;
        b=XUcKXa4D5iEGuS+WOkphe8jQpZhOU+3n+lEG90mCE4sl4VQTaW4X2Goe2DMAS7sOJZqBIE
        bwx4PdUWU5tf/W09AJl4JgrEemod5fzYZUf5wvoS4YNhol3iqSOHwODxsqWk7lNbA2WeF6
        aqUYMPYXgbE0jiBdXeHFsCNUEt9Q6ZI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1758C13446;
        Sun, 28 Nov 2021 05:53:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sCo1NlQZo2G7fAAAMHmgww
        (envelope-from <wqu@suse.com>); Sun, 28 Nov 2021 05:53:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH RFC 05/11] btrfs: save bio::bi_iter into btrfs_bio::iter before submitting
Date:   Sun, 28 Nov 2021 13:52:53 +0800
Message-Id: <20211128055259.39249-6-wqu@suse.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128055259.39249-1-wqu@suse.com>
References: <20211128055259.39249-1-wqu@suse.com>
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
 fs/btrfs/volumes.c     | 11 +++++++++++
 fs/btrfs/volumes.h     | 19 +++++++++++++++++++
 4 files changed, 35 insertions(+)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 64f931fc11f0..943e5898fa87 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -867,6 +867,9 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
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
index f7449bf7a595..e6ed71195e18 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6771,6 +6771,17 @@ static int submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
 		dev->devid, bio->bi_iter.bi_size);
 	bio_set_dev(bio, dev->bdev);
 
+	/*
+	 * At endio time, bi_iter is no longer reliable, thus we have to save
+	 * current bi_iter into btrfs_bio so that even for split bio we can
+	 * iterate only the split part.
+	 *
+	 * For bio create by btrfs_bio_slit() or btrfs_bio_clone*(), it's
+	 * already set, but we can still have original bio which has its
+	 * iter not initialized.
+	 */
+	btrfs_bio_save_iter(btrfs_bio(bio));
+
 	/* Do the final endio remap if needed */
 	ret = btrfs_bio_final_endio_remap(fs_info, bio);
 	if (ret < 0)
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 358fc546d611..baccf895a544 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -378,6 +378,13 @@ struct btrfs_bio {
 			bio_end_io_t *orig_endio;
 		};
 	};
+
+	/*
+	 * Saved bio::bi_iter before submission.
+	 *
+	 * This allows us to interate the cloned/split bio properly, as at
+	 * endio time bio::bi_iter is no longer reliable.
+	 */
 	struct bvec_iter iter;
 
 	/*
@@ -400,6 +407,18 @@ static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)
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
2.34.0

