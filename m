Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0F83F51E3
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 22:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhHWUP4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 16:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbhHWUPz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 16:15:55 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F421AC06175F
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:15:10 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id e14so20608165qkg.3
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4RIjkuDeY3PlmnTFqIEBwtBoE99vXi4w6UmJB3UY2rg=;
        b=WVntmK3fUltCcwT7Nvv6auK9mmABs0rMfMlfI4r1HWsmPHBU6eS6p8CNZcsymFWJlX
         b9kLi2KjYTLIqR/CHPJTL+LvU/fcSPhfC9oufdvz04aPM8X1/tKbUgGTzuMl0rykE2oK
         P7g9wuGzxWeG4Dhj4emJaZHqm9k6JDLrDu1FZhHeNC+uOkoSP/UoUpKNPAVPURTKoWEw
         9xXFuu7lm0MLq/eJ5e9e7zf08rkNo1YzjT5sQpgPOVatgyte3vZHQ2Dw699Az7vEQd6X
         4G0vj/jwyV8IZa2+CBV9KgEGCjJaTZolTxd6igqw7IQ2Q0menckPJcUAJp/8FQLKQmiK
         zwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4RIjkuDeY3PlmnTFqIEBwtBoE99vXi4w6UmJB3UY2rg=;
        b=QnsG8EhJwxvU4+TnIKN+EVk5L34FS9wDsrFj5FJxhmaYsJpMfd47Df0p703ccQWVC7
         TqKZam5gQ0KmZOCCy4fff5726a+7Gnw938n2Fq+9T5mUGOcRk80SXBK1ddMTfQAuzTip
         59vfxhXwx12lFYZ9uYbhrp4iVVa7i3Gc8uR7EqMeRL/OL7145OzFOoFnQeZOVWlyS13r
         3eLv1odbrpLdUSkFCK2Kki18qR8vz6dhHZbCaEypo2VxaknYgd4hta8AtZ5hIbYoLI/D
         ENve7b5MBbJJ7+tYx1NE9+FXxNUtNI+k7//4mjz7MOLYVxcTBp10RuwrK08FINjujXyK
         ksSg==
X-Gm-Message-State: AOAM531S2po54dGnxMNZk41A+bJ0N6czUjmNAKmqK64nK1PCbJ7V2BAl
        0Gno9+ctk+lbff77T5qn3Ap+J5hGMbKOxw==
X-Google-Smtp-Source: ABdhPJxGYMiqe0Ev8DaMq/nq31STlLhiJt6VGmZKogOXuBvO6IwdDyw1/saJDl5f4aCJ/L0vY7Loxg==
X-Received: by 2002:a37:a13:: with SMTP id 19mr23764233qkk.285.1629749709767;
        Mon, 23 Aug 2021 13:15:09 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c22sm860666qtc.89.2021.08.23.13.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 13:15:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 08/10] btrfs-progs: add add_block_group_free_space helper
Date:   Mon, 23 Aug 2021 16:14:53 -0400
Message-Id: <2baa0ddabfc39080848872a7ad4841482ef985e5.1629749291.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629749291.git.josef@toxicpanda.com>
References: <cover.1629749291.git.josef@toxicpanda.com>
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
index 7f589dfe..1e127e31 100644
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

