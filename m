Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C4E573446
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 12:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbiGMKbS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 06:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiGMKbR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 06:31:17 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D557BFD204
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 03:31:16 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 7749981120;
        Wed, 13 Jul 2022 06:31:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1657708276; bh=YF0eZzef2DDGBsEfzktAfjuY6iCob9oE6T5l5oX/ujU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K3IYaUWbZfng5JIimYuhmOO0HW3klIVX9yYQ35GS7mkIJWDukMDJfQQbd4ap9tDji
         0MF9x89nNcmNZ6vJkNz4q0tVMlVbQY7/ngWcGK1pnPvtL20YgYzBwOihoqZbSC3Tt1
         HZAFT9dTk/aEn6asCUeeG15l71o9adFMLVFFpzzFX+uU203sgrdkKj68s1llJQFu7Q
         50weoabYxYAH2OAYgo4TdxLxFZPjtILB/Y5BRPQJ5nEjWoyNGTu6lJ0bD0XLOR7Wbk
         mJBW5gUgMbHuh5tEvwR9XojiQFhMABhksBdOJP/YiKN2v4RUpoYfDAM/XjDLlQE1jP
         KaftBqsaHnDDA==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [RFC ONLY 16/23] btrfs: translate btrfs encryption flags and encrypted inode flag.
Date:   Wed, 13 Jul 2022 06:29:49 -0400
Message-Id: <ca9242a09a1eeecb99330a0ce4e6316370d5ed92.1657707687.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1657707686.git.sweettea-kernel@dorminy.me>
References: <cover.1657707686.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs, a file can be encrypted either if its directory is encrypted
or its root subvolume is encrypted, so translate both to the standard
flags.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/ioctl.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 9d3d447f58ad..c980a3025cf9 100644
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

