Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3268B64F70B
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Dec 2022 03:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiLQCev (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 21:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLQCeu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 21:34:50 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2757369A92
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 18:34:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C369B5FEFC
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Dec 2022 02:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671244487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=BpYjpVZbde/UxdtVKr7KuaVly/5dtMi2x/k8MacgXUw=;
        b=mLp04T5Zs4AyboeFLLp87bV+2JvYXh8JIVU8P6tUd1SBf/PwrGRrbfzBgOrImjwwMxE6u8
        q5+4bv0c6l2gfGolIoq1cf2K5sgSbSKGRlWSGeOmzRw70SVEtrzdSiDyOqKrTp87c34vX0
        nZNNkdYMkZYp3zMMtMTQTjFVJVLNyWQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E92113499
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Dec 2022 02:34:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rUzUMMYqnWP1FAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Dec 2022 02:34:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: scrub: improve its tree block error reporting
Date:   Sat, 17 Dec 2022 10:34:29 +0800
Message-Id: <0ba09faab92972fb164215f3614678678cc0fa16.1671244467.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When debugging a scrub related metadata error, it turns out that our
metadata error reporting is not ideal.

The only 3 error messages are:

- BTRFS error (device dm-2): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 0, gen 1
  Showing we have metadata generation mismatch errors.

- BTRFS error (device dm-2): unable to fixup (regular) error at logical 7110656 on dev /dev/mapper/test-scratch1
  Showing which tree blocks are corrupted.

- BTRFS warning (device dm-2): checksum/header error at logical 24772608 on dev /dev/mapper/test-scratch2, physical 3801088: metadata node (level 1) in tree 5
  Showing which physical range the corrupted metadata is at.

We have to combine the above 3 to know we have a corrupted metadata with
generation mismatch.

And this is already the better case, if we have other problems, like
fsid mismatch, we can not even know the cause.

[CAUSE]
The problem is caused by the fact that, scrub_checksum_tree_block()
never outputs any error message.

It just return two bits for scrub: sblock->header_error, and
sblock->generation_error.

And later we report error in scrub_print_warning(), but unfortunately we
only have two bits, there is not really much thing we can done to print
any detailed errors.

[FIX]
This patch will do the following to enhance the error reporting of
metadata scrub:

- Add extra warning (ratelimited) for every error we hit
  This can help us to distinguish the different types of errors.
  Some errors can help us to know what's going wrong immediately,
  like bytenr mismatch.

- Re-order the checks
  Currently we check bytenr first, then immediately geneartion.
  This can lead to false generation mismatch reports, while the fsid
  mismatches.

Here is the newer output for the bug I'm debugging (we forgot to
writeback tree blocks for commit roots):

 BTRFS warning (device dm-2): tree block 24117248 mirror 1 has bad fsid, has b77cd862-f150-4c71-90ec-7baf0544d83f want 17df6abf-23cd-445f-b350-5b3e40bfd2fc
 BTRFS warning (device dm-2): tree block 24117248 mirror 0 has bad fsid, has b77cd862-f150-4c71-90ec-7baf0544d83f want 17df6abf-23cd-445f-b350-5b3e40bfd2fc

Now we can immediately know it's some tree blocks didn't even get written
back, other than the original confusing generation mismatch.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 52b346795f66..e0004e59b38b 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2053,20 +2053,34 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	 * a) don't have an extent buffer and
 	 * b) the page is already kmapped
 	 */
-	if (sblock->logical != btrfs_stack_header_bytenr(h))
+	if (sblock->logical != btrfs_stack_header_bytenr(h)) {
 		sblock->header_error = 1;
-
-	if (sector->generation != btrfs_stack_header_generation(h)) {
-		sblock->header_error = 1;
-		sblock->generation_error = 1;
+		btrfs_warn_rl(fs_info,
+		"tree block %llu mirror %u has bad bytenr, has %llu want %llu",
+			      sblock->logical, sblock->mirror_num,
+			      btrfs_stack_header_bytenr(h),
+			      sblock->logical);
+		goto out;
 	}
 
-	if (!scrub_check_fsid(h->fsid, sector))
+	if (!scrub_check_fsid(h->fsid, sector)) {
 		sblock->header_error = 1;
+		btrfs_warn_rl(fs_info,
+		"tree block %llu mirror %u has bad fsid, has %pU want %pU",
+			      sblock->logical, sblock->mirror_num,
+			      h->fsid, sblock->dev->fs_devices->fsid);
+		goto out;
+	}
 
 	if (memcmp(h->chunk_tree_uuid, fs_info->chunk_tree_uuid,
-		   BTRFS_UUID_SIZE))
+		   BTRFS_UUID_SIZE)) {
 		sblock->header_error = 1;
+		btrfs_warn_rl(fs_info,
+		"tree block %llu mirror %u has bad chunk tree uuid, has %pU want %pU",
+			      sblock->logical, sblock->mirror_num,
+			      h->chunk_tree_uuid, fs_info->chunk_tree_uuid);
+		goto out;
+	}
 
 	shash->tfm = fs_info->csum_shash;
 	crypto_shash_init(shash);
@@ -2079,9 +2093,27 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	}
 
 	crypto_shash_final(shash, calculated_csum);
-	if (memcmp(calculated_csum, on_disk_csum, sctx->fs_info->csum_size))
+	if (memcmp(calculated_csum, on_disk_csum, sctx->fs_info->csum_size)) {
 		sblock->checksum_error = 1;
+		btrfs_warn_rl(fs_info,
+		"tree block %llu mirror %u has bad csum, has " CSUM_FMT " want " CSUM_FMT,
+			      sblock->logical, sblock->mirror_num,
+			      CSUM_FMT_VALUE(fs_info->csum_size, on_disk_csum),
+			      CSUM_FMT_VALUE(fs_info->csum_size, calculated_csum));
+		goto out;
+	}
 
+	if (sector->generation != btrfs_stack_header_generation(h)) {
+		sblock->header_error = 1;
+		sblock->generation_error = 1;
+		btrfs_warn_rl(fs_info,
+		"tree block %llu mirror %u has bad geneartion, has %llu want %llu",
+			      sblock->logical, sblock->mirror_num,
+			      btrfs_stack_header_generation(h),
+			      sector->generation);
+	}
+
+out:
 	return sblock->header_error || sblock->checksum_error;
 }
 
-- 
2.39.0

