Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6ED42D35C
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 09:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhJNHS6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 03:18:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42038 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhJNHS5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 03:18:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A2CE121A74;
        Thu, 14 Oct 2021 07:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634195812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=iuoBSf13eNQxEpgaAxyg2ZGFZsjzqW6qjTQLxefz8CM=;
        b=Hx2dgPWGNu6V+OOPYdVvyQpwv9yVCDXXmgbkrS3jsz4HyvgmQOqhE9VtRvwP44qDkRgteK
        Mq5TNif3semmY2F30zm5h2R16rU6dmr3v9DODHkN1RpsF5FyGlVDYQ90NTFwVaa3pQs2Wh
        aUky1/kwc/EfpSemNyrIM96KlDJq8Ys=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C721C13D3F;
        Thu, 14 Oct 2021 07:16:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ll1IJGPZZ2FQFgAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 14 Oct 2021 07:16:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH] btrfs: fix a triggered ASSERT() for generic/029 when executed with compression
Date:   Thu, 14 Oct 2021 15:16:34 +0800
Message-Id: <20211014071634.29738-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running generic/029 test with "-o compress" mount option, it will
crash with the following ASSERT() triggered:

  assertion failed: PageLocked(page), in fs/btrfs/extent_io.c:5150
  ------------[ cut here ]------------
  kernel BUG at fs/btrfs/ctree.h:3495!
  RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
  Call Trace:
   extent_write_locked_range.cold+0x11/0x44 [btrfs]
   submit_compressed_extents+0x42f/0x440 [btrfs]
   async_cow_submit+0x37/0x90 [btrfs]
   btrfs_work_helper+0x132/0x3e0 [btrfs]
   process_one_work+0x294/0x5d0
   worker_thread+0x55/0x3c0
   kthread+0x140/0x170
   ret_from_fork+0x22/0x30
  ---[ end trace 32cf9a3b0c96a939 ]---

[CAUSE]
Function extent_write_locked_range() expects all its pages being locked
since btrfs_run_delalloc_range().
Thus the ASSERT() in it is doing the correct check.

The problem is in submit_uncompressed_range(), which calls
cow_file_range() to create ordered extent for it.

But since cow_file_range() can inline the data, callers must check if
cow_file_range() created an inline extent, and handle it properly.

Unfortunately commit c12036efa894 ("btrfs: factor uncompressed async
extent submission code into a new helper") did a wrong refactor, which
uses "ret > 0" to check if cow_file_range() created an inline extent.

The correct check should be "page_start".

This causes submit_compressed_extents() always call
extent_write_locked_range() even we have created an inline extent.

And when an inline extent is created, the page is unlocked and dirty bit
cleared, which will trigger the new ASSERT() in
extent_write_locked_range().

[FIX]
Use the proper condition to check if cow_file_range() created an inline
extent.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---

This commit can be fixed into the offending refactor.
It looks like I can't escape the recent destiny that refactors are
introducing more bugs.
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b9c70a073a24..cb802a55391c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -899,7 +899,7 @@ static int submit_uncompressed_range(struct btrfs_inode *inode,
 	ret = cow_file_range(inode, locked_page, start, end, &page_started,
 			     &nr_written, 0);
 	/* Inline extent inserted, page gets unlocked and everything is done */
-	if (ret > 0) {
+	if (page_started) {
 		ret = 0;
 		goto out;
 	}
-- 
2.33.0

