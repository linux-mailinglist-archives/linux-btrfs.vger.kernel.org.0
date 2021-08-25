Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506163F6EE5
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 07:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbhHYFmg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Aug 2021 01:42:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47326 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbhHYFmd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Aug 2021 01:42:33 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 053631FDDA
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Aug 2021 05:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629870106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sKkzLZXK2LNlrwc9a8SflH0jpQhQK3koUZmNJybEjsw=;
        b=dMbegpS6X9L9I+Ln9mi564dtBid2aKbYOsYGc1CDJMhXIdUjeHGD7zCXX7PMAoreAu8b0B
        BxkwqBEm4Z9hP18aX30Ge+AXZTC6UkfoGCNu88fY1b8crStv2dsm8gLcBdw08MfMMyVcii
        1epKnnZjXCu6AJWTjZWyrS7EIzHp4Xo=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 39FC313929
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Aug 2021 05:41:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id g0wtOhjYJWF/VgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Aug 2021 05:41:44 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Revert "btrfs: compression: don't try to compress if we don't have enough pages"
Date:   Wed, 25 Aug 2021 13:41:42 +0800
Message-Id: <20210825054142.11579-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This reverts commit f2165627319ffd33a6217275e5690b1ab5c45763.

[BUG]
It's no longer possible to create compressed inline extent after commit
f2165627319f ("btrfs: compression: don't try to compress if we don't
have enough pages").

[CAUSE]
For compression code, there are several possible reasons we have a range
that needs to be compressed while it's no more than one page.

- Compressed inline write
  The data is always smaller than one sector.

- Compressed subpage write
  For the incoming subpage compressed write support, we require page
  alignment of the delalloc range.
  And for 64K page size, we can compress just one page into smaller
  sectors.

For those reasons, the requirement for the data to be more than one page
is not correct, and is already causing regression for compressed inline
data writeback.

[FIX]
Fix it by reverting the offending commit.

Fixes: f2165627319f ("btrfs: compression: don't try to compress if we don't have enough pages")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2aa9646bce56..2b7fe98adec2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -632,7 +632,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 	 * inode has not been flagged as nocompress.  This flag can
 	 * change at any time if we discover bad compression ratios.
 	 */
-	if (nr_pages > 1 && inode_need_compress(BTRFS_I(inode), start, end)) {
+	if (inode_need_compress(BTRFS_I(inode), start, end)) {
 		WARN_ON(pages);
 		pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
 		if (!pages) {
-- 
2.32.0

