Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6847136CF2D
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 01:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbhD0XFm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 19:05:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:37324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238340AbhD0XFm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 19:05:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619564697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GGPaJT2GniEalBnHWUXV2pjrjD1fMgjcFnxajKx2Oxs=;
        b=MPOU4yc+XT49j8L3ComeyBTfRQ39mfF9vHt32f0kbpBPcFurQth7QnggWeAyEMJ+8i87k/
        yJpnvZzxme21zS1VQxh0fjcSnN9xfm6wuKFGHSnMIp3qW3es2LrVVVr8CSzZC1qhn9ALsK
        +iiGZsxwflnHYwVUTfHz/1+OwfEHnss=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 798FAAC6A
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Apr 2021 23:04:57 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [Patch v2 28/42] btrfs: make btrfs_truncate_block() to be subpage compatible
Date:   Wed, 28 Apr 2021 07:03:35 +0800
Message-Id: <20210427230349.369603-29-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427230349.369603-1-wqu@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
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
index a997d041e1ee..a54ea576a061 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4909,7 +4909,8 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
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

