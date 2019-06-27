Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D174C57BC9
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2019 08:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfF0GPa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jun 2019 02:15:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:53582 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725770AbfF0GPa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jun 2019 02:15:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 816E2AEB8;
        Thu, 27 Jun 2019 06:15:29 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     James Harvey <jamespharvey20@gmail.com>
Subject: [PATCH RESEND] btrfs: inode: Don't compress if NODATASUM or NODATACOW set
Date:   Thu, 27 Jun 2019 14:15:17 +0800
Message-Id: <20190627061517.2112-1-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As btrfs(5) specified:

	Note
	If nodatacow or nodatasum are enabled, compression is disabled.

If NODATASUM or NODATACOW set, we should not compress the extent.

Normally NODATACOW is detected properly in run_delalloc_range() so
compression won't happen for NODATACOW.

However for NODATASUM we don't have any check, and it can cause
compressed extent without csum pretty easily, just by:

  mkfs.btrfs -f $dev
  mount $dev $mnt -o nodatasum
  touch $mnt/foobar
  mount -o remount,datasum,compress $mnt
  xfs_io -f -c "pwrite 0 128K" $mnt/foobar

And in fact, we have bug report about corrupted compressed extent
without proper data checksum so even RAID1 can't recover the corruption.
(https://bugzilla.kernel.org/show_bug.cgi?id=199707)

Running compression without proper checksum could cause more damage when
corruption happens, so there is no need to allow compression for
NODATACSUM.

Reported-by: James Harvey <jamespharvey20@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a2aabdb85226..4e0c7f18fa3a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -398,6 +398,14 @@ static inline int inode_need_compress(struct inode *inode, u64 start, u64 end)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 
+	/*
+	 * Btrfs doesn't support compression without csum or CoW.
+	 * This should have the highest priority.
+	 */
+	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW ||
+	    BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
+		return 0;
+
 	/* force compress */
 	if (btrfs_test_opt(fs_info, FORCE_COMPRESS))
 		return 1;
-- 
2.22.0

