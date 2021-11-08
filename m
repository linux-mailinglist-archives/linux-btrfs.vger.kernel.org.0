Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AA6449C79
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbhKHTaC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbhKHTaB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:30:01 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5BFC061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 11:27:16 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id m17so451840qvx.8
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 11:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aBUk2cArVvEwez5VE+87HZJGc9HIWulLuJzNnuBNwzE=;
        b=wN1PyUCZRDXhcj+R63y+oD5vmjsWMzUFnig+7f9yjznmTFOeycWoGz3JbxC2/n8IqY
         yJV5fdWjC3YB2ibHNwMNvzzfIAy9jHwtxhpqRaaAigDVEz2PLqxZw2fq2yiHQRcR6Yr5
         5onsEQMnHjbSqG/vh1rov+C61hlsToE+q59bjNlS+wZU+m/zEzxn1vWfDmPwdlM8a02w
         RUDeoVm+Ub5VJ5ppdDRYyNxIfisoz9jG1sWkHfYfRgW461lwl+FaW8h5NIjUHGKQMDhQ
         wfcysJ+yddJua7BcJHYDyGtQIyAX8BG9LM90fY1nufxie9Qm48gOttjGbMwcyMqYs+ux
         ZlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aBUk2cArVvEwez5VE+87HZJGc9HIWulLuJzNnuBNwzE=;
        b=PQpfFYZk9vLz9rtXw8LZvQZXn4z9r/H3vC7dLzh2HZcTUvFpwFcI1BXV2T9XKv8nAL
         WqeCoIZn9k/eDSuAST+6QHSR1R2PAz2e6b/DMjCvheakVdoO0eafg25gxMTdnL/LRKNA
         jG3pL7SLlft70XUPc97HOaTBduyp7+588hFPAj2Vhts+WfmsCH9SdM/MjuggZJvDKQ1F
         RmIf0JlgA6AV+dS/x8DduIz+kb9E8TyEyU8kaDzS2pVKjtX0Su1mjUhdhN2zjYVIyAWH
         7GESQC6uKKp5zN5naoDaVn03teZGBic4RBH+Scf8Uib1OAkxNRcr6gQltDGAfZ/gpf/f
         WirQ==
X-Gm-Message-State: AOAM530SlLK/By9OzsdITyBp+vfyfJH8vCt43WZa+lk41cYqUijooJfT
        y3v+lxKxN9+KqyA3XZp82lSYFHsv/1ubhQ==
X-Google-Smtp-Source: ABdhPJywln7xSO0lynT60mJzkqhKrwW1XMTnOMZqBCTmQs0dNLbSY5LMQslnkAbdadwVbJYesO3CxA==
X-Received: by 2002:a05:6214:c8a:: with SMTP id r10mr1682432qvr.38.1636399635598;
        Mon, 08 Nov 2021 11:27:15 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d129sm9960021qkf.136.2021.11.08.11.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:27:14 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 19/20] btrfs-progs: check: fill csum root from all extent roots
Date:   Mon,  8 Nov 2021 14:26:47 -0500
Message-Id: <cca1215d9075019b72a0df6dcc3bc1825d0901b2.1636399482.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636399481.git.josef@toxicpanda.com>
References: <cover.1636399481.git.josef@toxicpanda.com>
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

