Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CFF27DE0D
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbgI3B43 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:56:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:50190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729843AbgI3B42 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:56:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601430987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ktf6xVJ3A6pAe8XjPeZRKQjD59dj9Vy8Xu06DjXEJpE=;
        b=pZgKO0BXP4Ov0TqDpvS7BqR539XWUn40mb1LfnENmw0K9er+OH0GQ4JheSZhFNYwQE4pvX
        ONNvDkTq5S/JV4np7ielYWyqyUuAb7WDRpmfUN398v19jSwg5qKoKlBfu9TvW6tRNKggsU
        rbjX7ZViLi3DXTDJSaNIgjq3OuF+xQg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 83E4CAFCD
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 01:56:27 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 20/49] btrfs: disk_io: grab fs_info from extent_buffer::fs_info directly for btrfs_mark_buffer_dirty()
Date:   Wed, 30 Sep 2020 09:55:10 +0800
Message-Id: <20200930015539.48867-21-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930015539.48867-1-wqu@suse.com>
References: <20200930015539.48867-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since commit f28491e0a6c4 ("Btrfs: move the extent buffer radix tree into
the fs_info"), fs_info can be grabbed from extent_buffer directly.

So use that extent_buffer::fs_info directly in btrfs_mark_buffer_dirty()
to make things a little easier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c81b7e53149c..58928076d08d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4190,8 +4190,7 @@ int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
 
 void btrfs_mark_buffer_dirty(struct extent_buffer *buf)
 {
-	struct btrfs_fs_info *fs_info;
-	struct btrfs_root *root;
+	struct btrfs_fs_info *fs_info = buf->fs_info;
 	u64 transid = btrfs_header_generation(buf);
 	int was_dirty;
 
@@ -4204,8 +4203,6 @@ void btrfs_mark_buffer_dirty(struct extent_buffer *buf)
 	if (unlikely(test_bit(EXTENT_BUFFER_UNMAPPED, &buf->bflags)))
 		return;
 #endif
-	root = BTRFS_I(buf->pages[0]->mapping->host)->root;
-	fs_info = root->fs_info;
 	btrfs_assert_tree_locked(buf);
 	if (transid != fs_info->generation)
 		WARN(1, KERN_CRIT "btrfs transid mismatch buffer %llu, found %llu running %llu\n",
-- 
2.28.0

