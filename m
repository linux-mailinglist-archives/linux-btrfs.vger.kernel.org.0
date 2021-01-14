Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9152F6A6C
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jan 2021 20:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbhANTDj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jan 2021 14:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbhANTDj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jan 2021 14:03:39 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C8CC0613D3
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jan 2021 11:02:59 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id w79so9322469qkb.5
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jan 2021 11:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lwBRXcf/nnqtZXOUcyl0M7iOkuZ2sALJPEASw9ht3O8=;
        b=EakxITne+9mUhfmerUbNe+bMwgK/HvH4BaxnKLXDxxvrBkgmqYOcBAa/dp/8pLhWlq
         LwVoLpXvpk8VzYghQb1aXvD1b28TKEGeQOsW+0xlrI/BgJp0rRO/vpAa/4DZjOsz40p9
         GuKjF4L67uzYxlt0MOV0STdogm6ceW9xrAogUmtGmOr998VviUxKEckDJ+s2yHyKtGSX
         PO4nhFUzxpR7q19O6DuYZTxXFBSOZYlh5ReN9KbWs9ZQTp8Y+6nsbyqtm8AFSdiJ05a2
         8Bm1goZ2gLKtzuUdRLayvcPR/zT3ioqo7uMZ+hBGzEjAybGxIz2s3Ye6tHRZUwkdVKlS
         ss/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lwBRXcf/nnqtZXOUcyl0M7iOkuZ2sALJPEASw9ht3O8=;
        b=RHh1DVBAr9Cuzxw0GlIH7Q36fDByUDc6TiPwhB9jk8zx7kjv65H5oampbK6CggwtMO
         d9OqN5qYofmc4TgIblCNPezLKhaUQqtHAcMsx8Hn8QvjaAfUvus0cJTifu8kGYalNEbd
         XQi8mH2gbrz4/xvxu5ADxLav9o48K22utz5pm8qjKSXEoFNp0gHCK/UCxnOqJo+8PWVQ
         xpWS3Q8eBTU2YzHykdXWCfkIoHzTSZzTR6Lu9WQfKyjxUIPx8zVvf6wEpWM3K6D+Vqv5
         G7P2WIdUlZHuPCBmRh6dTMVF6+u2i32T1xkYKcy20RHdbaZ6VcS5PUoDn77HR0uoNZzp
         g1qw==
X-Gm-Message-State: AOAM531pcieE08q6XK/VjLeqIVlYvaKh1MuTgk4L6V4Wq7GaqhW41H4s
        o/xB9ovFpk7qEKPd+RnHvcpmBEUqcyzwEHnm
X-Google-Smtp-Source: ABdhPJyXFk27YJ5VQxH1YoFdCudt1gLWUAM032Qw52v9hDhZ9iUPmMzE7SdMNrfEaGEHuJwxdiQ+5g==
X-Received: by 2002:a37:aa94:: with SMTP id t142mr8833736qke.116.1610650976993;
        Thu, 14 Jan 2021 11:02:56 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c20sm3327854qtj.29.2021.01.14.11.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 11:02:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 4/5] btrfs: add asserts for deleting backref cache nodes
Date:   Thu, 14 Jan 2021 14:02:45 -0500
Message-Id: <fd97fa2af421b5b9fe0c3ac1ee99dad0fcbf1f7d.1610650736.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1610650736.git.josef@toxicpanda.com>
References: <cover.1610650736.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A weird KASAN problem that Zygo reported could have been easily caught
if we checked for basic things in our backref freeing code.  We have two
methods of freeing a backref node

- btrfs_backref_free_node: this just is kfree() essentially.
- btrfs_backref_drop_node: this actually unlinks the node and cleans up
  everything and then calls btrfs_backref_free_node().

We should mostly be using btrfs_backref_drop_node(), to make sure the
node is properly unlinked from the backref cache, and only use
btrfs_backref_free_node() when we know the node isn't actually linked to
the backref cache.  We made a mistake here and thus got the KASAN splat.
Make this style of issue easier to find by adding some ASSERT()'s to
btrfs_backref_free_node() and adjusting our deletion stuff to properly
init the list so we can rely on list_empty() checks working properly.

Link: https://lore.kernel.org/linux-btrfs/20201208194607.GI31381@hungrycats.org/
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index ff705cc564a9..17abde7f794c 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -296,6 +296,9 @@ static inline void btrfs_backref_free_node(struct btrfs_backref_cache *cache,
 					   struct btrfs_backref_node *node)
 {
 	if (node) {
+		ASSERT(list_empty(&node->list));
+		ASSERT(list_empty(&node->lower));
+		ASSERT(node->eb == NULL);
 		cache->nr_nodes--;
 		btrfs_put_root(node->root);
 		kfree(node);
@@ -340,11 +343,11 @@ static inline void btrfs_backref_drop_node_buffer(
 static inline void btrfs_backref_drop_node(struct btrfs_backref_cache *tree,
 					   struct btrfs_backref_node *node)
 {
-	BUG_ON(!list_empty(&node->upper));
+	ASSERT(list_empty(&node->upper));
 
 	btrfs_backref_drop_node_buffer(node);
-	list_del(&node->list);
-	list_del(&node->lower);
+	list_del_init(&node->list);
+	list_del_init(&node->lower);
 	if (!RB_EMPTY_NODE(&node->rb_node))
 		rb_erase(&node->rb_node, &tree->rb_root);
 	btrfs_backref_free_node(tree, node);
-- 
2.26.2

