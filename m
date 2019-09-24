Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C17AABD3CC
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 22:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbfIXUuu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 16:50:50 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36222 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfIXUuu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 16:50:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id y189so3295353qkc.3
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 13:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QkJ9CHxApOUnXEifyT4dHaurfifVgyWe+EFM6lvayeo=;
        b=kTEiyD1c1KFEPaW9x24NGjPgmYNtNCMQgnEXTx2riOBHazYZAiHvVj10f8P0HL2Z/k
         PGvnib1D0bPEnGiuctdAbk3Zbt62cCB0HnNC8co7xRx9YwloAAMNKBOBqa1lPNtb420m
         8yZ2xy+UXnDbzEeElT2jVjolkDNQaGmgSknfgOasy5KmqpGXL4ltDJ/26J98AIY1ZzfS
         G0pNAGOkhiJ+2q8Bpa+QvFHUfH7+m9biJaMYJYGxA/1c0TI9IsMyn4z3h3u3yNMkULZw
         eBjBdRCiQRDk8or8Po7/ixooaoofSfH3LnN6dWRMd9+vje2/Mu44JxD3anPiLzRFrqDw
         wJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QkJ9CHxApOUnXEifyT4dHaurfifVgyWe+EFM6lvayeo=;
        b=GXpmWEWfIdXeQeogDcYv0IGdq4wv9H3On1Z35wPFPkS9fFwAk8CXQr2qk/hfj2PXCD
         kPsAI/nu2KUMIGBT6DF9QGttoEPv+wP8CJRZ9qz4PPm1rJNUc5haGbGglkylfuIKrT1S
         2lD7maIuaEND4uY9sdmrVXUS3CpMqh2ylpkB534zBVZxmrbWJaTlz/9KDLOrrYwHnb8N
         u/OWebPGUF9jn5zTUMymzHH5ncK+8cg5GSP6NETl7NLLwBHx5xDk4muIomV+/BWl1WT8
         MXYWI6fXUrJsfweMEu4exhYLf7hPflmGWlDNBizOzrjnuQoxORE+UODnmr+iZyIwNpua
         I5bw==
X-Gm-Message-State: APjAAAUQQKME/f0L1QPzdCv0eUe2nJZ3n77Z3uxbZIuyKQU5WNVQPRZl
        qehV+0oVqAQHHDhDU42+pyceay9eH0+Gww==
X-Google-Smtp-Source: APXvYqz5YOXc3IZURlh2S+biuE/LT4y5O6jKpO9EmrAocnGBX7RgnlxA46HeQHsinbpEyjnLiKB0Jw==
X-Received: by 2002:a37:6fc1:: with SMTP id k184mr14515qkc.237.1569358247883;
        Tue, 24 Sep 2019 13:50:47 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b50sm2050056qte.48.2019.09.24.13.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 13:50:47 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: use btrfs_block_group_cache_done in update_block_group
Date:   Tue, 24 Sep 2019 16:50:44 -0400
Message-Id: <20190924205044.31830-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190924205044.31830-1-josef@toxicpanda.com>
References: <20190924205044.31830-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When free'ing extents in a block group we check to see if the block
group is not cached, and then cache it if we need to.  However we'll
just carry on as long as we're loading the cache.  This is problematic
because we are dirtying the block group here.  If we are fast enough we
could do a transaction commit and clear the free space cache while we're
still loading the space cache in another thread.  This truncates the
free space inode, which will keep it from loading the space cache.

Fix this by using the btrfs_block_group_cache_done helper so that we try
to load the space cache unconditionally here, which will result in the
caller waiting for the fast caching to complete and keep us from
truncating the free space inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index bf7e3f23bba7..d7b3a516f27a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2661,7 +2661,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		 * is because we need the unpinning stage to actually add the
 		 * space back to the block group, otherwise we will leak space.
 		 */
-		if (!alloc && cache->cached == BTRFS_CACHE_NO)
+		if (!alloc && !btrfs_block_group_cache_done(cache))
 			btrfs_cache_block_group(cache, 1);
 
 		byte_in_group = bytenr - cache->key.objectid;
-- 
2.21.0

