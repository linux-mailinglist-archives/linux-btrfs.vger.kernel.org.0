Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEB4764670
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jul 2023 08:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjG0GIV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 02:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjG0GIU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 02:08:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6068E42
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 23:08:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7BFEB1F889
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 06:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690438095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XpaeZMYnxdnM3UZRru4b9vusUEF2qI0ENyMWu6ACE9Y=;
        b=kVs/95fK4dz0CdbtIO4BoKDVWUftopQfDsA0tKS/R6kDTP07dwwU3OJbVtAUHMQsF8XLEx
        1Hs7oysjqM3gEB5MxTn6wQhMjHRWNLTxTftflKnxoqOYUB4McdT1FesUoIFmqqpTdY+2QP
        wleJtWTGuuWzlUlk17Wksc/nKnlVXO0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B80C613902
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 06:08:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uI1aHs4JwmQdDwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 06:08:14 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: do not commit transaction canceling a suspended replace
Date:   Thu, 27 Jul 2023 14:07:54 +0800
Message-ID: <18f1e6d4afa0db4aad56569bbab15b220f03236f.1690437675.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690437675.git.wqu@suse.com>
References: <cover.1690437675.git.wqu@suse.com>
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

[BUG]
There is a very rare corner case that, if the filesystem falls into a
deadly ENOSPC trap (metadata is so full that committing a transaction
would trigger transaction abort and falls RO), and the user needs to
cancel a suspended dev-replace, it would fail.

This is because the dev-replace canceling itself would commit the
current transaction, and falls RO first.

[CAUSE]
There are two involved situations:

- Cancel a running dev-replace
  We just call btrfs_scrub_cancel(), it doesn't commit transaction
  anyway.

- Cancel a suspended dev-replace
  We only need to cleanup the various in-memory replace structure, which
  is no difference than the previous situation.

  But in this case we commit transaction, and may trigger the deadly
  ENOSPC trap.

[FIX]
Just follow the first case, do not commit transaction when not needed.

Link: https://lore.kernel.org/linux-btrfs/CA+W5K0pQyJH5zWxs4JxfHR06DSUWDOcDPNsKxbdKQ_CiUtpyUg@mail.gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/dev-replace.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index fff22ed55c42..35590f17a5d7 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -1056,8 +1056,6 @@ int btrfs_dev_replace_cancel(struct btrfs_fs_info *fs_info)
 	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
 	struct btrfs_device *tgt_device = NULL;
 	struct btrfs_device *src_device = NULL;
-	struct btrfs_trans_handle *trans;
-	struct btrfs_root *root = fs_info->tree_root;
 	int result;
 	int ret;
 
@@ -1112,14 +1110,6 @@ int btrfs_dev_replace_cancel(struct btrfs_fs_info *fs_info)
 		/* Scrub for replace must not be running in suspended state */
 		btrfs_scrub_cancel(fs_info);
 
-		trans = btrfs_start_transaction(root, 0);
-		if (IS_ERR(trans)) {
-			mutex_unlock(&dev_replace->lock_finishing_cancel_unmount);
-			return PTR_ERR(trans);
-		}
-		ret = btrfs_commit_transaction(trans);
-		WARN_ON(ret);
-
 		btrfs_info_in_rcu(fs_info,
 		"suspended dev_replace from %s (devid %llu) to %s canceled",
 			btrfs_dev_name(src_device), src_device->devid,
-- 
2.41.0

