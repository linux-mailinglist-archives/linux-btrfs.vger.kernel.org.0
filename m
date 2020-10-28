Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7729529D35B
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Oct 2020 22:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgJ1VnD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 17:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbgJ1Vmt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 17:42:49 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6646EC0613CF
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 14:42:49 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r10so585141pgb.10
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 14:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pRWlQf1PcsLnwOjRHE/KkmHwfJ1wqCb0rdyDIMCZWlQ=;
        b=q921MKTL4bYbnmlGljG2O8IXHNyYF+GfloSo1QBVRAKTWLmU0ce+/hkVXNUVytzuZ9
         p1oaGuzuMkc1F3KoRAA4rT4ykk4hKM43sVxdsEoWdyMSvH6UZSelI+badf0WTuORAtPs
         BKGfzpORthCJEmoNHBmBL65UrlLCzDlKjKHwDmBw0K2g5ttSSzH5lHZmKbzl4RKbTZWx
         +KHFO3Twmefj4dsDBlxOUmjCd4E/+upUeGMzQfqBX5R/fMckiTEZDW3iT3/AGsQ+oEKM
         2MP6PuCtJEqxSerzSyhbWOPHUZ9dClN5gcVlLOj6y1aNSZ+AScoJlAr0aIZz5x3WgDLM
         QBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pRWlQf1PcsLnwOjRHE/KkmHwfJ1wqCb0rdyDIMCZWlQ=;
        b=ldr1uYdM7J9q5d1tZSVimWTtrQFjmU7E1TnkL/aRsakJXM0sTSnLwFWJPfI0P5jX76
         O5jzcFa0phm0ZL7aEveS+9XO3EpSosTyrM7G1FA5SZQ/WG+EF3KGe9gpaIHciIfSE4jL
         gZMDKox6JXDSc4W6N43mM3LjyolXWluB6ERQglFERqgsTGAN2CF6HmoGG/tRg+vpYmNS
         DGKunkvQ5JhQ3VmafhfbI1WSQgEM2cjWHOmgrsv4WMYTk0vAU3HNkoBgonDmUgY0xhKV
         vs/Dkx8dM/YTMt1PeDMJi2qzeJPztpMA4pUtDtB2fH6uO7FvySZqwYEKlI7ctb7bFrgP
         s6JA==
X-Gm-Message-State: AOAM531hBGvT/95ZPjUTIkj9dSxnzQFAfqZvdGtp058Mj/vSqasFKMAk
        3LjAaSFdYl8QN808ItLo/nV0wLbEJ5Yv9Q==
X-Google-Smtp-Source: ABdhPJyAbP6msLMc4C4UT4Ojp6vr5xDPNqQ4e50aAX6HqbTRnJNj8ZH2eJ9kKiZmV238w4Tol7IARA==
X-Received: by 2002:a17:90a:b302:: with SMTP id d2mr879260pjr.57.1603921368185;
        Wed, 28 Oct 2020 14:42:48 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::4:9e72])
        by smtp.gmail.com with ESMTPSA id d7sm330901pjx.33.2020.10.28.14.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 14:42:47 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [RFC PATCH] Revert "btrfs: qgroup: return ENOTCONN instead of EINVAL when quotas are not enabled"
Date:   Wed, 28 Oct 2020 14:42:38 -0700
Message-Id: <33ce2f6df841772666ca1cf3a4876b0ff6612983.1603921124.git.osandov@fb.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This reverts commit 8a36e408d40606e21cd4e2dd9601004a67b14868.

At Facebook, we have some userspace code that calls
BTRFS_IOC_QGROUP_CREATE when qgroups may be disabled and specifically
handles EINVAL. When we updated to 5.6, this started failing with the
new error code and broke the application. ENOTCONN is indeed better, but
this is effectively an ABI breakage.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
The userspace code in question is actually unit testing code for our
container system, so it's trivial for us to update that to handle the
new error. However, this may be considered an ABI breakage, so I wanted
to throw this out there and see if anyone thinks this is important
enough to revert.

 fs/btrfs/qgroup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 580899bdb991..50396e85dd92 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1318,7 +1318,7 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
-		ret = -ENOTCONN;
+		ret = -EINVAL;
 		goto out;
 	}
 	member = find_qgroup_rb(fs_info, src);
@@ -1377,7 +1377,7 @@ static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 		return -ENOMEM;
 
 	if (!fs_info->quota_root) {
-		ret = -ENOTCONN;
+		ret = -EINVAL;
 		goto out;
 	}
 
@@ -1443,7 +1443,7 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
-		ret = -ENOTCONN;
+		ret = -EINVAL;
 		goto out;
 	}
 	quota_root = fs_info->quota_root;
@@ -1480,7 +1480,7 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
-		ret = -ENOTCONN;
+		ret = -EINVAL;
 		goto out;
 	}
 
@@ -1531,7 +1531,7 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
-		ret = -ENOTCONN;
+		ret = -EINVAL;
 		goto out;
 	}
 
-- 
2.29.1

