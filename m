Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E535C507D8B
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 02:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358570AbiDTAXS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 20:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358557AbiDTAXP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 20:23:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F342C67F
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 17:20:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD612210E6
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650414029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bmmlmVw4Otp6JFeMVqOxGqHzwtEwkHgajY6U8mVl1/w=;
        b=K0/u/tm4Ox8BtO31Pm+wtjxlOkas6+PRmXZA+zBWIdPE4C72KT7CVQcSTAdxGZaJZhVJwK
        Zl/C+IXBFEDfsOo/Wou17+oJdVtpfSolOjGoPqhfR2NhJ6mfr4N8QZvB6dDMasOkM3H/4j
        xyNlNn6Celqodbvy0RZqIHcFlu1Su0s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F135139BE
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sP5rNcxRX2KvZAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 10/10] btrfs-progs: mkfs: add support for seed sprout
Date:   Wed, 20 Apr 2022 08:19:59 +0800
Message-Id: <e8cc9e4258c7f1ed5853cfc0c245e013ccb6d84d.1650413308.git.wqu@suse.com>
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

This patch will add a new option "--seed <device>" to mkfs, allowing us
to mark specified device as seed (if not yet a seed device), then
sprouting it with the extra rw device.

The new --seed option will be hidden underneath the experimental feature.

Currently, --seed has extra limitations, including:

- csum type/sectorsize/nodesize/features must match seeding device
  The very basic sanity checks.

- Ignoreing -m/-d options
  As we will inherit the profiles from the seed device.

- Only accept single deviced seed
  This is not a technical limit, but purely to make seed usage less
  flex, and less error prone.

- Only accept single rw device
  We can already add as many deviecs as regular mkfs, I just didn't see
  much usefulness from it.

- Rejects --rootdir option
  It's super easy to have --rootdir to conflict with the existing files
  inherited from the seed fs.

With the new "--seed" option, we can replace the following workflow:

 mkfs.btrfs -f $seed
 mount $seed $mnt
 # Populate $mnt with contents we want
 umount $mnt
 btrfstune -S1 $seed
 mount $seed $mnt
 btrfs dev add -f $rw_dev $mnt
 mount -o remount,rw $mnt

With much less commands:

 mkfs.btrfs -f $seed
 mount $seed $mnt
 # Populate $mnt with contents we want
 umount $mnt
 mkfs.btrfs --seed $seed $rw_dev
 mount $rw_dev $mnt

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/mkfs.btrfs.rst |  13 +++
 mkfs/main.c                  |  42 +++++++++
 mkfs/sprout.c                | 169 +++++++++++++++++++++++++++++++++++
 mkfs/sprout.h                |   3 +
 4 files changed, 227 insertions(+)

diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
index df3b5d807ca5..e73a3c5644fa 100644
--- a/Documentation/mkfs.btrfs.rst
+++ b/Documentation/mkfs.btrfs.rst
@@ -136,6 +136,19 @@ OPTIONS
                 contain the files from *rootdir*. Since version 4.14.1 the filesystem size is
                 not minimized. Please see option *--shrink* if you need that functionality.
 
+--seed <seed>
+        Use *seed* as the seed device, then sprout it with the extra *device*.
+        If *seed* is not a seed device yet, mkfs will mark it with seed flag,
+        other than that, no other write will reach *seed* device.
+
+        Check *SEEDING DEVICE* section of ``btrfs(5)`` for more details and the
+        alternative way of sprouting a seed device.
+
+        .. note::
+                With this option, *seed* must only contain a single device
+                filesystem, and we only accept one single device to be added
+                to sprout the seed device.
+
 --shrink
         Shrink the filesystem to its minimal size, only works with *--rootdir* option.
 
diff --git a/mkfs/main.c b/mkfs/main.c
index ca035cbb27f7..44f1b2e5c0a2 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -408,6 +408,7 @@ static void print_usage(int ret)
 	printf("  creation:\n");
 	printf("\t-b|--byte-count SIZE        set filesystem size to SIZE (on the first device)\n");
 	printf("\t-r|--rootdir DIR            copy files from DIR to the image root directory\n");
+	printf("\t--seed DEV                  use DEV as seed device to create the fs\n");
 	printf("\t--shrink                    (with --rootdir) shrink the filled filesystem to minimal size\n");
 	printf("\t-K|--nodiscard              do not perform whole device TRIM\n");
 	printf("\t-f|--force                  force overwrite of existing filesystem\n");
@@ -1283,6 +1284,14 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	}
 
 	if (seed_dev) {
+		if (dev_cnt > 1) {
+			error("the option --seed only accepts a single device");
+			goto error;
+		}
+		if (source_dir_set) {
+			error("the option --seed conflicts with the option --rootdir");
+			goto error;
+		}
 		ret = prepare_seed_device(seed_dev, features, csum_type,
 					  sectorsize, nodesize);
 		if (ret < 0) {
@@ -1577,6 +1586,37 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	else
 		mkfs_cfg.zone_size = 0;
 
+	if (seed_dev) {
+		/*
+		 * Data/metadata profiles will inherit from the seed device,
+		 * thus setting data/metadata profile is useless.
+		 */
+		if (data_profile_opt || metadata_profile_opt)
+			warning(
+"data/metadata profiles will inherit from the seed device, ignoring specified profiles");
+
+		ocf.filename = seed_dev;
+		/* Open the seed fs with read-only */
+		ocf.flags = 0;
+
+		fs_info = open_ctree_fs_info(&ocf);
+		if (!fs_info) {
+			error("failed to open seed fs");
+			goto error;
+		}
+
+		ret = sprout_seed_fs(fs_info, &mkfs_cfg, file, dev_block_count);
+		if (ret < 0) {
+			errno = -ret;
+			error("the seed fs failed to sprout: %m");
+			goto error;
+		}
+
+		root = fs_info->fs_root;
+		/* Now the fs is opened RW, and continue the remaining work */
+		goto fs_created;
+	}
+
 	ret = make_btrfs(fd, &mkfs_cfg);
 	if (ret) {
 		errno = -ret;
@@ -1712,6 +1752,8 @@ raid_groups:
 		error("unable to commit transaction before recowing trees: %m");
 		goto out;
 	}
+
+fs_created:
 	trans = btrfs_start_transaction(root, 1);
 	if (IS_ERR(trans)) {
 		errno = -PTR_ERR(trans);
diff --git a/mkfs/sprout.c b/mkfs/sprout.c
index 049098872d3e..eecf40f4512f 100644
--- a/mkfs/sprout.c
+++ b/mkfs/sprout.c
@@ -1,10 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#include <sys/stat.h>
+#include <uuid/uuid.h>
+#include <fcntl.h>
+#include <unistd.h>
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/transaction.h"
+#include "kernel-lib/overflow.h"
 #include "common/messages.h"
+#include "common/units.h"
 #include "mkfs/common.h"
 
 int prepare_seed_device(const char *path, u64 features, u32 csum_type,
@@ -294,3 +300,166 @@ next:
 	}
 	return 0;
 }
+
+int sprout_seed_fs(struct btrfs_fs_info *fs_info,
+		   struct btrfs_mkfs_config *cfg, const char *path,
+		   u64 dev_block_count)
+{
+	struct btrfs_fs_devices *seed_fs_devs = fs_info->fs_devices;
+	struct btrfs_fs_devices *new_fs_devs;
+	struct btrfs_trans_handle *trans;
+	struct btrfs_device *dev;
+	const u64 old_size = btrfs_super_total_bytes(fs_info->super_copy);
+	u8 fsid[BTRFS_FSID_SIZE];
+	u64 new_size;
+	int fd;
+	int ret;
+
+	/* The seed fs should be RO. */
+	ASSERT(fs_info->readonly);
+
+	fd = open(path, O_RDWR);
+	if (fd < 0) {
+		ret = -errno;
+		error("failed to open %s: %m", path);
+		return ret;
+	}
+	new_fs_devs = btrfs_alloc_fs_devices(fsid, NULL);
+	if (!new_fs_devs) {
+		ret = -ENOMEM;
+		goto error_close;
+	}
+	if (!*cfg->fs_uuid) {
+		uuid_generate(new_fs_devs->fsid);
+		uuid_unparse(new_fs_devs->fsid, cfg->fs_uuid);
+	} else {
+		uuid_parse(cfg->fs_uuid, new_fs_devs->fsid);
+	}
+	memcpy(new_fs_devs->metadata_uuid, new_fs_devs->fsid, BTRFS_FSID_SIZE);
+
+	/* The seed fs should only have one device. */
+	ASSERT(seed_fs_devs->devices.next == seed_fs_devs->devices.prev);
+
+	/* All devices should be RO already. */
+	list_for_each_entry(dev, &seed_fs_devs->devices, dev_list) {
+		if (dev->fd >= 0) {
+			int old_flags;
+
+			old_flags = fcntl(dev->fd, F_GETFL);
+			if ((old_flags & O_ACCMODE) != O_RDONLY)
+				warning("devid %llu is not opened read-only",
+					dev->devid);
+		}
+	}
+
+	/* Add a new btrfs_device. */
+	dev = calloc(1, sizeof(*dev));
+	if (!dev) {
+		ret = -ENOMEM;
+		goto error_close;
+	}
+	dev->fs_info = fs_info;
+	dev->fs_devices = new_fs_devs;
+	/* The seed device is the first device thus we're the 2nd. */
+	dev->devid = 2;
+	dev->type = 0;
+	dev->io_width = cfg->sectorsize;
+	dev->io_align = cfg->sectorsize;
+	dev->fd = fd;
+	dev->writeable = 1;
+	dev->total_bytes = dev_block_count;
+	dev->sector_size = cfg->sectorsize;
+	dev->bytes_used = 0;
+	dev->dev_root = fs_info->dev_root;
+	uuid_generate(dev->uuid);
+	dev->name = strdup(path);
+	if (!dev->name) {
+		ret = -ENOMEM;
+		goto error_free;
+	}
+	if (check_add_overflow(old_size, dev_block_count, &new_size)) {
+		ret = -EOVERFLOW;
+		error(
+		"adding device of %llu (%s) bytes would exceed max file system size",
+		      dev->total_bytes, pretty_size(dev->total_bytes));
+		goto error_free;
+	}
+	list_add_tail(&dev->dev_list, &new_fs_devs->devices);
+	fs_info->readonly = 0;
+	fs_info->fs_devices = new_fs_devs;
+	new_fs_devs->seed = seed_fs_devs;
+
+	trans = btrfs_start_transaction(fs_info->tree_root, 0);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error("failed to start transaction: %m");
+		goto abort;
+	}
+	/* Force chunk allocation, or we won't have any bg to do CoW. */
+	ret = sprout_alloc_one_chunk(trans, BTRFS_BLOCK_GROUP_METADATA);
+	if (ret < 0)
+		goto abort;
+	ret = sprout_alloc_one_chunk(trans, BTRFS_BLOCK_GROUP_SYSTEM);
+	if (ret < 0)
+		goto abort;
+	/*
+	 * Our device is only in memory. Now with new block groups, we're
+	 * safe to insert it into chunk tree.
+	 */
+	ret = btrfs_add_device(trans, fs_info, dev);
+	if (ret < 0)
+		goto abort;
+
+	/* Update the geneartion of the device item of seed device */
+	ret = update_seed_dev_geneartion(trans);
+	if (ret < 0)
+		goto abort;
+
+	/* Relocate seed system chunks, so later we can delete them */
+	ret = sprout_relocate_chunk_tree(trans);
+	if (ret < 0)
+		goto abort;
+
+	btrfs_set_super_total_bytes(fs_info->super_copy, new_size);
+	btrfs_set_super_num_devices(fs_info->super_copy,
+			btrfs_super_num_devices(fs_info->super_copy) + 1);
+	btrfs_set_super_flags(fs_info->super_copy, ~BTRFS_SUPER_FLAG_SEEDING &
+			btrfs_super_flags(fs_info->super_copy));
+	memcpy(fs_info->super_copy->fsid, new_fs_devs->fsid, BTRFS_FSID_SIZE);
+	/*
+	 * Commit trans will update super block device item for us
+	 *
+	 * And we also need to update block group items, as
+	 * btrfs_block_group_item::used update is delayed, we can't
+	 * delete the empty system chunks in the same trans.
+	 */
+	ret = btrfs_commit_transaction(trans, fs_info->tree_root);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to commit transaction: %m");
+		return ret;
+	}
+
+	trans = btrfs_start_transaction(fs_info->tree_root, 0);
+	/* Remove the empty seed system chunks. */
+	ret = sprout_remove_seed_sys_chunk(trans);
+	if (ret < 0)
+		goto abort;
+	ret = btrfs_commit_transaction(trans, fs_info->tree_root);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to commit transaction: %m");
+	}
+
+	return ret;
+error_free:
+	free(dev);
+	free(new_fs_devs);
+error_close:
+	close(fd);
+	return ret;
+abort:
+	btrfs_abort_transaction(trans, ret);
+	return ret;
+}
diff --git a/mkfs/sprout.h b/mkfs/sprout.h
index 2e8b794c93e4..5527256178e5 100644
--- a/mkfs/sprout.h
+++ b/mkfs/sprout.h
@@ -6,5 +6,8 @@
 
 int prepare_seed_device(const char *path, u64 features, u32 csum_type,
 			u32 sectorsize, u32 nodesize);
+int sprout_seed_fs(struct btrfs_fs_info *fs_info,
+		   struct btrfs_mkfs_config *cfg, const char *path,
+		   u64 dev_block_count);
 
 #endif
-- 
2.35.1

