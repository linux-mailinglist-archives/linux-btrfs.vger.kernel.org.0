Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39374371050
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 May 2021 03:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhECBaW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 May 2021 21:30:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:50912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbhECBaW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 2 May 2021 21:30:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620005369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0lEOc6I/dtdUzKeJuLUFmx0BgvnobRORq6ajnxyBpw=;
        b=HXBxxYT+WohWLFuSExJiqd+zyEJKe54KV/gwFJzW2EjwPo8mkJubMKPG1u/lY+PA3ybHU3
        3pJ9HAlSOuS7sbJ8KG4KpM68MCwDR36UTQASx+5tiYrVEmk6VmMXB0wRr2YFWlcK2REdjC
        o+tk16y3jGDZogBqOqPXT3Rp69bFljE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F24DBB05E
        for <linux-btrfs@vger.kernel.org>; Mon,  3 May 2021 01:29:28 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/4] btrfs: remove the dead branch in btrfs_io_needs_validation()
Date:   Mon,  3 May 2021 09:29:21 +0800
Message-Id: <20210503012924.77865-2-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503012924.77865-1-wqu@suse.com>
References: <20210503012924.77865-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In function btrfs_io_needs_validation() we are ensured to get a
non-cloned bio.
The only caller, end_bio_extent_readpage(), already has an ASSERT() to
make sure we only get non-cloned bios.

Thus the (bio_flagged(bio, BIO_CLONED)) branch will never get executed.

Remove the dead branch and updated the comment.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 14ab11381d49..0787fae5f7f1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2644,8 +2644,10 @@ static bool btrfs_check_repairable(struct inode *inode, bool needs_validation,
 
 static bool btrfs_io_needs_validation(struct inode *inode, struct bio *bio)
 {
+	struct bio_vec *bvec;
 	u64 len = 0;
 	const u32 blocksize = inode->i_sb->s_blocksize;
+	int i;
 
 	/*
 	 * If bi_status is BLK_STS_OK, then this was a checksum error, not an
@@ -2669,30 +2671,13 @@ static bool btrfs_io_needs_validation(struct inode *inode, struct bio *bio)
 	if (blocksize < PAGE_SIZE)
 		return false;
 	/*
-	 * We need to validate each sector individually if the failed I/O was
-	 * for multiple sectors.
-	 *
-	 * There are a few possible bios that can end up here:
-	 * 1. A buffered read bio, which is not cloned.
-	 * 2. A direct I/O read bio, which is cloned.
-	 * 3. A (buffered or direct) repair bio, which is not cloned.
-	 *
-	 * For cloned bios (case 2), we can get the size from
-	 * btrfs_io_bio->iter; for non-cloned bios (cases 1 and 3), we can get
-	 * it from the bvecs.
+	 * We're ensured we won't get cloned bio in end_bio_extent_readpage(),
+	 * thus we can get the length from the bvecs.
 	 */
-	if (bio_flagged(bio, BIO_CLONED)) {
-		if (btrfs_io_bio(bio)->iter.bi_size > blocksize)
+	bio_for_each_bvec_all(bvec, bio, i) {
+		len += bvec->bv_len;
+		if (len > blocksize)
 			return true;
-	} else {
-		struct bio_vec *bvec;
-		int i;
-
-		bio_for_each_bvec_all(bvec, bio, i) {
-			len += bvec->bv_len;
-			if (len > blocksize)
-				return true;
-		}
 	}
 	return false;
 }
-- 
2.31.1

