Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795B72EB762
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 02:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbhAFBDo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 20:03:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:45900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbhAFBDo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Jan 2021 20:03:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609894946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=guv89VQOdB6Z2KhL8iB2kKYZUkjFuNXImUymuWXxCqk=;
        b=mVNlLrKX6z+GUOdW4M7lwmGaA9HlGCrjWAseJOKJ03D8tYsxuKRfTeQiH91lzXVYo9aCKj
        h7Lf1tE1h4xfpi53VS0623hXeQloqI8YS/55PrIDwIyzZNCkeddRDCfSUZCqJ/sPkbfsO+
        aZzQI1AyJcNImCOQu8TuSu+I8/8BHHA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C1366AF4C
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jan 2021 01:02:26 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 11/22] btrfs: extent_io: attach private to dummy extent buffer pages
Date:   Wed,  6 Jan 2021 09:01:50 +0800
Message-Id: <20210106010201.37864-12-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106010201.37864-1-wqu@suse.com>
References: <20210106010201.37864-1-wqu@suse.com>
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
index 3158461ebf4c..3bd4b99897d6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5146,9 +5146,14 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
+		int ret;
+
 		eb->pages[i] = alloc_page(GFP_NOFS);
 		if (!eb->pages[i])
 			goto err;
+		ret = attach_extent_buffer_page(eb, eb->pages[i]);
+		if (ret < 0)
+			goto err;
 	}
 	set_extent_buffer_uptodate(eb);
 	btrfs_set_header_nritems(eb, 0);
@@ -5156,8 +5161,10 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 
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
2.29.2

