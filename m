Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E31E2A4690
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgKCNcI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:32:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:44928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729379AbgKCNcF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:32:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4HW27xl7bSd1rK7DTNw+O3TLbSc5iwCo3WqwAwm6x0w=;
        b=LcNy6ozAY4/xtC27YhzvMA0DRpjCImHze3rTLqkgjy1NrKiWm9JSfOVaHw6L3PDrpw0jRH
        ClK80ozY1VSjtlvUiFHlBBs/HAACbZ9EyevOC4nWm47RaK0TlPN1pNHTm7q7Q2BLFHQe+P
        3d2gDso1lREoax1lWNZJtLKlyTK8oik=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51F1FAF95
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 13:32:04 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 17/32] btrfs: extent_io: don't allow tree block to cross page boundary for subpage support
Date:   Tue,  3 Nov 2020 21:30:53 +0800
Message-Id: <20201103133108.148112-18-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
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

Currently the only way to create such tree blocks crossing 64K boundary
is by btrfs-convert, which will get fixed soon and doesn't get
wide-spread usage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 30768e49cf47..30bbaeaa129a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5261,6 +5261,13 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		btrfs_err(fs_info, "bad tree block start %llu", start);
 		return ERR_PTR(-EINVAL);
 	}
+	if (btrfs_is_subpage(fs_info) && round_down(start, PAGE_SIZE) !=
+	    round_down(start + len - 1, PAGE_SIZE)) {
+		btrfs_err(fs_info,
+		"tree block crosses page boundary, start %llu nodesize %lu",
+			  start, len);
+		return ERR_PTR(-EINVAL);
+	}
 
 	eb = find_extent_buffer(fs_info, start);
 	if (eb)
-- 
2.29.2

