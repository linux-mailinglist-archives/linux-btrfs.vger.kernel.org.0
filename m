Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A7766B7B8
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 08:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjAPHEo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Jan 2023 02:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjAPHEn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 02:04:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575718A5B
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Jan 2023 23:04:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 13D8F34F24
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673852681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WgGfoHWtSRGCAhhD/AHGgHm7JO9wY8tXS3mwvHdNhow=;
        b=YOMUIVykVGRZ1AZRm4DlMf7XS2KNnX60EdiR0Rw/uH7/ooHDFFTYSgq+R82amRBX8MWBKC
        IS+iLqv9DEeXK3zg+/ln/uQzazMbI0eGxTN0p5iVVWFvhJV3KIlhcmm6Ziv1dj5eXBmAsR
        9uqBNLQlWFkQwPr3ROxyCYM+b47dQB4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 655A8138FA
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kNGgDAj3xGMfZwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:40 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/11] btrfs: remove unused @path inside scrub_stripe()
Date:   Mon, 16 Jan 2023 15:04:12 +0800
Message-Id: <716c80826f14a61bf87398cf0b4b99ba846954bf.1673851704.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673851704.git.wqu@suse.com>
References: <cover.1673851704.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The variable @path is no longer passed into any call sites after commit
18d30ab96149 ("btrfs: scrub: use scrub_simple_mirror() to handle RAID56
data stripe scrub"), thus we can remove the variable completely.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 10c26bc8e60e..e241e2a35bfd 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3607,7 +3607,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   struct btrfs_device *scrub_dev,
 					   int stripe_index)
 {
-	struct btrfs_path *path;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_root *root;
 	struct btrfs_root *csum_root;
@@ -3629,19 +3628,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	u64 stripe_end;
 	int stop_loop = 0;
 
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	/*
-	 * work on commit root. The related disk blocks are static as
-	 * long as COW is applied. This means, it is save to rewrite
-	 * them to repair disk errors without any race conditions
-	 */
-	path->search_commit_root = 1;
-	path->skip_locking = 1;
-	path->reada = READA_FORWARD;
-
 	wait_event(sctx->list_wait,
 		   atomic_read(&sctx->bios_in_flight) == 0);
 	scrub_blocked_if_needed(fs_info);
@@ -3761,7 +3747,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	mutex_unlock(&sctx->wr_lock);
 
 	blk_finish_plug(&plug);
-	btrfs_free_path(path);
 
 	if (sctx->is_dev_replace && ret >= 0) {
 		int ret2;
-- 
2.39.0

