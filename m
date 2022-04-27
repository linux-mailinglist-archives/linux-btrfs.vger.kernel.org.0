Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD3D511241
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 09:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358692AbiD0HWb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 03:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358679AbiD0HW3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 03:22:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05565DA24
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 00:19:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8B8F71F746
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651043957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=acyBe6rvzfKzhpGS/MGpajtzBz01A+WsLP7OTMBJdiU=;
        b=JEpzhLyCNd7bmENyORxWaui2shgYwZD+gqni4hAo8OkH/p02u+bSz3Qs0j2ezxZl8SseqY
        dN6RzeuvYurm6r0ZRIsOXMgl2JeUK1pxFhlkKH2Z1InNTeGVOzN2hU7axCTuYZunfJik2C
        kWsKjwHim6+wLW2dlcZbVQ9E5MYyB2Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0BB313A39
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uEcSJXTuaGIbJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:16 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC v2 01/12] btrfs: introduce a pure data checksum checking helper
Date:   Wed, 27 Apr 2022 15:18:47 +0800
Message-Id: <552b8ca1c4757a9b1fe85c2545d951d12422dfd8.1651043617.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <cover.1651043617.git.wqu@suse.com>
References: <cover.1651043617.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 fs/btrfs/compression.c | 10 ++++-----
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/inode.c       | 50 +++++++++++++++++++++++++++++++-----------
 3 files changed, 43 insertions(+), 19 deletions(-)

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
index 507e3a0055e5..b4cfd78f50e8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3299,6 +3299,37 @@ void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 				       finish_ordered_fn, uptodate);
 }
 
+/*
+ * Just verify one sector of csum, without any extra handling.
+ *
+ * Functions like btrfs_verify_data_csum() have extra handling like setting
+ * page flags which is not suitable for call sites like direct IO.
+ *
+ * This pure csum checking allows us to utilize it for call sites which need
+ * to handle page for both buffered and direct IO.
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
+	kaddr = kmap_atomic(page);
+	shash->tfm = fs_info->csum_shash;
+
+	crypto_shash_digest(shash, kaddr + pgoff, len, csum);
+	kunmap_atomic(kaddr);
+
+	if (memcmp(csum, csum_expected, csum_size))
+		return -EIO;
+	return 0;
+}
+
 /*
  * check_data_csum - verify checksum of one sector of uncompressed data
  * @inode:	inode
@@ -3309,15 +3340,16 @@ void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
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
@@ -3328,17 +3360,9 @@ static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
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

