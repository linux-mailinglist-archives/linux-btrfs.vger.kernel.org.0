Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE80528DD10
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Oct 2020 11:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgJNJWJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Oct 2020 05:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730272AbgJNJVz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Oct 2020 05:21:55 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73287C041E51;
        Tue, 13 Oct 2020 20:24:35 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id c6so1032803plr.9;
        Tue, 13 Oct 2020 20:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=08YgLkicvYu2QMyEN9IpZIKEoaxmhCS9+fHx/OZdpbI=;
        b=nmAz3VNNb+gIPg8PAbotb3Pu/rfYLtN+H2qZx6dYG5cyVw+irNPJLEqEKQ38VLp4fX
         2GG2h9CIjevR/WGUEmQt+vjz68i8QtdTp1/NjKZ7Gxberz4Hpm7m6Fvz7RPR/eVvK4nx
         z8SqAVvfxm/UugnH9mvkT7aFbGT0RfNMRnNyN7Ebj3iAPC40vfPySCR542d8+RuaDB7Y
         06AqSZN9B+qalkazY17g/fjdSTZIw2oSSyISLr5JqB+7M52eCwohMs8XNbWCBbXpKKUq
         ZN0DM+KZLRUx3A2SIStIH/pf20InhN10kgzOsejhNw2smfu0kAIDfTYkPsjz+i16fCI+
         V46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=08YgLkicvYu2QMyEN9IpZIKEoaxmhCS9+fHx/OZdpbI=;
        b=d5o2ljyB2Twyjsu86oO5ziecuJqew9cdhK3qAw01gbirpzxr5q+8sDZIdLB1SGYKlu
         cqKaG9IuvRmqJFjMwYkq9LQngJe8yeap1iZB1uiATfa0avKQmKAzEFkfftQBajKL382I
         yEN6KN++iExJhCiVgD3qbdYy95Ek2hvPijrjUTInujHDMdY8WQ7r6I1tDaT4c29XYtxv
         TQcjTEVqoEbF2dU9+ywuiekM7rVfWIup4hXrz5VR76p7auNa5r4IgLAbxKuXyve1k8fY
         uhPfCWLLd8L7JObFyXWtJb+Bp0PCiHyOJ4aIQ2CnQVQq64LU1OxJ8cW6KXJLek68TvfU
         ZHfw==
X-Gm-Message-State: AOAM531o4GUAMXBg3VHtZW7SmV/0Th2n5iZEIVJ2iH5erTEBZ3wLPGLg
        tLEW9IUv39u6nwbxfOKmtA==
X-Google-Smtp-Source: ABdhPJyZcI9qwONYOWp4syLDFF+2Hqqtny7mDfa1eHvD9d6Jn84ZEf5LZS+i/LNqIGZvyX+g6kZbeQ==
X-Received: by 2002:a17:902:7e82:b029:d3:f3b5:d99a with SMTP id z2-20020a1709027e82b02900d3f3b5d99amr2628888pla.7.1602645874989;
        Tue, 13 Oct 2020 20:24:34 -0700 (PDT)
Received: from localhost.localdomain ([8.210.181.200])
        by smtp.gmail.com with ESMTPSA id n15sm463185pgt.75.2020.10.13.20.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 20:24:34 -0700 (PDT)
From:   Pujin Shi <shipujin.t@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pujin Shi <shipujin.t@gmail.com>
Subject: [PATCH] fs: btrfs: Fix incorrect printf qualifier
Date:   Wed, 14 Oct 2020 11:24:19 +0800
Message-Id: <20201014032419.1268-1-shipujin.t@gmail.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch addresses a compile warning:
fs/btrfs/extent-tree.c: In function '__btrfs_free_extent':
fs/btrfs/extent-tree.c:3187:4: warning: format '%lu' expects argument of type 'long unsigned int', but argument 8 has type 'unsigned int' [-Wformat=]

Fixes: 3b7b6ffa4f8f ("btrfs: extent-tree: kill BUG_ON() in __btrfs_free_extent()")
Signed-off-by: Pujin Shi <shipujin.t@gmail.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3b21fee13e77..5fd60b13f4f8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3185,7 +3185,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		struct btrfs_tree_block_info *bi;
 		if (item_size < sizeof(*ei) + sizeof(*bi)) {
 			btrfs_crit(info,
-"invalid extent item size for key (%llu, %u, %llu) owner %llu, has %u expect >= %lu",
+"invalid extent item size for key (%llu, %u, %llu) owner %llu, has %u expect >= %zu",
 				   key.objectid, key.type, key.offset,
 				   owner_objectid, item_size,
 				   sizeof(*ei) + sizeof(*bi));
-- 
2.18.1

