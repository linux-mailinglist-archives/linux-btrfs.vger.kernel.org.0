Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1163D2D2F8F
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbgLHQ0I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730427AbgLHQ0I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:08 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925B8C0611C5
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:38 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id 7so12326058qtp.1
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VafAFhu13jV10oTVJpICh9ERQ6Z0ZUmUtNXN5qZwDpo=;
        b=Rv8QwBAaDDx7No1VJp21b2uAc0NQVkPF1ZViKtJ+0HXoVIM76yc0bLyFyMUaGhcr+i
         YDUUfnNj66r47uA3O7v3fg8BBEr4pm/mAIiXlIlDB53f7oRluTLZQVj5yvc4Zt5k0rLZ
         6aZG0dt1pOp9ZIwbd/3T4Sy+OXprX005yR8l/ADvGehRPqhEJeFHVbK1wD6hVYotFPL4
         vsGRuLYFcIPxDVjTXWyml1iBKnSDNpU1ajFLLjGmLXW7sNXpyn/EhlvJry3/QHMjFwmz
         OO9iRvMqfiHL9BRfpLWbHL1tROVWBAMWom/SCDiS0d/dVxniqghqqL2JCB0ZII3IaoUI
         8tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VafAFhu13jV10oTVJpICh9ERQ6Z0ZUmUtNXN5qZwDpo=;
        b=N6yGI9EI9OEfK8ZmPOl8Vb83aUBXnfudVwbrfqv5P4aZuvECPhpSsgK0Bb15lrWXtD
         8xRbQegHVQMYq2xFB/2B+SK4TkrweZsD+EhYGGw8DuCo7lvkpKx0XIq/QHkg1eu4inAh
         Zg2g8BolbmAPklXwMctIhk+wnCKAa/S/6JrWXkmrN8UHECmudHY92cTLC+Azj3jX6GqA
         WyuHpBM5VSPsqwwFCoz0ZtTs4DUFrhN2+wYVL9M4td4eFh0gO4S+BBwJpJbbap9bmCX6
         d669IR29lkspF7vw8Qp6D9DdfKuvvFwln9p/pncFAHT37inAHxye+/6uuVO7UzRE41a8
         Tjdg==
X-Gm-Message-State: AOAM5323q5Xp9NRXFwyYWI+BOauG5rcvMFOuGbQgoC4cexq5EYQARqJe
        MGBjFcqY1bJ+6ghBqM8dFWYLzfw0TMZ6MUqA
X-Google-Smtp-Source: ABdhPJzj3om4vT4pNEAc21PvcOtWN8YR+xLq8Tw+olza1JfnJFKZpdHXJEd4zL/b8MyiEouO4eWApw==
X-Received: by 2002:ac8:4801:: with SMTP id g1mr29405083qtq.44.1607444737425;
        Tue, 08 Dec 2020 08:25:37 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n81sm13526736qka.76.2020.12.08.08.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:25:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 44/52] btrfs: handle __add_reloc_root failures in btrfs_recover_relocation
Date:   Tue,  8 Dec 2020 11:23:51 -0500
Message-Id: <591c0c9447f6d82de6ba142cfbf6d7e762382df9.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can already handle errors appropriately from this function, deal with
an error coming from __add_reloc_root appropriately.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index b5d644a87dcf..af9008a71ff4 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4005,7 +4005,12 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		}
 
 		err = __add_reloc_root(reloc_root);
-		BUG_ON(err < 0); /* -ENOMEM or logic error */
+		if (err) {
+			list_add_tail(&reloc_root->root_list, &reloc_roots);
+			btrfs_put_root(fs_root);
+			btrfs_end_transaction(trans);
+			goto out_unset;
+		}
 		fs_root->reloc_root = btrfs_grab_root(reloc_root);
 		btrfs_put_root(fs_root);
 	}
@@ -4220,7 +4225,10 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 		return PTR_ERR(reloc_root);
 
 	ret = __add_reloc_root(reloc_root);
-	BUG_ON(ret < 0);
+	if (ret) {
+		btrfs_put_root(reloc_root);
+		return ret;
+	}
 	new_root->reloc_root = btrfs_grab_root(reloc_root);
 
 	if (rc->create_reloc_tree)
-- 
2.26.2

