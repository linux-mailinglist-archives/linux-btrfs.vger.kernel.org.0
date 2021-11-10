Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8ECC44CA5C
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhKJUR6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbhKJUR5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:17:57 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9445FC061766
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:08 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id b17so2628069qvl.9
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zXWlqsbvJdBA7V1RQ7p0gyG+qJq1hALP23Ng+qoqb4c=;
        b=3REE7/VvmhKfC49BWOqACgWrEgFh0vJvoxaRZ/Ne46G/PJG5jYxyuLNncVSXLOxCPY
         V3/XUEsSChlMoMoE83HF6lKMU2OIuquUsTIhecuRQQL0cNfULeiydpurR7du4CQccX5x
         7ZYd4xN+sIhj65k7kZ9MG4D2545PXBNTu6XhXUob+9tsxcMAe4lVZEVUp1u5zg100z5G
         mzlal50MqMm9OBg2nPosdsXGHD9wELMRwt7X+udOASwIGz4I/x+csjf5e/jKlG46Hun9
         Exh5pzrxqSiH874WVtBmFOcKDkjRu5OzNunibgDjkO2rOPS7CmfGaLUmsS9k608CfpGc
         pIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zXWlqsbvJdBA7V1RQ7p0gyG+qJq1hALP23Ng+qoqb4c=;
        b=KharFO0KhJHVdlKzY96WyXaRc8UML7U13pptaaIy38JnbFWSFI05uDmi9lYQs2J5hW
         8d8DRHjHu9tTZYhAO3+v2pF1pXz3qqBMHPczrDQiNn1ULr/bunSGsrGqL+xSoC6XSUW5
         Q7GOidv2hfQMtkBIEJwlUafbR5Hn4p5WG5UkyAzax602FLxFRbzpi/4LZr+ggo9NLjsp
         oMzLw68NRR+vnEK4ke7XSzdWyWESGBAr+T8GlVmrNVdWifqiu4hY74zTQFZwgIb9JCxq
         OJYBEs1DpMkxL2efdtwKcFtidB041wEm/n3v0zoKo1zSf0m5pM9wrBgpqqI6qD6jiDB/
         EsJg==
X-Gm-Message-State: AOAM530ZPzzlkrkuMfQ+CriBXlbAYtx+K8DUYzfRze2ZY/Kdoj1JqG+W
        lw1NjHGZjgLCv42AhbSJdbiWLDOGOG311A==
X-Google-Smtp-Source: ABdhPJxnlgqJ7CUPC8QKchFgIe0FdfFRUhmR4pBXeRvonm191ATMW+je8mV7s9waWZGKgax0LsCgcQ==
X-Received: by 2002:a05:6214:2a45:: with SMTP id jf5mr1756509qvb.50.1636575307491;
        Wed, 10 Nov 2021 12:15:07 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o5sm379641qkl.50.2021.11.10.12.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:15:07 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 14/30] btrfs-progs: mkfs: use the btrfs_block_group_root helper
Date:   Wed, 10 Nov 2021 15:14:26 -0500
Message-Id: <dd2016bf86e76b8c7e860d66bc92b724671a0ba9.1636575146.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of accessing the extent root directory for modifying block
groups, use the helper which will do the correct thing based on the
flags of the file system.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 4 ++--
 mkfs/main.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/check/main.c b/check/main.c
index 5fb28216..7735cce1 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9387,6 +9387,7 @@ static int reinit_global_roots(struct btrfs_trans_handle *trans, u64 objectid)
 
 static int reinit_extent_tree(struct btrfs_trans_handle *trans, bool pin)
 {
+	struct btrfs_root *bg_root = btrfs_block_group_root(trans->fs_info);
 	u64 start = 0;
 	int ret;
 
@@ -9460,7 +9461,6 @@ again:
 	while (1) {
 		struct btrfs_block_group_item bgi;
 		struct btrfs_block_group *cache;
-		struct btrfs_root *extent_root = btrfs_extent_root(gfs_info, 0);
 		struct btrfs_key key;
 
 		cache = btrfs_lookup_first_block_group(gfs_info, start);
@@ -9474,7 +9474,7 @@ again:
 		key.objectid = cache->start;
 		key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 		key.offset = cache->length;
-		ret = btrfs_insert_item(trans, extent_root, &key, &bgi,
+		ret = btrfs_insert_item(trans, bg_root, &key, &bgi,
 					sizeof(bgi));
 		if (ret) {
 			fprintf(stderr, "Error adding block group\n");
diff --git a/mkfs/main.c b/mkfs/main.c
index 2c4b7b00..9a57cef8 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -596,7 +596,7 @@ static int cleanup_temp_chunks(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_trans_handle *trans = NULL;
 	struct btrfs_block_group_item *bgi;
-	struct btrfs_root *root = btrfs_extent_root(fs_info, 0);
+	struct btrfs_root *root = btrfs_block_group_root(fs_info);
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	struct btrfs_path path;
-- 
2.26.3

