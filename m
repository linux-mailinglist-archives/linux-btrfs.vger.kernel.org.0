Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D4D240AA1
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 17:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgHJPm5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 11:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgHJPm4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 11:42:56 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADF0C061756
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:42:56 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id l13so4417755qvt.10
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qr5QAMkuQGDGkevrO1MvrkFsLkrhzCq8pAyr802+eXs=;
        b=t63uVOti/BXGmmdJq25geiew22Qu7sAQhcJPI5CfAg3y1YsNwgAXyAgEevGpD3/yNv
         eoIucHEdKZjLWsnfq1o9QFQu1AxNQ/W4BDgPi7nlSzjnbASTkb0yhZtXFBy6No9mx3Dl
         kfufjvC3KcAxta9ae7MHfX6M04i/Fyw9tRl1sxfllGOzEqyoWtQo0UTFa8hxuLiHHO+f
         l2NStXZAN3zMMzNd++EDnvvo8tbJ0YF3tGixSNWupNDunjDkVZynSeFiWIMsSckX0dxC
         +dgpdq2zck16LU2jKDuhb/GeTX0732rp4bqHVAoWinPcm66aMPoFGfpzC5sKIsGSuq25
         D8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qr5QAMkuQGDGkevrO1MvrkFsLkrhzCq8pAyr802+eXs=;
        b=QugBqGbcgVo/MuAOYeuu/jqMfUAVyBzWsxwwenGZVZDNWp73iA35vdmV+36vTufpCA
         rMcaD2QGxu8pJYW0QP1fG52w6s1bxYxC5iXVn9H18DD6A22CGjE9EIO4kkg6yJFTOmzF
         v3UWUSRV9dIYpNEf0nliUkLqP11+AXMNFb29HPGEmJzFcebwGWBDUGG8oYcPhEk7luuB
         /fTxd9ora2V2kayMZTxAAcikLmPLTAHp3dORTBrSVFf8uwHkwUkUnBFeNyvbUSvqolWy
         g+HW+zYNgXGNZKbgM1RbrL0sjtkknzprB/kwrreMbZ4UDt4UjLtPMiPOD4b+yuvfbSGb
         zRuA==
X-Gm-Message-State: AOAM533MVgUcjtRuvcpF8LNbkTh0CMRx8G+PT/oAOCsquwxn/i4bwzY8
        Va7KSdHK67pVumGntoeBVT+aWUpFgkHXkA==
X-Google-Smtp-Source: ABdhPJxTFuX7YddhbZiJeMfWlI7eBlxGvbEoxXGLmzlJFhOvHyedzkSJ0AdRe0x+gaFAT3IqVLyt8g==
X-Received: by 2002:a0c:b599:: with SMTP id g25mr29468684qve.118.1597074175359;
        Mon, 10 Aug 2020 08:42:55 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k31sm16043933qtd.60.2020.08.10.08.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 08:42:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/17] btrfs: set the correct lockdep class for new nodes
Date:   Mon, 10 Aug 2020 11:42:30 -0400
Message-Id: <20200810154242.782802-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200810154242.782802-1-josef@toxicpanda.com>
References: <20200810154242.782802-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When flipping over to the rw_semaphore I noticed I'd get a lockdep splat
in replace_path(), which is weird because we're swapping the reloc root
with the actual target root.  Turns out this is because we're using the
root->root_key.objectid as the root id for the newly allocated tree
block when setting the lockdep class, however we need to be using the
actual owner of this new block, which is saved in owner.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index fa7d83051587..84029851f094 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4522,7 +4522,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		return ERR_PTR(-EUCLEAN);
 	}
 
-	btrfs_set_buffer_lockdep_class(root->root_key.objectid, buf, level);
+	btrfs_set_buffer_lockdep_class(owner, buf, level);
 	btrfs_tree_lock(buf);
 	btrfs_clean_tree_block(buf);
 	clear_bit(EXTENT_BUFFER_STALE, &buf->bflags);
-- 
2.24.1

