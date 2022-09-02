Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D895AB953
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiIBURN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiIBURA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:17:00 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A87D344C
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:16:58 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g14so2335388qto.11
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=HRhiJtjzbat0qp8UfnLyt/cT/Aa6D+S4PuZAeaJNGJM=;
        b=pLYXIOpVsTjibJLSJXa82BSfgDkS6gyNYsyT9rKU7p6pG/JgMz4gIDOKkEU8XP3DfX
         9ignNsuliNJ+5jP+KosuvuhEtA94JHeBTINgIMXI64I4bFut+WyH2XqDRsa9A9m7ujqm
         Ooxex5E6ByciD3Sj31ffsGylrJbRLVnxgMkgzjaUJEv6Wr9iWHU4apoeX1dLEzWiFAI1
         OCdYGf96AKG6/UiGoOuK7EHiiCE1iWMF83pIdtqm8UcCceufOQg+Hq32lr+uUVNvSzL9
         hqkKo9ncPywtFVNHCM5Y0AA8+8OrMUVljqY7PH3Zgrq7OgAtsMM0x6PptAQphnFpKD8j
         P4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HRhiJtjzbat0qp8UfnLyt/cT/Aa6D+S4PuZAeaJNGJM=;
        b=51vGqum7TrxTpGl5cMpaDVnLiaHh+KD96HZa5jIxMJCIphOqFwFjPuCzJuULoZvEHy
         ABo/2T3WR+B6FVpXZx3bvUAu/pcARCXG2/Oh+tdkuMZ1zchRzW3clgTNEXHk17MTT9B5
         HfvqY/F2skGhjepTlIN/MaggfT9naNL7pSISbAKp3WIxASg38s6Knxu3NddkWeV+1EdG
         rZO+wHs3eSH+WTBvGVWNAKpLscSA1CQGqDGFqM7H5QrdGYuOJ2+kfvC4UoSGIg/gAOrP
         1YKSWC2jvw3mssRmxzrmqhFhOqqQRyLqn9GYL/PxJ5OXqfJ+XLP22J2ug2JIh7vVRXn4
         KjEg==
X-Gm-Message-State: ACgBeo2i2/qua+2EVZuSZq8M4lT0bvfH3e2OhHNoQa8dIBRFq6JGypGa
        Tl/6ONbO0kS8QgfdSjaoWP9YAB7qHOUezg==
X-Google-Smtp-Source: AA6agR6t2lXmMKCz19estObM3/EbMdAOE83tt9XAQaH1DJiBygFjM9ZnlqfwNPAgIgbkdl67WF2gwQ==
X-Received: by 2002:a05:622a:1788:b0:344:7c86:f9a1 with SMTP id s8-20020a05622a178800b003447c86f9a1mr29446087qtk.22.1662149818149;
        Fri, 02 Sep 2022 13:16:58 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006bad20a6cfesm2166248qkp.102.2022.09.02.13.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:16:57 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/31] btrfs: export wait_extent_bit
Date:   Fri,  2 Sep 2022 16:16:16 -0400
Message-Id: <9a17df6dd26b9231b51843c205346bbad218034c.1662149276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662149276.git.josef@toxicpanda.com>
References: <cover.1662149276.git.josef@toxicpanda.com>
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

This is used by the subpage code in addition to lock_extent_bits, so
export it so we can move it out of extent_io.c

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.h | 1 +
 fs/btrfs/extent_io.c      | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 16a9da4149f3..3b63aeca941a 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -253,6 +253,7 @@ int extent_invalidate_folio(struct extent_io_tree *tree,
 bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 			       u64 *end, u64 max_bytes,
 			       struct extent_state **cached_state);
+void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits);
 
 /* This should be reworked in the future and put elsewhere. */
 void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b8fdd4aa7583..5bfa14f2b5e3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -753,8 +753,7 @@ static void wait_on_state(struct extent_io_tree *tree,
  * The range [start, end] is inclusive.
  * The tree lock is taken by this function
  */
-static void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-			    u32 bits)
+void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits)
 {
 	struct extent_state *state;
 	struct rb_node *node;
-- 
2.26.3

