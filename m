Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C834027C31
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2019 13:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbfEWLv3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 May 2019 07:51:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:56816 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730525AbfEWLv3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 May 2019 07:51:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E0A2AD17
        for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2019 11:51:28 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Remove unnecessary check from join_running_log_trans
Date:   Thu, 23 May 2019 14:51:26 +0300
Message-Id: <20190523115126.10532-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

join_running_log_trans checks btrfs_root::log_root outside of
btrfs_root::log_mutex to avoid contention on the mutex. Turns out this
check is not necessary because the two callers of join_running_log_trans
(both of which deal with removing entries from the tree-log during
unlink) explicitly check whether the respective inode has been logged in
the current transaction. If it hasn't then it won't have any items in
the tree-log and call path will return before calling
join_running_log_trans. If the check passes, however, then it's
guaranteed that btrfs_root::log_root is set because the inode is logged.

Those guarantees allows us to remove the speculative as well as the
implicity and tricky memory barrier. No functionl changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

I have evaluated if there is any performance impact (there isn't one). Here's
the script used: 

for i in {1..10}; do
	echo "Testun run : $i"
	time ./ltp/fsstress -d /media/scratch/ -p5 -n 100000 -z -fcreat=100 -f write=100 -f fsync=70 -f unlink=80
	rm -rf /media/scratch/*
	echo "Executions of join_running_trans : $(trace-cmd show | wc -l)"
	trace-cmd clear
done

And the result :

			Unpatched (Sys)  Unpatched (Real)  Unpatched (JRT exec)    Patched (Sys)  Patched(Real)  Patched (JRT exec)
			161              387               153215                  183                   393             149153
			165              392               158490                  159                   404             158118
			140              381               147707                  145                   373             145676
			143              394               147129                  148                   383             131029
			206              410               157987                  152                   383             136134
			152              376               157771                  143                   387             131048
			140              371               153929                  146                   376             149885
			149              376               152723                  207                   407             147477
			164              396               157385                  160                   393             155272
			146              373               147937                  148                   384             152828

stddev     19.75             12.44             4525                    20.5                  11.06           9722
mean       156.6             385.6             153427.3                159.1                 388.3           145662
median     150.5             384               153572                  150                   385.5           148315


JRT exec means executions of join_running_transaction during that iteration of
the test case. 

 fs/btrfs/tree-log.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6c47f6ed3e94..6c8aff105b0c 100644
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

