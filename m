Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBCE3A438E
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 15:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhFKN5q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 09:57:46 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:40540 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbhFKN5L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 09:57:11 -0400
Received: by mail-qt1-f173.google.com with SMTP id t9so2595302qtw.7
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 06:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eo3uPuIkk9g5eY7Rh3Yd/RH0ZC3R9OIWSjFlpNNl+A0=;
        b=QH7H+0U/TZrduBv7bS/WtqmhqtW4M3mbJa2V2UcFl2EQ7bOsYfIDqSyWSnRMkxuets
         j2RJntbj9wwT4oJUkcVoY9jZYBPlikdQCR5zZxKnNNTV62+pieXV4O+Aj7bVPwzarI6Q
         eY61aKiwFvinUeP+vMbwjyAAwdTZmCBMXdJ8sW/670fkHE6NwAnqeMSAm7nIR/eU6C+c
         jx5FgaUOSGAb9wMFf2Ooj0nt4B+FlwsVD5C3ZnerlCP3VX9OQHxn26G3E2u2xx8+axMw
         +wnR/Y9PUJ8W8cvZA6sOfXd4jZu0lk3l9PSwWejyJ8W7NKCt6qjQAWl0RxXkbOBnmOAf
         JSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eo3uPuIkk9g5eY7Rh3Yd/RH0ZC3R9OIWSjFlpNNl+A0=;
        b=FVCr8BDLGnRmu8dGx1CwXqCRTMVIh2BUiHnZDKceQN0gvpHBfyKC23lPZwa2vpnerS
         Ali1vCrz+oyxJP4+9Ug7qAyQ6sGTjItkj8OUuosnqaFNRvtGV2cDwWM95686srBFP7Br
         Dn98APhXQC4bjd3xCLIbQBh3pwPyIa4TI2HqE2B5GM6AI256m/DymuN5kPPKdmVADHwS
         cQkcuRlqaYx++jX0zy9O7jS68Nfkhc8VHOo/MMKpl7SvhPMPturUnly9OFgePeKh1Ej4
         is366bS8DtUYjCl5CMJlkelLtNOCGYcVnN4OkN9kwsDATfz+hJRdJN3N651/wvtf3xKB
         QnNw==
X-Gm-Message-State: AOAM5330jmnd0BbR/tKPojFOs30hrMTB00yUq7/DD3/JOJ8eHsJMIo00
        eQXye9oNzScaALGdotGsLtJ0gcBymXuaCw==
X-Google-Smtp-Source: ABdhPJzC6mdMVKkHKoSKFZXQ2ZXipRe/EkwTjCiKIU22fLcbSCmYS/uGzoiEbGumEBoaX7yXVJN4dg==
X-Received: by 2002:a05:622a:1c1:: with SMTP id t1mr3836184qtw.27.1623419643508;
        Fri, 11 Jun 2021 06:54:03 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u123sm4376478qkh.83.2021.06.11.06.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 06:54:03 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/4] btrfs: wait on async extents when flushing delalloc
Date:   Fri, 11 Jun 2021 09:53:57 -0400
Message-Id: <f2a18e6cf6553f9b886768d86d5580561d9c279e.1623419155.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1623419155.git.josef@toxicpanda.com>
References: <cover.1623419155.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've been debugging an early ENOSPC problem in production and finally
root caused it to this problem.  When we switched to the per-inode
flushing code I pulled out the async extent handling, because we were
doing the correct thing by calling filemap_flush() if we had async
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
 fs/btrfs/space-info.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8ba4b194cd3e..6cb73ff59c7c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9681,10 +9681,6 @@ static int start_delalloc_inodes(struct btrfs_root *root,
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
index af467e888545..3c89af4fd729 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -547,9 +547,42 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
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
+		 * Josef, when you think you are smart enough to remove this in
+		 * the future, read this comment 4 times and explain in the
+		 * commit message why it makes sense to remove it, and then
+		 * delete the commit and don't remove it.
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

