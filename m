Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD3070C2D3
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 17:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjEVP4m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 11:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjEVP4l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 11:56:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8D89E
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 08:56:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 028E71FFDB;
        Mon, 22 May 2023 15:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684770999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qsw+B6nFbNCouSkEWlmp/2H5kOgWm4+AqJtv0PNlEYs=;
        b=CK8j+ye3TWvCLLU1fhpo+jMgwR1F01oPbzbyErQ5bkTgj8QEtXPlxa23GlnVhiMvHqAnG6
        xsAXqGmjGe0Z3uM8VuinBnWrgi39lROx2/OnFQGn5Bsrv5Uj+ETR509uEOg79MR9ACwQzh
        gAVt1GqMKBWuQu9WgCzVZvuKEAjZ41Y=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E106F2C141;
        Mon, 22 May 2023 15:56:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BE78CDA82D; Mon, 22 May 2023 17:50:33 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: disable allocation warnings for compression workspaces
Date:   Mon, 22 May 2023 17:50:32 +0200
Message-Id: <20230522155032.4358-1-dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The workspaces for compression are typically much larger than a page and
for high zstd levels in the range of megabytes. There's a fallback to
vmalloc but this can still fail (see the report).

Some of the workspaces are preallocated at module load time so we have a
safe fallback, otherwise when a new workspace is needed it's allocated
but if this fails then the process waits. Which means the warning is
only causing noise and we can use the GFP flag to disable it.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=217466
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/lzo.c  | 6 +++---
 fs/btrfs/zlib.c | 2 +-
 fs/btrfs/zstd.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 3a095b9c6373..d3fcfc628a4f 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -88,9 +88,9 @@ struct list_head *lzo_alloc_workspace(unsigned int level)
 	if (!workspace)
 		return ERR_PTR(-ENOMEM);
 
-	workspace->mem = kvmalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
-	workspace->buf = kvmalloc(WORKSPACE_BUF_LENGTH, GFP_KERNEL);
-	workspace->cbuf = kvmalloc(WORKSPACE_CBUF_LENGTH, GFP_KERNEL);
+	workspace->mem = kvmalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL | __GFP_NOWARN);
+	workspace->buf = kvmalloc(WORKSPACE_BUF_LENGTH, GFP_KERNEL | __GFP_NOWARN);
+	workspace->cbuf = kvmalloc(WORKSPACE_CBUF_LENGTH, GFP_KERNEL | __GFP_NOWARN);
 	if (!workspace->mem || !workspace->buf || !workspace->cbuf)
 		goto fail;
 
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 8acb05e176c5..6c231a116a29 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -63,7 +63,7 @@ struct list_head *zlib_alloc_workspace(unsigned int level)
 
 	workspacesize = max(zlib_deflate_workspacesize(MAX_WBITS, MAX_MEM_LEVEL),
 			zlib_inflate_workspacesize());
-	workspace->strm.workspace = kvzalloc(workspacesize, GFP_KERNEL);
+	workspace->strm.workspace = kvzalloc(workspacesize, GFP_KERNEL | __GFP_NOWARN);
 	workspace->level = level;
 	workspace->buf = NULL;
 	/*
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index f798da267590..e7ac4ec809a4 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -356,7 +356,7 @@ struct list_head *zstd_alloc_workspace(unsigned int level)
 	workspace->level = level;
 	workspace->req_level = level;
 	workspace->last_used = jiffies;
-	workspace->mem = kvmalloc(workspace->size, GFP_KERNEL);
+	workspace->mem = kvmalloc(workspace->size, GFP_KERNEL | __GFP_NOWARN);
 	workspace->buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!workspace->mem || !workspace->buf)
 		goto fail;
-- 
2.40.0

