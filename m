Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED9A2172B4
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgGGPnL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGPnK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 11:43:10 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6F3C061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:43:10 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l6so38544539qkc.6
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 08:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VnXtZZSzIs9CL8rkYhMWWfG8VP/VpNFi+WpvwqR/TWE=;
        b=FWFpRi9auHgbOpdg4/8gu3ammiG5fR7Inj3VOXtdZTnjPf7DVY2/p7+fMRXDvSGcOT
         TvsuZjuc3w5bik31oDSJkXxGvIWdkdNZDOUl8gt5CH6vwtgg1/GxuxxpTJVLiJwYqPi+
         d6DhlmsUjLYnuL2KM2cktxK34L5MVmiLxmXAyliAmfWLXeF9e3HP78klDv41mItyIM9L
         dqPnobMneQ0lpwkYMQtB4jdGrwTrWulzdLVDbYIXPQivft4vSiesXINkDjIfif3kM+H2
         i+c4NCJ3rK+o7f8RKT7mq+6rQq9Lv3nzDWe9yo0QPQYMR57wN3UwRdyurCcYGxfFnrJ2
         1xjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VnXtZZSzIs9CL8rkYhMWWfG8VP/VpNFi+WpvwqR/TWE=;
        b=WwKR+eJN8dphBhz1JpmlCQ90mepDFoQSV4jtDJwOMyufSKOKmEyEfvEi9ZsVGmuAVC
         JYKBgvTnp5bPUlC3YBxAB8gm/n00TKmx3mW2Z9Vx3YK+ZUazXQClCjuxdE0+rDWtMSKK
         hJcXCpqzAEazN3otCNyLfhS/E20NkPUqBGL0mrUd/3zGPxgmhaC3E9vHfIWWfnnxEf8/
         Y8P3ReRvSUJv4+tauZiqPKrlGwf3CcxRBjGeFc/FovCVTEI9AMuCzb2kyzyPaztJzdnO
         GbN8Qp1cl8+ev4S6VBbUKSx1CjQ/wRGmg6BKoddbYMOTE0PEqjVAP3QpFZx8K75hmPUF
         7EDg==
X-Gm-Message-State: AOAM530NGpMkHmPt9qXLMNC6+yGELT1iqpp8Cnl9gZRSDXWT/UB6o4JZ
        4bz2uyVyIW35E3NOWu+AdAIXwSAd0lH/FA==
X-Google-Smtp-Source: ABdhPJyn31aDJwMXuyum5lK/WF2jjfSxziDQXmslpa/iZU0kDi9fgZ1pdSYx0LmmOs+qq/AdAXwEtA==
X-Received: by 2002:a37:689:: with SMTP id 131mr42578968qkg.468.1594136589201;
        Tue, 07 Jul 2020 08:43:09 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r6sm16092555qtt.81.2020.07.07.08.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:43:08 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 10/23] btrfs: use btrfs_start_delalloc_roots in shrink_delalloc
Date:   Tue,  7 Jul 2020 11:42:33 -0400
Message-Id: <20200707154246.52844-11-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200707154246.52844-1-josef@toxicpanda.com>
References: <20200707154246.52844-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The original iteration of flushing had us flushing delalloc and then
checking to see if we could make our reservation, thus we were very
careful about how many pages we would flush at once.

But now that everything is async and we satisfy tickets as the space
becomes available we don't have to keep track of any of this, simply try
and flush the number of dirty inodes we may have in order to reclaim
space to make our reservation.  This cleans up our delalloc flushing
significantly.

The async_pages stuff is dropped because btrfs_start_delalloc_roots()
handles the case that we generate async extents for us, so we no longer
require this extra logic.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 55 +------------------------------------------
 1 file changed, 1 insertion(+), 54 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 3f0e6fa31937..1d3af37b0ad0 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -476,28 +476,6 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 	up_read(&info->groups_sem);
 }
 
-static void btrfs_writeback_inodes_sb_nr(struct btrfs_fs_info *fs_info,
-					 unsigned long nr_pages, u64 nr_items)
-{
-	struct super_block *sb = fs_info->sb;
-
-	if (down_read_trylock(&sb->s_umount)) {
-		writeback_inodes_sb_nr(sb, nr_pages, WB_REASON_FS_FREE_SPACE);
-		up_read(&sb->s_umount);
-	} else {
-		/*
-		 * We needn't worry the filesystem going from r/w to r/o though
-		 * we don't acquire ->s_umount mutex, because the filesystem
-		 * should guarantee the delalloc inodes list be empty after
-		 * the filesystem is readonly(all dirty pages are written to
-		 * the disk).
-		 */
-		btrfs_start_delalloc_roots(fs_info, nr_items);
-		if (!current->journal_info)
-			btrfs_wait_ordered_roots(fs_info, nr_items, 0, (u64)-1);
-	}
-}
-
 static inline u64 calc_reclaim_items_nr(struct btrfs_fs_info *fs_info,
 					u64 to_reclaim)
 {
@@ -523,10 +501,8 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 	struct btrfs_trans_handle *trans;
 	u64 delalloc_bytes;
 	u64 dio_bytes;
-	u64 async_pages;
 	u64 items;
 	long time_left;
-	unsigned long nr_pages;
 	int loops;
 
 	/* Calc the number of the pages we need flush for space reservation */
@@ -567,37 +543,8 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 
 	loops = 0;
 	while ((delalloc_bytes || dio_bytes) && loops < 3) {
-		nr_pages = min(delalloc_bytes, to_reclaim) >> PAGE_SHIFT;
-
-		/*
-		 * Triggers inode writeback for up to nr_pages. This will invoke
-		 * ->writepages callback and trigger delalloc filling
-		 *  (btrfs_run_delalloc_range()).
-		 */
-		btrfs_writeback_inodes_sb_nr(fs_info, nr_pages, items);
-
-		/*
-		 * We need to wait for the compressed pages to start before
-		 * we continue.
-		 */
-		async_pages = atomic_read(&fs_info->async_delalloc_pages);
-		if (!async_pages)
-			goto skip_async;
-
-		/*
-		 * Calculate how many compressed pages we want to be written
-		 * before we continue. I.e if there are more async pages than we
-		 * require wait_event will wait until nr_pages are written.
-		 */
-		if (async_pages <= nr_pages)
-			async_pages = 0;
-		else
-			async_pages -= nr_pages;
+		btrfs_start_delalloc_roots(fs_info, items);
 
-		wait_event(fs_info->async_submit_wait,
-			   atomic_read(&fs_info->async_delalloc_pages) <=
-			   (int)async_pages);
-skip_async:
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets) &&
 		    list_empty(&space_info->priority_tickets)) {
-- 
2.24.1

