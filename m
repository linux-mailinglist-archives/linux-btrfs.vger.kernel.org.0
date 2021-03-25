Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A08E3489F0
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 08:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhCYHPq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 03:15:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:36556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229676AbhCYHPS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 03:15:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616656517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XUflP34HQBlhd2f8tCGn3cWbGqRM200EEQtNcsqUeDU=;
        b=lRk89JDtOmiz1GXe3DmLVRdySG+feUW4CHbI1lBSdrmIIWF+IZkVqWL+XvKZ3GyoIPqqub
        hQm6QC4dCe9mQI6FgFPuE42Ofh+Y8mkS/E9Ua/E7ZG5z6GI+LI5kXpMxpRD9X+jtA/2N/0
        FjvjvKjBLL70KJ0rPiabW5XwSSYfT5E=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A475AAA55
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Mar 2021 07:15:17 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 09/13] btrfs: make alloc_extent_buffer() check subpage dirty bitmap
Date:   Thu, 25 Mar 2021 15:14:41 +0800
Message-Id: <20210325071445.90896-10-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325071445.90896-1-wqu@suse.com>
References: <20210325071445.90896-1-wqu@suse.com>
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
index 7ad2169e7487..7c195d8dc07b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5665,7 +5665,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		btrfs_page_inc_eb_refs(fs_info, p);
 		spin_unlock(&mapping->private_lock);
 
-		WARN_ON(PageDirty(p));
+		WARN_ON(btrfs_page_test_dirty(fs_info, p, eb->start, eb->len));
 		eb->pages[i] = p;
 		if (!PageUptodate(p))
 			uptodate = 0;
-- 
2.30.1

