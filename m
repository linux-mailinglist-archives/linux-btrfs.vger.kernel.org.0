Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C290D3EF90C
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 06:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhHREQd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 00:16:33 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:40326 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhHREQd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 00:16:33 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 1DEE41E006CF;
        Wed, 18 Aug 2021 07:15:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1629260158; bh=QiSVWi96CG8Yca3Qj9gK1fWZSg0WJRSk27dkwFf00Eg=;
        h=From:To:Cc:Subject:Date;
        b=iWMrB0lxcKo1V4RMZ0aS9QXmxyACLv25a8sOufTMKxKAbUJcRrKQeqlXO3Ln3dp5a
         0s/57Dt/zu747NssF4P7eDlLA469mtPBIn3qae3DzFZvf7zV5+/jeswP92115Z1T9c
         ZSb9mIjPq95pGCvFW4TIiQXHzkHQivqnGX6uoA2s=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 14BAF1E006C8;
        Wed, 18 Aug 2021 07:15:58 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id EXLLK4F-4Zle; Wed, 18 Aug 2021 07:15:57 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 921031E006B4;
        Wed, 18 Aug 2021 07:15:57 +0300 (EEST)
Received: from mini.lan (unknown [49.65.73.48])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 73BCA1BE00FE;
        Wed, 18 Aug 2021 07:15:56 +0300 (EEST)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su
Subject: [PATCH] btrfs: update comment for fs_devices::seed_list in btrfs_rm_device
Date:   Wed, 18 Aug 2021 12:15:48 +0800
Message-Id: <20210818041548.5692-1-l@damenly.su>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: 6NpmlYxOGzysiV+lRWetewt38GpVL57oiJmmsm5UnmeDUSOAd1YLVQ6wnnJyRWA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Update it since commit 944d3f9fac61 ("btrfs: switch seed device to
list api") did conversion from fs_devices::seed to fs_devices::seed_list.

Signed-off-by: Su Yue <l@damenly.su>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 70f94b75f25a..fcc2fede9ffc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2203,7 +2203,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 	/*
 	 * In normal cases the cur_devices == fs_devices. But in case
 	 * of deleting a seed device, the cur_devices should point to
-	 * its own fs_devices listed under the fs_devices->seed.
+	 * its own fs_devices listed under the fs_devices->seed_list.
 	 */
 	cur_devices = device->fs_devices;
 	mutex_lock(&fs_devices->device_list_mutex);
-- 
2.30.1

