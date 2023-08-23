Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20BB785A96
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbjHWOd1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbjHWOdZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:25 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CAAE78
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:14 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-58c92a2c52dso61783237b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801193; x=1693405993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCyZHB34BZce4FZ4PGz6ESIQhV8F8G7pmPqidbHJmNY=;
        b=nEIuoiS1OAJmKLZa24Qh0uFikFT/lQ2sduHsG141eswSFsQZ13sarxFuYj3CYz8k0Z
         S71PvVLP+RCJ+rmNtoE7CZWj2UiIZaXIdXd22RwSCwFpF6ID0/LQhTN46UETv3CN4qFb
         JJkIM73UdZbsde7wJCfjr/ywS0+Epp2Rr1CcvKL0UsgvLV+jLVXAkkU5xx3fGnn5zRL5
         Md67Sea/N4P91gqrlIjp4BlOAMxdElTuOjirvpxaawaK+btO1wgaJo+dVVl+nqi97E2C
         /Zx1aHB+ZLhSzLWIb8Jr5+E+nCv5oulD0Mf1a90YzhuAd0X230OLAdkHE7s5poWkzR89
         ulOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801193; x=1693405993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCyZHB34BZce4FZ4PGz6ESIQhV8F8G7pmPqidbHJmNY=;
        b=hpsh0/gg9Rjskwm+3v4YlzxfquQQv6/ReTUn5RtLniZATYRziLi8ige4DCMdNQGLnj
         JCxdkbQPIjmyhWBBFN4DT0ZcqZitYwpk4CLBpwmQ+y+ENVO+njXOdvZAHgd/03+2GUKq
         8Rd6Q0oXZ5LuSMmeAITySCjHQOT4UUIjwBUXQDGqkFbRr/fJkJ8Tnko4zH7/P76PoT6z
         3ItJetsEvwDZJgyWYFcNDVL1jlnkXMAyjeh/P1yNznJd58Cm7guoPyLFU1vdnYngyDOx
         Q0lTn16hTYN+3mhLZ6bm5j2QfrMIl2tt2PMf/agqfc4OIHqFchuLPfN1zsKrwYXxM4Hu
         vjlA==
X-Gm-Message-State: AOJu0YyM/APm+53vZrTU3KjU/aqzoLfKOM0AjfnB0SAejeK8waBk6glo
        Eivgu6jT64omiHFmzH8K9Ah4rXO6/TwhLEIWiIA=
X-Google-Smtp-Source: AGHT+IHymjphZsvWDdq2bwBXtYIzfq8s+u86tz5BSBKYdCgiBNF0lXl82YU8drs93fbwRwwX/WpH1w==
X-Received: by 2002:a81:8402:0:b0:586:a684:e7b6 with SMTP id u2-20020a818402000000b00586a684e7b6mr13298678ywf.9.1692801193228;
        Wed, 23 Aug 2023 07:33:13 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i80-20020a816d53000000b00570599de9a5sm3357294ywc.88.2023.08.23.07.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/38] btrfs-progs: make add_root_to_dirty_list static and unexport it
Date:   Wed, 23 Aug 2023 10:32:30 -0400
Message-ID: <d250bbd63e6c612917b3d3c89caae808067424e8.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that there are no users of this helper outside of ctree.c, unexport
it and make it static.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c | 2 +-
 kernel-shared/ctree.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 51b126c6..6e88b4a9 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -262,7 +262,7 @@ bool __cold abort_should_print_stack(int errno)
 	return true;
 }
 
-void add_root_to_dirty_list(struct btrfs_root *root)
+static void add_root_to_dirty_list(struct btrfs_root *root)
 {
 	if (test_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state) &&
 	    list_empty(&root->dirty_list)) {
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 59533879..15ac310e 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -989,7 +989,6 @@ int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path *found_path,
 		u64 iobjectid, u64 ioff, u8 key_type,
 		struct btrfs_key *found_key);
 void btrfs_release_path(struct btrfs_path *p);
-void add_root_to_dirty_list(struct btrfs_root *root);
 struct btrfs_path *btrfs_alloc_path(void);
 void btrfs_free_path(struct btrfs_path *p);
 void btrfs_init_path(struct btrfs_path *p);
-- 
2.41.0

