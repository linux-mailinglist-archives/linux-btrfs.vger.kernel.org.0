Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476312EA0A8
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jan 2021 00:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbhADXVK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jan 2021 18:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbhADXVJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jan 2021 18:21:09 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D0BC061793
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jan 2021 15:20:29 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id e2so20077666pgi.5
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Jan 2021 15:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HM40yInyqOESB0bWFHLV1WSaosSDAzFCKSR88/P6UZo=;
        b=stKyu4AAFzusvg9erPYILS7LOO43zc2FYDguIeL7F9MV5+sSKNEn7Sz1JYgS/uIX0Y
         k3bdr/i5S86J9drJ6rZttJ4PjJCZ2qTSaHbRJf6OVHjccCMUZ/lDcye/1BQvrL2/wa4w
         que8KMy2exBpuMwojLixY1diPBEoFGTQ6DlIg3rY2O02nXzEjnI+A5J/fdCBIER3/Cpx
         RBIJlZ9a++lbdr6klxQYh2UyZyawy+alXszU2ap+oSuYeeayr7mZedm3NFIsEpelduQC
         WB7duN3Ji1VoFNtIXvTN226wR4IMYwZQveXnmQbWArQs0pXtnMXCob49m8yggo/yp3NG
         t2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HM40yInyqOESB0bWFHLV1WSaosSDAzFCKSR88/P6UZo=;
        b=LYjVzpPIGJ1u+P1P31rQca6fAHB4U7Og/zpHejMte+CAFtc7ofHVlHkJ8H4JfHK/PM
         TAB5QhUYzH95zC1TKGM9nSBo7jIBCmlr9mHE/h9nRRxW+UGjNSxLdIwNEXmfS0quCQNb
         /XD0AqeWBVN3m6u7+9ecLKH3JqRfB1sPeDfVHwm1Hbj+DZeEXO/zDUEsspAMAMD4GprN
         BWSBXIgD+Xf629+y8h1APj2C9yYsreSG6W93YL6atTq8mpKNX1SW49ememzI6cQI3HqA
         GLE+wzq7J4MkxGKwmZM1PsW4uTHc3fuBgoUIpwLITe4CqqrsQ7ec/tj1S08UtdnqdU9w
         uebw==
X-Gm-Message-State: AOAM533AozpQTxsZmnIidZ1lhHJKAjOw+UXTMVDBVyR9rZoNnN5FDzyM
        wAx+7KA5ko28FonHcehUGvcaDO39BWxy/7QW
X-Google-Smtp-Source: ABdhPJyeykrVZkge7xlozho8X+VHSGmc3QCadaaOtmXc4JUSNwHysTTw40R1Qkqnxsxk5Xcy+nyPfQ==
X-Received: by 2002:a0c:a905:: with SMTP id y5mr79505596qva.55.1609791853305;
        Mon, 04 Jan 2021 12:24:13 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u5sm6276781qkb.120.2021.01.04.12.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 12:24:12 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     stable@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactcode.de>
Subject: [PATCH] btrfs: shrink delalloc pages instead of full inodes
Date:   Mon,  4 Jan 2021 15:24:11 -0500
Message-Id: <270ea622955d197137bf510ba82ec7f7fa0e425c.1609791839.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 38d715f494f2 ("btrfs: use btrfs_start_delalloc_roots in
shrink_delalloc") cleaned up how we do delalloc shrinking by utilizing
some infrastructure we have in place to flush inodes that we use for
device replace and snapshot.  However this introduced a pretty serious
performance regression.  The root cause is because before we would
generally use the normal writeback path to reclaim delalloc space, and
for this we would provide it with the number of pages we wanted to
flush.  The referenced commit changed this to flush that many inodes,
which drastically increased the amount of space we were flushing in
certain cases, which severely affected performance.

We cannot revert this patch unfortunately, because Filipe has another
fix that requires the ability to skip flushing inodes that are being
cloned in certain scenarios, which means we need to keep using our
flushing infrastructure or risk re-introducing the deadlock.

Instead to fix this problem we can go back to providing
btrfs_start_delalloc_roots with a number of pages to flush, and then set
up a writeback_control and utilize sync_inode() to handle the flushing
for us.  This gives us the same behavior we had prior to the fix, while
still allowing us to avoid the deadlock that was fixed by Filipe.  The
user reported reproducer was a simple untarring of a large tarball of
the source code for Firefox.  The results are as follows

5.9	0m54.258s
5.10	1m26.212s
Patch	0m38.800s

We are significantly faster because of the work I did around improving
ENOSPC flushing in 5.10 and 5.11, so reverting to the previous write out
behavior gave us a pretty big boost.

CC: stable@vger.kernel.org # 5.10
Reported-by: René Rebe <rene@exactcode.de>
Fixes: 38d715f494f2 ("btrfs: use btrfs_start_delalloc_roots in shrink_delalloc")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c      | 60 +++++++++++++++++++++++++++++++------------
 fs/btrfs/space-info.c |  4 ++-
 2 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 070716650df8..a8e0a6b038d3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9390,7 +9390,8 @@ static struct btrfs_delalloc_work *btrfs_alloc_delalloc_work(struct inode *inode
  * some fairly slow code that needs optimization. This walks the list
  * of all the inodes with pending delalloc and forces them to disk.
  */
-static int start_delalloc_inodes(struct btrfs_root *root, u64 *nr, bool snapshot,
+static int start_delalloc_inodes(struct btrfs_root *root,
+				 struct writeback_control *wbc, bool snapshot,
 				 bool in_reclaim_context)
 {
 	struct btrfs_inode *binode;
@@ -9399,6 +9400,7 @@ static int start_delalloc_inodes(struct btrfs_root *root, u64 *nr, bool snapshot
 	struct list_head works;
 	struct list_head splice;
 	int ret = 0;
+	bool full_flush = wbc->nr_to_write == LONG_MAX;
 
 	INIT_LIST_HEAD(&works);
 	INIT_LIST_HEAD(&splice);
@@ -9427,18 +9429,24 @@ static int start_delalloc_inodes(struct btrfs_root *root, u64 *nr, bool snapshot
 		if (snapshot)
 			set_bit(BTRFS_INODE_SNAPSHOT_FLUSH,
 				&binode->runtime_flags);
-		work = btrfs_alloc_delalloc_work(inode);
-		if (!work) {
-			iput(inode);
-			ret = -ENOMEM;
-			goto out;
-		}
-		list_add_tail(&work->list, &works);
-		btrfs_queue_work(root->fs_info->flush_workers,
-				 &work->work);
-		if (*nr != U64_MAX) {
-			(*nr)--;
-			if (*nr == 0)
+		if (full_flush) {
+			work = btrfs_alloc_delalloc_work(inode);
+			if (!work) {
+				iput(inode);
+				ret = -ENOMEM;
+				goto out;
+			}
+			list_add_tail(&work->list, &works);
+			btrfs_queue_work(root->fs_info->flush_workers,
+					 &work->work);
+		} else {
+			ret = sync_inode(inode, wbc);
+			if (!ret &&
+			    test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
+				     &BTRFS_I(inode)->runtime_flags))
+				ret = sync_inode(inode, wbc);
+			btrfs_add_delayed_iput(inode);
+			if (ret || wbc->nr_to_write <= 0)
 				goto out;
 		}
 		cond_resched();
@@ -9464,18 +9472,29 @@ static int start_delalloc_inodes(struct btrfs_root *root, u64 *nr, bool snapshot
 
 int btrfs_start_delalloc_snapshot(struct btrfs_root *root)
 {
+	struct writeback_control wbc = {
+		.nr_to_write = LONG_MAX,
+		.sync_mode = WB_SYNC_NONE,
+		.range_start = 0,
+		.range_end = LLONG_MAX,
+	};
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	u64 nr = U64_MAX;
 
 	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
 		return -EROFS;
 
-	return start_delalloc_inodes(root, &nr, true, false);
+	return start_delalloc_inodes(root, &wbc, true, false);
 }
 
 int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, u64 nr,
 			       bool in_reclaim_context)
 {
+	struct writeback_control wbc = {
+		.nr_to_write = (nr == U64_MAX) ? LONG_MAX : (unsigned long)nr,
+		.sync_mode = WB_SYNC_NONE,
+		.range_start = 0,
+		.range_end = LLONG_MAX,
+	};
 	struct btrfs_root *root;
 	struct list_head splice;
 	int ret;
@@ -9489,6 +9508,13 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, u64 nr,
 	spin_lock(&fs_info->delalloc_root_lock);
 	list_splice_init(&fs_info->delalloc_roots, &splice);
 	while (!list_empty(&splice) && nr) {
+		/*
+		 * Reset nr_to_write here so we know that we're doing a full
+		 * flush.
+		 */
+		if (nr == U64_MAX)
+			wbc.nr_to_write = LONG_MAX;
+
 		root = list_first_entry(&splice, struct btrfs_root,
 					delalloc_root);
 		root = btrfs_grab_root(root);
@@ -9497,9 +9523,9 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, u64 nr,
 			       &fs_info->delalloc_roots);
 		spin_unlock(&fs_info->delalloc_root_lock);
 
-		ret = start_delalloc_inodes(root, &nr, false, in_reclaim_context);
+		ret = start_delalloc_inodes(root, &wbc, false, in_reclaim_context);
 		btrfs_put_root(root);
-		if (ret < 0)
+		if (ret < 0 || wbc.nr_to_write <= 0)
 			goto out;
 		spin_lock(&fs_info->delalloc_root_lock);
 	}
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 67e55c5479b8..e8347461c8dd 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -532,7 +532,9 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 
 	loops = 0;
 	while ((delalloc_bytes || dio_bytes) && loops < 3) {
-		btrfs_start_delalloc_roots(fs_info, items, true);
+		u64 nr_pages = min(delalloc_bytes, to_reclaim) >> PAGE_SHIFT;
+
+		btrfs_start_delalloc_roots(fs_info, nr_pages, true);
 
 		loops++;
 		if (wait_ordered && !trans) {
-- 
2.26.2

