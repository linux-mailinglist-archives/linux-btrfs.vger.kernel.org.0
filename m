Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F50960E8C1
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiJZTMA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbiJZTLh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:37 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC13E03C
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:08 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id h24so10692585qta.7
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AjkMzcvMFJFTbCkaE/x0EU7EaY5vDPOLp5r4EnaoR1U=;
        b=ur0LaQScwrL7wVevK01WzqXN+x74uTseYh30AX29+4wC/JoxrYjZRi5AtQ6IwzJmLS
         oWYIdnVYBhpCizS/qjj9i/Qckhw5siz1AXHfAS+lPF8LYBqW6ByCP1jA6f/c2mAnQPn4
         n8Fi6Mzj4bA7sSHKG44C3xQe4aDbx9RILXl7VS7IfrxMzDuO5hjnJjmmLc8DLZMnS0YD
         m79hwp/vPx0CsIyqUgvlSCY5vXqfZl6fbiFQHL2unuQgGcqkVwU85Sh45Q2hp+UH5l3n
         DVlZbitjAZGQDJg3KGydVXnZ+xdyedfqC6OMjZ0t3pxCKusxH4KjddO8C0UVdZ0WtKjt
         xsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjkMzcvMFJFTbCkaE/x0EU7EaY5vDPOLp5r4EnaoR1U=;
        b=iVPyUBCzxy4czUnJQfdh5Mu2rN2yOvzlOiKOs+h4En5k/LzWGdyNo9jiXhxnjLBd1v
         w9RtoskX0iE/B4qVk7s814Md0AZGjerXIIJs4iBGoq+9SblYocU7H124uU0tiTaOY69S
         ENuR9isK9YZgEj53mvtFayynDpr6dgyReizbGO+BI1+8QmBao942bV+hrwSIUuC5Xc34
         LVSJOUGHm31P/ymfxXo6naVcSYqM9mhhd7bHo6tIksiaLuXOBWwYzxzsa4L9fzFyvjIz
         aGzD0PNbdZJmTMbdWnXWHqlZ2p4VqH8MV6sFWBKkqiJcczZW2qqNE7vnaKqBmNbo9F5b
         P2dQ==
X-Gm-Message-State: ACrzQf2ZPs3eHLBQVJvk3zFT9MWHrctMbHKdp/ue0d+TP4oqA2lBiZqO
        eY2Qvp4aDPno77RhJsRj1N6f+1hRwxaS1Q==
X-Google-Smtp-Source: AMsMyM5qbnNc/6DhR9yzXcByGCCogMITR0rAuwQwUEX7siWIIBqid9qjKu1ijY9LxZQa6Ah1N5TI6w==
X-Received: by 2002:ac8:5f52:0:b0:39c:cb1c:9310 with SMTP id y18-20020ac85f52000000b0039ccb1c9310mr38080605qta.177.1666811347510;
        Wed, 26 Oct 2022 12:09:07 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bj22-20020a05620a191600b006f956766f76sm1184449qkb.1.2022.10.26.12.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:09:07 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 17/26] btrfs: move the snapshot drop related prototypes to extent-tree.h
Date:   Wed, 26 Oct 2022 15:08:32 -0400
Message-Id: <2235e6eb3854dc111d0e0211c4a4d012741d6691.1666811039.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666811038.git.josef@toxicpanda.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These belong in extent-tree.h, they were missed because they were not
grouped with the other extent-tree.c prototypes.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       | 6 ------
 fs/btrfs/extent-tree.h | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ae2af0aeebc4..dcbfb1b9d269 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -675,12 +675,6 @@ static inline int btrfs_next_item(struct btrfs_root *root, struct btrfs_path *p)
 	return btrfs_next_old_item(root, p, 0);
 }
 int btrfs_leaf_free_space(struct extent_buffer *leaf);
-int __must_check btrfs_drop_snapshot(struct btrfs_root *root, int update_ref,
-				     int for_reloc);
-int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
-			struct btrfs_root *root,
-			struct extent_buffer *node,
-			struct extent_buffer *parent);
 
 /* orphan.c */
 int btrfs_insert_orphan_item(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 41870ba98346..df4c92c81fa9 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -72,5 +72,11 @@ int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans, u64 start,
 int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans);
 int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 			 struct btrfs_ref *generic_ref);
+int __must_check btrfs_drop_snapshot(struct btrfs_root *root, int update_ref,
+				     int for_reloc);
+int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
+			struct btrfs_root *root,
+			struct extent_buffer *node,
+			struct extent_buffer *parent);
 
 #endif
-- 
2.26.3

