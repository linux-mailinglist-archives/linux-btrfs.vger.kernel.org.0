Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B6E38CF3A
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 22:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhEUUpl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 16:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhEUUpk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 16:45:40 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BB8C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 13:44:13 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id w9so11100880qvi.13
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 13:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9KDK7B0lQQy7BGmsixKOW+ayeQWXqgr32LWV7EFER0M=;
        b=dnPJU/KAqwSfCJE561KLpL8Lvo+ik2HZDk4MRcu9JZPeyNVdtkGqiJCnvD6H99Pw6P
         lPpOLFI51ZVJkbMDboO6DjBX+H432jnSEZev49+AHFY0WJ2pw17QMrzMArvTIjO+C3Xi
         KD5fEmyu55kNgn65PSBexIOgwKicVsrYetssg6l/InkB7dw/C3uO0AEOYvA2LVEdCCsb
         Rn7jeTbdmj1g7mPnxZCRQ/nKyjhVEjW1b65lLdbixODFf689PGl6DdEWu1//bA9yAqP2
         4PgDGVvy11sS0fEQsSeBRtmGbK4iUgkP0Kix61T50qm2p4FPOdfxy9LCaiSkCLaGbv5i
         xpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9KDK7B0lQQy7BGmsixKOW+ayeQWXqgr32LWV7EFER0M=;
        b=E6xpqR+UXxV1q4nk2jgdDcefkF+tNsWMlTDrFzTFeks6cJs4Jrp4bdnSJODvuYQOen
         YlaQjbYPdInkuBymCs+2BxixuIUObbvNBgTwkM+yAAN1x6lZ7LeizKSWbChGSLyaCYK3
         z5UQLXwh87TCyXMTd4P2gY9U23/V/yspzMv3Qm/471/Dp5yrBsAafaeU5ZBjf2yG2aHs
         dXwfFf209LIFa4RmSTwma/6BHWIPqbK8C6OHLKsGTmQ//1gLVI5Sl5glh1vSVJcFm7fY
         nwYB5EOYD0b50QgXyW6hr2PnqeXtB5onBeKcwNI3vzqNPlluOMR7FG47bNCOscFpB3c8
         yb3w==
X-Gm-Message-State: AOAM533GD8Rbj9RYZ4Pd4Q7FXHmbbnW8TA+gR7vNFrMZDG7xjikxkUXU
        iJVzMgkN0zuYj+NAGpGiF23wsVTHuB9Srw==
X-Google-Smtp-Source: ABdhPJy2oNDHJnNPfG6YWIKIB6kOxlmgjos38vjOrxd3Td9iDGSXruGYmE5jrDjFa20FxQjWJWnCjA==
X-Received: by 2002:a05:6214:307:: with SMTP id i7mr15103428qvu.29.1621629852626;
        Fri, 21 May 2021 13:44:12 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a14sm5123845qtj.57.2021.05.21.13.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:44:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/3] btrfs: make btrfs_release_delayed_iref handle the !iref case
Date:   Fri, 21 May 2021 16:44:07 -0400
Message-Id: <713960f1cca61ca61f2f16e6e2e230bde97d7df1.1621629737.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1621629737.git.josef@toxicpanda.com>
References: <cover.1621629737.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Right now we only cleanup the delayed iref if we have
BTRFS_DELAYED_NODE_DEL_IREF set on the node.  However we have some error
conditions that need to cleanup the iref if it still exists, so to make
this code cleaner move the test_bit into btrfs_release_delayed_iref
itself and unconditionally call it in each of the cases instead.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-inode.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 1a88f6214ebc..3ed4ecb49f8a 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -976,12 +976,15 @@ static void btrfs_release_delayed_iref(struct btrfs_delayed_node *delayed_node)
 {
 	struct btrfs_delayed_root *delayed_root;
 
-	ASSERT(delayed_node->root);
-	clear_bit(BTRFS_DELAYED_NODE_DEL_IREF, &delayed_node->flags);
-	delayed_node->count--;
+	if (test_and_clear_bit(BTRFS_DELAYED_NODE_DEL_IREF,
+			       &delayed_node->flags)) {
 
-	delayed_root = delayed_node->root->fs_info->delayed_root;
-	finish_one_item(delayed_root);
+		ASSERT(delayed_node->root);
+		delayed_node->count--;
+
+		delayed_root = delayed_node->root->fs_info->delayed_root;
+		finish_one_item(delayed_root);
+	}
 }
 
 static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
@@ -1024,7 +1027,7 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(leaf);
 
 	if (!test_bit(BTRFS_DELAYED_NODE_DEL_IREF, &node->flags))
-		goto no_iref;
+		goto out;
 
 	path->slots[0]++;
 	if (path->slots[0] >= btrfs_header_nritems(leaf))
@@ -1046,7 +1049,6 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
 	btrfs_del_item(trans, root, path);
 out:
 	btrfs_release_delayed_iref(node);
-no_iref:
 	btrfs_release_path(path);
 err_out:
 	btrfs_delayed_inode_release_metadata(fs_info, node, (ret < 0));
@@ -1898,8 +1900,7 @@ static void __btrfs_kill_delayed_node(struct btrfs_delayed_node *delayed_node)
 		btrfs_release_delayed_item(prev_item);
 	}
 
-	if (test_bit(BTRFS_DELAYED_NODE_DEL_IREF, &delayed_node->flags))
-		btrfs_release_delayed_iref(delayed_node);
+	btrfs_release_delayed_iref(delayed_node);
 
 	if (test_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags)) {
 		btrfs_delayed_inode_release_metadata(fs_info, delayed_node, false);
-- 
2.26.3

