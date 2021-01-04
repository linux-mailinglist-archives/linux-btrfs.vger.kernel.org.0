Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4EB2E9BAC
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jan 2021 18:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbhADRE2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jan 2021 12:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbhADRE2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jan 2021 12:04:28 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B90C061795
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jan 2021 09:03:47 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id 2so18920843qtt.10
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Jan 2021 09:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p3fstNFwpviS5MMSNrF6it3JOKHc3O5G6kSCnagCyGE=;
        b=FUAuLUk9FSP5LcmkVbO8WmZfqhXrXhesRQBxqZXLPK7klyRVdOriUfsjBgOzNkWdrh
         MNchdtgoGqYHaTMRk4C1ZORsXgYYeqTC6E9TBePWVvCQYDGkT6NJmvcvYMDrazjnmzN0
         F4TCOdKvfupPmXiPKRddtks4Hd1gYRq+DLlsevAIabn4/23vQQ5Ndu2AR6VPi/TQoA8B
         Kd8A5xION4t28yo7yI62uWiOL7XfXKf+yS+l0QJMlwD1A4u0s/VyVJp7bOxIao6OzPFL
         +uVZPZZ06ND2EV2VP1CWijUq4REH6A6IyhiJ/QaUe/nVaSyOa9fw7QOXtNtU9mzaX8G7
         NsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p3fstNFwpviS5MMSNrF6it3JOKHc3O5G6kSCnagCyGE=;
        b=nj6U6mQ6XOLiSJj110Uo5t1qOOKd1m/kp9vIJfoteJ6yCvnsQSGdRFa5xZLaewozol
         TonvVyAFdKt8WXv+oofHY1emFIaVNZEzCMEhZJ6NzkCxhFlurBDPGhDwxasicnY8tqMk
         RkYJ/05Bbbd0lTx1IQT8z7XGJYgKY/vejJK9DW/KjTF0dTDsKDDImnkTpJQiVSKHWMsS
         q9CiUl6nblbSPz6l9NYelhpgiGxb/YudEaza7qCqxeexWwSbyvLldwJ4q0xc8mC2RZjY
         Zbz2mbY9Jjwjb30hgmUG4/7GiFxOjf0O1MXoYntSzG3mK+7+DwEk2PPeoA+r7AmEY1qK
         i4GA==
X-Gm-Message-State: AOAM530Ey9Bw5ilEkKlYr7f57rJrn0q3fsarzy3Wg7013XZL1qqthcSl
        O3WTAAQFlWwCkipD3VOJZuCMB31GmaH/fn6T
X-Google-Smtp-Source: ABdhPJzsy0Q0qeHMC/6f8adb9c7LcOheaBaqi4ElBXSjkeujb0jeUhoTNT4/f00GHIpGt/zO9LA2lQ==
X-Received: by 2002:ac8:5c95:: with SMTP id r21mr72469629qta.152.1609779826707;
        Mon, 04 Jan 2021 09:03:46 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z30sm36935235qtc.15.2021.01.04.09.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 09:03:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     stable@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactcode.de>
Subject: [PATCH] btrfs: Use the normal writeback path for flushing delalloc
Date:   Mon,  4 Jan 2021 12:03:45 -0500
Message-Id: <7a1048dfbc8d2f5f3869f072146ec3e499bc0ac2.1609779712.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a revert for 38d715f494f2 ("btrfs: use
btrfs_start_delalloc_roots in shrink_delalloc").  A user reported a
problem where performance was significantly worse with this patch
applied.  The problem needs to be fixed with proper pre-flushing, and
changes to how we deal with the work queues for the inodes.  However
that work is much more complicated than is acceptable for stable, and
simply reverting this patch fixes the problem.  The original patch was
a cleanup of the code, so it's fine to revert it.  My numbers for the
original reported test, which was untarring a copy of the firefox
sources, are as follows

5.9	0m54.258s
5.10	1m26.212s
Fix	0m35.038s

cc: stable@vger.kernel.org # 5.10
Reported-by: René Rebe <rene@exactcode.de>
Fixes: 38d715f494f2 ("btrfs: use btrfs_start_delalloc_roots in shrink_delalloc")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
Dave, this is ontop of linus's branch, because we've changed the arguments for
btrfs_start_delalloc_roots in misc-next, and this needs to go back to 5.10 ASAP.
I can send a misc-next version if you want to have it there as well while we're
waiting for it to go into linus's tree, just let me know.

 fs/btrfs/space-info.c | 54 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 64099565ab8f..a2b322275b8d 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -465,6 +465,28 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 	up_read(&info->groups_sem);
 }
 
+static void btrfs_writeback_inodes_sb_nr(struct btrfs_fs_info *fs_info,
+					 unsigned long nr_pages, u64 nr_items)
+{
+	struct super_block *sb = fs_info->sb;
+
+	if (down_read_trylock(&sb->s_umount)) {
+		writeback_inodes_sb_nr(sb, nr_pages, WB_REASON_FS_FREE_SPACE);
+		up_read(&sb->s_umount);
+	} else {
+		/*
+		 * We needn't worry the filesystem going from r/w to r/o though
+		 * we don't acquire ->s_umount mutex, because the filesystem
+		 * should guarantee the delalloc inodes list be empty after
+		 * the filesystem is readonly(all dirty pages are written to
+		 * the disk).
+		 */
+		btrfs_start_delalloc_roots(fs_info, nr_items);
+		if (!current->journal_info)
+			btrfs_wait_ordered_roots(fs_info, nr_items, 0, (u64)-1);
+	}
+}
+
 static inline u64 calc_reclaim_items_nr(struct btrfs_fs_info *fs_info,
 					u64 to_reclaim)
 {
@@ -490,8 +512,10 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 	struct btrfs_trans_handle *trans;
 	u64 delalloc_bytes;
 	u64 dio_bytes;
+	u64 async_pages;
 	u64 items;
 	long time_left;
+	unsigned long nr_pages;
 	int loops;
 
 	/* Calc the number of the pages we need flush for space reservation */
@@ -532,8 +556,36 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 
 	loops = 0;
 	while ((delalloc_bytes || dio_bytes) && loops < 3) {
-		btrfs_start_delalloc_roots(fs_info, items);
+		nr_pages = min(delalloc_bytes, to_reclaim) >> PAGE_SHIFT;
+
+		/*
+		 * Triggers inode writeback for up to nr_pages. This will invoke
+		 * ->writepages callback and trigger delalloc filling
+		 *  (btrfs_run_delalloc_range()).
+		 */
+		btrfs_writeback_inodes_sb_nr(fs_info, nr_pages, items);
+		/*
+		 * We need to wait for the compressed pages to start before
+		 * we continue.
+		 */
+		async_pages = atomic_read(&fs_info->async_delalloc_pages);
+		if (!async_pages)
+			goto skip_async;
+
+		/*
+		 * Calculate how many compressed pages we want to be written
+		 * before we continue. I.e if there are more async pages than we
+		 * require wait_event will wait until nr_pages are written.
+		 */
+		if (async_pages <= nr_pages)
+			async_pages = 0;
+		else
+			async_pages -= nr_pages;
 
+		wait_event(fs_info->async_submit_wait,
+			   atomic_read(&fs_info->async_delalloc_pages) <=
+			   (int)async_pages);
+skip_async:
 		loops++;
 		if (wait_ordered && !trans) {
 			btrfs_wait_ordered_roots(fs_info, items, 0, (u64)-1);
-- 
2.26.2

