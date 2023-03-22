Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EBC6C4797
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 11:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCVK1u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 06:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCVK1q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 06:27:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0138B60D71
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 03:27:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 99BCF20C67
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 10:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679480845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VToTGoKD5Sl/cqVd+ez6VOBfugR+cdZmripXZ+BsaRg=;
        b=k3fXtLG+uzlJ9tPe00X92I5GY2J2PCp38K68dqjh355w+4PodwjJzaCiym5fwdFndHMwoU
        UORFPJ7Pb/2K9jKn6EeiV5596lzzcMeZrUzPPal05KHIr1rKKaijL7xTNOekelY30CmKtS
        tRgRSzJMj10AFZcFb5Hs4GQYoCWqwk0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07EB5138E9
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 10:27:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mI8oMgzYGmRyEgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 10:27:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: convert: follow the default free space tree setting
Date:   Wed, 22 Mar 2023 18:27:05 +0800
Message-Id: <6f3214e15cf1cee7671d79a8dd8eb7e2949626d9.1679480445.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679480445.git.wqu@suse.com>
References: <cover.1679480445.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
We got some test failures related to btrfs-convert, like btrfs/012, the
failure would cause the following dmesg:

 BTRFS warning (device nvme0n1p7): v1 space cache is not supported for page size 16384 with sectorsize 4096
 BTRFS error (device nvme0n1p7): open_ctree failed

[CAUSE]
v1 space cache has tons of hardcoded PAGE_SIZE usage, and considering v2
space cache is going to replace it (which is already the new default
since v5.15 btrfs-progs), thus for btrfs subpage support, we just simply
reject the v1 space cache, and utilize v2 space cache when possible.

But there is special catch in btrfs-convert, although we're specifying
v2 space cache as the new default for btrfs-convert, it doesn't really
follow the specification at all.

Thus the converted btrfs will still go v1 space cache.

[FIX]
It can be a huge change to btrfs-convert to make the initial btrfs image
to support v2 cache.

Thus this patch would change the fs at the final stage, just before we
finalize the btrfs.

This patch would drop all the v1 cache created, then call
btrfs_create_free_space_tree() to populate the free space tree and
commit the superblock with needed compat_ro flags.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
It looks like since e2fsprogs 1.47, there would be a new special inode
with ino number 12 after mkfs.ext4.

Such special inode has no parent directory entry pointing to it, thus it
would be always orphan, and cause btrfs check to complain.
As btrfs-convert strictly follows the ext inode, and created an orphan
inode in btrfs too.

Thus with newer e2fsprogs, this would cause convert tests to fail.

Still confirming with ext4 community to get a way to work around this.
---
 Makefile       |  2 +-
 convert/main.c | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 4b0a869b6ca5..1e61bb31eb79 100644
--- a/Makefile
+++ b/Makefile
@@ -246,7 +246,7 @@ libbtrfsutil_objects = libbtrfsutil/errors.o libbtrfsutil/filesystem.o \
 		       libbtrfsutil/stubs.o
 convert_objects = convert/main.o convert/common.o convert/source-fs.o \
 		  convert/source-ext2.o convert/source-reiserfs.o \
-		  mkfs/common.o
+		  mkfs/common.o check/clear-cache.o
 mkfs_objects = mkfs/main.o mkfs/common.o mkfs/rootdir.o
 image_objects = image/main.o image/sanitize.o
 tune_objects = tune/main.o tune/seeding.o tune/change-uuid.o tune/change-metadata-uuid.o \
diff --git a/convert/main.c b/convert/main.c
index 3f54ea304e6f..b4df5a984238 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -99,6 +99,7 @@
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/transaction.h"
+#include "kernel-shared/free-space-tree.h"
 #include "crypto/hash.h"
 #include "common/defs.h"
 #include "common/extent-cache.h"
@@ -115,6 +116,7 @@
 #include "common/open-utils.h"
 #include "cmds/commands.h"
 #include "check/repair.h"
+#include "check/clear-cache.h"
 #include "mkfs/common.h"
 #include "convert/common.h"
 #include "convert/source-fs.h"
@@ -1343,6 +1345,27 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 		error("unable to open ctree for finalization");
 		goto fail;
 	}
+	/*
+	 * Setup free space tree.
+	 *
+	 * - Clear any v1 cache first
+	 * - Create v2 free space tree
+	 */
+	if (mkfs_cfg.features.compat_ro_flags &
+	    BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE) {
+		ret = do_clear_free_space_cache(root->fs_info, 1);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to clear v1 space cache: %m");
+			goto fail;
+		}
+		ret = btrfs_create_free_space_tree(root->fs_info);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to create v2 space cache: %m");
+			goto fail;
+		}
+	}
 	root->fs_info->finalize_on_close = 1;
 	close_ctree(root);
 	close(fd);
-- 
2.39.2

