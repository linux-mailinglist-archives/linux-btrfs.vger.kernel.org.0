Return-Path: <linux-btrfs+bounces-42-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091377E5E45
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 20:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D1728178D
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 19:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEAD374FA;
	Wed,  8 Nov 2023 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ChIcI5iH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B180F374E2
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 19:09:26 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056552117
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 11:09:26 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-777754138bdso953085a.1
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Nov 2023 11:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699470565; x=1700075365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qi9EDPpqsP1S+XlZ8gl3BYRn+cxn6q4J+q4swfwHv2I=;
        b=ChIcI5iHRhKM/4/c6dRaUR6GrCcPMdueR12vSkLiM7iBOZkV0/r5nK8nLlnTLgj5eO
         zOom4WkcytezFIY9BQA4A2dmorcAV1kIyuGOJn4CIxBAQ3UhdR1dbTDv60230POClF8X
         taDqj+o/pThChnxnqI2nj+QM4LmfcY7nfkO2bo21/638P3w0Ckt5DqKLQ+I0LOs/l+AI
         0kd+49o7+RIUo391nG/NHfBF3QS7VbP5jJDwHYxG0rzz7XUb6J+dVFpEDED1udHmUHbG
         6I4T3rZ8Als7rVoijcW2IsWd0QUMYetvLay4019Tm85sR0aOx7dAI29PlC2cuOwlFaTX
         EzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470565; x=1700075365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qi9EDPpqsP1S+XlZ8gl3BYRn+cxn6q4J+q4swfwHv2I=;
        b=vr4wRwO/JKEJoSn1F5HikozINmIMgvHNbDggvVjwz4XhZYq+yJdcw+YY51WPhdk9av
         DJsifyd0elZ68xo0RqUGKENoQGhNCAw5gVzfXX8WWnZ0WZ/P0Xds5eGECyeVE0vgvvDG
         shcjKhtMj2QT2ILLlab8UkFSiksdlo9/WJdXRb/DcZtZW8sXFwocakRZ66wdE7ww/dcU
         veZoXh6Qwje0SxXccWC88UFSU16H1e0Q2yrgFLy76xfpDD/xOaRrEaWjq1FRAU6WQGjC
         gThE1ZJbmVCQ8yiCSQJlp7Q5UnWtgrK5LDGGq1gTKk62cnR0PS1SdgMchfUh966SHpAx
         vBYg==
X-Gm-Message-State: AOJu0YyaEawKorYXsoL/WnwbBMdTIhggh4Fz4In2LHOE8D0Y6iFQ0yRz
	b7RjWH7a9jyqWBjtDRH0YirDOySCIYBEB51KxaONrA==
X-Google-Smtp-Source: AGHT+IFqX8FCH7A14GIUxif9PhQIp5aaXMkVzFsFrNDfHdR2YJ2jsL7pmoHaZQHuHhV3mnYMewbHSw==
X-Received: by 2002:a05:620a:4551:b0:774:389f:8358 with SMTP id u17-20020a05620a455100b00774389f8358mr3105529qkp.52.1699470564936;
        Wed, 08 Nov 2023 11:09:24 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c28-20020a05620a165c00b0077894c77ca6sm1331476qko.135.2023.11.08.11.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:09:24 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH v2 08/18] btrfs: add fs_parameter definitions
Date: Wed,  8 Nov 2023 14:08:43 -0500
Message-ID: <24771d34a49eb428d6415197f390bf41dcef495c.1699470345.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699470345.git.josef@toxicpanda.com>
References: <cover.1699470345.git.josef@toxicpanda.com>
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
index d7070269e3ea..0e9cb9ed6508 100644
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
@@ -132,7 +133,7 @@ enum {
 	/* Debugging options */
 	Opt_enospc_debug, Opt_noenospc_debug,
 #ifdef CONFIG_BTRFS_DEBUG
-	Opt_fragment_data, Opt_fragment_metadata, Opt_fragment_all,
+	Opt_fragment, Opt_fragment_data, Opt_fragment_metadata, Opt_fragment_all,
 #endif
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	Opt_ref_verify,
@@ -222,6 +223,131 @@ static const match_table_t rescue_tokens = {
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


