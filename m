Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC916507D91
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 02:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358531AbiDTAXJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 20:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343907AbiDTAXH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 20:23:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A5A2C651
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 17:20:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AC6D52129B
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650414021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VI/sCnj31c7AHPdZSvrKDQXJGIHN5bewfHx6n1reAXQ=;
        b=P+a/b+6Czr9PME3zFuZSXUbVZMeH9Fk4K0EHbeTQMBjFTuVDxcOmLcnhrYNWv5Z1Rrgnhf
        mJfc0d0BKZbavZdKqXPFEhrStgRiHGuVsp+24koFbctbdhOodyUZrLvfNJ6tthxFB4NpGX
        +2zoI8qjAQRdG39jRssJYZwK94N8M9k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F12C4139BE
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IMQCLcRRX2KvZAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:20 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 03/10] btrfs-progs: mkfs: introduce helper to set seed flag
Date:   Wed, 20 Apr 2022 08:19:52 +0800
Message-Id: <0fe28f7170bd687ad0015c4ce1c606ab2a23cc1a.1650413308.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1650413308.git.wqu@suse.com>
References: <cover.1650413308.git.wqu@suse.com>
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

The new helper, prepare_seed_device(), will be used for later mkfs time
seed sprouting.

Although it has way more checks than btrfstune:

- csum_type/sectorsize/nodesize/features checks
  Any mismatch means we can not use that seed device
  Normally it should not be a problem for default mkfs profiles,
  but since we're going to do the sprout at mkfs time, we must
  do these checks.

- Device number check
  I see no reason nor use-case to support nested/multi-device seed at
  mkfs time.

Currently mkfs.btrfs will accept --seed (undocumented, and experimental)
and call the helper to set seed flag on the target, but will not really
do the sprout yet.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Makefile      |   2 +-
 mkfs/main.c   |  17 ++++++++
 mkfs/sprout.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++
 mkfs/sprout.h |  10 +++++
 4 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 mkfs/sprout.c
 create mode 100644 mkfs/sprout.h

diff --git a/Makefile b/Makefile
index af4908f9d8de..4e56326e4746 100644
--- a/Makefile
+++ b/Makefile
@@ -226,7 +226,7 @@ libbtrfsutil_objects = libbtrfsutil/errors.o libbtrfsutil/filesystem.o \
 convert_objects = convert/main.o convert/common.o convert/source-fs.o \
 		  convert/source-ext2.o convert/source-reiserfs.o \
 		  mkfs/common.o
-mkfs_objects = mkfs/main.o mkfs/common.o mkfs/rootdir.o
+mkfs_objects = mkfs/main.o mkfs/common.o mkfs/rootdir.o mkfs/sprout.o
 image_objects = image/main.o image/sanitize.o
 all_objects = $(objects) $(cmds_objects) $(libbtrfs_objects) $(convert_objects) \
 	      $(mkfs_objects) $(image_objects) $(libbtrfsutil_objects)
diff --git a/mkfs/main.c b/mkfs/main.c
index 4e0a46a77aa5..7b7793f8b996 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -48,6 +48,7 @@
 #include "common/parse-utils.h"
 #include "mkfs/common.h"
 #include "mkfs/rootdir.h"
+#include "mkfs/sprout.h"
 #include "common/fsfeatures.h"
 #include "common/box.h"
 #include "common/units.h"
@@ -999,6 +1000,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	bool force_overwrite = false;
 	int oflags;
 	char *source_dir = NULL;
+	char *seed_dev = NULL;
 	bool source_dir_set = false;
 	bool shrink_rootdir = false;
 	u64 source_dir_size = 0;
@@ -1024,6 +1026,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			GETOPT_VAL_SHRINK = 257,
 			GETOPT_VAL_CHECKSUM,
 			GETOPT_VAL_GLOBAL_ROOTS,
+			GETOPT_VAL_SEED_DEV,
 		};
 		static const struct option long_options[] = {
 			{ "byte-count", required_argument, NULL, 'b' },
@@ -1050,6 +1053,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			{ "shrink", no_argument, NULL, GETOPT_VAL_SHRINK },
 #if EXPERIMENTAL
 			{ "num-global-roots", required_argument, NULL, GETOPT_VAL_GLOBAL_ROOTS },
+			{ "seed", required_argument, NULL, GETOPT_VAL_SEED_DEV },
 #endif
 			{ "help", no_argument, NULL, GETOPT_VAL_HELP },
 			{ NULL, 0, NULL, 0}
@@ -1158,6 +1162,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			case GETOPT_VAL_GLOBAL_ROOTS:
 				nr_global_roots = (int)arg_strtou64(optarg);
 				break;
+			case GETOPT_VAL_SEED_DEV:
+				seed_dev = optarg;
+				break;
 			case GETOPT_VAL_HELP:
 			default:
 				print_usage(c != GETOPT_VAL_HELP);
@@ -1207,6 +1214,16 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		}
 	}
 
+	if (seed_dev) {
+		ret = prepare_seed_device(seed_dev, features, csum_type,
+					  sectorsize, nodesize);
+		if (ret < 0) {
+			errno = -ret;
+			error("faield to set seed flag on %s: %m", seed_dev);
+			goto error;
+		}
+	}
+
 	while (dev_cnt-- > 0) {
 		file = argv[optind++];
 		if (source_dir_set && path_exists(file) == 0)
diff --git a/mkfs/sprout.c b/mkfs/sprout.c
new file mode 100644
index 000000000000..eb423d082c7c
--- /dev/null
+++ b/mkfs/sprout.c
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include "kernel-shared/ctree.h"
+#include "kernel-shared/disk-io.h"
+#include "kernel-shared/volumes.h"
+#include "kernel-shared/transaction.h"
+#include "common/messages.h"
+#include "mkfs/common.h"
+
+int prepare_seed_device(const char *path, u64 features, u32 csum_type,
+			u32 sectorsize, u32 nodesize)
+{
+	struct open_ctree_flags ocf = { 0 };
+	struct btrfs_trans_handle *trans;
+	struct btrfs_fs_devices *fs_devs;
+	struct btrfs_fs_info *fs_info;
+	int nr_devs = 0;
+	int ret;
+
+	ocf.filename = path;
+	ocf.flags = OPEN_CTREE_WRITES;
+
+	fs_info = open_ctree_fs_info(&ocf);
+	if (!fs_info) {
+		error("can not open btrfs on %s", path);
+		return -EINVAL;
+	}
+
+	fs_devs = fs_info->fs_devices;
+	while (fs_devs) {
+		struct list_head *list;
+
+		list_for_each(list, &fs_devs->devices)
+			nr_devs++;
+		fs_devs = fs_devs->seed;
+	}
+
+	/*
+	 * Multi-device seed is not recommended, we just reject them.
+	 * This also rejects sported fs which still has seed attached.
+	 */
+	if (nr_devs > 1) {
+		ret = -EINVAL;
+		error("the seed filesystem has multiple devices, have %u expect 1",
+			nr_devs);
+		goto out;
+	}
+
+	/* METADATA_UUID feature should not be enabled on seed device */
+	if (btrfs_fs_incompat(fs_info, METADATA_UUID)) {
+		ret = -EINVAL;
+		error("the seed filesystem can not have METADATA_UUID feature enabled");
+		goto out;
+	}
+	/* Transient device can not be seed target */
+	if (btrfs_super_flags(fs_info->super_copy) &
+	    (BTRFS_SUPER_FLAG_CHANGING_CSUM |
+	     BTRFS_SUPER_FLAG_CHANGING_FSID |
+	     BTRFS_SUPER_FLAG_CHANGING_FSID_V2 |
+	     BTRFS_SUPER_FLAG_METADUMP |
+	     BTRFS_SUPER_FLAG_METADUMP_V2)) {
+		ret = -EINVAL;
+		error("the seed filesystem has transient flags: 0x%llx",
+		      btrfs_super_flags(fs_info->super_copy));
+		goto out;
+	}
+	/*
+	 * Make sure the seed device matches all the criteria
+	 * For incompat flags, we only require our target features is a subset
+	 * of the seed device.
+	 */
+	if (fs_info->sectorsize != sectorsize ||
+	    fs_info->nodesize != nodesize ||
+	    fs_info->csum_type != csum_type ||
+	    ~btrfs_super_incompat_flags(fs_info->super_copy) & features) {
+		ret = -EINVAL;
+		error("the seed filesystem parameters don't match the target");
+		error("  seed features=0x%llx csum_type=%u sectorsize=%u nodesize=%u",
+			btrfs_super_incompat_flags(fs_info->super_copy),
+			fs_info->csum_type, fs_info->sectorsize,
+			fs_info->nodesize);
+		error("  target features=0x%llx csum_type=%u sectorsize=%u nodesize=%u",
+			features, csum_type, sectorsize, nodesize);
+		goto out;
+	}
+
+	/* Already has seed flag */
+	if (btrfs_super_flags(fs_info->super_copy) & BTRFS_SUPER_FLAG_SEEDING) {
+		ret = 0;
+		goto out;
+	}
+
+	/* All check passed, set seed flag */
+	trans = btrfs_start_transaction(fs_info->tree_root, 0);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error("failed to start transaction for setting seed flag: %m");
+		goto out;
+	}
+	btrfs_set_super_flags(fs_info->super_copy, BTRFS_SUPER_FLAG_SEEDING |
+			      btrfs_super_flags(fs_info->super_copy));
+	ret = btrfs_commit_transaction(trans, fs_info->tree_root);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to commit transaction for setting seed flag: %m");
+		goto out;
+	} else {
+		printf("Seed flag set for %s\n", path);
+	}
+out:
+	close_ctree(fs_info->tree_root);
+	return ret;
+}
diff --git a/mkfs/sprout.h b/mkfs/sprout.h
new file mode 100644
index 000000000000..2e8b794c93e4
--- /dev/null
+++ b/mkfs/sprout.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Functions only used for seed sprout at mkfs time. */
+#ifndef __BTRFS_MKFS_SPROUT_H__
+#define __BTRFS_MKFS_SPROUT_H__
+
+int prepare_seed_device(const char *path, u64 features, u32 csum_type,
+			u32 sectorsize, u32 nodesize);
+
+#endif
-- 
2.35.1

