Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D068A3F345E
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 21:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238353AbhHTTMu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 15:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237996AbhHTTMs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 15:12:48 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135A3C061575
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 12:12:10 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id g11so6081687qvd.2
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O6aQeGfWGPdHnV7vwosAMgPpPw6DNRvHyR7lbIIhYSY=;
        b=baD4mn+iL+xcNfocaoRB1hBUvzuirijIJz7cyZ3aOsHPPIqa5Ja55bV2S+CsCQlMrL
         xBRUyYFvOi6ljpuB6qw71jyxE/BxBB7TADbohgnVEwpsZrcZxHbZ1FofYmCA/hV3tcjn
         nVfV2rPgaawuvq0tgvUxa+nei6EyvNoJx123oQs5ouze6nKzkmxp3VIQwGZXCUqjqBsq
         ycqp7vxQXBtyZBL2KBroFN+G3s0X8upypov/wNFIfDd7qwjzBd5MI00zaRmzjKcLPslG
         7h29uEXP1sxPxaKvF6RECW2o1CUp4W1ifA82C5KatNifBdBlWOkvAC1+5VxplKbPmPrr
         7c8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6aQeGfWGPdHnV7vwosAMgPpPw6DNRvHyR7lbIIhYSY=;
        b=MAmsPJCC/SiDNHuxiC1PzUMtSRAT3ZGKZgpykn8dpf2jTOaU/qghlN9OABJLj62q73
         Hq5IoZ+lK26hPQE0nxxylWsyQzRH6/UwJFfEqs1fiRq4OcSedeFP9uckeqkOvcAmFe9g
         6YybovI06VMEijK3sl1L867T7FJpvs4wkz1f/veX1qh2SNtwyBOD09DLtjSr8qI5+qkc
         o0zbmJEUi4Tf+2B+ixEVHqcJHtoDu/lZ19IKSHEkSrqBRw0oqmFeQfhRnGXnLo1MXR3l
         LejBREkUaNsDpy/iAMZUJ27rS27KO7RxNoQRsP6GFQvmc3osBVWs8y+Lvmcar+IY/yNM
         xepw==
X-Gm-Message-State: AOAM532uHGW2UK3aCGR9kPctJLMXTy5t3it2EeNkhRF104VD0ajsoiHO
        ykWH+SNWyNQv6eaa3rW5Y5nLyMCaRR48kQ==
X-Google-Smtp-Source: ABdhPJwbm/TbTWErVHmb0QTRuLz+INtWzSAC1LrcRWD3lUzVmzow2TKBzalExgYOHTTYDEfTDlhBnA==
X-Received: by 2002:ad4:4bb1:: with SMTP id i17mr22229417qvw.12.1629486729050;
        Fri, 20 Aug 2021 12:12:09 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d7sm3013397qth.70.2021.08.20.12.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:12:08 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/9] btrfs-progs: add add_block_group_free_space helper
Date:   Fri, 20 Aug 2021 15:11:55 -0400
Message-Id: <cdabc5351f55f70e9fe1096b4718c6b700157e6a.1629486429.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629486429.git.josef@toxicpanda.com>
References: <cover.1629486429.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This exists in the kernel free-space-tree.c but not in progs.  We need
it to generate the free space items for new block groups, which is
needed when we start creating the free space tree in make_btrfs().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent-tree.c     |  2 ++
 kernel-shared/free-space-tree.c | 26 ++++++++++++++++++++++++++
 kernel-shared/free-space-tree.h |  2 ++
 3 files changed, 30 insertions(+)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 056a9256..b5b43c10 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -2816,6 +2816,8 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans,
 	ret = btrfs_insert_item(trans, extent_root, &key, &bgi, sizeof(bgi));
 	BUG_ON(ret);
 
+	add_block_group_free_space(trans, cache);
+
 	return 0;
 }
 
diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 2edc7fc7..397311c0 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -986,6 +986,32 @@ out:
 	return ret;
 }
 
+int add_block_group_free_space(struct btrfs_trans_handle *trans,
+			       struct btrfs_block_group *block_group)
+{
+	struct btrfs_path *path;
+	int ret;
+
+	if (!btrfs_fs_compat_ro(trans->fs_info, FREE_SPACE_TREE))
+		return 0;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	ret = add_new_free_space_info(trans, block_group, path);
+	if (ret)
+		goto out;
+	ret = __add_to_free_space_tree(trans, block_group, path,
+				       block_group->start,
+				       block_group->length);
+out:
+	btrfs_free_path(path);
+	if (ret)
+		btrfs_abort_transaction(trans, ret);
+	return ret;
+}
+
 int populate_free_space_tree(struct btrfs_trans_handle *trans,
 			     struct btrfs_block_group *block_group)
 {
diff --git a/kernel-shared/free-space-tree.h b/kernel-shared/free-space-tree.h
index 3d32e167..4f6aa5fc 100644
--- a/kernel-shared/free-space-tree.h
+++ b/kernel-shared/free-space-tree.h
@@ -34,5 +34,7 @@ int add_to_free_space_tree(struct btrfs_trans_handle *trans, u64 start,
 int remove_from_free_space_tree(struct btrfs_trans_handle *trans, u64 start,
 				u64 size);
 int btrfs_create_free_space_tree(struct btrfs_fs_info *info);
+int add_block_group_free_space(struct btrfs_trans_handle *trans,
+			       struct btrfs_block_group *block_group);
 
 #endif
-- 
2.26.3

