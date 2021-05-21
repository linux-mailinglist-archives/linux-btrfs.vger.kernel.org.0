Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D7038BFC6
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 08:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhEUGoS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 02:44:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:58774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234422AbhEUGny (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 02:43:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621579263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hYVeus6owo8iEUG8RcD8NEjpyF6B+CbULJO+ll+Mzhw=;
        b=OAC85h1dQVgXytV4taq+/1UvM0t/m/9zUDueozU66vkcZbzq7MJ+dcqZGKk4JjstQ0STS3
        pLKWgMMLwO8s9YRdC9s6s0IArQlcNy9c37vMui8HgkPUMnIiYMSun5u0wsdogUfKXSnpN9
        qMQRdRzvVyMjZJAE043vppKe45s56Co=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 952D0ACAD;
        Fri, 21 May 2021 06:41:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v3 05/31] btrfs: make btrfs_dirty_pages() to be subpage compatible
Date:   Fri, 21 May 2021 14:40:24 +0800
Message-Id: <20210521064050.191164-6-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521064050.191164-1-wqu@suse.com>
References: <20210521064050.191164-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since the extent io tree operations in btrfs_dirty_pages() are already
subpage compatible, we only need to make the page status update to use
subpage helpers.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 3b10d98b4ebb..4a89697ae3a7 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -28,6 +28,7 @@
 #include "compression.h"
 #include "delalloc-space.h"
 #include "reflink.h"
+#include "subpage.h"
 
 static struct kmem_cache *btrfs_inode_defrag_cachep;
 /*
@@ -482,6 +483,7 @@ int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 	start_pos = round_down(pos, fs_info->sectorsize);
 	num_bytes = round_up(write_bytes + pos - start_pos,
 			     fs_info->sectorsize);
+	ASSERT(num_bytes <= U32_MAX);
 
 	end_of_last_block = start_pos + num_bytes - 1;
 
@@ -500,9 +502,10 @@ int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = pages[i];
-		SetPageUptodate(p);
+
+		btrfs_page_clamp_set_uptodate(fs_info, p, start_pos, num_bytes);
 		ClearPageChecked(p);
-		set_page_dirty(p);
+		btrfs_page_clamp_set_dirty(fs_info, p, start_pos, num_bytes);
 	}
 
 	/*
-- 
2.31.1

