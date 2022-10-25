Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBBE60BFE7
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 02:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiJYAnF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 20:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJYAmZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 20:42:25 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC316186F2;
        Mon, 24 Oct 2022 16:14:30 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 0B55B811D7;
        Mon, 24 Oct 2022 19:13:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1666653240; bh=DM3CC6t2fbok6CzqMUsPW6N1ixGhc+b5yss6kVAQI3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GIOoeYQ26gmQ8C+HYJtrghepyS4ovQzPA/9zEk00/vuLTfLbg/w4bUMbMASOUuhMm
         SoIY1dc/hR9Y71obqgC6Zp5isMoL6C/4LAYUwF5n+7omO8j6JAh70Nav3n/Fz/znq8
         mYYtlYo9MHTO2vjUX7ZNsVJGm62tdw7zBFxoVvLoW40tiRVBDCYGi7autMPsvaGoVM
         pDgbCRQm0RILSSVhfndUlNVlA1jMtUJiOWC2tTSsCfos9BCinedKW/Oui7ervxcbHp
         FSuIyCc6LgwKlk/myF6lF6FpGYi/juyLjR4/rzUcVY+oD0VQVMRBsMv0xQM614XlPl
         YF1RPuVr+DcuQ==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@meta.com
Cc:     Omar Sandoval <osandov@osandov.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v4 11/21] btrfs: disable various operations on encrypted inodes
Date:   Mon, 24 Oct 2022 19:13:21 -0400
Message-Id: <cf0d8515689bb928a815806e29c47ef33036d1a0.1666651724.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1666651724.git.sweettea-kernel@dorminy.me>
References: <cover.1666651724.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 530a0ebfab3f..af23bd1fde36 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -385,6 +385,9 @@ static inline bool btrfs_inode_in_log(struct btrfs_inode *inode, u64 generation)
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
index a30ddd2697de..97d098b3c2e6 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1808,7 +1808,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		goto relock;
 	}
 
-	if (check_direct_IO(fs_info, from, pos)) {
+	if (IS_ENCRYPTED(inode) || check_direct_IO(fs_info, from, pos)) {
 		btrfs_inode_unlock(inode, ilock_flags);
 		goto buffered;
 	}
@@ -4045,7 +4045,7 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
 	ssize_t read = 0;
 	ssize_t ret;
 
-	if (fsverity_active(inode))
+	if (IS_ENCRYPTED(inode) || fsverity_active(inode))
 		return 0;
 
 	if (check_direct_read(btrfs_sb(inode->i_sb), to, iocb->ki_pos))
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c41ae611767c..55a8fe278435 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -432,7 +432,8 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
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
index f0243eb33df7..4143ebf22d7f 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -808,6 +808,13 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
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

