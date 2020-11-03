Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4632A467A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgKCNb2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:31:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:44192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729043AbgKCNb0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:31:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fBsh8AS/ePYnb31EdT6vVpaN4yojvxK7Yfk/f//2g9g=;
        b=npoTGx5019ZSKU1MGSdHiswC4tujdpYUyFoH2g2WzAQTPNhZsx8VIPmAkMtHkigBp4nkcl
        FLuUjNoRDJ+iGSdXvfLNh/jpIDT/uWtwKn1yw3nCunj/pGXyeflHbjeM0CsR1gvsOsfo6g
        r3VsI+lmJdEMjGhsrD67AadiIbWii7Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5FB1FABF4;
        Tue,  3 Nov 2020 13:31:25 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 03/32] btrfs: extent_io: add lockdep_assert_held() for attach_extent_buffer_page()
Date:   Tue,  3 Nov 2020 21:30:39 +0800
Message-Id: <20201103133108.148112-4-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
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

Add lockdep_assert_held() if we're calling from alloc_extent_buffer().

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 228bf0c5f7a0..9cbce0b74db7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3093,6 +3093,15 @@ static int submit_extent_page(unsigned int opf,
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
+		lockdep_assert_held(&page->mapping->private_lock);
+
 	if (!PagePrivate(page))
 		attach_page_private(page, eb);
 	else
-- 
2.29.2

