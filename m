Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6055A2FFC6B
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 07:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbhAVGBr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 01:01:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:41934 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbhAVGBq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 01:01:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611295259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=soAMALw4VnkbBnhG6FrRMcQEk2MF7SeXQkfPunlwwAo=;
        b=mEVpj8lAjaxDLUP4Ti/kWJkxAT3tMbbqRm2MfpbkYkO5UzspJ8s+YnclEf+quGVxE65udm
        oxevgYld6uCQFQkniTdl0NU6tSniAnlXHg3DmJi7RJJnThCA1RqE7yL8K2EcX8XqjBbvlO
        SMHpTyp606leGw0ar8xOyd6i5mYFyFM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 79411AD0B
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 06:00:59 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: make Private2 lifespan more consistent
Date:   Fri, 22 Jan 2021 14:00:52 +0800
Message-Id: <20210122060052.74365-1-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs uses page Private2 bit to incidate if we have ordered
extent for the page range.

But the lifespan of it is not consistent, during regular writeback path,
there are two locations to clear the same PagePrivate2:

    T ----- Page marked Dirty
    |
    + ----- Page marked Private2, through btrfs_run_dealloc_range()
    |
    + ----- Page cleared Private2, through btrfs_writepage_cow_fixup()
    |       in __extent_writepage_io()
    |       ^^^ Private2 cleared for the first time
    |
    + ----- Page marked Writeback, through btrfs_set_range_writeback()
    |       in __extent_writepage_io().
    |
    + ----- Page cleared Private2, through
    |       btrfs_writepage_endio_finish_ordered()
    |       ^^^ Private2 cleared for the second time.
    |
    + ----- Page cleared Writeback, through
            btrfs_writepage_endio_finish_ordered()

Currently PagePrivate2 is mostly to prevent ordered extent accounting
being executed for both endio and invalidatepage.
Thus only the one who cleared page Private2 is responsible for ordered
extent accounting.

But the fact is, in btrfs_writepage_endio_finish_ordered(), page
Private2 is cleared and ordered extent accounting is executed
unconditionally.

The race prevention only happens through btrfs_invalidatepage(), where
we wait the page writeback first, before checking the Private2 bit.

This means, Private2 is also protected by Writeback bit, and there is no
need for btrfs_writepage_cow_fixup() to clear Priavte2.

This patch will change btrfs_writepage_cow_fixup() to just
check PagePrivate2, not to clear it.
The clear will happen either in btrfs_invalidatepage() or
btrfs_writepage_endio_finish_ordered().

This makes the Private2 bit easier to understand, just meaning the page
has unfinished ordered extent attached to it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ef6cb7b620d0..fd06a2a1ee8f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2539,7 +2539,7 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end)
 	struct btrfs_writepage_fixup *fixup;
 
 	/* this page is properly in the ordered list */
-	if (TestClearPagePrivate2(page))
+	if (PagePrivate2(page))
 		return 0;
 
 	/*
-- 
2.30.0

