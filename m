Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFA7260C72
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 09:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbgIHHw6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 03:52:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:50974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729552AbgIHHwx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Sep 2020 03:52:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 39834AE24
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Sep 2020 07:52:53 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/17] btrfs: don't allow tree block to cross page boundary for subpage support
Date:   Tue,  8 Sep 2020 15:52:18 +0800
Message-Id: <20200908075230.86856-6-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908075230.86856-1-wqu@suse.com>
References: <20200908075230.86856-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As a preparation for subpage sector size support (allow sector size
smaller than page size to be mounted), if the sector size is smaller
than page size, we don't allow tree block to be read if it cross page
boundary (normally 64K).

This ensures that, tree blocks are always contained in one page for 64K
system, which can greatly simplify the handling.

Or we need to do complex multi-page handling for tree blocks.

Currently the only way to create such tree blocks crossing 64K boundary
is by btrfs-convert, which will get fixed soon and doesn't get
wide-spread usage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5d969340275e..119193166cec 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5232,6 +5232,13 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		btrfs_err(fs_info, "bad tree block start %llu", start);
 		return ERR_PTR(-EINVAL);
 	}
+	if (fs_info->sectorsize < PAGE_SIZE && round_down(start, PAGE_SIZE) !=
+	    round_down(start + len - 1, PAGE_SIZE)) {
+		btrfs_err(fs_info,
+		"tree block crosses page boundary, start %llu nodesize %lu",
+			  start, len);
+		return ERR_PTR(-EINVAL);
+	}
 
 	eb = find_extent_buffer(fs_info, start);
 	if (eb)
-- 
2.28.0

