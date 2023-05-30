Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277D7715309
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 03:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjE3Bpx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 21:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjE3Bpv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 21:45:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C14DB
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 18:45:50 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 603121F8B9
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 01:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685411149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5H5u0t0nx4dMqk0Q92K2zA80bt2OXfTw4ANhNdg4bSU=;
        b=YNZBEF2TLEQLJoxGqV06w1AZuPKsAcHVwzxAGr0ow/jGp08HHFhRvny4iBfyPJ9BQXPO1l
        Yp8b0as5SqPwzPMDcBkSD/r6ag1GsOzuaP1ra4oD01Vk/WvBHgkMhkqj7WcyDJRY443ehb
        dAGKSOgTyDnkQn2K7lwanttNX2uPhz8=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id CE285132F3
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 01:45:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id KFbDJ0xVdWSIJwAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 01:45:48 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: use the same @uptodate variable for end_bio_extent_readpage()
Date:   Tue, 30 May 2023 09:45:28 +0800
Message-Id: <65fed3703d077362b9a7b3ec393452c40b6895db.1685411033.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685411033.git.wqu@suse.com>
References: <cover.1685411033.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In function end_bio_extent_readpage() we call
endio_readpage_release_extent() to unlock the extent io tree.

However we pass PageUptodate(page) as @uptodate parameter for it, while
for previous end_page_read() call, we use a dedicated @uptodate local
variable.

This is not a big deal, as even for subpage cases, either the bio only
covers part of the page, then the @uptodate is always false, and the
subpage ranges can still be merged.

But for the sake of consistency, always use @uptodate variable when
possible.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9afdcf0c70dd..2d228cc8b401 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -745,7 +745,7 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 		/* Update page status and unlock. */
 		end_page_read(page, uptodate, start, len);
 		endio_readpage_release_extent(&processed, BTRFS_I(inode),
-					      start, end, PageUptodate(page));
+					      start, end, uptodate);
 
 		ASSERT(bio_offset + len > bio_offset);
 		bio_offset += len;
-- 
2.40.1

