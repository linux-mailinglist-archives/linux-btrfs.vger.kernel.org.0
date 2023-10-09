Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74807BD29E
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 06:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345075AbjJIEra (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 00:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345068AbjJIEr2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 00:47:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E17FA6
        for <linux-btrfs@vger.kernel.org>; Sun,  8 Oct 2023 21:47:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0677221883
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 04:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696826843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TM25PUacKvsJZL1iZYXFoaHQOMoYGPVsCX2ZgmCa+Ls=;
        b=rOVjbiUl7blyddK7+VdW4w5jHfHg2Yi9xddcPiPAi06v3P8mBFowFrlPqQ5mGNAhuX3PnA
        QXLtSzGfJpMIwziyUSM2I3y/0zl5ximMvYrp1oSwpz9msexJKIvDJsOe8l2kR7ka7SP0ML
        BLeHEK5zxADoW/2UT6TFjDNC7CBa/PY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D25E713586
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 04:47:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CFjOHNmFI2VSVQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Oct 2023 04:47:21 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: move clear-cache.[ch] from check to common directory
Date:   Mon,  9 Oct 2023 15:16:59 +1030
Message-ID: <ea481febfdd13de99682e86ce6bc4c8a475cdead.1696826531.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696826531.git.wqu@suse.com>
References: <cover.1696826531.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The clear-cache functionality is not shared by several commands:

- btrfs check
  For --clear-cache and --clear-ino-cache.

- btrfstune
  Mostly for block-group-tree feature conversion.

- btrfs-convert
  To enable the now default v2 space cache.

Thus it's no longer proper to keep clea-cache.[ch] under check/
directory, move them to common/ directory.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Makefile                        | 6 +++---
 check/main.c                    | 2 +-
 {check => common}/clear-cache.c | 2 +-
 {check => common}/clear-cache.h | 0
 convert/main.c                  | 2 +-
 tune/main.c                     | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)
 rename {check => common}/clear-cache.c (99%)
 rename {check => common}/clear-cache.h (100%)

diff --git a/Makefile b/Makefile
index e5817f1456a2..345c8efc8249 100644
--- a/Makefile
+++ b/Makefile
@@ -242,7 +242,7 @@ cmds_objects = cmds/subvolume.o cmds/subvolume-list.o \
 	       cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/filesystem-du.o \
 	       cmds/reflink.o \
 	       mkfs/common.o check/mode-common.o check/mode-lowmem.o \
-	       check/clear-cache.o
+	       common/clear-cache.o
 
 libbtrfs_objects = \
 		kernel-lib/rbtree.o	\
@@ -262,12 +262,12 @@ libbtrfsutil_objects = libbtrfsutil/errors.o libbtrfsutil/filesystem.o \
 		       libbtrfsutil/stubs.o
 convert_objects = convert/main.o convert/common.o convert/source-fs.o \
 		  convert/source-ext2.o convert/source-reiserfs.o \
-		  mkfs/common.o check/clear-cache.o
+		  mkfs/common.o common/clear-cache.o
 mkfs_objects = mkfs/main.o mkfs/common.o mkfs/rootdir.o
 image_objects = image/main.o image/sanitize.o image/image-create.o image/common.o \
 		image/image-restore.o
 tune_objects = tune/main.o tune/seeding.o tune/change-uuid.o tune/change-metadata-uuid.o \
-	       tune/convert-bgt.o tune/change-csum.o check/clear-cache.o tune/quota.o
+	       tune/convert-bgt.o tune/change-csum.o common/clear-cache.o tune/quota.o
 all_objects = $(objects) $(cmds_objects) $(libbtrfs_objects) $(convert_objects) \
 	      $(mkfs_objects) $(image_objects) $(tune_objects) $(libbtrfsutil_objects)
 
diff --git a/check/main.c b/check/main.c
index be27ee5f2415..1174939fd6eb 100644
--- a/check/main.c
+++ b/check/main.c
@@ -58,6 +58,7 @@
 #include "common/help.h"
 #include "common/open-utils.h"
 #include "common/string-utils.h"
+#include "common/clear-cache.h"
 #include "cmds/commands.h"
 #include "mkfs/common.h"
 #include "check/common.h"
@@ -66,7 +67,6 @@
 #include "check/mode-original.h"
 #include "check/mode-lowmem.h"
 #include "check/qgroup-verify.h"
-#include "check/clear-cache.h"
 
 /* Global context variables */
 struct btrfs_fs_info *gfs_info;
diff --git a/check/clear-cache.c b/common/clear-cache.c
similarity index 99%
rename from check/clear-cache.c
rename to common/clear-cache.c
index d83d9b2fcda8..d57313b783c0 100644
--- a/check/clear-cache.c
+++ b/common/clear-cache.c
@@ -33,7 +33,7 @@
 #include "common/messages.h"
 #include "check/repair.h"
 #include "check/mode-common.h"
-#include "check/clear-cache.h"
+#include "common/clear-cache.h"
 
 /*
  * Number of free space cache inodes to delete in one transaction.
diff --git a/check/clear-cache.h b/common/clear-cache.h
similarity index 100%
rename from check/clear-cache.h
rename to common/clear-cache.h
diff --git a/convert/main.c b/convert/main.c
index 5d7c1e1d99d6..c9e50c036f92 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -119,9 +119,9 @@
 #include "common/box.h"
 #include "common/open-utils.h"
 #include "common/extent-tree-utils.h"
+#include "common/clear-cache.h"
 #include "cmds/commands.h"
 #include "check/repair.h"
-#include "check/clear-cache.h"
 #include "mkfs/common.h"
 #include "convert/common.h"
 #include "convert/source-fs.h"
diff --git a/tune/main.c b/tune/main.c
index 08dedce26cb5..4aef76748343 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -37,9 +37,9 @@
 #include "common/string-utils.h"
 #include "common/help.h"
 #include "common/box.h"
+#include "common/clear-cache.h"
 #include "cmds/commands.h"
 #include "tune/tune.h"
-#include "check/clear-cache.h"
 
 static char *device;
 static int force = 0;
-- 
2.42.0

