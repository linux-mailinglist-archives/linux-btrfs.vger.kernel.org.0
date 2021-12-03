Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF6D467FCB
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 23:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383384AbhLCWVy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 17:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383382AbhLCWVx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 17:21:53 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966F5C061751
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 14:18:28 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id i9so5002110qki.3
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 14:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Hdk6IGC1r5OdjW/6E849de+YzzXb1kC1ZOVBZF+BkbU=;
        b=7CiBZrHbZK0ZZN73TO2RjM10lkHc9q8WOqqGNJQAT/MtXg/ElJvFHz2EVa1Z3nJ8PN
         nSGQq65dEGuNRM+Pexue1CE5VHWDHgstlvgvYrzGN/PwJtzWsHuMm7vVXIOt/ulkxvnB
         asOcyr1JdlGFwUXqd8pgjfsHzXRBtoMZU75UpGYQe9j0FHuAz2PmJS+/tOubwNFrzeg2
         REdIZIF+4NuFxZvBf2TBnj5A73Rqeuw+maMF8woDB+xf+IdXnQMoAU53kcB5ph9FVva/
         kpZNYA5rW7DqUf6RFJ69kiM9XiBrGjXEisyJl0g9gw6Qgbse6QXa/wkBts+qmTtkuzYR
         otiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hdk6IGC1r5OdjW/6E849de+YzzXb1kC1ZOVBZF+BkbU=;
        b=y81Tnjs7T6jxljZ58PQsTFVIbf+m3VGmluJpDh4Yzm9y6uT34H9FuTQOyspXFwWMoO
         eFWXJpq1MDI1g9mlIzGzwlI0EZZIBTvGrnXKgH3O58ZqXNVafi587PQnqCMmBZMj3FxS
         A41E+RwXszFEB3UPAgRcoPZPSwE5FYTMzRwO5J88KCyPe2NSCKFb+9VbLVqF/zV0LF0c
         HkKh1RKCdIziIWlSpKNhn3YhzgJvdM0/IG6NNpRorwObA7Ph4Kao6c/7Fu9iByGOrkH3
         ZEincf2oluIYDyhiowrtf/h8zeIEa+E1eTfgKuYxh/xv2ZKhudKAdpCqNDDwJY/KI5f+
         OAkg==
X-Gm-Message-State: AOAM5339JfG/Mx19HryKQLoa4aAkliCr0xBvMr2jc+TMCeYvG77t/Gdc
        FT3XxJKnTf2Um8A7dYeRcn97s1QznrRHHA==
X-Google-Smtp-Source: ABdhPJxLYX5rxLup8lnzwb5zih4Ro6RLFx72nuEkAITb1VqagDthx558V9FZKmqI2fbm1LfH+iTlLQ==
X-Received: by 2002:a05:620a:8d4:: with SMTP id z20mr19715219qkz.526.1638569907474;
        Fri, 03 Dec 2021 14:18:27 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y6sm3053524qtn.23.2021.12.03.14.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:18:27 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/18] btrfs: move btrfs_kill_delayed_inode_items into evict
Date:   Fri,  3 Dec 2021 17:18:07 -0500
Message-Id: <108dc02e55b99c09e8544052c9981585693710aa.1638569556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638569556.git.josef@toxicpanda.com>
References: <cover.1638569556.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a special case in btrfs_truncate_inode_items() to call
btrfs_kill_delayed_inode_items() if min_type == 0, which is only called
during evict.

Instead move this out into evict proper, and add some comments because I
erroneously attempted to remove this code altogether without
understanding what we were doing.

Evict is updating the inode only because we only care about making sure
the i_nlink count has hit disk.  If we had pending deletions we don't
want to process those via the delayed inode updates, we simply want to
drop all of them and reclaim the reserved metadata space.  Then from
there the btrfs_truncate_inode_items() will do the work to remove all of
the items as appropriate.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode-item.c |  9 ---------
 fs/btrfs/inode.c      | 12 ++++++++++++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index ee7ac75ed6c8..bc59f80510ad 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -488,15 +488,6 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 	path->reada = READA_BACK;
 
-	/*
-	 * This function is also used to drop the items in the log tree before
-	 * we relog the inode, so if root != BTRFS_I(inode)->root, it means
-	 * it is used to drop the logged items. So we shouldn't kill the delayed
-	 * items.
-	 */
-	if (min_type == 0 && root == inode->root)
-		btrfs_kill_delayed_inode_items(inode);
-
 	key.objectid = ino;
 	key.offset = (u64)-1;
 	key.type = (u8)-1;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index da474791da23..73bb7acf6813 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5226,10 +5226,22 @@ void btrfs_evict_inode(struct inode *inode)
 		goto no_delete;
 	}
 
+	/*
+	 * This makes sure the inode item in tree is uptodate and the space for
+	 * the inode update is released.
+	 */
 	ret = btrfs_commit_inode_delayed_inode(BTRFS_I(inode));
 	if (ret)
 		goto no_delete;
 
+	/*
+	 * This drops any pending insert or delete operations we have for this
+	 * inode.  We could have a delayed dir index deletion queued up, but
+	 * we're removing the inode completely so that'll be taken care of in
+	 * the truncate.
+	 */
+	btrfs_kill_delayed_inode_items(BTRFS_I(inode));
+
 	rsv = btrfs_alloc_block_rsv(fs_info, BTRFS_BLOCK_RSV_TEMP);
 	if (!rsv)
 		goto no_delete;
-- 
2.26.3

