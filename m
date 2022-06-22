Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68804555494
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 21:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347354AbiFVTe0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 15:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377843AbiFVTdx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 15:33:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF6840E4D
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 12:32:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D320421B69;
        Wed, 22 Jun 2022 19:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655926360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=U+5gBq/+cNMkLgV/bTRq41UIm8bJJShy/psahyC196o=;
        b=lkWGiOiQy0KRMqU3Z6/sQMv3kFuLArCFjJ/N+Ucbf2qkWEP7x6MLL+OC+IiVyqwVep4sNo
        rOZqXShdHYEj+rBY1x7Vam+64kuwong9PeRLLaD/BzP2SU373NUAZIysBKln6SogUi2DwJ
        bau7EWJmboQGM57Cien//FnY/L6J6Ls=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CB0E62C141;
        Wed, 22 Jun 2022 19:32:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1CB79DA82F; Wed, 22 Jun 2022 21:28:04 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: lower some mount messages level to debug
Date:   Wed, 22 Jun 2022 21:28:03 +0200
Message-Id: <20220622192803.16233-1-dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Change message level from info to debug for the following messages,
there's no reason to print them for all users as that won't help
debugging if nearly all filesystems use that.

- flagging fs with big metadata feature

Added in commit 727011e07cbd ("Btrfs: allow metadata blocks larger than
the page size") in 2010 and it's been default for mkfs since 3.12
(2013).

- has skinny extents

Added in 3173a18f7055 ("Btrfs: add a incompatible format change for
smaller metadata extent refs") in 2013 and default for mkfs since 3.18
(2014).

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8592eaf6de53..3d435560980c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3472,8 +3472,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 */
 	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE) {
 		if (!(features & BTRFS_FEATURE_INCOMPAT_BIG_METADATA))
-			btrfs_info(fs_info,
-				"flagging fs with big metadata feature");
+			btrfs_debug(fs_info, "flagging fs with big metadata feature");
 		features |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
 	}
 
@@ -3514,7 +3513,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		features |= BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD;
 
 	if (features & BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
-		btrfs_info(fs_info, "has skinny extents");
+		btrfs_debug(fs_info, "has skinny extents");
 
 	/*
 	 * mixed block groups end up with duplicate but slightly offset
-- 
2.36.1

