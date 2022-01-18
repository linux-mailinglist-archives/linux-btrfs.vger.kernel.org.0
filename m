Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82283491FB7
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 08:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244571AbiARHTY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jan 2022 02:19:24 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51020 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiARHTY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jan 2022 02:19:24 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 94B30212C3;
        Tue, 18 Jan 2022 07:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642490362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=mwrMm9p0XKm29fkZlYtvb/i6y3gRyXzoJRGx3A3cGZo=;
        b=fIzWN9k1lgiNdVnTrAir1QaSO4VQyM4CrKcZm9O9Adgdm9ShVNL1G7XqNXWfu4jlIe/cqY
        fim0Pgo6tWN+s4P4gaQmsF4qoeVeXwg42hNpjXeye0RkNw1aqnARt0nn+RDJGGL0N/QkfX
        Q2mJCGyLGEjzcRz+pQ/A2agYbgpTSpY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B87B51332F;
        Tue, 18 Jan 2022 07:19:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KS9hIflp5mF5RQAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 18 Jan 2022 07:19:21 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anthony Ruhier <aruhier@mailbox.org>
Subject: [PATCH v2] btrfs: defrag: fix the wrong number of defragged sectors
Date:   Tue, 18 Jan 2022 15:19:04 +0800
Message-Id: <20220118071904.29991-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There are users using autodefrag mount option reporting obvious increase
in IO:

> If I compare the write average (in total, I don't have it per process)
> when taking idle periods on the same machine:
>     Linux 5.16:
>         without autodefrag: ~ 10KiB/s
>         with autodefrag: between 1 and 2MiB/s.
>
>     Linux 5.15:
>         with autodefrag:~ 10KiB/s (around the same as without
> autodefrag on 5.16)

[CAUSE]
When autodefrag mount option is enabled, btrfs_defrag_file() will be
called with @max_sectors = BTRFS_DEFRAG_BATCH (1024) to limit how many
sectors we can defrag in one try.

And then use the number of sectors defragged to determine if we need to
re-defrag.

But commit b18c3ab2343d ("btrfs: defrag: introduce helper to defrag one
cluster") uses wrong unit to increase @sectors_defragged, which should
be in unit of sector, not byte.

This means, if we have defragged any sector, then @sectors_defragged
will be >= sectorsize (normally 4096), which is larger than
BTRFS_DEFRAG_BATCH.

This makes the @max_sectors check in defrag_one_cluster() to underflow,
rendering the whole @max_sectors check useless.

Thus causing way more IO for autodefrag mount options, as now there is
no limit on how many sectors can really be defragged.

[FIX]
Fix the problems by:

- Use sector as unit when increaseing @sectors_defragged

- Include @sectors_defragged > @max_sectors case to break the loop

- Add extra comment on the return value of btrfs_defrag_file()

Reported-by: Anthony Ruhier <aruhier@mailbox.org>
Fixes: b18c3ab2343d ("btrfs: defrag: introduce helper to defrag one cluster")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Update the commit message to include the root cause of extra IO

- Keep @sectors_defragged update where it is
  Since the over-reported @sectors_defragged is not the real reason,
  keep the patch smaller.
---
 fs/btrfs/ioctl.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6ad2bc2e5af3..2a77273d91fe 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1442,8 +1442,8 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 	list_for_each_entry(entry, &target_list, list) {
 		u32 range_len = entry->len;
 
-		/* Reached the limit */
-		if (max_sectors && max_sectors == *sectors_defragged)
+		/* Reached or beyond the limit */
+		if (max_sectors && *sectors_defragged >= max_sectors)
 			break;
 
 		if (max_sectors)
@@ -1465,7 +1465,8 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 				       extent_thresh, newer_than, do_compress);
 		if (ret < 0)
 			break;
-		*sectors_defragged += range_len;
+		*sectors_defragged += range_len >>
+				      inode->root->fs_info->sectorsize_bits;
 	}
 out:
 	list_for_each_entry_safe(entry, tmp, &target_list, list) {
@@ -1484,6 +1485,9 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
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

