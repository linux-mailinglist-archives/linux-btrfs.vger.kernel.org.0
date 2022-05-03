Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27ACD517DB1
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 08:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiECG4F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 02:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiECGxw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 02:53:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36B0261C
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 23:50:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 83ECE1F749
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 06:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651560616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1UKiKNWDapJDbOLdw0P1h0HCtF+eBOCvMNDkZ52ytzQ=;
        b=FSRd6JrALZDujWRWoBr3PMYcJVMbPyfLHxzTs1rEmhPF/L0MRhaFYKWlnlUX75C0lRdneL
        AvnQqBVednOJ75PzreQkjLN2ErelTv7kDj1/8S7P7KCFLRkRDKPngyZDcZZyR+Q6+AwdJk
        xyCL6MINAnWnyCU8tNgFplzv6Ynjv8Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE76113AA3
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 06:50:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mA0mL6fQcGIZDAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 03 May 2022 06:50:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/13] btrfs: introduce a pure data checksum checking helper
Date:   Tue,  3 May 2022 14:49:45 +0800
Message-Id: <c46edf2e09f5924d00174bed98ad1d8a78c80d81.1651559986.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <cover.1651559986.git.wqu@suse.com>
References: <cover.1651559986.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although we have several data csum verification code, we never have a
function really just to verify checksum for one sector.

Function check_data_csum() do extra work for error reporting, thus it
requires a lot of extra things like file offset, bio_offset etc.

Function btrfs_verify_data_csum() is even worse, it will utizlie page
checked flag, which means it can not be utilized for direct IO pages.

Here we introduce a new helper, btrfs_check_data_sector(), which really
only accept a sector in page, and expected checksum pointer.

We use this function to implement check_data_csum(), and export it for
incoming patch.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 10 ++++------
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/inode.c       | 45 ++++++++++++++++++++++++++++++------------
 3 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 8fda38a58706..69c060dc024c 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -152,7 +152,6 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
 	const u32 sectorsize = fs_info->sectorsize;
 	struct page *page;
 	unsigned int i;
-	char *kaddr;
 	u8 csum[BTRFS_CSUM_SIZE];
 	struct compressed_bio *cb = bio->bi_private;
 	u8 *cb_sum = cb->sums;
@@ -175,12 +174,11 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
 		/* Hash through the page sector by sector */
 		for (pg_offset = 0; pg_offset < bytes_left;
 		     pg_offset += sectorsize) {
-			kaddr = kmap_atomic(page);
-			crypto_shash_digest(shash, kaddr + pg_offset,
-					    sectorsize, csum);
-			kunmap_atomic(kaddr);
+			int ret;
 
-			if (memcmp(&csum, cb_sum, csum_size) != 0) {
+			ret = btrfs_check_data_sector(fs_info, page, pg_offset,
+						      cb_sum);
+			if (ret) {
 				btrfs_print_data_csum_error(inode, disk_start,
 						csum, cb_sum, cb->mirror_num);
 				if (btrfs_bio(bio)->device)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index dd23f78664f1..296fc2052aa9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3252,6 +3252,8 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path);
 /* inode.c */
 void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 			   int mirror_num, unsigned long bio_flags);
+int btrfs_check_data_sector(struct btrfs_fs_info *fs_info, struct page *page,
+			    u32 pgoff, u8 *csum_expected);
 unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
 				    u32 bio_offset, struct page *page,
 				    u64 start, u64 end);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 507e3a0055e5..5b1a60a25ef6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3299,6 +3299,32 @@ void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 				       finish_ordered_fn, uptodate);
 }
 
+/*
+ * Verify the checksum for a single sector without any extra action that
+ * depend on the type of I/O.
+ */
+int btrfs_check_data_sector(struct btrfs_fs_info *fs_info, struct page *page,
+			    u32 pgoff, u8 *csum_expected)
+{
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	char *kaddr;
+	const u32 len = fs_info->sectorsize;
+	const u32 csum_size = fs_info->csum_size;
+	u8 csum[BTRFS_CSUM_SIZE];
+
+	ASSERT(pgoff + len <= PAGE_SIZE);
+
+	kaddr = kmap_local_page(page) + pgoff;
+	shash->tfm = fs_info->csum_shash;
+
+	crypto_shash_digest(shash, kaddr, len, csum);
+	kunmap_local(kaddr);
+
+	if (memcmp(csum, csum_expected, csum_size))
+		return -EIO;
+	return 0;
+}
+
 /*
  * check_data_csum - verify checksum of one sector of uncompressed data
  * @inode:	inode
@@ -3309,15 +3335,16 @@ void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
  * @start:	logical offset in the file
  *
  * The length of such check is always one sector size.
+ *
+ * When csum mismatch detected, we will also report the error and fill the
+ * corrupted range with zero. (thus it needs the extra parameters)
  */
 static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
 			   u32 bio_offset, struct page *page, u32 pgoff,
 			   u64 start)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-	char *kaddr;
-	u32 len = fs_info->sectorsize;
+	const u32 len = fs_info->sectorsize;
 	const u32 csum_size = fs_info->csum_size;
 	unsigned int offset_sectors;
 	u8 *csum_expected;
@@ -3328,17 +3355,9 @@ static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
 	offset_sectors = bio_offset >> fs_info->sectorsize_bits;
 	csum_expected = ((u8 *)bbio->csum) + offset_sectors * csum_size;
 
-	kaddr = kmap_atomic(page);
-	shash->tfm = fs_info->csum_shash;
-
-	crypto_shash_digest(shash, kaddr + pgoff, len, csum);
-	kunmap_atomic(kaddr);
-
-	if (memcmp(csum, csum_expected, csum_size))
-		goto zeroit;
+	if (!btrfs_check_data_sector(fs_info, page, pgoff, csum_expected))
+		return 0;
 
-	return 0;
-zeroit:
 	btrfs_print_data_csum_error(BTRFS_I(inode), start, csum, csum_expected,
 				    bbio->mirror_num);
 	if (bbio->device)
-- 
2.36.0

