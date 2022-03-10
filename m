Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709634D4577
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 12:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241538AbiCJLRV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Mar 2022 06:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiCJLRQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Mar 2022 06:17:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FC3BE1EB
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 03:16:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 58B561F381;
        Thu, 10 Mar 2022 11:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646910974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5WUaBMxgScgrw3aDpNqAJTxD/zOsdQbbgHwOre55kIc=;
        b=fKx6DOKvh/UMJtiT2qYp3873IEzRBIK96o8PHMFXx+CyPy3A3HXUeSCQAQH3xBPuIul6aK
        hZp/EwngF/vQNf93NuylkcXiilSM29KC2UZNAb/72Gu8BVrtFyLCwrlxYM987B6DutSahB
        fdEEBKXu5R7Ddsd/5iw4XwmNzp6xFh0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D8B213FA3;
        Thu, 10 Mar 2022 11:16:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nA5sC/3dKWItCAAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 10 Mar 2022 11:16:13 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] btrfs: scrub: fix uninitialized variables in scrub_raid56_data_stripe_for_parity()
Date:   Thu, 10 Mar 2022 19:15:56 +0800
Message-Id: <7d577c7d7683274c316dda4b8e3a8e2344e4be06.1646829087.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The variable @extent_start and @extent_end will not be initialized if
find_first_extent_item() failed.

Fix this problem by:

- Only define @extent_start and @extent_size inside the while() loop

- Manually call scrub_parity_mark_sectors_error() for error branch

- Remove the scrub_parity_mark_sectors_error() out of the while() loop

Please fold this fix into patch "btrfs: use find_first_extent_item() to
replace the open-coded extent item search"

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 13cfa39f83b9..eb793f72d13b 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3044,8 +3044,6 @@ static int scrub_raid56_data_stripe_for_parity(struct scrub_ctx *sctx,
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, logical);
 	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, logical);
-	u64 extent_start;
-	u64 extent_size;
 	u64 cur_logical = logical;
 	int ret;
 
@@ -3057,6 +3055,8 @@ static int scrub_raid56_data_stripe_for_parity(struct scrub_ctx *sctx,
 		struct btrfs_io_context *bioc = NULL;
 		struct btrfs_device *extent_dev;
 		u64 mapped_length;
+		u64 extent_start;
+		u64 extent_size;
 		u64 extent_flags;
 		u64 extent_gen;
 		u64 extent_physical;
@@ -3118,8 +3118,11 @@ static int scrub_raid56_data_stripe_for_parity(struct scrub_ctx *sctx,
 		ret = btrfs_lookup_csums_range(csum_root, extent_start,
 					       extent_start + extent_size - 1,
 					       &sctx->csum_list, 1);
-		if (ret)
+		if (ret) {
+			scrub_parity_mark_sectors_error(sparity, extent_start,
+							extent_size);
 			break;
+		}
 
 		ret = scrub_extent_for_parity(sparity, extent_start,
 					      extent_size, extent_physical,
@@ -3127,15 +3130,15 @@ static int scrub_raid56_data_stripe_for_parity(struct scrub_ctx *sctx,
 					      extent_gen, extent_mirror_num);
 		scrub_free_csums(sctx);
 
-		if (ret)
+		if (ret) {
+			scrub_parity_mark_sectors_error(sparity, extent_start,
+							extent_size);
 			break;
+		}
 
 		cond_resched();
 		cur_logical += extent_size;
 	}
-	if (ret < 0)
-		scrub_parity_mark_sectors_error(sparity, extent_start,
-						extent_size);
 	btrfs_release_path(path);
 	return ret;
 }
-- 
2.35.1

