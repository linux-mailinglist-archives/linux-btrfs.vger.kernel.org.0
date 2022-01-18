Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5786749253C
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 12:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbiARLyN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jan 2022 06:54:13 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:50870 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiARLyM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jan 2022 06:54:12 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0121C1F3A1;
        Tue, 18 Jan 2022 11:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642506852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=neQhBVi3SYxmcFifRAFV6iImGRANo2gKLKo03CT72Tg=;
        b=k2IZGOmM6XC1AFKONdYOZGOVDIsh9mRG5ZCor3rcWjIcJJbqc6G7xEnqaLr48+jwwEgmeM
        x4QStSfxfcgkKXi+gzQswE1Wueb01KBCb0s5R75UVJrNFSi2e8+y4NmSwsCupsY09UBSoC
        T7/syjtob1Xc/Ev49XJMMVGGXSuqQdY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9787213B26;
        Tue, 18 Jan 2022 11:54:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GBhuF2Kq5mGZXgAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 18 Jan 2022 11:54:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: defrag: properly update range->start for autodefrag
Date:   Tue, 18 Jan 2022 19:53:52 +0800
Message-Id: <20220118115352.52126-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
After commit 7b508037d4ca ("btrfs: defrag: use defrag_one_cluster() to
implement btrfs_defrag_file()") autodefrag no longer properly re-defrag
the file from previously finished location.

[CAUSE]
The recent refactor on defrag only focuses on defrag ioctl subpage
support, doesn't take auto defrag into consideration.

There are two problems involved which prevents autodefrag to restart its
scan:

- No range.start update
  Previously when one defrag target is found, range->start will be
  updated to indicate where next search should start from.

  But now btrfs_defrag_file() doesn't update it anymore, making all
  autodefrag to rescan from file offset 0.

  This would also make autodefrag to mark the same range dirty again and
  again, causing extra IO.

- No proper quick exit for defrag_one_cluster()
  Currently if we reached or exceed @max_sectors limit, we just exit
  defrag_one_cluster(), and let next defrag_one_cluster() call to do a
  quick exit.
  This makes @cur increase, thus no way to properly know which range is
  defragged and which range is skipped.

[FIX]
The fix involves two modifications:

- Update range->start to next cluster start
  This is a little different from the old behavior.
  Previously range->start is updated to the next defrag target.

  But in the end, the behavior should still be pretty much the same,
  as now we skip to next defrag target inside btrfs_defrag_file().

  Thus if auto-defrag determines to re-scan, then we still do the skip,
  just at a different timing.

- Make defrag_one_cluster() to return >0 to indicate a quick exit
  So that btrfs_defrag_file() can also do a quick exit, without
  increasing @cur to the range end, and re-use @cur to update
  @range->start.

- Add comment for btrfs_defrag_file() to mention the range->start update
  Currently only autodefrag utilize this behavior, as defrag ioctl won't
  set @max_to_defrag parameter, thus unless interrupted it will always
  try to defrag the whole range.

Reported-by: Filipe Manana <fdmanana@suse.com>
Fixes: 7b508037d4ca ("btrfs: defrag: use defrag_one_cluster() to implement btrfs_defrag_file()")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 2a77273d91fe..91ba2efe9792 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1443,8 +1443,10 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 		u32 range_len = entry->len;
 
 		/* Reached or beyond the limit */
-		if (max_sectors && *sectors_defragged >= max_sectors)
+		if (max_sectors && *sectors_defragged >= max_sectors) {
+			ret = 1;
 			break;
+		}
 
 		if (max_sectors)
 			range_len = min_t(u32, range_len,
@@ -1487,7 +1489,10 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
  *		   will be defragged.
  *
  * Return <0 for error.
- * Return >=0 for the number of sectors defragged.
+ * Return >=0 for the number of sectors defragged, and range->start will be updated
+ * to indicate the file offset where next defrag should be started at.
+ * (Mostly for autodefrag, which sets @max_to_defrag thus we may exit early without
+ *  defragging all the range).
  */
 int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		      struct btrfs_ioctl_defrag_range_args *range,
@@ -1575,10 +1580,19 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		if (ret < 0)
 			break;
 		cur = cluster_end + 1;
+		if (ret > 0) {
+			ret = 0;
+			break;
+		}
 	}
 
 	if (ra_allocated)
 		kfree(ra);
+	/*
+	 * Update range.start for autodefrag, this will indicate where to start
+	 * in next run.
+	 */
+	range->start = cur;
 	if (sectors_defragged) {
 		/*
 		 * We have defragged some sectors, for compression case they
-- 
2.34.1

