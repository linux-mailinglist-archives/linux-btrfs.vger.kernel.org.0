Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA5391C747
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2019 12:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfENKyv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 May 2019 06:54:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:40858 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726400AbfENKyt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 May 2019 06:54:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 790F9AFCE
        for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2019 10:54:48 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4/8] btrfs: Ensure btrfs_init_dev_replace_tgtdev sees up to date values
Date:   Tue, 14 May 2019 13:54:41 +0300
Message-Id: <20190514105445.23051-5-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514105445.23051-1-nborisov@suse.com>
References: <20190514105445.23051-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_init_dev_replace_tgtdev reads certain values from the source
device (such as commit_total_bytes) which are updated during transaction
commit. Currently this function is called before committing any pending
transaction, leading to possibly reading outdated values. Fix this
by moving the function below the transaction commit, at this point the
exclusive op bit it set hence once transaction is complete the total
size of the device cannot be changed (it's usually changed by
resize/remove ops which are blocked).

Fixes: 9e271ae27e44 ("Btrfs: kernel operation should come after user input has been verified")

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/dev-replace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 7db9057d3d3c..fbf53e996668 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -414,11 +414,6 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 		return -ETXTBSY;
 	}
 
-	ret = btrfs_init_dev_replace_tgtdev(fs_info, tgtdev_name,
-					    src_device, &tgt_device);
-	if (ret)
-		return ret;
-
 	/*
 	 * Here we commit the transaction to make sure commit_total_bytes
 	 * of all the devices are updated.
@@ -432,6 +427,11 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 		return PTR_ERR(trans);
 	}
 
+	ret = btrfs_init_dev_replace_tgtdev(fs_info, tgtdev_name,
+					    src_device, &tgt_device);
+	if (ret)
+		return ret;
+
 	need_unlock = true;
 	down_write(&dev_replace->rwsem);
 	switch (dev_replace->replace_state) {
-- 
2.17.1

