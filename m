Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A735266DA88
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jan 2023 11:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbjAQKDp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Jan 2023 05:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbjAQKD0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Jan 2023 05:03:26 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1102C67E;
        Tue, 17 Jan 2023 02:03:24 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j17so3258680wms.0;
        Tue, 17 Jan 2023 02:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jDTSmRwtuhSampwuymzbbEvtHIuPFvNY4RP4UxpSO18=;
        b=Epjaxhxeg/xTyBpjJ8dK3TQ+2/6vTEWkYnkBmYYaK0QKdNvjQENHSyljWxgcTCRl4V
         8iENmN1toOgAWGjQF5nHWK5HQ6hsVzwe3UYQ0m0QPrVLoqAHU4h1rncxuZkDDwZdS63w
         5G+fsMjWfOqklDt1kU9pkwgPy05jwEi7BNUOmEV/yDtMvwpAEV7iASbbrBdbOlKgDhLS
         Hkhi8tKsKlNpdgx9ZdZDDvv/pI6Ar6eO+ZFYT7Ohnat3e1bVUbVW41Qa5jZWkIAPtSNd
         W4gBnxfO5uMHTAzYsLMkYPBJaK/obBugvR0bbgzJPijlG6ddcwxPR8ouSjpoxA8B3V4C
         TP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDTSmRwtuhSampwuymzbbEvtHIuPFvNY4RP4UxpSO18=;
        b=vSz0K/jmp0BGpfOET/bXQFceZAQLZiLqpj6SD3rqMUwgom4STkR/0WUFubfQVN1xGj
         57Qa3BTSsUC0UluIFXTHRfQPf7NH88oLth8+9Cq/xKYUJhxDFrC394cvIrTgBhYvRwhL
         32RjCTQSo9ACYaE7k1uskdUO0Wl0LLVndoIoZ10+W+VvpleVv/9/8/Xb7YTT1BjgF2r6
         TDNx+1Q3jYIS60Skm5GtKplta/IVEVmhaERiV8iGniVT4ffS7c5sYhOA3MLHFOW3RrbG
         CUQm+vyyvTn7H74GFekG2RX6ZC1oLoLf7cZrre6hHNxdY0dzYAt5Xn3w6N44qJhp+5WV
         butQ==
X-Gm-Message-State: AFqh2krif2AooEkHwa4iHul9CnRCDFNFwao2vcL8lFZ4FbGSs3DPYs5f
        uajGxPBBG27j/Lm+Qh5Ro1o=
X-Google-Smtp-Source: AMrXdXulFJH7mjDeKwureG6f1LaKIwECTX4q+r1Lbs/CtqNgE/BYMlVJ939Ui5mN3Zvi/mJtezzxBg==
X-Received: by 2002:a05:600c:304a:b0:3d9:8635:a916 with SMTP id n10-20020a05600c304a00b003d98635a916mr2505428wmh.9.1673949803326;
        Tue, 17 Jan 2023 02:03:23 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id k30-20020a05600c1c9e00b003d9b89a39b2sm40427155wms.10.2023.01.17.02.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 02:03:22 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] btrfs: Fix spelling mistakes found using codespell
Date:   Tue, 17 Jan 2023 10:03:21 +0000
Message-Id: <20230117100321.113814-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There quite a few spelling mistakes as found using codespell. Fix them.
Thanks to David Sterba for pointing these out.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/btrfs/bio.c            |  2 +-
 fs/btrfs/compression.c    |  4 ++--
 fs/btrfs/disk-io.c        |  4 ++--
 fs/btrfs/extent-io-tree.c |  2 +-
 fs/btrfs/raid56.c         | 10 +++++-----
 fs/btrfs/raid56.h         |  4 ++--
 fs/btrfs/scrub.c          |  2 +-
 fs/btrfs/super.c          |  2 +-
 fs/btrfs/volumes.c        |  2 +-
 9 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 8affc88b0e0a..c3bf36fef3aa 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -283,7 +283,7 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
  * RAID setup.  Here we only want to write the one bad copy, so we do the
  * mapping ourselves and submit the bio directly.
  *
- * The I/O is issued sychronously to block the repair read completion from
+ * The I/O is issued synchronously to block the repair read completion from
  * freeing the bio.
  */
 int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 5122ca79f7ea..cca6838f6775 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -796,7 +796,7 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			 * Save the initial offset of this chunk, as there
 			 * is no direct correlation between compressed pages and
 			 * the original file offset.  The field is only used for
-			 * priting error messages.
+			 * printing error messages.
 			 */
 			btrfs_bio(comp_bio)->file_offset = file_offset;
 
@@ -1642,7 +1642,7 @@ static void heuristic_collect_sample(struct inode *inode, u64 start, u64 end,
  *
  * For now is's a naive and optimistic 'return true', we'll extend the logic to
  * quickly (compared to direct compression) detect data characteristics
- * (compressible/uncompressible) to avoid wasting CPU time on uncompressible
+ * (compressible/incompressible) to avoid wasting CPU time on incompressible
  * data.
  *
  * The following types of analysis can be performed:
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3aa04224315e..5204a7340f36 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -763,8 +763,8 @@ static void run_one_async_free(struct btrfs_work *work)
 /*
  * Submit bio to an async queue.
  *
- * Retrun:
- * - true if the work has been succesfuly submitted
+ * Return:
+ * - true if the work has been successfully submitted
  * - false in case of error
  */
 bool btrfs_wq_submit_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num,
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 3c7766dfaa69..6fb621e0c6e7 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1625,7 +1625,7 @@ u64 count_range_bits(struct extent_io_tree *tree,
 }
 
 /*
- * Searche a range in the state tree for a given mask.  If 'filled' == 1, this
+ * Search a range in the state tree for a given mask.  If 'filled' == 1, this
  * returns 1 only if every extent in the tree has the bits set.  Otherwise, 1
  * is returned if any bit in the range is found set.
  */
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 6a2cf754912d..43f7a72161bf 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -998,7 +998,7 @@ static int alloc_rbio_parity_pages(struct btrfs_raid_bio *rbio)
 }
 
 /*
- * Return the total numer of errors found in the vertical stripe of @sector_nr.
+ * Return the total number of errors found in the vertical stripe of @sector_nr.
  *
  * @faila and @failb will also be updated to the first and second stripe
  * number of the errors.
@@ -1183,7 +1183,7 @@ static void bio_get_trace_info(struct btrfs_raid_bio *rbio, struct bio *bio,
 	trace_info->stripe_nr = -1;
 }
 
-/* Generate PQ for one veritical stripe. */
+/* Generate PQ for one vertical stripe. */
 static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
 {
 	void **pointers = rbio->finish_pointers;
@@ -1357,7 +1357,7 @@ static void set_rbio_range_error(struct btrfs_raid_bio *rbio, struct bio *bio)
 }
 
 /*
- * For subpage case, we can no longer set page Uptodate directly for
+ * For subpage case, we can no longer set page Up-to-date directly for
  * stripe_pages[], thus we need to locate the sector.
  */
 static struct sector_ptr *find_stripe_sector(struct btrfs_raid_bio *rbio,
@@ -1521,7 +1521,7 @@ static int rmw_assemble_read_bios(struct btrfs_raid_bio *rbio,
 	/*
 	 * Build a list of bios to read all sectors (including data and P/Q).
 	 *
-	 * This behaviro is to compensate the later csum verification and
+	 * This behavior is to compensate the later csum verification and
 	 * recovery.
 	 */
 	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
@@ -1765,7 +1765,7 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 	found_errors = get_rbio_veritical_errors(rbio, sector_nr, &faila,
 						 &failb);
 	/*
-	 * No errors in the veritical stripe, skip it.  Can happen for recovery
+	 * No errors in the vertical stripe, skip it.  Can happen for recovery
 	 * which only part of a stripe failed csum check.
 	 */
 	if (!found_errors)
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 7c73a443939e..df0e0abdeb1f 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -65,7 +65,7 @@ struct btrfs_raid_bio {
 	/* Number of data stripes (no p/q) */
 	u8 nr_data;
 
-	/* Numer of all stripes (including P/Q) */
+	/* Number of all stripes (including P/Q) */
 	u8 real_stripes;
 
 	/* How many pages there are for each stripe */
@@ -132,7 +132,7 @@ struct btrfs_raid_bio {
 
 	/*
 	 * Checksum buffer if the rbio is for data.  The buffer should cover
-	 * all data sectors (exlcuding P/Q sectors).
+	 * all data sectors (excluding P/Q sectors).
 	 */
 	u8 *csum_buf;
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 52b346795f66..f0efaecdb749 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -229,7 +229,7 @@ struct full_stripe_lock {
 };
 
 #ifndef CONFIG_64BIT
-/* This structure is for archtectures whose (void *) is smaller than u64 */
+/* This structure is for architectures whose (void *) is smaller than u64 */
 struct scrub_page_private {
 	u64 logical;
 };
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 433ce221dc5c..f900e921ab22 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2049,7 +2049,7 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 		}
 
 		/*
-		 * Metadata in mixed block goup profiles are accounted in data
+		 * Metadata in mixed block group profiles are accounted in data
 		 */
 		if (!mixed && found->flags & BTRFS_BLOCK_GROUP_METADATA) {
 			if (found->flags & BTRFS_BLOCK_GROUP_DATA)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bf0decaac7f3..877b0a3e4551 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -727,7 +727,7 @@ static struct btrfs_fs_devices *find_fsid_reverted_metadata(
 	/*
 	 * Handle the case where the scanned device is part of an fs whose last
 	 * metadata UUID change reverted it to the original FSID. At the same
-	 * time * fs_devices was first created by another constitutent device
+	 * time * fs_devices was first created by another constituent device
 	 * which didn't fully observe the operation. This results in an
 	 * btrfs_fs_devices created with metadata/fsid different AND
 	 * btrfs_fs_devices::fsid_change set AND the metadata_uuid of the
-- 
2.30.2

