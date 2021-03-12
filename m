Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D122E33984F
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbhCLU0k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbhCLU0N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:13 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1C2C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:13 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id m7so4836375qtq.11
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=q1dbXkCl5T04l8kQjp3OaynvG1yvO/2YEvX/tUF9PyI=;
        b=ZXaEfVO+zBZZM2lDMaTas/tAJaHBae5fdv3ieiUaUMw0XLyt0INC3DXLHqdKTnEFqq
         geiJFzMg1YRBQAm6I6NmTdYOCysGC99RSw1Ez4fRL5uRvzUiXzSX5Ao3Ha+JSd8nO/Iy
         XrY880tgGcBlILl9J2V4X3pVtBElJSWpWzkDh4Qy/cdVxuclwgA9guAWRu+HBwUwEshd
         8Zu97bb9SgDd+VHwlrKVt3CL7xkUR65230V6FPXzJ3O7nWOngDl2PqTjFhoc6Z0DcYIB
         UbnmpQXj6SWUICsCGek1nZadbkUA8fYEahi7+a1XyD7++0FoeinvhP7tncxbWwJxmjbc
         C3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q1dbXkCl5T04l8kQjp3OaynvG1yvO/2YEvX/tUF9PyI=;
        b=sZCFcnq5TjlyjmnH2T/NpdTQ6+sh+zdqE1zz5tet826San8RcOmfK6JO9UKaGXS0rj
         h0K7+ie0Brfh4uODgM9Jfs5nj0//+I4KujciMEPIEjlpj6nfToZFobIM6QAii65H+SWv
         X+uVYjm31DIL6lduSjDROyiJTmc6VFexnN/rNfLBpzBWG0kcjDl13oMAZdJAdCiydG13
         Gsn3tNnee5xbE9+Jfv1j9vngbC6QdhFPgsnoADmTOcuGf3bgUjTcCbkB+j2vJfl6hG10
         w34VP8MRecXcVfawYmngy95Wsvzvkp4aWeF+szJ2UpvXtSVZNtR5PTT2Yfl9QQHEJCep
         d2aQ==
X-Gm-Message-State: AOAM532K6wzBVQxvs5wIbW2nreyVmfPyKfN55jb8xzeJBxshKSNd1NO3
        OAc9URvlOQSLTPvPg5DGBwRDSxA6uad1bx+J
X-Google-Smtp-Source: ABdhPJzpv+07kRIUWntftEIqW81t/tLClYYppzrxJisM5oUWx0BvR21CXJn6X5rtGIJyH21zftB8gQ==
X-Received: by 2002:a05:622a:d2:: with SMTP id p18mr13551052qtw.365.1615580772318;
        Fri, 12 Mar 2021 12:26:12 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d70sm5312361qkg.30.2021.03.12.12.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:12 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v8 23/39] btrfs: handle btrfs_update_reloc_root failure in insert_dirty_subvol
Date:   Fri, 12 Mar 2021 15:25:18 -0500
Message-Id: <76c5e64ff98eaf11ed42976c5f9e77b6987f3d73.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
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
index 2187015fc412..e6f9304d6a29 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1570,6 +1570,7 @@ static int insert_dirty_subvol(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *reloc_root = root->reloc_root;
 	struct btrfs_root_item *reloc_root_item;
+	int ret;
 
 	/* @root must be a subvolume tree root with a valid reloc tree */
 	ASSERT(root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
@@ -1580,7 +1581,9 @@ static int insert_dirty_subvol(struct btrfs_trans_handle *trans,
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

