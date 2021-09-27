Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E004418FD2
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 09:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbhI0HYR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 03:24:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56818 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbhI0HYJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 03:24:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 16FEE200A1
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632727351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ie6NwNxMWe30UrATIA53bomy6fbUSe3VZHi35baslRY=;
        b=DIEWcBpSog7HzwO8s2XJWF1vLbwrzsI57Bs6HcTZ8BPO7ya6ctuWucU916PQAlGqZhGH5B
        39xCSHn05dmALIEDDN/tieJg0r2Y7sOlFK95vpWZEIiiCprdWUKYDrHaYsT9xAYdl7NtEI
        PXEhgA2+9liiE231DrMqlH1qzSSIjHM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 711FD13A1E
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WMpuDzZxUWEVLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 04/26] btrfs: don't pass compressed pages to btrfs_writepage_endio_finish_ordered()
Date:   Mon, 27 Sep 2021 15:21:46 +0800
Message-Id: <20210927072208.21634-5-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927072208.21634-1-wqu@suse.com>
References: <20210927072208.21634-1-wqu@suse.com>
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
index 3aa820d64b94..c559726dca3f 100644
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
2.33.0

