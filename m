Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58776118FE0
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 19:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfLJShs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 13:37:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44032 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbfLJShs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 13:37:48 -0500
Received: by mail-pg1-f193.google.com with SMTP id x7so9284725pgl.11
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2019 10:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yyEiZwivy85n8pFxJDkvy20/Yf89VR2Oylwmb6c/l5Q=;
        b=h50R1lqtn1n8e7gMNEIWUJV1ziziRx2yvFV1+WI7/PTMZuuKnU1dJqWJV5rcA4K6d0
         V73twgsOyUl552pGVM9Lj3S4JuDGsVcrJ6s+VUmkdp/csmzZLdOqpVdZVX3p8k9iXX2f
         RAwoqQ7NCD1TUHnbyOMothEmZ4ijw74iUTI1SXjYajtp/fZ27OQSHApB78zirGWGWKR/
         X4YYC7u07SurWAji4nhTm4I+IywfjBAj6PbLF32FKySQODkKemrVDDkDAc8Hk1obSXOF
         d/Sb2qAWVxm3vCSGqSR/hAX3tChFCECht011GhvsiTYaqn0mVLGyfJVAUg44veQKbgha
         KdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yyEiZwivy85n8pFxJDkvy20/Yf89VR2Oylwmb6c/l5Q=;
        b=ZOTkZd+E+5VyIbz2p+F27BJmXCUVIjAs/3r0xp/AQFsOFbtjTG2oxTBat7pD10EzVu
         hJmoPuhedx3OYDyg6ltnbYhm0Fuxw42tWLHG65cBlrsnmgF5V3ioRKF6s1TUhxxzQljl
         AnKnVz97hgipU9sW2EMwljKNsJXX4GZ0EWtY4Dmkykcrk/em/jKfw89HpQNpuGKmSnMb
         VHcOuSHdSt7+aLywi5EAUg3T+Y3IyOINgEs35V68rTZonYPNQG5Vg3c3aL0RvedTnGss
         6uP5ZGjnYKHQNxFOLFjSUZHZd0U50g6JVIXWb+zJo/PL73Zv/W9e+omvkn/9r8wUG7WU
         KHbQ==
X-Gm-Message-State: APjAAAW4kXvGoy1FXkzsA3ab7Qb2s2ve282UW+7FfwIn2KWzpwu+ykx1
        OJNuAh9tBHcSrUorXT4/3I4VHVmWefNU5g==
X-Google-Smtp-Source: APXvYqyoTiWY+NihfCGkumDcFutGCXTpkHSDAU8ltaWX7id7ZDtDv0PfZ2d6whiVMV1RMhJB30JzOw==
X-Received: by 2002:a63:e30a:: with SMTP id f10mr25597534pgh.331.1576003067202;
        Tue, 10 Dec 2019 10:37:47 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:200::1:c519])
        by smtp.gmail.com with ESMTPSA id o184sm4028647pgo.62.2019.12.10.10.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 10:37:46 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
Cc:     kernel-team@fb.com
Subject: [PATCH] btrfs: get rid of at_offset parameter to btrfs_lookup_bio_sums()
Date:   Tue, 10 Dec 2019 10:37:35 -0800
Message-Id: <a52f14650c1d0d0b1371c15df4a76e2089864d76.1576003002.git.osandov@fb.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210182606.GG3929@twin.jikos.cz>
References: <20191210182606.GG3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

We can encode this in the offset parameter: -1 means use the page
offsets, anything else is a valid offset.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Feel free to fold this in or apply separately as needed.

 fs/btrfs/compression.c |  6 +++---
 fs/btrfs/ctree.h       |  2 +-
 fs/btrfs/file-item.c   | 11 +++++------
 fs/btrfs/inode.c       |  6 +++---
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 03eb50727038..4a8578512c07 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -757,8 +757,8 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			refcount_inc(&cb->pending_bios);
 
 			if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
-				ret = btrfs_lookup_bio_sums(inode, comp_bio,
-							    false, 0, sums);
+				ret = btrfs_lookup_bio_sums(inode, comp_bio, -1,
+							    sums);
 				BUG_ON(ret); /* -ENOMEM */
 			}
 
@@ -786,7 +786,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	BUG_ON(ret); /* -ENOMEM */
 
 	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
-		ret = btrfs_lookup_bio_sums(inode, comp_bio, false, 0, sums);
+		ret = btrfs_lookup_bio_sums(inode, comp_bio, -1, sums);
 		BUG_ON(ret); /* -ENOMEM */
 	}
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6e2ac3e06c45..6b2af3ab2c26 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2789,7 +2789,7 @@ struct btrfs_dio_private;
 int btrfs_del_csums(struct btrfs_trans_handle *trans,
 		    struct btrfs_fs_info *fs_info, u64 bytenr, u64 len);
 blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
-				   bool at_offset, u64 offset, u8 *dst);
+				   u64 offset, u8 *dst);
 int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
 			     u64 objectid, u64 pos,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 6f7777e5a554..76a433aba675 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -152,17 +152,15 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
  * btrfs_lookup_bio_sums - Look up checksums for a bio.
  * @inode: inode that the bio is for.
  * @bio: bio embedded in btrfs_io_bio.
- * @at_offset: If true, look up checksums for the extent at @offset.
- *             If false, use the page offsets from the bio.
- * @offset: If @at_offset is true, offset in file to look up checksums for.
- *          Ignored otherwise.
+ * @offset: Unless -1, look up checksums for this offset in the file. If -1, use
+ *          the page offsets from the bio instead.
  * @dst: Buffer of size btrfs_super_csum_size() used to return checksum. If
  *       NULL, the checksum is returned in btrfs_io_bio(bio)->csum instead.
  *
  * Return: BLK_STS_RESOURCE if allocating memory fails, BLK_STS_OK otherwise.
  */
 blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
-				   bool at_offset, u64 offset, u8 *dst)
+				   u64 offset, u8 *dst)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct bio_vec bvec;
@@ -171,6 +169,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 	struct btrfs_csum_item *item = NULL;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_path *path;
+	bool page_offsets = offset == (u64)-1;
 	u8 *csum;
 	u64 item_start_offset = 0;
 	u64 item_last_offset = 0;
@@ -223,7 +222,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 		if (count)
 			goto next;
 
-		if (!at_offset)
+		if (page_offsets)
 			offset = page_offset(bvec.bv_page) + bvec.bv_offset;
 		count = btrfs_find_ordered_sum(inode, offset, disk_bytenr,
 					       csum, nblocks);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 056e4035e469..3c812f3ba1ba 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2127,7 +2127,7 @@ static blk_status_t btrfs_submit_bio_hook(struct inode *inode, struct bio *bio,
 							   bio_flags);
 			goto out;
 		} else if (!skip_sum) {
-			ret = btrfs_lookup_bio_sums(inode, bio, false, 0, NULL);
+			ret = btrfs_lookup_bio_sums(inode, bio, -1, NULL);
 			if (ret)
 				goto out;
 		}
@@ -7690,8 +7690,8 @@ static inline blk_status_t btrfs_lookup_and_bind_dio_csum(struct inode *inode,
 	 * contention.
 	 */
 	if (dip->logical_offset == file_offset) {
-		ret = btrfs_lookup_bio_sums(inode, dip->orig_bio, true,
-					    file_offset, NULL);
+		ret = btrfs_lookup_bio_sums(inode, dip->orig_bio, file_offset,
+					    NULL);
 		if (ret)
 			return ret;
 	}
-- 
2.24.0

