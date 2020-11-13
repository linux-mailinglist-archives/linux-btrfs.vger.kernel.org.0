Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DDC2B2046
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgKMQY1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgKMQY0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:26 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE4FC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:25 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id q22so9288087qkq.6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RG9QPgd1Qom/XN1IJ24BjPJDyXVPC2BRWrG6ZomrNeU=;
        b=Ux6tP/2ZOlBsMyZGxG+z/B+v+qo+n5x/4K2WOFnCm/osgvGn+bxn72AEfr1bzz56D5
         ODEd8ldpbJuBOfLB0zPGeWMTAmKLWZmgQI5e7PHyQY9vaEoYOnkuXdX9TVtuxeFtR7D4
         /jzEMKV/rdfhbQzDqgC6SA42BdZyNEDbcuGzyvuQBC69cF0I2m+9AxL8px4EXPrxGJ9c
         7+xS/6MZVEm7W7oM7LNRXOhjPS4BBMjmYi4tYgzFWoEDQl5bZwA0KfA0dxHbAtVfMWRM
         FS2iK1rvbuQWI7EjWndR0GqjG3QQTcKPNsn9v2yqMvRYbNGUGs7nVCUk4hHI2K6HvUhq
         0bTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RG9QPgd1Qom/XN1IJ24BjPJDyXVPC2BRWrG6ZomrNeU=;
        b=qxN8hkYgTH1ed1qJOCBiX6Y51sT0J/iQ2wsVEAKXuH0ek9TIgAnRjzAmZzzDGsiKHo
         cJ+Qnq60DgOslD4/GYXi0cAVJFiqm7W4/ed4mCPIgtzxU/WOKGtFm/bvaiU8wehOq+fY
         D1mgohACTnBUXLVMasSI9z8qWeq+WoUwhTsR499Dbs6DHMZAPuUWKcbHRCPcJdae7NgB
         k/iPtS9iXic1SLOa5ArNLxUb3hgSlzCxtXZiHiPq4V5/Jn+ZtBko93gJ7opgrEtjmZnO
         3bUgw79tipN+54jZ+ahv8dpGRAO4aPy7EMdvLudqnIRm6HhOGUkDkYDqYlIuB0UEDM2S
         +psw==
X-Gm-Message-State: AOAM533C6JwyJRqriUtqGey5qWF12ktgVZtvd8+M6Mm7eQktTe6gLeSO
        NU7n4jHALbMwkuFn+32JJRsV+ywc2uwp8A==
X-Google-Smtp-Source: ABdhPJyV7xijvF6xrlBz8z9oOqnbdxzSzY35kSJhwXIrfF+YAk9LX5div1Yp35CryrzmCOHPfL/lVA==
X-Received: by 2002:a37:408d:: with SMTP id n135mr2746251qka.16.1605284659425;
        Fri, 13 Nov 2020 08:24:19 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u31sm7341354qtu.87.2020.11.13.08.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 24/42] btrfs: change insert_dirty_subvol to return errors
Date:   Fri, 13 Nov 2020 11:23:14 -0500
Message-Id: <73cf2e1c7edb060cb2f2ca0fc1dbc65d80502071.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This will be able to return errors in the future, so change it to return
an error and handle the error appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 2ae1a3816ce5..e3f73ec1476c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1556,9 +1556,9 @@ static int find_next_key(struct btrfs_path *path, int level,
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
@@ -1578,6 +1578,7 @@ static void insert_dirty_subvol(struct btrfs_trans_handle *trans,
 		btrfs_grab_root(root);
 		list_add_tail(&root->reloc_dirty_list, &rc->dirty_subvol_roots);
 	}
+	return 0;
 }
 
 static int clean_dirty_subvols(struct reloc_control *rc)
@@ -1789,8 +1790,13 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 out:
 	btrfs_free_path(path);
 
-	if (err == 0)
-		insert_dirty_subvol(trans, rc, root);
+	if (err == 0) {
+		ret = insert_dirty_subvol(trans, rc, root);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			err = ret;
+		}
+	}
 
 	if (trans)
 		btrfs_end_transaction_throttle(trans);
-- 
2.26.2

