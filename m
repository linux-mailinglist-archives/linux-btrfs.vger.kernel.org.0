Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC4B260C77
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 09:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbgIHHxM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 03:53:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:51098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729576AbgIHHxE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Sep 2020 03:53:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D536FAE24
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Sep 2020 07:53:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/17] btrfs: refactor how we extract extent buffer from page for alloc_extent_buffer()
Date:   Tue,  8 Sep 2020 15:52:21 +0800
Message-Id: <20200908075230.86856-9-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908075230.86856-1-wqu@suse.com>
References: <20200908075230.86856-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch will extract the code to extract extent_buffer from
page::private into its own function, grab_extent_buffer_from_page().

Although it's just one line, for later sub-page size support it will
become way more larger.

Also add some extra comments why we need to do such page::private
dancing.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 49 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6fafbc1d047b..3c8fe40f67fa 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5214,6 +5214,44 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 }
 #endif
 
+/*
+ * A helper to grab the exist extent buffer from a page.
+ *
+ * There is a small race window where two callers of alloc_extent_buffer():
+ * 		Thread 1		|	Thread 2
+ * -------------------------------------+---------------------------------------
+ * alloc_extent_buffer()		| alloc_extent_buffer()
+ * |- eb = __alloc_extent_buffer()	| |- eb = __alloc_extent_buffer()
+ * |- p = find_or_create_page()		| |- p = find_or_create_page()
+ *
+ * In above case, two ebs get allocated for the same bytenr, and got the same
+ * page.
+ * We have to rely on the page->mapping->private_lock to make one of them to
+ * give up and reuse the allocated eb:
+ *
+ * 					| |- grab_extent_buffer_from_page()
+ * 					| |- get nothing
+ * 					| |- attach_extent_buffer_page()
+ * 					| |  |- Now page->private is set
+ * 					| |- spin_unlock(&mapping->private_lock);
+ * |- spin_lock(private_lock);		| |- Continue to insert radix tree.
+ * |- grab_extent_buffer_from_page()	|
+ * |- got eb from thread 2		|
+ * |- spin_unlock(private_lock);	|
+ * |- goto free_eb;			|
+ *
+ * The function here is to ensure we have proper locking and detect such race
+ * so we won't allocating an eb twice.
+ */
+static struct extent_buffer *grab_extent_buffer_from_page(struct page *page)
+{
+	/*
+	 * For PAGE_SIZE == sectorsize case, a btree_inode page should have its
+	 * private pointer as extent buffer who owns this page.
+	 */
+	return (struct extent_buffer *)page->private;
+}
+
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 start)
 {
@@ -5258,15 +5296,8 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 
 		spin_lock(&mapping->private_lock);
 		if (PagePrivate(p)) {
-			/*
-			 * We could have already allocated an eb for this page
-			 * and attached one so lets see if we can get a ref on
-			 * the existing eb, and if we can we know it's good and
-			 * we can just return that one, else we know we can just
-			 * overwrite page->private.
-			 */
-			exists = (struct extent_buffer *)p->private;
-			if (atomic_inc_not_zero(&exists->refs)) {
+			exists = grab_extent_buffer_from_page(p);
+			if (exists && atomic_inc_not_zero(&exists->refs)) {
 				spin_unlock(&mapping->private_lock);
 				unlock_page(p);
 				put_page(p);
-- 
2.28.0

