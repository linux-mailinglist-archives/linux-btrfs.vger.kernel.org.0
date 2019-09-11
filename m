Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1D2AFFF8
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 17:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfIKP0h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 11:26:37 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44074 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbfIKP0h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 11:26:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id i78so21157152qke.11
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 08:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=B8sUpAjQgwfcmFZy5GTjP0434XTb7mlKHp53djKQn6c=;
        b=vU4pa6Y/gcWYudWtvG3X5VXKm6ysELasdQi9vvWqBOGOYPaKRmhR/swSMVgi9zShPN
         hBZjs+hm38Tv4+FZcX9BreRgC6xR7KxJClyeNJwzcYmP5/24xtxA1Ha0Matn2bB6nVpi
         eCJZgWWriOPfGGSsNbVoVyB72o2tU2u8mmf5MPWVw/dc4iR9P4DYH6VrPZP/R7Ub+FOZ
         4Wk8nV2Dsc8gFLYTlfK+q4TyFXJMBJExayfQNPyfHKxIqqtKELFtCyFXGmid38oIe5qN
         85GFZZll9FMFNHSVol1ZAp8F7DUvlQ7WXmQfnEuT6dlp1dY6CUmzHGTsdaj6cDbiv8Od
         U9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B8sUpAjQgwfcmFZy5GTjP0434XTb7mlKHp53djKQn6c=;
        b=s+iG69G2yInp48Ego/5a8IO3FFbFVviQ1HAkmkNDQvBy86LMKjXST1i5bolzD3u77N
         1QlQW5/v6hp0fdFnkPKm1WhYccxvQAv7PznaqUk2CNpFDk5h0jD+GOpce63c2tFKeRTI
         ghbEh7wiOc4dznr4MGRejzEXUPe2vBZ+wUaz4yOicGBSUQayc0wlfu4TcMrMgPcC2GKd
         Bx2EGgsPJ0XUXpcr3NYKLEjm/Bh1hmQULBS0RtVDNuNsM4pA6RkJvHyu+s2SoL+dvQQL
         1rd/SIRYJzoV6OA7NP3nfBIACQo2ID+5/NbwSb29ESDxEjuYYAGwOCGB7otXfyr5kgPN
         2VrQ==
X-Gm-Message-State: APjAAAWSM9fHfvVhYPDNykXVNakmIBUcDdaiwgI1YKfdXo9bPq2FiGf/
        KM/gDsMACvKIw8eN1N+E2JZg+eE+FM51vw==
X-Google-Smtp-Source: APXvYqyc4rb92DmFk76/u8tPo83Jm42F9nNSvbu/PeAdaaE2dlOay32RxYP+fIV21BpalCmqZuuDJA==
X-Received: by 2002:a37:4c16:: with SMTP id z22mr2788491qka.42.1568215591538;
        Wed, 11 Sep 2019 08:26:31 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f5sm5932136qkg.9.2019.09.11.08.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 08:26:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 9/9] btrfs: move the extent-buffer code
Date:   Wed, 11 Sep 2019 11:26:11 -0400
Message-Id: <20190911152611.3393-10-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911152611.3393-1-josef@toxicpanda.com>
References: <20190911152611.3393-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This moves the extent buffer code into its own file.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/Makefile        |    3 +-
 fs/btrfs/extent-buffer.c | 1266 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent_io.c     | 1255 -------------------------------------
 3 files changed, 1268 insertions(+), 1256 deletions(-)
 create mode 100644 fs/btrfs/extent-buffer.c

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 7ce7202f5fe8..4d669c1d09fa 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -11,7 +11,8 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   compression.o delayed-ref.o relocation.o delayed-inode.o scrub.o \
 	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
-	   block-rsv.o delalloc-space.o block-group.o extent-io-tree.o
+	   block-rsv.o delalloc-space.o block-group.o extent-io-tree.o \
+	   extent-buffer.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/extent-buffer.c b/fs/btrfs/extent-buffer.c
new file mode 100644
index 000000000000..f03e67de34c2
--- /dev/null
+++ b/fs/btrfs/extent-buffer.c
@@ -0,0 +1,1266 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/swap.h>
+#include <linux/sched.h>
+#include <linux/radix-tree.h>
+#include <linux/wait_bit.h>
+#include "ctree.h"
+#include "extent-buffer.h"
+
+static struct kmem_cache *extent_buffer_cache;
+
+#ifdef CONFIG_BTRFS_DEBUG
+static LIST_HEAD(buffers);
+
+static DEFINE_SPINLOCK(leak_lock);
+
+static inline
+void btrfs_leak_debug_add(struct list_head *new, struct list_head *head)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&leak_lock, flags);
+	list_add(new, head);
+	spin_unlock_irqrestore(&leak_lock, flags);
+}
+
+static inline
+void btrfs_leak_debug_del(struct list_head *entry)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&leak_lock, flags);
+	list_del(entry);
+	spin_unlock_irqrestore(&leak_lock, flags);
+}
+
+static inline
+void btrfs_extent_buffer_leak_debug_check()
+{
+	while (!list_empty(&buffers)) {
+		eb = list_entry(buffers.next, struct extent_buffer, leak_list);
+		pr_err("BTRFS: buffer leak start %llu len %lu refs %d bflags %lu\n",
+		       eb->start, eb->len, atomic_read(&eb->refs), eb->bflags);
+		list_del(&eb->leak_list);
+		kmem_cache_free(extent_buffer_cache, eb);
+	}
+}
+#else
+#define btrfs_leak_debug_add(new, head)	do {} while (0)
+#define btrfs_leak_debug_del(entry)	do {} while (0)
+#define btrfs_extent_buffer_leak_debug_check()	do {} while (0)
+#endif
+
+int __init extent_buffer_init(void)
+{
+	extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
+			sizeof(struct extent_buffer), 0,
+			SLAB_MEM_SPREAD, NULL);
+	if (!extent_buffer_cache)
+		return -ENOMEM;
+	return 0;
+}
+
+void __cold extent_buffer_exit(void)
+{
+	btrfs_extent_buffer_leak_debug_check();
+
+	/*
+	 * Make sure all delayed rcu free are flushed before we
+	 * destroy caches.
+	 */
+	rcu_barrier();
+	kmem_cache_destroy(extent_buffer_cache);
+}
+
+void wait_on_extent_buffer_writeback(struct extent_buffer *eb)
+{
+	wait_on_bit_io(&eb->bflags, EXTENT_BUFFER_WRITEBACK,
+		       TASK_UNINTERRUPTIBLE);
+}
+
+static void __free_extent_buffer(struct extent_buffer *eb)
+{
+	btrfs_leak_debug_del(&eb->leak_list);
+	kmem_cache_free(extent_buffer_cache, eb);
+}
+
+int extent_buffer_under_io(struct extent_buffer *eb)
+{
+	return (atomic_read(&eb->io_pages) ||
+		test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags) ||
+		test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
+}
+
+/*
+ * Release all pages attached to the extent buffer.
+ */
+static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
+{
+	int i;
+	int num_pages;
+	int mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
+
+	BUG_ON(extent_buffer_under_io(eb));
+
+	num_pages = num_extent_pages(eb);
+	for (i = 0; i < num_pages; i++) {
+		struct page *page = eb->pages[i];
+
+		if (!page)
+			continue;
+		if (mapped)
+			spin_lock(&page->mapping->private_lock);
+		/*
+		 * We do this since we'll remove the pages after we've
+		 * removed the eb from the radix tree, so we could race
+		 * and have this page now attached to the new eb.  So
+		 * only clear page_private if it's still connected to
+		 * this eb.
+		 */
+		if (PagePrivate(page) &&
+		    page->private == (unsigned long)eb) {
+			BUG_ON(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
+			BUG_ON(PageDirty(page));
+			BUG_ON(PageWriteback(page));
+			/*
+			 * We need to make sure we haven't be attached
+			 * to a new eb.
+			 */
+			ClearPagePrivate(page);
+			set_page_private(page, 0);
+			/* One for the page private */
+			put_page(page);
+		}
+
+		if (mapped)
+			spin_unlock(&page->mapping->private_lock);
+
+		/* One for when we allocated the page */
+		put_page(page);
+	}
+}
+
+/*
+ * Helper for releasing the extent buffer.
+ */
+static inline void btrfs_release_extent_buffer(struct extent_buffer *eb)
+{
+	btrfs_release_extent_buffer_pages(eb);
+	__free_extent_buffer(eb);
+}
+
+static struct extent_buffer *
+__alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
+		      unsigned long len)
+{
+	struct extent_buffer *eb = NULL;
+
+	eb = kmem_cache_zalloc(extent_buffer_cache, GFP_NOFS|__GFP_NOFAIL);
+	eb->start = start;
+	eb->len = len;
+	eb->fs_info = fs_info;
+	eb->bflags = 0;
+	rwlock_init(&eb->lock);
+	atomic_set(&eb->blocking_readers, 0);
+	eb->blocking_writers = 0;
+	eb->lock_nested = false;
+	init_waitqueue_head(&eb->write_lock_wq);
+	init_waitqueue_head(&eb->read_lock_wq);
+
+	btrfs_leak_debug_add(&eb->leak_list, &buffers);
+
+	spin_lock_init(&eb->refs_lock);
+	atomic_set(&eb->refs, 1);
+	atomic_set(&eb->io_pages, 0);
+
+	/*
+	 * Sanity checks, currently the maximum is 64k covered by 16x 4k pages
+	 */
+	BUILD_BUG_ON(BTRFS_MAX_METADATA_BLOCKSIZE
+		> MAX_INLINE_EXTENT_BUFFER_SIZE);
+	BUG_ON(len > MAX_INLINE_EXTENT_BUFFER_SIZE);
+
+#ifdef CONFIG_BTRFS_DEBUG
+	eb->spinning_writers = 0;
+	atomic_set(&eb->spinning_readers, 0);
+	atomic_set(&eb->read_locks, 0);
+	eb->write_locks = 0;
+#endif
+
+	return eb;
+}
+
+static void attach_extent_buffer_page(struct extent_buffer *eb,
+				      struct page *page)
+{
+	if (!PagePrivate(page)) {
+		SetPagePrivate(page);
+		get_page(page);
+		set_page_private(page, (unsigned long)eb);
+	} else {
+		WARN_ON(page->private != (unsigned long)eb);
+	}
+}
+
+struct extent_buffer *btrfs_clone_extent_buffer(struct extent_buffer *src)
+{
+	int i;
+	struct page *p;
+	struct extent_buffer *new;
+	int num_pages = num_extent_pages(src);
+
+	new = __alloc_extent_buffer(src->fs_info, src->start, src->len);
+	if (new == NULL)
+		return NULL;
+
+	for (i = 0; i < num_pages; i++) {
+		p = alloc_page(GFP_NOFS);
+		if (!p) {
+			btrfs_release_extent_buffer(new);
+			return NULL;
+		}
+		attach_extent_buffer_page(new, p);
+		WARN_ON(PageDirty(p));
+		SetPageUptodate(p);
+		new->pages[i] = p;
+		copy_page(page_address(p), page_address(src->pages[i]));
+	}
+
+	set_bit(EXTENT_BUFFER_UPTODATE, &new->bflags);
+	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
+
+	return new;
+}
+
+struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
+						  u64 start, unsigned long len)
+{
+	struct extent_buffer *eb;
+	int num_pages;
+	int i;
+
+	eb = __alloc_extent_buffer(fs_info, start, len);
+	if (!eb)
+		return NULL;
+
+	num_pages = num_extent_pages(eb);
+	for (i = 0; i < num_pages; i++) {
+		eb->pages[i] = alloc_page(GFP_NOFS);
+		if (!eb->pages[i])
+			goto err;
+	}
+	set_extent_buffer_uptodate(eb);
+	btrfs_set_header_nritems(eb, 0);
+	set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
+
+	return eb;
+err:
+	for (; i > 0; i--)
+		__free_page(eb->pages[i - 1]);
+	__free_extent_buffer(eb);
+	return NULL;
+}
+
+struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
+						u64 start)
+{
+	return __alloc_dummy_extent_buffer(fs_info, start, fs_info->nodesize);
+}
+
+static void check_buffer_tree_ref(struct extent_buffer *eb)
+{
+	int refs;
+	/* the ref bit is tricky.  We have to make sure it is set
+	 * if we have the buffer dirty.   Otherwise the
+	 * code to free a buffer can end up dropping a dirty
+	 * page
+	 *
+	 * Once the ref bit is set, it won't go away while the
+	 * buffer is dirty or in writeback, and it also won't
+	 * go away while we have the reference count on the
+	 * eb bumped.
+	 *
+	 * We can't just set the ref bit without bumping the
+	 * ref on the eb because free_extent_buffer might
+	 * see the ref bit and try to clear it.  If this happens
+	 * free_extent_buffer might end up dropping our original
+	 * ref by mistake and freeing the page before we are able
+	 * to add one more ref.
+	 *
+	 * So bump the ref count first, then set the bit.  If someone
+	 * beat us to it, drop the ref we added.
+	 */
+	refs = atomic_read(&eb->refs);
+	if (refs >= 2 && test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
+		return;
+
+	spin_lock(&eb->refs_lock);
+	if (!test_and_set_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
+		atomic_inc(&eb->refs);
+	spin_unlock(&eb->refs_lock);
+}
+
+static void mark_extent_buffer_accessed(struct extent_buffer *eb,
+		struct page *accessed)
+{
+	int num_pages, i;
+
+	check_buffer_tree_ref(eb);
+
+	num_pages = num_extent_pages(eb);
+	for (i = 0; i < num_pages; i++) {
+		struct page *p = eb->pages[i];
+
+		if (p != accessed)
+			mark_page_accessed(p);
+	}
+}
+
+struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
+					 u64 start)
+{
+	struct extent_buffer *eb;
+
+	rcu_read_lock();
+	eb = radix_tree_lookup(&fs_info->buffer_radix,
+			       start >> PAGE_SHIFT);
+	if (eb && atomic_inc_not_zero(&eb->refs)) {
+		rcu_read_unlock();
+		/*
+		 * Lock our eb's refs_lock to avoid races with
+		 * free_extent_buffer. When we get our eb it might be flagged
+		 * with EXTENT_BUFFER_STALE and another task running
+		 * free_extent_buffer might have seen that flag set,
+		 * eb->refs == 2, that the buffer isn't under IO (dirty and
+		 * writeback flags not set) and it's still in the tree (flag
+		 * EXTENT_BUFFER_TREE_REF set), therefore being in the process
+		 * of decrementing the extent buffer's reference count twice.
+		 * So here we could race and increment the eb's reference count,
+		 * clear its stale flag, mark it as dirty and drop our reference
+		 * before the other task finishes executing free_extent_buffer,
+		 * which would later result in an attempt to free an extent
+		 * buffer that is dirty.
+		 */
+		if (test_bit(EXTENT_BUFFER_STALE, &eb->bflags)) {
+			spin_lock(&eb->refs_lock);
+			spin_unlock(&eb->refs_lock);
+		}
+		mark_extent_buffer_accessed(eb, NULL);
+		return eb;
+	}
+	rcu_read_unlock();
+
+	return NULL;
+}
+
+#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
+struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
+					u64 start)
+{
+	struct extent_buffer *eb, *exists = NULL;
+	int ret;
+
+	eb = find_extent_buffer(fs_info, start);
+	if (eb)
+		return eb;
+	eb = alloc_dummy_extent_buffer(fs_info, start);
+	if (!eb)
+		return NULL;
+	eb->fs_info = fs_info;
+again:
+	ret = radix_tree_preload(GFP_NOFS);
+	if (ret)
+		goto free_eb;
+	spin_lock(&fs_info->buffer_lock);
+	ret = radix_tree_insert(&fs_info->buffer_radix,
+				start >> PAGE_SHIFT, eb);
+	spin_unlock(&fs_info->buffer_lock);
+	radix_tree_preload_end();
+	if (ret == -EEXIST) {
+		exists = find_extent_buffer(fs_info, start);
+		if (exists)
+			goto free_eb;
+		else
+			goto again;
+	}
+	check_buffer_tree_ref(eb);
+	set_bit(EXTENT_BUFFER_IN_TREE, &eb->bflags);
+
+	return eb;
+free_eb:
+	btrfs_release_extent_buffer(eb);
+	return exists;
+}
+#endif
+
+struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
+					  u64 start)
+{
+	unsigned long len = fs_info->nodesize;
+	int num_pages;
+	int i;
+	unsigned long index = start >> PAGE_SHIFT;
+	struct extent_buffer *eb;
+	struct extent_buffer *exists = NULL;
+	struct page *p;
+	struct address_space *mapping = fs_info->btree_inode->i_mapping;
+	int uptodate = 1;
+	int ret;
+
+	if (!IS_ALIGNED(start, fs_info->sectorsize)) {
+		btrfs_err(fs_info, "bad tree block start %llu", start);
+		return ERR_PTR(-EINVAL);
+	}
+
+	eb = find_extent_buffer(fs_info, start);
+	if (eb)
+		return eb;
+
+	eb = __alloc_extent_buffer(fs_info, start, len);
+	if (!eb)
+		return ERR_PTR(-ENOMEM);
+
+	num_pages = num_extent_pages(eb);
+	for (i = 0; i < num_pages; i++, index++) {
+		p = find_or_create_page(mapping, index, GFP_NOFS|__GFP_NOFAIL);
+		if (!p) {
+			exists = ERR_PTR(-ENOMEM);
+			goto free_eb;
+		}
+
+		spin_lock(&mapping->private_lock);
+		if (PagePrivate(p)) {
+			/*
+			 * We could have already allocated an eb for this page
+			 * and attached one so lets see if we can get a ref on
+			 * the existing eb, and if we can we know it's good and
+			 * we can just return that one, else we know we can just
+			 * overwrite page->private.
+			 */
+			exists = (struct extent_buffer *)p->private;
+			if (atomic_inc_not_zero(&exists->refs)) {
+				spin_unlock(&mapping->private_lock);
+				unlock_page(p);
+				put_page(p);
+				mark_extent_buffer_accessed(exists, p);
+				goto free_eb;
+			}
+			exists = NULL;
+
+			/*
+			 * Do this so attach doesn't complain and we need to
+			 * drop the ref the old guy had.
+			 */
+			ClearPagePrivate(p);
+			WARN_ON(PageDirty(p));
+			put_page(p);
+		}
+		attach_extent_buffer_page(eb, p);
+		spin_unlock(&mapping->private_lock);
+		WARN_ON(PageDirty(p));
+		eb->pages[i] = p;
+		if (!PageUptodate(p))
+			uptodate = 0;
+
+		/*
+		 * We can't unlock the pages just yet since the extent buffer
+		 * hasn't been properly inserted in the radix tree, this
+		 * opens a race with btree_releasepage which can free a page
+		 * while we are still filling in all pages for the buffer and
+		 * we could crash.
+		 */
+	}
+	if (uptodate)
+		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
+again:
+	ret = radix_tree_preload(GFP_NOFS);
+	if (ret) {
+		exists = ERR_PTR(ret);
+		goto free_eb;
+	}
+
+	spin_lock(&fs_info->buffer_lock);
+	ret = radix_tree_insert(&fs_info->buffer_radix,
+				start >> PAGE_SHIFT, eb);
+	spin_unlock(&fs_info->buffer_lock);
+	radix_tree_preload_end();
+	if (ret == -EEXIST) {
+		exists = find_extent_buffer(fs_info, start);
+		if (exists)
+			goto free_eb;
+		else
+			goto again;
+	}
+	/* add one reference for the tree */
+	check_buffer_tree_ref(eb);
+	set_bit(EXTENT_BUFFER_IN_TREE, &eb->bflags);
+
+	/*
+	 * Now it's safe to unlock the pages because any calls to
+	 * btree_releasepage will correctly detect that a page belongs to a
+	 * live buffer and won't free them prematurely.
+	 */
+	for (i = 0; i < num_pages; i++)
+		unlock_page(eb->pages[i]);
+	return eb;
+
+free_eb:
+	WARN_ON(!atomic_dec_and_test(&eb->refs));
+	for (i = 0; i < num_pages; i++) {
+		if (eb->pages[i])
+			unlock_page(eb->pages[i]);
+	}
+
+	btrfs_release_extent_buffer(eb);
+	return exists;
+}
+
+static inline void btrfs_release_extent_buffer_rcu(struct rcu_head *head)
+{
+	struct extent_buffer *eb =
+			container_of(head, struct extent_buffer, rcu_head);
+
+	__free_extent_buffer(eb);
+}
+
+static int release_extent_buffer(struct extent_buffer *eb)
+{
+	lockdep_assert_held(&eb->refs_lock);
+
+	WARN_ON(atomic_read(&eb->refs) == 0);
+	if (atomic_dec_and_test(&eb->refs)) {
+		if (test_and_clear_bit(EXTENT_BUFFER_IN_TREE, &eb->bflags)) {
+			struct btrfs_fs_info *fs_info = eb->fs_info;
+
+			spin_unlock(&eb->refs_lock);
+
+			spin_lock(&fs_info->buffer_lock);
+			radix_tree_delete(&fs_info->buffer_radix,
+					  eb->start >> PAGE_SHIFT);
+			spin_unlock(&fs_info->buffer_lock);
+		} else {
+			spin_unlock(&eb->refs_lock);
+		}
+
+		/* Should be safe to release our pages at this point */
+		btrfs_release_extent_buffer_pages(eb);
+#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
+		if (unlikely(test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags))) {
+			__free_extent_buffer(eb);
+			return 1;
+		}
+#endif
+		call_rcu(&eb->rcu_head, btrfs_release_extent_buffer_rcu);
+		return 1;
+	}
+	spin_unlock(&eb->refs_lock);
+
+	return 0;
+}
+
+void free_extent_buffer(struct extent_buffer *eb)
+{
+	int refs;
+	int old;
+	if (!eb)
+		return;
+
+	while (1) {
+		refs = atomic_read(&eb->refs);
+		if ((!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags) && refs <= 3)
+		    || (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags) &&
+			refs == 1))
+			break;
+		old = atomic_cmpxchg(&eb->refs, refs, refs - 1);
+		if (old == refs)
+			return;
+	}
+
+	spin_lock(&eb->refs_lock);
+	if (atomic_read(&eb->refs) == 2 &&
+	    test_bit(EXTENT_BUFFER_STALE, &eb->bflags) &&
+	    !extent_buffer_under_io(eb) &&
+	    test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
+		atomic_dec(&eb->refs);
+
+	/*
+	 * I know this is terrible, but it's temporary until we stop tracking
+	 * the uptodate bits and such for the extent buffers.
+	 */
+	release_extent_buffer(eb);
+}
+
+void free_extent_buffer_stale(struct extent_buffer *eb)
+{
+	if (!eb)
+		return;
+
+	spin_lock(&eb->refs_lock);
+	set_bit(EXTENT_BUFFER_STALE, &eb->bflags);
+
+	if (atomic_read(&eb->refs) == 2 && !extent_buffer_under_io(eb) &&
+	    test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
+		atomic_dec(&eb->refs);
+	release_extent_buffer(eb);
+}
+
+void clear_extent_buffer_dirty(struct extent_buffer *eb)
+{
+	int i;
+	int num_pages;
+	struct page *page;
+
+	num_pages = num_extent_pages(eb);
+
+	for (i = 0; i < num_pages; i++) {
+		page = eb->pages[i];
+		if (!PageDirty(page))
+			continue;
+
+		lock_page(page);
+		WARN_ON(!PagePrivate(page));
+
+		clear_page_dirty_for_io(page);
+		xa_lock_irq(&page->mapping->i_pages);
+		if (!PageDirty(page))
+			__xa_clear_mark(&page->mapping->i_pages,
+					page_index(page), PAGECACHE_TAG_DIRTY);
+		xa_unlock_irq(&page->mapping->i_pages);
+		ClearPageError(page);
+		unlock_page(page);
+	}
+	WARN_ON(atomic_read(&eb->refs) == 0);
+}
+
+bool set_extent_buffer_dirty(struct extent_buffer *eb)
+{
+	int i;
+	int num_pages;
+	bool was_dirty;
+
+	check_buffer_tree_ref(eb);
+
+	was_dirty = test_and_set_bit(EXTENT_BUFFER_DIRTY, &eb->bflags);
+
+	num_pages = num_extent_pages(eb);
+	WARN_ON(atomic_read(&eb->refs) == 0);
+	WARN_ON(!test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags));
+
+	if (!was_dirty)
+		for (i = 0; i < num_pages; i++)
+			set_page_dirty(eb->pages[i]);
+
+#ifdef CONFIG_BTRFS_DEBUG
+	for (i = 0; i < num_pages; i++)
+		ASSERT(PageDirty(eb->pages[i]));
+#endif
+
+	return was_dirty;
+}
+
+void clear_extent_buffer_uptodate(struct extent_buffer *eb)
+{
+	int i;
+	struct page *page;
+	int num_pages;
+
+	clear_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
+	num_pages = num_extent_pages(eb);
+	for (i = 0; i < num_pages; i++) {
+		page = eb->pages[i];
+		if (page)
+			ClearPageUptodate(page);
+	}
+}
+
+void set_extent_buffer_uptodate(struct extent_buffer *eb)
+{
+	int i;
+	struct page *page;
+	int num_pages;
+
+	set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
+	num_pages = num_extent_pages(eb);
+	for (i = 0; i < num_pages; i++) {
+		page = eb->pages[i];
+		SetPageUptodate(page);
+	}
+}
+
+void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
+			unsigned long start, unsigned long len)
+{
+	size_t cur;
+	size_t offset;
+	struct page *page;
+	char *kaddr;
+	char *dst = (char *)dstv;
+	size_t start_offset = offset_in_page(eb->start);
+	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
+
+	if (start + len > eb->len) {
+		WARN(1, KERN_ERR "btrfs bad mapping eb start %llu len %lu, wanted %lu %lu\n",
+		     eb->start, eb->len, start, len);
+		memset(dst, 0, len);
+		return;
+	}
+
+	offset = offset_in_page(start_offset + start);
+
+	while (len > 0) {
+		page = eb->pages[i];
+
+		cur = min(len, (PAGE_SIZE - offset));
+		kaddr = page_address(page);
+		memcpy(dst, kaddr + offset, cur);
+
+		dst += cur;
+		len -= cur;
+		offset = 0;
+		i++;
+	}
+}
+
+int read_extent_buffer_to_user(const struct extent_buffer *eb,
+			       void __user *dstv,
+			       unsigned long start, unsigned long len)
+{
+	size_t cur;
+	size_t offset;
+	struct page *page;
+	char *kaddr;
+	char __user *dst = (char __user *)dstv;
+	size_t start_offset = offset_in_page(eb->start);
+	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
+	int ret = 0;
+
+	WARN_ON(start > eb->len);
+	WARN_ON(start + len > eb->start + eb->len);
+
+	offset = offset_in_page(start_offset + start);
+
+	while (len > 0) {
+		page = eb->pages[i];
+
+		cur = min(len, (PAGE_SIZE - offset));
+		kaddr = page_address(page);
+		if (copy_to_user(dst, kaddr + offset, cur)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		dst += cur;
+		len -= cur;
+		offset = 0;
+		i++;
+	}
+
+	return ret;
+}
+
+/*
+ * return 0 if the item is found within a page.
+ * return 1 if the item spans two pages.
+ * return -EINVAL otherwise.
+ */
+int map_private_extent_buffer(const struct extent_buffer *eb,
+			      unsigned long start, unsigned long min_len,
+			      char **map, unsigned long *map_start,
+			      unsigned long *map_len)
+{
+	size_t offset;
+	char *kaddr;
+	struct page *p;
+	size_t start_offset = offset_in_page(eb->start);
+	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
+	unsigned long end_i = (start_offset + start + min_len - 1) >>
+		PAGE_SHIFT;
+
+	if (start + min_len > eb->len) {
+		WARN(1, KERN_ERR "btrfs bad mapping eb start %llu len %lu, wanted %lu %lu\n",
+		       eb->start, eb->len, start, min_len);
+		return -EINVAL;
+	}
+
+	if (i != end_i)
+		return 1;
+
+	if (i == 0) {
+		offset = start_offset;
+		*map_start = 0;
+	} else {
+		offset = 0;
+		*map_start = ((u64)i << PAGE_SHIFT) - start_offset;
+	}
+
+	p = eb->pages[i];
+	kaddr = page_address(p);
+	*map = kaddr + offset;
+	*map_len = PAGE_SIZE - offset;
+	return 0;
+}
+
+int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
+			 unsigned long start, unsigned long len)
+{
+	size_t cur;
+	size_t offset;
+	struct page *page;
+	char *kaddr;
+	char *ptr = (char *)ptrv;
+	size_t start_offset = offset_in_page(eb->start);
+	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
+	int ret = 0;
+
+	WARN_ON(start > eb->len);
+	WARN_ON(start + len > eb->start + eb->len);
+
+	offset = offset_in_page(start_offset + start);
+
+	while (len > 0) {
+		page = eb->pages[i];
+
+		cur = min(len, (PAGE_SIZE - offset));
+
+		kaddr = page_address(page);
+		ret = memcmp(ptr, kaddr + offset, cur);
+		if (ret)
+			break;
+
+		ptr += cur;
+		len -= cur;
+		offset = 0;
+		i++;
+	}
+	return ret;
+}
+
+void write_extent_buffer_chunk_tree_uuid(struct extent_buffer *eb,
+		const void *srcv)
+{
+	char *kaddr;
+
+	WARN_ON(!PageUptodate(eb->pages[0]));
+	kaddr = page_address(eb->pages[0]);
+	memcpy(kaddr + offsetof(struct btrfs_header, chunk_tree_uuid), srcv,
+			BTRFS_FSID_SIZE);
+}
+
+void write_extent_buffer_fsid(struct extent_buffer *eb, const void *srcv)
+{
+	char *kaddr;
+
+	WARN_ON(!PageUptodate(eb->pages[0]));
+	kaddr = page_address(eb->pages[0]);
+	memcpy(kaddr + offsetof(struct btrfs_header, fsid), srcv,
+			BTRFS_FSID_SIZE);
+}
+
+void write_extent_buffer(struct extent_buffer *eb, const void *srcv,
+			 unsigned long start, unsigned long len)
+{
+	size_t cur;
+	size_t offset;
+	struct page *page;
+	char *kaddr;
+	char *src = (char *)srcv;
+	size_t start_offset = offset_in_page(eb->start);
+	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
+
+	WARN_ON(start > eb->len);
+	WARN_ON(start + len > eb->start + eb->len);
+
+	offset = offset_in_page(start_offset + start);
+
+	while (len > 0) {
+		page = eb->pages[i];
+		WARN_ON(!PageUptodate(page));
+
+		cur = min(len, PAGE_SIZE - offset);
+		kaddr = page_address(page);
+		memcpy(kaddr + offset, src, cur);
+
+		src += cur;
+		len -= cur;
+		offset = 0;
+		i++;
+	}
+}
+
+void memzero_extent_buffer(struct extent_buffer *eb, unsigned long start,
+		unsigned long len)
+{
+	size_t cur;
+	size_t offset;
+	struct page *page;
+	char *kaddr;
+	size_t start_offset = offset_in_page(eb->start);
+	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
+
+	WARN_ON(start > eb->len);
+	WARN_ON(start + len > eb->start + eb->len);
+
+	offset = offset_in_page(start_offset + start);
+
+	while (len > 0) {
+		page = eb->pages[i];
+		WARN_ON(!PageUptodate(page));
+
+		cur = min(len, PAGE_SIZE - offset);
+		kaddr = page_address(page);
+		memset(kaddr + offset, 0, cur);
+
+		len -= cur;
+		offset = 0;
+		i++;
+	}
+}
+
+void copy_extent_buffer_full(struct extent_buffer *dst,
+			     struct extent_buffer *src)
+{
+	int i;
+	int num_pages;
+
+	ASSERT(dst->len == src->len);
+
+	num_pages = num_extent_pages(dst);
+	for (i = 0; i < num_pages; i++)
+		copy_page(page_address(dst->pages[i]),
+				page_address(src->pages[i]));
+}
+
+void copy_extent_buffer(struct extent_buffer *dst, struct extent_buffer *src,
+			unsigned long dst_offset, unsigned long src_offset,
+			unsigned long len)
+{
+	u64 dst_len = dst->len;
+	size_t cur;
+	size_t offset;
+	struct page *page;
+	char *kaddr;
+	size_t start_offset = offset_in_page(dst->start);
+	unsigned long i = (start_offset + dst_offset) >> PAGE_SHIFT;
+
+	WARN_ON(src->len != dst_len);
+
+	offset = offset_in_page(start_offset + dst_offset);
+
+	while (len > 0) {
+		page = dst->pages[i];
+		WARN_ON(!PageUptodate(page));
+
+		cur = min(len, (unsigned long)(PAGE_SIZE - offset));
+
+		kaddr = page_address(page);
+		read_extent_buffer(src, kaddr + offset, src_offset, cur);
+
+		src_offset += cur;
+		len -= cur;
+		offset = 0;
+		i++;
+	}
+}
+
+/*
+ * eb_bitmap_offset() - calculate the page and offset of the byte containing the
+ * given bit number
+ * @eb: the extent buffer
+ * @start: offset of the bitmap item in the extent buffer
+ * @nr: bit number
+ * @page_index: return index of the page in the extent buffer that contains the
+ * given bit number
+ * @page_offset: return offset into the page given by page_index
+ *
+ * This helper hides the ugliness of finding the byte in an extent buffer which
+ * contains a given bit.
+ */
+static inline void eb_bitmap_offset(struct extent_buffer *eb,
+				    unsigned long start, unsigned long nr,
+				    unsigned long *page_index,
+				    size_t *page_offset)
+{
+	size_t start_offset = offset_in_page(eb->start);
+	size_t byte_offset = BIT_BYTE(nr);
+	size_t offset;
+
+	/*
+	 * The byte we want is the offset of the extent buffer + the offset of
+	 * the bitmap item in the extent buffer + the offset of the byte in the
+	 * bitmap item.
+	 */
+	offset = start_offset + start + byte_offset;
+
+	*page_index = offset >> PAGE_SHIFT;
+	*page_offset = offset_in_page(offset);
+}
+
+/**
+ * extent_buffer_test_bit - determine whether a bit in a bitmap item is set
+ * @eb: the extent buffer
+ * @start: offset of the bitmap item in the extent buffer
+ * @nr: bit number to test
+ */
+int extent_buffer_test_bit(struct extent_buffer *eb, unsigned long start,
+			   unsigned long nr)
+{
+	u8 *kaddr;
+	struct page *page;
+	unsigned long i;
+	size_t offset;
+
+	eb_bitmap_offset(eb, start, nr, &i, &offset);
+	page = eb->pages[i];
+	WARN_ON(!PageUptodate(page));
+	kaddr = page_address(page);
+	return 1U & (kaddr[offset] >> (nr & (BITS_PER_BYTE - 1)));
+}
+
+/**
+ * extent_buffer_bitmap_set - set an area of a bitmap
+ * @eb: the extent buffer
+ * @start: offset of the bitmap item in the extent buffer
+ * @pos: bit number of the first bit
+ * @len: number of bits to set
+ */
+void extent_buffer_bitmap_set(struct extent_buffer *eb, unsigned long start,
+			      unsigned long pos, unsigned long len)
+{
+	u8 *kaddr;
+	struct page *page;
+	unsigned long i;
+	size_t offset;
+	const unsigned int size = pos + len;
+	int bits_to_set = BITS_PER_BYTE - (pos % BITS_PER_BYTE);
+	u8 mask_to_set = BITMAP_FIRST_BYTE_MASK(pos);
+
+	eb_bitmap_offset(eb, start, pos, &i, &offset);
+	page = eb->pages[i];
+	WARN_ON(!PageUptodate(page));
+	kaddr = page_address(page);
+
+	while (len >= bits_to_set) {
+		kaddr[offset] |= mask_to_set;
+		len -= bits_to_set;
+		bits_to_set = BITS_PER_BYTE;
+		mask_to_set = ~0;
+		if (++offset >= PAGE_SIZE && len > 0) {
+			offset = 0;
+			page = eb->pages[++i];
+			WARN_ON(!PageUptodate(page));
+			kaddr = page_address(page);
+		}
+	}
+	if (len) {
+		mask_to_set &= BITMAP_LAST_BYTE_MASK(size);
+		kaddr[offset] |= mask_to_set;
+	}
+}
+
+
+/**
+ * extent_buffer_bitmap_clear - clear an area of a bitmap
+ * @eb: the extent buffer
+ * @start: offset of the bitmap item in the extent buffer
+ * @pos: bit number of the first bit
+ * @len: number of bits to clear
+ */
+void extent_buffer_bitmap_clear(struct extent_buffer *eb, unsigned long start,
+				unsigned long pos, unsigned long len)
+{
+	u8 *kaddr;
+	struct page *page;
+	unsigned long i;
+	size_t offset;
+	const unsigned int size = pos + len;
+	int bits_to_clear = BITS_PER_BYTE - (pos % BITS_PER_BYTE);
+	u8 mask_to_clear = BITMAP_FIRST_BYTE_MASK(pos);
+
+	eb_bitmap_offset(eb, start, pos, &i, &offset);
+	page = eb->pages[i];
+	WARN_ON(!PageUptodate(page));
+	kaddr = page_address(page);
+
+	while (len >= bits_to_clear) {
+		kaddr[offset] &= ~mask_to_clear;
+		len -= bits_to_clear;
+		bits_to_clear = BITS_PER_BYTE;
+		mask_to_clear = ~0;
+		if (++offset >= PAGE_SIZE && len > 0) {
+			offset = 0;
+			page = eb->pages[++i];
+			WARN_ON(!PageUptodate(page));
+			kaddr = page_address(page);
+		}
+	}
+	if (len) {
+		mask_to_clear &= BITMAP_LAST_BYTE_MASK(size);
+		kaddr[offset] &= ~mask_to_clear;
+	}
+}
+
+static inline bool areas_overlap(unsigned long src, unsigned long dst, unsigned long len)
+{
+	unsigned long distance = (src > dst) ? src - dst : dst - src;
+	return distance < len;
+}
+
+static void copy_pages(struct page *dst_page, struct page *src_page,
+		       unsigned long dst_off, unsigned long src_off,
+		       unsigned long len)
+{
+	char *dst_kaddr = page_address(dst_page);
+	char *src_kaddr;
+	int must_memmove = 0;
+
+	if (dst_page != src_page) {
+		src_kaddr = page_address(src_page);
+	} else {
+		src_kaddr = dst_kaddr;
+		if (areas_overlap(src_off, dst_off, len))
+			must_memmove = 1;
+	}
+
+	if (must_memmove)
+		memmove(dst_kaddr + dst_off, src_kaddr + src_off, len);
+	else
+		memcpy(dst_kaddr + dst_off, src_kaddr + src_off, len);
+}
+
+void memcpy_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
+			   unsigned long src_offset, unsigned long len)
+{
+	struct btrfs_fs_info *fs_info = dst->fs_info;
+	size_t cur;
+	size_t dst_off_in_page;
+	size_t src_off_in_page;
+	size_t start_offset = offset_in_page(dst->start);
+	unsigned long dst_i;
+	unsigned long src_i;
+
+	if (src_offset + len > dst->len) {
+		btrfs_err(fs_info,
+			"memmove bogus src_offset %lu move len %lu dst len %lu",
+			 src_offset, len, dst->len);
+		BUG();
+	}
+	if (dst_offset + len > dst->len) {
+		btrfs_err(fs_info,
+			"memmove bogus dst_offset %lu move len %lu dst len %lu",
+			 dst_offset, len, dst->len);
+		BUG();
+	}
+
+	while (len > 0) {
+		dst_off_in_page = offset_in_page(start_offset + dst_offset);
+		src_off_in_page = offset_in_page(start_offset + src_offset);
+
+		dst_i = (start_offset + dst_offset) >> PAGE_SHIFT;
+		src_i = (start_offset + src_offset) >> PAGE_SHIFT;
+
+		cur = min(len, (unsigned long)(PAGE_SIZE -
+					       src_off_in_page));
+		cur = min_t(unsigned long, cur,
+			(unsigned long)(PAGE_SIZE - dst_off_in_page));
+
+		copy_pages(dst->pages[dst_i], dst->pages[src_i],
+			   dst_off_in_page, src_off_in_page, cur);
+
+		src_offset += cur;
+		dst_offset += cur;
+		len -= cur;
+	}
+}
+
+void memmove_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
+			   unsigned long src_offset, unsigned long len)
+{
+	struct btrfs_fs_info *fs_info = dst->fs_info;
+	size_t cur;
+	size_t dst_off_in_page;
+	size_t src_off_in_page;
+	unsigned long dst_end = dst_offset + len - 1;
+	unsigned long src_end = src_offset + len - 1;
+	size_t start_offset = offset_in_page(dst->start);
+	unsigned long dst_i;
+	unsigned long src_i;
+
+	if (src_offset + len > dst->len) {
+		btrfs_err(fs_info,
+			  "memmove bogus src_offset %lu move len %lu len %lu",
+			  src_offset, len, dst->len);
+		BUG();
+	}
+	if (dst_offset + len > dst->len) {
+		btrfs_err(fs_info,
+			  "memmove bogus dst_offset %lu move len %lu len %lu",
+			  dst_offset, len, dst->len);
+		BUG();
+	}
+	if (dst_offset < src_offset) {
+		memcpy_extent_buffer(dst, dst_offset, src_offset, len);
+		return;
+	}
+	while (len > 0) {
+		dst_i = (start_offset + dst_end) >> PAGE_SHIFT;
+		src_i = (start_offset + src_end) >> PAGE_SHIFT;
+
+		dst_off_in_page = offset_in_page(start_offset + dst_end);
+		src_off_in_page = offset_in_page(start_offset + src_end);
+
+		cur = min_t(unsigned long, len, src_off_in_page + 1);
+		cur = min(cur, dst_off_in_page + 1);
+		copy_pages(dst->pages[dst_i], dst->pages[src_i],
+			   dst_off_in_page - cur + 1,
+			   src_off_in_page - cur + 1, cur);
+
+		dst_end -= cur;
+		src_end -= cur;
+		len -= cur;
+	}
+}
+
+int try_release_extent_buffer(struct page *page)
+{
+	struct extent_buffer *eb;
+
+	/*
+	 * We need to make sure nobody is attaching this page to an eb right
+	 * now.
+	 */
+	spin_lock(&page->mapping->private_lock);
+	if (!PagePrivate(page)) {
+		spin_unlock(&page->mapping->private_lock);
+		return 1;
+	}
+
+	eb = (struct extent_buffer *)page->private;
+	BUG_ON(!eb);
+
+	/*
+	 * This is a little awful but should be ok, we need to make sure that
+	 * the eb doesn't disappear out from under us while we're looking at
+	 * this page.
+	 */
+	spin_lock(&eb->refs_lock);
+	if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
+		spin_unlock(&eb->refs_lock);
+		spin_unlock(&page->mapping->private_lock);
+		return 0;
+	}
+	spin_unlock(&page->mapping->private_lock);
+
+	/*
+	 * If tree ref isn't set then we know the ref on this eb is a real ref,
+	 * so just return, this page will likely be freed soon anyway.
+	 */
+	if (!test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags)) {
+		spin_unlock(&eb->refs_lock);
+		return 0;
+	}
+
+	return release_extent_buffer(eb);
+}
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d8acf5df35e7..4ac356e849b7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -25,51 +25,8 @@
 #include "backref.h"
 #include "disk-io.h"
 
-static struct kmem_cache *extent_buffer_cache;
 static struct bio_set btrfs_bioset;
 
-#ifdef CONFIG_BTRFS_DEBUG
-static LIST_HEAD(buffers);
-
-static DEFINE_SPINLOCK(leak_lock);
-
-static inline
-void btrfs_leak_debug_add(struct list_head *new, struct list_head *head)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&leak_lock, flags);
-	list_add(new, head);
-	spin_unlock_irqrestore(&leak_lock, flags);
-}
-
-static inline
-void btrfs_leak_debug_del(struct list_head *entry)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&leak_lock, flags);
-	list_del(entry);
-	spin_unlock_irqrestore(&leak_lock, flags);
-}
-
-static inline
-void btrfs_extent_buffer_leak_debug_check()
-{
-	while (!list_empty(&buffers)) {
-		eb = list_entry(buffers.next, struct extent_buffer, leak_list);
-		pr_err("BTRFS: buffer leak start %llu len %lu refs %d bflags %lu\n",
-		       eb->start, eb->len, atomic_read(&eb->refs), eb->bflags);
-		list_del(&eb->leak_list);
-		kmem_cache_free(extent_buffer_cache, eb);
-	}
-}
-#else
-#define btrfs_leak_debug_add(new, head)	do {} while (0)
-#define btrfs_leak_debug_del(entry)	do {} while (0)
-#define btrfs_extent_buffer_leak_debug_check()	do {} while (0)
-#endif
-
 struct extent_page_data {
 	struct bio *bio;
 	struct extent_io_tree *tree;
@@ -148,28 +105,6 @@ int __init extent_io_init(void)
 	return 0;
 }
 
-int __init extent_buffer_init(void)
-{
-	extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
-			sizeof(struct extent_buffer), 0,
-			SLAB_MEM_SPREAD, NULL);
-	if (!extent_buffer_cache)
-		return -ENOMEM;
-	return 0;
-}
-
-void __cold extent_buffer_exit(void)
-{
-	btrfs_extent_buffer_leak_debug_check();
-
-	/*
-	 * Make sure all delayed rcu free are flushed before we
-	 * destroy caches.
-	 */
-	rcu_barrier();
-	kmem_cache_destroy(extent_buffer_cache);
-}
-
 void __cold extent_io_exit(void)
 {
 	bioset_exit(&btrfs_bioset);
@@ -1089,18 +1024,6 @@ static int submit_extent_page(unsigned int opf, struct extent_io_tree *tree,
 	return ret;
 }
 
-static void attach_extent_buffer_page(struct extent_buffer *eb,
-				      struct page *page)
-{
-	if (!PagePrivate(page)) {
-		SetPagePrivate(page);
-		get_page(page);
-		set_page_private(page, (unsigned long)eb);
-	} else {
-		WARN_ON(page->private != (unsigned long)eb);
-	}
-}
-
 void set_page_extent_mapped(struct page *page)
 {
 	if (!PagePrivate(page)) {
@@ -1718,12 +1641,6 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	return 0;
 }
 
-void wait_on_extent_buffer_writeback(struct extent_buffer *eb)
-{
-	wait_on_bit_io(&eb->bflags, EXTENT_BUFFER_WRITEBACK,
-		       TASK_UNINTERRUPTIBLE);
-}
-
 /*
  * Lock eb pages and flush the bio if we can't the locks
  *
@@ -2867,603 +2784,6 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	return ret;
 }
 
-static void __free_extent_buffer(struct extent_buffer *eb)
-{
-	btrfs_leak_debug_del(&eb->leak_list);
-	kmem_cache_free(extent_buffer_cache, eb);
-}
-
-int extent_buffer_under_io(struct extent_buffer *eb)
-{
-	return (atomic_read(&eb->io_pages) ||
-		test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags) ||
-		test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
-}
-
-/*
- * Release all pages attached to the extent buffer.
- */
-static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
-{
-	int i;
-	int num_pages;
-	int mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
-
-	BUG_ON(extent_buffer_under_io(eb));
-
-	num_pages = num_extent_pages(eb);
-	for (i = 0; i < num_pages; i++) {
-		struct page *page = eb->pages[i];
-
-		if (!page)
-			continue;
-		if (mapped)
-			spin_lock(&page->mapping->private_lock);
-		/*
-		 * We do this since we'll remove the pages after we've
-		 * removed the eb from the radix tree, so we could race
-		 * and have this page now attached to the new eb.  So
-		 * only clear page_private if it's still connected to
-		 * this eb.
-		 */
-		if (PagePrivate(page) &&
-		    page->private == (unsigned long)eb) {
-			BUG_ON(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
-			BUG_ON(PageDirty(page));
-			BUG_ON(PageWriteback(page));
-			/*
-			 * We need to make sure we haven't be attached
-			 * to a new eb.
-			 */
-			ClearPagePrivate(page);
-			set_page_private(page, 0);
-			/* One for the page private */
-			put_page(page);
-		}
-
-		if (mapped)
-			spin_unlock(&page->mapping->private_lock);
-
-		/* One for when we allocated the page */
-		put_page(page);
-	}
-}
-
-/*
- * Helper for releasing the extent buffer.
- */
-static inline void btrfs_release_extent_buffer(struct extent_buffer *eb)
-{
-	btrfs_release_extent_buffer_pages(eb);
-	__free_extent_buffer(eb);
-}
-
-static struct extent_buffer *
-__alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
-		      unsigned long len)
-{
-	struct extent_buffer *eb = NULL;
-
-	eb = kmem_cache_zalloc(extent_buffer_cache, GFP_NOFS|__GFP_NOFAIL);
-	eb->start = start;
-	eb->len = len;
-	eb->fs_info = fs_info;
-	eb->bflags = 0;
-	rwlock_init(&eb->lock);
-	atomic_set(&eb->blocking_readers, 0);
-	eb->blocking_writers = 0;
-	eb->lock_nested = false;
-	init_waitqueue_head(&eb->write_lock_wq);
-	init_waitqueue_head(&eb->read_lock_wq);
-
-	btrfs_leak_debug_add(&eb->leak_list, &buffers);
-
-	spin_lock_init(&eb->refs_lock);
-	atomic_set(&eb->refs, 1);
-	atomic_set(&eb->io_pages, 0);
-
-	/*
-	 * Sanity checks, currently the maximum is 64k covered by 16x 4k pages
-	 */
-	BUILD_BUG_ON(BTRFS_MAX_METADATA_BLOCKSIZE
-		> MAX_INLINE_EXTENT_BUFFER_SIZE);
-	BUG_ON(len > MAX_INLINE_EXTENT_BUFFER_SIZE);
-
-#ifdef CONFIG_BTRFS_DEBUG
-	eb->spinning_writers = 0;
-	atomic_set(&eb->spinning_readers, 0);
-	atomic_set(&eb->read_locks, 0);
-	eb->write_locks = 0;
-#endif
-
-	return eb;
-}
-
-struct extent_buffer *btrfs_clone_extent_buffer(struct extent_buffer *src)
-{
-	int i;
-	struct page *p;
-	struct extent_buffer *new;
-	int num_pages = num_extent_pages(src);
-
-	new = __alloc_extent_buffer(src->fs_info, src->start, src->len);
-	if (new == NULL)
-		return NULL;
-
-	for (i = 0; i < num_pages; i++) {
-		p = alloc_page(GFP_NOFS);
-		if (!p) {
-			btrfs_release_extent_buffer(new);
-			return NULL;
-		}
-		attach_extent_buffer_page(new, p);
-		WARN_ON(PageDirty(p));
-		SetPageUptodate(p);
-		new->pages[i] = p;
-		copy_page(page_address(p), page_address(src->pages[i]));
-	}
-
-	set_bit(EXTENT_BUFFER_UPTODATE, &new->bflags);
-	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
-
-	return new;
-}
-
-struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
-						  u64 start, unsigned long len)
-{
-	struct extent_buffer *eb;
-	int num_pages;
-	int i;
-
-	eb = __alloc_extent_buffer(fs_info, start, len);
-	if (!eb)
-		return NULL;
-
-	num_pages = num_extent_pages(eb);
-	for (i = 0; i < num_pages; i++) {
-		eb->pages[i] = alloc_page(GFP_NOFS);
-		if (!eb->pages[i])
-			goto err;
-	}
-	set_extent_buffer_uptodate(eb);
-	btrfs_set_header_nritems(eb, 0);
-	set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
-
-	return eb;
-err:
-	for (; i > 0; i--)
-		__free_page(eb->pages[i - 1]);
-	__free_extent_buffer(eb);
-	return NULL;
-}
-
-struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
-						u64 start)
-{
-	return __alloc_dummy_extent_buffer(fs_info, start, fs_info->nodesize);
-}
-
-static void check_buffer_tree_ref(struct extent_buffer *eb)
-{
-	int refs;
-	/* the ref bit is tricky.  We have to make sure it is set
-	 * if we have the buffer dirty.   Otherwise the
-	 * code to free a buffer can end up dropping a dirty
-	 * page
-	 *
-	 * Once the ref bit is set, it won't go away while the
-	 * buffer is dirty or in writeback, and it also won't
-	 * go away while we have the reference count on the
-	 * eb bumped.
-	 *
-	 * We can't just set the ref bit without bumping the
-	 * ref on the eb because free_extent_buffer might
-	 * see the ref bit and try to clear it.  If this happens
-	 * free_extent_buffer might end up dropping our original
-	 * ref by mistake and freeing the page before we are able
-	 * to add one more ref.
-	 *
-	 * So bump the ref count first, then set the bit.  If someone
-	 * beat us to it, drop the ref we added.
-	 */
-	refs = atomic_read(&eb->refs);
-	if (refs >= 2 && test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
-		return;
-
-	spin_lock(&eb->refs_lock);
-	if (!test_and_set_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
-		atomic_inc(&eb->refs);
-	spin_unlock(&eb->refs_lock);
-}
-
-static void mark_extent_buffer_accessed(struct extent_buffer *eb,
-		struct page *accessed)
-{
-	int num_pages, i;
-
-	check_buffer_tree_ref(eb);
-
-	num_pages = num_extent_pages(eb);
-	for (i = 0; i < num_pages; i++) {
-		struct page *p = eb->pages[i];
-
-		if (p != accessed)
-			mark_page_accessed(p);
-	}
-}
-
-struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
-					 u64 start)
-{
-	struct extent_buffer *eb;
-
-	rcu_read_lock();
-	eb = radix_tree_lookup(&fs_info->buffer_radix,
-			       start >> PAGE_SHIFT);
-	if (eb && atomic_inc_not_zero(&eb->refs)) {
-		rcu_read_unlock();
-		/*
-		 * Lock our eb's refs_lock to avoid races with
-		 * free_extent_buffer. When we get our eb it might be flagged
-		 * with EXTENT_BUFFER_STALE and another task running
-		 * free_extent_buffer might have seen that flag set,
-		 * eb->refs == 2, that the buffer isn't under IO (dirty and
-		 * writeback flags not set) and it's still in the tree (flag
-		 * EXTENT_BUFFER_TREE_REF set), therefore being in the process
-		 * of decrementing the extent buffer's reference count twice.
-		 * So here we could race and increment the eb's reference count,
-		 * clear its stale flag, mark it as dirty and drop our reference
-		 * before the other task finishes executing free_extent_buffer,
-		 * which would later result in an attempt to free an extent
-		 * buffer that is dirty.
-		 */
-		if (test_bit(EXTENT_BUFFER_STALE, &eb->bflags)) {
-			spin_lock(&eb->refs_lock);
-			spin_unlock(&eb->refs_lock);
-		}
-		mark_extent_buffer_accessed(eb, NULL);
-		return eb;
-	}
-	rcu_read_unlock();
-
-	return NULL;
-}
-
-#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
-					u64 start)
-{
-	struct extent_buffer *eb, *exists = NULL;
-	int ret;
-
-	eb = find_extent_buffer(fs_info, start);
-	if (eb)
-		return eb;
-	eb = alloc_dummy_extent_buffer(fs_info, start);
-	if (!eb)
-		return NULL;
-	eb->fs_info = fs_info;
-again:
-	ret = radix_tree_preload(GFP_NOFS);
-	if (ret)
-		goto free_eb;
-	spin_lock(&fs_info->buffer_lock);
-	ret = radix_tree_insert(&fs_info->buffer_radix,
-				start >> PAGE_SHIFT, eb);
-	spin_unlock(&fs_info->buffer_lock);
-	radix_tree_preload_end();
-	if (ret == -EEXIST) {
-		exists = find_extent_buffer(fs_info, start);
-		if (exists)
-			goto free_eb;
-		else
-			goto again;
-	}
-	check_buffer_tree_ref(eb);
-	set_bit(EXTENT_BUFFER_IN_TREE, &eb->bflags);
-
-	return eb;
-free_eb:
-	btrfs_release_extent_buffer(eb);
-	return exists;
-}
-#endif
-
-struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
-					  u64 start)
-{
-	unsigned long len = fs_info->nodesize;
-	int num_pages;
-	int i;
-	unsigned long index = start >> PAGE_SHIFT;
-	struct extent_buffer *eb;
-	struct extent_buffer *exists = NULL;
-	struct page *p;
-	struct address_space *mapping = fs_info->btree_inode->i_mapping;
-	int uptodate = 1;
-	int ret;
-
-	if (!IS_ALIGNED(start, fs_info->sectorsize)) {
-		btrfs_err(fs_info, "bad tree block start %llu", start);
-		return ERR_PTR(-EINVAL);
-	}
-
-	eb = find_extent_buffer(fs_info, start);
-	if (eb)
-		return eb;
-
-	eb = __alloc_extent_buffer(fs_info, start, len);
-	if (!eb)
-		return ERR_PTR(-ENOMEM);
-
-	num_pages = num_extent_pages(eb);
-	for (i = 0; i < num_pages; i++, index++) {
-		p = find_or_create_page(mapping, index, GFP_NOFS|__GFP_NOFAIL);
-		if (!p) {
-			exists = ERR_PTR(-ENOMEM);
-			goto free_eb;
-		}
-
-		spin_lock(&mapping->private_lock);
-		if (PagePrivate(p)) {
-			/*
-			 * We could have already allocated an eb for this page
-			 * and attached one so lets see if we can get a ref on
-			 * the existing eb, and if we can we know it's good and
-			 * we can just return that one, else we know we can just
-			 * overwrite page->private.
-			 */
-			exists = (struct extent_buffer *)p->private;
-			if (atomic_inc_not_zero(&exists->refs)) {
-				spin_unlock(&mapping->private_lock);
-				unlock_page(p);
-				put_page(p);
-				mark_extent_buffer_accessed(exists, p);
-				goto free_eb;
-			}
-			exists = NULL;
-
-			/*
-			 * Do this so attach doesn't complain and we need to
-			 * drop the ref the old guy had.
-			 */
-			ClearPagePrivate(p);
-			WARN_ON(PageDirty(p));
-			put_page(p);
-		}
-		attach_extent_buffer_page(eb, p);
-		spin_unlock(&mapping->private_lock);
-		WARN_ON(PageDirty(p));
-		eb->pages[i] = p;
-		if (!PageUptodate(p))
-			uptodate = 0;
-
-		/*
-		 * We can't unlock the pages just yet since the extent buffer
-		 * hasn't been properly inserted in the radix tree, this
-		 * opens a race with btree_releasepage which can free a page
-		 * while we are still filling in all pages for the buffer and
-		 * we could crash.
-		 */
-	}
-	if (uptodate)
-		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
-again:
-	ret = radix_tree_preload(GFP_NOFS);
-	if (ret) {
-		exists = ERR_PTR(ret);
-		goto free_eb;
-	}
-
-	spin_lock(&fs_info->buffer_lock);
-	ret = radix_tree_insert(&fs_info->buffer_radix,
-				start >> PAGE_SHIFT, eb);
-	spin_unlock(&fs_info->buffer_lock);
-	radix_tree_preload_end();
-	if (ret == -EEXIST) {
-		exists = find_extent_buffer(fs_info, start);
-		if (exists)
-			goto free_eb;
-		else
-			goto again;
-	}
-	/* add one reference for the tree */
-	check_buffer_tree_ref(eb);
-	set_bit(EXTENT_BUFFER_IN_TREE, &eb->bflags);
-
-	/*
-	 * Now it's safe to unlock the pages because any calls to
-	 * btree_releasepage will correctly detect that a page belongs to a
-	 * live buffer and won't free them prematurely.
-	 */
-	for (i = 0; i < num_pages; i++)
-		unlock_page(eb->pages[i]);
-	return eb;
-
-free_eb:
-	WARN_ON(!atomic_dec_and_test(&eb->refs));
-	for (i = 0; i < num_pages; i++) {
-		if (eb->pages[i])
-			unlock_page(eb->pages[i]);
-	}
-
-	btrfs_release_extent_buffer(eb);
-	return exists;
-}
-
-static inline void btrfs_release_extent_buffer_rcu(struct rcu_head *head)
-{
-	struct extent_buffer *eb =
-			container_of(head, struct extent_buffer, rcu_head);
-
-	__free_extent_buffer(eb);
-}
-
-static int release_extent_buffer(struct extent_buffer *eb)
-{
-	lockdep_assert_held(&eb->refs_lock);
-
-	WARN_ON(atomic_read(&eb->refs) == 0);
-	if (atomic_dec_and_test(&eb->refs)) {
-		if (test_and_clear_bit(EXTENT_BUFFER_IN_TREE, &eb->bflags)) {
-			struct btrfs_fs_info *fs_info = eb->fs_info;
-
-			spin_unlock(&eb->refs_lock);
-
-			spin_lock(&fs_info->buffer_lock);
-			radix_tree_delete(&fs_info->buffer_radix,
-					  eb->start >> PAGE_SHIFT);
-			spin_unlock(&fs_info->buffer_lock);
-		} else {
-			spin_unlock(&eb->refs_lock);
-		}
-
-		/* Should be safe to release our pages at this point */
-		btrfs_release_extent_buffer_pages(eb);
-#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-		if (unlikely(test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags))) {
-			__free_extent_buffer(eb);
-			return 1;
-		}
-#endif
-		call_rcu(&eb->rcu_head, btrfs_release_extent_buffer_rcu);
-		return 1;
-	}
-	spin_unlock(&eb->refs_lock);
-
-	return 0;
-}
-
-void free_extent_buffer(struct extent_buffer *eb)
-{
-	int refs;
-	int old;
-	if (!eb)
-		return;
-
-	while (1) {
-		refs = atomic_read(&eb->refs);
-		if ((!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags) && refs <= 3)
-		    || (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags) &&
-			refs == 1))
-			break;
-		old = atomic_cmpxchg(&eb->refs, refs, refs - 1);
-		if (old == refs)
-			return;
-	}
-
-	spin_lock(&eb->refs_lock);
-	if (atomic_read(&eb->refs) == 2 &&
-	    test_bit(EXTENT_BUFFER_STALE, &eb->bflags) &&
-	    !extent_buffer_under_io(eb) &&
-	    test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
-		atomic_dec(&eb->refs);
-
-	/*
-	 * I know this is terrible, but it's temporary until we stop tracking
-	 * the uptodate bits and such for the extent buffers.
-	 */
-	release_extent_buffer(eb);
-}
-
-void free_extent_buffer_stale(struct extent_buffer *eb)
-{
-	if (!eb)
-		return;
-
-	spin_lock(&eb->refs_lock);
-	set_bit(EXTENT_BUFFER_STALE, &eb->bflags);
-
-	if (atomic_read(&eb->refs) == 2 && !extent_buffer_under_io(eb) &&
-	    test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
-		atomic_dec(&eb->refs);
-	release_extent_buffer(eb);
-}
-
-void clear_extent_buffer_dirty(struct extent_buffer *eb)
-{
-	int i;
-	int num_pages;
-	struct page *page;
-
-	num_pages = num_extent_pages(eb);
-
-	for (i = 0; i < num_pages; i++) {
-		page = eb->pages[i];
-		if (!PageDirty(page))
-			continue;
-
-		lock_page(page);
-		WARN_ON(!PagePrivate(page));
-
-		clear_page_dirty_for_io(page);
-		xa_lock_irq(&page->mapping->i_pages);
-		if (!PageDirty(page))
-			__xa_clear_mark(&page->mapping->i_pages,
-					page_index(page), PAGECACHE_TAG_DIRTY);
-		xa_unlock_irq(&page->mapping->i_pages);
-		ClearPageError(page);
-		unlock_page(page);
-	}
-	WARN_ON(atomic_read(&eb->refs) == 0);
-}
-
-bool set_extent_buffer_dirty(struct extent_buffer *eb)
-{
-	int i;
-	int num_pages;
-	bool was_dirty;
-
-	check_buffer_tree_ref(eb);
-
-	was_dirty = test_and_set_bit(EXTENT_BUFFER_DIRTY, &eb->bflags);
-
-	num_pages = num_extent_pages(eb);
-	WARN_ON(atomic_read(&eb->refs) == 0);
-	WARN_ON(!test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags));
-
-	if (!was_dirty)
-		for (i = 0; i < num_pages; i++)
-			set_page_dirty(eb->pages[i]);
-
-#ifdef CONFIG_BTRFS_DEBUG
-	for (i = 0; i < num_pages; i++)
-		ASSERT(PageDirty(eb->pages[i]));
-#endif
-
-	return was_dirty;
-}
-
-void clear_extent_buffer_uptodate(struct extent_buffer *eb)
-{
-	int i;
-	struct page *page;
-	int num_pages;
-
-	clear_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
-	num_pages = num_extent_pages(eb);
-	for (i = 0; i < num_pages; i++) {
-		page = eb->pages[i];
-		if (page)
-			ClearPageUptodate(page);
-	}
-}
-
-void set_extent_buffer_uptodate(struct extent_buffer *eb)
-{
-	int i;
-	struct page *page;
-	int num_pages;
-
-	set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
-	num_pages = num_extent_pages(eb);
-	for (i = 0; i < num_pages; i++) {
-		page = eb->pages[i];
-		SetPageUptodate(page);
-	}
-}
-
 int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 {
 	int i;
@@ -3571,578 +2891,3 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 	}
 	return ret;
 }
-
-void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
-			unsigned long start, unsigned long len)
-{
-	size_t cur;
-	size_t offset;
-	struct page *page;
-	char *kaddr;
-	char *dst = (char *)dstv;
-	size_t start_offset = offset_in_page(eb->start);
-	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
-
-	if (start + len > eb->len) {
-		WARN(1, KERN_ERR "btrfs bad mapping eb start %llu len %lu, wanted %lu %lu\n",
-		     eb->start, eb->len, start, len);
-		memset(dst, 0, len);
-		return;
-	}
-
-	offset = offset_in_page(start_offset + start);
-
-	while (len > 0) {
-		page = eb->pages[i];
-
-		cur = min(len, (PAGE_SIZE - offset));
-		kaddr = page_address(page);
-		memcpy(dst, kaddr + offset, cur);
-
-		dst += cur;
-		len -= cur;
-		offset = 0;
-		i++;
-	}
-}
-
-int read_extent_buffer_to_user(const struct extent_buffer *eb,
-			       void __user *dstv,
-			       unsigned long start, unsigned long len)
-{
-	size_t cur;
-	size_t offset;
-	struct page *page;
-	char *kaddr;
-	char __user *dst = (char __user *)dstv;
-	size_t start_offset = offset_in_page(eb->start);
-	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
-	int ret = 0;
-
-	WARN_ON(start > eb->len);
-	WARN_ON(start + len > eb->start + eb->len);
-
-	offset = offset_in_page(start_offset + start);
-
-	while (len > 0) {
-		page = eb->pages[i];
-
-		cur = min(len, (PAGE_SIZE - offset));
-		kaddr = page_address(page);
-		if (copy_to_user(dst, kaddr + offset, cur)) {
-			ret = -EFAULT;
-			break;
-		}
-
-		dst += cur;
-		len -= cur;
-		offset = 0;
-		i++;
-	}
-
-	return ret;
-}
-
-/*
- * return 0 if the item is found within a page.
- * return 1 if the item spans two pages.
- * return -EINVAL otherwise.
- */
-int map_private_extent_buffer(const struct extent_buffer *eb,
-			      unsigned long start, unsigned long min_len,
-			      char **map, unsigned long *map_start,
-			      unsigned long *map_len)
-{
-	size_t offset;
-	char *kaddr;
-	struct page *p;
-	size_t start_offset = offset_in_page(eb->start);
-	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
-	unsigned long end_i = (start_offset + start + min_len - 1) >>
-		PAGE_SHIFT;
-
-	if (start + min_len > eb->len) {
-		WARN(1, KERN_ERR "btrfs bad mapping eb start %llu len %lu, wanted %lu %lu\n",
-		       eb->start, eb->len, start, min_len);
-		return -EINVAL;
-	}
-
-	if (i != end_i)
-		return 1;
-
-	if (i == 0) {
-		offset = start_offset;
-		*map_start = 0;
-	} else {
-		offset = 0;
-		*map_start = ((u64)i << PAGE_SHIFT) - start_offset;
-	}
-
-	p = eb->pages[i];
-	kaddr = page_address(p);
-	*map = kaddr + offset;
-	*map_len = PAGE_SIZE - offset;
-	return 0;
-}
-
-int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
-			 unsigned long start, unsigned long len)
-{
-	size_t cur;
-	size_t offset;
-	struct page *page;
-	char *kaddr;
-	char *ptr = (char *)ptrv;
-	size_t start_offset = offset_in_page(eb->start);
-	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
-	int ret = 0;
-
-	WARN_ON(start > eb->len);
-	WARN_ON(start + len > eb->start + eb->len);
-
-	offset = offset_in_page(start_offset + start);
-
-	while (len > 0) {
-		page = eb->pages[i];
-
-		cur = min(len, (PAGE_SIZE - offset));
-
-		kaddr = page_address(page);
-		ret = memcmp(ptr, kaddr + offset, cur);
-		if (ret)
-			break;
-
-		ptr += cur;
-		len -= cur;
-		offset = 0;
-		i++;
-	}
-	return ret;
-}
-
-void write_extent_buffer_chunk_tree_uuid(struct extent_buffer *eb,
-		const void *srcv)
-{
-	char *kaddr;
-
-	WARN_ON(!PageUptodate(eb->pages[0]));
-	kaddr = page_address(eb->pages[0]);
-	memcpy(kaddr + offsetof(struct btrfs_header, chunk_tree_uuid), srcv,
-			BTRFS_FSID_SIZE);
-}
-
-void write_extent_buffer_fsid(struct extent_buffer *eb, const void *srcv)
-{
-	char *kaddr;
-
-	WARN_ON(!PageUptodate(eb->pages[0]));
-	kaddr = page_address(eb->pages[0]);
-	memcpy(kaddr + offsetof(struct btrfs_header, fsid), srcv,
-			BTRFS_FSID_SIZE);
-}
-
-void write_extent_buffer(struct extent_buffer *eb, const void *srcv,
-			 unsigned long start, unsigned long len)
-{
-	size_t cur;
-	size_t offset;
-	struct page *page;
-	char *kaddr;
-	char *src = (char *)srcv;
-	size_t start_offset = offset_in_page(eb->start);
-	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
-
-	WARN_ON(start > eb->len);
-	WARN_ON(start + len > eb->start + eb->len);
-
-	offset = offset_in_page(start_offset + start);
-
-	while (len > 0) {
-		page = eb->pages[i];
-		WARN_ON(!PageUptodate(page));
-
-		cur = min(len, PAGE_SIZE - offset);
-		kaddr = page_address(page);
-		memcpy(kaddr + offset, src, cur);
-
-		src += cur;
-		len -= cur;
-		offset = 0;
-		i++;
-	}
-}
-
-void memzero_extent_buffer(struct extent_buffer *eb, unsigned long start,
-		unsigned long len)
-{
-	size_t cur;
-	size_t offset;
-	struct page *page;
-	char *kaddr;
-	size_t start_offset = offset_in_page(eb->start);
-	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
-
-	WARN_ON(start > eb->len);
-	WARN_ON(start + len > eb->start + eb->len);
-
-	offset = offset_in_page(start_offset + start);
-
-	while (len > 0) {
-		page = eb->pages[i];
-		WARN_ON(!PageUptodate(page));
-
-		cur = min(len, PAGE_SIZE - offset);
-		kaddr = page_address(page);
-		memset(kaddr + offset, 0, cur);
-
-		len -= cur;
-		offset = 0;
-		i++;
-	}
-}
-
-void copy_extent_buffer_full(struct extent_buffer *dst,
-			     struct extent_buffer *src)
-{
-	int i;
-	int num_pages;
-
-	ASSERT(dst->len == src->len);
-
-	num_pages = num_extent_pages(dst);
-	for (i = 0; i < num_pages; i++)
-		copy_page(page_address(dst->pages[i]),
-				page_address(src->pages[i]));
-}
-
-void copy_extent_buffer(struct extent_buffer *dst, struct extent_buffer *src,
-			unsigned long dst_offset, unsigned long src_offset,
-			unsigned long len)
-{
-	u64 dst_len = dst->len;
-	size_t cur;
-	size_t offset;
-	struct page *page;
-	char *kaddr;
-	size_t start_offset = offset_in_page(dst->start);
-	unsigned long i = (start_offset + dst_offset) >> PAGE_SHIFT;
-
-	WARN_ON(src->len != dst_len);
-
-	offset = offset_in_page(start_offset + dst_offset);
-
-	while (len > 0) {
-		page = dst->pages[i];
-		WARN_ON(!PageUptodate(page));
-
-		cur = min(len, (unsigned long)(PAGE_SIZE - offset));
-
-		kaddr = page_address(page);
-		read_extent_buffer(src, kaddr + offset, src_offset, cur);
-
-		src_offset += cur;
-		len -= cur;
-		offset = 0;
-		i++;
-	}
-}
-
-/*
- * eb_bitmap_offset() - calculate the page and offset of the byte containing the
- * given bit number
- * @eb: the extent buffer
- * @start: offset of the bitmap item in the extent buffer
- * @nr: bit number
- * @page_index: return index of the page in the extent buffer that contains the
- * given bit number
- * @page_offset: return offset into the page given by page_index
- *
- * This helper hides the ugliness of finding the byte in an extent buffer which
- * contains a given bit.
- */
-static inline void eb_bitmap_offset(struct extent_buffer *eb,
-				    unsigned long start, unsigned long nr,
-				    unsigned long *page_index,
-				    size_t *page_offset)
-{
-	size_t start_offset = offset_in_page(eb->start);
-	size_t byte_offset = BIT_BYTE(nr);
-	size_t offset;
-
-	/*
-	 * The byte we want is the offset of the extent buffer + the offset of
-	 * the bitmap item in the extent buffer + the offset of the byte in the
-	 * bitmap item.
-	 */
-	offset = start_offset + start + byte_offset;
-
-	*page_index = offset >> PAGE_SHIFT;
-	*page_offset = offset_in_page(offset);
-}
-
-/**
- * extent_buffer_test_bit - determine whether a bit in a bitmap item is set
- * @eb: the extent buffer
- * @start: offset of the bitmap item in the extent buffer
- * @nr: bit number to test
- */
-int extent_buffer_test_bit(struct extent_buffer *eb, unsigned long start,
-			   unsigned long nr)
-{
-	u8 *kaddr;
-	struct page *page;
-	unsigned long i;
-	size_t offset;
-
-	eb_bitmap_offset(eb, start, nr, &i, &offset);
-	page = eb->pages[i];
-	WARN_ON(!PageUptodate(page));
-	kaddr = page_address(page);
-	return 1U & (kaddr[offset] >> (nr & (BITS_PER_BYTE - 1)));
-}
-
-/**
- * extent_buffer_bitmap_set - set an area of a bitmap
- * @eb: the extent buffer
- * @start: offset of the bitmap item in the extent buffer
- * @pos: bit number of the first bit
- * @len: number of bits to set
- */
-void extent_buffer_bitmap_set(struct extent_buffer *eb, unsigned long start,
-			      unsigned long pos, unsigned long len)
-{
-	u8 *kaddr;
-	struct page *page;
-	unsigned long i;
-	size_t offset;
-	const unsigned int size = pos + len;
-	int bits_to_set = BITS_PER_BYTE - (pos % BITS_PER_BYTE);
-	u8 mask_to_set = BITMAP_FIRST_BYTE_MASK(pos);
-
-	eb_bitmap_offset(eb, start, pos, &i, &offset);
-	page = eb->pages[i];
-	WARN_ON(!PageUptodate(page));
-	kaddr = page_address(page);
-
-	while (len >= bits_to_set) {
-		kaddr[offset] |= mask_to_set;
-		len -= bits_to_set;
-		bits_to_set = BITS_PER_BYTE;
-		mask_to_set = ~0;
-		if (++offset >= PAGE_SIZE && len > 0) {
-			offset = 0;
-			page = eb->pages[++i];
-			WARN_ON(!PageUptodate(page));
-			kaddr = page_address(page);
-		}
-	}
-	if (len) {
-		mask_to_set &= BITMAP_LAST_BYTE_MASK(size);
-		kaddr[offset] |= mask_to_set;
-	}
-}
-
-
-/**
- * extent_buffer_bitmap_clear - clear an area of a bitmap
- * @eb: the extent buffer
- * @start: offset of the bitmap item in the extent buffer
- * @pos: bit number of the first bit
- * @len: number of bits to clear
- */
-void extent_buffer_bitmap_clear(struct extent_buffer *eb, unsigned long start,
-				unsigned long pos, unsigned long len)
-{
-	u8 *kaddr;
-	struct page *page;
-	unsigned long i;
-	size_t offset;
-	const unsigned int size = pos + len;
-	int bits_to_clear = BITS_PER_BYTE - (pos % BITS_PER_BYTE);
-	u8 mask_to_clear = BITMAP_FIRST_BYTE_MASK(pos);
-
-	eb_bitmap_offset(eb, start, pos, &i, &offset);
-	page = eb->pages[i];
-	WARN_ON(!PageUptodate(page));
-	kaddr = page_address(page);
-
-	while (len >= bits_to_clear) {
-		kaddr[offset] &= ~mask_to_clear;
-		len -= bits_to_clear;
-		bits_to_clear = BITS_PER_BYTE;
-		mask_to_clear = ~0;
-		if (++offset >= PAGE_SIZE && len > 0) {
-			offset = 0;
-			page = eb->pages[++i];
-			WARN_ON(!PageUptodate(page));
-			kaddr = page_address(page);
-		}
-	}
-	if (len) {
-		mask_to_clear &= BITMAP_LAST_BYTE_MASK(size);
-		kaddr[offset] &= ~mask_to_clear;
-	}
-}
-
-static inline bool areas_overlap(unsigned long src, unsigned long dst, unsigned long len)
-{
-	unsigned long distance = (src > dst) ? src - dst : dst - src;
-	return distance < len;
-}
-
-static void copy_pages(struct page *dst_page, struct page *src_page,
-		       unsigned long dst_off, unsigned long src_off,
-		       unsigned long len)
-{
-	char *dst_kaddr = page_address(dst_page);
-	char *src_kaddr;
-	int must_memmove = 0;
-
-	if (dst_page != src_page) {
-		src_kaddr = page_address(src_page);
-	} else {
-		src_kaddr = dst_kaddr;
-		if (areas_overlap(src_off, dst_off, len))
-			must_memmove = 1;
-	}
-
-	if (must_memmove)
-		memmove(dst_kaddr + dst_off, src_kaddr + src_off, len);
-	else
-		memcpy(dst_kaddr + dst_off, src_kaddr + src_off, len);
-}
-
-void memcpy_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
-			   unsigned long src_offset, unsigned long len)
-{
-	struct btrfs_fs_info *fs_info = dst->fs_info;
-	size_t cur;
-	size_t dst_off_in_page;
-	size_t src_off_in_page;
-	size_t start_offset = offset_in_page(dst->start);
-	unsigned long dst_i;
-	unsigned long src_i;
-
-	if (src_offset + len > dst->len) {
-		btrfs_err(fs_info,
-			"memmove bogus src_offset %lu move len %lu dst len %lu",
-			 src_offset, len, dst->len);
-		BUG();
-	}
-	if (dst_offset + len > dst->len) {
-		btrfs_err(fs_info,
-			"memmove bogus dst_offset %lu move len %lu dst len %lu",
-			 dst_offset, len, dst->len);
-		BUG();
-	}
-
-	while (len > 0) {
-		dst_off_in_page = offset_in_page(start_offset + dst_offset);
-		src_off_in_page = offset_in_page(start_offset + src_offset);
-
-		dst_i = (start_offset + dst_offset) >> PAGE_SHIFT;
-		src_i = (start_offset + src_offset) >> PAGE_SHIFT;
-
-		cur = min(len, (unsigned long)(PAGE_SIZE -
-					       src_off_in_page));
-		cur = min_t(unsigned long, cur,
-			(unsigned long)(PAGE_SIZE - dst_off_in_page));
-
-		copy_pages(dst->pages[dst_i], dst->pages[src_i],
-			   dst_off_in_page, src_off_in_page, cur);
-
-		src_offset += cur;
-		dst_offset += cur;
-		len -= cur;
-	}
-}
-
-void memmove_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
-			   unsigned long src_offset, unsigned long len)
-{
-	struct btrfs_fs_info *fs_info = dst->fs_info;
-	size_t cur;
-	size_t dst_off_in_page;
-	size_t src_off_in_page;
-	unsigned long dst_end = dst_offset + len - 1;
-	unsigned long src_end = src_offset + len - 1;
-	size_t start_offset = offset_in_page(dst->start);
-	unsigned long dst_i;
-	unsigned long src_i;
-
-	if (src_offset + len > dst->len) {
-		btrfs_err(fs_info,
-			  "memmove bogus src_offset %lu move len %lu len %lu",
-			  src_offset, len, dst->len);
-		BUG();
-	}
-	if (dst_offset + len > dst->len) {
-		btrfs_err(fs_info,
-			  "memmove bogus dst_offset %lu move len %lu len %lu",
-			  dst_offset, len, dst->len);
-		BUG();
-	}
-	if (dst_offset < src_offset) {
-		memcpy_extent_buffer(dst, dst_offset, src_offset, len);
-		return;
-	}
-	while (len > 0) {
-		dst_i = (start_offset + dst_end) >> PAGE_SHIFT;
-		src_i = (start_offset + src_end) >> PAGE_SHIFT;
-
-		dst_off_in_page = offset_in_page(start_offset + dst_end);
-		src_off_in_page = offset_in_page(start_offset + src_end);
-
-		cur = min_t(unsigned long, len, src_off_in_page + 1);
-		cur = min(cur, dst_off_in_page + 1);
-		copy_pages(dst->pages[dst_i], dst->pages[src_i],
-			   dst_off_in_page - cur + 1,
-			   src_off_in_page - cur + 1, cur);
-
-		dst_end -= cur;
-		src_end -= cur;
-		len -= cur;
-	}
-}
-
-int try_release_extent_buffer(struct page *page)
-{
-	struct extent_buffer *eb;
-
-	/*
-	 * We need to make sure nobody is attaching this page to an eb right
-	 * now.
-	 */
-	spin_lock(&page->mapping->private_lock);
-	if (!PagePrivate(page)) {
-		spin_unlock(&page->mapping->private_lock);
-		return 1;
-	}
-
-	eb = (struct extent_buffer *)page->private;
-	BUG_ON(!eb);
-
-	/*
-	 * This is a little awful but should be ok, we need to make sure that
-	 * the eb doesn't disappear out from under us while we're looking at
-	 * this page.
-	 */
-	spin_lock(&eb->refs_lock);
-	if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
-		spin_unlock(&eb->refs_lock);
-		spin_unlock(&page->mapping->private_lock);
-		return 0;
-	}
-	spin_unlock(&page->mapping->private_lock);
-
-	/*
-	 * If tree ref isn't set then we know the ref on this eb is a real ref,
-	 * so just return, this page will likely be freed soon anyway.
-	 */
-	if (!test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags)) {
-		spin_unlock(&eb->refs_lock);
-		return 0;
-	}
-
-	return release_extent_buffer(eb);
-}
-- 
2.21.0

