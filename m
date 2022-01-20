Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F802495373
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jan 2022 18:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiATRlY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jan 2022 12:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiATRlW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jan 2022 12:41:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93480C06161C
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 09:41:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D36BB81E07
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 17:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC4DC340E0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 17:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642700480;
        bh=w53GwXiGsVPxfplsJ0tgRceHEEdBmosS4nqYjMdGKoA=;
        h=From:To:Subject:Date:From;
        b=PMCDz08E6dKG/h+4BfjXQ00rqRKMzdL86tHpHeCgB74/d0R2SXZ/uCB3TCiVFrfSG
         b0cMoROed5wnSwIVt9u/+yaqdeaFMY6/fjYRYWvkuHcatyVwi7w75EhlWuKSaPbFY3
         Up4f6jqyO4otPXL9JCgKXttA1X/pJmRY+OADF8zjyssI3TZ+59fqG3ioYTzbYUgVbO
         opQqdQr5SqpuSgENz/AoZJFjLK2T/JZHwJTAwU+ssKvJqM9EHNaAseLS4Yhe+bH8C+
         PxL5n03fcU3CwWwX5hK2DYKVefZzxPzhQJCdBRoHT3PeUGwCjLN+IocF4NnXRJmHZM
         tbnGh/64Mqd8g==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: update writeback index when starting defrag
Date:   Thu, 20 Jan 2022 17:41:17 +0000
Message-Id: <20aad8ccf0fbdecddd49216f25fa772754f77978.1642700395.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When starting a defrag, we should update the writeback index of the
inode's mapping in case it currently has a value beyond the start of the
range we are defragging. This can help performance and often result in
getting less extents after writeback - for e.g., if the current value
of the writeback index sits somewhere in the middle of a range that
gets dirty by the defrag, then after writeback we can get two smaller
extents instead of a single, larger extent.

We used to have this before the refactoring in 5.16, but it was removed
without any reason to do so. Orginally it was added in kernel 3.1, by
commit 2a0f7f5769992b ("Btrfs: fix recursive auto-defrag"), in order to
fix a loop with autodefrag resulting in dirtying and writing pages over
and over, but some testing on current code did not show that happening,
at least with the test described in that commit.

So add back the behaviour, as at the very least it is a nice to have
optimization.

Fixes: 7b508037d4cac3 ("btrfs: defrag: use defrag_one_cluster() to implement btrfs_defrag_file()")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index bfe5ed65e92b..95d0e210f063 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1535,6 +1535,7 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 	int compress_type = BTRFS_COMPRESS_ZLIB;
 	int ret = 0;
 	u32 extent_thresh = range->extent_thresh;
+	pgoff_t start_index;
 
 	if (isize == 0)
 		return 0;
@@ -1576,6 +1577,14 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 			file_ra_state_init(ra, inode->i_mapping);
 	}
 
+	/*
+	 * Make writeback start from the beginning of the range, so that the
+	 * defrag range can be written sequentially.
+	 */
+	start_index = cur >> PAGE_SHIFT;
+	if (start_index < inode->i_mapping->writeback_index)
+		inode->i_mapping->writeback_index = start_index;
+
 	while (cur < last_byte) {
 		const unsigned long prev_sectors_defragged = sectors_defragged;
 		u64 cluster_end;
-- 
2.33.0

