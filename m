Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5621D3C6A45
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jul 2021 08:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhGMGSV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jul 2021 02:18:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59694 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhGMGSL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jul 2021 02:18:11 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 951CD20057
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626156921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TiduicuKlJYt4NElGYH55QRTj45ZAPRy0BzZAzx3HwA=;
        b=K/gT7bVQ725tZU0SAhRNGafs5j0DWKx9J6MFH768pjeeAJIsUw8suMOpANYqY89mGtyfm1
        4BUX7k42fC9rTsSHvyZilmjQjjzMT6ebymoX5cdxUDEqNjo0xU39yNK0XZuCt8DZLw3P8S
        Ijy90/I+lZeC1SCRwQZBxMVstjSIQZY=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D1965139AC
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id eK+9JHgv7WB0XgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:20 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/27] btrfs: remove unused parameter @nr_pages in add_ra_bio_pages()
Date:   Tue, 13 Jul 2021 14:14:50 +0800
Message-Id: <20210713061516.163318-2-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713061516.163318-1-wqu@suse.com>
References: <20210713061516.163318-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Variable @nr_pages only get increased but never used.
Remove it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 4edfcc3890a5..0d95eed4282c 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -549,7 +549,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 	u64 isize = i_size_read(inode);
 	int ret;
 	struct page *page;
-	unsigned long nr_pages = 0;
 	struct extent_map *em;
 	struct address_space *mapping = inode->i_mapping;
 	struct extent_map_tree *em_tree;
@@ -645,7 +644,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 				   PAGE_SIZE, 0);
 
 		if (ret == PAGE_SIZE) {
-			nr_pages++;
 			put_page(page);
 		} else {
 			unlock_extent(tree, last_offset, end);
-- 
2.32.0

