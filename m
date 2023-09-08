Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E49798285
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 08:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbjIHGmr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 02:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbjIHGmp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 02:42:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD291BDA
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 23:42:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5943A1F853
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 06:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694155359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7frJaOrxaRWOqhogxPk/ZmCC6tH0XIV8ujG+/4WFe3s=;
        b=oVh6JKFKIJIx49ehubsKpsxhZjI55YT9LJo8KrgkO4VF432R8M8UHL4M/1ycx/wm87Zkgo
        4aSeZSMSm3KAmdvugwzT09jcXE35k+bIrAmSHkiVvfRHo+N+1q+W2EeVTNk3rju+kVK5AA
        MlO7qeXM32YhL+DB0vyUrY9BaYjwozk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0C9B131FD
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 06:42:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KIT9I17C+mQZeQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 06:42:38 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: remove CONFIG_BTRFS_FS_CHECK_INTEGRITY macro
Date:   Fri,  8 Sep 2023 14:42:17 +0800
Message-ID: <29b0b8b86012e744e2b24d4a9b23c13856c4c832.1694154699.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1694154699.git.wqu@suse.com>
References: <cover.1694154699.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since all check-intergrity entrances have been removed, let's also
remove the config and all related code relying on that.

And since we have removed the mount option for check-intergrity, we also
need to re-number all the BTRFS_MOUNT_* enums.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/Kconfig   | 21 -----------------
 fs/btrfs/disk-io.c | 28 -----------------------
 fs/btrfs/fs.h      | 27 +++++++++-------------
 fs/btrfs/super.c   | 56 ----------------------------------------------
 4 files changed, 11 insertions(+), 121 deletions(-)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index a25c9910d90b..4fb925e8c981 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -48,27 +48,6 @@ config BTRFS_FS_POSIX_ACL
 
 	  If you don't know what Access Control Lists are, say N
 
-config BTRFS_FS_CHECK_INTEGRITY
-	bool "Btrfs with integrity check tool compiled in (DEPRECATED)"
-	depends on BTRFS_FS
-	help
-	  This feature has been deprecated and will be removed in 6.7.
-
-	  Adds code that examines all block write requests (including
-	  writes of the super block). The goal is to verify that the
-	  state of the filesystem on disk is always consistent, i.e.,
-	  after a power-loss or kernel panic event the filesystem is
-	  in a consistent state.
-
-	  If the integrity check tool is included and activated in
-	  the mount options, plenty of kernel memory is used, and
-	  plenty of additional CPU cycles are spent. Enabling this
-	  functionality is not intended for normal use.
-
-	  In most cases, unless you are a btrfs developer who needs
-	  to verify the integrity of (super)-block write requests
-	  during the run of a regression test, say N
-
 config BTRFS_FS_RUN_SANITY_TESTS
 	bool "Btrfs will run sanity tests upon loading"
 	depends on BTRFS_FS
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 728dab15d620..41570fb0ec7a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2735,9 +2735,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	spin_lock_init(&fs_info->ordered_root_lock);
 
 	btrfs_init_scrub(fs_info);
-#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
-	fs_info->check_integrity_print_mask = 0;
-#endif
 	btrfs_init_balance(fs_info);
 	btrfs_init_async_reclaim_work(fs_info);
 
@@ -3903,21 +3900,6 @@ static void write_dev_flush(struct btrfs_device *device)
 
 	device->last_flush_error = BLK_STS_OK;
 
-#ifndef CONFIG_BTRFS_FS_CHECK_INTEGRITY
-	/*
-	 * When a disk has write caching disabled, we skip submission of a bio
-	 * with flush and sync requests before writing the superblock, since
-	 * it's not needed. However when the integrity checker is enabled, this
-	 * results in reports that there are metadata blocks referred by a
-	 * superblock that were not properly flushed. So don't skip the bio
-	 * submission only when the integrity checker is enabled for the sake
-	 * of simplicity, since this is a debug tool and not meant for use in
-	 * non-debug builds.
-	 */
-	if (!bdev_write_cache(device->bdev))
-		return;
-#endif
-
 	bio_init(bio, device->bdev, NULL, 0,
 		 REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH);
 	bio->bi_end_io = btrfs_end_empty_barrier;
@@ -4421,16 +4403,6 @@ void btrfs_mark_buffer_dirty(struct extent_buffer *buf)
 		WARN(1, KERN_CRIT "btrfs transid mismatch buffer %llu, found %llu running %llu\n",
 			buf->start, transid, fs_info->generation);
 	set_extent_buffer_dirty(buf);
-#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
-	/*
-	 * btrfs_check_leaf() won't check item data if we don't have WRITTEN
-	 * set, so this will only validate the basic structure of the items.
-	 */
-	if (btrfs_header_level(buf) == 0 && btrfs_check_leaf(buf)) {
-		btrfs_print_leaf(buf);
-		ASSERT(0);
-	}
-#endif
 }
 
 static void __btrfs_btree_balance_dirty(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index a523d64d5491..d84a390336fc 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -171,19 +171,17 @@ enum {
 	BTRFS_MOUNT_AUTO_DEFRAG			= (1UL << 16),
 	BTRFS_MOUNT_USEBACKUPROOT		= (1UL << 17),
 	BTRFS_MOUNT_SKIP_BALANCE		= (1UL << 18),
-	BTRFS_MOUNT_CHECK_INTEGRITY		= (1UL << 19),
-	BTRFS_MOUNT_CHECK_INTEGRITY_DATA	= (1UL << 20),
-	BTRFS_MOUNT_PANIC_ON_FATAL_ERROR	= (1UL << 21),
-	BTRFS_MOUNT_RESCAN_UUID_TREE		= (1UL << 22),
-	BTRFS_MOUNT_FRAGMENT_DATA		= (1UL << 23),
-	BTRFS_MOUNT_FRAGMENT_METADATA		= (1UL << 24),
-	BTRFS_MOUNT_FREE_SPACE_TREE		= (1UL << 25),
-	BTRFS_MOUNT_NOLOGREPLAY			= (1UL << 26),
-	BTRFS_MOUNT_REF_VERIFY			= (1UL << 27),
-	BTRFS_MOUNT_DISCARD_ASYNC		= (1UL << 28),
-	BTRFS_MOUNT_IGNOREBADROOTS		= (1UL << 29),
-	BTRFS_MOUNT_IGNOREDATACSUMS		= (1UL << 30),
-	BTRFS_MOUNT_NODISCARD			= (1UL << 31),
+	BTRFS_MOUNT_PANIC_ON_FATAL_ERROR	= (1UL << 19),
+	BTRFS_MOUNT_RESCAN_UUID_TREE		= (1UL << 20),
+	BTRFS_MOUNT_FRAGMENT_DATA		= (1UL << 21),
+	BTRFS_MOUNT_FRAGMENT_METADATA		= (1UL << 22),
+	BTRFS_MOUNT_FREE_SPACE_TREE		= (1UL << 23),
+	BTRFS_MOUNT_NOLOGREPLAY			= (1UL << 24),
+	BTRFS_MOUNT_REF_VERIFY			= (1UL << 25),
+	BTRFS_MOUNT_DISCARD_ASYNC		= (1UL << 26),
+	BTRFS_MOUNT_IGNOREBADROOTS		= (1UL << 27),
+	BTRFS_MOUNT_IGNOREDATACSUMS		= (1UL << 28),
+	BTRFS_MOUNT_NODISCARD			= (1UL << 29),
 };
 
 /*
@@ -645,9 +643,6 @@ struct btrfs_fs_info {
 
 	struct btrfs_discard_ctl discard_ctl;
 
-#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
-	u32 check_integrity_print_mask;
-#endif
 	/* Is qgroup tracking in a consistent state? */
 	u64 qgroup_flags;
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 56deb2e1bf7d..8d87b474018e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -130,9 +130,6 @@ enum {
 	Opt_inode_cache, Opt_noinode_cache,
 
 	/* Debugging options */
-	Opt_check_integrity,
-	Opt_check_integrity_including_extent_data,
-	Opt_check_integrity_print_mask,
 	Opt_enospc_debug, Opt_noenospc_debug,
 #ifdef CONFIG_BTRFS_DEBUG
 	Opt_fragment_data, Opt_fragment_metadata, Opt_fragment_all,
@@ -201,9 +198,6 @@ static const match_table_t tokens = {
 	{Opt_recovery, "recovery"},
 
 	/* Debugging options */
-	{Opt_check_integrity, "check_int"},
-	{Opt_check_integrity_including_extent_data, "check_int_data"},
-	{Opt_check_integrity_print_mask, "check_int_print_mask=%u"},
 	{Opt_enospc_debug, "enospc_debug"},
 	{Opt_noenospc_debug, "noenospc_debug"},
 #ifdef CONFIG_BTRFS_DEBUG
@@ -708,44 +702,6 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		case Opt_skip_balance:
 			btrfs_set_opt(info->mount_opt, SKIP_BALANCE);
 			break;
-#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
-		case Opt_check_integrity_including_extent_data:
-			btrfs_warn(info,
-	"integrity checker is deprecated and will be removed in 6.7");
-			btrfs_info(info,
-				   "enabling check integrity including extent data");
-			btrfs_set_opt(info->mount_opt, CHECK_INTEGRITY_DATA);
-			btrfs_set_opt(info->mount_opt, CHECK_INTEGRITY);
-			break;
-		case Opt_check_integrity:
-			btrfs_warn(info,
-	"integrity checker is deprecated and will be removed in 6.7");
-			btrfs_info(info, "enabling check integrity");
-			btrfs_set_opt(info->mount_opt, CHECK_INTEGRITY);
-			break;
-		case Opt_check_integrity_print_mask:
-			ret = match_int(&args[0], &intarg);
-			if (ret) {
-				btrfs_err(info,
-				"unrecognized check_integrity_print_mask value %s",
-					args[0].from);
-				goto out;
-			}
-			info->check_integrity_print_mask = intarg;
-			btrfs_warn(info,
-	"integrity checker is deprecated and will be removed in 6.7");
-			btrfs_info(info, "check_integrity_print_mask 0x%x",
-				   info->check_integrity_print_mask);
-			break;
-#else
-		case Opt_check_integrity_including_extent_data:
-		case Opt_check_integrity:
-		case Opt_check_integrity_print_mask:
-			btrfs_err(info,
-				  "support for check_integrity* not compiled in!");
-			ret = -EINVAL;
-			goto out;
-#endif
 		case Opt_fatal_errors:
 			if (strcmp(args[0].from, "panic") == 0) {
 				btrfs_set_opt(info->mount_opt,
@@ -1306,15 +1262,6 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",autodefrag");
 	if (btrfs_test_opt(info, SKIP_BALANCE))
 		seq_puts(seq, ",skip_balance");
-#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
-	if (btrfs_test_opt(info, CHECK_INTEGRITY_DATA))
-		seq_puts(seq, ",check_int_data");
-	else if (btrfs_test_opt(info, CHECK_INTEGRITY))
-		seq_puts(seq, ",check_int");
-	if (info->check_integrity_print_mask)
-		seq_printf(seq, ",check_int_print_mask=%d",
-				info->check_integrity_print_mask);
-#endif
 	if (info->metadata_ratio)
 		seq_printf(seq, ",metadata_ratio=%u", info->metadata_ratio);
 	if (btrfs_test_opt(info, PANIC_ON_FATAL_ERROR))
@@ -2406,9 +2353,6 @@ static int __init btrfs_print_mod_info(void)
 #ifdef CONFIG_BTRFS_ASSERT
 			", assert=on"
 #endif
-#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
-			", integrity-checker=on"
-#endif
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 			", ref-verify=on"
 #endif
-- 
2.42.0

