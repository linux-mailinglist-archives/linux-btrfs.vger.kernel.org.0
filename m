Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597B73210E0
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 07:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhBVGfi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 01:35:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:48794 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229943AbhBVGfi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 01:35:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613975663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gqu16gpPs/SgfjfojO/0IZnMruFKZCCIaHY9dEYtH0E=;
        b=Ucfp989sL7eeTzxncNHy92upernoYHkjb0WKTWEDDmcD8FGbLd+k/+XBQjQOFAuyOgYaDP
        8PiqtvBJdINfcuRQZjWiHvQoWunKT75nDfR6/nM19EHdkmIKVIOKQubDazHPeM5GxuCcIC
        mIB1nvfFK0kSLAeuvqjpAVyaXPahZwk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F38F5B120
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Feb 2021 06:34:22 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/12] btrfs: extent_io: make alloc_extent_buffer() check subpage dirty bitmap
Date:   Mon, 22 Feb 2021 14:33:50 +0800
Message-Id: <20210222063357.92930-6-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210222063357.92930-1-wqu@suse.com>
References: <20210222063357.92930-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In alloc_extent_buffer(), we make sure that the newly allocated page is
never dirty.

This is fine for sector size == PAGE_SIZE case, but for subpage it's
possible that one extent buffer in the page is dirty, thus the whole
page is marked dirty, and could cause false alert.

To support subpage, call btrfs_page_test_dirty() to handle both cases.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4dfb3ead1175..6637535d264d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5625,7 +5625,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		btrfs_page_inc_eb_refs(fs_info, p);
 		spin_unlock(&mapping->private_lock);
 
-		WARN_ON(PageDirty(p));
+		WARN_ON(btrfs_page_test_dirty(fs_info, p, eb->start, eb->len));
 		eb->pages[i] = p;
 		if (!PageUptodate(p))
 			uptodate = 0;
-- 
2.30.0

