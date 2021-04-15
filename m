Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2337636016C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 07:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhDOFGM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 01:06:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:38090 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230163AbhDOFGL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 01:06:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618463148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J5JjxU3dfPiGCpU3qJWCevya7lQaYI1JExy5nzxa7Tc=;
        b=W8bP68ilaRsqBHnbskpNCXYxYGCe4FuYpBbbvZX1ICoM1upOBLvaHsvMh9Qr/le2REDgTJ
        pebB75BNf78EBYmO+7M/70dBuAMHWPuiijvVKQ1d4nol06LLhQxAv0vzhwY3YvjuZg/U5Q
        rx8APQSXdmlI94OSQGAQSTgy9zzgWqs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC047AF03
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 05:05:47 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 29/42] btrfs: make btrfs_truncate_block() to be subpage compatible
Date:   Thu, 15 Apr 2021 13:04:35 +0800
Message-Id: <20210415050448.267306-30-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415050448.267306-1-wqu@suse.com>
References: <20210415050448.267306-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_truncate_block() itself is already mostly subpage compatible, the
only missing part is the page dirtying code.

Currently if we have a sector that needs to be truncated, we set the
sector aligned range delalloc, then set the full page dirty.

The problem is, current subpage code requires subpage dirty bit to be
set, or __extent_writepage_io() won't submit bio, thus leads to ordered
extent never to finish.

So this patch will make btrfs_truncate_block() to call
btrfs_page_set_dirty() helper to replace set_page_dirty() to fix the
problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index da73fd51d232..38ebb79ee580 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4937,7 +4937,8 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 		kunmap(page);
 	}
 	ClearPageChecked(page);
-	set_page_dirty(page);
+	btrfs_page_set_dirty(fs_info, page, block_start,
+			     block_end + 1 - block_start);
 	unlock_extent_cached(io_tree, block_start, block_end, &cached_state);
 
 	if (only_release_metadata)
-- 
2.31.1

