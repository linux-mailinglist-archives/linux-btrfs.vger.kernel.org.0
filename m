Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A534BBBC6
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 16:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiBRPDw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 10:03:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiBRPDv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 10:03:51 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25069294FDB
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:03:35 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id j78so3552938qke.2
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ni7VePx5kF+Kb2E63fpeRR+qyCxIn9y0blCeXC97V/M=;
        b=a9wR0WLhQkgBCcEdyzKDk+ujoirDMebugSQVAyS3hFJXthehvLGZ8x4UJZJuxVT7eM
         IT56yHZZkSS9syQUL2OzUnA+dLQne+WuNVVEa+3h+2pjJ78HVVZEhRC5RUYBgVbsv8BA
         fYYBE9xq4xm/uWObWqKtHaYLXENyLZGjVaz+yr/OfTZMCjMF4s44GGc19MlVb61x8316
         2Tfhum0OcZfK1MIe9VgXAsjLevw+OsgBD187DMyVtuuCQedvNRUQ+FtC8Vu6RJPfZLG8
         l0QGNwc5H5tEZj+vBr3Hqj7mhKwJxUHromjjtyaO5CR0opnkzTxCWDNeq9UDYcXuII8v
         RsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ni7VePx5kF+Kb2E63fpeRR+qyCxIn9y0blCeXC97V/M=;
        b=djTiPUvw+RXdZJf1FSHrif5dZFwjSXKz9/hriwYbDqmW9FETt5hn28cTbknaKRRlEd
         3ibsfjMYUxZCYf1aYa6oQmHlWmWibC5D+Z6DjAO68JIcb3NzZv7o54PTDXTJOIpZ9ZC1
         m7xP1SjtC6p0e1VrVrEsih+jzyR+KDL4qn+Q74odgn0//n4BBaSvqGNxorNvrGDYOcUE
         zAUhU1WI7OvHFIHtEyFdv62xSogFutzsp2DnkpfNBcOtKlibDx6Q8FopWitDnMrntfDs
         Q6lqBunIyyKTmcE0WP8IiIjRGGE48hH5QGOHBvalhuIaNESxRKub7Fb+Foj6IWZf1Ex5
         U++g==
X-Gm-Message-State: AOAM5337WaHYUq7gPWv4kj2nJNAwZ2jZsAn3kVoODUePXIPIKfoVHQWZ
        PFxX+C4p3qJflZG4bpT9sjQo/TtWRZiCx98m
X-Google-Smtp-Source: ABdhPJzBx/EDWiyhY40HiNuTVQ4tEtr3p5lAcX2gBkp/PO7QLKX+t8wSZuIV/kiwgwQVFDhPvf4/Tg==
X-Received: by 2002:a05:620a:2a0b:b0:47e:174f:12d2 with SMTP id o11-20020a05620a2a0b00b0047e174f12d2mr4953069qkp.331.1645196613841;
        Fri, 18 Feb 2022 07:03:33 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v5sm22704786qkp.70.2022.02.18.07.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:03:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/8] btrfs: handle csum lookup errors properly on reads
Date:   Fri, 18 Feb 2022 10:03:23 -0500
Message-Id: <5b9da7cdf4f3bb6edbf6e52313f8451be10f56a6.1645196493.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645196493.git.josef@toxicpanda.com>
References: <cover.1645196493.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently any error we get while trying to lookup csums during reads
shows up as a missing csum, and then on the read completion side we spit
out an error saying there was a csum mismatch and we increase the device
corruption count.

However we could have gotten an EIO from the lookup.  We could also be
inside of a memory constrained container and gotten a ENOMEM while
trying to do the read.  In either case we don't want to make this look
like a file system corruption problem, we want to make it look like the
actual error it is.  Capture any negative value, convert it to the
appropriate blk_sts_t, free the csum array if we have one and bail.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file-item.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index efb24cc0b083..1ce5988297c3 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -368,6 +368,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	struct btrfs_bio *bbio = NULL;
 	struct btrfs_path *path;
 	const u32 sectorsize = fs_info->sectorsize;
 	const u32 csum_size = fs_info->csum_size;
@@ -377,6 +378,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 	u8 *csum;
 	const unsigned int nblocks = orig_len >> fs_info->sectorsize_bits;
 	int count = 0;
+	blk_status_t ret = BLK_STS_OK;
 
 	if ((BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM) ||
 	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state))
@@ -400,7 +402,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 		return BLK_STS_RESOURCE;
 
 	if (!dst) {
-		struct btrfs_bio *bbio = btrfs_bio(bio);
+		bbio = btrfs_bio(bio);
 
 		if (nblocks * csum_size > BTRFS_BIO_INLINE_CSUM_SIZE) {
 			bbio->csum = kmalloc_array(nblocks, csum_size, GFP_NOFS);
@@ -456,21 +458,32 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 
 		count = search_csum_tree(fs_info, path, cur_disk_bytenr,
 					 search_len, csum_dst);
-		if (count <= 0) {
-			/*
-			 * Either we hit a critical error or we didn't find
-			 * the csum.
-			 * Either way, we put zero into the csums dst, and skip
-			 * to the next sector.
-			 */
+		if (count < 0) {
+			ret = errno_to_blk_status(count);
+			if (bbio)
+				btrfs_bio_free_csum(bbio);
+			break;
+		}
+
+		/*
+		 * We didn't find a csum for this range.  We need to make sure
+		 * we complain loudly about this, because we are not NODATASUM.
+		 *
+		 * However for the DATA_RELOC inode we could potentially be
+		 * relocating data extents for a NODATASUM inode, so the inode
+		 * itself won't be marked with NODATASUM, but the extent we're
+		 * copying is in fact NODATASUM.  If we don't find a csum we
+		 * assume this is the case.
+		 *
+		 * TODO: make the relocation code look up the owning inode and
+		 * see if it's marked as NODATASUM and set EXTENT_NODATASUM
+		 * there, that way if there's corruption and there isn't a
+		 * checksum when we want it we can fail here rather than later.
+		 */
+		if (count == 0) {
 			memset(csum_dst, 0, csum_size);
 			count = 1;
 
-			/*
-			 * For data reloc inode, we need to mark the range
-			 * NODATASUM so that balance won't report false csum
-			 * error.
-			 */
 			if (BTRFS_I(inode)->root->root_key.objectid ==
 			    BTRFS_DATA_RELOC_TREE_OBJECTID) {
 				u64 file_offset;
@@ -491,7 +504,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 	}
 
 	btrfs_free_path(path);
-	return BLK_STS_OK;
+	return ret;
 }
 
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
-- 
2.26.3

