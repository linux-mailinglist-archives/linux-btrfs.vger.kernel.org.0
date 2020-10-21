Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93018294832
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440760AbgJUG0r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:26:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:43100 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731630AbgJUG0r (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:26:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ktf6xVJ3A6pAe8XjPeZRKQjD59dj9Vy8Xu06DjXEJpE=;
        b=oXgyXtDhUtFauWW7468JdTuU5NhyGUS6iiQHAU0YurXniktEj48I7R3nxpb3p3h6xckxpA
        bRsd3MI7aD1XWw63ifjc+w1DYbMgfxcgIb9sqDhr4WO/4R8bSL7GJYDevVU0/hHV87ner8
        eYwqI+8aSdS6Ta25bGMyNRNPLvwLCMM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 10A4BAC1D
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:26:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 22/68] btrfs: disk_io: grab fs_info from extent_buffer::fs_info directly for btrfs_mark_buffer_dirty()
Date:   Wed, 21 Oct 2020 14:25:08 +0800
Message-Id: <20201021062554.68132-23-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
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

