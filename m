Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4613FA942
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 07:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbhH2F0A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 01:26:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45758 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbhH2FZ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 01:25:58 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B0A701FD50
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630214706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hZLbJcFJHlclKPIbFqwLJZHTfnFUxTJlAYZzMPrgCPg=;
        b=FyCXI1guMUcOFh9F7tuE+yuVL6Ws/spY91hd58jXlClmtxvRvlkVMS3BxUSWiGS9SW32Bs
        1tgBxfwTALo6dPb1sxvGLHNPhKo6zbftIu4kAJ+hB19ZvtKGjMsPJ0LGxvZDDKLYOTE6d9
        4tA4GGitjA7U5nUL4CWejsbxPv/yogg=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id EEF3413964
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id IJbmKzEaK2HnPAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:05 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 04/26] btrfs: don't pass compressed pages to btrfs_writepage_endio_finish_ordered()
Date:   Sun, 29 Aug 2021 13:24:36 +0800
Message-Id: <20210829052458.15454-5-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829052458.15454-1-wqu@suse.com>
References: <20210829052458.15454-1-wqu@suse.com>
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
index 02448857b72f..6760ec78df6b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -973,15 +973,12 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 				    async_extent->nr_pages,
 				    async_chunk->write_flags,
 				    async_chunk->blkcg_css)) {
-			struct page *p = async_extent->pages[0];
 			const u64 start = async_extent->start;
 			const u64 end = start + async_extent->ram_size - 1;
 
-			p->mapping = inode->vfs_inode.i_mapping;
-			btrfs_writepage_endio_finish_ordered(inode, p, start,
+			btrfs_writepage_endio_finish_ordered(inode, NULL, start,
 							     end, false);
 
-			p->mapping = NULL;
 			extent_clear_unlock_delalloc(inode, start, end, NULL, 0,
 						     PAGE_END_WRITEBACK |
 						     PAGE_SET_ERROR);
-- 
2.32.0

