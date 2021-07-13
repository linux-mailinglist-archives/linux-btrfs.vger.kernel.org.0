Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391FB3C6A48
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jul 2021 08:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhGMGSX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jul 2021 02:18:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36610 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbhGMGSP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jul 2021 02:18:15 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 39B9B21C8D
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626156925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tTkO07inAqhU7BOKkY+etAlDISal08LWM4Va8aRhi+k=;
        b=SaoebLxTV+IgCWgk9uEtigV87NDJZ78kLBo0h9QA/7k9CmRtAkZZMHDdgW9GVBoC+9NbCC
        tOCM6Urgg9PJid6wloQA9mHgZAwDM9SLguN775gCabyETPb+XADJu+T6ik6e2RyKagrXje
        CQo7Wn0D0nEIUlNB0ceK5ANQwtzCPYU=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 775A5139AC
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id +LOkDnwv7WB0XgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/27] btrfs: don't pass compressed pages to btrfs_writepage_endio_finish_ordered()
Date:   Tue, 13 Jul 2021 14:14:53 +0800
Message-Id: <20210713061516.163318-5-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713061516.163318-1-wqu@suse.com>
References: <20210713061516.163318-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since async_extent holds the compressed page, it would trigger the new
ASSERT() in btrfs_mark_ordered_io_finished() which checks the range is
inside the page.

Now btrfs_writepage_endio_finish_ordered() can accept @page == NULL,
just pass NULL to btrfs_writepage_endio_finish_ordered().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e5703160718c..b524deadb5c6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -972,15 +972,12 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 				    async_extent->nr_pages,
 				    async_chunk->write_flags,
 				    async_chunk->blkcg_css)) {
-			struct page *p = async_extent->pages[0];
 			const u64 start = async_extent->start;
 			const u64 end = start + async_extent->ram_size - 1;
 
-			p->mapping = inode->vfs_inode.i_mapping;
-			btrfs_writepage_endio_finish_ordered(inode, p, start,
+			btrfs_writepage_endio_finish_ordered(inode, NULL, start,
 							     end, 0);
 
-			p->mapping = NULL;
 			extent_clear_unlock_delalloc(inode, start, end, NULL, 0,
 						     PAGE_END_WRITEBACK |
 						     PAGE_SET_ERROR);
-- 
2.32.0

