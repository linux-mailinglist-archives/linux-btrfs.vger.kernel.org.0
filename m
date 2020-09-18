Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40A026FE9B
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 15:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgIRNeo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 09:34:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:40932 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgIRNen (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 09:34:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600436081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=jbGnh8KERY1PqYaQkyR58qYXFslqhmCdFVNzsyQdxWg=;
        b=MAsSq6+9PAzbaCIowyNp80xK1KYUh/J5yGwRIB2z2XTafdbGB3eIOHcNJpdY+99wHforDx
        IScWaSk1q1uppXPV5rpmcpCvDaDNFeQ2m8hCgACXRmmIlR/79Y3erFucSC8eAFnGNXj/L+
        BxS70DGc6t1aXq+cIcicdtxzDW2Gsjs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05385B1E1;
        Fri, 18 Sep 2020 13:35:16 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/7] btrfs: Remove extent_io_ops::readpage_end_io_hook
Date:   Fri, 18 Sep 2020 16:34:34 +0300
Message-Id: <20200918133439.23187-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918133439.23187-1-nborisov@suse.com>
References: <20200918133439.23187-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's no longer used so let's remove it.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.c   | 4 +---
 fs/btrfs/extent_io.h | 5 +----
 fs/btrfs/inode.c     | 4 +---
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5ad11c38230f..73937954f464 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4637,7 +4637,5 @@ static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)
 }
 
 static const struct extent_io_ops btree_extent_io_ops = {
-	/* mandatory callbacks */
-	.submit_bio_hook = btree_submit_bio_hook,
-	.readpage_end_io_hook = NULL
+	.submit_bio_hook = btree_submit_bio_hook
 };
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 133487a5e6b8..d9119bd555a9 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -77,13 +77,10 @@ typedef blk_status_t (extent_submit_bio_start_t)(void *private_data,
 
 struct extent_io_ops {
 	/*
-	 * The following callbacks must be always defined, the function
+	 * The following callback must be always defined, the function
 	 * pointer will be called unconditionally.
 	 */
 	submit_bio_hook_t *submit_bio_hook;
-	int (*readpage_end_io_hook)(struct btrfs_io_bio *io_bio, u64 phy_offset,
-				    struct page *page, u64 start, u64 end,
-				    int mirror);
 };
 
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 23ac09aa813e..41565c5a05ef 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10246,9 +10246,7 @@ static const struct file_operations btrfs_dir_file_operations = {
 };
 
 static const struct extent_io_ops btrfs_extent_io_ops = {
-	/* mandatory callbacks */
-	.submit_bio_hook = btrfs_submit_bio_hook,
-	.readpage_end_io_hook = NULL
+	.submit_bio_hook = btrfs_submit_bio_hook
 };
 
 /*
-- 
2.17.1

