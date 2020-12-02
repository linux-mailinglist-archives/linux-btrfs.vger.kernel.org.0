Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901E42CC73C
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389868AbgLBTxm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389866AbgLBTxm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:42 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DB6C061A4D
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:51 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id y197so2473515qkb.7
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AsRjczG2u/IZBO3TnGiSTj7YRPKVYiweycoLH2spsog=;
        b=wEF2DAgs/jbbuJKt/RT1vBRxHvOZlxsvnTLOCphN4fWdFkCln58kDfNQ2yCq8aJUsX
         d+ctjU7OTl/oiTKap3AdSXRerLoFzlURyqpnzMHFcgvAjZpSW9mD2jzUOyGEPVLv1pDp
         hydGMWDzEcWD6FXVIv3W7CMlylYAKLea68weSPjACYzusJ337NPtwVFMXHRl6D8RfB9x
         JuiTlX9/ldyHRAPaFs2EyBVgRxJyJbgkzTWKiSAxMW/qNUGQKn43H5MCwcBbgc0mHukn
         BtYknKfBiYawWhQ3mo+ug4t5fp7EwdAIh8LqaiQtvrUrWzrjRbVGjydNvedTM4bJnI+Z
         RHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AsRjczG2u/IZBO3TnGiSTj7YRPKVYiweycoLH2spsog=;
        b=lGz+uY0RY5Ds5wpYRx2T+UQgsEcM8W3d0zv+wm3VCKzme0qe+KnJUp5vobpqlhhaqs
         JkhqeKiONQrZst5YHOPYYOmNvXM3Iw7RtXkstZhxncRqiXDyPHEmtEw4gkU5kGo06q4j
         7UE3lHF95YwRqaRYSGHzCcxUCOEuZzv1w6lIxqzW8Oh8rbvh9AGrPx/Ny/EGfxPdaMQD
         kwjbrhcQGzgfmgdqojU4FQcRmDQw7pO9pepxNOcAXWuQ8r8y4P5q93mp4NisQD90lRHm
         yKR8Z4XZCq7is0jOLW7q/9fj5fiG4ckA0eWnTtqs3UYOXRTl1NS0U3JruPfUsw4M4iY3
         01zA==
X-Gm-Message-State: AOAM530bVf1Q8FQ1859gbv+iTY3A5VjTNkSn57Ue8QxD+utkxGrUGkGb
        Xj0bgzHXLimhlwmaHtyTGOXnsMFkRjPeEA==
X-Google-Smtp-Source: ABdhPJxgeG0nbKi+En3wyN5IQsT6pJGT6yqtXCbIaeo4PllMWg1HAWS0j0eZUI3sJLZJHI0f0qhFVA==
X-Received: by 2002:ae9:f506:: with SMTP id o6mr4129671qkg.414.1606938770151;
        Wed, 02 Dec 2020 11:52:50 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l46sm3025278qta.44.2020.12.02.11.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:49 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 53/54] btrfs: fix reloc root leak with 0 ref reloc roots on recovery
Date:   Wed,  2 Dec 2020 14:51:11 -0500
Message-Id: <8938404bfb921d70018de363dd006f24f1beefd6.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When recovering a relocation, if we run into a reloc root that has 0
refs we simply add it to the reloc_control->reloc_roots list, and then
clean it up later.  The problem with this is __del_reloc_root() doesn't
do anything if the root isn't in the radix tree, which in this case it
won't be because we never call __add_reloc_root() on the reloc_root.

This exit condition simply isn't correct really.  During normal
operation we can remove ourselves from the rb tree and then we're meant
to clean up later at merge_reloc_roots() time, and this happens
correctly.  During recovery we're depending on free_reloc_roots() to
drop our references, but we're short-circuiting.

Fix this by continuing to check if we're on the list and dropping
ourselves from the reloc_control root list and dropping our reference
appropriately.  Change the corresponding BUG_ON() to an ASSERT() that
does the correct thing if we aren't in the rb tree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 15b6e54394b7..a49a422f2f9b 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -671,9 +671,7 @@ static void __del_reloc_root(struct btrfs_root *root)
 			RB_CLEAR_NODE(&node->rb_node);
 		}
 		spin_unlock(&rc->reloc_root_tree.lock);
-		if (!node)
-			return;
-		BUG_ON((struct btrfs_root *)node->data != root);
+		ASSERT(!node || (struct btrfs_root *)node->data == root);
 	}
 
 	/*
-- 
2.26.2

