Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C94F2F8BFE
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jan 2021 08:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbhAPHRO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jan 2021 02:17:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:56156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbhAPHRO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jan 2021 02:17:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610781358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YUfWAyhbQG+1m6zDQGC63vBbQkN2NuPvOKVSpKvbno8=;
        b=H/xBxIQBADFqmgzkK1W6z33Ro1B5fA+L+n633IvZT5OJERLtkKFumS5MXY5p5sqOgKTr/f
        k/kv1wEPnIxTtnvcW8YbQUYHwQ4F3r5g47aNLsdqsp2IPgTm3/KODoBfOTbKufDOi3YPvL
        pU+x0vapHJcYE82Tu5x3Tg9iEaKU314=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D786DB8F2
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jan 2021 07:15:58 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 07/18] btrfs: attach private to dummy extent buffer pages
Date:   Sat, 16 Jan 2021 15:15:22 +0800
Message-Id: <20210116071533.105780-8-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210116071533.105780-1-wqu@suse.com>
References: <20210116071533.105780-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Even for regular btrfs, there are locations where we allocate dummy
extent buffers for temporary usage.

Like tree_mod_log_rewind() and get_old_root().

Those dummy extent buffers will be handled by the same eb accessors, and
if they don't have page::private subpage eb accessors can fail.

To address such problems, make __alloc_dummy_extent_buffer() to attach
page private for dummy extent buffers too.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index fb800f237099..7f94f00936d7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5204,9 +5204,14 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
+		int ret;
+
 		eb->pages[i] = alloc_page(GFP_NOFS);
 		if (!eb->pages[i])
 			goto err;
+		ret = attach_extent_buffer_page(eb, eb->pages[i], NULL);
+		if (ret < 0)
+			goto err;
 	}
 	set_extent_buffer_uptodate(eb);
 	btrfs_set_header_nritems(eb, 0);
@@ -5214,8 +5219,10 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 
 	return eb;
 err:
-	for (; i > 0; i--)
+	for (; i > 0; i--) {
+		detach_extent_buffer_page(eb, eb->pages[i - 1]);
 		__free_page(eb->pages[i - 1]);
+	}
 	__free_extent_buffer(eb);
 	return NULL;
 }
-- 
2.30.0

