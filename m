Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2083B59EA27
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 19:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiHWRsx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 13:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiHWRsa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 13:48:30 -0400
X-Greylist: delayed 1106 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 Aug 2022 08:46:59 PDT
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F92A6C0B
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 08:46:58 -0700 (PDT)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1oQVpK-0002EO-De; Tue, 23 Aug 2022 17:28:26 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: don't print information about space cache or tree every remount
Date:   Tue, 23 Aug 2022 17:28:20 +0200
Message-Id: <ca82edf897ae4cbd71277e76f43c6631ffd26b5a.1661268435.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

btrfs currently prints information about space cache or free space tree
being in use on every remount, regardless whether such remount actually
enabled or disabled one of these features.

This is actually unnecessary since providing remount options changing the
state of these features will explicitly print the appropriate notice.

Let's instead print such unconditional information just on an initial mount
to avoid filling the kernel log when, for example, laptop-mode-tools
remount the fs on some events.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 fs/btrfs/super.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2535f96612856..16fdfaad103da 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -626,6 +626,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	int saved_compress_level;
 	bool saved_compress_force;
 	int no_compress = 0;
+	bool remounting = test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state);
 
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
 		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
@@ -1137,10 +1138,12 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	}
 	if (!ret)
 		ret = btrfs_check_mountopts_zoned(info);
-	if (!ret && btrfs_test_opt(info, SPACE_CACHE))
-		btrfs_info(info, "disk space caching is enabled");
-	if (!ret && btrfs_test_opt(info, FREE_SPACE_TREE))
-		btrfs_info(info, "using free space tree");
+	if (!ret && !remounting) {
+		if (btrfs_test_opt(info, SPACE_CACHE))
+			btrfs_info(info, "disk space caching is enabled");
+		if (btrfs_test_opt(info, FREE_SPACE_TREE))
+			btrfs_info(info, "using free space tree");
+	}
 	return ret;
 }
 
