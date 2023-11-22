Return-Path: <linux-btrfs+bounces-300-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9017F4E1C
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 18:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 359F9B21455
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 17:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F60B58ADB;
	Wed, 22 Nov 2023 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="pGMUb/8f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4271B3
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:13 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5cccd2d4c4dso5084717b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700673492; x=1701278292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fkA3lCitnD/iMODXrJglqig2YV4i0dKVL4SuP4eEJE=;
        b=pGMUb/8f1dFLx0DwMUBL6XXb3RZNArGon9FeGD1pttolDVLcu2RBcAiKbtq8PBCbLy
         QhsJyj6/rEv+ncpWmOlMs0oYB83ph8uOEIEfL38GrK/3EH1pg05CxZRTOJMxK/ZghPlO
         jGuB7EdYLpRZA93gStt7xtOuWLbWFg4E1ZD7fKOzb10bGaWF2KrXZ7FYMeAmHVeicOJv
         cs73jVInxg5+YOtTOSfUycQtxw5iB0UMWvASIQv4Nk1EGI7y1ucmVbszlTUXifsGWOUD
         2LQ7qKxeBP4G6DXdB2hUrED+FAYYCgcMtHjdy+59V+BPoqbvnw3fP3MdVV4xzuCXasbP
         lh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673492; x=1701278292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fkA3lCitnD/iMODXrJglqig2YV4i0dKVL4SuP4eEJE=;
        b=BGJcdU3zLBEOlDmoc26/9apAOoNB46UNhtSvrO37NIrr987P/7Jmlp7B0bxtvHgM+j
         YhINEe9INZKvulEFrhlfm9sifWkf7qyx/6eIIxh6qbEhI9r7AYt7EMgYudMtioH4CR3P
         EUQK7+fjfeWVuvXUzt3nlQsbuiyKo9nQGYo0iQJydg+7T2BodGwsNnZ+PL5NOLs7Y7zM
         HkrzE2UmQwi++1ygHLQ6UOBhLLoPaKfBuHhbp+tmAqrMlBPXswV9cOUZZ872KAJOLmQj
         JQb4l2YZpJvL7oHk3ko6JXJCWhXIKq+Moyavt93aV/4E3hv/Z+DQxYZ7/SH4VMt6zJFf
         yGHA==
X-Gm-Message-State: AOJu0YzBFGaWIiEHkKmljTapy4/vxyuAX2RURJfgnrfPxZtK1Yqe+4Ho
	HhZMuetiBzXAsSAyxpTdar4Qkm7r8BLkfZhqGnoRA4Bp
X-Google-Smtp-Source: AGHT+IETYkKHOM4YSxxN9MqGSDgqilWwCR4w2yYYdc8jjcvyyeXwuXRPM2YH0vRkDFHrdkqkIuTa7Q==
X-Received: by 2002:a81:5207:0:b0:5ca:15db:5c66 with SMTP id g7-20020a815207000000b005ca15db5c66mr2915764ywb.18.1700673492034;
        Wed, 22 Nov 2023 09:18:12 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g74-20020a0ddd4d000000b005cc636ddb1esm544961ywe.41.2023.11.22.09.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:18:11 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 08/19] btrfs: add fs_parameter definitions
Date: Wed, 22 Nov 2023 12:17:44 -0500
Message-ID: <3421ce0974e8ab4b156640d2c353e0a6cffd914f.1700673401.git.josef@toxicpanda.com>
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

In order to convert to the new mount api we have to change how we do the
mount option parsing.  For now we're going to duplicate these helpers to
make it easier to follow, and then remove the old code once everything
is in place.  This patch contains the re-definiton of all of our mount
options into the new fs_parameter_spec format.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 128 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 127 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index e4ac09bfe0fc..2366bcf7a23c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -27,6 +27,7 @@
 #include <linux/crc32c.h>
 #include <linux/btrfs.h>
 #include <linux/security.h>
+#include <linux/fs_parser.h>
 #include "messages.h"
 #include "delayed-inode.h"
 #include "ctree.h"
@@ -135,7 +136,7 @@ enum {
 	/* Debugging options */
 	Opt_enospc_debug, Opt_noenospc_debug,
 #ifdef CONFIG_BTRFS_DEBUG
-	Opt_fragment_data, Opt_fragment_metadata, Opt_fragment_all,
+	Opt_fragment, Opt_fragment_data, Opt_fragment_metadata, Opt_fragment_all,
 #endif
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	Opt_ref_verify,
@@ -225,6 +226,131 @@ static const match_table_t rescue_tokens = {
 	{Opt_err, NULL},
 };
 
+enum {
+	Opt_fatal_errors_panic,
+	Opt_fatal_errors_bug,
+};
+
+static const struct constant_table btrfs_parameter_fatal_errors[] = {
+	{ "panic", Opt_fatal_errors_panic },
+	{ "bug", Opt_fatal_errors_bug },
+	{}
+};
+
+enum {
+	Opt_discard_sync,
+	Opt_discard_async,
+};
+
+static const struct constant_table btrfs_parameter_discard[] = {
+	{ "sync", Opt_discard_sync },
+	{ "async", Opt_discard_async },
+	{}
+};
+
+enum {
+	Opt_space_cache_v1,
+	Opt_space_cache_v2,
+};
+
+static const struct constant_table btrfs_parameter_space_cache[] = {
+	{ "v1", Opt_space_cache_v1 },
+	{ "v2", Opt_space_cache_v2 },
+	{}
+};
+
+enum {
+	Opt_rescue_usebackuproot,
+	Opt_rescue_nologreplay,
+	Opt_rescue_ignorebadroots,
+	Opt_rescue_ignoredatacsums,
+	Opt_rescue_parameter_all,
+};
+
+static const struct constant_table btrfs_parameter_rescue[] = {
+	{ "usebackuproot", Opt_rescue_usebackuproot },
+	{ "nologreplay", Opt_rescue_nologreplay },
+	{ "ignorebadroots", Opt_rescue_ignorebadroots },
+	{ "ibadroots", Opt_rescue_ignorebadroots },
+	{ "ignoredatacsums", Opt_rescue_ignoredatacsums },
+	{ "idatacsums", Opt_rescue_ignoredatacsums },
+	{ "all", Opt_rescue_parameter_all },
+	{}
+};
+
+#ifdef CONFIG_BTRFS_DEBUG
+enum {
+	Opt_fragment_parameter_data,
+	Opt_fragment_parameter_metadata,
+	Opt_fragment_parameter_all,
+};
+
+static const struct constant_table btrfs_parameter_fragment[] = {
+	{ "data", Opt_fragment_parameter_data },
+	{ "metadata", Opt_fragment_parameter_metadata },
+	{ "all", Opt_fragment_parameter_all },
+	{}
+};
+#endif
+
+static const struct fs_parameter_spec btrfs_fs_parameters[] __maybe_unused = {
+	fsparam_flag_no("acl", Opt_acl),
+	fsparam_flag("clear_cache", Opt_clear_cache),
+	fsparam_u32("commit", Opt_commit_interval),
+	fsparam_flag("compress", Opt_compress),
+	fsparam_string("compress", Opt_compress_type),
+	fsparam_flag("compress-force", Opt_compress_force),
+	fsparam_string("compress-force", Opt_compress_force_type),
+	fsparam_flag("degraded", Opt_degraded),
+	fsparam_string("device", Opt_device),
+	fsparam_enum("fatal_errors", Opt_fatal_errors, btrfs_parameter_fatal_errors),
+	fsparam_flag_no("flushoncommit", Opt_flushoncommit),
+	fsparam_flag_no("inode_cache", Opt_inode_cache),
+	fsparam_string("max_inline", Opt_max_inline),
+	fsparam_flag_no("barrier", Opt_barrier),
+	fsparam_flag_no("datacow", Opt_datacow),
+	fsparam_flag_no("datasum", Opt_datasum),
+	fsparam_flag_no("autodefrag", Opt_defrag),
+	fsparam_flag_no("discard", Opt_discard),
+	fsparam_enum("discard", Opt_discard_mode, btrfs_parameter_discard),
+	fsparam_u32("metadata_ratio", Opt_ratio),
+	fsparam_flag("rescan_uuid_tree", Opt_rescan_uuid_tree),
+	fsparam_flag("skip_balance", Opt_skip_balance),
+	fsparam_flag_no("space_cache", Opt_space_cache),
+	fsparam_enum("space_cache", Opt_space_cache_version, btrfs_parameter_space_cache),
+	fsparam_flag_no("ssd", Opt_ssd),
+	fsparam_flag_no("ssd_spread", Opt_ssd_spread),
+	fsparam_string("subvol", Opt_subvol),
+	fsparam_flag("subvol=", Opt_subvol_empty),
+	fsparam_u64("subvolid", Opt_subvolid),
+	fsparam_u32("thread_pool", Opt_thread_pool),
+	fsparam_flag_no("treelog", Opt_treelog),
+	fsparam_flag("user_subvol_rm_allowed", Opt_user_subvol_rm_allowed),
+
+	/* Rescue options */
+	fsparam_enum("rescue", Opt_rescue, btrfs_parameter_rescue),
+	/* Deprecated, with alias rescue=nologreplay */
+	__fsparam(NULL, "nologreplay", Opt_nologreplay, fs_param_deprecated,
+		  NULL),
+	/* Deprecated, with alias rescue=usebackuproot */
+	__fsparam(NULL, "usebackuproot", Opt_usebackuproot, fs_param_deprecated,
+		  NULL),
+
+	/* Deprecated options */
+	__fsparam(NULL, "recovery", Opt_recovery,
+		  fs_param_neg_with_no|fs_param_deprecated, NULL),
+
+	/* Debugging options */
+	fsparam_flag_no("enospc_debug", Opt_enospc_debug),
+#ifdef CONFIG_BTRFS_DEBUG
+	fsparam_enum("fragment", Opt_fragment, btrfs_parameter_fragment),
+#endif
+#ifdef CONFIG_BTRFS_FS_REF_VERIFY
+	fsparam_flag("ref_verify", Opt_ref_verify),
+#endif
+	{}
+};
+
 static bool check_ro_option(struct btrfs_fs_info *fs_info, unsigned long opt,
 			    const char *opt_name)
 {
-- 
2.41.0


