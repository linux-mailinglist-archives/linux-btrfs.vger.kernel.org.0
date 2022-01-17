Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA3A490C7F
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 17:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237589AbiAQQ2e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 11:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240884AbiAQQ2e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 11:28:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24914C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 08:28:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A825C61171
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 16:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D33C36AE3
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 16:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642436913;
        bh=D9hFta5N4jvu/xidp2pS4s0ppZ1nB8e2zYozK6CcPuk=;
        h=From:To:Subject:Date:From;
        b=b/umuYvKSeDkkbY4Rcb+PxsX+TAB1VZ7zbgmERt1whpqbotkFbPATOpyq/GOTrawn
         JZVXMQuJenKtIdYIEHYHkD79wqY1eI47y6gUrPJnWOHrEsHG8aRhZb7Vs1AeK7rFSS
         QkesgXKMX5QUrQAipNVQ1bP/M8d2xdZip6ZfDKVJ7vMnf9Ju4DcvaamMX6Sxf/NnRk
         6UYhmRLhIQOzFcPn09X4+jTXEIB7A89T2YcHM4o0BMidGUZHoSQWk9uNSu6v9ZMHIP
         prkdP1c8MEjM5mWU99bAtcJNgbzTbgsnZuqPPze41eGrtQnyFzQ0MBFld2zxjrIsoZ
         0cuXfsko1OjDA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix too long loop when defragging a 1 byte file
Date:   Mon, 17 Jan 2022 16:28:29 +0000
Message-Id: <bcbfce0ff7e21bbfed2484b1457e560edf78020d.1642436805.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When attempting to defrag a file with a single byte, we can end up in a
too long loop, which is nearly infinite because at btrfs_defrag_file()
we end up with the variable last_byte assigned with a value of
18446744073709551615 (which is (u64)-1). The problem comes from the fact
we end up doing:

    last_byte = round_up(last_byte, fs_info->sectorsize) - 1;

So if last_byte was assigned 0, which is i_size - 1, we underflow and
end up with the value 18446744073709551615.

This is trivial to reproduce and the following script triggers it:

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/sdj
  MNT=/mnt/sdj

  mkfs.btrfs -f $DEV
  mount $DEV $MNT

  echo -n "X" > $MNT/foobar

  btrfs filesystem defragment $MNT/foobar

  umount $MNT

So fix this by not decrementing last_byte by 1 before doing the sector
size round up. Also, to make it easier to follow, make the round up right
after computing last_byte.

Fixes: 7b508037d4cac3 ("btrfs: defrag: use defrag_one_cluster() to implement btrfs_defrag_file()")
Reported-by: Anthony Ruhier <aruhier@mailbox.org>
Link: https://lore.kernel.org/linux-btrfs/0a269612-e43f-da22-c5bc-b34b1b56ebe8@mailbox.org/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a5bd6926f7ff..6ad2bc2e5af3 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1518,12 +1518,16 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 
 	if (range->start + range->len > range->start) {
 		/* Got a specific range */
-		last_byte = min(isize, range->start + range->len) - 1;
+		last_byte = min(isize, range->start + range->len);
 	} else {
 		/* Defrag until file end */
-		last_byte = isize - 1;
+		last_byte = isize;
 	}
 
+	/* Align the range */
+	cur = round_down(range->start, fs_info->sectorsize);
+	last_byte = round_up(last_byte, fs_info->sectorsize) - 1;
+
 	/*
 	 * If we were not given a ra, allocate a readahead context. As
 	 * readahead is just an optimization, defrag will work without it so
@@ -1536,10 +1540,6 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 			file_ra_state_init(ra, inode->i_mapping);
 	}
 
-	/* Align the range */
-	cur = round_down(range->start, fs_info->sectorsize);
-	last_byte = round_up(last_byte, fs_info->sectorsize) - 1;
-
 	while (cur < last_byte) {
 		u64 cluster_end;
 
-- 
2.33.0

