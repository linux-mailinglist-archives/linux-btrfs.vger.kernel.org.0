Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA3027DE08
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgI3B4U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:56:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:50038 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729834AbgI3B4U (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:56:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601430978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOHsdqz1ZA/hXiOu0qi1TyahI2taKcOlUWmD8U1R2VU=;
        b=iOY6j+LvFtSF+rUVcUcpdVdU4VTV3sqIY50mONS2uGlt6aBEdy9Wq//t5bY+gJMH2fZ7Mr
        nC289hD8TXr0yWspFJFw4XOGko5ngCyTElsubHCtxN7YOE22RiWm9ZH7tblHarxdKKt9Pl
        FES2FDEGBuJhmJER3T4arnyGhoBXDfU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7B6D3AF95;
        Wed, 30 Sep 2020 01:56:18 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 16/49] btrfs: extent_io: add assert_spin_locked() for attach_extent_buffer_page()
Date:   Wed, 30 Sep 2020 09:55:06 +0800
Message-Id: <20200930015539.48867-17-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930015539.48867-1-wqu@suse.com>
References: <20200930015539.48867-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 2edbac6c089e..e282eb63ad1b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3110,6 +3110,15 @@ static int submit_extent_page(unsigned int opf,
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

