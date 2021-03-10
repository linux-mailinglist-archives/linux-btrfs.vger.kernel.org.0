Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E732233385C
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 10:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbhCJJJX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 04:09:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:34788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232694AbhCJJI4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 04:08:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615367335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YdULI0b6cZt14olkEluIl5PCPvhtYviT+kZdgqzkmVs=;
        b=jz2Fl5YoBl9vGx5g8mD2hUq/TdvkpP8GS+u/pvY1bzeagSXx6XG7/lRSPfUW4MSNtQ6ueO
        fnK+Z7NIyh/Wb0yrFp9OzxftL3mJXEGLshrUHwb9G25nQZuA2LctQYfsmIYTRNeTHRl8rb
        EvqHu+sUb4A1JxvJNN2W6pzaYbW32wQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51B07AD74
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Mar 2021 09:08:55 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 08/15] btrfs: make alloc_extent_buffer() check subpage dirty bitmap
Date:   Wed, 10 Mar 2021 17:08:26 +0800
Message-Id: <20210310090833.105015-9-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210310090833.105015-1-wqu@suse.com>
References: <20210310090833.105015-1-wqu@suse.com>
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
index 82cc8b9ce744..796beb5a0b6b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5635,7 +5635,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		btrfs_page_inc_eb_refs(fs_info, p);
 		spin_unlock(&mapping->private_lock);
 
-		WARN_ON(PageDirty(p));
+		WARN_ON(btrfs_page_test_dirty(fs_info, p, eb->start, eb->len));
 		eb->pages[i] = p;
 		if (!PageUptodate(p))
 			uptodate = 0;
-- 
2.30.1

