Return-Path: <linux-btrfs+bounces-52-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0627B7E5E5C
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 20:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82DE0B21814
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 19:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00747374E2;
	Wed,  8 Nov 2023 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="QNUxvfIp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBEF39856
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 19:09:39 +0000 (UTC)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A0A2110
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 11:09:39 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77ba6d5123fso98176285a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Nov 2023 11:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699470578; x=1700075378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFhP1hKebiWECw4Ujtbs0/IzrYrCaUbc1GWQbdpeKs4=;
        b=QNUxvfIpp3An1r4/kmPhC74a0D0DsvxiOJuU1OTBCqv6fYow4NsQ9SgNap49MKc9JD
         jD1n8Lq/u+nqCrWTsXmqkTjWIDwElxq4D5TFDcP3rbK3+9y8Qr+MpE490KkxnPs7uGYo
         D2CDNLgZXV9JEW55HmtCoHZoT3Yww2eD1qyuZXJRUJbEnIZpgBBYbN22VJ+AVaujrmMy
         osSGO4vtTxIXfESV8dJF96mSuJUSTTYPhoHKkOIGMqgonnVjA1s7T4x69XeW8HEbV8/y
         Rs3IOjeyAxYjCvmVGYWFF6wXl1WChtW2QEwUiPqGhCUOmgs+YsyfKE3NCopDiAsznsc6
         lA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470578; x=1700075378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFhP1hKebiWECw4Ujtbs0/IzrYrCaUbc1GWQbdpeKs4=;
        b=J62KaVgJcbksaLUCu5ihS3NEaMEKnFjlhlvdVG+sYvrSx9wtzbuLL+EkZfSjRrI6B0
         ueOubJDkCELfTyBDK8IR7CY1Eptm82Iq51B15d9SrP0SnKajicmMKC+Bm+T3Ohv2T2zA
         WfQ+ztlOjtMaZnfL+j6uzx/OkuIfuIA1TUSXWzyCiXLmM9tFBKEWTMn55LjNRA1CENUm
         LbhrAEtcIofaVm6I+2ZLTbZIyWUbdnIyIGlQIjapGeNGuIm0Na4wSmHHWwv1cpXXMHam
         1+z1mjal9azPVH9izlmVe36+SXB3ycDYP6NP0l7+bHeiGZ/fGc8dWIhisBuLfB0mr0DS
         j7Mg==
X-Gm-Message-State: AOJu0Yy3DkzmwsgtVwC5KqBW920IuphtTrB+rmmblzT4dFpqYl0ctBHd
	4ZXnxNIWVxhvpggiM8nYEjtAHr98WvDlKpp0+Yfr4Q==
X-Google-Smtp-Source: AGHT+IEFwUHcaGjFViWcQkhRCLF8vG3B0wRrzZMz98Qss2ZILOC/Kdc/KYLrVeXPXpC9LSanSDYkPQ==
X-Received: by 2002:a05:620a:4114:b0:779:d1a6:ee5c with SMTP id j20-20020a05620a411400b00779d1a6ee5cmr8340132qko.32.1699470578440;
        Wed, 08 Nov 2023 11:09:38 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ou32-20020a05620a622000b0076c96e571f3sm1353185qkn.26.2023.11.08.11.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:09:38 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH v2 18/18] btrfs: set clear_cache if we use usebackuproot
Date: Wed,  8 Nov 2023 14:08:53 -0500
Message-ID: <f6f4ebd670ac2d70a45da4d688d9eaa5ce8853b1.1699470345.git.josef@toxicpanda.com>
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

We're currently setting this when we try to load the roots and we see
that usebackuproot is set.  Instead set this at mount option parsing
time.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c |  3 ---
 fs/btrfs/super.c   | 12 ++++++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8f04d2d5f530..77f13543fa0e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2614,9 +2614,6 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 			 */
 			btrfs_set_super_log_root(sb, 0);
 
-			/* We can't trust the free space cache either */
-			btrfs_set_opt(fs_info->mount_opt, CLEAR_CACHE);
-
 			btrfs_warn(fs_info, "try to load backup roots slot %d", i);
 			ret = read_backup_root(fs_info, i);
 			backup_index = ret;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f45de65c3c0b..fe5badc9f6a7 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -459,6 +459,12 @@ static int btrfs_parse_param(struct fs_context *fc,
 			btrfs_warn(NULL,
 				   "'recovery' is deprecated, use 'rescue=usebackuproot' instead");
 			btrfs_set_opt(ctx->mount_opt, USEBACKUPROOT);
+
+			/*
+			 * If we're loading the backup roots we can't trust the
+			 * space cache.
+			 */
+			btrfs_set_opt(ctx->mount_opt, CLEAR_CACHE);
 		}
 		break;
 	case Opt_nologreplay:
@@ -557,6 +563,12 @@ static int btrfs_parse_param(struct fs_context *fc,
 		btrfs_warn(NULL,
 			   "'usebackuproot' is deprecated, use 'rescue=usebackuproot' instead");
 		btrfs_set_opt(ctx->mount_opt, USEBACKUPROOT);
+
+		/*
+		 * If we're loading the backup roots we can't trust the space
+		 * cache.
+		 */
+		btrfs_set_opt(ctx->mount_opt, CLEAR_CACHE);
 		break;
 	case Opt_skip_balance:
 		btrfs_set_opt(ctx->mount_opt, SKIP_BALANCE);
-- 
2.41.0


