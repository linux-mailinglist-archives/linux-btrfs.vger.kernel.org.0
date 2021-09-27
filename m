Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0888E418FE1
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 09:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbhI0HY3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 03:24:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44996 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbhI0HYY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 03:24:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7326D220C0
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632727366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wE8GL9EPLKWWlvQgHaHsCAop6wIHc8wwK/2CPPeK3i8=;
        b=XDPYo9kD/nUUUtevmIUv2JBDkxCf/NNQ4sw2ihgXXXBfeQDr12bg8Zh4xGV7tB5wjDvIM5
        Q4war3dZg0taWGOPs4n6ss/WAAeDfDOJw1vvT12YZlY0jgz8dGM/rgVVptRmaGemtwMJ2T
        3sIElPCAgpDq1IL5wh4yLFx7FYanPsw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CCFBF13A1E
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qATnJUVxUWEVLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:45 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 19/26] btrfs: make end_compressed_bio_writeback() to be subpage compatble
Date:   Mon, 27 Sep 2021 15:22:01 +0800
Message-Id: <20210927072208.21634-20-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927072208.21634-1-wqu@suse.com>
References: <20210927072208.21634-1-wqu@suse.com>
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
index 9a87f949a036..69a19d51fa35 100644
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
2.33.0

