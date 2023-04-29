Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF6D6F2662
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjD2UUN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjD2UUM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:12 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB2FE6C
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:10 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5562c93f140so10856687b3.1
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799609; x=1685391609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LnN241K7LXD/Glp4haAL2w2w1cE1ZjHjvJ9h+WX3H+c=;
        b=CtzhjkZvYcJXgHrUDIWpnGLrc5AP5If7ZSVhz+hE7DHfoL91GrTpqSreFweDFuHrVk
         M1hBe8bkiFvHhNJbzM2YS5numYymt5OeDYuqRQ82yg4/QNi+Rvh6V2odYtwnMoL4asqZ
         HHRpljZ2hJ9Fe1kSjF+EM9DMjbooEnIPxQixZVTEduCi4AosrK7LoC45murjEUVz75DA
         jZwVGQTKI1FbmtFce6Jgi/pEgsYY2RKDog6NM4t2t+hZkVPTvGGkciWo3TjUpkEO9A39
         pdyAvNR4UfrNuPvMpWZs/kaN+OAdjDrWmY9opXj1e6dmGfPMR1mDt26yjFwv6dR51rHo
         8Arg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799609; x=1685391609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnN241K7LXD/Glp4haAL2w2w1cE1ZjHjvJ9h+WX3H+c=;
        b=KHgvu5V2W0aGE7uRZh//wMbJZroiB11f9H6qaN/p7ltpgGqjps9gzxAWBuBmFDNYfB
         q3/xIFj0BFktU1aydCdQeKhAKcynZw6pnabjSPJnoCNmj3fumhsRTSXtofmq0yQBW+36
         It/XBlxYSuXv2oIxvacq7zf4b49hG+xUYz9UtFcVZ8/Wy8AaMvqByAYYYnWHBr2o27gj
         +z+TvxNqokeMDGkUJf4BzsGzkafxLR399/hJE7h94eL0nOkSHWyyvu9295FXhuIkOi9V
         xKwqsQoID9ZrWHxz+G7JaTyfkbO5LLAkEMlRycQbUA4+zxKsCgkm9C1dWmnCEEs1pCxv
         XFFA==
X-Gm-Message-State: AC+VfDzFAKXHZtJcGEVgVzHPfZwzgM3ddGjE29Xy1Vox+9Tj+N7mBeF2
        F2rG3U6/WZ5SHkhmFG9D5K9Gdi9W6c64RPhLygZIRA==
X-Google-Smtp-Source: ACHHUZ6+2ylilZcP1stE9O9q8oIgPZy7OuAK8l6FdAZ0WN/U9CacgI/b3ZWbNONorR1sdALzvjXgGg==
X-Received: by 2002:a0d:e64a:0:b0:54f:8171:38db with SMTP id p71-20020a0de64a000000b0054f817138dbmr7925250ywe.32.1682799609392;
        Sat, 29 Apr 2023 13:20:09 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u188-20020a8160c5000000b00556aa81f615sm3697148ywb.68.2023.04.29.13.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/26] btrfs-progs: make add_root_to_dirty_list static and unexport it
Date:   Sat, 29 Apr 2023 16:19:35 -0400
Message-Id: <df79d38d775726ed76a584c15d18d37cbaeb8ef1.1682799405.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682799405.git.josef@toxicpanda.com>
References: <cover.1682799405.git.josef@toxicpanda.com>
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

Now that there are no users of this helper outside of ctree.c, unexport
it and make it static.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c | 2 +-
 kernel-shared/ctree.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index d5a1f90b..3cb3378e 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -119,7 +119,7 @@ void btrfs_release_path(struct btrfs_path *p)
 	memset(p, 0, sizeof(*p));
 }
 
-void add_root_to_dirty_list(struct btrfs_root *root)
+static void add_root_to_dirty_list(struct btrfs_root *root)
 {
 	if (test_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state) &&
 	    list_empty(&root->dirty_list)) {
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 5eba9c14..ce050cec 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -988,7 +988,6 @@ int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path *found_path,
 		u64 iobjectid, u64 ioff, u8 key_type,
 		struct btrfs_key *found_key);
 void btrfs_release_path(struct btrfs_path *p);
-void add_root_to_dirty_list(struct btrfs_root *root);
 struct btrfs_path *btrfs_alloc_path(void);
 void btrfs_free_path(struct btrfs_path *p);
 void btrfs_init_path(struct btrfs_path *p);
-- 
2.40.0

