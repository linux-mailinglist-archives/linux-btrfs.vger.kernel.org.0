Return-Path: <linux-btrfs+bounces-302-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEE17F4E1F
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 18:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61530B2153E
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 17:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5297558AD8;
	Wed, 22 Nov 2023 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="scBMGcv8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE6B1A4
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:14 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5cc642e4c69so10174047b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700673493; x=1701278293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43K70ReJ/ZnydsIdQxXrWAnUohmuvWnf9VmLW+rwBi0=;
        b=scBMGcv8z0g1Ojys/AaTC0MVrRyzs/JECE7HdaTLwFSUgLeqVtwfBBvuX1EffmUCnt
         lFcTlDWUYJd481VPWHucr3TIuEU9qQLfH3Oz1To6FIdfwaKOIpaCSQNnJWKb2I8e3+CU
         2p3lBq5OtqmZHnFf9SM9+D0MRh0ZFt1vuItVuvVxqfDsY2wAq6Dy6dH2sE6mBSi6JNvG
         HoslEG2NWXS01xyO26vbDr9DfDDmdzgT1zMP3YhpS30H3ZamxcXySBrQcJL7k9HJJFro
         3DZQsyt4baRAbeJCWAYo+ucO6DXvUj/wXVWt5mCqXDg3ZPc2oDZPiy/9g4ZhRhbPIilI
         A3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673493; x=1701278293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43K70ReJ/ZnydsIdQxXrWAnUohmuvWnf9VmLW+rwBi0=;
        b=KJ4ayTNNzwN1cc4iU2GuQ0ESuiOKv3Z8GiJtFJPBt3RXtMNgFcaoLW9EfgDemvrfz3
         vPFiV2c0QKji6kqMHXCuU7RVa9BWyNVzBlFcS/beBeLnBwpgdKycfUIlLmyw3jZYnkMl
         eI6yo8UrHTaLOuRcalFuKoP9W2XppuQEeZknkXsjsomEVfLHeXku02zL8rUR/JecCAMa
         3iEF2o+sj2QFI/YV82whpBLv0mn6eREV5bDrcQhGaYzFsLeG9uipTs/UTOEAY3hDmquD
         TQBfbLxdNQb14ZkdbGhvZnoLT2NHvB5aufD/3RrS9ukUG74gruXjiEPMd6vBcddLRk8c
         DnVQ==
X-Gm-Message-State: AOJu0YxBdPWasL0Gn5TqeIHtBA4M4qhIbbTb6lCUMAPxM0WaATyMzM4Y
	cIWARxjyqiKKW3hR7m9CdF7BjRdFvp/laooP2/DzKGVX
X-Google-Smtp-Source: AGHT+IFGqAm+YtrZDu5zHWa4AOWXCIsKDqJIL1cCjsARQohQ6UEgcPJ/2xZIEJh8cWwfm1SKzbWbzw==
X-Received: by 2002:a0d:fc81:0:b0:59b:eb8:c38a with SMTP id m123-20020a0dfc81000000b0059b0eb8c38amr3041474ywf.30.1700673493022;
        Wed, 22 Nov 2023 09:18:13 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x77-20020a81a050000000b005a7ba08b2acsm3831712ywg.0.2023.11.22.09.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:18:12 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 09/19] btrfs: add parse_param callback for the new mount api
Date: Wed, 22 Nov 2023 12:17:45 -0500
Message-ID: <ed6a5b9bae38cc1c9e9c24f08e8b2e454340f4fd.1700673401.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700673401.git.josef@toxicpanda.com>
References: <cover.1700673401.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The parse_param callback handles one parameter at a time, take our
existing mount option parsing loop and adjust it to handle one parameter
at a time, and tie it into the fs_context_operations.

Create a btrfs_fs_context object that will store the various mount
properties, we'll house this in fc->fs_private.  This is necessary to
separate because remounting will use ->reconfigure, and we'll get a new
copy of the parsed parameters, so we can no longer directly mess with
the fs_info in this stage.

In the future we'll add this to the btrfs_fs_info and update the users
to use the new context object instead.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 382 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 382 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2366bcf7a23c..b1764efbc8f5 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -87,6 +87,19 @@ static void btrfs_put_super(struct super_block *sb)
 	close_ctree(fs_info);
 }
 
+/* Store the mount options related information. */
+struct btrfs_fs_context {
+	char *subvol_name;
+	u64 subvol_objectid;
+	u64 max_inline;
+	u32 commit_interval;
+	u32 metadata_ratio;
+	u32 thread_pool_size;
+	unsigned long mount_opt;
+	unsigned long compress_type:4;
+	unsigned int compress_level;
+};
+
 enum {
 	Opt_acl, Opt_noacl,
 	Opt_clear_cache,
@@ -351,6 +364,371 @@ static const struct fs_parameter_spec btrfs_fs_parameters[] __maybe_unused = {
 	{}
 };
 
+static int btrfs_parse_param(struct fs_context *fc,
+			     struct fs_parameter *param)
+{
+	struct btrfs_fs_context *ctx = fc->fs_private;
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, btrfs_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_degraded:
+		btrfs_set_opt(ctx->mount_opt, DEGRADED);
+		break;
+	case Opt_subvol_empty:
+		/*
+		 * This exists because we used to allow it on accident, so we're
+		 * keeping it to maintain ABI.  See 37becec95ac3 ("Btrfs: allow
+		 * empty subvol= again").
+		 */
+		break;
+	case Opt_subvol:
+		kfree(ctx->subvol_name);
+		ctx->subvol_name = kstrdup(param->string, GFP_KERNEL);
+		if (!ctx->subvol_name)
+			return -ENOMEM;
+		break;
+	case Opt_subvolid:
+		ctx->subvol_objectid = result.uint_64;
+
+		/* subvolid=0 means give me the original fs_tree. */
+		if (!ctx->subvol_objectid)
+			ctx->subvol_objectid = BTRFS_FS_TREE_OBJECTID;
+		break;
+	case Opt_device: {
+		struct btrfs_device *device;
+		blk_mode_t mode = sb_open_mode(fc->sb_flags);
+
+		mutex_lock(&uuid_mutex);
+		device = btrfs_scan_one_device(param->string, mode, false);
+		mutex_unlock(&uuid_mutex);
+		if (IS_ERR(device))
+			return PTR_ERR(device);
+		break;
+	}
+	case Opt_datasum:
+		if (result.negated) {
+			btrfs_set_opt(ctx->mount_opt, NODATASUM);
+		} else {
+			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
+			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
+		}
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
+	case Opt_compress_force:
+	case Opt_compress_force_type:
+		btrfs_set_opt(ctx->mount_opt, FORCE_COMPRESS);
+		fallthrough;
+	case Opt_compress:
+	case Opt_compress_type:
+		if (opt == Opt_compress || opt == Opt_compress_force) {
+			ctx->compress_type = BTRFS_COMPRESS_ZLIB;
+			ctx->compress_level = BTRFS_ZLIB_DEFAULT_LEVEL;
+			btrfs_set_opt(ctx->mount_opt, COMPRESS);
+			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
+			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
+		} else if (strncmp(param->string, "zlib", 4) == 0) {
+			ctx->compress_type = BTRFS_COMPRESS_ZLIB;
+			ctx->compress_level =
+				btrfs_compress_str2level(BTRFS_COMPRESS_ZLIB,
+							 param->string + 4);
+			btrfs_set_opt(ctx->mount_opt, COMPRESS);
+			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
+			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
+		} else if (strncmp(param->string, "lzo", 3) == 0) {
+			ctx->compress_type = BTRFS_COMPRESS_LZO;
+			ctx->compress_level = 0;
+			btrfs_set_opt(ctx->mount_opt, COMPRESS);
+			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
+			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
+		} else if (strncmp(param->string, "zstd", 4) == 0) {
+			ctx->compress_type = BTRFS_COMPRESS_ZSTD;
+			ctx->compress_level =
+				btrfs_compress_str2level(BTRFS_COMPRESS_ZSTD,
+							 param->string + 4);
+			btrfs_set_opt(ctx->mount_opt, COMPRESS);
+			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
+			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
+		} else if (strncmp(param->string, "no", 2) == 0) {
+			ctx->compress_level = 0;
+			ctx->compress_type = 0;
+			btrfs_clear_opt(ctx->mount_opt, COMPRESS);
+			btrfs_clear_opt(ctx->mount_opt, FORCE_COMPRESS);
+		} else {
+			btrfs_err(NULL, "unrecognized compression value %s",
+				  param->string);
+			return -EINVAL;
+		}
+		break;
+	case Opt_ssd:
+		if (result.negated) {
+			btrfs_set_opt(ctx->mount_opt, NOSSD);
+			btrfs_clear_opt(ctx->mount_opt, SSD);
+			btrfs_clear_opt(ctx->mount_opt, SSD_SPREAD);
+		} else {
+			btrfs_set_opt(ctx->mount_opt, SSD);
+			btrfs_clear_opt(ctx->mount_opt, NOSSD);
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
+	case Opt_barrier:
+		if (result.negated)
+			btrfs_set_opt(ctx->mount_opt, NOBARRIER);
+		else
+			btrfs_clear_opt(ctx->mount_opt, NOBARRIER);
+		break;
+	case Opt_thread_pool:
+		if (result.uint_32 == 0) {
+			btrfs_err(NULL, "invalid value 0 for thread_pool");
+			return -EINVAL;
+		}
+		ctx->thread_pool_size = result.uint_32;
+		break;
+	case Opt_max_inline:
+		ctx->max_inline = memparse(param->string, NULL);
+		break;
+	case Opt_acl:
+		if (result.negated) {
+			fc->sb_flags &= ~SB_POSIXACL;
+		} else {
+#ifdef CONFIG_BTRFS_FS_POSIX_ACL
+			fc->sb_flags |= SB_POSIXACL;
+#else
+			btrfs_err(NULL, "support for ACL not compiled in!");
+			ret = -EINVAL;
+			goto out;
+#endif
+		}
+		/*
+		 * VFS limits the ability to toggle ACL on and off via remount,
+		 * despite every file system allowing this.  This seems to be an
+		 * oversight since we all do, but it'll fail if we're
+		 * remounting.  So don't set the mask here, we'll check it in
+		 * btrfs_reconfigure and do the toggling ourselves.
+		 */
+		if (fc->purpose != FS_CONTEXT_FOR_RECONFIGURE)
+			fc->sb_flags_mask |= SB_POSIXACL;
+		break;
+	case Opt_treelog:
+		if (result.negated)
+			btrfs_set_opt(ctx->mount_opt, NOTREELOG);
+		else
+			btrfs_clear_opt(ctx->mount_opt, NOTREELOG);
+		break;
+	case Opt_recovery:
+		/*
+		 * -o recovery used to be an alias for usebackuproot, and then
+		 * norecovery was an alias for nologreplay, hence the different
+		 * behaviors for negated and not.
+		 */
+		if (result.negated) {
+			btrfs_warn(NULL,
+				   "'norecovery' is deprecated, use 'rescue=nologreplay' instead");
+			btrfs_set_opt(ctx->mount_opt, NOLOGREPLAY);
+		} else {
+			btrfs_warn(NULL,
+				   "'recovery' is deprecated, use 'rescue=usebackuproot' instead");
+			btrfs_set_opt(ctx->mount_opt, USEBACKUPROOT);
+		}
+		break;
+	case Opt_nologreplay:
+		btrfs_warn(NULL,
+			   "'nologreplay' is deprecated, use 'rescue=nologreplay' instead");
+		btrfs_set_opt(ctx->mount_opt, NOLOGREPLAY);
+		break;
+	case Opt_flushoncommit:
+		if (result.negated)
+			btrfs_clear_opt(ctx->mount_opt, FLUSHONCOMMIT);
+		else
+			btrfs_set_opt(ctx->mount_opt, FLUSHONCOMMIT);
+		break;
+	case Opt_ratio:
+		ctx->metadata_ratio = result.uint_32;
+		break;
+	case Opt_discard:
+		if (result.negated) {
+			btrfs_clear_opt(ctx->mount_opt, DISCARD_SYNC);
+			btrfs_clear_opt(ctx->mount_opt, DISCARD_ASYNC);
+			btrfs_set_opt(ctx->mount_opt, NODISCARD);
+		} else {
+			btrfs_set_opt(ctx->mount_opt, DISCARD_SYNC);
+			btrfs_clear_opt(ctx->mount_opt, DISCARD_ASYNC);
+		}
+		break;
+	case Opt_discard_mode:
+		switch (result.uint_32) {
+		case Opt_discard_sync:
+			btrfs_clear_opt(ctx->mount_opt, DISCARD_ASYNC);
+			btrfs_set_opt(ctx->mount_opt, DISCARD_SYNC);
+			break;
+		case Opt_discard_async:
+			btrfs_clear_opt(ctx->mount_opt, DISCARD_SYNC);
+			btrfs_set_opt(ctx->mount_opt, DISCARD_ASYNC);
+			break;
+		default:
+			btrfs_err(NULL, "unrecognized discard mode value %s",
+				  param->key);
+			return -EINVAL;
+		}
+		btrfs_clear_opt(ctx->mount_opt, NODISCARD);
+		break;
+	case Opt_space_cache:
+		if (result.negated) {
+			btrfs_set_opt(ctx->mount_opt, NOSPACECACHE);
+			btrfs_clear_opt(ctx->mount_opt, SPACE_CACHE);
+			btrfs_clear_opt(ctx->mount_opt, FREE_SPACE_TREE);
+		} else {
+			btrfs_clear_opt(ctx->mount_opt, FREE_SPACE_TREE);
+			btrfs_set_opt(ctx->mount_opt, SPACE_CACHE);
+		}
+		break;
+	case Opt_space_cache_version:
+		switch (result.uint_32) {
+		case Opt_space_cache_v1:
+			btrfs_set_opt(ctx->mount_opt, SPACE_CACHE);
+			btrfs_clear_opt(ctx->mount_opt, FREE_SPACE_TREE);
+			break;
+		case Opt_space_cache_v2:
+			btrfs_clear_opt(ctx->mount_opt, SPACE_CACHE);
+			btrfs_set_opt(ctx->mount_opt, FREE_SPACE_TREE);
+			break;
+		default:
+			btrfs_err(NULL, "unrecognized space_cache value %s",
+				  param->key);
+			return -EINVAL;
+		}
+		break;
+	case Opt_rescan_uuid_tree:
+		btrfs_set_opt(ctx->mount_opt, RESCAN_UUID_TREE);
+		break;
+	case Opt_inode_cache:
+		btrfs_warn(NULL,
+			   "the 'inode_cache' option is deprecated and has no effect since 5.11");
+		break;
+	case Opt_clear_cache:
+		btrfs_set_opt(ctx->mount_opt, CLEAR_CACHE);
+		break;
+	case Opt_user_subvol_rm_allowed:
+		btrfs_set_opt(ctx->mount_opt, USER_SUBVOL_RM_ALLOWED);
+		break;
+	case Opt_enospc_debug:
+		if (result.negated)
+			btrfs_clear_opt(ctx->mount_opt, ENOSPC_DEBUG);
+		else
+			btrfs_set_opt(ctx->mount_opt, ENOSPC_DEBUG);
+		break;
+	case Opt_defrag:
+		if (result.negated)
+			btrfs_clear_opt(ctx->mount_opt, AUTO_DEFRAG);
+		else
+			btrfs_set_opt(ctx->mount_opt, AUTO_DEFRAG);
+		break;
+	case Opt_usebackuproot:
+		btrfs_warn(NULL,
+			   "'usebackuproot' is deprecated, use 'rescue=usebackuproot' instead");
+		btrfs_set_opt(ctx->mount_opt, USEBACKUPROOT);
+		break;
+	case Opt_skip_balance:
+		btrfs_set_opt(ctx->mount_opt, SKIP_BALANCE);
+		break;
+	case Opt_fatal_errors:
+		switch (result.uint_32) {
+		case Opt_fatal_errors_panic:
+			btrfs_set_opt(ctx->mount_opt, PANIC_ON_FATAL_ERROR);
+			break;
+		case Opt_fatal_errors_bug:
+			btrfs_clear_opt(ctx->mount_opt, PANIC_ON_FATAL_ERROR);
+			break;
+		default:
+			btrfs_err(NULL, "unrecognized fatal_errors value %s",
+				  param->key);
+			return -EINVAL;
+		}
+		break;
+	case Opt_commit_interval:
+		ctx->commit_interval = result.uint_32;
+		if (!ctx->commit_interval)
+			ctx->commit_interval = BTRFS_DEFAULT_COMMIT_INTERVAL;
+		break;
+	case Opt_rescue:
+		switch (result.uint_32) {
+		case Opt_rescue_usebackuproot:
+			btrfs_set_opt(ctx->mount_opt, USEBACKUPROOT);
+			break;
+		case Opt_rescue_nologreplay:
+			btrfs_set_opt(ctx->mount_opt, NOLOGREPLAY);
+			break;
+		case Opt_rescue_ignorebadroots:
+			btrfs_set_opt(ctx->mount_opt, IGNOREBADROOTS);
+			break;
+		case Opt_rescue_ignoredatacsums:
+			btrfs_set_opt(ctx->mount_opt, IGNOREDATACSUMS);
+			break;
+		case Opt_rescue_parameter_all:
+			btrfs_set_opt(ctx->mount_opt, IGNOREDATACSUMS);
+			btrfs_set_opt(ctx->mount_opt, IGNOREBADROOTS);
+			btrfs_set_opt(ctx->mount_opt, NOLOGREPLAY);
+			break;
+		default:
+			btrfs_info(NULL, "unrecognized rescue option '%s'",
+				   param->key);
+			return -EINVAL;
+		}
+		break;
+#ifdef CONFIG_BTRFS_DEBUG
+	case Opt_fragment:
+		switch (result.uint_32) {
+		case Opt_fragment_parameter_all:
+			btrfs_set_opt(ctx->mount_opt, FRAGMENT_DATA);
+			btrfs_set_opt(ctx->mount_opt, FRAGMENT_METADATA);
+			break;
+		case Opt_fragment_parameter_metadata:
+			btrfs_set_opt(ctx->mount_opt, FRAGMENT_METADATA);
+			break;
+		case Opt_fragment_parameter_data:
+			btrfs_set_opt(ctx->mount_opt, FRAGMENT_DATA);
+			break;
+		default:
+			btrfs_info(NULL, "unrecognized fragment option '%s'",
+				   param->key);
+			return -EINVAL;
+		}
+		break;
+#endif
+#ifdef CONFIG_BTRFS_FS_REF_VERIFY
+	case Opt_ref_verify:
+		btrfs_set_opt(ctx->mount_opt, REF_VERIFY);
+		break;
+#endif
+	default:
+		btrfs_err(NULL, "unrecognized mount option '%s'", param->key);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static bool check_ro_option(struct btrfs_fs_info *fs_info, unsigned long opt,
 			    const char *opt_name)
 {
@@ -2272,6 +2650,10 @@ static void btrfs_kill_super(struct super_block *sb)
 	btrfs_free_fs_info(fs_info);
 }
 
+static const struct fs_context_operations btrfs_fs_context_ops __maybe_unused = {
+	.parse_param	= btrfs_parse_param,
+};
+
 static struct file_system_type btrfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "btrfs",
-- 
2.41.0


