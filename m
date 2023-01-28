Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15C967F63D
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Jan 2023 09:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjA1IXj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Jan 2023 03:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjA1IXi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Jan 2023 03:23:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA263E63E
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Jan 2023 00:23:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 85EF12227D
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Jan 2023 08:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674894215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+eAHnDrpmXN/ysGyz4BQYN6bNZxeclejYXsDe4AFA14=;
        b=YSSWc9PwzHdJZNzde+3wQUOasjHEBdiCT+hAF7I3HpjJvST0zfnW6h287aMAqZZwaU9RoB
        ALCt3CPbOD0lLuVtMfbt3FJxYT39d9kCcVxFhqA3QI/jm0w4/QMaYRldekWrU995tTSLFQ
        omBw35LxwfKKTGBGC9LWrRt7iyJAPhA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0121139BD
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Jan 2023 08:23:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6O1sJobb1GPqGwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Jan 2023 08:23:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: simplify the @bioc argument for handle_ops_on_dev_replace()
Date:   Sat, 28 Jan 2023 16:23:14 +0800
Message-Id: <92276451bbeed279f8c04bc9ce684f42a25cfc92.1674893735.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674893735.git.wqu@suse.com>
References: <cover.1674893735.git.wqu@suse.com>
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

There is no memory re-allocation for handle_ops_on_dev_replace(), thus
we don't need to pass a struct btrfs_io_context ** pointer.

Just a regular struct btrfs_io_contex * pointer is enough.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 883e5d2a23b6..66d44167f7b1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6168,12 +6168,11 @@ static bool is_block_group_to_copy(struct btrfs_fs_info *fs_info, u64 logical)
 }
 
 static void handle_ops_on_dev_replace(enum btrfs_map_op op,
-				      struct btrfs_io_context **bioc_ret,
+				      struct btrfs_io_context *bioc,
 				      struct btrfs_dev_replace *dev_replace,
 				      u64 logical,
 				      int *num_stripes_ret, int *max_errors_ret)
 {
-	struct btrfs_io_context *bioc = *bioc_ret;
 	u64 srcdev_devid = dev_replace->srcdev->devid;
 	int tgtdev_indexes = 0;
 	int num_stripes = *num_stripes_ret;
@@ -6262,7 +6261,6 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 	*num_stripes_ret = num_stripes;
 	*max_errors_ret = max_errors;
 	bioc->num_tgtdevs = tgtdev_indexes;
-	*bioc_ret = bioc;
 }
 
 static bool need_full_stripe(enum btrfs_map_op op)
@@ -6604,7 +6602,7 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 
 	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
 	    need_full_stripe(op)) {
-		handle_ops_on_dev_replace(op, &bioc, dev_replace, logical,
+		handle_ops_on_dev_replace(op, bioc, dev_replace, logical,
 					  &num_stripes, &max_errors);
 	}
 
-- 
2.39.1

