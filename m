Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E43B78678C
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Aug 2023 08:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240119AbjHXGeK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Aug 2023 02:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240145AbjHXGdr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Aug 2023 02:33:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B88BA8
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 23:33:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7EEB522C09
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 06:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692858823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BINppVa/0Pc0Jtdm2Vyfj6SivsAuYcyiTC1uV1pPcSY=;
        b=fko1AG5GMr/RaFrfDyoaKRzxGFUBfuRxbA2XiNLb2fsHOis6+9lRJfTVSv4ngd5rdfaEad
        4uTmFelHiSsHNUFheG4aJ73Zr2d1dB8cA3ebuwkz/27255TaoFqiB/K4/7YCwt0yQ4twvS
        JA23cbnw7HbnxDqNjZ/bjKlOqVE3b4s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4672138FB
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 06:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kPt0J8b55mQqDAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 06:33:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: map uncontinuous extent buffer pages into virtual address space
Date:   Thu, 24 Aug 2023 14:33:37 +0800
Message-ID: <d68af5f6ddd6472ccef76db6f704d900945a53c0.1692858397.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692858397.git.wqu@suse.com>
References: <cover.1692858397.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index f13211975e0b..9f9a3ab82f04 100644
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
@@ -3153,6 +3154,8 @@ static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
 	ASSERT(!extent_buffer_under_io(eb));
 
 	num_pages = num_extent_pages(eb);
+	if (eb->vaddr)
+		vm_unmap_ram(eb->vaddr, num_pages);
 	for (i = 0; i < num_pages; i++) {
 		struct page *page = eb->pages[i];
 
@@ -3202,6 +3205,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 {
 	int i;
 	struct extent_buffer *new;
+	bool pages_contig = true;
 	int num_pages = num_extent_pages(src);
 	int ret;
 
@@ -3226,6 +3230,9 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 		int ret;
 		struct page *p = new->pages[i];
 
+		if (i && p != new->pages[i - 1] + 1)
+			pages_contig = false;
+
 		ret = attach_extent_buffer_page(new, p, NULL);
 		if (ret < 0) {
 			btrfs_release_extent_buffer(new);
@@ -3233,6 +3240,23 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
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
 
@@ -3243,6 +3267,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 						  u64 start, unsigned long len)
 {
 	struct extent_buffer *eb;
+	bool pages_contig = true;
 	int num_pages;
 	int i;
 	int ret;
@@ -3259,11 +3284,29 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
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
@@ -3486,6 +3529,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	struct btrfs_subpage *prealloc = NULL;
 	u64 lockdep_owner = owner_root;
+	bool pages_contig = true;
 	int uptodate = 1;
 	int ret;
 
@@ -3558,6 +3602,10 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
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
@@ -3583,6 +3631,28 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
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
index 68368ba99321..930a2dc38157 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -87,6 +87,13 @@ struct extent_buffer {
 
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

