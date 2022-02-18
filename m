Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6305B4BAF7A
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 03:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiBRCNh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Feb 2022 21:13:37 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiBRCNg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Feb 2022 21:13:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB69E1F1770
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 18:13:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 55CE61F383
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 02:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645150399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=iQdYa0DoMPpSSO3oPfC/dLDoi1SxFlMiMLkngMHDNxs=;
        b=BbRPFUdqrWC1oa+1s8J2Yp1JDz/K5swAiAk8jkXqmdH0piX4ZD1DdZXhWlQ8lh3X5zhNZF
        p5yHRLQF5j7FgvjdSx+BZLX8bCVosj7InFrEzwmDpxNI7FcHUqsT0y8Lx0Ql9E/a5cTQPx
        5Bhe4YhftQGzThQjO43bsT9bbBkCv7I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E86013BFC
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 02:13:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /b23FL4AD2LBVwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 02:13:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: subpage: fix a wrong check on subpage->writers
Date:   Fri, 18 Feb 2022 10:13:00 +0800
Message-Id: <486801f8e45849c882c2531fe72b6a120429be07.1645150277.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When looping btrfs/074 with 64K page size and 4K sectorsize, there is a low
chance (1/50~1/100) to crash with the following ASSERT() triggered in
btrfs_subpage_start_writer():

	ret = atomic_add_return(nbits, &subpage->writers);
	ASSERT(ret == nbits); <<< This one <<<

[CAUSE]
With more debugging output on the parameters of
btrfs_subpage_start_writer(), it shows a very concerning error:

  ret=29 nbits=13 start=393216 len=53248

For @nbits it's correct, but @ret which is the returned value from
atomic_add_return(), it's not only larger than nbits, but also larger
than max sectors per page value (for 64K page size and 4K sector size,
it's 16).

This indicates that some call sites are not properly decreasing the value.

And that's exactly the case, in btrfs_page_unlock_writer(), due to the
fact that we can have page locked either by lock_page() or
process_one_page(), we have to check if the subpage has any writer.

If no writers, it's locked by lock_page() and we only need to unlock it.

But unfortunately the check for the writers are completely opposite:

	if (atomic_read(&subpage->writers))
		/* No writers, locked by plain lock_page() */
		return unlock_page(page);

We directly unlock the page if it has writers, which is the completely
opposite what we want.

Thankfully the affected call site is only limited to
extent_write_locked_range(), so it's mostly affecting compressed write.

[FIX]
Just fix the wrong check condition to fix the bug.

Fixes: e55a0de18572 ("btrfs: rework page locking in __extent_writepage()")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 29bd8c7a7706..ef7ae20d2b77 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -736,7 +736,7 @@ void btrfs_page_unlock_writer(struct btrfs_fs_info *fs_info, struct page *page,
 	 * Since we own the page lock, no one else could touch subpage::writers
 	 * and we are safe to do several atomic operations without spinlock.
 	 */
-	if (atomic_read(&subpage->writers))
+	if (atomic_read(&subpage->writers) == 0)
 		/* No writers, locked by plain lock_page() */
 		return unlock_page(page);
 
-- 
2.35.1

