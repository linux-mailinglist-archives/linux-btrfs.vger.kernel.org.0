Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BFD4B623A
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Feb 2022 05:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiBOEqi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Feb 2022 23:46:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiBOEqh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Feb 2022 23:46:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2884863E8
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Feb 2022 20:46:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 27B97210E0;
        Tue, 15 Feb 2022 04:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644900385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=BZfMFVIbPOigokEXPzeWGhUxYAaWo9jt5fSYkOtLZl0=;
        b=pOswSAM3/ghJ0kOJ92CiPYFCcb8VcQy52pZ44Ro3lZuF8cPwfpcdK0Hb9Xw6xTTTlUOHxO
        OtUh3L+X6TVAJJPwvx1b+fbCh32q8Q0djAiFwgOZ95gz85H80KapSP8tOayLaw7CwT/y6q
        E5pnpjavd6fcUN/loUYAq62aPEoZT3k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B812613BC2;
        Tue, 15 Feb 2022 04:46:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1f4XHx8wC2KqDQAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 15 Feb 2022 04:46:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <l@damenly.su>
Subject: [PATCH] btrfs: remove an ASSERT() which can cause false alert
Date:   Tue, 15 Feb 2022 12:46:01 +0800
Message-Id: <8ff11d24e9650cbaed4f52c4ead6184899bcc7b8.1644900321.git.wqu@suse.com>
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
Su reported that with his VM running on an M1 mac, it has a high chance
to trigger the following ASSERT() with scrub and balance test cases:

		ASSERT(cache->start == chunk_offset);
		ret = scrub_chunk(sctx, cache, scrub_dev, found_key.offset,
				  dev_extent_len);

[CAUSE]
The ASSERT() is making sure that the block group cache (@cache) and the
chunk offset from the device extent match.

But the truth is, block group caches and dev extent items are deleted at
different timing.

For block group caches and items, after btrfs_remove_block_group() they
will be marked deleted, but the device extent and the chunk item is
still in dev tree and chunk tree respectively.

The device extents and chunk items are only deleted in
btrfs_remove_chunk(), which happens either a btrfs_delete_unused_bgs()
or btrfs_relocate_chunk().

This timing difference leaves a window where we can have a mismatch
between block group cache and device extent tree, and triggering the
ASSERT().

[FIX]
Just remove the ASSERT().

In fact there are several checks in scrub_chunk() to skip such device
extents.
In scrub_chunk() we do an chunk mapping search, and handling (!em) or
(em->start != bg->start) case by simply exit with ret = 0.

So the ASSERT() is really not necessary.

Please fold this fix into the patch "btrfs: scrub: cleanup the argument
list of scrub_chunk()".

Reported-by: Su Yue <l@damenly.su>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 11089568b287..9c6cf1149f08 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3822,7 +3822,6 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		dev_replace->item_needs_writeback = 1;
 		up_write(&dev_replace->rwsem);
 
-		ASSERT(cache->start == chunk_offset);
 		ret = scrub_chunk(sctx, cache, scrub_dev, found_key.offset,
 				  dev_extent_len);
 
-- 
2.35.1

