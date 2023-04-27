Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F476EFF09
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Apr 2023 03:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242725AbjD0Bpz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 21:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjD0Bpy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 21:45:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2577A3C2F;
        Wed, 26 Apr 2023 18:45:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A6A1121A25;
        Thu, 27 Apr 2023 01:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682559950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=bAdAj2f7hwBdihybW+C4eNHtleVU3mjSH49OccF/PGU=;
        b=AhsdGmNop5e1k4EhilVzdSD87fkMUclLAkcZb2hCgH6HgS3VKrbeq5hpqbV6Hwh8Yfafl+
        +boNuTvRye8JiUKnhVj5CnNbne/DaBQDzlWLpGEn0PAkVGNmnSI5oTNukz1zIBumvXcDMx
        P5pt4cQBV+kscURhFta9VnLtbUDHvXo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3A06138F9;
        Thu, 27 Apr 2023 01:45:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V2q3Is3TSWSEGAAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 27 Apr 2023 01:45:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: [PATCH] btrfs: properly reject clear_cache and v1 cache for block-group-tree
Date:   Thu, 27 Apr 2023 09:45:32 +0800
Message-Id: <832315ce8d970a393a2948e4cc21690a1d9e1cac.1682559926.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
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
With block-group-tree feature enabled, mounting it with clear_cache
would cause the following transaction abort at mount or remount:

 BTRFS info (device dm-4): force clearing of disk cache
 BTRFS info (device dm-4): using free space tree
 BTRFS info (device dm-4): auto enabling async discard
 BTRFS info (device dm-4): clearing free space tree
 BTRFS info (device dm-4): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
 BTRFS info (device dm-4): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
 BTRFS error (device dm-4): block-group-tree feature requires fres-space-tree and no-holes
 BTRFS error (device dm-4): super block corruption detected before writing it to disk
 BTRFS: error (device dm-4) in write_all_supers:4288: errno=-117 Filesystem corrupted (unexpected superblock corruption detected)
 BTRFS warning (device dm-4: state E): Skipping commit of aborted transaction.

[CAUSE]
For block-group-tree feature, we have an artificial dependency on
free-space-tree.

This means if we detects block-group-tree without v2 cache, we consider
it a corruption and cause the problem.

For clear_cache mount option, it would temporary disable v2 cache, then
re-enable it.

But unfortunately for that temporary v2 cache disabled status, we refuse
to write a superblock with bg tree only flag, thus leads to the above
transaction abortion.

[FIX]
For now, just reject clear_cache and v1 cache mount option for block
group tree.
So now we got a graceful rejection other than a transaction abort:

 BTRFS info (device dm-4): force clearing of disk cache
 BTRFS error (device dm-4): cannot disable free space tree with block-group-tree feature
 BTRFS error (device dm-4): open_ctree failed

Cc: stable@vger.kernel.org # 6.1+
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
For the proper fix, we need to change the behavior of clear_cache and v1
cache switch.

For pure clear_cache without switch cache version, we should allow
rebuilding v2 cache without fully disable v2 cache.
---
 fs/btrfs/super.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 581845bc206a..eefae0318d4f 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -826,7 +826,12 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	    !btrfs_test_opt(info, CLEAR_CACHE)) {
 		btrfs_err(info, "cannot disable free space tree");
 		ret = -EINVAL;
-
+	}
+	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE) &&
+	    (btrfs_test_opt(info, CLEAR_CACHE) ||
+	     !btrfs_test_opt(info, FREE_SPACE_TREE))) {
+		btrfs_err(info, "cannot disable free space tree with block-group-tree feature");
+		ret = -EINVAL;
 	}
 	if (!ret)
 		ret = btrfs_check_mountopts_zoned(info);
-- 
2.39.2

