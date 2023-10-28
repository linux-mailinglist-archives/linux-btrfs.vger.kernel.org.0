Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94AB7DA4EB
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Oct 2023 04:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjJ1C7N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Oct 2023 22:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1C7M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Oct 2023 22:59:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BC4106
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Oct 2023 19:59:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7420B21B29
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Oct 2023 02:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698461945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VO7c8ZVNU29e+5DTPTW/Y+3giTIyp0HLP4MsEbw7zE0=;
        b=OfZf0RS5O5m0R7kEDKjWPzgiJpAWKO0l7fLone+G6u2gKPlfhVMY6tld23cuvy6Z88ykNN
        1XoVwMyU6Gz2+WW1J0x8+wcDU7X+eVFpSvjpRm6qsSn669cXodrO07hlPZ7bo3I8vL2eSe
        FjM9U27TJDSjnDylq/sxnzyBiL92+yY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D9B91391D
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Oct 2023 02:59:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gqOfA/h4PGV/IAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Oct 2023 02:59:04 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: make found_logical_ret parameter mandatory for function queue_scrub_stripe()
Date:   Sat, 28 Oct 2023 13:28:45 +1030
Message-ID: <4da50284fed071fea6d629f09d318f70a4e42c47.1698461922.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -6.10
X-Spamd-Result: default: False [-6.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
         RCPT_COUNT_ONE(0.00)[1];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a compiling warning reported on commit ae76d8e3e135 ("btrfs:
scrub: fix grouping of read IO"), where gcc (14.0.0 20231022 experimental)
is reporting the following uninitialized variable:

  fs/btrfs/scrub.c: In function ‘scrub_simple_mirror.isra’:
  fs/btrfs/scrub.c:2075:29: error: ‘found_logical’ may be used uninitialized [-Werror=maybe-uninitialized[https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wmaybe-uninitialized]]
   2075 |                 cur_logical = found_logical + BTRFS_STRIPE_LEN;
  fs/btrfs/scrub.c:2040:21: note: ‘found_logical’ was declared here
   2040 |                 u64 found_logical;
        |                     ^~~~~~~~~~~~~

[CAUSE]
This is a false alert, as @found_logical is passed as parameter
@found_logical_ret of function queue_scrub_stripe().

As long as queue_scrub_stripe() returned 0, we would update
@found_logical_ret.
And if queue_scrub_stripe() returned >0 or <0, the caller would not
utilized @found_logical, thus there should be nothing wrong.

Although the triggering gcc is still experimental, it looks like the
extra check on "if (found_logical_ret)" can sometimes confuse the
compiler.

Meanwhile the only caller of queue_scrub_stripe() is always passing a
valid pointer, there is no need for such check at all.

[FIX]
Although the report itself is a false alert, we can still make it more
explicit by:

- Replace the check for @found_logical_ret with ASSERT()

- Initialize @found_logical to U64_MAX

- Add one extra ASSERT() to make sure @found_logical got updated

Link: https://lore.kernel.org/linux-btrfs/87fs1x1p93.fsf@gentoo.org/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 9ce5be21b036..e6160e8dc39d 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1868,6 +1868,9 @@ static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *
 	 */
 	ASSERT(sctx->cur_stripe < SCRUB_TOTAL_STRIPES);
 
+	/* @found_logical_ret must be specified. */
+	ASSERT(found_logical_ret);
+
 	stripe = &sctx->stripes[sctx->cur_stripe];
 	scrub_reset_stripe(stripe);
 	ret = scrub_find_fill_first_stripe(bg, &sctx->extent_path,
@@ -1876,8 +1879,7 @@ static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *
 	/* Either >0 as no more extents or <0 for error. */
 	if (ret)
 		return ret;
-	if (found_logical_ret)
-		*found_logical_ret = stripe->logical;
+	*found_logical_ret = stripe->logical;
 	sctx->cur_stripe++;
 
 	/* We filled one group, submit it. */
@@ -2080,7 +2082,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 
 	/* Go through each extent items inside the logical range */
 	while (cur_logical < logical_end) {
-		u64 found_logical;
+		u64 found_logical = U64_MAX;
 		u64 cur_physical = physical + cur_logical - logical_start;
 
 		/* Canceled? */
@@ -2115,6 +2117,11 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 		if (ret < 0)
 			break;
 
+		/*
+		 * queue_scrub_stripe() returned 0, @found_logical must be
+		 * updated.
+		 */
+		ASSERT(found_logical != U64_MAX);
 		cur_logical = found_logical + BTRFS_STRIPE_LEN;
 
 		/* Don't hold CPU for too long time */
-- 
2.42.0

