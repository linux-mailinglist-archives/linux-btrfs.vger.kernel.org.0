Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0EA2E20FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Dec 2020 20:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgLWTlo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Dec 2020 14:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbgLWTlo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Dec 2020 14:41:44 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E355C06179C
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Dec 2020 11:41:04 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 22so327202qkf.9
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Dec 2020 11:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=F3x9DORJXAffrCC9iVVE/Ywf1t3nSqNFcq2Lp9kRz7c=;
        b=otQ+XxFMwKto9TpmT8h6d+ALLtHQY+nU6JjEL0qiC//3acZk6IzwmhdYMg8NdOdzea
         dSgv7TjAJQEf+z2ViUeoEW+7B0GC2FTY47BPd5l0WO8PlpjFwNc38Z5FlkBPOAzeQcNJ
         5SYfqS0LAObqddvx3U+hAgwmD0y1eBOI72SqsgskEZbp9m+g+dGULCBsXvywn1e5+PUD
         1ZnfegYY7GztkuM6FldAcI5+kfUcOYQtAt9dyC+aHXm5s+EnMKNr7THvoFH4tODWbWHB
         qUaJJ7px7WXrpzHOQQwo0TIB35B+x6PNak+IQ7USozWmjmLTTuYE8Ly37uKpNubE0JQA
         TH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F3x9DORJXAffrCC9iVVE/Ywf1t3nSqNFcq2Lp9kRz7c=;
        b=FNz/ChjsdTGR2c7RSU0CqHu/oD1sx7Uc4l2pIjWYXto//Qq1n0O+seFAiS7LQjqCsv
         UGh5Z9a8iZ+aYgMHhcU7C/d5i9aF0nFFGhfz8tk7GdFO1/LyswshE90/xuydXQvspxh/
         i/3AePkjP7oblHnGC1zkHT7XgyN8pFEg50tXxIx2HotvUmLo4KtXFW5d0Hs1u2xXDp+Y
         8aUUAEfwdkri3GBFNp557pQNfblPGkE4y2PrEGoApRjBTIuSgU5vTC6Pys/06+fDRcBB
         o3m4rTc1dbBg++CnYPFihdnbLMNkDEhT9wfXN/QEQqWtF0sGSO+FWqKaBi404Y2msPUB
         Zsvg==
X-Gm-Message-State: AOAM531PIk0yxxwCfQlTeJ5z2ZVYvJium5nS4nlF7RCEthfR7bSUze4v
        iPplzNl01lff0x60c1I2kcnOKs+XBuPc0teW
X-Google-Smtp-Source: ABdhPJySpUt9gQwtRs3EJiS59zZPoHL1MgMexgQmOhJk7No6VX/peqB6dCI4IMnip8dqbXHs8FVPNA==
X-Received: by 2002:a37:658d:: with SMTP id z135mr28196065qkb.288.1608752462743;
        Wed, 23 Dec 2020 11:41:02 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l11sm15225986qtn.83.2020.12.23.11.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 11:41:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     rene@exactcode.de, linux-btrfs@vger.kernel.org
Subject: Re: [BUG] 500-2000% performance regression w/ 5.10
Date:   Wed, 23 Dec 2020 14:41:00 -0500
Message-Id: <0382080a1836a12c2d625f8a5bf899828eba204b.1608752315.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <B4BB2DCB-C438-4871-9DDD-D6FB0E6E4F1B@exactcode.de>
References: <B4BB2DCB-C438-4871-9DDD-D6FB0E6E4F1B@exactcode.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Could you give this a try?  I'm not able to reproduce the problem, but I'm
testing inside of a VM.  I'm in the middle of Christmas stuff, but I'll get
ahold of a giant machine at work tomorrow and see if I can reproduce there.
Meanwhile can you give this a shot?  I have a sneaking suspicion why it happens
on your baremetal and not in VM's, and this will be a partial enough of a revert
of the patch you bisected to validate what I'm thinking.  THanks,

Josef


Test this to see if it fixes the problem.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 67e55c5479b8..7b2867e915c6 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -480,6 +480,28 @@ static inline u64 calc_reclaim_items_nr(struct btrfs_fs_info *fs_info,
 
 #define EXTENT_SIZE_PER_ITEM	SZ_256K
 
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
+		btrfs_start_delalloc_roots(fs_info, nr_items, true);
+		if (!current->journal_info)
+			btrfs_wait_ordered_roots(fs_info, nr_items, 0, (u64)-1);
+       }
+}
+
 /*
  * shrink metadata reservation for delalloc
  */
@@ -532,7 +554,8 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 
 	loops = 0;
 	while ((delalloc_bytes || dio_bytes) && loops < 3) {
-		btrfs_start_delalloc_roots(fs_info, items, true);
+		unsigned long nr_pages = min(delalloc_bytes, to_reclaim) >> PAGE_SHIFT;
+		btrfs_writeback_inodes_sb_nr(fs_info, nr_pages, items);
 
 		loops++;
 		if (wait_ordered && !trans) {
-- 
2.26.2

