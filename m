Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D460C7E2F88
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 23:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjKFWIu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 17:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjKFWIs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 17:08:48 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE34D75
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Nov 2023 14:08:45 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-778a6c440faso258527885a.3
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Nov 2023 14:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308524; x=1699913324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qi9EDPpqsP1S+XlZ8gl3BYRn+cxn6q4J+q4swfwHv2I=;
        b=1g7H7GtrZ9mm41v3RmDCdjUIvd/CMTTYIF/68OYqF8p9wWjddWfyA9JHRYxPOgo5qd
         kv7f5n7KRUNSlZfM51DLxGYx0/j7NLyakDoLwHvfEIGGCgpJWBHGVuHyGMEBwd+vC7uw
         Utj8cpVDsQ/2Y619rghIcOKgW37WdhBvLSgqeoqxgUsNNS409MwjZy9faUtvxRSnQ3PE
         DBjzNlSuQ7winLJqu/SsCUZUbA+k3gg7gz6xihdHoNfL5U03APu7Vxogk5v6pTidulfg
         ZWine5WZS25BuRl2VZODB749Z/uYaGFb4ZRZUjutB1FNK9JziE7y7VmLNMj8NTHxxU/F
         NhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308524; x=1699913324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qi9EDPpqsP1S+XlZ8gl3BYRn+cxn6q4J+q4swfwHv2I=;
        b=RjOa37xpfJe8tpwaZUxYA/s5jFFiN/xI/4C76oIRq9XzF3PN9n7b9XF2r4z44lGt3F
         Tbm+3UNYPyKbZnJhM02NT4E3Ox0uuqz2D03gvGVyFduR4RiND5d/8lSbaalVy1q8h8l1
         17j6HEaCaSTOFISmtGNODFvb5Ka3ttEEM467NjNAZCKcRbGxTU9Rb2451CprmOhpEK1n
         EotKvaVNBCzQDm1YvSnASRvmr4sKzdbDhegRfHzbKSKlpFepeDQ3yslwO+tq/c+2F0z5
         GB61JHLIH/5iVT6+FlobiuxJlcpZLnp/JUUHTchklMijfFKxFtgll18s7xDBwbzY35dg
         GwiA==
X-Gm-Message-State: AOJu0YzNZliAp6XaNCBbvySd6H9e4I5+unqcj1RmpviXNBXNXL9AaDqr
        WhrdLSoNLEUFgCbjj5dBT8WL/hGFCN0qV4f+eIKsBA==
X-Google-Smtp-Source: AGHT+IFPiDb7JWisYnS006hixYyoYr8loyt9iXIWTDKC1Q9M+sYaNa6Us9AC6cgYW9NSl0YLlbyKDA==
X-Received: by 2002:ad4:5ca1:0:b0:66d:6af7:4571 with SMTP id q1-20020ad45ca1000000b0066d6af74571mr32971369qvh.17.1699308524086;
        Mon, 06 Nov 2023 14:08:44 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c10-20020a0cfb0a000000b0065af9d1203dsm3809217qvp.121.2023.11.06.14.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:43 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: [PATCH 08/18] btrfs: add fs_parameter definitions
Date:   Mon,  6 Nov 2023 17:08:16 -0500
Message-ID: <9d0173eef0e37f321da8945cfcfa7d5c923280c3.1699308010.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699308010.git.josef@toxicpanda.com>
References: <cover.1699308010.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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

