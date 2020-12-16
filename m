Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625ED2DC405
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgLPQXm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgLPQXm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:23:42 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72EDC061285
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:30 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id z9so17593126qtn.4
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mfah3e/U4W8lQNBUIdUhlArMK02nCZywYkh4WS7qFyg=;
        b=DF6n6PSD55BnsLHnHXuIFMXZxMCWnS8j98meF9mUMZ3KlSsrPNlxrZMA8PuGd9IemT
         0YQsPwbqa8Lsy/W4bRsnOCj8vCdmS8PIn+BeXC4vKMgnb1n5rLsTRPodZuvLKDsSTXK1
         iPipfq0/nahFJTWl5XlfoSTcw7cMFfViAwezvDpTY/vJ0KBFNb1+u/l3i1fyHDlHsTj6
         JjB4KPTnrnAUHDGhrl2vCZX34vr5wB+PNhxzHtm04XoiCHrMFcXBHh9EKQp65MUD6DFZ
         SuCz7Ru38Z93z2WFb/o2vuVDV98X+gA+hKzV8TUA3pm7W6tkz3V4cssTfgOBSBUPDOQA
         xjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mfah3e/U4W8lQNBUIdUhlArMK02nCZywYkh4WS7qFyg=;
        b=QqlDqSDav7mOAkBm3zB4jmmTT09CAu8ALYd/jHWlMg8E2QxX/cEg+gMInqvZZklcTe
         R+MPXr02SkNLCbY7nuBJJBmAGytLKVqW4dcC4IPxgMGkTUTBbuhG2fUwBDXXVZF+QAKA
         mFdbSLnwm9559KcqYOKuLa7vhDIwHEoUmnTsWQn8RrF4OvVvQAyGSJ/h4mFg0HxL6Kje
         PqDS7qD2iDFLD+ylrDEMuBM4K8CpEdiM9Vj13arP/559QZ+qf0IsTmMQiv2vFet1Gv9a
         p1rPZ6XiMZZmFNHwhiAckQkj0QkiabP1RZhAszJU+SxfkPSUPb/hmg/TTf7KatXAyPxb
         6X7g==
X-Gm-Message-State: AOAM530kBOdXcRGNXgjwSa5YOXg42etwGB9PNldwTyT5gIRe0DifO9EU
        bnfhXcV3bZCjZo76/lXjJ/luFsDnPOilQksY
X-Google-Smtp-Source: ABdhPJwruYdcNeVDWhjCcFNZATTSjC1oohd8WdLl3RJ6gBicGBgS/xpMoB+ynSXQb2AErZDmTDWLqg==
X-Received: by 2002:ac8:488e:: with SMTP id i14mr41444863qtq.372.1608135749797;
        Wed, 16 Dec 2020 08:22:29 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u26sm1397718qke.57.2020.12.16.08.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:22:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/13] btrfs: add ASSERT()'s for deleting backref cache nodes
Date:   Wed, 16 Dec 2020 11:22:10 -0500
Message-Id: <3fc2e3dd35d339a7251a2ed48af3ba484769002e.1608135557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135557.git.josef@toxicpanda.com>
References: <cover.1608135557.git.josef@toxicpanda.com>
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

