Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EDB2D2F97
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbgLHQ0O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbgLHQ0N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:13 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EB1C0619DA
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:12 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id l7so12284385qtp.8
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5tGgAU0fytAuCT9HyuGI8SUEESboZkA97zkxEHIqkMs=;
        b=CMnOnobNj9vJ3C7kAP6lMP7SlKIWxwcowGvy/+OPHXwm1oXGwFG2SJ8C6AuS3RJoTM
         xXQQN1wquB7IkIlVLIftfIpJPPjjjeMpTkfTqVxv66Ziddz2coy6QAZPjyJE103hiyI1
         biAiR1iEUkgxQq/EPR6TOw3PTJO1AxGtIBcslDTTsCIDldt50YI8BNkG/DzO2P389q5X
         OUSH7YbSOmaZmT1Yhf40HiCe85lQ9pyDtojge9iVFZpEaE2zbuVuCaYd+OdcdT94PuQW
         amld6Jj/IuRB9DBMtYphUp9WI3D/ShrzTT3HZGLul8J+QC2M3Wzq41XK91/p2DfZUsZ9
         gaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5tGgAU0fytAuCT9HyuGI8SUEESboZkA97zkxEHIqkMs=;
        b=bfhzGKtwZoktfC05YrtSFSiUzpAAdk7EDGfY3Mw4VXPoffoa95xxn8Wf6/lY5HIQLI
         yS4T991koExsvG6zhbRXvlLE+5LyWC1kFtHPFSnpE61qyEIH1ITuThwJo5tMsU5X8Ft7
         G8oLl2UEdrA+Jg7gdMqqaDyxwMJrw42EeRK2c39Q545pTE1+j1ILfdRwq4CCCn/1J9oZ
         7cMn77Xlj6e7jO1eJvDAZlU6w+NETiQgu2bNGxDM1iAKMRaaauHKe6cmM5jXvg3dXBOh
         VwjOeJ5ttWebGUFAoQLW0rADQ+irkHuScAbl96W3m9lnkdKw2Gi8Ej/PhFZv/HRHTh/b
         2oBw==
X-Gm-Message-State: AOAM530PN9HKJkfPjJbiU+2MInr6iy4GJq6xSy4TyKbEMxdmpUHLibLt
        fBTp00nuzQK1VrdOSQp46jTV2rNT4oqDfCEc
X-Google-Smtp-Source: ABdhPJzC+vUaPjacKpHTuzo662E3u5qQn8XWq+JpqPw0SJrwubSRav7qkMLbz5P1HPs7hQIg1NFqJA==
X-Received: by 2002:aed:2393:: with SMTP id j19mr30416539qtc.23.1607444711902;
        Tue, 08 Dec 2020 08:25:11 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p62sm14220212qkf.50.2020.12.08.08.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:25:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 32/52] btrfs: change insert_dirty_subvol to return errors
Date:   Tue,  8 Dec 2020 11:23:39 -0500
Message-Id: <64a96d50f7bd536840e8ce9f6f6b32a97b4d0262.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
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
index ac5350dfb33a..17bb2bb9a507 100644
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
@@ -1779,8 +1780,11 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
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

