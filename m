Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BED44BBCC
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 07:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhKJGpZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 01:45:25 -0500
Received: from eu-shark1.inbox.eu ([195.216.236.81]:58552 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhKJGpY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 01:45:24 -0500
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 3768F6C007BB;
        Wed, 10 Nov 2021 08:42:36 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1636526556; bh=MfrVvyHU7sSLv28jTUduFdApgBqmOnMmsfMKI6gI26M=;
        h=From:To:Cc:Subject:Date;
        b=E+nTLfaFYqxKFWlEBlwXeKT/xRX4NWV13Y/mbsth27Tq+qohC2KmUB8IfkgYnKmpp
         e3GOCl7Ic74iXIcBPq+hwTZIEEd+z5NGvAkxhKBghOVuIjEIAMS5vlFYtRgBgR3EvT
         2b25s0DAyo2KVtK/rd9vJgvqCnY5RwRgd14PQyKg=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 253C66C007BA;
        Wed, 10 Nov 2021 08:42:36 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id agASggER-j1V; Wed, 10 Nov 2021 08:42:36 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id DF0FC6C007B8;
        Wed, 10 Nov 2021 08:42:35 +0200 (EET)
Received: from localhost.localdomain (unknown [222.95.66.226])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id DC6F81BE00D9;
        Wed, 10 Nov 2021 08:42:34 +0200 (EET)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su
Subject: [PATCH] btrfs: remove unused parameter fs_devices from btrfs_init_workqueues
Date:   Wed, 10 Nov 2021 14:42:17 +0800
Message-Id: <20211110064217.98007-1-l@damenly.su>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: 885mlohMBDehlFinXXncAxpE3Cc6IvGWher6j11F/g/3MCiEf0oFUxGzm3AUPnG6og==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since commit ba8a9d079543 ("Btrfs: delete the entire async bio submission
framework") removed submit workqueues, the parameter fs_devices is not used
anymore.

So remove the parameter, no functional changes.

Signed-off-by: Su Yue <l@damenly.su>
---
 fs/btrfs/disk-io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 847aabb30676..366b2f47f94b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2283,8 +2283,7 @@ static void btrfs_init_qgroup(struct btrfs_fs_info *fs_info)
 	mutex_init(&fs_info->qgroup_rescan_lock);
 }
 
-static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
-		struct btrfs_fs_devices *fs_devices)
+static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 {
 	u32 max_active = fs_info->thread_pool_size;
 	unsigned int flags = WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_UNBOUND;
@@ -3415,7 +3414,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		fs_info->subpage_info = subpage_info;
 	}
 
-	ret = btrfs_init_workqueues(fs_info, fs_devices);
+	ret = btrfs_init_workqueues(fs_info);
 	if (ret) {
 		err = ret;
 		goto fail_sb_buffer;
-- 
2.33.1

