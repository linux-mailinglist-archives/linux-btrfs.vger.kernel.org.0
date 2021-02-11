Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFF7318681
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 09:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhBKIta (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Feb 2021 03:49:30 -0500
Received: from eu-shark2.inbox.eu ([195.216.236.82]:58966 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhBKIsw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Feb 2021 03:48:52 -0500
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id D020B45BF14;
        Thu, 11 Feb 2021 10:38:44 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1613032724; bh=ufMZrgozIAfSve7tX+hWmfGwhLTQYAvxrYm7T5zMN2w=;
        h=From:To:Cc:Subject:Date;
        b=TAzKxpJwIKxCyEH+aTQCTE9aVwEXY6fjq18IhYk12hMJkTAAxJNBgD6aXdEgo6m+I
         +2aJ0zIyPUDYwjJnMoIgFt9+RkcTrlHro7KeRNJW8m1dgVeUmRBxfugZpZF3qEM/e+
         At4HiW8WMQlCRt9rwFY1J3BWbLKZ5AKWTZ58BlZE=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id B4B4345BF12;
        Thu, 11 Feb 2021 10:38:44 +0200 (EET)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id 7yCbwQ4sXH_I; Thu, 11 Feb 2021 10:38:44 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 68A8345BF11;
        Thu, 11 Feb 2021 10:38:44 +0200 (EET)
Received: from localhost.localdomain (unknown [117.89.40.51])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 079611BE007B;
        Thu, 11 Feb 2021 10:38:42 +0200 (EET)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su
Subject: [PATCH] btrfs: initialize btrfs_fs_info::csum_size earlier in open_ctree()
Date:   Thu, 11 Feb 2021 16:38:28 +0800
Message-Id: <20210211083828.6835-1-l@damenly.su>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: +d1m5/RSaUCpygHhXwK+CAc2qDRBVfPh+/m/0QE76Hb7Ny6FfEAOURSxgQ4FQH6k
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

User reported that btrfs-progs misc-tests/028-superblock-recover fails:
    [TEST/misc]   028-superblock-recover
unexpected success: mounted fs with corrupted superblock
test failed for case 028-superblock-recover

The test case expects that a broken image with bad superblock will be
rejected to be mounted. However, the test image just passed csum check
of superblock and was successfully mounted.

Commit 55fc29bed8dd ("btrfs: use cached value of fs_info::csum_size
everywhere") replaces all calls to btrfs_super_csum_size by
fs_info::csum_size. The calls include the place where fs_info->csum_size
is not initialized. So btrfs_check_super_csum() passes because memcmp()
with len 0 always returns 0.

Fix it by caching csum size in btrfs_fs_info::csum_size once we know the
csum type in superblock is valid in open_ctree().

Link: https://github.com/kdave/btrfs-progs/issues/250
Fixes: 55fc29bed8dd ("btrfs: use cached value of fs_info::csum_size everywhere")
Signed-off-by: Su Yue <l@damenly.su>
---
 fs/btrfs/disk-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6b35b7e88136..07a2b4f69b10 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3044,6 +3044,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_alloc;
 	}
 
+	fs_info->csum_size = btrfs_super_csum_size(disk_super);
+
 	ret = btrfs_init_csum_hash(fs_info, csum_type);
 	if (ret) {
 		err = ret;
@@ -3161,7 +3163,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	fs_info->nodesize = nodesize;
 	fs_info->sectorsize = sectorsize;
 	fs_info->sectorsize_bits = ilog2(sectorsize);
-	fs_info->csum_size = btrfs_super_csum_size(disk_super);
 	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
 	fs_info->stripesize = stripesize;
 
-- 
2.30.0

