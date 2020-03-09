Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC3417EB3D
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 22:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCIVdD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 17:33:03 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46273 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgCIVdD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 17:33:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id w12so4517173pll.13
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2020 14:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KlnSratDuh7Mb0mrIUd1+nwdt40J3jArN9hk+Bj7v9c=;
        b=DzkIu350t8f/ofqj5930gqwF7wK/krmohkS8Oy6r6l3JgCEUugCFUMZrWKxk5yVjMp
         wmDEURrsj+CIBw/jn0NxsZBE1h6beJ7ktpRVY3ex0ZWqnIUyeMb7GbdlrrDWE3f2hzcQ
         cjI/egEDXxjsK7VFAAhU0jIo95etjtVtJo/TeMkicy2ccPvUB8GSVJ6Kxj0ZPvbaWwrx
         hD0+k3k4TNy3+PDMRljr4kkwibxD+OYwqqXMF6mji9Ghs/YMBtagfsjTvrN/13m28U1D
         EpePusH48BD3d+WstOJuAt1dV9m3mBuqMgGpulUHuWKYYO25+FViOuVdmebZOtnNXCQP
         XlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KlnSratDuh7Mb0mrIUd1+nwdt40J3jArN9hk+Bj7v9c=;
        b=kNkmrUYvlRST1Tt+d+vKr165L5hlmmXENFNxhXCslkoqHxnqrm2wkOWhS2i9Tln10y
         dCmqk589p8TvfBybqtL842AaVklTR/rY+FgpllBCo8OhbfDluqgMyzSK5W92Z5+A8pE2
         Zzbej8gaB0ZrgUTnHnphFeW6AzExTvjfHKTnyzYpruWkqTcKcdDmo/c7MaiaAVgo/tIU
         ZpV+5mAimlazhZVrb7DoKTVgGee75Ao/Fbkfu2+GiSaWQ6szZWUdITK9q5jQEVfTgG1w
         qQy7E24F5mZFBPzZy8m3ggZ+fEESzjk+odZItUYcrcy5XejbsETJtiTGWEdfMV9y6gEK
         B/pA==
X-Gm-Message-State: ANhLgQ0dNfbOk9Wxthy4CQBIOmJuDU8B+U5pwC717h8ZejxP3QA9su3o
        dbH3IAl0DWtbGyLAWWikckaa/5fKSHE=
X-Google-Smtp-Source: ADFU+vth9RrrI1G1khrQZNV/VBAr31eFtnS4Uc4v/P2Elb5LoXXdVTSJqS70dH2KjrsqoTq59OdYSA==
X-Received: by 2002:a17:902:a516:: with SMTP id s22mr17266308plq.271.1583789579993;
        Mon, 09 Mar 2020 14:32:59 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:fe90])
        by smtp.gmail.com with ESMTPSA id 13sm44221683pgo.13.2020.03.09.14.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:32:59 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 05/15] btrfs: clarify btrfs_lookup_bio_sums documentation
Date:   Mon,  9 Mar 2020 14:32:31 -0700
Message-Id: <2ee5f090b52dc23569bf94a5a2609dfc49ac4a4b.1583789410.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583789410.git.osandov@fb.com>
References: <cover.1583789410.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Fix a couple of issues in the btrfs_lookup_bio_sums documentation:

* The bio doesn't need to be a btrfs_io_bio if dst was provided. Move
  the declaration in the code to make that clear, too.
* dst must be large enough to hold nblocks * csum_size, not just
  csum_size.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/file-item.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 6c849e8fd5a1..fa9f4a92f74d 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -242,11 +242,13 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 /**
  * btrfs_lookup_bio_sums - Look up checksums for a bio.
  * @inode: inode that the bio is for.
- * @bio: bio embedded in btrfs_io_bio.
+ * @bio: bio to look up.
  * @offset: Unless (u64)-1, look up checksums for this offset in the file.
  *          If (u64)-1, use the page offsets from the bio instead.
- * @dst: Buffer of size btrfs_super_csum_size() used to return checksum. If
- *       NULL, the checksum is returned in btrfs_io_bio(bio)->csum instead.
+ * @dst: Buffer of size nblocks * btrfs_super_csum_size() used to return
+ *       checksum (nblocks = bio->bi_iter.bi_size / sectorsize). If NULL, the
+ *       checksum buffer is allocated and returned in btrfs_io_bio(bio)->csum
+ *       instead.
  *
  * Return: BLK_STS_RESOURCE if allocating memory fails, BLK_STS_OK otherwise.
  */
@@ -256,7 +258,6 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct bio_vec bvec;
 	struct bvec_iter iter;
-	struct btrfs_io_bio *btrfs_bio = btrfs_io_bio(bio);
 	struct btrfs_csum_item *item = NULL;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_path *path;
@@ -277,6 +278,8 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 
 	nblocks = bio->bi_iter.bi_size >> inode->i_sb->s_blocksize_bits;
 	if (!dst) {
+		struct btrfs_io_bio *btrfs_bio = btrfs_io_bio(bio);
+
 		if (nblocks * csum_size > BTRFS_BIO_INLINE_CSUM_SIZE) {
 			btrfs_bio->csum = kmalloc_array(nblocks, csum_size,
 							GFP_NOFS);
-- 
2.25.1

