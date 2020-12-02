Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC442CB544
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 07:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgLBGtv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 01:49:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:53474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728623AbgLBGtu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 01:49:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606891715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3BLNgJuooQugIyc5magaI5yoL/H+svhmP1oQvBidNBY=;
        b=tJNtgJsnDd6YJXTq8+xwe+nYvvlsr7ESNWRKeThUAidKwQXTYgWRbibtGM9Cu7MhJbDeyO
        wuBoxXi9Dz5rCT662wNSYL14i3gzLBMq8FP7moovLgTECnqpXwvhXmr7Z9aMc5raB7GGif
        23DshYLo7GcF1VJaNJ7RKFczAKoi3g4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8FF96AEC3
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 06:48:35 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 06/15] btrfs: extent_io: don't allow tree block to cross page boundary for subpage support
Date:   Wed,  2 Dec 2020 14:48:02 +0800
Message-Id: <20201202064811.100688-7-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202064811.100688-1-wqu@suse.com>
References: <20201202064811.100688-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As a preparation for subpage sector size support (allowing filesystem
with sector size smaller than page size to be mounted) if the sector
size is smaller than page size, we don't allow tree block to be read if
it crosses 64K(*) boundary.

The 64K is selected because:
- We are only going to support 64K page size for subpage for now
- 64K is also the max node size btrfs supports

This ensures that, tree blocks are always contained in one page for a
system with 64K page size, which can greatly simplify the handling.

Or we need to do complex multi-page handling for tree blocks.

Currently there is no way to create such tree blocks.
Kernel has avoided such tree blocks allocation even on 4K page size, as
it can lead to RAID56 stripe scrubing.

While btrfs-progs has fixed its chunk allocator since 2016 for convert,
and has extra checks to do the same behavior as the kernel.

Just add such graceful checks for ancient btrfs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2bab66b42395..8cbd6d43b154 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5272,6 +5272,13 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		btrfs_err(fs_info, "bad tree block start %llu", start);
 		return ERR_PTR(-EINVAL);
 	}
+	if (fs_info->sectorsize < PAGE_SIZE &&
+	    offset_in_page(start) + len > PAGE_SIZE) {
+		btrfs_err(fs_info,
+		"tree block crosses page boundary, start %llu nodesize %lu",
+			  start, len);
+		return ERR_PTR(-EINVAL);
+	}
 
 	eb = find_extent_buffer(fs_info, start);
 	if (eb)
-- 
2.29.2

