Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BE32A4684
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgKCNbu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:31:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:44690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729352AbgKCNbu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:31:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=htUvAJAoU9EbXW7IYGFWfOyqeUc8fblvRzLOJ2LrgNk=;
        b=Fn2Lxv8b/LMTO455c8Gag9lCwxoCMT31EsC6FIgWWsp1CjwbptVMmbzAXxSj2J4HNAq79n
        nBnuBtyxinE2uWy0uCAmzV/gnhnjRl5UsuHB0zEHGg+XZqHqZ+vN1S1agC4oPfFIMzW9v7
        vrY4rdqZaJwneay6lG6ykzaqjXOytw8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 03E71ABF4
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 13:31:48 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/32] btrfs: disk_io: grab fs_info from extent_buffer::fs_info directly for btrfs_mark_buffer_dirty()
Date:   Tue,  3 Nov 2020 21:30:46 +0800
Message-Id: <20201103133108.148112-11-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
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
index c70a52b44ceb..1b527b2d16d8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4191,8 +4191,7 @@ int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
 
 void btrfs_mark_buffer_dirty(struct extent_buffer *buf)
 {
-	struct btrfs_fs_info *fs_info;
-	struct btrfs_root *root;
+	struct btrfs_fs_info *fs_info = buf->fs_info;
 	u64 transid = btrfs_header_generation(buf);
 	int was_dirty;
 
@@ -4205,8 +4204,6 @@ void btrfs_mark_buffer_dirty(struct extent_buffer *buf)
 	if (unlikely(test_bit(EXTENT_BUFFER_UNMAPPED, &buf->bflags)))
 		return;
 #endif
-	root = BTRFS_I(buf->pages[0]->mapping->host)->root;
-	fs_info = root->fs_info;
 	btrfs_assert_tree_locked(buf);
 	if (transid != fs_info->generation)
 		WARN(1, KERN_CRIT "btrfs transid mismatch buffer %llu, found %llu running %llu\n",
-- 
2.29.2

