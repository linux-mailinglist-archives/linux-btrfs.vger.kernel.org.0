Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA47242DCA
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 19:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgHLRCS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 13:02:18 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.222]:43488 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726558AbgHLRCR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 13:02:17 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 310EB1359C1A
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Aug 2020 11:37:18 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 5tkbk2dfxBD8b5tkckanoU; Wed, 12 Aug 2020 11:37:18 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2BMCy+0SbO7eVzsw1Y8+sDSJ6MFKuBG+3CNXULF3zus=; b=Qfl79ljySXPL5UkRHMTUT/JYB9
        PL6uE6w0Wm+RqvDXnyWSJ55kvauVZG+h12jZ6/AThMABswWrUkFmCoFeiyH7TdD1oN2AGFDDCCsPQ
        of+3IW65tWNjknpRkZkDkexkBmg3xDGJBfOnlfOHPx9uR182Vbx/zTf8RAk+hu6OeR3jPPHaejDZ3
        kEmP9ngBKfVe+FFYcrDzjPk6lyHCcjWpFY4IPLH/DEI43JNlD0b0hn+S/whJuoa1tMJTuECkqPwmk
        G6g/KGW167p1RbAWvU+xlroOzrOFz4XRoqmUZ5fLPMhIro1e1/8WyZy5Q9WeR0acPhFBvjcHhnCHc
        sjzh/MtA==;
Received: from [179.185.221.211] (port=55300 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1k5tkb-004J9r-2x; Wed, 12 Aug 2020 13:37:17 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [RFC PATCH 3/8] btrfs: super: Introduce btrfs_fc_parse_param and btrfs_apply_configuration
Date:   Wed, 12 Aug 2020 13:36:49 -0300
Message-Id: <20200812163654.17080-4-marcos@mpdesouza.com>
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
X-Exim-ID: 1k5tkb-004J9r-2x
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [179.185.221.211]:55300
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 11
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

The first function will parse the arguments using the new fs_context API
saving the arguments in btrfs_fs_context, while the second one populate
the settings of btrfs_fs_info using the context previously set.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/ctree.h |   1 +
 fs/btrfs/super.c | 609 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 610 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b7e3962a0941..d96bce2ea5bb 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3102,6 +3102,7 @@ int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
 /* super.c */
 int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			unsigned long new_flags);
+int btrfs_apply_configuration(struct fs_context *fc, struct super_block *sb);
 int btrfs_sync_fs(struct super_block *sb, int wait);
 char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 					  u64 subvol_objectid);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index fe19ffe962c6..3425a77ecd57 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1051,6 +1051,394 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	return ret;
 }
 
+struct btrfs_flag_map {
+       int bit;
+       bool enabled;
+};
+
+#define INIT_MAP(OPT) { BTRFS_MOUNT_##OPT, false }
+#define btrfs_test_exp_opt(fs_info, opt) \
+	((fs_info)->mount_opt_explicity & BTRFS_MOUNT_##opt)
+
+/* Opt_err is the latest option */
+static struct btrfs_flag_map btrfs_opt_map[Opt_err] = {
+	[Opt_barrier] = INIT_MAP(NOBARRIER),
+	[Opt_check_integrity] = INIT_MAP(CHECK_INTEGRITY),
+	[Opt_check_integrity_including_extent_data] =
+		INIT_MAP(CHECK_INTEGRITY_INCLUDING_EXTENT_DATA),
+	[Opt_datacow] = INIT_MAP(NODATACOW),
+	[Opt_datasum] = INIT_MAP(NODATASUM),
+	[Opt_discard] = INIT_MAP(DISCARD_SYNC),
+	[Opt_defrag] = INIT_MAP(AUTO_DEFRAG),
+	[Opt_degraded] = INIT_MAP(DEGRADED),
+	[Opt_flushoncommit] = INIT_MAP(FLUSHONCOMMIT),
+	[Opt_inode_cache] = INIT_MAP(INODE_MAP_CACHE),
+	[Opt_nologreplay] = INIT_MAP(NOLOGREPLAY),
+	[Opt_ssd] = INIT_MAP(SSD),
+	[Opt_ssd_spread] = INIT_MAP(SSD_SPREAD),
+	[Opt_treelog] = INIT_MAP(NOTREELOG),
+	[Opt_ref_verify] = INIT_MAP(REF_VERIFY),
+};
+
+static int btrfs_fc_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	int opt;
+	char *compress_type;
+	char **devs;
+	bool compress_force = false;
+	enum btrfs_compression_type saved_compress_type;
+	bool saved_compress_force;
+	struct fs_parse_result result;
+	struct btrfs_fs_context *ctx = fc->fs_private;
+
+	opt = fs_parse(fc, btrfs_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	/*
+	 * Store the option parsed to avoid being too noisy in
+	 * btrfs_apply_configuration.
+	 */
+	ctx->mount_opt_explicity |= btrfs_opt_map[opt].bit;
+	btrfs_opt_map[opt].enabled = !result.negated;
+
+	switch (opt) {
+	case Opt_acl:
+		if (result.negated) {
+			fc->sb_flags &= ~SB_POSIXACL;
+		} else {
+#ifndef CONFIG_BTRFS_FS_POSIX_ACL
+			return invalf(fc, "support for ACL not compiled in!");
+#else
+			fc->sb_flags |= SB_POSIXACL;
+#endif
+		}
+		break;
+	case Opt_barrier:
+		if (result.negated)
+			btrfs_set_opt(ctx->mount_opt, NOBARRIER);
+		else
+			btrfs_clear_opt(ctx->mount_opt, NOBARRIER);
+		break;
+	case Opt_clear_cache:
+		btrfs_set_opt(ctx->mount_opt, CLEAR_CACHE);
+		break;
+	case Opt_commit_interval:
+		ctx->commit_interval = result.uint_32;
+		break;
+	case Opt_compress_force:
+	case Opt_compress_force_type:
+		compress_force = true;
+		fallthrough;
+	case Opt_compress:
+	case Opt_compress_type:
+		saved_compress_type = btrfs_test_opt(ctx, COMPRESS) ?
+			ctx->compress_type : BTRFS_COMPRESS_NONE;
+		saved_compress_force =
+			btrfs_test_opt(ctx, FORCE_COMPRESS);
+		if (opt == Opt_compress ||
+		    opt == Opt_compress_force ||
+		    strncmp(param->string, "zlib", 4) == 0) {
+			compress_type = "zlib";
+
+			ctx->compress_type = BTRFS_COMPRESS_ZLIB;
+			ctx->compress_level = BTRFS_ZLIB_DEFAULT_LEVEL;
+			/*
+			 * param->string contains uninitialized data since
+			 * for these options we don't expect any
+			 * parameter.
+			 */
+			if (opt != Opt_compress &&
+			    opt != Opt_compress_force)
+				ctx->compress_level =
+				  btrfs_compress_str2level(
+						BTRFS_COMPRESS_ZLIB,
+						param->string + 4);
+			btrfs_set_opt(ctx->mount_opt, COMPRESS);
+			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
+			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
+			ctx->no_compress = false;
+		} else if (strncmp(param->string, "lzo", 3) == 0) {
+			compress_type = "lzo";
+			ctx->compress_type = BTRFS_COMPRESS_LZO;
+			/* btrfs does not exposes lzo compression levels */
+			ctx->compress_level = 0;
+			btrfs_set_opt(ctx->mount_opt, COMPRESS);
+			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
+			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
+			ctx->no_compress = false;
+		} else if (strncmp(param->string, "zstd", 4) == 0) {
+			compress_type = "zstd";
+			ctx->compress_type = BTRFS_COMPRESS_ZSTD;
+			ctx->compress_level =
+				btrfs_compress_str2level(
+						 BTRFS_COMPRESS_ZSTD,
+						 param->string + 4);
+			btrfs_set_opt(ctx->mount_opt, COMPRESS);
+			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
+			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
+			ctx->no_compress = false;
+		} else if (strncmp(param->string, "no", 2) == 0) {
+			compress_type = "no";
+			ctx->compress_level = 0;
+			btrfs_clear_opt(ctx->mount_opt, COMPRESS);
+			btrfs_clear_opt(ctx->mount_opt, FORCE_COMPRESS);
+			compress_force = false;
+			ctx->no_compress = true;
+		} else {
+			return invalf(fc, "Invalid compression option: %s",
+								param->string);
+		}
+
+		if (compress_force) {
+			btrfs_set_opt(ctx->mount_opt, FORCE_COMPRESS);
+		} else {
+			/*
+			 * If we reconfigure from compress-force=xxx to
+			 * compress=xxx, we need clear FORCE_COMPRESS
+			 * flag, otherwise, there is no way for users
+			 * to disable forcible compression separately.
+			 */
+			btrfs_clear_opt(ctx->mount_opt, FORCE_COMPRESS);
+		}
+		break;
+	case Opt_degraded:
+		btrfs_set_opt(ctx->mount_opt, DEGRADED);
+		break;
+	case Opt_device:
+		devs = krealloc(ctx->devices,
+				sizeof(char *) * (ctx->nr_devices + 1),
+				GFP_KERNEL);
+		if (!devs)
+			return -ENOMEM;
+		devs[ctx->nr_devices] = param->string;
+		param->string = NULL;
+		ctx->devices = devs;
+		ctx->nr_devices++;
+		break;
+	case Opt_datacow:
+		if (result.negated) {
+			btrfs_clear_opt(ctx->mount_opt, COMPRESS);
+			btrfs_clear_opt(ctx->mount_opt, FORCE_COMPRESS);
+			btrfs_set_opt(ctx->mount_opt, NODATACOW);
+			btrfs_set_opt(ctx->mount_opt, NODATASUM);
+		} else {
+			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
+		}
+		break;
+	case Opt_datasum:
+		if (result.negated) {
+			btrfs_set_opt(ctx->mount_opt, NODATASUM);
+		} else {
+			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
+			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
+		}
+		break;
+	case Opt_defrag:
+		if (result.negated)
+			btrfs_clear_opt(ctx->mount_opt, AUTO_DEFRAG);
+		else
+			btrfs_set_opt(ctx->mount_opt, AUTO_DEFRAG);
+		break;
+	case Opt_discard:
+		if (result.negated) {
+			btrfs_clear_opt(ctx->mount_opt, DISCARD_SYNC);
+			btrfs_clear_opt(ctx->mount_opt, DISCARD_ASYNC);
+		} else {
+			btrfs_clear_opt(ctx->mount_opt, DISCARD_ASYNC);
+			btrfs_set_opt(ctx->mount_opt, DISCARD_SYNC);
+		}
+		break;
+	case Opt_discard_mode:
+		if (strcmp(param->string, "sync") == 0) {
+			btrfs_clear_opt(ctx->mount_opt, DISCARD_ASYNC);
+			btrfs_set_opt(ctx->mount_opt, DISCARD_SYNC);
+		} else if (strcmp(param->string, "async") == 0) {
+			btrfs_clear_opt(ctx->mount_opt, DISCARD_SYNC);
+			btrfs_set_opt(ctx->mount_opt, DISCARD_ASYNC);
+		} else {
+			return invalf(fc, "Invalid discard mode: %s",
+								param->string);
+		}
+		break;
+	case Opt_enospc_debug:
+		if (result.negated)
+			btrfs_clear_opt(ctx->mount_opt, ENOSPC_DEBUG);
+		else
+			btrfs_set_opt(ctx->mount_opt, ENOSPC_DEBUG);
+		break;
+	case Opt_fatal_errors:
+		if (strcmp(param->string, "panic") == 0)
+			btrfs_set_opt(ctx->mount_opt, PANIC_ON_FATAL_ERROR);
+		else if (strcmp(param->string, "bug") == 0)
+			btrfs_clear_opt(ctx->mount_opt, PANIC_ON_FATAL_ERROR);
+		else
+			return invalf(fc, "Invalid fatal_errors option: %s",
+								param->string);
+		break;
+	case Opt_flushoncommit:
+		if (result.negated)
+			btrfs_clear_opt(ctx->mount_opt, FLUSHONCOMMIT);
+		else
+			btrfs_set_opt(ctx->mount_opt, FLUSHONCOMMIT);
+		break;
+#ifdef CONFIG_BTRFS_DEBUG
+	case Opt_fragment:
+		if (strcmp(param->string, "all") == 0) {
+			btrfs_set_opt(ctx->mount_opt, FRAGMENT_DATA);
+			btrfs_set_opt(ctx->mount_opt, FRAGMENT_METADATA);
+		} else if (strcmp(param->string, "metadata") == 0) {
+			btrfs_set_opt(ctx->mount_opt, FRAGMENT_METADATA);
+		} else if (strcmp(param->string, "data") == 0) {
+			btrfs_set_opt(ctx->mount_opt, FRAGMENT_DATA);
+		} else {
+			return invalf(fc, "Invalid fragment option: %s",
+					param->string);
+		}
+		break;
+#endif
+#ifdef CONFIG_BTRFS_FS_REF_VERIFY
+	case Opt_ref_verify:
+		btrfs_set_opt(ctx->mount_opt, REF_VERIFY);
+		break;
+#endif
+	case Opt_inode_cache:
+		/* handled in btrfs_apply_configuration */
+		break;
+	case Opt_max_inline:
+		ctx->max_inline = memparse(param->string, NULL);
+		break;
+	case Opt_norecovery:
+	case Opt_nologreplay:
+		warnf(fc, "'%s' is deprecated, use 'rescue=nologreplay' instead",
+				opt == Opt_norecovery ? "norecovery"
+							: "nologreplay");
+		btrfs_set_opt(ctx->mount_opt, NOLOGREPLAY);
+		break;
+	case Opt_ratio:
+		ctx->metadata_ratio = result.uint_32;
+		break;
+	case Opt_rescue:
+		if (strcmp(param->string, "usebackuproot") == 0) {
+			btrfs_set_opt(ctx->mount_opt, USEBACKUPROOT);
+		} else if (strcmp(param->string, "nologreplay") == 0) {
+			btrfs_set_opt(ctx->mount_opt, NOLOGREPLAY);
+		} else {
+			return invalf(fc, "unrecognized rescue option '%s'",
+					param->string);
+		}
+		break;
+	case Opt_skip_balance:
+		btrfs_set_opt(ctx->mount_opt, SKIP_BALANCE);
+		break;
+	case Opt_rescan_uuid_tree:
+		btrfs_set_opt(ctx->mount_opt, RESCAN_UUID_TREE);
+		break;
+	case Opt_space_cache:
+		if (result.negated) {
+			if (btrfs_test_opt(ctx, SPACE_CACHE))
+				btrfs_clear_opt(ctx->mount_opt, SPACE_CACHE);
+			if (btrfs_test_opt(ctx, FREE_SPACE_TREE))
+				btrfs_clear_opt(ctx->mount_opt, FREE_SPACE_TREE);
+			ctx->nospace_cache = true;
+		} else {
+			btrfs_clear_opt(ctx->mount_opt, FREE_SPACE_TREE);
+			btrfs_set_opt(ctx->mount_opt, SPACE_CACHE);
+			ctx->nospace_cache = false;
+		}
+		break;
+	case Opt_space_cache_version:
+		ctx->nospace_cache = false;
+		if (strcmp(param->string, "v1") == 0) {
+			btrfs_clear_opt(ctx->mount_opt, FREE_SPACE_TREE);
+			btrfs_set_opt(ctx->mount_opt, SPACE_CACHE);
+		} else if (strcmp(param->string, "v2") == 0) {
+			btrfs_clear_opt(ctx->mount_opt, SPACE_CACHE);
+			btrfs_set_opt(ctx->mount_opt, FREE_SPACE_TREE);
+		} else {
+			return invalf(fc, "Invalid space_cache version: %s",
+								param->string);
+		}
+		break;
+	case Opt_ssd:
+		if (result.negated) {
+			btrfs_set_opt(ctx->mount_opt, NOSSD);
+			btrfs_clear_opt(ctx->mount_opt, SSD);
+			btrfs_clear_opt(ctx->mount_opt, SSD_SPREAD);
+		} else {
+			btrfs_clear_opt(ctx->mount_opt, NOSSD);
+			btrfs_set_opt(ctx->mount_opt, SSD);
+		}
+		break;
+	case Opt_ssd_spread:
+		if (result.negated) {
+			btrfs_clear_opt(ctx->mount_opt, SSD_SPREAD);
+		} else {
+			btrfs_set_opt(ctx->mount_opt, SSD);
+			btrfs_set_opt(ctx->mount_opt, SSD_SPREAD);
+			btrfs_clear_opt(ctx->mount_opt, NOSSD);
+		}
+		break;
+	case Opt_subvol:
+		kfree(ctx->subvol_name);
+		ctx->subvol_name = param->string;
+		param->string = NULL;
+		break;
+	case Opt_subvolid:
+		ctx->subvolid = result.uint_64;
+
+		/* we want the original fs_tree */
+		if (ctx->subvolid == 0)
+			ctx->subvolid = BTRFS_FS_TREE_OBJECTID;
+		break;
+	case Opt_thread_pool:
+		if (result.uint_32 == 0)
+			return invalf(fc, "Invalid thread_pool value: 0");
+
+		ctx->thread_pool_size = result.uint_32;
+		break;
+	case Opt_treelog:
+		if (result.negated)
+			btrfs_set_opt(ctx->mount_opt, NOTREELOG);
+		else
+			btrfs_clear_opt(ctx->mount_opt, NOTREELOG);
+		break;
+#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
+	case Opt_check_integrity_including_extent_data:
+		btrfs_set_opt(ctx->mount_opt,
+			      CHECK_INTEGRITY_INCLUDING_EXTENT_DATA);
+		btrfs_set_opt(ctx->mount_opt, CHECK_INTEGRITY);
+		break;
+	case Opt_check_integrity:
+		btrfs_set_opt(ctx->mount_opt, CHECK_INTEGRITY);
+		break;
+	case Opt_check_integrity_print_mask:
+		ctx->check_integrity_print_mask = result.uint_32;
+		break;
+#else
+	case Opt_check_integrity_including_extent_data:
+	case Opt_check_integrity:
+	case Opt_check_integrity_print_mask:
+		return invalf(fc, "support for check_integrity* not compiled in!");
+#endif
+	case Opt_user_subvol_rm_allowed:
+		btrfs_set_opt(ctx->mount_opt, USER_SUBVOL_RM_ALLOWED);
+		break;
+	case Opt_recovery:
+		fallthrough;
+	case Opt_usebackuproot:
+		warnf(fc, "'%s' is deprecated, use 'rescue=usebackuproot' instead",
+			opt == Opt_recovery ? "recovery" :
+			"usebackuproot");
+		btrfs_set_opt(ctx->mount_opt, USEBACKUPROOT);
+		break;
+	default:
+		return invalf(fc, "Invalid mount option: %s", param->key);
+	}
+
+	return 0;
+}
+
 /*
  * Parse mount options that are required early in the mount process.
  *
@@ -1400,6 +1788,226 @@ static int btrfs_fill_super(struct super_block *sb,
 	return err;
 }
 
+int btrfs_apply_configuration(struct fs_context *fc,
+				struct super_block *sb)
+{
+	struct btrfs_fs_context *ctx = fc->fs_private;
+	struct btrfs_fs_info *info = sb->s_fs_info;
+
+#ifdef CONFIG_BTRFS_FS_POSIX_ACL
+	if (!(fc->sb_flags & SB_POSIXACL))
+		sb->s_flags &= ~SB_POSIXACL;
+	else
+		sb->s_flags |= SB_POSIXACL;
+#endif
+
+	if (btrfs_test_exp_opt(ctx, NOBARRIER))
+		btrfs_info(info, "turning %s barriers",
+				btrfs_opt_map[Opt_barrier].enabled ? "on" : "off");
+
+	if (btrfs_test_exp_opt(ctx, CLEAR_CACHE))
+		btrfs_info(info, "force clearing of disk cache");
+
+	if (ctx->commit_interval == 0) {
+		btrfs_info(info, "using default commit interval %us",
+			   BTRFS_DEFAULT_COMMIT_INTERVAL);
+		ctx->commit_interval = BTRFS_DEFAULT_COMMIT_INTERVAL;
+	} else if (ctx->commit_interval > 300) {
+		btrfs_warn(info, "excessive commit interval %d",
+					ctx->commit_interval);
+	}
+	info->commit_interval = ctx->commit_interval;
+
+	if (btrfs_test_opt(ctx, COMPRESS) || ctx->no_compress) {
+		btrfs_info(info, "%s %s compression, level %d",
+				btrfs_test_opt(ctx, FORCE_COMPRESS) ? "force" : "use",
+				ctx->no_compress ? "no"
+				: btrfs_compress_type2str(ctx->compress_type),
+				ctx->compress_level);
+
+		if (ctx->compress_type == BTRFS_COMPRESS_LZO)
+			btrfs_set_fs_incompat(info, COMPRESS_LZO);
+		else if (ctx->compress_type == BTRFS_COMPRESS_ZSTD)
+			btrfs_set_fs_incompat(info, COMPRESS_ZSTD);
+	}
+
+	if (btrfs_test_exp_opt(ctx, DEGRADED))
+		btrfs_info(info, "allowing degraded mounts");
+
+	if (btrfs_test_exp_opt(ctx, NODATACOW)) {
+		if (btrfs_opt_map[Opt_datacow].enabled) {
+			btrfs_info(info, "setting datacow");
+		} else {
+			if (!btrfs_test_opt(ctx, COMPRESS) ||
+					!btrfs_test_opt(ctx, FORCE_COMPRESS)) {
+				btrfs_info(info, "setting nodatacow, compression disabled");
+			} else {
+				btrfs_info(info, "setting nodatacow");
+			}
+		}
+	}
+
+	if (btrfs_test_exp_opt(ctx, NODATASUM)) {
+		if (!btrfs_opt_map[Opt_datasum].enabled) {
+			btrfs_info(info, "setting nodatasum");
+		} else {
+			if (btrfs_test_opt(ctx, NODATASUM)) {
+				if (btrfs_test_opt(ctx, NODATACOW))
+					btrfs_info(info, "setting datasum, datacow enabled");
+				else
+					btrfs_info(info, "setting datasum");
+			}
+		}
+	}
+
+	if (btrfs_test_exp_opt(ctx, AUTO_DEFRAG))
+		btrfs_info(info, "%s auto defrag",
+				btrfs_opt_map[Opt_barrier].enabled ? "enabling"
+				: "disabling");
+
+	if (btrfs_test_opt(ctx, DISCARD_ASYNC)) {
+		btrfs_info(info, "turning on async discard");
+	} else if (btrfs_test_exp_opt(ctx, DISCARD_SYNC)) {
+		if (!btrfs_opt_map[Opt_discard].enabled) {
+			btrfs_info(info, "turning off discard");
+			btrfs_info(info, "turning off async discard");
+		} else {
+			btrfs_info(info, "turning on sync discard");
+		}
+	}
+
+	if (btrfs_test_exp_opt(ctx, FLUSHONCOMMIT))
+		btrfs_info(info, "turning %s flush-on-commit",
+				btrfs_opt_map[Opt_flushoncommit].enabled ? "on" : "off");
+
+#ifdef CONFIG_BTRFS_DEBUG
+	if (btrfs_test_opt(ctx, FRAGMENT_DATA) && btrfs_test_opt(ctx, FRAGMENT_METADATA))
+		btrfs_info(info, "fragmenting all space");
+	else if (btrfs_test_opt(ctx, FRAGMENT_METADATA))
+		btrfs_info(info, "fragmenting metadata");
+	else if (btrfs_test_opt(ctx, FRAGMENT_DATA))
+		btrfs_info(info, "fragmenting data");
+#endif
+
+#ifdef CONFIG_BTRFS_FS_REF_VERIFY
+       if (btrfs_test_exp_opt(ctx, REF_VERIFY))
+               btrfs_info(info, "doing ref verification");
+#endif
+
+	if (btrfs_test_exp_opt(ctx, INODE_MAP_CACHE)) {
+		if (btrfs_opt_map[Opt_inode_cache].enabled) {
+		       btrfs_clear_pending_and_info(info, INODE_MAP_CACHE,
+				       "disabling inode map caching");
+		} else {
+			btrfs_info(info,
+				"the 'inode_cache' option is deprecated and will have no effect from 5.11");
+			btrfs_set_pending_and_info(info, INODE_MAP_CACHE,
+				       "enabling inode map caching");
+		}
+	}
+
+	if (ctx->max_inline) {
+		ctx->max_inline = min_t(u64, ctx->max_inline, info->sectorsize);
+		if (ctx->max_inline != info->max_inline)
+			btrfs_info(info, "max_inline at %llu", ctx->max_inline);
+		info->max_inline = ctx->max_inline;
+	}
+
+       if (btrfs_test_exp_opt(ctx, NOLOGREPLAY))
+               btrfs_info(info, "disabling log replay at mount time");
+
+	info->metadata_ratio = ctx->metadata_ratio;
+	if (ctx->metadata_ratio)
+		btrfs_info(info, "Metadata ratio %u", ctx->metadata_ratio);
+
+	if (btrfs_test_opt(ctx, USEBACKUPROOT))
+		btrfs_info(info, "trying to use backup root at mount time");
+
+	/* set a default space_cache value if none was specified */
+	if (!ctx->nospace_cache && !btrfs_test_opt(ctx, SPACE_CACHE) &&
+			!btrfs_test_opt(ctx, FREE_SPACE_TREE)) {
+		if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
+			btrfs_set_opt(ctx->mount_opt, FREE_SPACE_TREE);
+		else
+			btrfs_set_opt(ctx->mount_opt, SPACE_CACHE);
+	}
+
+	if (ctx->nospace_cache) {
+		if (btrfs_test_opt(ctx, SPACE_CACHE))
+			btrfs_info(info, "disabling disk space caching");
+		if (btrfs_test_opt(ctx, FREE_SPACE_TREE))
+			btrfs_info(info, "disabling free space tree");
+	} else if (btrfs_test_opt(ctx, SPACE_CACHE))  {
+		btrfs_info(info, "enabling disk space caching");
+	} else if (btrfs_test_opt(ctx, FREE_SPACE_TREE)) {
+		btrfs_info(info, "enabling free space tree");
+	}
+
+	/*
+	 * When the free space tree is enabled:
+	 * -o nospace_cache, -o space_cache=v1: error
+	 * no options, -o space_cache=v2: keep using the free space tree
+	 * -o clear_cache, -o clear_cache,space_cache=v2: clear and recreate the free space tree
+	 * -o clear_cache,nospace_cache: clear the free space tree
+	 * -o clear_cache,space_cache=v1: clear the free space tree, enable the free space cache
+	 */
+	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE)) {
+		bool opt_clear = btrfs_test_opt(ctx, CLEAR_CACHE);
+		bool opt_cache_v1 = btrfs_test_opt(ctx, SPACE_CACHE);
+		bool no_space_cache = ctx->nospace_cache;
+
+		if ((no_space_cache && !opt_clear) || (opt_cache_v1 && !opt_clear)) {
+			btrfs_err(info, "cannot disable free space tree XX");
+			return -EINVAL;
+		}
+	}
+
+	if (btrfs_test_exp_opt(ctx, SSD_SPREAD)) {
+		if (!btrfs_opt_map[Opt_ssd_spread].enabled) {
+			btrfs_info(info, "not using spread ssd allocation scheme");
+		} else {
+			btrfs_info(info, "enabling ssd optimizations");
+			btrfs_info(info, "using spread ssd allocation scheme");
+		}
+	}
+
+	if (btrfs_test_exp_opt(ctx, SSD)) {
+		if (!btrfs_opt_map[Opt_ssd].enabled) {
+			btrfs_info(info, "not using ssd optimizations");
+			btrfs_info(info, "not using spread ssd allocation scheme");
+		} else {
+			btrfs_info(info, "enabling ssd optimizations");
+		}
+	}
+
+	if (ctx->thread_pool_size)
+		info->thread_pool_size = ctx->thread_pool_size;
+
+	if (btrfs_test_exp_opt(ctx, NOTREELOG))
+		btrfs_info(info, "%s tree log",
+				btrfs_opt_map[Opt_notreelog].enabled ? "enabling"
+				: "disabling");
+
+#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
+       if (btrfs_test_exp_opt(ctx, CHECK_INTEGRITY_INCLUDING_EXTENT_DATA))
+               btrfs_info(info, "disabling log replay at mount time");
+       else if (btrfs_test_exp_opt(ctx, CHECK_INTEGRITY))
+               btrfs_info(info, "enabling check integrity");
+       if (ctx->check_integrity_print_mask != info->check_integrity_print_mask) {
+               info->check_integrity_print_mask = ctx->check_integrity_print_mask;
+               btrfs_info(info, "check_integrity_print_mask 0x%x",
+                  info->check_integrity_print_mask);
+       }
+#endif
+
+	info->compress_type = ctx->compress_type;
+	info->compress_level = ctx->compress_level;
+	info->pending_changes = ctx->pending_changes;
+	info->mount_opt = ctx->mount_opt;
+
+	return 0;
+}
+
 int btrfs_sync_fs(struct super_block *sb, int wait)
 {
 	struct btrfs_trans_handle *trans;
@@ -2349,6 +2957,7 @@ static void btrfs_fc_free(struct fs_context *fc)
 
 static const struct fs_context_operations btrfs_context_ops = {
 	.free = btrfs_fc_free,
+	.parse_param = btrfs_fc_parse_param,
 };
 
 static int btrfs_init_fs_context(struct fs_context *fc)
-- 
2.28.0

