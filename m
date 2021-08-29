Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC533FA93F
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 07:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbhH2FZ5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 01:25:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45746 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbhH2FZz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 01:25:55 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 157ED20017
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630214703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lNwuEzLTk+QCOipRrVvhTJVVdfuXHtfj7JnXEW6uPiw=;
        b=hzyU6XXSQw+lMstgaCEf1Wik/vmqDqP9WWbb3sTMs5ezDwvYYbVtPFxECyrh14sSdNTk/l
        pHzIHLt37jeG44611vVR83PBR9AvkB1Ri5KX5EZ6pChY6TvS8nrFKPdrOeeP2vch8vWTxc
        t7YlV/bZdWpfIf/UUlst7h8zh/xUIY0=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 53C3C13964
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id kOsZBi4aK2HnPAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:02 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 01/26] btrfs: remove unused parameter @nr_pages in add_ra_bio_pages()
Date:   Sun, 29 Aug 2021 13:24:33 +0800
Message-Id: <20210829052458.15454-2-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829052458.15454-1-wqu@suse.com>
References: <20210829052458.15454-1-wqu@suse.com>
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
index 7869ad12bc6e..a26ce27ad005 100644
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

