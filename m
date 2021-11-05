Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591934469B3
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbhKEUbl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbhKEUbl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:31:41 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B65C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:29:00 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id s20so1634377qtk.0
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fXOo4OFFhd3TCh1YRGhWnQCfYRDWYwlAttNRthBXGnU=;
        b=td7NRD9Q1g3HZsfLVw/vPa24kfk2UOcvW8u4EZomD4xT7EkDhqzLxVqpReVzp3eydn
         BYWpCwlqmnM9akUL/P8DT7Iq5NkIc7epyyRXx+4GfScJjXnkIN8jGQEcVptdRSDj0NaW
         uDoR6WwrZNj3TEVWBz3eJ9/8U5gIAkDIxjTq4ikyynA7p3ekJV2s2Ygpyy0LENNeugZW
         YYCilYVGDHCTIp+EFjdlueVMIIzurYOLErPcsXsNXSVC6VX7bEVKnXqAwycjo5FksAnK
         Lby5GxgEwQxXxRjrCx5YIm3FadPS0SEaLWwTg0mH6eaJRTN4iWmrBDgW/pB2hp+qCJRf
         YsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fXOo4OFFhd3TCh1YRGhWnQCfYRDWYwlAttNRthBXGnU=;
        b=QvaNcJRRlL+8s2pC583vl11ekzQxcjLTZLltplw9MpoJuVEQzpTbK7P1GeiaLOXwjI
         mlx/nxHnzHWilCHwjfTh2BCc1v8xjjHxJCjvgSstUqLFw+UGYfJdjvbx/qvC5MOu5Skc
         AsEaZfcnycWJBiH1SCo7GvAektrbGtGYtzMqgs+kNvWhFFzlloTMMjfqqvJxQAMu5ZHp
         UKuDIjafPaSGkZoAWlk0nMHHjHCeMVO+BBsKqWbtXcw9g9vqwWypwDRUYLqa9/gXkuqX
         AtUs+WYWb8rUJFWEaBl6R1xDlpNuF3AUE1fJrA20g+KCv+aaAEN+tiMObduAH00Gf7/m
         l41w==
X-Gm-Message-State: AOAM532vO3J4j8P0tV6Kc/PBuf0UeHoZThCb7d3eCUiyTqRnJ7tjr1Yz
        Zc0oN5OKBb/8kD6DJW/Jjdci6P+aGSpt8A==
X-Google-Smtp-Source: ABdhPJzIy5WNCv075wiwh+oJEGjOLymAtTOF+cw+d+HE0WWbARsPEEZ38DTOAOrAYFJ2CkvNLAUk7g==
X-Received: by 2002:ac8:59cc:: with SMTP id f12mr13386620qtf.397.1636144139371;
        Fri, 05 Nov 2021 13:28:59 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d9sm6510583qtd.21.2021.11.05.13.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:28:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/20] btrfs-progs: image: keep track of seen blocks when walking trees
Date:   Fri,  5 Nov 2021 16:28:33 -0400
Message-Id: <b0f1ed7e3a0049232fe27491c9931f821ee87566.1636143924.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636143924.git.josef@toxicpanda.com>
References: <cover.1636143924.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Extent tree v2 no longer tracks all allocated blocks on the file system,
so we'll have to default to walking trees to generate metadata images.
There's an annoying drawback with walking trees with btrfs-image where
we'll happily copy multiple blocks over and over again if there are
snapshots.  Fix this by keeping track of blocks we've seen and simply
skipping blocks that we've already queued up for copying.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 image/main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/image/main.c b/image/main.c
index dbce17e7..57e0cb6c 100644
--- a/image/main.c
+++ b/image/main.c
@@ -93,6 +93,8 @@ struct metadump_struct {
 	pthread_cond_t cond;
 	struct rb_root name_tree;
 
+	struct extent_io_tree seen;
+
 	struct list_head list;
 	struct list_head ordered;
 	size_t num_items;
@@ -461,6 +463,7 @@ static void metadump_destroy(struct metadump_struct *md, int num_threads)
 		free(name->sub);
 		free(name);
 	}
+	extent_io_tree_cleanup(&md->seen);
 }
 
 static int metadump_init(struct metadump_struct *md, struct btrfs_root *root,
@@ -476,6 +479,7 @@ static int metadump_init(struct metadump_struct *md, struct btrfs_root *root,
 	memset(md, 0, sizeof(*md));
 	INIT_LIST_HEAD(&md->list);
 	INIT_LIST_HEAD(&md->ordered);
+	extent_io_tree_init(&md->seen);
 	md->root = root;
 	md->out = out;
 	md->pending_start = (u64)-1;
@@ -771,6 +775,14 @@ static int copy_tree_blocks(struct btrfs_root *root, struct extent_buffer *eb,
 	int i = 0;
 	int ret;
 
+	bytenr = btrfs_header_bytenr(eb);
+	if (test_range_bit(&metadump->seen, bytenr,
+			   bytenr + fs_info->nodesize - 1, EXTENT_DIRTY, 1))
+		return 0;
+
+	set_extent_dirty(&metadump->seen, bytenr,
+			 bytenr + fs_info->nodesize - 1);
+
 	ret = add_extent(btrfs_header_bytenr(eb), fs_info->nodesize,
 			 metadump, 0);
 	if (ret) {
-- 
2.26.3

