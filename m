Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A4C44CA55
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhKJURq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbhKJURp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:17:45 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCF2C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:14:57 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id jo22so2618163qvb.13
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aBUk2cArVvEwez5VE+87HZJGc9HIWulLuJzNnuBNwzE=;
        b=Z3LbEDT1ykj4OO5Esc0p8XMdsxxrXMvE582gGb9NsTMIToYRpewfxiAybSsgbuzpJy
         bxYeHVhgYQf0lZYcr3/BDEETWzCOfPzBLuc+QTLCY1ZRalktLQxmuKRQzjgdV8vaKn7H
         l0ibQ++1XkJwUeff8tqsn1XOrHppmI9Jysg5pc0qyeJkQmlY3NyHF4eDR/1zcR1JNRo2
         OP31cx7LhPVLO/6QARTUUHTXl9hwnWVnz0WKOI1+hs3/pzUdWwHNwgjx1nXgt7cNJFMW
         wWKnj1X7+xj+BB1IwzKocml+35KTVBYM3mVK8P2m2WF59nAozLQuCaui64Cq9YSQXzzJ
         LxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aBUk2cArVvEwez5VE+87HZJGc9HIWulLuJzNnuBNwzE=;
        b=UNgykiCMVTYgFEkizhHSimHTkkSEW1n13ksFpH2NdQ4aI6Q/qV6yGlJ5/xkNC+TqKO
         RnDmTg7VlZUqsForcTLtsTuhZzN/kqhsApQeDIypThqdda/4NT9sLK4k7KU/BXY9+PR8
         WkyawhXgRZoYyiMUKeeHL1RIc9yhwz2uRcU5tDuCBo7l7g9LgrPOceaaOzGDYej/JFRG
         rJngTa33UsnB6c5KUHAGDVMcDT6VLTlvxMC/wM+2Lli+i8xLSGZEoJLIZ0LvIhdWT8lx
         DHDTK0KTvF3qX+Icuv54f594+V1W5kN1bkmz+PJqC6U6T7dJR8+tdGPcdomsb3wVvZgc
         dF3g==
X-Gm-Message-State: AOAM531iEIWPXx0d53tSMOt/3tcDkQ59FrNkcX8ltkzACo9sm54x1Raf
        uLu/+RfbyqAuPulTIeL586yg90fCR6vbqg==
X-Google-Smtp-Source: ABdhPJz6BAK2XMwRZt3N0gM9aNg39TOKnyh0kyiVHvXJb9KjkukW2EcrYcX1u+An7MeWHxhwIxvuLw==
X-Received: by 2002:a05:6214:1c8a:: with SMTP id ib10mr1773279qvb.46.1636575296579;
        Wed, 10 Nov 2021 12:14:56 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y14sm483367qta.86.2021.11.10.12.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:14:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 07/30] btrfs-progs: check: fill csum root from all extent roots
Date:   Wed, 10 Nov 2021 15:14:19 -0500
Message-Id: <e35b21635b214b398590dff7093c5d7327d6e8e2.1636575146.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We may have multiple extent roots, so cycle through all of the extent
roots and populate the csum tree based on the content of every extent
root we have in the file system.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/check/main.c b/check/main.c
index 175fe616..5fb28216 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9690,9 +9690,9 @@ out:
 	return ret;
 }
 
-static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans)
+static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans,
+				      struct btrfs_root *extent_root)
 {
-	struct btrfs_root *extent_root = btrfs_extent_root(gfs_info, 0);
 	struct btrfs_root *csum_root;
 	struct btrfs_path path;
 	struct btrfs_extent_item *ei;
@@ -9766,10 +9766,26 @@ static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans)
 static int fill_csum_tree(struct btrfs_trans_handle *trans,
 			  int search_fs_tree)
 {
+	struct btrfs_root *root;
+	struct rb_node *n;
+	int ret;
+
 	if (search_fs_tree)
 		return fill_csum_tree_from_fs(trans);
-	else
-		return fill_csum_tree_from_extent(trans);
+
+	root = btrfs_extent_root(gfs_info, 0);
+	while (1) {
+		ret = fill_csum_tree_from_extent(trans, root);
+		if (ret)
+			break;
+		n = rb_next(&root->rb_node);
+		if (!n)
+			break;
+		root = rb_entry(n, struct btrfs_root, rb_node);
+		if (root->root_key.objectid != BTRFS_EXTENT_TREE_OBJECTID)
+			break;
+	}
+	return ret;
 }
 
 static void free_roots_info_cache(void)
-- 
2.26.3

