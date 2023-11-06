Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0687A7E2F83
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 23:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjKFWJE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 17:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbjKFWJB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 17:09:01 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B56AD73
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Nov 2023 14:08:56 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5af5b532d8fso57817847b3.2
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Nov 2023 14:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308535; x=1699913335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXa7qR/dnYgVT16zl6Y+77lu5bJKpb7Bxori4DISc1s=;
        b=FX48Q+4/lGMAZNB77RVKon8McTyhTLKIqvXr0Zh5MTsf0edwrtGgWYbDLXp1Kwz+9k
         PGESS67j4V6FKabd85k4robqHMqmW1q/ej93eRutTmeizwqAhCRxE8NbESYIR2q4RZU7
         gmQmGOKh8XN+0EMaLwUqaMFVmP1NfDaEdfYSxfupJHlKAOufkkcT0YwO8zJsMrY9TYij
         Ci/ieEA90eLSzCIwFBaTDg3J7Qq9Gj5s/atsb1Dxldku/FnCHR97G6vweuUinKm7zTp4
         dVRWGwMO4vwibyNP8FBK69dwe7YdPLxgDLLXlNVE2w4aAPS6Wy8Q13GU9ToY+XkWXZvT
         z8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308535; x=1699913335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXa7qR/dnYgVT16zl6Y+77lu5bJKpb7Bxori4DISc1s=;
        b=SusCwlj5qHFTQJWLRUM02j8Dyb9xU9Ko3NyfT0AXpNyxUhjGnuXaG+EhfHmj6BmMb7
         YzMp8QDfSL5Lxzn11W36ETiwa0amCLi7J/RQ2jlULMTkWr7EsWgoyu+zHdGCczOyxc4D
         PmWWrNzuq34929fESCubZbHV30jUecLaDS0WR1dDwGhA9IyRsRqC18Ov8YQ60qbLmtgO
         8ZyJRKdYKLlhtT+JEBl0NZs7nay7DNhlsPxLZ4NgPYJseVOpHKmlBFpqdtFFqA9bH13b
         6a7cx2pecqKy10hs2aSTOxafRkB6lqi9n+dmNsbYMRBKv2asofZazPAzWI9jHQSbsPDc
         8T9w==
X-Gm-Message-State: AOJu0YwuV8QO+U1rsKob0CWoCLIemqMCJqlVTUq7lHayR4XHTbK3YFfb
        apH/M5OwtyITQqYB6KTewhBAIvaCWKC1SkgUW2Ai2g==
X-Google-Smtp-Source: AGHT+IFtI8R7767Jp4wmekIuVY+aWRbp76qlLyNTBogEzaCjlS2v/IIqM+ql6g9s7ZfIoNNxeUSaRA==
X-Received: by 2002:a05:690c:fc1:b0:5b3:4264:416f with SMTP id dg1-20020a05690c0fc100b005b34264416fmr13295460ywb.27.1699308535285;
        Mon, 06 Nov 2023 14:08:55 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d24-20020a05620a141800b0077412ca0ae1sm3667431qkj.65.2023.11.06.14.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: [PATCH 18/18] btrfs: set clear_cache if we use usebackuproot
Date:   Mon,  6 Nov 2023 17:08:26 -0500
Message-ID: <fa8bd832709bea92d427c104cc45686be347a150.1699308010.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699308010.git.josef@toxicpanda.com>
References: <cover.1699308010.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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
index f2c90f022233..769c49f0ef97 100644
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

