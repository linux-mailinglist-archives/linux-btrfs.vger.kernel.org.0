Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227292B2047
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgKMQY3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgKMQY1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:27 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7FDC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:27 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id r7so9309708qkf.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PbhqqATKoIQI2a8Xa4KgbRY2vWlWzmBOUOKoRd562LQ=;
        b=oNknbNY0zPqGe3lBjypvWi4eIZwCIgiTmYonSjKgAfvEssA6Ob0fcnTWZbDCOTJ8m9
         24BzqjEsD4ly1/Dq8AWzKrCJfY068CTPm0/x9+sLZsnb8gf0WNdxt0OQ4PL6R2Np0bNr
         MGc6EwI3pFd3h3t6r0puOQMxfhqoqekTCCkn1B3hVdfdaWYcKvUv3NPPHYdWebCKTVxu
         FdVaZluMddPOxQJd55YbV5sdW1fCYH/RZ2vMXpZDf0yqpZP8m1J/k0bnf2UVGVyBuzVx
         G/NkRIcRufTVMzRJeqZRvi0vwP2Lfcd6cCooIPb1DB/uOcMJrnzPMs+/UbkrQFWBjdld
         wzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PbhqqATKoIQI2a8Xa4KgbRY2vWlWzmBOUOKoRd562LQ=;
        b=i4+xsWJBMgWnc/jLzw1PMPR7/LAsBu1HHKeaSYn4YhEKntwygV1QCDDdLxVb1dV06A
         E0UmM7fA5Z8SHKhMVkRUjn0xaI9m0me43xzfBo+5YIYZqiESRxA34U5fza9T2JtToA9B
         nTFQbaAWkgFqV0psdrnHvHGLXQGX6Tim7e/iYr3jdl+rHhXsE44e9wYmZJRnc3Qpr5W6
         o4NIWsB7+ah3wuL2YkQ2oWdXa+7pJQvv4TLCXVFsBgtjkD4oxfgr7JLNBuxL917ZzVSP
         n6PngUCX31TFjQ74VjFBZ1v7mjy3HQZO/bvdmOzY5jlG5aXeVvH6JHJ8yLyImvEAQuce
         QLmw==
X-Gm-Message-State: AOAM532bDQTq/aIEvfkzcvPqV855pcF5C3q9bXmtlyjrDbSMZT2NU0+N
        SKcKb7etQyFyAg/mhPJH8U8y+I4IBbY0Vw==
X-Google-Smtp-Source: ABdhPJxi6De/3LubKzkdC6KaCTRsll0EAT5/xAa6jFlPpQq1v7HYl5d+YaV7Ru2ZqgivGwM8z2Yx5Q==
X-Received: by 2002:a05:620a:10ac:: with SMTP id h12mr2740888qkk.165.1605284661247;
        Fri, 13 Nov 2020 08:24:21 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e186sm6882278qkd.117.2020.11.13.08.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 25/42] btrfs: handle btrfs_update_reloc_root failure in insert_dirty_subvol
Date:   Fri, 13 Nov 2020 11:23:15 -0500
Message-Id: <d494a0ae10d7c60a73e5b157f1a7fa43d10a57d3.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_update_reloc_root will will return errors in the future, so handle
the error properly in insert_dirty_subvol.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index e3f73ec1476c..16deb9e3f764 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1562,6 +1562,7 @@ static int insert_dirty_subvol(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *reloc_root = root->reloc_root;
 	struct btrfs_root_item *reloc_root_item;
+	int ret;
 
 	/* @root must be a subvolume tree root with a valid reloc tree */
 	ASSERT(root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
@@ -1572,7 +1573,9 @@ static int insert_dirty_subvol(struct btrfs_trans_handle *trans,
 		sizeof(reloc_root_item->drop_progress));
 	btrfs_set_root_drop_level(reloc_root_item, 0);
 	btrfs_set_root_refs(reloc_root_item, 0);
-	btrfs_update_reloc_root(trans, root);
+	ret = btrfs_update_reloc_root(trans, root);
+	if (ret)
+		return ret;
 
 	if (list_empty(&root->reloc_dirty_list)) {
 		btrfs_grab_root(root);
-- 
2.26.2

