Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F704E563B
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 17:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245445AbiCWQVS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 12:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245182AbiCWQVR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 12:21:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203DD70044
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 09:19:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B288961865
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993BDC340EE
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648052385;
        bh=oIprmn6+QjdkRTx9hCc/3/ootbjDObHTqVObNKFNnSY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fiNZ5MQdwJ1vl61VypR2RNgfQWiO/Lv7w9lX02jAtD9W0Xc4TTndkf2C1T4xa+leZ
         SfHKf75DnVl0GmKCMj2xth20b9M9l/CiElEplobKwzZm9GJN55LyKnVf8sRvvmVW0A
         cKL64IbVzfWVByHZCP9TId0PGOjS4jhGNgqNjDSZRkw9c7PAGOl5S3qf6bZNT97xSY
         FU2Sim8g6toCWG1Fm0GDBvLBpbZFkgNMxjs2zTaEVFdXK6vvukM2UVMqAibGYzPiU3
         ZwPiDlHHxjg1YDGTkPz8W0DxNvf3f/gV4GGfBHKYooFebPi0ijTjbXvvMH1weEnhPJ
         wutRcAmhNjLxQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/8] btrfs: release path earlier at can_nocow_extent()
Date:   Wed, 23 Mar 2022 16:19:28 +0000
Message-Id: <5452c422221d60076bdc02557412ffc58ad89091.1648051583.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648051582.git.fdmanana@suse.com>
References: <cover.1648051582.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At can_nocow_extent(), we are releasing the path only after checking if
the block group that has the target extent is read only, and after
checking if there's delalloc in the range in case our extent is a
preallocated extent. The read only extent check can be expensive if we
have a very large filesystem with many block groups, as well as the
check for delalloc in the inode's io_tree in case the io_tree is big
due to IO on other file ranges.

Our path is holding a read lock on a leaf and there's no need to keep
the lock while doing those two checks, so release the path before doing
them, immediately after the last use of the leaf.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d7d7a28539a9..9a515ae491eb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7202,6 +7202,8 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 		*ram_bytes = btrfs_file_extent_ram_bytes(leaf, fi);
 	}
 
+	btrfs_release_path(path);
+
 	if (btrfs_extent_readonly(fs_info, disk_bytenr))
 		goto out;
 
@@ -7219,8 +7221,6 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 		}
 	}
 
-	btrfs_release_path(path);
-
 	/*
 	 * look for other files referencing this extent, if we
 	 * find any we must cow
-- 
2.33.0

