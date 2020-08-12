Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D50242E05
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 19:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHLRYY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 13:24:24 -0400
Received: from gateway20.websitewelcome.com ([192.185.60.19]:35109 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725993AbgHLRYX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 13:24:23 -0400
X-Greylist: delayed 1501 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Aug 2020 13:24:21 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id EE345400DE5FF
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Aug 2020 10:14:25 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 5tkik1ku1Xp2A5tkikP7vJ; Wed, 12 Aug 2020 11:37:24 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/ZkWlRCSz6RjY6K+qOL9VKvjrSo/ErdxCvJO5GKxSYE=; b=MtLUmwshbBQosiiZnOPKez0E0N
        NEDEZJSdwyzifzwZuE2WIMp/8PBB1X8LsbgQie64xOTVg6UH0eAhOIszVE+BwFr+vI2lFrhO+GCxn
        D4KvBxZDPT7FxnPbvAwgeeIDv9tqmy+6LEr7uch7AX0Lu41dKJoxjzjTtiir3GXq7/PNmu33yHwFO
        oDlvBFJX2FMduZ5XITIe0HopRqPJ9FUpDkpb9bliB8YN35itZTDTGDidmxZhkTaEhEog53apNJpt4
        c9uIeH2bZs8r0+cEdsNV947DWORSzurqlOqSFJIaqfdtlG38g8hGN3RLAFW7rOP57IF8cbTFM6w3R
        PQ2gC/vQ==;
Received: from [179.185.221.211] (port=55300 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1k5tkh-004J9r-UU; Wed, 12 Aug 2020 13:37:24 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [RFC PATCH 8/8] btrfs: Remove leftover code from fscontext conversion
Date:   Wed, 12 Aug 2020 13:36:54 -0300
Message-Id: <20200812163654.17080-9-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812163654.17080-1-marcos@mpdesouza.com>
References: <20200812163654.17080-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.185.221.211
X-Source-L: No
X-Exim-ID: 1k5tkh-004J9r-UU
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [179.185.221.211]:55300
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 26
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

* Remove all Opt_no* options, since the fscontext have a flag_no version
  which also handles this option variation.

* Remove all old parse_* function, since now btrfs_fc_parse_param
  handles all options.

* Remove the btrfs_root_fs_type now that btrfs_fs_type handles both root
  fs and subvolumes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/super.c | 784 +----------------------------------------------
 1 file changed, 14 insertions(+), 770 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d9a0faea8c88..8e2feef075c9 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -55,16 +55,6 @@
 
 static const struct super_operations btrfs_super_ops;
 
-/*
- * Types for mounting the default subvolume and a subvolume explicitly
- * requested by subvol=/path. That way the callchain is straightforward and we
- * don't have to play tricks with the mount options and recursive calls to
- * btrfs_mount.
- *
- * The new btrfs_root_fs_type also servers as a tag for the bdev_holder.
- */
-static struct file_system_type btrfs_root_fs_type;
-
 static int btrfs_reconfigure(struct fs_context *fc);
 
 /*
@@ -322,7 +312,7 @@ static void btrfs_put_super(struct super_block *sb)
 }
 
 enum {
-	Opt_acl, Opt_noacl,
+	Opt_acl,
 	Opt_clear_cache,
 	Opt_commit_interval,
 	Opt_compress,
@@ -332,28 +322,28 @@ enum {
 	Opt_degraded,
 	Opt_device,
 	Opt_fatal_errors,
-	Opt_flushoncommit, Opt_noflushoncommit,
-	Opt_inode_cache, Opt_noinode_cache,
+	Opt_flushoncommit,
+	Opt_inode_cache,
 	Opt_max_inline,
-	Opt_barrier, Opt_nobarrier,
-	Opt_datacow, Opt_nodatacow,
-	Opt_datasum, Opt_nodatasum,
-	Opt_defrag, Opt_nodefrag,
-	Opt_discard, Opt_nodiscard,
+	Opt_barrier,
+	Opt_datacow,
+	Opt_datasum,
+	Opt_defrag,
+	Opt_discard,
 	Opt_discard_mode,
 	Opt_norecovery,
 	Opt_ratio,
 	Opt_rescan_uuid_tree,
 	Opt_skip_balance,
-	Opt_space_cache, Opt_no_space_cache,
+	Opt_space_cache,
 	Opt_space_cache_version,
-	Opt_ssd, Opt_nossd,
-	Opt_ssd_spread, Opt_nossd_spread,
+	Opt_ssd,
+	Opt_ssd_spread,
 	Opt_subvol,
 	Opt_subvol_empty,
 	Opt_subvolid,
 	Opt_thread_pool,
-	Opt_treelog, Opt_notreelog,
+	Opt_treelog,
 	Opt_user_subvol_rm_allowed,
 
 	/* Rescue options */
@@ -368,10 +358,9 @@ enum {
 	Opt_check_integrity,
 	Opt_check_integrity_including_extent_data,
 	Opt_check_integrity_print_mask,
-	Opt_enospc_debug, Opt_noenospc_debug,
+	Opt_enospc_debug,
 #ifdef CONFIG_BTRFS_DEBUG
 	Opt_fragment,
-	Opt_fragment_data, Opt_fragment_metadata, Opt_fragment_all,
 #endif
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	Opt_ref_verify,
@@ -379,86 +368,6 @@ enum {
 	Opt_err,
 };
 
-static const match_table_t tokens = {
-	{Opt_acl, "acl"},
-	{Opt_noacl, "noacl"},
-	{Opt_clear_cache, "clear_cache"},
-	{Opt_commit_interval, "commit=%u"},
-	{Opt_compress, "compress"},
-	{Opt_compress_type, "compress=%s"},
-	{Opt_compress_force, "compress-force"},
-	{Opt_compress_force_type, "compress-force=%s"},
-	{Opt_degraded, "degraded"},
-	{Opt_device, "device=%s"},
-	{Opt_fatal_errors, "fatal_errors=%s"},
-	{Opt_flushoncommit, "flushoncommit"},
-	{Opt_noflushoncommit, "noflushoncommit"},
-	{Opt_inode_cache, "inode_cache"},
-	{Opt_noinode_cache, "noinode_cache"},
-	{Opt_max_inline, "max_inline=%s"},
-	{Opt_barrier, "barrier"},
-	{Opt_nobarrier, "nobarrier"},
-	{Opt_datacow, "datacow"},
-	{Opt_nodatacow, "nodatacow"},
-	{Opt_datasum, "datasum"},
-	{Opt_nodatasum, "nodatasum"},
-	{Opt_defrag, "autodefrag"},
-	{Opt_nodefrag, "noautodefrag"},
-	{Opt_discard, "discard"},
-	{Opt_discard_mode, "discard=%s"},
-	{Opt_nodiscard, "nodiscard"},
-	{Opt_norecovery, "norecovery"},
-	{Opt_ratio, "metadata_ratio=%u"},
-	{Opt_rescan_uuid_tree, "rescan_uuid_tree"},
-	{Opt_skip_balance, "skip_balance"},
-	{Opt_space_cache, "space_cache"},
-	{Opt_no_space_cache, "nospace_cache"},
-	{Opt_space_cache_version, "space_cache=%s"},
-	{Opt_ssd, "ssd"},
-	{Opt_nossd, "nossd"},
-	{Opt_ssd_spread, "ssd_spread"},
-	{Opt_nossd_spread, "nossd_spread"},
-	{Opt_subvol, "subvol=%s"},
-	{Opt_subvol_empty, "subvol="},
-	{Opt_subvolid, "subvolid=%s"},
-	{Opt_thread_pool, "thread_pool=%u"},
-	{Opt_treelog, "treelog"},
-	{Opt_notreelog, "notreelog"},
-	{Opt_user_subvol_rm_allowed, "user_subvol_rm_allowed"},
-
-	/* Rescue options */
-	{Opt_rescue, "rescue=%s"},
-	/* Deprecated, with alias rescue=nologreplay */
-	{Opt_nologreplay, "nologreplay"},
-	/* Deprecated, with alias rescue=usebackuproot */
-	{Opt_usebackuproot, "usebackuproot"},
-
-	/* Deprecated options */
-	{Opt_recovery, "recovery"},
-
-	/* Debugging options */
-	{Opt_check_integrity, "check_int"},
-	{Opt_check_integrity_including_extent_data, "check_int_data"},
-	{Opt_check_integrity_print_mask, "check_int_print_mask=%u"},
-	{Opt_enospc_debug, "enospc_debug"},
-	{Opt_noenospc_debug, "noenospc_debug"},
-#ifdef CONFIG_BTRFS_DEBUG
-	{Opt_fragment_data, "fragment=data"},
-	{Opt_fragment_metadata, "fragment=metadata"},
-	{Opt_fragment_all, "fragment=all"},
-#endif
-#ifdef CONFIG_BTRFS_FS_REF_VERIFY
-	{Opt_ref_verify, "ref_verify"},
-#endif
-	{Opt_err, NULL},
-};
-
-static const match_table_t rescue_tokens = {
-	{Opt_usebackuproot, "usebackuproot"},
-	{Opt_nologreplay, "nologreplay"},
-	{Opt_err, NULL},
-};
-
 static const struct fs_parameter_spec btrfs_fs_parameters[] = {
 	fsparam_flag_no("acl", Opt_acl),
 	fsparam_flag_no("autodefrag", Opt_defrag),
@@ -518,538 +427,6 @@ static const struct fs_parameter_spec btrfs_fs_parameters[] = {
 	{}
 };
 
-static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
-{
-	char *opts;
-	char *orig;
-	char *p;
-	substring_t args[MAX_OPT_ARGS];
-	int ret = 0;
-
-	opts = kstrdup(options, GFP_KERNEL);
-	if (!opts)
-		return -ENOMEM;
-	orig = opts;
-
-	while ((p = strsep(&opts, ":")) != NULL) {
-		int token;
-
-		if (!*p)
-			continue;
-		token = match_token(p, rescue_tokens, args);
-		switch (token){
-		case Opt_usebackuproot:
-			btrfs_info(info,
-				   "trying to use backup root at mount time");
-			btrfs_set_opt(info->mount_opt, USEBACKUPROOT);
-			break;
-		case Opt_nologreplay:
-			btrfs_set_and_info(info, NOLOGREPLAY,
-					   "disabling log replay at mount time");
-			break;
-		case Opt_err:
-			btrfs_info(info, "unrecognized rescue option '%s'", p);
-			ret = -EINVAL;
-			goto out;
-		default:
-			break;
-		}
-
-	}
-out:
-	kfree(orig);
-	return ret;
-}
-
-/*
- * Regular mount options parser.  Everything that is needed only when
- * reading in a new superblock is parsed here.
- * XXX JDM: This needs to be cleaned up for remount.
- */
-int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
-			unsigned long new_flags)
-{
-	substring_t args[MAX_OPT_ARGS];
-	char *p, *num;
-	u64 cache_gen;
-	int intarg;
-	int ret = 0;
-	char *compress_type;
-	bool compress_force = false;
-	enum btrfs_compression_type saved_compress_type;
-	int saved_compress_level;
-	bool saved_compress_force;
-	int no_compress = 0;
-
-	cache_gen = btrfs_super_cache_generation(info->super_copy);
-	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
-		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
-	else if (cache_gen)
-		btrfs_set_opt(info->mount_opt, SPACE_CACHE);
-
-	/*
-	 * Even the options are empty, we still need to do extra check
-	 * against new flags
-	 */
-	if (!options)
-		goto check;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		int token;
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_degraded:
-			btrfs_info(info, "allowing degraded mounts");
-			btrfs_set_opt(info->mount_opt, DEGRADED);
-			break;
-		case Opt_subvol:
-		case Opt_subvol_empty:
-		case Opt_subvolid:
-		case Opt_device:
-			/*
-			 * These are parsed by btrfs_parse_subvol_options or
-			 * btrfs_parse_device_options and can be ignored here.
-			 */
-			break;
-		case Opt_nodatasum:
-			btrfs_set_and_info(info, NODATASUM,
-					   "setting nodatasum");
-			break;
-		case Opt_datasum:
-			if (btrfs_test_opt(info, NODATASUM)) {
-				if (btrfs_test_opt(info, NODATACOW))
-					btrfs_info(info,
-						   "setting datasum, datacow enabled");
-				else
-					btrfs_info(info, "setting datasum");
-			}
-			btrfs_clear_opt(info->mount_opt, NODATACOW);
-			btrfs_clear_opt(info->mount_opt, NODATASUM);
-			break;
-		case Opt_nodatacow:
-			if (!btrfs_test_opt(info, NODATACOW)) {
-				if (!btrfs_test_opt(info, COMPRESS) ||
-				    !btrfs_test_opt(info, FORCE_COMPRESS)) {
-					btrfs_info(info,
-						   "setting nodatacow, compression disabled");
-				} else {
-					btrfs_info(info, "setting nodatacow");
-				}
-			}
-			btrfs_clear_opt(info->mount_opt, COMPRESS);
-			btrfs_clear_opt(info->mount_opt, FORCE_COMPRESS);
-			btrfs_set_opt(info->mount_opt, NODATACOW);
-			btrfs_set_opt(info->mount_opt, NODATASUM);
-			break;
-		case Opt_datacow:
-			btrfs_clear_and_info(info, NODATACOW,
-					     "setting datacow");
-			break;
-		case Opt_compress_force:
-		case Opt_compress_force_type:
-			compress_force = true;
-			fallthrough;
-		case Opt_compress:
-		case Opt_compress_type:
-			saved_compress_type = btrfs_test_opt(info,
-							     COMPRESS) ?
-				info->compress_type : BTRFS_COMPRESS_NONE;
-			saved_compress_force =
-				btrfs_test_opt(info, FORCE_COMPRESS);
-			saved_compress_level = info->compress_level;
-			if (token == Opt_compress ||
-			    token == Opt_compress_force ||
-			    strncmp(args[0].from, "zlib", 4) == 0) {
-				compress_type = "zlib";
-
-				info->compress_type = BTRFS_COMPRESS_ZLIB;
-				info->compress_level = BTRFS_ZLIB_DEFAULT_LEVEL;
-				/*
-				 * args[0] contains uninitialized data since
-				 * for these tokens we don't expect any
-				 * parameter.
-				 */
-				if (token != Opt_compress &&
-				    token != Opt_compress_force)
-					info->compress_level =
-					  btrfs_compress_str2level(
-							BTRFS_COMPRESS_ZLIB,
-							args[0].from + 4);
-				btrfs_set_opt(info->mount_opt, COMPRESS);
-				btrfs_clear_opt(info->mount_opt, NODATACOW);
-				btrfs_clear_opt(info->mount_opt, NODATASUM);
-				no_compress = 0;
-			} else if (strncmp(args[0].from, "lzo", 3) == 0) {
-				compress_type = "lzo";
-				info->compress_type = BTRFS_COMPRESS_LZO;
-				btrfs_set_opt(info->mount_opt, COMPRESS);
-				btrfs_clear_opt(info->mount_opt, NODATACOW);
-				btrfs_clear_opt(info->mount_opt, NODATASUM);
-				btrfs_set_fs_incompat(info, COMPRESS_LZO);
-				no_compress = 0;
-			} else if (strncmp(args[0].from, "zstd", 4) == 0) {
-				compress_type = "zstd";
-				info->compress_type = BTRFS_COMPRESS_ZSTD;
-				info->compress_level =
-					btrfs_compress_str2level(
-							 BTRFS_COMPRESS_ZSTD,
-							 args[0].from + 4);
-				btrfs_set_opt(info->mount_opt, COMPRESS);
-				btrfs_clear_opt(info->mount_opt, NODATACOW);
-				btrfs_clear_opt(info->mount_opt, NODATASUM);
-				btrfs_set_fs_incompat(info, COMPRESS_ZSTD);
-				no_compress = 0;
-			} else if (strncmp(args[0].from, "no", 2) == 0) {
-				compress_type = "no";
-				info->compress_level = 0;
-				info->compress_type = 0;
-				btrfs_clear_opt(info->mount_opt, COMPRESS);
-				btrfs_clear_opt(info->mount_opt, FORCE_COMPRESS);
-				compress_force = false;
-				no_compress++;
-			} else {
-				ret = -EINVAL;
-				goto out;
-			}
-
-			if (compress_force) {
-				btrfs_set_opt(info->mount_opt, FORCE_COMPRESS);
-			} else {
-				/*
-				 * If we remount from compress-force=xxx to
-				 * compress=xxx, we need clear FORCE_COMPRESS
-				 * flag, otherwise, there is no way for users
-				 * to disable forcible compression separately.
-				 */
-				btrfs_clear_opt(info->mount_opt, FORCE_COMPRESS);
-			}
-			if (no_compress == 1) {
-				btrfs_info(info, "use no compression");
-			} else if ((info->compress_type != saved_compress_type) ||
-				   (compress_force != saved_compress_force) ||
-				   (info->compress_level != saved_compress_level)) {
-				btrfs_info(info, "%s %s compression, level %d",
-					   (compress_force) ? "force" : "use",
-					   compress_type, info->compress_level);
-			}
-			compress_force = false;
-			break;
-		case Opt_ssd:
-			btrfs_set_and_info(info, SSD,
-					   "enabling ssd optimizations");
-			btrfs_clear_opt(info->mount_opt, NOSSD);
-			break;
-		case Opt_ssd_spread:
-			btrfs_set_and_info(info, SSD,
-					   "enabling ssd optimizations");
-			btrfs_set_and_info(info, SSD_SPREAD,
-					   "using spread ssd allocation scheme");
-			btrfs_clear_opt(info->mount_opt, NOSSD);
-			break;
-		case Opt_nossd:
-			btrfs_set_opt(info->mount_opt, NOSSD);
-			btrfs_clear_and_info(info, SSD,
-					     "not using ssd optimizations");
-			fallthrough;
-		case Opt_nossd_spread:
-			btrfs_clear_and_info(info, SSD_SPREAD,
-					     "not using spread ssd allocation scheme");
-			break;
-		case Opt_barrier:
-			btrfs_clear_and_info(info, NOBARRIER,
-					     "turning on barriers");
-			break;
-		case Opt_nobarrier:
-			btrfs_set_and_info(info, NOBARRIER,
-					   "turning off barriers");
-			break;
-		case Opt_thread_pool:
-			ret = match_int(&args[0], &intarg);
-			if (ret) {
-				goto out;
-			} else if (intarg == 0) {
-				ret = -EINVAL;
-				goto out;
-			}
-			info->thread_pool_size = intarg;
-			break;
-		case Opt_max_inline:
-			num = match_strdup(&args[0]);
-			if (num) {
-				info->max_inline = memparse(num, NULL);
-				kfree(num);
-
-				if (info->max_inline) {
-					info->max_inline = min_t(u64,
-						info->max_inline,
-						info->sectorsize);
-				}
-				btrfs_info(info, "max_inline at %llu",
-					   info->max_inline);
-			} else {
-				ret = -ENOMEM;
-				goto out;
-			}
-			break;
-		case Opt_acl:
-#ifdef CONFIG_BTRFS_FS_POSIX_ACL
-			info->sb->s_flags |= SB_POSIXACL;
-			break;
-#else
-			btrfs_err(info, "support for ACL not compiled in!");
-			ret = -EINVAL;
-			goto out;
-#endif
-		case Opt_noacl:
-			info->sb->s_flags &= ~SB_POSIXACL;
-			break;
-		case Opt_notreelog:
-			btrfs_set_and_info(info, NOTREELOG,
-					   "disabling tree log");
-			break;
-		case Opt_treelog:
-			btrfs_clear_and_info(info, NOTREELOG,
-					     "enabling tree log");
-			break;
-		case Opt_norecovery:
-		case Opt_nologreplay:
-			btrfs_warn(info,
-		"'nologreplay' is deprecated, use 'rescue=nologreplay' instead");
-			btrfs_set_and_info(info, NOLOGREPLAY,
-					   "disabling log replay at mount time");
-			break;
-		case Opt_flushoncommit:
-			btrfs_set_and_info(info, FLUSHONCOMMIT,
-					   "turning on flush-on-commit");
-			break;
-		case Opt_noflushoncommit:
-			btrfs_clear_and_info(info, FLUSHONCOMMIT,
-					     "turning off flush-on-commit");
-			break;
-		case Opt_ratio:
-			ret = match_int(&args[0], &intarg);
-			if (ret)
-				goto out;
-			info->metadata_ratio = intarg;
-			btrfs_info(info, "metadata ratio %u",
-				   info->metadata_ratio);
-			break;
-		case Opt_discard:
-		case Opt_discard_mode:
-			if (token == Opt_discard ||
-			    strcmp(args[0].from, "sync") == 0) {
-				btrfs_clear_opt(info->mount_opt, DISCARD_ASYNC);
-				btrfs_set_and_info(info, DISCARD_SYNC,
-						   "turning on sync discard");
-			} else if (strcmp(args[0].from, "async") == 0) {
-				btrfs_clear_opt(info->mount_opt, DISCARD_SYNC);
-				btrfs_set_and_info(info, DISCARD_ASYNC,
-						   "turning on async discard");
-			} else {
-				ret = -EINVAL;
-				goto out;
-			}
-			break;
-		case Opt_nodiscard:
-			btrfs_clear_and_info(info, DISCARD_SYNC,
-					     "turning off discard");
-			btrfs_clear_and_info(info, DISCARD_ASYNC,
-					     "turning off async discard");
-			break;
-		case Opt_space_cache:
-		case Opt_space_cache_version:
-			if (token == Opt_space_cache ||
-			    strcmp(args[0].from, "v1") == 0) {
-				btrfs_clear_opt(info->mount_opt,
-						FREE_SPACE_TREE);
-				btrfs_set_and_info(info, SPACE_CACHE,
-					   "enabling disk space caching");
-			} else if (strcmp(args[0].from, "v2") == 0) {
-				btrfs_clear_opt(info->mount_opt,
-						SPACE_CACHE);
-				btrfs_set_and_info(info, FREE_SPACE_TREE,
-						   "enabling free space tree");
-			} else {
-				ret = -EINVAL;
-				goto out;
-			}
-			break;
-		case Opt_rescan_uuid_tree:
-			btrfs_set_opt(info->mount_opt, RESCAN_UUID_TREE);
-			break;
-		case Opt_no_space_cache:
-			if (btrfs_test_opt(info, SPACE_CACHE)) {
-				btrfs_clear_and_info(info, SPACE_CACHE,
-					     "disabling disk space caching");
-			}
-			if (btrfs_test_opt(info, FREE_SPACE_TREE)) {
-				btrfs_clear_and_info(info, FREE_SPACE_TREE,
-					     "disabling free space tree");
-			}
-			break;
-		case Opt_inode_cache:
-			btrfs_warn(info,
-	"the 'inode_cache' option is deprecated and will have no effect from 5.11");
-			btrfs_set_pending_and_info(info, INODE_MAP_CACHE,
-					   "enabling inode map caching");
-			break;
-		case Opt_noinode_cache:
-			btrfs_clear_pending_and_info(info, INODE_MAP_CACHE,
-					     "disabling inode map caching");
-			break;
-		case Opt_clear_cache:
-			btrfs_set_and_info(info, CLEAR_CACHE,
-					   "force clearing of disk cache");
-			break;
-		case Opt_user_subvol_rm_allowed:
-			btrfs_set_opt(info->mount_opt, USER_SUBVOL_RM_ALLOWED);
-			break;
-		case Opt_enospc_debug:
-			btrfs_set_opt(info->mount_opt, ENOSPC_DEBUG);
-			break;
-		case Opt_noenospc_debug:
-			btrfs_clear_opt(info->mount_opt, ENOSPC_DEBUG);
-			break;
-		case Opt_defrag:
-			btrfs_set_and_info(info, AUTO_DEFRAG,
-					   "enabling auto defrag");
-			break;
-		case Opt_nodefrag:
-			btrfs_clear_and_info(info, AUTO_DEFRAG,
-					     "disabling auto defrag");
-			break;
-		case Opt_recovery:
-		case Opt_usebackuproot:
-			btrfs_warn(info,
-			"'%s' is deprecated, use 'rescue=usebackuproot' instead",
-				   token == Opt_recovery ? "recovery" :
-				   "usebackuproot");
-			btrfs_info(info,
-				   "trying to use backup root at mount time");
-			btrfs_set_opt(info->mount_opt, USEBACKUPROOT);
-			break;
-		case Opt_skip_balance:
-			btrfs_set_opt(info->mount_opt, SKIP_BALANCE);
-			break;
-#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
-		case Opt_check_integrity_including_extent_data:
-			btrfs_info(info,
-				   "enabling check integrity including extent data");
-			btrfs_set_opt(info->mount_opt,
-				      CHECK_INTEGRITY_INCLUDING_EXTENT_DATA);
-			btrfs_set_opt(info->mount_opt, CHECK_INTEGRITY);
-			break;
-		case Opt_check_integrity:
-			btrfs_info(info, "enabling check integrity");
-			btrfs_set_opt(info->mount_opt, CHECK_INTEGRITY);
-			break;
-		case Opt_check_integrity_print_mask:
-			ret = match_int(&args[0], &intarg);
-			if (ret)
-				goto out;
-			info->check_integrity_print_mask = intarg;
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
-		case Opt_fatal_errors:
-			if (strcmp(args[0].from, "panic") == 0)
-				btrfs_set_opt(info->mount_opt,
-					      PANIC_ON_FATAL_ERROR);
-			else if (strcmp(args[0].from, "bug") == 0)
-				btrfs_clear_opt(info->mount_opt,
-					      PANIC_ON_FATAL_ERROR);
-			else {
-				ret = -EINVAL;
-				goto out;
-			}
-			break;
-		case Opt_commit_interval:
-			intarg = 0;
-			ret = match_int(&args[0], &intarg);
-			if (ret)
-				goto out;
-			if (intarg == 0) {
-				btrfs_info(info,
-					   "using default commit interval %us",
-					   BTRFS_DEFAULT_COMMIT_INTERVAL);
-				intarg = BTRFS_DEFAULT_COMMIT_INTERVAL;
-			} else if (intarg > 300) {
-				btrfs_warn(info, "excessive commit interval %d",
-					   intarg);
-			}
-			info->commit_interval = intarg;
-			break;
-		case Opt_rescue:
-			ret = parse_rescue_options(info, args[0].from);
-			if (ret < 0)
-				goto out;
-			break;
-#ifdef CONFIG_BTRFS_DEBUG
-		case Opt_fragment_all:
-			btrfs_info(info, "fragmenting all space");
-			btrfs_set_opt(info->mount_opt, FRAGMENT_DATA);
-			btrfs_set_opt(info->mount_opt, FRAGMENT_METADATA);
-			break;
-		case Opt_fragment_metadata:
-			btrfs_info(info, "fragmenting metadata");
-			btrfs_set_opt(info->mount_opt,
-				      FRAGMENT_METADATA);
-			break;
-		case Opt_fragment_data:
-			btrfs_info(info, "fragmenting data");
-			btrfs_set_opt(info->mount_opt, FRAGMENT_DATA);
-			break;
-#endif
-#ifdef CONFIG_BTRFS_FS_REF_VERIFY
-		case Opt_ref_verify:
-			btrfs_info(info, "doing ref verification");
-			btrfs_set_opt(info->mount_opt, REF_VERIFY);
-			break;
-#endif
-		case Opt_err:
-			btrfs_err(info, "unrecognized mount option '%s'", p);
-			ret = -EINVAL;
-			goto out;
-		default:
-			break;
-		}
-	}
-check:
-	/*
-	 * Extra check for current option against current flag
-	 */
-	if (btrfs_test_opt(info, NOLOGREPLAY) && !(new_flags & SB_RDONLY)) {
-		btrfs_err(info,
-			  "nologreplay must be used with ro mount option");
-		ret = -EINVAL;
-	}
-out:
-	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
-	    !btrfs_test_opt(info, FREE_SPACE_TREE) &&
-	    !btrfs_test_opt(info, CLEAR_CACHE)) {
-		btrfs_err(info, "cannot disable free space tree");
-		ret = -EINVAL;
-
-	}
-	if (!ret && btrfs_test_opt(info, SPACE_CACHE))
-		btrfs_info(info, "disk space caching is enabled");
-	if (!ret && btrfs_test_opt(info, FREE_SPACE_TREE))
-		btrfs_info(info, "using free space tree");
-	return ret;
-}
-
 struct btrfs_flag_map {
        int bit;
        bool enabled;
@@ -1499,123 +876,6 @@ static int btrfs_fc_parse_param(struct fs_context *fc, struct fs_parameter *para
 	return 0;
 }
 
-/*
- * Parse mount options that are required early in the mount process.
- *
- * All other options will be parsed on much later in the mount process and
- * only when we need to allocate a new super block.
- */
-static int btrfs_parse_device_options(const char *options, fmode_t flags,
-				      void *holder)
-{
-	substring_t args[MAX_OPT_ARGS];
-	char *device_name, *opts, *orig, *p;
-	struct btrfs_device *device = NULL;
-	int error = 0;
-
-	lockdep_assert_held(&uuid_mutex);
-
-	if (!options)
-		return 0;
-
-	/*
-	 * strsep changes the string, duplicate it because btrfs_parse_options
-	 * gets called later
-	 */
-	opts = kstrdup(options, GFP_KERNEL);
-	if (!opts)
-		return -ENOMEM;
-	orig = opts;
-
-	while ((p = strsep(&opts, ",")) != NULL) {
-		int token;
-
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		if (token == Opt_device) {
-			device_name = match_strdup(&args[0]);
-			if (!device_name) {
-				error = -ENOMEM;
-				goto out;
-			}
-			device = btrfs_scan_one_device(device_name, flags,
-							&btrfs_fs_type);
-			kfree(device_name);
-			if (IS_ERR(device)) {
-				error = PTR_ERR(device);
-				goto out;
-			}
-		}
-	}
-
-out:
-	kfree(orig);
-	return error;
-}
-
-/*
- * Parse mount options that are related to subvolume id
- *
- * The value is later passed to mount_subvol()
- */
-static int btrfs_parse_subvol_options(const char *options, char **subvol_name,
-		u64 *subvol_objectid)
-{
-	substring_t args[MAX_OPT_ARGS];
-	char *opts, *orig, *p;
-	int error = 0;
-	u64 subvolid;
-
-	if (!options)
-		return 0;
-
-	/*
-	 * strsep changes the string, duplicate it because
-	 * btrfs_parse_device_options gets called later
-	 */
-	opts = kstrdup(options, GFP_KERNEL);
-	if (!opts)
-		return -ENOMEM;
-	orig = opts;
-
-	while ((p = strsep(&opts, ",")) != NULL) {
-		int token;
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_subvol:
-			kfree(*subvol_name);
-			*subvol_name = match_strdup(&args[0]);
-			if (!*subvol_name) {
-				error = -ENOMEM;
-				goto out;
-			}
-			break;
-		case Opt_subvolid:
-			error = match_u64(&args[0], &subvolid);
-			if (error)
-				goto out;
-
-			/* we want the original fs_tree */
-			if (subvolid == 0)
-				subvolid = BTRFS_FS_TREE_OBJECTID;
-
-			*subvol_objectid = subvolid;
-			break;
-		default:
-			break;
-		}
-	}
-
-out:
-	kfree(orig);
-	return error;
-}
-
 char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 					  u64 subvol_objectid)
 {
@@ -2042,7 +1302,7 @@ int btrfs_apply_configuration(struct fs_context *fc,
 
 	if (btrfs_test_exp_opt(ctx, NOTREELOG))
 		btrfs_info(info, "%s tree log",
-				btrfs_opt_map[Opt_notreelog].enabled ? "enabling"
+				btrfs_opt_map[Opt_treelog].enabled ? "enabling"
 				: "disabling");
 
 #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
@@ -2216,14 +1476,6 @@ static int btrfs_test_super(struct super_block *s, struct fs_context *fc)
 	return fs_info->fs_devices == p->fs_devices;
 }
 
-static int btrfs_set_super(struct super_block *s, void *data)
-{
-	int err = set_anon_super(s, data);
-	if (!err)
-		s->s_fs_info = data;
-	return err;
-}
-
 /*
  * subvolumes are identified by ino 256
  */
@@ -3081,14 +2333,6 @@ struct file_system_type btrfs_fs_type = {
 	.init_fs_context = btrfs_init_fs_context,
 	.kill_sb	= btrfs_kill_super,
 	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
-	};
-
-static struct file_system_type btrfs_root_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "btrfs",
-	.parameters	= btrfs_fs_parameters,
-	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
 };
 
 MODULE_ALIAS_FS("btrfs");
-- 
2.28.0

