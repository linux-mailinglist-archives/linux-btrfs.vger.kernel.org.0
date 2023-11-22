Return-Path: <linux-btrfs+bounces-310-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669177F4E2B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 18:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDFC9B2112E
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 17:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FBB5B5DA;
	Wed, 22 Nov 2023 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="G7PmPc8u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE1B83
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:24 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5cbbe2cba33so19023467b3.1
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700673503; x=1701278303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BiTjWmy4vJZo6BlhqNQcEYY6KSKiyt3LwZZttTCg/UE=;
        b=G7PmPc8ude4xe7o8U/57d/bvVGthtSOhoTG8yTi3CD4FmgjSb+7azDJzfzUqIKEPKu
         YB1Q/1shlznt9vSuvhb/PH3Lvm7jyrcSIlD814uGs+At1Ibnmc5H+MaMbm3b3XCUxjU/
         eaWyrSkOk+F85QDWX50noZkZ6f3D7bkTEFFqy9YgywzpzVId1UESJc730eUmJVXDuW+q
         fxE8sTb6S8eOEWoYO+rmne4LLOJwOJXh5ah8WXHYU3//0ZzqAJZ71cw4HVH/PD/mLtQu
         1Vpcwdem/OHhTTEZVkzWQ/ZS44Z63xts4HAVJBXKnSgwJp7/D/YhHXuVmFPKqTti+gau
         h98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673503; x=1701278303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiTjWmy4vJZo6BlhqNQcEYY6KSKiyt3LwZZttTCg/UE=;
        b=jwAWwVNcoj4xIE8hDqznpbJ7ryxsEopyrmfQwJoERzWNHgZbbUs+QN/HJ1mS2UhhTK
         ubrZchinhY17ofkjVeEiqadsJ75ulZvv8OrNmHi+FKhZLqhOT4U9PHpNDPegJyr1gM5U
         H2C2B7Rbguxn05bTeNfstsxSojmWwmr8giC2X/2wfUAMtFscpxTenE/pjZ+9RfH9TZCL
         4HI/aqL0mu2PMcUDJFwWlpwLDdNoGTIaULVD/OKmtw6aPnvZp5iTYzSlNaXOnZNsfM+q
         yl/5poO+IgJnBg8DJMp9LPqZYrlIkP05wZkpy8EEhUllEO/H2yMNnoJKKu8eHOgqI0n6
         rZLQ==
X-Gm-Message-State: AOJu0YxzQsREbTNcFQZW/Nne8YqkLbSidBwlYjv6xW5D/v86FgXy1Ukl
	NBe2kzV2Qk+KGH3QFsL2yOLUIHLt+oSKvD62onCG5sLJ
X-Google-Smtp-Source: AGHT+IHFt2HnaSBdZqayOZ/jkrIrhK6onRuD2u0+HXeCZlT3pGRtSBS/PCdF45H3N1JkghPQDkNJDA==
X-Received: by 2002:a81:5c07:0:b0:5ca:6e:35d3 with SMTP id q7-20020a815c07000000b005ca006e35d3mr2711501ywb.30.1700673503318;
        Wed, 22 Nov 2023 09:18:23 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u65-20020a0deb44000000b005cd091e885dsm43713ywe.30.2023.11.22.09.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:18:22 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 19/19] btrfs: remove code for inode_cache and recovery mount options
Date: Wed, 22 Nov 2023 12:17:55 -0500
Message-ID: <91c34f25266be07585b75fde0b580b9118f8786e.1700673401.git.josef@toxicpanda.com>
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

We've deprecated these a while ago, go ahead and remove the code for
them.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 17fd0a438537..8ce7c880e9ce 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -130,10 +130,6 @@ enum {
 	Opt_ignoredatacsums,
 	Opt_rescue_all,
 
-	/* Deprecated options */
-	Opt_recovery,
-	Opt_inode_cache,
-
 	/* Debugging options */
 	Opt_enospc_debug,
 #ifdef CONFIG_BTRFS_DEBUG
@@ -224,7 +220,6 @@ static const struct fs_parameter_spec btrfs_fs_parameters[] = {
 	fsparam_string("device", Opt_device),
 	fsparam_enum("fatal_errors", Opt_fatal_errors, btrfs_parameter_fatal_errors),
 	fsparam_flag_no("flushoncommit", Opt_flushoncommit),
-	fsparam_flag_no("inode_cache", Opt_inode_cache),
 	fsparam_string("max_inline", Opt_max_inline),
 	fsparam_flag_no("barrier", Opt_barrier),
 	fsparam_flag_no("datacow", Opt_datacow),
@@ -255,10 +250,6 @@ static const struct fs_parameter_spec btrfs_fs_parameters[] = {
 	__fsparam(NULL, "usebackuproot", Opt_usebackuproot, fs_param_deprecated,
 		  NULL),
 
-	/* Deprecated options */
-	__fsparam(NULL, "recovery", Opt_recovery,
-		  fs_param_neg_with_no|fs_param_deprecated, NULL),
-
 	/* Debugging options */
 	fsparam_flag_no("enospc_debug", Opt_enospc_debug),
 #ifdef CONFIG_BTRFS_DEBUG
@@ -442,28 +433,6 @@ static int btrfs_parse_param(struct fs_context *fc,
 		else
 			btrfs_clear_opt(ctx->mount_opt, NOTREELOG);
 		break;
-	case Opt_recovery:
-		/*
-		 * -o recovery used to be an alias for usebackuproot, and then
-		 * norecovery was an alias for nologreplay, hence the different
-		 * behaviors for negated and not.
-		 */
-		if (result.negated) {
-			btrfs_warn(NULL,
-				   "'norecovery' is deprecated, use 'rescue=nologreplay' instead");
-			btrfs_set_opt(ctx->mount_opt, NOLOGREPLAY);
-		} else {
-			btrfs_warn(NULL,
-				   "'recovery' is deprecated, use 'rescue=usebackuproot' instead");
-			btrfs_set_opt(ctx->mount_opt, USEBACKUPROOT);
-
-			/*
-			 * If we're loading the backup roots we can't trust the
-			 * space cache.
-			 */
-			btrfs_set_opt(ctx->mount_opt, CLEAR_CACHE);
-		}
-		break;
 	case Opt_nologreplay:
 		btrfs_warn(NULL,
 			   "'nologreplay' is deprecated, use 'rescue=nologreplay' instead");
@@ -534,10 +503,6 @@ static int btrfs_parse_param(struct fs_context *fc,
 	case Opt_rescan_uuid_tree:
 		btrfs_set_opt(ctx->mount_opt, RESCAN_UUID_TREE);
 		break;
-	case Opt_inode_cache:
-		btrfs_warn(NULL,
-			   "the 'inode_cache' option is deprecated and has no effect since 5.11");
-		break;
 	case Opt_clear_cache:
 		btrfs_set_opt(ctx->mount_opt, CLEAR_CACHE);
 		break;
-- 
2.41.0


