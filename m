Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAA7587748
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 08:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiHBGxa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 02:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiHBGx3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 02:53:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B4C60EA
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 23:53:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 81F5C34669
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 06:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659423204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rsY2X5dfb+HPBcJg//a+cskJoPP1LAaskWOS6OGtjkM=;
        b=EwzMrhrVFrMQQNBN9w7rcwjm5uFUOi1i7xw48+2wphqgeP1AMQ824FEfI9F6SA4De06ytn
        zp2v7C1ctg+Q5rWpzLM074cYxvyld2ycJeVvMHJjAWfmDXqe2XyMM/MN9nDbtWL0CZA/4j
        dJ2keSizZj0U9ngAeGtXQ3CQfw3YNsQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB08F1345B
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 06:53:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iAVOJOPJ6GKVHwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Aug 2022 06:53:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: scrub: properly report super block errors in dmesg
Date:   Tue,  2 Aug 2022 14:53:02 +0800
Message-Id: <b883519f45860c76a48e9ab1f12dfa30f52bb809.1659423009.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1659423009.git.wqu@suse.com>
References: <cover.1659423009.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]

Unlike data/metadata corruption, if scrub detected some error in the
super block, the only error message is from the updated device status:

 BTRFS info (device dm-1): scrub: started on devid 2
 BTRFS error (device dm-1): bdev /dev/mapper/test-scratch2 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
 BTRFS info (device dm-1): scrub: finished on devid 2 with status: 0

This is not helpful at all.

[CAUSE]
Unlike data/metadata error reporting, there is no visible report in
kernel dmesg to report supper block errors.

In fact, return value of scrub_checksum_super() is intentionally
skipped, thus scrub_handle_errored_block() will never be called for
super blocks.

[FIX]
Make super block errors to output an error message, now the full
dmesg would looks like this:

 BTRFS info (device dm-1): scrub: started on devid 2
 BTRFS warning (device dm-1): super block error on dev /dev/mapper/test-scratch2, physical 67108864
 BTRFS error (device dm-1): bdev /dev/mapper/test-scratch2 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
 BTRFS info (device dm-1): scrub: finished on devid 2 with status: 0
 BTRFS info (device dm-1): scrub: started on devid 2

This fix involves:

- Move the super_errors reporting to scrub_handle_errored_block()
  This allows the device status message to show after the super block
  error message.
  But now we no longer distinguish super block corruption and generation
  mismatch, now all counted as corruption.

- Properly check the return value from scrub_checksum_super()
- Add extra super block error reporting for scrub_print_warning().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 3afe5fa50a63..0330b1ba1a6a 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -729,6 +729,13 @@ static void scrub_print_warning(const char *errstr, struct scrub_block *sblock)
 	dev = sblock->sectors[0]->dev;
 	fs_info = sblock->sctx->fs_info;
 
+	/* Super block error, no need to search extent tree. */
+	if (sblock->sectors[0]->flags & BTRFS_EXTENT_FLAG_SUPER) {
+		btrfs_warn_in_rcu(fs_info, "%s on dev %s, physical %llu",
+			errstr, rcu_str_deref(dev->name),
+			sblock->sectors[0]->physical);
+		return;
+	}
 	path = btrfs_alloc_path();
 	if (!path)
 		return;
@@ -804,7 +811,7 @@ static inline void scrub_put_recover(struct btrfs_fs_info *fs_info,
 static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 {
 	struct scrub_ctx *sctx = sblock_to_check->sctx;
-	struct btrfs_device *dev;
+	struct btrfs_device *dev = sblock_to_check->sectors[0]->dev;
 	struct btrfs_fs_info *fs_info;
 	u64 logical;
 	unsigned int failed_mirror_index;
@@ -825,13 +832,16 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 	fs_info = sctx->fs_info;
 	if (sblock_to_check->sectors[0]->flags & BTRFS_EXTENT_FLAG_SUPER) {
 		/*
-		 * if we find an error in a super block, we just report it.
+		 * If we find an error in a super block, we just report it.
 		 * They will get written with the next transaction commit
 		 * anyway
 		 */
+		scrub_print_warning("super block error", sblock_to_check);
 		spin_lock(&sctx->stat_lock);
 		++sctx->stat.super_errors;
 		spin_unlock(&sctx->stat_lock);
+		btrfs_dev_stat_inc_and_print(dev,
+					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
 		return 0;
 	}
 	logical = sblock_to_check->sectors[0]->logical;
@@ -840,7 +850,6 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 	is_metadata = !(sblock_to_check->sectors[0]->flags &
 			BTRFS_EXTENT_FLAG_DATA);
 	have_csum = sblock_to_check->sectors[0]->have_csum;
-	dev = sblock_to_check->sectors[0]->dev;
 
 	if (!sctx->is_dev_replace && btrfs_repair_one_zone(fs_info, logical))
 		return 0;
@@ -1762,7 +1771,7 @@ static int scrub_checksum(struct scrub_block *sblock)
 	else if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK)
 		ret = scrub_checksum_tree_block(sblock);
 	else if (flags & BTRFS_EXTENT_FLAG_SUPER)
-		(void)scrub_checksum_super(sblock);
+		ret = scrub_checksum_super(sblock);
 	else
 		WARN_ON(1);
 	if (ret)
@@ -1901,23 +1910,6 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 	if (memcmp(calculated_csum, s->csum, sctx->fs_info->csum_size))
 		++fail_cor;
 
-	if (fail_cor + fail_gen) {
-		/*
-		 * if we find an error in a super block, we just report it.
-		 * They will get written with the next transaction commit
-		 * anyway
-		 */
-		spin_lock(&sctx->stat_lock);
-		++sctx->stat.super_errors;
-		spin_unlock(&sctx->stat_lock);
-		if (fail_cor)
-			btrfs_dev_stat_inc_and_print(sector->dev,
-				BTRFS_DEV_STAT_CORRUPTION_ERRS);
-		else
-			btrfs_dev_stat_inc_and_print(sector->dev,
-				BTRFS_DEV_STAT_GENERATION_ERRS);
-	}
-
 	return fail_cor + fail_gen;
 }
 
-- 
2.37.0

