Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F48446A00
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbhKEUs6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbhKEUsy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:48:54 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF42C06120D
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:46:12 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id b17so8061699qvl.9
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KWqG04N+0b18rI5H3e90yELKXPTBpkvGbJ/cK8Ilj/A=;
        b=oSW7g/2RTD58nWuo3SwDAhuvT8ae2pSEHwfhXusEAKuuJOmtCOj0DpCACaH1ZVlRwH
         x4agLYe092mZoamlsg7DaUQ8QpZFFM8HNqqjAnBVHZe2QgvOWiNUVKvfy08z8Q96p7FS
         JJSCt2qYf0jMmpWdgiYtRimrdisyx/XhPd3PE/4iJ8t07qYp/ufVJcGNxzsfJYzzE8b+
         cueI92ZM7f++OarDBM/1RGhFCie2zduN3IegTI+4IlQ9oZWtHgHx4xv+XYu9vQ3ZSB+l
         1vl7iXWNOg5wr6VbkicCoq/8qDv50l9RxeB3+BN8SXXsvSkS4uQeMvPKzB90Y6I12IVH
         REBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KWqG04N+0b18rI5H3e90yELKXPTBpkvGbJ/cK8Ilj/A=;
        b=1Fm4ftWxhb95Qgew9mQHM1+eTzdVs1FmqP+pkq3b7BIDis/yS4jA5gC2+MoQ25Z3BZ
         5Vzn9PzENTC8JFemGw4MgV/79WrmRQ6ZxYQDBfTMZvWYepT+9ucqFuDttC0V3psTwrI4
         afSLPX44kEiBfX7HkdDoQVQjx8o2HR3CZ3TWUU//5NlpMBVsvqO+rZ778pEuYSM8O4Cd
         a5jzVxZuhOdwwESTwgzMIbVd6Y0XWK3xSP9YwfBksupiLBtG0JS8P8mEyrlwXEMTwswK
         F17dw1iUNX3vBw36lfwb+TvTuEj4asmyH2bjTx70nenagLHIqLd15dkaIUMUbjlejg7w
         ZOzw==
X-Gm-Message-State: AOAM532zevjEeuMYps8I9X0ODg+ZeHJfOJqQ5UPHCbwfnp88dFY58dnm
        Jpgk7SlJjZoO9V1rC2Y64+MNWTDvTV/fdg==
X-Google-Smtp-Source: ABdhPJwvRJHKUG5jL7lUbS9kDL5Xhlu7F2F65efFw68WzGjfJYYDBsh2Me+mWLkp6cVA4kgsM1Y9jw==
X-Received: by 2002:ad4:5de3:: with SMTP id jn3mr1569481qvb.22.1636145171136;
        Fri, 05 Nov 2021 13:46:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f66sm5929839qkj.76.2021.11.05.13.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:46:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/25] btrfs: do not special case the extent root for switch commit roots
Date:   Fri,  5 Nov 2021 16:45:39 -0400
Message-Id: <1257dfbb2f30bf87f425b8ba3d48d32f2fc0ca1a.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a leftover from when we used to independently swap the extent
root's commit root and the fs tree commit roots.  At the time I simply
changed the helper to a list_add.  There's actually no reason to not add
the extent root to the switch commit root at this point, we don't care
about the order we do the switching since it's all done under the
commit_root_sem.

If we re-mark the extent root dirty after adding it to the
switch_commits list we'll see that BTRFS_ROOT_DIRTY isn't set and then
list_move it back onto the dirty list, and then we'll redo the tree
update and everything will be ok.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 451788400e17..9f03c727aa6a 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1266,9 +1266,8 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 		root = list_entry(next, struct btrfs_root, dirty_list);
 		clear_bit(BTRFS_ROOT_DIRTY, &root->state);
 
-		if (root != fs_info->extent_root)
-			list_add_tail(&root->dirty_list,
-				      &trans->transaction->switch_commits);
+		list_add_tail(&root->dirty_list,
+			      &trans->transaction->switch_commits);
 		ret = update_cowonly_root(trans, root);
 		if (ret)
 			return ret;
@@ -1298,9 +1297,6 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 	if (!list_empty(&fs_info->dirty_cowonly_roots))
 		goto again;
 
-	list_add_tail(&fs_info->extent_root->dirty_list,
-		      &trans->transaction->switch_commits);
-
 	/* Update dev-replace pointer once everything is committed */
 	fs_info->dev_replace.committed_cursor_left =
 		fs_info->dev_replace.cursor_left_last_write_of_item;
-- 
2.26.3

