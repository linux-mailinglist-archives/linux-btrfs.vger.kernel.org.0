Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5E43FA951
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 07:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbhH2F0R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 01:26:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59398 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbhH2F0R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 01:26:17 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E9F5F21D6A
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630214724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OawqWwuUDuWuzEgwCMslzCgEH3puAhpaawAMB3aNKsM=;
        b=a8DUaBKo68TtJqpX8o+qTHhP56eSrDwIopVhoG5AA7vVCF7k64r90kN2gC1WZkkTg0qXCh
        wTilVVpqdl9SWo0xNXkL8bx2rMvWqCnEiC+qHvfCzVB3+SJo6IWuOMbDGlC8hZ/PIUETbW
        zWI/LT7nIyIZzwe1pMExVlV/lXFkqQE=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3313513964
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 8MW1OUMaK2HnPAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 19/26] btrfs: make end_compressed_bio_writeback() to be subpage compatble
Date:   Sun, 29 Aug 2021 13:24:51 +0800
Message-Id: <20210829052458.15454-20-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829052458.15454-1-wqu@suse.com>
References: <20210829052458.15454-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In end_compressed_writeback() we just clear the full page writeback.
For subpage case, if there are two delalloc range in the same page, the
2nd range will trigger a BUG_ON() as the page writeback is already
cleared by previous range.

Fix it by using btrfs_page_clamp_clear_writeback() helper.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 6bfa626bbd0b..ef3d409a1bc3 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -336,6 +336,7 @@ static void end_compressed_bio_read(struct bio *bio)
 static noinline void end_compressed_writeback(struct inode *inode,
 					      const struct compressed_bio *cb)
 {
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	unsigned long index = cb->start >> PAGE_SHIFT;
 	unsigned long end_index = (cb->start + cb->len - 1) >> PAGE_SHIFT;
 	struct page *pages[16];
@@ -358,7 +359,8 @@ static noinline void end_compressed_writeback(struct inode *inode,
 		for (i = 0; i < ret; i++) {
 			if (cb->errors)
 				SetPageError(pages[i]);
-			end_page_writeback(pages[i]);
+			btrfs_page_clamp_clear_writeback(fs_info, pages[i],
+							 cb->start, cb->len);
 			put_page(pages[i]);
 		}
 		nr_pages -= ret;
-- 
2.32.0

