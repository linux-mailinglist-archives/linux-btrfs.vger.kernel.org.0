Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5435A449C6E
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbhKHT3r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbhKHT3q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:29:46 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECECAC061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 11:27:01 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id a2so2173284qtx.11
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 11:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OrzBinvVFNl8LLYGzVfUNwOHSnZxDGtZtYRpLHCyhJo=;
        b=M6wDrBWCjbpqf4LhKs4fdFOlON2B6GWvHh9rp5IHhq3omi52cjD/We0SmnJS6sk8QW
         9ExUY0pZK2h4DnAxavweHkxDkz2Wij6A1ZmN5QfHonnaSowG61QqVQSss8zVfW+lQWrV
         pOte3kNjSGomLgPOLl2gyRoZQtJiqCNy1msLkpw5HIAOL1ShOZH0kDnbWfIiZ2tp8PmS
         /8XdL7K4jzVffkmilEgMakZ8wpvSPENzqlJQZ8Xq+PRP4ypFmzH+gv7AwZ2qYkN/GCvE
         LpQARDuImWl0cQPZb5OzyxCOTEukwrh6eFtKIAPI6NQbWVU/G/ZxR2XlZ8ObcXNXy6jQ
         XWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OrzBinvVFNl8LLYGzVfUNwOHSnZxDGtZtYRpLHCyhJo=;
        b=Fq/zMvdiIvFEsvO1NXlkgWk+48r5Q7gEreobDuz3ozqWq4jy3ggmpsXRvPxEQirWMP
         n7qbO/qyBGa/YJsKIE6oyu6jYbQk/oU/EbeT/pGNt7HzAEFH7PdbF6JQry7JKla5bSDh
         f2cKaWXIvkrZRyZIcLlO0IJ30hvqYxJacZ/Y6b2mAzZzat98hSWfVbkQ9fMOTIuv2nQN
         a4S6xdBND95GaExXI7et2ebmJFdA4S/vHOI0nnsvwcHT4UgYGrvY6oDvV2dMmK1JK11Z
         llhYiy6aCW9zlqtuzeijFdICT2zo7GbH7CCmRKdYVzgAiRYXukiRjJvgHaF5SZm/EwFr
         uPxw==
X-Gm-Message-State: AOAM533pxzQ6QcwJzop+pz9M8CU3Rx5GuBBAVuR5MYvM6/69ELFIXinf
        cir1axHoCt7aSmOiZgwUDw5DTX8UeAj4vg==
X-Google-Smtp-Source: ABdhPJzeVMTaDmVnMsPJwk36ViP1nB3ke+7hKlnWI+LLy3cZGm3IhAPIZ4HLydrF4Z4J9QKXqlEZ0w==
X-Received: by 2002:ac8:5f08:: with SMTP id x8mr2109689qta.165.1636399620652;
        Mon, 08 Nov 2021 11:27:00 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m4sm1912923qtu.87.2021.11.08.11.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:27:00 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 08/20] btrfs-progs: image: keep track of seen blocks when walking trees
Date:   Mon,  8 Nov 2021 14:26:36 -0500
Message-Id: <2287937ff3841f4314de1a346cbdee99da7ada74.1636399481.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636399481.git.josef@toxicpanda.com>
References: <cover.1636399481.git.josef@toxicpanda.com>
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

Reviewed-by: Qu Wenruo <wqu@suse.com>
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

