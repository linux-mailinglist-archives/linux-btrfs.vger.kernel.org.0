Return-Path: <linux-btrfs+bounces-308-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F10EE7F4E27
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 18:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81276B216D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 17:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C14F58AAF;
	Wed, 22 Nov 2023 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="WS1sE5Nl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470561A4
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:23 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5cc589c0b90so10957617b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700673502; x=1701278302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAilSxqh1txTS7OyIFklNF4zhihXwft90BLRolkYYzE=;
        b=WS1sE5NlaQuPT9JM0LLiVOXYDY87x3zNPT43zA8jUJuWcugQc9Z6xOZ5ze4wUxdZMa
         pd+6spGYx0zUgmlEiNjkLNOtIWGQmKJu5XChZUPdMI7rnsKepsnXNpL6A4/mt3uQBeCu
         Tp30QUk7tbQY2j8nWXBWmrvLqsSqA3rtA0rhMRlyxRLCWwiAW8qcCUP7PQ3K3d6wOj8G
         Qlf6a763RBreFOHDVDNDgAqSelgwtiCDv/ikOM4GPD438qfcLys7f0SHZT/wy52Y/HUu
         I1UXyoyW/m5vkMFYoQGI2qliPGZdMa5qF2Sf2KRjTED8jPg5OSvx0XZLOyyEwx/8dSuw
         73/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673502; x=1701278302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAilSxqh1txTS7OyIFklNF4zhihXwft90BLRolkYYzE=;
        b=TfqJwzhavnCi4310NiaUSRDTwN1RIRZe3RPGTxA1FdQBZL4W2vQze8XjpFq9A6MHkQ
         Qi225bNxAmEP2UoE9f6uuzNY/BLK1ezNPzV2eCzAtVYmgs5yddLQ68VDQ13WUIUSaPe6
         vXTKaMlKwptrwkZ5RG/7p97+7wNX13UV0CvvMrL8yDSddTokg/0f/TRv2TVTGognUeQG
         sjuuBZuC0Ujz9kqsV+h6vEqB7pBjkRTUzpoWYcwO7bwHuFrgDPhxqFBnSQM65dWKSMGx
         IwEvDRBXvm8McZsMPADHhJPu+D85ilGYjaecG9fgJdeMemN+q152a3YfyDvNcel5M/Qc
         ZFFA==
X-Gm-Message-State: AOJu0YyPUHI7MYeorCh48QmvH0OiiED+emojT/9Tn1h4hn7c7KDIAy3A
	SUct6/bt+0ppCpFcLzaclOJ/wVHsMbvqMiTWpaMaNSAy
X-Google-Smtp-Source: AGHT+IGI6BJKwDRgvPRB6aPNHMEu3cRKwkFEfcQA68SwlTsZH1kBb7C4KZLtN4E6Sbg7xePb62/fUg==
X-Received: by 2002:a81:6c07:0:b0:5a9:30c3:c664 with SMTP id h7-20020a816c07000000b005a930c3c664mr3146076ywc.19.1700673502296;
        Wed, 22 Nov 2023 09:18:22 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id b1-20020a0dc001000000b005a4da74b869sm3846198ywd.139.2023.11.22.09.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:18:21 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 18/19] btrfs: set clear_cache if we use usebackuproot
Date: Wed, 22 Nov 2023 12:17:54 -0500
Message-ID: <026c5b257818ffc5b29421f7e3b039a626936ea5.1700673401.git.josef@toxicpanda.com>
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

We're currently setting this when we try to load the roots and we see
that usebackuproot is set.  Instead set this at mount option parsing
time.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c |  3 ---
 fs/btrfs/super.c   | 12 ++++++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c688eba0312f..719245d73b99 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2622,9 +2622,6 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 			 */
 			btrfs_set_super_log_root(sb, 0);
 
-			/* We can't trust the free space cache either */
-			btrfs_set_opt(fs_info->mount_opt, CLEAR_CACHE);
-
 			btrfs_warn(fs_info, "try to load backup roots slot %d", i);
 			ret = read_backup_root(fs_info, i);
 			backup_index = ret;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 30603248b71c..17fd0a438537 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -456,6 +456,12 @@ static int btrfs_parse_param(struct fs_context *fc,
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
@@ -554,6 +560,12 @@ static int btrfs_parse_param(struct fs_context *fc,
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


