Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE1C2B1006
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgKLVUC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgKLVUB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:20:01 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76545C0613D1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:01 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id u4so6879907qkk.10
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FD8zBUXOFKKHdWA1gPH8QrHxwAlBg0MsBnJsIbqv84k=;
        b=V8y6qmfyQUkl2c7E82o8NEoxBQRDO0i1XkHFLUVTMshR02HJBA9Tl51YQ3rHG0uep5
         fmbqLf0m5b6crqjl7bCyIiYmd5qNm7A/xyUR9X13rPKPlY2cM9w7VaFkBT3+htJStSuj
         lCw5i05AAYkQYlkcn3iH/NrJhdxM5g8c6lRebgEmNwatsMomdslYMBYFwwQAUJEV4HM6
         K1LucUy6/J4zPvA82xmjg+wWxLqeVltd1WFF9Mr8F6sa3P5xpO5ktLucOFKOVrZOQRqP
         FFOilHah8W03Cx+7b2zRQrVKuhXsPM1qb2nGzlN8wihYZiH5usOOy6GClqj2RtF48oy7
         PICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FD8zBUXOFKKHdWA1gPH8QrHxwAlBg0MsBnJsIbqv84k=;
        b=ZS6WEUJEYmNLv6xP7JuDwu4Eihvof+ARdtGfqjZ8aYAbR3UcJ7qDSwcC3hYImAGhnx
         3AZs/nlJN5Rdo/96cuXqiAxUuC+0r0kEm/42ltae7u3yEeXz86z+jDKbtPGHwU5pJYh4
         vMUz8KurlhLzhYzaRHeWN4QfFVfaffvaDnF2F1SyNbPbaSi0xgUTl2x94Nys0abXKE1Y
         AvOynh9aqNHwyANs+Y0RXQX4epbWZYeO77jf5okxzpenCb/SZVueAHTn9OfYdiOxxSBL
         G5YeB0TkSrKYLcLEPQVLljZ88avxaHQQZ98Ei3Lqi6oMXVFYFRVYXuLIzWDKuFJ4Yr43
         v7Dw==
X-Gm-Message-State: AOAM531Qu+YwbDfqaPWztGmxVncCO20T20ppDs5kxBIdfUX29d6OaGxi
        5hwxjutwon1wO+OJplcwrji1hC4WgxPu9w==
X-Google-Smtp-Source: ABdhPJyOPrDgW/OXB/QErbBjBjTqHu2w7TphWjRuT+9ik2ZvXs3LgCZHBCWxwPKLdvJWQd7y+7xdng==
X-Received: by 2002:a37:4692:: with SMTP id t140mr1886945qka.275.1605215999436;
        Thu, 12 Nov 2020 13:19:59 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p72sm5791897qke.110.2020.11.12.13.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:58 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 24/42] btrfs: change insert_dirty_subvol to return errors
Date:   Thu, 12 Nov 2020 16:18:51 -0500
Message-Id: <353dbca3af54e9f485f1aa9c9ae3501ff19b2952.1605215646.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This will be able to return errors in the future, so change it to return
an error and handle the error appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d61dc2b1928c..5174f5b2765e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1575,9 +1575,9 @@ static int find_next_key(struct btrfs_path *path, int level,
 /*
  * Insert current subvolume into reloc_control::dirty_subvol_roots
  */
-static void insert_dirty_subvol(struct btrfs_trans_handle *trans,
-				struct reloc_control *rc,
-				struct btrfs_root *root)
+static int insert_dirty_subvol(struct btrfs_trans_handle *trans,
+			       struct reloc_control *rc,
+			       struct btrfs_root *root)
 {
 	struct btrfs_root *reloc_root = root->reloc_root;
 	struct btrfs_root_item *reloc_root_item;
@@ -1597,6 +1597,7 @@ static void insert_dirty_subvol(struct btrfs_trans_handle *trans,
 		btrfs_grab_root(root);
 		list_add_tail(&root->reloc_dirty_list, &rc->dirty_subvol_roots);
 	}
+	return 0;
 }
 
 static int clean_dirty_subvols(struct reloc_control *rc)
@@ -1808,8 +1809,13 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 out:
 	btrfs_free_path(path);
 
-	if (err == 0)
-		insert_dirty_subvol(trans, rc, root);
+	if (err == 0) {
+		ret = insert_dirty_subvol(trans, rc, root);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			err = ret;
+		}
+	}
 
 	if (trans)
 		btrfs_end_transaction_throttle(trans);
-- 
2.26.2

