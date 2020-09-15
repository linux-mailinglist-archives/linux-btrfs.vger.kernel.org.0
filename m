Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFDE269DDF
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 07:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgIOFgH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 01:36:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:43248 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgIOFgC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 01:36:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 509CEAD52;
        Tue, 15 Sep 2020 05:36:17 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 10/19] btrfs: add assert_spin_locked() for attach_extent_buffer_page()
Date:   Tue, 15 Sep 2020 13:35:23 +0800
Message-Id: <20200915053532.63279-11-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915053532.63279-1-wqu@suse.com>
References: <20200915053532.63279-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When calling attach_extent_buffer_page(), either we're attaching
anonymous pages, called from btrfs_clone_extent_buffer().

Or we're attaching btree_inode pages, called from alloc_extent_buffer().

For the later case, we should have page->mapping->private_lock hold to
avoid race modifying page->private.

Add assert_spin_locked() if we're calling from alloc_extent_buffer().

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent_io.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ba9cc864d9c0..9d4a81997738 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3096,6 +3096,15 @@ static int submit_extent_page(unsigned int opf,
 static void attach_extent_buffer_page(struct extent_buffer *eb,
 				      struct page *page)
 {
+	/*
+	 * If the page is mapped to btree inode, we should hold the private
+	 * lock to prevent race.
+	 * For cloned or dummy extent buffers, their pages are not mapped and
+	 * will not race with any other ebs.
+	 */
+	if (page->mapping)
+		assert_spin_locked(&page->mapping->private_lock);
+
 	if (!PagePrivate(page))
 		attach_page_private(page, eb);
 	else
-- 
2.28.0

