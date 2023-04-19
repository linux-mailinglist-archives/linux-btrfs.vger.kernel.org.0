Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFEA6E83A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjDSVZN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjDSVY5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:24:57 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3346B5FE9
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:27 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id me15so1100039qvb.4
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939465; x=1684531465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYxJwfplDQ982XTUrmfS13Uhz8ITO+4fKZPwQuX5rag=;
        b=rA+gHAOYg7y+cvYFB3umqUzmu5uSXhhGVpnSqopNZ9hlgPBru07Q9x9+VDGHV1wcAU
         lu9SwXMtYdhhD1UF5MLs2iN1NTcAjg0clyqbpargFcB4uF7GNxraso1zBMcNwplgucVE
         evWAebmM+WGBU/d8oly+XgAL7Z4XQ440jVTas5o0J6dOcg1brlPW/7HpZday1WKHv+D2
         78E59yZujCgPMpiz0hcv7IS2epNbmIjzxQiLYwQwjGnu2g0rw0unL4pkdSw+SE33/le+
         3MBEwU3Q+mm2oe2qL851uYqBuUpAw7NgVBmyClrbyqMeSCJYYIrVN/LpqiTwIf8p4tLS
         VRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939465; x=1684531465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYxJwfplDQ982XTUrmfS13Uhz8ITO+4fKZPwQuX5rag=;
        b=TvG85PgUuwZMKInAOgi3dbz1jK7p6wWlfvLy7qYrIH/h8tHxT28zKRVtcerUmYmZWK
         D33zv/jL+Ccz9ICeiYvnQb0t41ti7l6+v29CPCjTweP5zANS+JxXTPTWpO2Z7RBLt/De
         lb/mtWnMPAYoYKICqIOIbzJzAFRJ0JbE5W8a56Mzau8TCpX535g37JaEQQ3Kfpo3VgJY
         smLZzbHlLx50ub18di57VX7atmPNcs8aL2cReF/qJ/E1nIW3jiNYUEkEIouZ68+mUy+d
         itx8kOGvxMim70lUo1Q4ctB5ZxwBwtAF17ihB1muWVcTp1mTVE/h6FjUj57BLdoO56Na
         U9yg==
X-Gm-Message-State: AAQBX9cK5hMJPTmQh+YzDfKvC7BOJ23atfJYr+YGck0vRygDHOhrCiwy
        BXmH/fEK4QUdCOS/KuR8yQuA5f2NW6W8a9lV/WedHQ==
X-Google-Smtp-Source: AKy350ZS/Qixy3j6JE0RK4fXDZQpxmTHqDvp0uewKqelxu1mYwgGxgsIroLPsvtAZXyZW7fgy9BiGg==
X-Received: by 2002:a05:6214:409:b0:5c1:59b9:40b4 with SMTP id z9-20020a056214040900b005c159b940b4mr36316765qvx.48.1681939465169;
        Wed, 19 Apr 2023 14:24:25 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id y19-20020a0cd993000000b005f66296da7bsm208877qvj.94.2023.04.19.14.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:24:24 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/18] btrfs-progs: make reada_for_search static
Date:   Wed, 19 Apr 2023 17:24:00 -0400
Message-Id: <0bce8f5d59f15495ebee3491b7991296728cbef5.1681939316.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681939316.git.josef@toxicpanda.com>
References: <cover.1681939316.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We were using this in cmds/restore.c, however it only does anything if
path->reada is set, and we don't set that in cmds/restore.c.  Remove
this usage of reada_for_search and make the function static.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 cmds/restore.c        | 5 -----
 kernel-shared/ctree.c | 5 +++--
 kernel-shared/ctree.h | 2 --
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/cmds/restore.c b/cmds/restore.c
index 72fc7a07..9fe7b4d2 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -267,9 +267,6 @@ again:
 			continue;
 		}
 
-		if (path->reada)
-			reada_for_search(fs_info, path, level, slot, 0);
-
 		next = read_node_slot(fs_info, c, slot);
 		if (extent_buffer_uptodate(next))
 			break;
@@ -284,8 +281,6 @@ again:
 		path->slots[level] = 0;
 		if (!level)
 			break;
-		if (path->reada)
-			reada_for_search(fs_info, path, level, 0, 0);
 		next = read_node_slot(fs_info, next, 0);
 		if (!extent_buffer_uptodate(next))
 			goto again;
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 35133268..3e1085a0 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -1205,8 +1205,9 @@ static int noinline push_nodes_for_insert(struct btrfs_trans_handle *trans,
 /*
  * readahead one full node of leaves
  */
-void reada_for_search(struct btrfs_fs_info *fs_info, struct btrfs_path *path,
-		      int level, int slot, u64 objectid)
+static void reada_for_search(struct btrfs_fs_info *fs_info,
+			     struct btrfs_path *path, int level, int slot,
+			     u64 objectid)
 {
 	struct extent_buffer *node;
 	struct btrfs_disk_key disk_key;
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 50f97533..2237f3ef 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -929,8 +929,6 @@ int btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 		int level, int slot);
 enum btrfs_tree_block_status btrfs_check_node(struct extent_buffer *buf);
 enum btrfs_tree_block_status btrfs_check_leaf(struct extent_buffer *buf);
-void reada_for_search(struct btrfs_fs_info *fs_info, struct btrfs_path *path,
-		      int level, int slot, u64 objectid);
 struct extent_buffer *read_node_slot(struct btrfs_fs_info *fs_info,
 				   struct extent_buffer *parent, int slot);
 int btrfs_previous_item(struct btrfs_root *root,
-- 
2.40.0

