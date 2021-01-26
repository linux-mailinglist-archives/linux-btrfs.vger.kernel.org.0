Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DC8304530
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 18:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbhAZRYx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 12:24:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:54954 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390321AbhAZIhN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 03:37:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611650091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bwunWFCfxmh5H02Fs38CkvmnSOvG4fDceEgEls1rPPM=;
        b=ITqN06cgKpgGclC7ExYHZmBlrWwUU+sYofqsBWtClNMBNCXBPmbfrXxJa9EZuHJg67TdZq
        PS3sa0PYu0rorZd5MgUZyBC13SdIhujEgmomJHkwAhZ4WtdOeh2ZfO71MqW4QmgPrcblsa
        iqERoL27t/0dwf1dke6Sdag5vG8RzU0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0319B221;
        Tue, 26 Jan 2021 08:34:51 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v5 12/18] btrfs: support subpage in try_release_extent_buffer()
Date:   Tue, 26 Jan 2021 16:33:56 +0800
Message-Id: <20210126083402.142577-13-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126083402.142577-1-wqu@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Unlike the original try_release_extent_buffer(),
try_release_subpage_extent_buffer() will iterate through all the ebs in
the page, and try to release each.

We can release the full page only after there's no private attached,
which means all ebs of that page have been released as well.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 106 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d1c1bbc19226..27d7f42f605e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6316,13 +6316,115 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 	}
 }
 
+static struct extent_buffer *get_next_extent_buffer(
+		struct btrfs_fs_info *fs_info, struct page *page, u64 bytenr)
+{
+	struct extent_buffer *gang[BTRFS_SUBPAGE_BITMAP_SIZE];
+	struct extent_buffer *found = NULL;
+	u64 page_start = page_offset(page);
+	int ret;
+	int i;
+
+	ASSERT(in_range(bytenr, page_start, PAGE_SIZE));
+	ASSERT(PAGE_SIZE / fs_info->nodesize <= BTRFS_SUBPAGE_BITMAP_SIZE);
+	lockdep_assert_held(&fs_info->buffer_lock);
+
+	ret = radix_tree_gang_lookup(&fs_info->buffer_radix, (void **)gang,
+			bytenr >> fs_info->sectorsize_bits,
+			PAGE_SIZE / fs_info->nodesize);
+	for (i = 0; i < ret; i++) {
+		/* Already beyond page end */
+		if (gang[i]->start >= page_start + PAGE_SIZE)
+			break;
+		/* Found one */
+		if (gang[i]->start >= bytenr) {
+			found = gang[i];
+			break;
+		}
+	}
+	return found;
+}
+
+static int try_release_subpage_extent_buffer(struct page *page)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+	u64 cur = page_offset(page);
+	const u64 end = page_offset(page) + PAGE_SIZE;
+	int ret;
+
+	while (cur < end) {
+		struct extent_buffer *eb = NULL;
+
+		/*
+		 * Unlike try_release_extent_buffer() which uses page->private
+		 * to grab buffer, for subpage case we rely on radix tree, thus
+		 * we need to ensure radix tree consistency.
+		 *
+		 * We also want an atomic snapshot of the radix tree, thus go
+		 * with spinlock rather than RCU.
+		 */
+		spin_lock(&fs_info->buffer_lock);
+		eb = get_next_extent_buffer(fs_info, page, cur);
+		if (!eb) {
+			/* No more eb in the page range after or at cur */
+			spin_unlock(&fs_info->buffer_lock);
+			break;
+		}
+		cur = eb->start + eb->len;
+
+		/*
+		 * The same as try_release_extent_buffer(), to ensure the eb
+		 * won't disappear out from under us.
+		 */
+		spin_lock(&eb->refs_lock);
+		if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
+			spin_unlock(&eb->refs_lock);
+			spin_unlock(&fs_info->buffer_lock);
+			break;
+		}
+		spin_unlock(&fs_info->buffer_lock);
+
+		/*
+		 * If tree ref isn't set then we know the ref on this eb is a
+		 * real ref, so just return, this eb will likely be freed soon
+		 * anyway.
+		 */
+		if (!test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags)) {
+			spin_unlock(&eb->refs_lock);
+			break;
+		}
+
+		/*
+		 * Here we don't care about the return value, we will always
+		 * check the page private at the end.  And
+		 * release_extent_buffer() will release the refs_lock.
+		 */
+		release_extent_buffer(eb);
+	}
+	/*
+	 * Finally to check if we have cleared page private, as if we have
+	 * released all ebs in the page, the page private should be cleared now.
+	 */
+	spin_lock(&page->mapping->private_lock);
+	if (!PagePrivate(page))
+		ret = 1;
+	else
+		ret = 0;
+	spin_unlock(&page->mapping->private_lock);
+	return ret;
+
+}
+
 int try_release_extent_buffer(struct page *page)
 {
 	struct extent_buffer *eb;
 
+	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
+		return try_release_subpage_extent_buffer(page);
+
 	/*
-	 * We need to make sure nobody is attaching this page to an eb right
-	 * now.
+	 * We need to make sure nobody is changing page->private, as we rely on
+	 * page->private as the pointer to extent buffer.
 	 */
 	spin_lock(&page->mapping->private_lock);
 	if (!PagePrivate(page)) {
-- 
2.30.0

