Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E6644CA27
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhKJULL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhKJULK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:11:10 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF5BC061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:22 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id q14so3239947qtx.10
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OrzBinvVFNl8LLYGzVfUNwOHSnZxDGtZtYRpLHCyhJo=;
        b=m85ocxu8pO1O49e9iJtWH1idKZMgQ3Z9wsVqXnkzI3zeQ3hw51hsCuKDrpf30ef2rY
         9HMOaS6l7FwO6Zc2KAoQDGfdmoB5SZIoICPfw8vA/oHIE8bIBMDKJ3Vl9VsjYK1ZbEwl
         1UVL1pHw3sqVvcamKvelLYMXWIST+HyHYsnBMtCICqJDev6TFNybXSrgiAuSt0uhQtyw
         AQycR9jdJpUAfDNv1ra4m/ciLEWzZa4cl0gAiWdMjDNdH2ys2D7mGuqsnNcQRlNGigjM
         pYb8Fj/E4EL9M8pvJW5VON/RUCA2/7Wv7ZtCsdzJ4bkrPxppRnGZ93TEoZY26vlyldsp
         lnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OrzBinvVFNl8LLYGzVfUNwOHSnZxDGtZtYRpLHCyhJo=;
        b=arXHw3yCiKzchUEYxEHUGC6XayPiTrcyMBAIvq0CpxbjYFXaEeypvWwhTqf0RqGLVR
         AgY/Q/iqq5NhG6vD3DoR9YAEeSKHB5dN5nmxwHFFLC7xnkruKDwOq2XfIrRmjQT/OObK
         WmWtdEXLcrGcc45x1/FytWeSSHsHNzjZZ850I8WcFa3WqboDx91KRcR0mEiEptafMb13
         B0cFRgdpPRIl65c0C95LK7zRN0xqq/kzdE76fJIv5J+9r9pk4x3PBabGhBbShhr7BdlL
         HBmXvWSSPGzaihAlEoUYDvlrrv4nhvLd3Y7rm3X6qfoRtErCNh3mp67zttTpWOSyG1Ic
         Ug6A==
X-Gm-Message-State: AOAM531y4r9q/9fxGAYJX77tahIe3Tmig/agovSDlEyTExJkT/GUJagn
        89s2hoQ6DmZGnMXLKfylDYrJ57EjNdUviw==
X-Google-Smtp-Source: ABdhPJwEn2yAGJRzg3zlOf1F7lYKVovNAij6EGWDTzDX07rqcjNrdv9e9M5WDA3eH8p7jhPsX1zj5w==
X-Received: by 2002:ac8:5711:: with SMTP id 17mr1893998qtw.58.1636574901539;
        Wed, 10 Nov 2021 12:08:21 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w9sm485771qkp.12.2021.11.10.12.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:08:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 09/13] btrfs-progs: image: keep track of seen blocks when walking trees
Date:   Wed, 10 Nov 2021 15:08:00 -0500
Message-Id: <164b6a339044653244b5ad843f032cdbedc314d6.1636574767.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636574767.git.josef@toxicpanda.com>
References: <cover.1636574767.git.josef@toxicpanda.com>
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

