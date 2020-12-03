Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533C62CD0D5
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 09:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388221AbgLCIKi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 03:10:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:58204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387620AbgLCIKh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 03:10:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606982991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=X2+vA2PFsoXFpyTH/dVCuwEszp4fJW9TmeyIdARDkXk=;
        b=ma8VUIWB5fat65aYDpQoA1urEzMnHppOG6XEvDtu5H8CrpPY5uQGLD4BIDTbKdxCz2mOr8
        AbS1LCjquZ1zFu/yssPGvPWSsS3PGDQt2hv9PBRb3kG2Ql05/LXDGMoEDHiiNugrDbtzhV
        mEOLecz0iVOJBen6VBahcUEE9Gcu2sU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 02D2AACC2;
        Thu,  3 Dec 2020 08:09:51 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/2] btrfs: Remove logic for !crc_check case
Date:   Thu,  3 Dec 2020 10:09:48 +0200
Message-Id: <20201203080949.3759006-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Following removal of the ino cache io_ctl_init will be called only on
behalf of the freespace inode. In this case we always want to check
crcs so conditional code that dependen on io_ctl::check_crc can be
removed.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
David,

Here are 2 patches that followup based on your feedback of the ino removal
feature, I have run a full xfstest run to validate them.

 fs/btrfs/free-space-cache.c | 38 ++++++-------------------------------
 fs/btrfs/free-space-cache.h |  1 -
 2 files changed, 6 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index cd5996350cf0..e83b3bdc4e46 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -364,16 +364,11 @@ static int io_ctl_init(struct btrfs_io_ctl *io_ctl, struct inode *inode,
 		       int write)
 {
 	int num_pages;
-	int check_crcs = 0;

 	num_pages = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);

-	if (btrfs_ino(BTRFS_I(inode)) != BTRFS_FREE_INO_OBJECTID)
-		check_crcs = 1;
-
 	/* Make sure we can fit our crcs and generation into the first page */
-	if (write && check_crcs &&
-	    (num_pages * sizeof(u32) + sizeof(u64)) > PAGE_SIZE)
+	if (write && (num_pages * sizeof(u32) + sizeof(u64)) > PAGE_SIZE)
 		return -ENOSPC;

 	memset(io_ctl, 0, sizeof(struct btrfs_io_ctl));
@@ -384,7 +379,6 @@ static int io_ctl_init(struct btrfs_io_ctl *io_ctl, struct inode *inode,

 	io_ctl->num_pages = num_pages;
 	io_ctl->fs_info = btrfs_sb(inode->i_sb);
-	io_ctl->check_crcs = check_crcs;
 	io_ctl->inode = inode;

 	return 0;
@@ -479,13 +473,8 @@ static void io_ctl_set_generation(struct btrfs_io_ctl *io_ctl, u64 generation)
 	 * Skip the csum areas.  If we don't check crcs then we just have a
 	 * 64bit chunk at the front of the first page.
 	 */
-	if (io_ctl->check_crcs) {
-		io_ctl->cur += (sizeof(u32) * io_ctl->num_pages);
-		io_ctl->size -= sizeof(u64) + (sizeof(u32) * io_ctl->num_pages);
-	} else {
-		io_ctl->cur += sizeof(u64);
-		io_ctl->size -= sizeof(u64) * 2;
-	}
+	io_ctl->cur += (sizeof(u32) * io_ctl->num_pages);
+	io_ctl->size -= sizeof(u64) + (sizeof(u32) * io_ctl->num_pages);

 	put_unaligned_le64(generation, io_ctl->cur);
 	io_ctl->cur += sizeof(u64);
@@ -499,14 +488,9 @@ static int io_ctl_check_generation(struct btrfs_io_ctl *io_ctl, u64 generation)
 	 * Skip the crc area.  If we don't check crcs then we just have a 64bit
 	 * chunk at the front of the first page.
 	 */
-	if (io_ctl->check_crcs) {
-		io_ctl->cur += sizeof(u32) * io_ctl->num_pages;
-		io_ctl->size -= sizeof(u64) +
-			(sizeof(u32) * io_ctl->num_pages);
-	} else {
-		io_ctl->cur += sizeof(u64);
-		io_ctl->size -= sizeof(u64) * 2;
-	}
+	io_ctl->cur += sizeof(u32) * io_ctl->num_pages;
+	io_ctl->size -= sizeof(u64) +
+		(sizeof(u32) * io_ctl->num_pages);

 	cache_gen = get_unaligned_le64(io_ctl->cur);
 	if (cache_gen != generation) {
@@ -526,11 +510,6 @@ static void io_ctl_set_crc(struct btrfs_io_ctl *io_ctl, int index)
 	u32 crc = ~(u32)0;
 	unsigned offset = 0;

-	if (!io_ctl->check_crcs) {
-		io_ctl_unmap_page(io_ctl);
-		return;
-	}
-
 	if (index == 0)
 		offset = sizeof(u32) * io_ctl->num_pages;

@@ -548,11 +527,6 @@ static int io_ctl_check_crc(struct btrfs_io_ctl *io_ctl, int index)
 	u32 crc = ~(u32)0;
 	unsigned offset = 0;

-	if (!io_ctl->check_crcs) {
-		io_ctl_map_page(io_ctl, 0);
-		return 0;
-	}
-
 	if (index == 0)
 		offset = sizeof(u32) * io_ctl->num_pages;

diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index a65ed1967d5d..33687b0b8e7a 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -76,7 +76,6 @@ struct btrfs_io_ctl {
 	int num_pages;
 	int entries;
 	int bitmaps;
-	unsigned check_crcs:1;
 };

 struct inode *lookup_free_space_inode(struct btrfs_block_group *block_group,
--
2.25.1

