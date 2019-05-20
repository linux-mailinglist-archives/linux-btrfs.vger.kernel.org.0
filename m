Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0A8322E0F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 10:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbfETILp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 04:11:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:51218 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728551AbfETILp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 04:11:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38E85ACE8
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2019 08:11:44 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     fdmanana@suse.com, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Simplify join_running_log_trans
Date:   Mon, 20 May 2019 11:11:42 +0300
Message-Id: <20190520081142.23706-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch removes stray smp_mb before root->log_root from join_running_log_trans
as well as the unlocked check for root->log_root. log_root is only set in
btrfs_add_log_tree, called from start_log_trans under root->log_mutex.
Furthermore, log_root is freed in btrfs_free_log, called from commit_fs_root,
which in turn is called from transaction's critical section (TRANS_COMMIT_DOING).
Those 2 locking invariants ensure join_running_log_trans don't see invalid
values of ->log_root.

Additionally this results in around 26% improvement when deleting 500k files/dir.
All values are in seconds. 

	With Patch (real)	With patch (sys)	Without patch (real)	Without patch (sys)
	    80					78						91						90
		63					62						93						91
		65					64						92						90
		67					65						93						90
		75					73						90						88
		75					73						91						89
		75					73						93						90
		74					73						89						87
		76					74						91						89
stddev	5.76146200581454	5.45690184791497	1.42400062421959	1.22474487139159
mean	72.2222222222222	70.5555555555556	91.4444444444444	89.3333333333333
median  75					73						91						90

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

This passed full xfstest run and the performance results were obtained with the 
following testcase: 

#!/bin/bash
for i in {1..10}; do
    echo "Testun run : %i"
    ./ltp/fsstress -z -d /media/scratch/ -f creat=100 -n 500000
    sync
    time rm -rf /media/scratch/*
    sync
done

 fs/btrfs/tree-log.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6adcd8a2c5c7..61744d8af106 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -188,10 +188,6 @@ static int join_running_log_trans(struct btrfs_root *root)
 {
 	int ret = -ENOENT;
 
-	smp_mb();
-	if (!root->log_root)
-		return -ENOENT;
-
 	mutex_lock(&root->log_mutex);
 	if (root->log_root) {
 		ret = 0;
-- 
2.17.1

