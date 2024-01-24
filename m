Return-Path: <linux-btrfs+bounces-1722-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3332583B019
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBA59B2D7D8
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C271292E5;
	Wed, 24 Jan 2024 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="0B+UcI+G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67E581AC7
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116803; cv=none; b=Q+GR6kFAZcgcvdV4mLzvCkFQbsQzTjhK5D6chvK6Irhuo3CFR/O5RMx3gXGyfKJl3a8fn9w5akFHn3o/n1MKfCw330Uldj6lmBguIL7rw6j0N2ISlrH1HFiWZHSBJ6SP6CjVSrnIjJAzYXU90kgAMgC7f17XDbTE9T1XJj4G+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116803; c=relaxed/simple;
	bh=ojpa3cxqYiII3mUVJLkF3OlQFxqXq8KkV0W4+PnJhQ0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F74fTVLLeYf/Fv0OeNTq+Es8qY67e3g6kS35yupE0V9isQBR6Cnx7K7H9mBTFQlrJ1T2paBGGeIOPBxSJ0sq1daQvZj52mdxOMW2lSvfhTd9kekLzN5OwnJMScvJT9wIrJOHKqRD6aejAj5R1Dt2Vyq/KG9zr5YtI0+DHHj7UbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=0B+UcI+G; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc21d7a7042so5011641276.2
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116801; x=1706721601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WtC6Aldok1fR5PG9ch6LHkGpBRc+MixBcB6xgNDFOk=;
        b=0B+UcI+GB5PGDiAbhiDw3HjHeTgXjWmyqzAzmEqrgAqsBOSz7cLr572KJQYA3PwCck
         GGvCxOftRJBud6+HUN5K9v6pktkJq7tj4AwjNLJkrK3VG1ac858wF+XWlvJfUoMYrBGL
         CNV1+KY31N+mh2Rqz658qXHXuCYJWjuzoaBaqnx+N6kic1tDbauusg4puBkESQUImz4+
         vndSBpdmo0RjGK06rQC4rbgE/EFsYOIVfW8Re+1kQ/Rf5W7NcBaZ715BT3dAoc1HlnTL
         /gg3N4IiMsvSBxX4Z+3D5NVcio0N9Yxmj9eMSSkRwXj8O4TcNYTUAMiVWpzNOL0jjzBX
         xIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116801; x=1706721601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WtC6Aldok1fR5PG9ch6LHkGpBRc+MixBcB6xgNDFOk=;
        b=qrHAU+aFU96k3ZY7wFBnryrlgg0RKDNvsO+Tsh+9sQG9p90U0Lnn28nNxTwD6pRgG6
         Z8rRNY/mJ+PPpxcemc4TsqbeZWo/Gc0EcpgGkkCeLoiFEDZZ4lLZoZdkUdihsyYpniHa
         k+Fo2XfoLb51BRdYsXf2g8zKEUTFiBOKsNEgquYiFjGtksZB3DvLUhDh+ju6ZIpIt/Ak
         e/pUsCvslPRi9MqAaCkM8DFRBMmYqbYnhuk216uPjWtHMr6mgnXJKhvidDZ2owdg15Hc
         J2cMISbZQiOM26lzI7YiZP2Q+IyEVfklF8TP19K7JQPCBsQ3rt8RRJpUUOhwQG/XNLsJ
         qOng==
X-Gm-Message-State: AOJu0YxxpYaOIdFwPQ73dVkI8xEwvu7suNiFPKHgPGtAEZUDYuiQ52En
	0c2vWZyhACAiruTSxtAYoIB71WUKeHGsfA2Waz6XphJJGsDAjl03pKoQJiLl6co3vEAE/s+lbL5
	+
X-Google-Smtp-Source: AGHT+IFJfk44bKxhnWRwngpWLsYV6Gm0LyOBtFlNuZih/B7Any72t8e4zr7XKckADcBvENmZAH9SaA==
X-Received: by 2002:a05:6902:548:b0:dc2:1a2b:bc1 with SMTP id z8-20020a056902054800b00dc21a2b0bc1mr971480ybs.19.1706116800676;
        Wed, 24 Jan 2024 09:20:00 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u11-20020a25840b000000b00dc218e084fbsm2842041ybk.28.2024.01.24.09.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:20:00 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 40/52] btrfs: add test_dummy_encryption support
Date: Wed, 24 Jan 2024 12:19:02 -0500
Message-ID: <77449ee5a882db2945429946c74ea7e796122328.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to enable more thorough testing of fscrypt enable the
test_dummy_encryption mount option.  This is used by fscrypt users to
easily enable fscrypt on the file system for testing without needing to
do the key setup and everything.

The only deviation from other file systems we make is we only support
the fsparam_flag version of this mount option, as it defaults to v2.  We
don't want to have to bother with rejecting v1 related mount options.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c |  1 +
 fs/btrfs/fs.h      |  3 +++
 fs/btrfs/fscrypt.c |  6 +++++
 fs/btrfs/super.c   | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 51c6127508af..70e33df8f975 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1290,6 +1290,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	kfree(fs_info->super_copy);
 	kfree(fs_info->super_for_commit);
 	kfree(fs_info->subpage_info);
+	fscrypt_free_dummy_policy(&fs_info->dummy_enc_policy);
 	kvfree(fs_info);
 }
 
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 1340e71d026c..74752204f3ab 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -7,6 +7,7 @@
 #include <linux/fs.h>
 #include <linux/btrfs_tree.h>
 #include <linux/sizes.h>
+#include <linux/fscrypt.h>
 #include "extent-io-tree.h"
 #include "extent_map.h"
 #include "async-thread.h"
@@ -189,6 +190,7 @@ enum {
 	BTRFS_MOUNT_IGNOREDATACSUMS		= (1UL << 28),
 	BTRFS_MOUNT_NODISCARD			= (1UL << 29),
 	BTRFS_MOUNT_NOSPACECACHE		= (1UL << 30),
+	BTRFS_MOUNT_TEST_DUMMY_ENCRYPTION	= (1UL << 31),
 };
 
 /*
@@ -828,6 +830,7 @@ struct btrfs_fs_info {
 	spinlock_t eb_leak_lock;
 	struct list_head allocated_ebs;
 #endif
+	struct fscrypt_dummy_policy dummy_enc_policy;
 };
 
 static inline u64 btrfs_get_fs_generation(const struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
index 560243d732e7..6a6ecf4a49e2 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -243,6 +243,11 @@ static blk_status_t btrfs_process_encrypted_bio(struct bio *orig_bio,
 	return btrfs_csum_one_bio(bbio, enc_bio);
 }
 
+static const union fscrypt_policy *btrfs_get_dummy_policy(struct super_block *sb)
+{
+	return btrfs_sb(sb)->dummy_enc_policy.policy;
+}
+
 int btrfs_fscrypt_load_extent_info(struct btrfs_inode *inode,
 				   struct extent_map *em,
 				   struct btrfs_fscrypt_ctx *ctx)
@@ -367,4 +372,5 @@ const struct fscrypt_operations btrfs_fscrypt_ops = {
 	.empty_dir = btrfs_fscrypt_empty_dir,
 	.get_devices = btrfs_fscrypt_get_devices,
 	.process_bio = btrfs_process_encrypted_bio,
+	.get_dummy_policy = btrfs_get_dummy_policy,
 };
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 28fbe366717e..861fbf48456a 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -88,6 +88,7 @@ struct btrfs_fs_context {
 	unsigned long compress_type:4;
 	unsigned int compress_level;
 	refcount_t refs;
+	struct fscrypt_dummy_policy dummy_enc_policy;
 };
 
 enum {
@@ -122,6 +123,7 @@ enum {
 	Opt_thread_pool,
 	Opt_treelog,
 	Opt_user_subvol_rm_allowed,
+	Opt_test_dummy_encryption,
 
 	/* Rescue options */
 	Opt_rescue,
@@ -253,6 +255,10 @@ static const struct fs_parameter_spec btrfs_fs_parameters[] = {
 	fsparam_flag_no("enospc_debug", Opt_enospc_debug),
 #ifdef CONFIG_BTRFS_DEBUG
 	fsparam_enum("fragment", Opt_fragment, btrfs_parameter_fragment),
+
+	fsparam_flag("test_dummy_encryption", Opt_test_dummy_encryption),
+	fsparam_string("test_dummy_encryption", Opt_test_dummy_encryption),
+
 #endif
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	fsparam_flag("ref_verify", Opt_ref_verify),
@@ -271,6 +277,7 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	struct btrfs_fs_context *ctx = fc->fs_private;
 	struct fs_parse_result result;
 	int opt;
+	int ret;
 
 	opt = fs_parse(fc, btrfs_fs_parameters, param, &result);
 	if (opt < 0)
@@ -598,6 +605,22 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		}
 		break;
+	case Opt_test_dummy_encryption:
+		/*
+		 * We only support v2, so reject any v1 policies.
+		 */
+		if (param->type == fs_value_is_string && *param->string &&
+		    !strcmp(param->string, "v1")) {
+			btrfs_info(NULL, "v1 encryption isn't supported");
+			return -EINVAL;
+		}
+
+		btrfs_set_opt(ctx->mount_opt, TEST_DUMMY_ENCRYPTION);
+		ret = fscrypt_parse_test_dummy_encryption(param,
+							  &ctx->dummy_enc_policy);
+		if (ret)
+			return ret;
+		break;
 #endif
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	case Opt_ref_verify:
@@ -945,6 +968,9 @@ static int btrfs_fill_super(struct super_block *sb,
 		return err;
 	}
 
+	if (fscrypt_is_dummy_policy_set(&fs_info->dummy_enc_policy))
+		btrfs_set_fs_incompat(fs_info, ENCRYPT);
+
 	inode = btrfs_iget(sb, BTRFS_FIRST_FREE_OBJECTID, fs_info->fs_root);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
@@ -1101,6 +1127,9 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 #endif
 	if (btrfs_test_opt(info, REF_VERIFY))
 		seq_puts(seq, ",ref_verify");
+	if (btrfs_test_opt(info, TEST_DUMMY_ENCRYPTION))
+		fscrypt_show_test_dummy_encryption(seq, ',', dentry->d_sb);
+
 	seq_printf(seq, ",subvolid=%llu",
 		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
 	subvol_name = btrfs_get_subvol_name_from_objectid(info,
@@ -1368,6 +1397,18 @@ static void btrfs_ctx_to_info(struct btrfs_fs_info *fs_info, struct btrfs_fs_con
 	fs_info->mount_opt = ctx->mount_opt;
 	fs_info->compress_type = ctx->compress_type;
 	fs_info->compress_level = ctx->compress_level;
+
+	/*
+	 * If there's nothing set, or if the fs_info already has one set, don't
+	 * do anything.  If the fs_info is set we'll free the dummy one when we
+	 * free the ctx.
+	 */
+	if (!fscrypt_is_dummy_policy_set(&ctx->dummy_enc_policy) ||
+	    fscrypt_is_dummy_policy_set(&fs_info->dummy_enc_policy))
+		return;
+
+	fs_info->dummy_enc_policy = ctx->dummy_enc_policy;
+	memset(&ctx->dummy_enc_policy, 0, sizeof(ctx->dummy_enc_policy));
 }
 
 static void btrfs_info_to_ctx(struct btrfs_fs_info *fs_info, struct btrfs_fs_context *ctx)
@@ -1419,6 +1460,7 @@ static void btrfs_emit_options(struct btrfs_fs_info *info,
 	btrfs_info_if_set(info, old, USEBACKUPROOT, "trying to use backup root at mount time");
 	btrfs_info_if_set(info, old, IGNOREBADROOTS, "ignoring bad roots");
 	btrfs_info_if_set(info, old, IGNOREDATACSUMS, "ignoring data csums");
+	btrfs_info_if_set(info, old, TEST_DUMMY_ENCRYPTION, "test dummy encryption mode enabled");
 
 	btrfs_info_if_unset(info, old, NODATACOW, "setting datacow");
 	btrfs_info_if_unset(info, old, SSD, "not using ssd optimizations");
@@ -1448,6 +1490,23 @@ static void btrfs_emit_options(struct btrfs_fs_info *info,
 		btrfs_info(info, "max_inline set to %llu", info->max_inline);
 }
 
+static bool btrfs_check_test_dummy_encryption(struct fs_context *fc)
+{
+	struct btrfs_fs_context *ctx = fc->fs_private;
+	struct btrfs_fs_info *fs_info = btrfs_sb(fc->root->d_sb);
+
+	if (!fscrypt_is_dummy_policy_set(&ctx->dummy_enc_policy))
+		return true;
+
+	if (fscrypt_dummy_policies_equal(&fs_info->dummy_enc_policy,
+					 &ctx->dummy_enc_policy))
+		return true;
+
+	btrfs_warn(fs_info,
+		   "Can't set or change test_dummy_encryption on remount");
+	return false;
+}
+
 static int btrfs_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
@@ -1474,6 +1533,10 @@ static int btrfs_reconfigure(struct fs_context *fc)
 	    !btrfs_check_options(fs_info, &ctx->mount_opt, fc->sb_flags))
 		return -EINVAL;
 
+	if (!mount_reconfigure &&
+	    !btrfs_check_test_dummy_encryption(fc))
+		return -EINVAL;
+
 	ret = btrfs_check_features(fs_info, !(fc->sb_flags & SB_RDONLY));
 	if (ret < 0)
 		return ret;
@@ -2105,6 +2168,7 @@ static void btrfs_free_fs_context(struct fs_context *fc)
 		btrfs_free_fs_info(fs_info);
 
 	if (ctx && refcount_dec_and_test(&ctx->refs)) {
+		fscrypt_free_dummy_policy(&ctx->dummy_enc_policy);
 		kfree(ctx->subvol_name);
 		kfree(ctx);
 	}
-- 
2.43.0


