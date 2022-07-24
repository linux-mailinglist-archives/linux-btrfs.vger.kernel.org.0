Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1288E57F24A
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jul 2022 02:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbiGXAzF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jul 2022 20:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239331AbiGXAyn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jul 2022 20:54:43 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EAB15A20;
        Sat, 23 Jul 2022 17:54:42 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 3D29E80BB8;
        Sat, 23 Jul 2022 20:54:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658624082; bh=AgDYp0BiOtfI423w4RuFeYp4IwenEY64iE6iTJOoayc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jo9PimxW1WAvkkJJz/rgxg7uH3nmtl6rKZVegJYJ55yvfxSoqqSzlOUFHPn61xoSY
         5YJtxfTPh8cFdAbHmVs6Xlj3sYyeYJZR9D1s0YBsJcv3eeglVK6hCxT8I/k4tVBnij
         9ZsdYTcygIgzoe4W5AlFKJR06bevJCBpm11fYqS9b4Mmvl2z+wTAkYVeWYynch7tTK
         hAtX3X9lDZSLBhydnLXMu/YIzGhzCVt9jZY6TPykcN1xwfXHm98DinwijddqHMBpS0
         1pZvH7KSyeH9HCKC1VtxK5fvxbxpklrdSKV6KVOCSX7MUmxo9GcwCRs/dSb3zxLYFp
         4vFsMGB25JZWg==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, osandov@osandov.com,
        kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH RFC v2 09/16] btrfs: translate btrfs encryption flags and encrypted inode flag.
Date:   Sat, 23 Jul 2022 20:53:54 -0400
Message-Id: <3f8eaa2ac5226dba403197398ebbd5208ccd9cc0.1658623319.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1658623319.git.sweettea-kernel@dorminy.me>
References: <cover.1658623319.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@osandov.com>

In btrfs, a file can be encrypted either if its directory is encrypted
or its root subvolume is encrypted, so translate both to the standard
flags.

Signed-off-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/ioctl.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 8f5b65c43c8d..708e514aca25 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -7,6 +7,7 @@
 #include <linux/bio.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/fscrypt.h>
 #include <linux/fsnotify.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
@@ -147,6 +148,10 @@ static unsigned int btrfs_inode_flags_to_fsflags(struct btrfs_inode *binode)
 		iflags |= FS_NOCOW_FL;
 	if (ro_flags & BTRFS_INODE_RO_VERITY)
 		iflags |= FS_VERITY_FL;
+	if ((binode->flags & BTRFS_INODE_FSCRYPT_CONTEXT) ||
+	    (btrfs_root_flags(&binode->root->root_item) &
+	     BTRFS_ROOT_SUBVOL_FSCRYPT))
+		iflags |= FS_ENCRYPT_FL;
 
 	if (flags & BTRFS_INODE_NOCOMPRESS)
 		iflags |= FS_NOCOMP_FL;
@@ -176,10 +181,14 @@ void btrfs_sync_inode_flags_to_i_flags(struct inode *inode)
 		new_fl |= S_DIRSYNC;
 	if (binode->ro_flags & BTRFS_INODE_RO_VERITY)
 		new_fl |= S_VERITY;
+	if ((binode->flags & BTRFS_INODE_FSCRYPT_CONTEXT) ||
+	    (btrfs_root_flags(&binode->root->root_item) &
+	     BTRFS_ROOT_SUBVOL_FSCRYPT))
+		new_fl |= S_ENCRYPTED;
 
 	set_mask_bits(&inode->i_flags,
 		      S_SYNC | S_APPEND | S_IMMUTABLE | S_NOATIME | S_DIRSYNC |
-		      S_VERITY, new_fl);
+		      S_VERITY | S_ENCRYPTED, new_fl);
 }
 
 /*
@@ -192,7 +201,7 @@ static int check_fsflags(unsigned int old_flags, unsigned int flags)
 		      FS_NOATIME_FL | FS_NODUMP_FL | \
 		      FS_SYNC_FL | FS_DIRSYNC_FL | \
 		      FS_NOCOMP_FL | FS_COMPR_FL |
-		      FS_NOCOW_FL))
+		      FS_NOCOW_FL | FS_ENCRYPT_FL))
 		return -EOPNOTSUPP;
 
 	/* COMPR and NOCOMP on new/old are valid */
-- 
2.35.1

