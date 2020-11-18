Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2542B7992
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 09:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgKRIxf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 03:53:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:47624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgKRIxf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 03:53:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605689613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DUj0cWKiIEgRFvhOFz5LC2T6WZX++Fj1bHql6QSzjXk=;
        b=cOAjxmRndtR8uS/x0nVrUpTXXKecX9HpiMZ3h/ZTdeFPksy4q6t+Wlf08CjfyAUFNbbgCf
        nJ4CLffuy/EjD6ijMf3S1tyMu42FVbhelU1jJVIm/BWgui1KomAix31sEHFoLilpl5J0Fj
        3fhJ3GyTbT2pcp6qU0tbKCRSTFzCnto=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AB0F6AD2F
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Nov 2020 08:53:33 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/14] btrfs: extent_io: introduce the skeleton of btrfs_subpage structure
Date:   Wed, 18 Nov 2020 16:53:08 +0800
Message-Id: <20201118085319.56668-4-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118085319.56668-1-wqu@suse.com>
References: <20201118085319.56668-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For btrfs subpage support, we need a structure for record extra info for
a page so that we can know things like which sector in the page is
uptodate/dirty.

This patch will introduce the skeleton structure for future btrfs
subpage support.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 32 ++++++++++++++++++++++++++++++++
 fs/btrfs/extent_io.h |  8 ++++++++
 2 files changed, 40 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 759d2f2292ed..2eaf09ff59ca 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5279,6 +5279,38 @@ static struct extent_buffer *grab_extent_buffer_from_page(struct page *page)
 	return NULL;
 }
 
+int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page *page)
+{
+	struct btrfs_subpage *subpage;
+
+	ASSERT(PageLocked(page));
+	/* Either not subpage, or the page already has private attached */
+	if (!btrfs_is_subpage(fs_info) || PagePrivate(page))
+		return 0;
+
+	subpage = kzalloc(sizeof(*subpage), GFP_NOFS);
+	if (!subpage)
+		return -ENOMEM;
+
+	spin_lock_init(&subpage->lock);
+	attach_page_private(page, subpage);
+	return 0;
+}
+
+void btrfs_detach_subpage(struct btrfs_fs_info *fs_info, struct page *page)
+{
+	struct btrfs_subpage *subpage;
+
+	/* Either not subpage, or already detached */
+	if (!btrfs_is_subpage(fs_info) || !PagePrivate(page))
+		return;
+
+	subpage = (struct btrfs_subpage *)detach_page_private(page);
+	ASSERT(subpage && bitmap_empty(subpage->tree_block_bitmap,
+				       BTRFS_SUBPAGE_BITMAP_SIZE));
+	kfree(subpage);
+}
+
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 start, u64 owner_root, int level)
 {
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 0123c75ee203..4251bef25aac 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -307,6 +307,14 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
 				      u64 start, u64 end, int failed_mirror,
 				      submit_bio_hook_t *submit_bio_hook);
 
+#define BTRFS_SUBPAGE_BITMAP_SIZE	(SZ_64K / SZ_4K)
+struct btrfs_subpage {
+	spinlock_t lock;
+	DECLARE_BITMAP(tree_block_bitmap, BTRFS_SUBPAGE_BITMAP_SIZE);
+};
+
+int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
+void btrfs_detach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 bool find_lock_delalloc_range(struct inode *inode,
 			     struct page *locked_page, u64 *start,
-- 
2.29.2

