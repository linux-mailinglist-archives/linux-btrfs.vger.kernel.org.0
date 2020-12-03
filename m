Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0583C2CDD53
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbgLCSXy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731579AbgLCSXx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:23:53 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97860C061A52
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:07 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id dm12so1440812qvb.3
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GNddX/0e9kcBUMopVlzs7hVvBNncJDN40C9lxwqurQ8=;
        b=zhu6/QNN7ftZlFOjMcqfTw+ERm5zTdaX2K+JhyJv+MlMJhr0YsHu6ImgJyuxviKowx
         p+QmeNf94TAItYUXjCl9YVLifpy6k6Ii8R3GdnbcMjjzPaEPuFsRWXkO9QVMiFAneySD
         TmFpIXgkr6Alj89f3cgLWjeapcMkFGtMiFXRqbZkEHh+RiFZQBxhBLqje286IiBwZ9oF
         oq+skhL+N3miZBgTLoL2Jwf2mF2X1eHkp6HglFcNlTu/WPtN/e2239Piew0BjVyC0oDO
         iE0z1SHUw0rsw2xzARhzQZ4SHsjdawD4v9Ni16IPyehltlQfuxSFNVT0rMamM1E99wa9
         BxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GNddX/0e9kcBUMopVlzs7hVvBNncJDN40C9lxwqurQ8=;
        b=mpsHhV1mMyilJ6JFjWjNKZRLthAZQxmLJAq6JHULNu4HZ2jWGtQnkBGF0i5YGr+Gst
         iW9ypYmSOOcW7mVaq1XDeMMSNDmhpB+yB4/kZoxtaJzxRDHQ6M+gSZuqB6mzt5CsgP8Y
         L7CyrFtLmyTf3Brb1FeuFkptIz5RcCXPigMNA0ls7wBQAHPdY+VkzwR3fzRJeUnCe7EB
         bFCgIYhH/8ksn+j4In3eEOWt1LrcRN+tDQbqPVdWhjeXsid9y6vbNwRAtwKcTtiVHaTR
         UkVkDmTKElyZ6NgiLrz9Tr3dRM4oMxUdwhS+0t23adzH/aOhoxP1/7XWSij57VVzKEI7
         DjsQ==
X-Gm-Message-State: AOAM5319D+eEeLtdyZ+mTiZF7o/hCfhcw4ApTXujF0+7OlHQ0MHmamnJ
        tj1uUOZhOUKJQP4NeXjcKTZzhCUjdUEpgWbH
X-Google-Smtp-Source: ABdhPJyoPyLAevg8RlWsihoKE3LSijEuRnus91rccKvvOWVSGD1UrPmNo+cGXgUeY1f6wu3tki4PcQ==
X-Received: by 2002:ad4:4725:: with SMTP id l5mr134070qvz.51.1607019786469;
        Thu, 03 Dec 2020 10:23:06 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l7sm1240650qtc.74.2020.12.03.10.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 03/53] btrfs: modify the new_root highest_objectid under a ref count
Date:   Thu,  3 Dec 2020 13:22:09 -0500
Message-Id: <ed37cf06762e40be2fcebc9359b1c063b32afef4.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu pointed out a bug in one of my error handling patches, which made me
notice that we modify the new_root->highest_objectid _after_ we've
dropped the ref to the new_root.  This could lead to a possible UAF, fix
this by modifying the ->highest_objectid before we drop our reference to
the new_root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 703212ff50a5..f240beed4739 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -717,6 +717,12 @@ static noinline int create_subvol(struct inode *dir,
 	btrfs_record_root_in_trans(trans, new_root);
 
 	ret = btrfs_create_subvol_root(trans, new_root, root, new_dirid);
+	if (!ret) {
+		mutex_lock(&new_root->objectid_mutex);
+		new_root->highest_objectid = new_dirid;
+		mutex_unlock(&new_root->objectid_mutex);
+	}
+
 	btrfs_put_root(new_root);
 	if (ret) {
 		/* We potentially lose an unused inode item here */
@@ -724,10 +730,6 @@ static noinline int create_subvol(struct inode *dir,
 		goto fail;
 	}
 
-	mutex_lock(&new_root->objectid_mutex);
-	new_root->highest_objectid = new_dirid;
-	mutex_unlock(&new_root->objectid_mutex);
-
 	/*
 	 * insert the directory item
 	 */
-- 
2.26.2

