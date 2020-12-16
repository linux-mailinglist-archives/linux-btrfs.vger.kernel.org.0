Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2360C2DC444
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgLPQ3A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgLPQ27 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:59 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF3BC0619D7
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:35 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id 2so7752214qtt.10
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QQbrd456nBkuUbJ1aFby5rqk1Xys8TS3UaspirWlPYg=;
        b=AuI+mcDO/sg2K4oXSCLT6Rq4Gl4uxg0WO6QXmpKoPmQl1JDEqQL0DuUb+yyHSztn7F
         i1ZaozW3G0zC6HJDoWSFv28u2jIZL90WAwaevIWVkyOnzCGGu1gLvKkRtNygVumknlyJ
         9N7R07TRBvN9o5AJBNKG4JF4GwjtZucI5nNZdM+zicrV+X5KoxpSXtdbdA0ZGukyXKwj
         Y9vXyTmJFA3eezweo+Pf5mL9FLTJM4Q941ZIOaXvgGsrwiXFTc8E5dSL/P6gknqNVI5k
         4WhySusjpNl0fhx+77hiM8BJZhVdKgExc+LIH10SyRle9OQWOaZeLncJR8Ub/1j6KoYz
         CEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QQbrd456nBkuUbJ1aFby5rqk1Xys8TS3UaspirWlPYg=;
        b=cWakJec33ypRJIGHw2/5ejxI1Gfad7n1zyIXIVytZEsDCVKaoenDr0Gl02VJiPDr5R
         LHOeEebtogv9wwNVlPztrNgSnSXnJ289+ULXogjiNyyDrXnphP2cMt0a7cIQ2Rou6ZOg
         M9/bkqAm5WXJegPcMXLs1n0GmQxOQZIyRc/7ioQG8XMswI6fp0t3dAL1BlLtwwKuygrS
         mBT1BLuCks2s44Z3SsExpLehzGuj1eHUU8buAW2mT+MFT4+IB7ToWoNrChXQk2kKWORy
         qGlz9VUZ1kmG4vvEVyoH6el7utMB/B0Ht1RuMcb35+p9PDP4BGBF+qqObz6vNDv9ll+V
         4Vqw==
X-Gm-Message-State: AOAM5322WG/XysA37LnA/nC9XcUaNw8U4YY7LFxwqlnO9qD2U1kViUwL
        LjmtV8iAqhiohKy3m2HbgjIDANlfvaNffgoX
X-Google-Smtp-Source: ABdhPJwra0MsBOlFqlQHKFvcdQ8HyTGycXN1cd1kR2HlZdPyyfUf+r4fuxpOBniEKZG+KTyS26I1BA==
X-Received: by 2002:a05:622a:243:: with SMTP id c3mr43458255qtx.202.1608136054467;
        Wed, 16 Dec 2020 08:27:34 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y15sm1249558qto.51.2020.12.16.08.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 22/38] btrfs: change insert_dirty_subvol to return errors
Date:   Wed, 16 Dec 2020 11:26:38 -0500
Message-Id: <bb1267848319fadcc17031456cfa9cb60f5ab731.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This will be able to return errors in the future, so change it to return
an error and handle the error appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 918fee55bc30..13d5fd74e745 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1566,9 +1566,9 @@ static int find_next_key(struct btrfs_path *path, int level,
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
@@ -1588,6 +1588,7 @@ static void insert_dirty_subvol(struct btrfs_trans_handle *trans,
 		btrfs_grab_root(root);
 		list_add_tail(&root->reloc_dirty_list, &rc->dirty_subvol_roots);
 	}
+	return 0;
 }
 
 static int clean_dirty_subvols(struct reloc_control *rc)
@@ -1789,8 +1790,11 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 out:
 	btrfs_free_path(path);
 
-	if (ret == 0)
-		insert_dirty_subvol(trans, rc, root);
+	if (ret == 0) {
+		ret = insert_dirty_subvol(trans, rc, root);
+		if (ret)
+			btrfs_abort_transaction(trans, ret);
+	}
 
 	if (trans)
 		btrfs_end_transaction_throttle(trans);
-- 
2.26.2

