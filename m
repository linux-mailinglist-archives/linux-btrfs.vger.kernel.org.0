Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998743B73A6
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jun 2021 15:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbhF2OCC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Jun 2021 10:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbhF2OB7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Jun 2021 10:01:59 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2BCC061766
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Jun 2021 06:59:32 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id w13so406165qtc.0
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Jun 2021 06:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aZs7tDGE5F1qLj1oIyCH3Juwy10djVLpnl4d0mbqTOU=;
        b=sYOM6GcIRtRtoRqfCEwniRDKBmn0n9Ipb8TayyFPHtzL6RUMfJchrZfjbSmBQfpeic
         8GAfkWLjrw5wxYotsVBl5i0DlQq+fXoIzpNu1yMpPfiEKsLrtKICSt8oAuq7bph4uz5W
         dmBM/L5ModVgJZjDEEyfj7JxiWLg4fFT56fm4/S7xGTWWOO+5knmyaFfr7Unq7OtZzZE
         /iZ7OLb5iWyO2O7flnKlSGY3LjRlAdiiXP0k7O5xPnPfifJlEEit/NjsBf9fl9KoU6d7
         mf4MhCClRG36MtM4oUjJIuU38wZ3zYC3Y+T+eZ9PtN/162Y8g2ahRIFBeqb6iwwBC0YY
         5w+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aZs7tDGE5F1qLj1oIyCH3Juwy10djVLpnl4d0mbqTOU=;
        b=M4ykwU+LeWnDEpv+YClIayxUB6Lak66SY+FgwsCJ8x/DLoPiOQ7hZdQilZyTV5Eyb2
         IbFsiyLetPjjHY8fQ50Jlzm410iOiSuPuZ3F9cQFS8pYqeFgB5OZ53XVXd4x1Wyqw9sp
         vEYjdJ+H+uvqIetBCeu/PTLgPZ2XcuL/nyZIec1YKqtkZKVDekFJxiIKTTFefhx6D3Cg
         EHvRwjZT7KnMzc51WoBVpnIHA4AK14vcBXJ8bDox8chLEgK2rQyWCBSKLBZldH6RF9kK
         UbCvVMb0BR4CtiUa4LB7EAfZXVvjykD8t42wr5NLmWxdl+9l/pH3z61hJ/CM78ktLF4Q
         H4hw==
X-Gm-Message-State: AOAM531NRb4JmYA8IhD2+4bdoEMd3jMDaMdNsspQ/N4TXU6zlZUBwtYj
        dxQE5u5/2uP/grcWRZjI2ZlFROx1eH5REw==
X-Google-Smtp-Source: ABdhPJxcwKD1lAamg2/QGQENbjhHQr/NHXSrfidJtydKyX2PZp+yRApsIKpmieQVKsvwPRR17v3dUA==
X-Received: by 2002:a05:622a:18a2:: with SMTP id v34mr14891629qtc.255.1624975171014;
        Tue, 29 Jun 2021 06:59:31 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p14sm11846857qkh.128.2021.06.29.06.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 06:59:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/8] btrfs: wait on async extents when flushing delalloc
Date:   Tue, 29 Jun 2021 09:59:19 -0400
Message-Id: <0ee87e54d0f14f0628d146e09fef34db2ce73e03.1624974951.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1624974951.git.josef@toxicpanda.com>
References: <cover.1624974951.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've been debugging an early ENOSPC problem in production and finally
root caused it to this problem.  When we switched to the per-inode in
38d715f494f2 ("btrfs: use btrfs_start_delalloc_roots in
shrink_delalloc") I pulled out the async extent handling, because we
were doing the correct thing by calling filemap_flush() if we had async
extents set.  This would properly wait on any async extents by locking
the page in the second flush, thus making sure our ordered extents were
properly set up.

However when I switched us back to page based flushing, I used
sync_inode(), which allows us to pass in our own wbc.  The problem here
is that sync_inode() is smarter than the filemap_* helpers, it tries to
avoid calling writepages at all.  This means that our second call could
skip calling do_writepages altogether, and thus not wait on the pagelock
for the async helpers.  This means we could come back before any ordered
extents were created and then simply continue on in our flushing
mechanisms and ENOSPC out when we have plenty of space to use.

Fix this by putting back the async pages logic in shrink_delalloc.  This
allows us to bulk write out everything that we need to, and then we can
wait in one place for the async helpers to catch up, and then wait on
any ordered extents that are created.

Fixes: e076ab2a2ca7 ("btrfs: shrink delalloc pages instead of full inodes")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c      |  4 ----
 fs/btrfs/space-info.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e6eb20987351..b1f02e3fea5d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9714,10 +9714,6 @@ static int start_delalloc_inodes(struct btrfs_root *root,
 					 &work->work);
 		} else {
 			ret = sync_inode(inode, wbc);
-			if (!ret &&
-			    test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
-				     &BTRFS_I(inode)->runtime_flags))
-				ret = sync_inode(inode, wbc);
 			btrfs_add_delayed_iput(inode);
 			if (ret || wbc->nr_to_write <= 0)
 				goto out;
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 0c539a94c6d9..f140a89a3cdd 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -534,9 +534,49 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 	while ((delalloc_bytes || ordered_bytes) && loops < 3) {
 		u64 temp = min(delalloc_bytes, to_reclaim) >> PAGE_SHIFT;
 		long nr_pages = min_t(u64, temp, LONG_MAX);
+		int async_pages;
 
 		btrfs_start_delalloc_roots(fs_info, nr_pages, true);
 
+		/*
+		 * We need to make sure any outstanding async pages are now
+		 * processed before we continue.  This is because things like
+		 * sync_inode() try to be smart and skip writing if the inode is
+		 * marked clean.  We don't use filemap_fwrite for flushing
+		 * because we want to control how many pages we write out at a
+		 * time, thus this is the only safe way to make sure we've
+		 * waited for outstanding compressed workers to have started
+		 * their jobs and thus have ordered extents set up properly.
+		 *
+		 * This exists because we do not want to wait for each
+		 * individual inode to finish its async work, we simply want to
+		 * start the IO on everybody, and then come back here and wait
+		 * for all of the async work to catch up.  Once we're done with
+		 * that we know we'll have ordered extents for everything and we
+		 * can decide if we wait for that or not.
+		 *
+		 * If we choose to replace this in the future, make absolutely
+		 * sure that the proper waiting is being done in the async case,
+		 * as there have been bugs in that area before.
+		 */
+		async_pages = atomic_read(&fs_info->async_delalloc_pages);
+		if (!async_pages)
+			goto skip_async;
+
+		/*
+		 * We don't want to wait forever, if we wrote less pages in this
+		 * loop than we have outstanding, only wait for that number of
+		 * pages, otherwise we can wait for all async pages to finish
+		 * before continuing.
+		 */
+		if (async_pages > nr_pages)
+			async_pages -= nr_pages;
+		else
+			async_pages = 0;
+		wait_event(fs_info->async_submit_wait,
+			   atomic_read(&fs_info->async_delalloc_pages) <=
+			   async_pages);
+skip_async:
 		loops++;
 		if (wait_ordered && !trans) {
 			btrfs_wait_ordered_roots(fs_info, items, 0, (u64)-1);
-- 
2.26.3

