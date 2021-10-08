Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C394142653C
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Oct 2021 09:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhJHHcE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Oct 2021 03:32:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57642 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhJHHcE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Oct 2021 03:32:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C9ABD223DF
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Oct 2021 07:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633678208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sCh92DmzNYJgdr8XRw2794/LK6us98SMauaOYVlSdME=;
        b=Ki7Qjb0OarUxF+Hg1woCm5j0agM3+xs9fbn6BMVsoBNjz0CAD5NrrWsbDyRLN1c1fAS7pz
        78xmTsoX3jWZXS4UYol+d/KOvdIdHwDUGnjmnA0Rgv4pg1bCIe82uPLBj9kHK0UtedHQ3q
        OBBvtgpNiQK/3WFsxhXfI3zg9vObBG4=
Received: from adam-pc.lan (wqu.tcp.ovpn2.nue.suse.de [10.163.34.62])
        by relay2.suse.de (Postfix) with ESMTP id C38BFA3B85
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Oct 2021 07:30:07 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: rename btrfs_dio_private::logical_offset to file_offset
Date:   Fri,  8 Oct 2021 15:29:59 +0800
Message-Id: <20211008073000.62391-2-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211008073000.62391-1-wqu@suse.com>
References: <20211008073000.62391-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The naming of "logical_offset" can be confused with logical bytenr of
the dio range.

In fact it's file offset, and the naming "file_offset" is already widely
used in all other sites.

Just do the rename to avoid confusion.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h |  7 ++++++-
 fs/btrfs/inode.c       | 12 ++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 602b426c286d..ab2a4a52e0bb 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -356,7 +356,12 @@ static inline bool btrfs_inode_in_log(struct btrfs_inode *inode, u64 generation)
 
 struct btrfs_dio_private {
 	struct inode *inode;
-	u64 logical_offset;
+
+	/*
+	 * Since DIO can use anonymous page, we cannot use page_offset() to
+	 * grab the file offset, thus need a dedicated member for file offset.
+	 */
+	u64 file_offset;
 	u64 disk_bytenr;
 	/* Used for bio::bi_size */
 	u32 bytes;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f5faa6bedbd4..d65f7d6b7df1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8055,13 +8055,13 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 
 	if (btrfs_op(dip->dio_bio) == BTRFS_MAP_WRITE) {
 		__endio_write_update_ordered(BTRFS_I(dip->inode),
-					     dip->logical_offset,
+					     dip->file_offset,
 					     dip->bytes,
 					     !dip->dio_bio->bi_status);
 	} else {
 		unlock_extent(&BTRFS_I(dip->inode)->io_tree,
-			      dip->logical_offset,
-			      dip->logical_offset + dip->bytes - 1);
+			      dip->file_offset,
+			      dip->file_offset + dip->bytes - 1);
 	}
 
 	bio_endio(dip->dio_bio);
@@ -8176,7 +8176,7 @@ static void btrfs_end_dio_bio(struct bio *bio)
 	if (err)
 		dip->dio_bio->bi_status = err;
 
-	btrfs_record_physical_zoned(dip->inode, dip->logical_offset, bio);
+	btrfs_record_physical_zoned(dip->inode, dip->file_offset, bio);
 
 	bio_put(bio);
 	btrfs_dio_private_put(dip);
@@ -8218,7 +8218,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 	} else {
 		u64 csum_offset;
 
-		csum_offset = file_offset - dip->logical_offset;
+		csum_offset = file_offset - dip->file_offset;
 		csum_offset >>= fs_info->sectorsize_bits;
 		csum_offset *= fs_info->csum_size;
 		btrfs_bio(bio)->csum = dip->csums + csum_offset;
@@ -8256,7 +8256,7 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 		return NULL;
 
 	dip->inode = inode;
-	dip->logical_offset = file_offset;
+	dip->file_offset = file_offset;
 	dip->bytes = dio_bio->bi_iter.bi_size;
 	dip->disk_bytenr = dio_bio->bi_iter.bi_sector << 9;
 	dip->dio_bio = dio_bio;
-- 
2.33.0

