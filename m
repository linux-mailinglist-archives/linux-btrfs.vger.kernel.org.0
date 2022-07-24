Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8B957F250
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jul 2022 02:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbiGXAyg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jul 2022 20:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239230AbiGXAye (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jul 2022 20:54:34 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3E614D3B;
        Sat, 23 Jul 2022 17:54:33 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id B0E6480BB8;
        Sat, 23 Jul 2022 20:54:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658624073; bh=Tcq2bnL7jZeUTtV/zMFhKPN5qxzKJGbsGbjP0h8/bsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B8bzyEJRbAWDO1uvBY5yJtfbqFa1tmoqO6UFGhYgjgVoyD/FL+vCW2ApvTejiCiZb
         5tNZ6UYFcXh2oG2lVGay3k5f5Ag5KZG2i1u9JZeGEx2ZOIBJN0bopsGeaXii33hp/v
         rF9oHMUR0p3moTLLx25mV2R4F5WSgbSrQMgeDckzn2tO7DQ0Tajp2KUmozcrwOrJxk
         XOE3/XbZGZ0j17ooXNLYpk4sYosNhWwnlQkMH4+RawV9O7JYfjWrZFCRIMfYn/VnNT
         s3haCRBrAXeT1HZfOffz552znBiF5GwrVejUdJ/9n4z8e8iulIDfANp43P8pJoFprr
         2lyZSbrx6z71Q==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, osandov@osandov.com,
        kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH RFC v2 05/16] btrfs: disable various operations on encrypted inodes
Date:   Sat, 23 Jul 2022 20:53:50 -0400
Message-Id: <58760cc4416ca2e3903c962cc02b9bc4a251a0e9.1658623319.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1658623319.git.sweettea-kernel@dorminy.me>
References: <cover.1658623319.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@osandov.com>

Initially, only normal data extents, using the normal (non-direct) IO
path, will be encrypted. This change forbids various other bits:
- allows reflinking only if both inodes have the same encryption status
- disables compressing encrypted inodes
- disables direct IO on encrypted inodes
- disable inline data on encrypted inodes

Signed-off-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/btrfs_inode.h | 3 +++
 fs/btrfs/file.c        | 4 ++--
 fs/btrfs/inode.c       | 3 ++-
 fs/btrfs/reflink.c     | 7 +++++++
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index b160b8e124e0..ff668686717b 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -400,6 +400,9 @@ static inline bool btrfs_inode_in_log(struct btrfs_inode *inode, u64 generation)
  */
 static inline bool btrfs_inode_can_compress(const struct btrfs_inode *inode)
 {
+	if (IS_ENCRYPTED(&inode->vfs_inode))
+		return false;
+
 	if (inode->flags & BTRFS_INODE_NODATACOW ||
 	    inode->flags & BTRFS_INODE_NODATASUM)
 		return false;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index d199275adfa4..1fa0fe9f122f 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1896,7 +1896,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		goto relock;
 	}
 
-	if (check_direct_IO(fs_info, from, pos)) {
+	if (IS_ENCRYPTED(inode) || check_direct_IO(fs_info, from, pos)) {
 		btrfs_inode_unlock(inode, ilock_flags);
 		goto buffered;
 	}
@@ -3743,7 +3743,7 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
 	ssize_t read = 0;
 	ssize_t ret;
 
-	if (fsverity_active(inode))
+	if (IS_ENCRYPTED(inode) || fsverity_active(inode))
 		return 0;
 
 	if (check_direct_read(btrfs_sb(inode->i_sb), to, iocb->ki_pos))
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 12381c87177e..2faa0ddfedf9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -409,7 +409,8 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
 	 * compressed) data fits in a leaf and the configured maximum inline
 	 * size.
 	 */
-	if (size < i_size_read(&inode->vfs_inode) ||
+	if (IS_ENCRYPTED(&inode->vfs_inode) ||
+	    size < i_size_read(&inode->vfs_inode) ||
 	    size > fs_info->sectorsize ||
 	    data_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info) ||
 	    data_len > fs_info->max_inline)
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 9acf47b11fe6..d22086e1cbc8 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -805,6 +805,13 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 		ASSERT(inode_in->i_sb == inode_out->i_sb);
 	}
 
+	/*
+	 * Can only reflink encrypted files if both files are encrypted.
+	 */
+	if (!fscrypt_have_same_policy(inode_in, inode_out)) {
+		return -EINVAL;
+	}
+
 	/* Don't make the dst file partly checksummed */
 	if ((BTRFS_I(inode_in)->flags & BTRFS_INODE_NODATASUM) !=
 	    (BTRFS_I(inode_out)->flags & BTRFS_INODE_NODATASUM)) {
-- 
2.35.1

