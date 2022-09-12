Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979915B52C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 05:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiILDMX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Sep 2022 23:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiILDMW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Sep 2022 23:12:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A91224948
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Sep 2022 20:12:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BB4D91FDE7
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 03:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662952339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3Xxf9K3QOkx8DKPFNY0NjbrHgUilSuzIDTQ+LOjMbpM=;
        b=jDTS6wkdniwAQoPYwj5UPJVRkH7hoX8T30b9m3JeKVXosgvUYt2TJzTqQ0lPm/fpfTp3Gr
        TuQMMZjSyZUMxibLVRoLVHbHJ18j9vIH/G2/QLkkzFm9wKB7mDVhiec58CKuj5tUQtoXUf
        pfyCZ/T8Als+7MBMQvoGhzTjNZhjGww=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12F52139C8
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 03:12:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R7DyMpKjHmNbRQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 03:12:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: hide block group tree behind experimental feature
Date:   Mon, 12 Sep 2022 11:12:01 +0800
Message-Id: <0b8f20ae26661e040dfcaae90928bbc1c6fff5cd.1662952308.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
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

The block group tree doesn't yet have full bi-directional conversion
support from btrfstune, and it seems we may want one or two release
cycles to rule out some extra bugs before really releasing the progs
support.

This patch will hide the block group tree feature behind experimental
flag for the following tools:

- btrfstune
  "-b" option to convert to bg tree.

- mkfs.btrfs
  hide "block-group-tree" feature from both -O (the new default position
  for all features) and -R (the old, soon to be deprecated one).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfstune.c         | 4 ++++
 common/fsfeatures.c | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/btrfstune.c b/btrfstune.c
index add7b1804400..b9a76ac095f0 100644
--- a/btrfstune.c
+++ b/btrfstune.c
@@ -949,7 +949,11 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 #endif
 			{ NULL, 0, NULL, 0 }
 		};
+#if EXPERIMENTAL
 		int c = getopt_long(argc, argv, "S:rxfuU:nmM:b", long_options, NULL);
+#else
+		int c = getopt_long(argc, argv, "S:rxfuU:nmM:", long_options, NULL);
+#endif
 
 		if (c < 0)
 			break;
diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 5896f66b3e91..67b5b08befc1 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -224,14 +224,16 @@ static const struct btrfs_feature runtime_features[] = {
 		VERSION_TO_STRING2(safe, 4,9),
 		VERSION_TO_STRING2(default, 5,15),
 		.desc		= "free space tree (space_cache=v2)"
+#if EXPERIMENTAL
 	}, {
 		.name		= "block-group-tree",
 		.flag		= BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE,
 		.sysfs_name = "block_group_tree",
-		VERSION_TO_STRING2(compat, 6,0),
+		VERSION_TO_STRING2(compat, 6,2),
 		VERSION_NULL(safe),
 		VERSION_NULL(default),
 		.desc		= "block group tree to reduce mount time"
+#endif
 	},
 	/* Keep this one last */
 	{
-- 
2.37.3

