Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221992B7997
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 09:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgKRIxo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 03:53:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:47778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgKRIxo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 03:53:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605689622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sZON5b6EiJQAQZoqvwG8jV0ASFtt60KuiyKi+yTLPFI=;
        b=qzmn8EiFw8hZYAEvkow1OsooWwqTqKRzHFSUlp55HXBRVFMoxqM5v8KZogQGHf/SzwUT0Z
        5Bn4TWg4ZIHbu0ihRAy5qQ+GVgmWHZRymVwrtfQ5zKE/3KpZ8vlYeO6b/WoS8CgAvJXM9B
        OYAunlOg0f7hcuoTIDr0i/MbK8p4x5M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CA8C9AD2F
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Nov 2020 08:53:42 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/14] btrfs: extent_io: implement try_release_extent_buffer() for subpage metadata support
Date:   Wed, 18 Nov 2020 16:53:13 +0800
Message-Id: <20201118085319.56668-9-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118085319.56668-1-wqu@suse.com>
References: <20201118085319.56668-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Unlike the original try_release_extent_buffer,
try_release_subpage_extent_buffer() will iterate through
btrfs_subpage::tree_block_bitmap, and try to release each extent buffer.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 69 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b3edd7fba5c8..28f35eb06bf8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6340,10 +6340,79 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 	}
 }
 
+static int try_release_subpage_extent_buffer(struct page *page)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+	u64 page_start = page_offset(page);
+	int bitmap_size = BTRFS_SUBPAGE_BITMAP_SIZE;
+	int bit_start = 0;
+	int ret;
+
+	while (bit_start < bitmap_size) {
+		struct btrfs_subpage *subpage;
+		struct extent_buffer *eb;
+		u64 start;
+
+		/*
+		 * Make sure the page still has private, as previous run can
+		 * detach the private
+		 */
+		spin_lock(&page->mapping->private_lock);
+		if (!PagePrivate(page)) {
+			spin_unlock(&page->mapping->private_lock);
+			break;
+		}
+		subpage = (struct btrfs_subpage *)page->private;
+		spin_unlock(&page->mapping->private_lock);
+
+		spin_lock_bh(&subpage->lock);
+		bit_start = find_next_bit(subpage->tree_block_bitmap,
+				BTRFS_SUBPAGE_BITMAP_SIZE, bit_start);
+		spin_unlock_bh(&subpage->lock);
+		if (bit_start >= bitmap_size)
+			break;
+		start = bit_start * fs_info->sectorsize + page_start;
+		bit_start += fs_info->nodesize >> fs_info->sectorsize_bits;
+		/*
+		 * Here we can't call find_extent_buffer() which will increase
+		 * eb->refs.
+		 */
+		rcu_read_lock();
+		eb = radix_tree_lookup(&fs_info->buffer_radix,
+				start >> fs_info->sectorsize_bits);
+		rcu_read_unlock();
+		ASSERT(eb);
+		spin_lock(&eb->refs_lock);
+		if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb) ||
+		    !test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags)) {
+			spin_unlock(&eb->refs_lock);
+			continue;
+		}
+		/*
+		 * Here we don't care the return value, we will always check
+		 * the page private at the end.
+		 * And release_extent_buffer() will release the refs_lock.
+		 */
+		release_extent_buffer(eb);
+	}
+	/* Finally to check if we have cleared page private */
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
 
+	if (btrfs_is_subpage(btrfs_sb(page->mapping->host->i_sb)))
+		return try_release_subpage_extent_buffer(page);
+
 	/*
 	 * We need to make sure nobody is attaching this page to an eb right
 	 * now.
-- 
2.29.2

