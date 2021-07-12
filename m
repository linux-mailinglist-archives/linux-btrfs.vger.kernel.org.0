Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B653C57B2
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jul 2021 12:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352823AbhGLIgw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jul 2021 04:36:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60684 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357919AbhGLIdW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jul 2021 04:33:22 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A00022104;
        Mon, 12 Jul 2021 08:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626078633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZCcW3sFYx+d1CSNl6qWBoewS1Tm4qQgwOzqh0mxnvPc=;
        b=ULf8GG/UtBWK234mkVL/lbgJ+KPBkz3OFLPPxUjWTca9EVOqQON+MHNxGiJJk5vYxfSO2i
        avhbFrvQv0lIZc8ThjrzbAQUxeoxMOh7stjIbRMjQFvHo3b/1xyvujF3X8O5n8qzsbJo8X
        4IJSlaVMW+ZJOe+MHndTjmqjO4u31oE=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 24E7213455;
        Mon, 12 Jul 2021 08:30:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id cLZdNaf962ByEAAAGKfGzw
        (envelope-from <wqu@suse.com>); Mon, 12 Jul 2021 08:30:31 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 01/17] btrfs: properly reset @this_bio_flag in btrfs_do_readpage() to avoid inheriting old bio flags to next extent
Date:   Mon, 12 Jul 2021 16:30:11 +0800
Message-Id: <20210712083027.212734-2-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210712083027.212734-1-wqu@suse.com>
References: <20210712083027.212734-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_do_readpage(), we never reset @this_bio_flag after we hit a
compressed extent.

This is fine, as for PAGE_SIZE == sectorsize case, we can only have one
sector for one page, thus @this_bio_flag will only be set at most once.

But for subpage case, after hitting a compressed extent, @this_bio_flag
will always have EXTENT_BIO_COMPRESSED bit, even we're reading a regular
extent.

This will lead to various read error, and causing new ASSERT() in
incoming subpage patches, which adds more strict check in
btrfs_submit_compressed_read().

Fix it by declaring @this_bio_flag inside the main loop and reset its
value for each iteration.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1f947e24091a..a834ba61a729 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3487,7 +3487,6 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 	size_t pg_offset = 0;
 	size_t iosize;
 	size_t blocksize = inode->i_sb->s_blocksize;
-	unsigned long this_bio_flag = 0;
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 
 	ret = set_page_extent_mapped(page);
@@ -3518,6 +3517,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 	}
 	begin_page_read(fs_info, page);
 	while (cur <= end) {
+		unsigned long this_bio_flag = 0;
 		bool force_bio_submit = false;
 		u64 disk_bytenr;
 
-- 
2.32.0

