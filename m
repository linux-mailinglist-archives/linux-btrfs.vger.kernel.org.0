Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C1D4913F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 03:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244286AbiARCQE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 21:16:04 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35602 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiARCQD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 21:16:03 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BD00F21136
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 02:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642472162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=mG7UgkvvCjCG2lUhmPOaBWbXMBHGuHWF+rHsQMmud2w=;
        b=LLf3Ccm0skQtmRzeUlGwJwC3KMZ+bfxHVfIev/0FHtQDpuA6v1fT73/3ZR7xQ+kpnn+4sw
        GB+4ur/e6aQ0P4Qol6RCC6FP682iJdQ7zRD8pYFNBm7F30rNhjlTLxzhBjRYPsIMG3y287
        q4UxsFdw4Dk+mKVk+hfsoD03KCZ1ngQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CE6A13342
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 02:16:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pdQLNuEi5mHEVQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 02:16:01 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: defrag: fix the wrong defragged number of sectors
Date:   Tue, 18 Jan 2022 10:15:44 +0800
Message-Id: <20220118021544.18543-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Since the recent rework on btrfs defrag to support subpage, the number
of defragged sectors is no longer reported in sector size, but in byte.

Normally this is fine and defrag ioctl won't return the number of
defragged sectors anyway.

But it will change the behavior of auto-defrag, which has re-defrag
behavior based on the defragged sectors.

Furthermore, the refactor changed how we report the number of defragged
sectors.
The refactor no longer reports the real defragged sectors, but just the
initial scan, which can report more bytes than the defragged sectors.

[FIX]
Fix the problems by:

- Pass @sectors_defragged to defrag_one_range() and update it in the
  real loop where we defrag the file

- Properly calculate the @sectors_defragged using number of sectors, not
  number of bytes.

Fixes: 7b508037d4ca ("btrfs: defrag: use defrag_one_cluster() to implement btrfs_defrag_file()")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6ad2bc2e5af3..d1f036aba36a 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1343,7 +1343,8 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 }
 
 static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
-			    u32 extent_thresh, u64 newer_than, bool do_compress)
+			    u32 extent_thresh, u64 newer_than, bool do_compress,
+			    unsigned long *sectors_defragged)
 {
 	struct extent_state *cached_state = NULL;
 	struct defrag_target_range *entry;
@@ -1398,6 +1399,8 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 					       &cached_state);
 		if (ret < 0)
 			break;
+		*sectors_defragged += entry->len >>
+				      (inode->root->fs_info->sectorsize_bits);
 	}
 
 	list_for_each_entry_safe(entry, tmp, &target_list, list) {
@@ -1462,10 +1465,10 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 		 * accounting.
 		 */
 		ret = defrag_one_range(inode, entry->start, range_len,
-				       extent_thresh, newer_than, do_compress);
+				       extent_thresh, newer_than, do_compress,
+				       sectors_defragged);
 		if (ret < 0)
 			break;
-		*sectors_defragged += range_len;
 	}
 out:
 	list_for_each_entry_safe(entry, tmp, &target_list, list) {
@@ -1484,6 +1487,9 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
  * @newer_than:	   minimum transid to defrag
  * @max_to_defrag: max number of sectors to be defragged, if 0, the whole inode
  *		   will be defragged.
+ *
+ * Return <0 for error.
+ * Return >=0 for the number of sectors defragged.
  */
 int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		      struct btrfs_ioctl_defrag_range_args *range,
-- 
2.34.1

