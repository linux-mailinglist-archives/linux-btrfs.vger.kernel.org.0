Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8347A5B8B4E
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 17:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiINPHF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 11:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiINPGw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 11:06:52 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1B57694D
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:06:51 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id o13so11944421qvw.12
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=2AjHThnE0yn83nW/cdnIYAI/OvmH2ANgBiP0rzjjGR8=;
        b=0d5lxOvFrCeeubJjAt/NlkYHa1uXl80nNoEgbWs2YUyix+RE3qhNu8bKMyjGZVbRp0
         IUvsIhXd01Uwf32tEd9tas0jhPjxiejlDz9T+7MKpm3pC/kIkAMa+KVWyFfnwmGvuESB
         8C7n7VW1NNMp0XDcJ25i5YAet0BTAOlPQWYVzTgqljOhu8lLiXkJxuQH9Rld5lxPVvyr
         9TG8UnnevCSqGG0Pd6wVsp0QcC6j2ELCrT6anvyjInX7qcGF+lbsZFwr5F4hw85TqVHt
         EZ/0OocIEQhJyR8s+Mn1Cn8aVkNpGUPNVEHg4YM4AYgp7kgvrpxe8guVH6CtbJXPQNNm
         KsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2AjHThnE0yn83nW/cdnIYAI/OvmH2ANgBiP0rzjjGR8=;
        b=NhogA/Y4foXoX/6IR+et4/5LJasK6ANfiKfL9ZHj0UzE3mgV+OrcYPTo4CGQlpyQbk
         oekMt0b27puOTmEZl5XO1qe6rNO1kZCD8iGh2Q6xcBL3g8dghvpa8PA3Uo8rD0SD9yt+
         peBrPzPMA/j2iZD2+TFVZj0Xaw9vKNZlIPtDJX5+25ytdqhnN8yOSKoRWkusj6C5kIxX
         2tPAWGz1uUFm0+kxmjue04yO40W6Ax6EDaYbLoc54Mc8ucxy10yT2thxFjvHlMMPEaDD
         6JWNvrdyssqBzL+Zkcd1RT2tBQNfX01KJ3TQy+S8ZP8iMvib0wbVpOp0K9H0p5Luughs
         nqtg==
X-Gm-Message-State: ACgBeo2OK/cRoE7wnuiLPWBFV2/n9vwi9GJ2Db8rsX3zdD/D8csapfj9
        +mXM8tOGURkZl4EeVrsP6e5rwNqtnGfCHw==
X-Google-Smtp-Source: AA6agR79svqG5F0JpaJz0hihMoQLrCsJmdy+yy8VxohsCjqo4oCDoSiZA8/+NWgLvtXPtaet/9z/vw==
X-Received: by 2002:a05:6214:528e:b0:4ac:d1bf:59b4 with SMTP id kj14-20020a056214528e00b004acd1bf59b4mr6017832qvb.3.1663168010341;
        Wed, 14 Sep 2022 08:06:50 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h16-20020ac85850000000b00342f8d4d0basm1773967qth.43.2022.09.14.08.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:06:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/17] btrfs: move btrfs_get_block_group helper out of disk-io.h
Date:   Wed, 14 Sep 2022 11:06:29 -0400
Message-Id: <375729b0fb82db1991d42f26b0853f30a3c9086d.1663167823.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663167823.git.josef@toxicpanda.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
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

This inline helper calls btrfs_fs_compat_ro(), which is defined in
another header.  To avoid weird header dependency problems move this
helper into disk-io.c with the rest of the global root helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 7 +++++++
 fs/btrfs/disk-io.h | 8 +-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a887fe67a2a0..d32aa67f962b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1169,6 +1169,13 @@ struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info, u64 bytenr)
 	return btrfs_global_root(fs_info, &key);
 }
 
+struct btrfs_root *btrfs_block_group_root(struct btrfs_fs_info *fs_info)
+{
+	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE))
+		return fs_info->block_group_root;
+	return btrfs_extent_root(fs_info, 0);
+}
+
 struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 				     u64 objectid)
 {
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 7e545ec09a10..084fbe5768e1 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -72,6 +72,7 @@ struct btrfs_root *btrfs_global_root(struct btrfs_fs_info *fs_info,
 				     struct btrfs_key *key);
 struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 bytenr);
 struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info, u64 bytenr);
+struct btrfs_root *btrfs_block_group_root(struct btrfs_fs_info *fs_info);
 
 void btrfs_free_fs_info(struct btrfs_fs_info *fs_info);
 int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info);
@@ -103,13 +104,6 @@ static inline struct btrfs_root *btrfs_grab_root(struct btrfs_root *root)
 	return NULL;
 }
 
-static inline struct btrfs_root *btrfs_block_group_root(struct btrfs_fs_info *fs_info)
-{
-	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE))
-		return fs_info->block_group_root;
-	return btrfs_extent_root(fs_info, 0);
-}
-
 void btrfs_put_root(struct btrfs_root *root);
 void btrfs_mark_buffer_dirty(struct extent_buffer *buf);
 int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
-- 
2.26.3

