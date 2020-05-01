Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCC31C0E62
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 08:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgEAGxe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 May 2020 02:53:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbgEAGxe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 May 2020 02:53:34 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C275F2054F
        for <linux-btrfs@vger.kernel.org>; Fri,  1 May 2020 06:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588316013;
        bh=59tjm6JIXvVmrkBM4hZ/cU7zPM0wNrLnx/EX5O0vItY=;
        h=From:To:Subject:Date:From;
        b=O5t4eccbmmP1Q8E4gXdakKQKCcskOXxO0u083XDAU2VO1Hf97Ui5s0Eae9sa1/LoX
         deG0J0nPaxkTOTlFrXlvVPg93vhi+QPZJOGNUqtJQER6L3MqfPZ5BDvzxnyS2vm1C6
         li4nLHoLATvAnAJF1bcHe4Creg1ywhigiO6BRDeo=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use crypto_shash_digest()
Date:   Thu, 30 Apr 2020 23:51:59 -0700
Message-Id: <20200501065159.738746-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Use crypto_shash_digest() instead of crypto_shash_init() +
crypto_shash_update() + crypto_shash_final().  This is more efficient.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/btrfs/compression.c |  4 +---
 fs/btrfs/disk-io.c     | 13 +++++--------
 fs/btrfs/file-item.c   |  7 +++----
 fs/btrfs/inode.c       |  4 +---
 4 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 9ab610cc911420..1b624f9ef97d59 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -194,11 +194,9 @@ static int check_compressed_csum(struct btrfs_inode *inode,
 	for (i = 0; i < cb->nr_pages; i++) {
 		page = cb->compressed_pages[i];
 
-		crypto_shash_init(shash);
 		kaddr = kmap_atomic(page);
-		crypto_shash_update(shash, kaddr, PAGE_SIZE);
+		crypto_shash_digest(shash, kaddr, PAGE_SIZE, csum);
 		kunmap_atomic(kaddr);
-		crypto_shash_final(shash, (u8 *)&csum);
 
 		if (memcmp(&csum, cb_sum, csum_size)) {
 			btrfs_print_data_csum_error(inode, disk_start,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d10c7be10f3b80..8050172b39ef57 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -358,16 +358,14 @@ static int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 
 	shash->tfm = fs_info->csum_shash;
-	crypto_shash_init(shash);
 
 	/*
 	 * The super_block structure does not span the whole
 	 * BTRFS_SUPER_INFO_SIZE range, we expect that the unused space is
 	 * filled with zeros and is included in the checksum.
 	 */
-	crypto_shash_update(shash, raw_disk_sb + BTRFS_CSUM_SIZE,
-			    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
-	crypto_shash_final(shash, result);
+	crypto_shash_digest(shash, raw_disk_sb + BTRFS_CSUM_SIZE,
+			    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE, result);
 
 	if (memcmp(disk_sb->csum, result, btrfs_super_csum_size(disk_sb)))
 		return 1;
@@ -3510,10 +3508,9 @@ static int write_dev_supers(struct btrfs_device *device,
 
 		btrfs_set_super_bytenr(sb, bytenr);
 
-		crypto_shash_init(shash);
-		crypto_shash_update(shash, (const char *)sb + BTRFS_CSUM_SIZE,
-				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
-		crypto_shash_final(shash, sb->csum);
+		crypto_shash_digest(shash, (const char *)sb + BTRFS_CSUM_SIZE,
+				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE,
+				    sb->csum);
 
 		page = find_or_create_page(mapping, bytenr >> PAGE_SHIFT,
 					   GFP_NOFS);
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 22cbb4da6d429e..8cdd06ea0e67a8 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -601,13 +601,12 @@ blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
 				index = 0;
 			}
 
-			crypto_shash_init(shash);
 			data = kmap_atomic(bvec.bv_page);
-			crypto_shash_update(shash, data + bvec.bv_offset
+			crypto_shash_digest(shash, data + bvec.bv_offset
 					    + (i * fs_info->sectorsize),
-					    fs_info->sectorsize);
+					    fs_info->sectorsize,
+					    sums->sums + index);
 			kunmap_atomic(data);
-			crypto_shash_final(shash, (char *)(sums->sums + index));
 			index += csum_size;
 			offset += fs_info->sectorsize;
 			this_sum_bytes += fs_info->sectorsize;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1462f64c2c4b52..3b119bb11549fd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2742,9 +2742,7 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
 	kaddr = kmap_atomic(page);
 	shash->tfm = fs_info->csum_shash;
 
-	crypto_shash_init(shash);
-	crypto_shash_update(shash, kaddr + pgoff, len);
-	crypto_shash_final(shash, csum);
+	crypto_shash_digest(shash, kaddr + pgoff, len, csum);
 
 	if (memcmp(csum, csum_expected, csum_size))
 		goto zeroit;
-- 
2.26.2

