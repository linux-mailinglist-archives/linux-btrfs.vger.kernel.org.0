Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8563C6A57
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jul 2021 08:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbhGMGSe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jul 2021 02:18:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59732 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbhGMGSd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jul 2021 02:18:33 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7294B20057
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626156943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S4/70l8aekAtKbYr2mMHL+RCkdlNjxwpURxNrg2YTno=;
        b=A4IfdLLlOJy1nTiomK4Vk9s2XBi88PvEaxrsl8jRFjz9J0Ia7XdSNrP6Z+S9rFQsPegWAW
        XwYWXAxR7XfhwRrdzdtY8yr7OgjmEHOybUKYTN38ZkCcCe3bwKV+1ZariIgafY8gb6CHom
        0gCiZfbmqLa5UFvdnSFIzNUMAj9KJ54=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B087C139AC
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id GP6kHI4v7WB0XgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 19/27] btrfs: make end_compressed_bio_writeback() to be subpage compatble
Date:   Tue, 13 Jul 2021 14:15:08 +0800
Message-Id: <20210713061516.163318-20-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713061516.163318-1-wqu@suse.com>
References: <20210713061516.163318-1-wqu@suse.com>
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
index d2d943e1f648..b4aa29965c69 100644
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

