Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8DD3894FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 20:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhESSFp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 14:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhESSFo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 14:05:44 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49A2C06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 11:04:24 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id k127so13607143qkc.6
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 11:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ikGKTcHskq+7QdMvE0elKpebYCr/uOxuqX3aZEj1cJ0=;
        b=tgbDqcVCsfY8Wa8KoZytptISgmD3lAa1HtCju32FF9TvFqcmZ4qoggbgZJNEAvgGQ/
         ekMoDHCmbB8wTlchHYLlNdWKDv9/0s4l6baY8PzNMAR12t7HZrXkYEQ6E8l1cSTExnnP
         k++z23iCWfKKTYcRiM1zSUrAWDKgUhIPnX1qMDg0ZBxFXe4bAuwkwslxxqm4vg6uR4OT
         AiKFmp1UPLDXk5ZiZsHB8yRoFf7Rj+Kv322MzGh9FFYmz1vHLS4MKonnG0ZWJwI815Eh
         crGdLzOL0Sk8zj2ZRmxxQfjyS9VZic5M4AbcrcpMgiynfac003vcadL38AL1fRQh5uI9
         xJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ikGKTcHskq+7QdMvE0elKpebYCr/uOxuqX3aZEj1cJ0=;
        b=IPUOFSJ2+tWZZOQHU6F4nvKFcOX2ZcloZwhnf7a/9/zn86a3YCGxHPD0HFpNw517yf
         /Vc4RaO6W7H5hoyEVY8a8YWkwhnhPhwhKRi/mRFWJXmTYnEyl3gAxkpzqyon6ORkokHp
         mCVNJZWzsHOYmx/y3fZVwdNeZgsY5z5boW2QlCvs4bztSgy/GNEc9Xz7uECujM9Xl+Lo
         dgTySIzQh+siHDfwJAwU11UXSfuCCwAEiwXRLxvsrtdS7WL9rHT653Ds0HMMcCqSYPYQ
         K5V2VHjPwhgX9ys41zfx5DeyxmqjV2C+fN2c0LXFoHB8a71bPRpdvLf4i2XuAWmRDFc7
         47Yg==
X-Gm-Message-State: AOAM533RZufw5pQaMn9vx5dNPL3Q9t4kESWcikncS6DJr24LDnRmgFBq
        Uu9YWSq3YCb1j7SAKqw3DrYB9BAPZWka2A==
X-Google-Smtp-Source: ABdhPJwtxJXKbZT+RDkxEJ+9sf6lhAC6wCQYxAfmcpFgEgv1BPoYqFlc2NieBwaqL5TUFnsXn/XIpA==
X-Received: by 2002:ae9:f50f:: with SMTP id o15mr663276qkg.445.1621447463609;
        Wed, 19 May 2021 11:04:23 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t187sm289033qkc.56.2021.05.19.11.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 11:04:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: abort in rename_exchange if we fail to insert the second ref
Date:   Wed, 19 May 2021 14:04:21 -0400
Message-Id: <b14ab16d2685978c2d0b1dce7c1a2bb3ad8aa00a.1621447454.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Error injection stress uncovered a problem where we'd leave a dangling
inode ref if we failed during a rename_exchange.  This happens because
we insert the inode ref for one side of the rename, and then for the
other side.  If this second inode ref insert fails we'll leave the first
one dangling and leave a corrupt file system behind.  Fix this by
aborting if we did the insert for the first inode ref.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 32a62ec4f127..a443b0b0de82 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9095,6 +9095,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	int ret2;
 	bool root_log_pinned = false;
 	bool dest_log_pinned = false;
+	bool need_abort = false;
 
 	/* we only allow rename subvolume link between subvolumes */
 	if (old_ino != BTRFS_FIRST_FREE_OBJECTID && root != dest)
@@ -9154,6 +9155,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 					     old_idx);
 		if (ret)
 			goto out_fail;
+		need_abort = true;
 	}
 
 	/* And now for the dest. */
@@ -9169,8 +9171,11 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 					     new_ino,
 					     btrfs_ino(BTRFS_I(old_dir)),
 					     new_idx);
-		if (ret)
+		if (ret) {
+			if (need_abort)
+				btrfs_abort_transaction(trans, ret);
 			goto out_fail;
+		}
 	}
 
 	/* Update inode version and ctime/mtime. */
-- 
2.26.3

