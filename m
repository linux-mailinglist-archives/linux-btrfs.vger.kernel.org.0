Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948A06D9064
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 09:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbjDFH0w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Apr 2023 03:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjDFH0v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 03:26:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C48619F
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Apr 2023 00:26:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5F8FC1FD90
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Apr 2023 07:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680766008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ppnpn+Z0SgYizyv7FN7/FgOffDzQq81C7D79Ny47Rzs=;
        b=YL4LxOVhpNU35VRH16P99QSdF3O1mVEL/eoABMSgVgi23xAdvY8LuGWZsNJIWg6oEsFaDI
        p12/Z6x2AvneMwRsFjWTsa+0j57GOmxY7y2JnLHGRPr7GH364gNSWZTAwq3Ic1rPct5EFl
        NT2ZdTuM1Dfl9+F372OWpMHDjhXKKFw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0D291351F
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Apr 2023 07:26:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EireIjd0LmThQgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Apr 2023 07:26:47 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: dev-replace: error out if we have unrepaired metadata error during
Date:   Thu,  6 Apr 2023 15:26:29 +0800
Message-Id: <4db115f8781fbf68f30ca82a431cdd931767638d.1680765987.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Even before the scrub rework, if we have some corrupted metadata failed
to be repaired during replace, we still continue replace and let it
finish just as there is nothing wrong:

 BTRFS info (device dm-4): dev_replace from /dev/mapper/test-scratch1 (devid 1) to /dev/mapper/test-scratch2 started
 BTRFS warning (device dm-4): tree block 5578752 mirror 1 has bad csum, has 0x00000000 want 0xade80ca1
 BTRFS warning (device dm-4): tree block 5578752 mirror 0 has bad csum, has 0x00000000 want 0xade80ca1
 BTRFS warning (device dm-4): checksum error at logical 5578752 on dev /dev/mapper/test-scratch1, physical 5578752: metadata leaf (level 0) in tree 5
 BTRFS warning (device dm-4): checksum error at logical 5578752 on dev /dev/mapper/test-scratch1, physical 5578752: metadata leaf (level 0) in tree 5
 BTRFS error (device dm-4): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
 BTRFS warning (device dm-4): tree block 5578752 mirror 1 has bad bytenr, has 0 want 5578752
 BTRFS error (device dm-4): unable to fixup (regular) error at logical 5578752 on dev /dev/mapper/test-scratch1
 BTRFS info (device dm-4): dev_replace from /dev/mapper/test-scratch1 (devid 1) to /dev/mapper/test-scratch2 finished

This can lead to unexpected problems for the result fs.

[CAUSE]
Btrfs reuses scrub code path for dev-replace to iterate all dev extents.

But unlike scrub, dev-replace doesn't really bother to check the scrub
progress, which records all the errors found during replace.

And even if we checks the progress, we can not really determine which
errors are minor, which are critical just by the plain numbers.
(remember we don't treat metadata/data checksum error differently).

This behavior is there from the very beginning.

[FIX]
Instead of continue the replace, just error out if we hit an unrepaired
metadata sector.

Now the dev-replace would be rejected with -EIO, to inform the user.
Although it also means, the fs has some metadata error which can not be
repaired, the user would be super upset anyway.

The new dmesg would look like this:

 BTRFS info (device dm-4): dev_replace from /dev/mapper/test-scratch1 (devid 1) to /dev/mapper/test-scratch2 started
 BTRFS warning (device dm-4): tree block 5578752 mirror 1 has bad csum, has 0x00000000 want 0xade80ca1
 BTRFS warning (device dm-4): tree block 5578752 mirror 1 has bad csum, has 0x00000000 want 0xade80ca1
 BTRFS error (device dm-4): unable to fixup (regular) error at logical 5570560 on dev /dev/mapper/test-scratch1 physical 5570560
 BTRFS warning (device dm-4): header error at logical 5570560 on dev /dev/mapper/test-scratch1, physical 5570560: metadata leaf (level 0) in tree 5
 BTRFS warning (device dm-4): header error at logical 5570560 on dev /dev/mapper/test-scratch1, physical 5570560: metadata leaf (level 0) in tree 5
 BTRFS error (device dm-4): stripe 5570560 has unrepaired metadata sector at 5578752
 BTRFS error (device dm-4): btrfs_scrub_dev(/dev/mapper/test-scratch1, 1, /dev/mapper/test-scratch2) failed -5

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 49 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 8450c7b4b8b9..ea5e1df8d513 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1685,14 +1685,33 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 	btrfs_submit_bio(bbio, mirror);
 }
 
-static void flush_scrub_stripes(struct scrub_ctx *sctx)
+static bool stripe_has_metadata_error(struct scrub_stripe *stripe)
+{
+	int i;
+
+	for_each_set_bit(i, &stripe->error_bitmap, stripe->nr_sectors) {
+		if (stripe->sectors[i].is_metadata) {
+			struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+
+			btrfs_err(fs_info,
+			"stripe %llu has unrepaired metadata sector at %llu",
+				  stripe->logical,
+				  stripe->logical + (i << fs_info->sectorsize_bits));
+			return true;
+		}
+	}
+	return false;
+}
+
+static int flush_scrub_stripes(struct scrub_ctx *sctx)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct scrub_stripe *stripe;
 	const int nr_stripes = sctx->cur_stripe;
+	int ret = 0;
 
 	if (!nr_stripes)
-		return;
+		return ret;
 
 	ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &sctx->stripes[0].state));
 
@@ -1739,6 +1758,18 @@ static void flush_scrub_stripes(struct scrub_ctx *sctx)
 
 	/* Submit for dev-replace. */
 	if (sctx->is_dev_replace) {
+		/*
+		 * For dev-replace, if we know there is something wrong with
+		 * metadata, we should immedately abort.
+		 */
+		for (int i = 0; i < nr_stripes; i++) {
+			stripe = &sctx->stripes[i];
+
+			if (stripe_has_metadata_error(stripe)) {
+				ret = -EIO;
+				goto out;
+			}
+		}
 		for (int i = 0; i < nr_stripes; i++) {
 			unsigned long good;
 
@@ -1759,7 +1790,9 @@ static void flush_scrub_stripes(struct scrub_ctx *sctx)
 		wait_scrub_stripe_io(stripe);
 		scrub_reset_stripe(stripe);
 	}
+out:
 	sctx->cur_stripe = 0;
+	return ret;
 }
 
 static void raid56_scrub_wait_endio(struct bio *bio)
@@ -1776,8 +1809,11 @@ static int queue_scrub_stripe(struct scrub_ctx *sctx,
 	int ret;
 
 	/* No available slot, submit all stripes and wait for them. */
-	if (sctx->cur_stripe >= SCRUB_STRIPES_PER_SCTX)
-		flush_scrub_stripes(sctx);
+	if (sctx->cur_stripe >= SCRUB_STRIPES_PER_SCTX) {
+		ret = flush_scrub_stripes(sctx);
+		if (ret < 0)
+			return ret;
+	}
 
 	stripe = &sctx->stripes[sctx->cur_stripe];
 
@@ -2108,6 +2144,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	const u64 profile = map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK;
 	const u64 chunk_logical = bg->start;
 	int ret;
+	int tmp;
 	u64 physical = map->stripes[stripe_index].physical;
 	const u64 dev_stripe_len = btrfs_calc_stripe_length(em);
 	const u64 physical_end = physical + dev_stripe_len;
@@ -2234,7 +2271,9 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 			break;
 	}
 out:
-	flush_scrub_stripes(sctx);
+	tmp = flush_scrub_stripes(sctx);
+	if (!ret)
+		ret = tmp;
 	if (sctx->raid56_data_stripes) {
 		for (int i = 0; i < nr_data_stripes(map); i++)
 			release_scrub_stripe(&sctx->raid56_data_stripes[i]);
-- 
2.39.2

