Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 624C212308F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfLQPhd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:33 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41518 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfLQPhc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:32 -0500
Received: by mail-qk1-f193.google.com with SMTP id x129so1115857qke.8
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xnA1zMQlWeZ+uUevxR44/u/GVIZqo262LTilixqIXjA=;
        b=AquQ46I+ptPGrDBEVhBEYA9D4pLwymdyqse36HpWS5Ac7obFccVfYNkFcDQj4jj00c
         sZPgjjTaPpLgI7+l7IqQKDJUsyJp1CQKl49xebzkuI7v8RelB+bVXhTM+Sx8m6LQ+VcA
         5l7yLuXq1VfhqSjOVkf2DILsvF1xbhzywO2AEi5vpwxnSSBnODo0gq7xJuTwISSM2V2R
         x2mqbR43ShKXCztn4DciubM9DXKDKxCKHodbTj5ibcKdI23mDfNr8yJD6Mw1vIPpG2tX
         l2ccMA4smmQwP1yhEwhDOC0tKnR03LSOD6Gr8DHE7kDZFaoPK6/sdoG7TaVAMVwl77+G
         Q2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xnA1zMQlWeZ+uUevxR44/u/GVIZqo262LTilixqIXjA=;
        b=dFXcHuchLPlh8bGRvf6LQ4qszCBEUzGPI42WV9gVFVeivE7WFKzBQgNdM4LTTuzTxj
         zsRMCu0oIah3/bS0sMA70mxE1WKy8emAugzgSuC6jPS7Md7HdizZjDP9OPlwRa8bv9qm
         LfdHpRF2/fuU3lbPuXavrdfp8mQ6X3YKGGf0k5ZVryy15C2CZu0JDcRyznvjpMQ2XlyY
         uVQYRaJjOkP0BZ+LVt9+9vg8YnEA2Vr/xRbvWnL5HgsaM6Fihe861vhfvX3OQrL78oTw
         wnc37SHWUyt2HE+GEnaTlk/HbTn3xS9QpWUT/PRv6FSpB6u/pTJe9n/4pRR2V0KjC9iT
         vocg==
X-Gm-Message-State: APjAAAUtnaHzXPJiiczkRd5xUq4tPzbFOqWfm2sVBNsDN07F5Fu3RffV
        +LeGbtgtS3kLVeTTCz0sZJHb1UexnbFwOQ==
X-Google-Smtp-Source: APXvYqzFytTX7t22B2fieS4XZ2zlxxxR7MjNoogiDDQ8Y58hW7AtSDGCRSTDqzlIYPZGMB622IFYpQ==
X-Received: by 2002:a37:7443:: with SMTP id p64mr5626003qkc.460.1576597050431;
        Tue, 17 Dec 2019 07:37:30 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v4sm3245097qtd.24.2019.12.17.07.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 29/45] btrfs: hold a ref on the root in btrfs_recover_relocation
Date:   Tue, 17 Dec 2019 10:36:19 -0500
Message-Id: <20191217153635.44733-30-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We look up the fs root in various places in here when recovering from a
crashed relcoation.  Make sure we hold a ref on the root whenever we
look them up.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4e455703439b..d40d145588f3 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4542,6 +4542,10 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
 			fs_root = read_fs_root(fs_info,
 					       reloc_root->root_key.offset);
+			if (!btrfs_grab_fs_root(fs_root)) {
+				err = -ENOENT;
+				goto out;
+			}
 			if (IS_ERR(fs_root)) {
 				ret = PTR_ERR(fs_root);
 				if (ret != -ENOENT) {
@@ -4553,6 +4557,8 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 					err = ret;
 					goto out;
 				}
+			} else {
+				btrfs_put_fs_root(fs_root);
 			}
 		}
 
@@ -4602,10 +4608,15 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			goto out_free;
 		}
+		if (!btrfs_grab_fs_root(fs_root)) {
+			err = -ENOENT;
+			goto out_free;
+		}
 
 		err = __add_reloc_root(reloc_root);
 		BUG_ON(err < 0); /* -ENOMEM or logic error */
 		fs_root->reloc_root = reloc_root;
+		btrfs_put_fs_root(fs_root);
 	}
 
 	err = btrfs_commit_transaction(trans);
@@ -4637,10 +4648,14 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 	if (err == 0) {
 		/* cleanup orphan inode in data relocation tree */
 		fs_root = read_fs_root(fs_info, BTRFS_DATA_RELOC_TREE_OBJECTID);
-		if (IS_ERR(fs_root))
+		if (IS_ERR(fs_root)) {
 			err = PTR_ERR(fs_root);
-		else
-			err = btrfs_orphan_cleanup(fs_root);
+		} else {
+			if (btrfs_grab_fs_root(fs_root)) {
+				err = btrfs_orphan_cleanup(fs_root);
+				btrfs_put_fs_root(fs_root);
+			}
+		}
 	}
 	return err;
 }
-- 
2.23.0

