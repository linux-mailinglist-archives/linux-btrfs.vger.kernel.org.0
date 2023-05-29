Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B868714543
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 09:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjE2HKe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 03:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjE2HKd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 03:10:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE23A3
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 00:10:31 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CBF1A1FE4F
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 07:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685344228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=w73AFs8qYvo9u7shGa/97iSZmReILsYPH3bbG6Qie6k=;
        b=n63d9xgnxc1m37MfzmB/q5A6Jtr6QnxoFN2NHGRkPltVJHpcNhMg9reDLCeSNN3Y4uTpzq
        J/S7PmQo3C/uAdcrKFnQzhelmsNuH1CpeInZkP5gz6qTEE8vx7EWIfoOiU5+mVHeXxKeDo
        cr513lqbTmC1L80yX8R18Y3xblv8J3E=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 2D86E13508
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 07:10:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id b25JOuNPdGTodgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 07:10:27 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs-progs: convert: follow the default free space tree setting
Date:   Mon, 29 May 2023 15:10:10 +0800
Message-Id: <bd49c49f1e1c8b816b5e1b7d0adc0461d2737601.1685344169.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
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
We got some test failures related to btrfs-convert with subpage, e.g.
btrfs/012, the failure would cause the following dmesg:

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
Changelog:
v2:
- Rebased to latest devel branch
  Which already has the orphan file support for ext4.
---
 Makefile       |  2 +-
 convert/main.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e2497c18b5e9..86c73590d118 100644
--- a/Makefile
+++ b/Makefile
@@ -253,7 +253,7 @@ libbtrfsutil_objects = libbtrfsutil/errors.o libbtrfsutil/filesystem.o \
 		       libbtrfsutil/stubs.o
 convert_objects = convert/main.o convert/common.o convert/source-fs.o \
 		  convert/source-ext2.o convert/source-reiserfs.o \
-		  mkfs/common.o
+		  mkfs/common.o check/clear-cache.o
 mkfs_objects = mkfs/main.o mkfs/common.o mkfs/rootdir.o
 image_objects = image/main.o image/sanitize.o
 tune_objects = tune/main.o tune/seeding.o tune/change-uuid.o tune/change-metadata-uuid.o \
diff --git a/convert/main.c b/convert/main.c
index 0a62101d7e48..27eece089cd4 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -99,6 +99,7 @@
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/transaction.h"
+#include "kernel-shared/free-space-tree.h"
 #include "kernel-shared/file-item.h"
 #include "crypto/hash.h"
 #include "common/defs.h"
@@ -116,6 +117,7 @@
 #include "common/open-utils.h"
 #include "cmds/commands.h"
 #include "check/repair.h"
+#include "check/clear-cache.h"
 #include "mkfs/common.h"
 #include "convert/common.h"
 #include "convert/source-fs.h"
@@ -1348,6 +1350,28 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 		error("unable to open ctree for finalization");
 		goto fail;
 	}
+
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
2.40.1

