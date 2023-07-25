Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABA476060F
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 04:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjGYC5p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 22:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjGYC5o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 22:57:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF7DF1
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 19:57:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D38661FDA7
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 02:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690253861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aM2oAq2kdWsl4iBbkXnmKehgv7SUyUuuiO6rvO4Fhbo=;
        b=TR4frfv6XNj9neafyu++KxHbMl/pl9nYwuQghsFm7EFgYiPY8BX6hoxuRKANgc0NkCwVl9
        f5udHLZiT/+mUkyrVtQwY16RFgexR+cXHrQQa8X9t5ZDUmfvC823oH7yE1ZKw5CjwlI2qy
        04n/FmKkK4OJd+O8r/BOrt0u/3CcsU4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 276AE13487
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 02:57:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8F9VNyQ6v2R1JAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 02:57:40 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 1/2] btrfs: map uncontinuous extent buffer pages into virtual address space
Date:   Tue, 25 Jul 2023 10:57:21 +0800
Message-ID: <46e2952cfe5b76733f5c2b22f11832f062be6200.1690249862.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690249862.git.wqu@suse.com>
References: <cover.1690249862.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs implements its extent buffer read-write using various
helpers doing cross-page handling for the pages array.

However other filesystems like XFS is mapping the pages into kernel
virtual address space, greatly simplify the access.

This patch would learn from XFS and map the pages into virtual address
space, if and only if the pages are not physically continuous.
(Note, a single page counts as physically continuous.)

For now we only do the map, but not yet really utilize the mapped
address.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent_io.h |  7 +++++
 2 files changed, 77 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4144c649718e..f40d48f641c0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -14,6 +14,7 @@
 #include <linux/pagevec.h>
 #include <linux/prefetch.h>
 #include <linux/fsverity.h>
+#include <linux/vmalloc.h>
 #include "misc.h"
 #include "extent_io.h"
 #include "extent-io-tree.h"
@@ -3206,6 +3207,8 @@ static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
 	ASSERT(!extent_buffer_under_io(eb));
 
 	num_pages = num_extent_pages(eb);
+	if (eb->vaddr)
+		vm_unmap_ram(eb->vaddr, num_pages);
 	for (i = 0; i < num_pages; i++) {
 		struct page *page = eb->pages[i];
 
@@ -3255,6 +3258,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 {
 	int i;
 	struct extent_buffer *new;
+	bool pages_contig = true;
 	int num_pages = num_extent_pages(src);
 	int ret;
 
@@ -3279,6 +3283,9 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 		int ret;
 		struct page *p = new->pages[i];
 
+		if (i && p != new->pages[i - 1] + 1)
+			pages_contig = false;
+
 		ret = attach_extent_buffer_page(new, p, NULL);
 		if (ret < 0) {
 			btrfs_release_extent_buffer(new);
@@ -3286,6 +3293,23 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 		}
 		WARN_ON(PageDirty(p));
 	}
+	if (!pages_contig) {
+		unsigned int nofs_flag;
+		int retried = 0;
+
+		nofs_flag = memalloc_nofs_save();
+		do {
+			new->vaddr = vm_map_ram(new->pages, num_pages, -1);
+			if (new->vaddr)
+				break;
+			vm_unmap_aliases();
+		} while ((retried++) <= 1);
+		memalloc_nofs_restore(nofs_flag);
+		if (!new->vaddr) {
+			btrfs_release_extent_buffer(new);
+			return NULL;
+		}
+	}
 	copy_extent_buffer_full(new, src);
 	set_extent_buffer_uptodate(new);
 
@@ -3296,6 +3320,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 						  u64 start, unsigned long len)
 {
 	struct extent_buffer *eb;
+	bool pages_contig = true;
 	int num_pages;
 	int i;
 	int ret;
@@ -3312,11 +3337,29 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = eb->pages[i];
 
+		if (i && p != eb->pages[i - 1] + 1)
+			pages_contig = false;
+
 		ret = attach_extent_buffer_page(eb, p, NULL);
 		if (ret < 0)
 			goto err;
 	}
 
+	if (!pages_contig) {
+		unsigned int nofs_flag;
+		int retried = 0;
+
+		nofs_flag = memalloc_nofs_save();
+		do {
+			eb->vaddr = vm_map_ram(eb->pages, num_pages, -1);
+			if (eb->vaddr)
+				break;
+			vm_unmap_aliases();
+		} while ((retried++) <= 1);
+		memalloc_nofs_restore(nofs_flag);
+		if (!eb->vaddr)
+			goto err;
+	}
 	set_extent_buffer_uptodate(eb);
 	btrfs_set_header_nritems(eb, 0);
 	set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
@@ -3539,6 +3582,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	struct btrfs_subpage *prealloc = NULL;
 	u64 lockdep_owner = owner_root;
+	bool pages_contig = true;
 	int uptodate = 1;
 	int ret;
 
@@ -3611,6 +3655,10 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		/* Should not fail, as we have preallocated the memory */
 		ret = attach_extent_buffer_page(eb, p, prealloc);
 		ASSERT(!ret);
+
+		if (i && p != eb->pages[i - 1] + 1)
+			pages_contig = false;
+
 		/*
 		 * To inform we have extra eb under allocation, so that
 		 * detach_extent_buffer_page() won't release the page private
@@ -3636,6 +3684,28 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		 * we could crash.
 		 */
 	}
+
+	/*
+	 * If pages are not continuous, here we map it into a continuous virtual
+	 * range to make later access easier.
+	 */
+	if (!pages_contig) {
+		unsigned int nofs_flag;
+		int retried = 0;
+
+		nofs_flag = memalloc_nofs_save();
+		do {
+			eb->vaddr = vm_map_ram(eb->pages, num_pages, -1);
+			if (eb->vaddr)
+				break;
+			vm_unmap_aliases();
+		} while ((retried++) <= 1);
+		memalloc_nofs_restore(nofs_flag);
+		if (!eb->vaddr) {
+			exists = ERR_PTR(-ENOMEM);
+			goto free_eb;
+		}
+	}
 	if (uptodate)
 		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
 again:
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 5966d810af7b..f1505c3a05cc 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -88,6 +88,13 @@ struct extent_buffer {
 
 	struct rw_semaphore lock;
 
+	/*
+	 * For virtually mapped address.
+	 *
+	 * NULL if the pages are physically continuous.
+	 */
+	void *vaddr;
+
 	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
 #ifdef CONFIG_BTRFS_DEBUG
 	struct list_head leak_list;
-- 
2.41.0

