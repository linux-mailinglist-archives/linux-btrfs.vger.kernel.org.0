Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23162240A9E
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 17:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgHJPmv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 11:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgHJPmu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 11:42:50 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70173C061756
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:42:50 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b14so8737263qkn.4
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WMfNRs+RPCRQYK1/j6Tvp3JQa/xhD2WDYrS+eSyC3UE=;
        b=c6tYKeFa3o0fvd8YXJRlqhUPRaHRecBFWraIeRnFgBs/4RA02CFUm4Dil5ueZNpzx8
         lrL2uZDshTv0WwcaMzo5ZD/8xVwrh1uQ3HkIVOmQnyQomicCQv6hIb5j0jMI5RdKo/XD
         wXs8Y4YkbvVF9XvJyLtsZpEedHhtvOKk7+WBDQY4BYrU7iha8YYpjbpFuJsNJdXcTprt
         kUvexV7rUr3EyB3spFVL5uxJmJrXiWaVkFUhKxMHFi75Csp/2G1YAS+5fjZVO6kZoJl6
         HtUZ2yIIoN/GrPNbbQinQY6nNLk7AxRoOHcz3ytUisxECnZwbpU/ae+MEQIJSQpa8qtv
         A9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WMfNRs+RPCRQYK1/j6Tvp3JQa/xhD2WDYrS+eSyC3UE=;
        b=N+zKs+Ao0zn5xsRdu1t/2KgBvVpdUnD+XD8pqibY/YlxyZg5Tokczo8Os5TvfOyAKI
         SdHUZljLmzHE6/HqSCTqoZQmCxRjNCXNs0clb6oyUfX52vFHWemgUUGajlRK9Pe6tSY4
         fWf1gZHLZo3CkitfwBUCBqUWvJY71pBnZi74775P2vlObMXAnyl0UrZPQUA0Dm4oIfot
         PcYgs6Luklt2/Zob/qyycX/RKP24lgpNSo/iRvMjQlF3dDP2xq/rJt5/NB2MX9HdDSpp
         cybvRr4aIcQ+yUblvHNhdfL9nDvGIq/09GKH5ce1WQcyWjyfsHyoud5X4RoKGCNvOi5n
         c7lg==
X-Gm-Message-State: AOAM532PfoRDYkQEmBzfWqTqj7Z1gzncy+tKQmizq0+56NGmXhESknAw
        kM4gow9iNLCG9Per6Kkg6U7NwhoDVZqGgA==
X-Google-Smtp-Source: ABdhPJwg5XzR2RH5in50iuvpnZFdLxEQeRNSydIb/F6IhFTykUzBMtOIoEtvljs1S/HZsTXRB0MYWQ==
X-Received: by 2002:a37:434a:: with SMTP id q71mr24525405qka.363.1597074169118;
        Mon, 10 Aug 2020 08:42:49 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l45sm15202127qtf.11.2020.08.10.08.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 08:42:48 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/17] btrfs: fix potential deadlock in the search ioctl
Date:   Mon, 10 Aug 2020 11:42:27 -0400
Message-Id: <20200810154242.782802-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200810154242.782802-1-josef@toxicpanda.com>
References: <20200810154242.782802-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When I converted the locking over to using a rwsem I got the following
lockdep splat

======================================================
WARNING: possible circular locking dependency detected
5.8.0-rc7-00165-g04ec4da5f45f-dirty #922 Not tainted
------------------------------------------------------
compsize/11122 is trying to acquire lock:
ffff889fabca8768 (&mm->mmap_lock#2){++++}-{3:3}, at: __might_fault+0x3e/0x90

but task is already holding lock:
ffff889fe720fe40 (btrfs-fs-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x39/0x180

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (btrfs-fs-00){++++}-{3:3}:
       down_write_nested+0x3b/0x70
       __btrfs_tree_lock+0x24/0x120
       btrfs_search_slot+0x756/0x990
       btrfs_lookup_inode+0x3a/0xb4
       __btrfs_update_delayed_inode+0x93/0x270
       btrfs_async_run_delayed_root+0x168/0x230
       btrfs_work_helper+0xd4/0x570
       process_one_work+0x2ad/0x5f0
       worker_thread+0x3a/0x3d0
       kthread+0x133/0x150
       ret_from_fork+0x1f/0x30

-> #1 (&delayed_node->mutex){+.+.}-{3:3}:
       __mutex_lock+0x9f/0x930
       btrfs_delayed_update_inode+0x50/0x440
       btrfs_update_inode+0x8a/0xf0
       btrfs_dirty_inode+0x5b/0xd0
       touch_atime+0xa1/0xd0
       btrfs_file_mmap+0x3f/0x60
       mmap_region+0x3a4/0x640
       do_mmap+0x376/0x580
       vm_mmap_pgoff+0xd5/0x120
       ksys_mmap_pgoff+0x193/0x230
       do_syscall_64+0x50/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (&mm->mmap_lock#2){++++}-{3:3}:
       __lock_acquire+0x1272/0x2310
       lock_acquire+0x9e/0x360
       __might_fault+0x68/0x90
       _copy_to_user+0x1e/0x80
       copy_to_sk.isra.32+0x121/0x300
       search_ioctl+0x106/0x200
       btrfs_ioctl_tree_search_v2+0x7b/0xf0
       btrfs_ioctl+0x106f/0x30a0
       ksys_ioctl+0x83/0xc0
       __x64_sys_ioctl+0x16/0x20
       do_syscall_64+0x50/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock#2 --> &delayed_node->mutex --> btrfs-fs-00

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-fs-00);
                               lock(&delayed_node->mutex);
                               lock(btrfs-fs-00);
  lock(&mm->mmap_lock#2);

 *** DEADLOCK ***

1 lock held by compsize/11122:
 #0: ffff889fe720fe40 (btrfs-fs-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x39/0x180

stack backtrace:
CPU: 17 PID: 11122 Comm: compsize Kdump: loaded Not tainted 5.8.0-rc7-00165-g04ec4da5f45f-dirty #922
Hardware name: Quanta Tioga Pass Single Side 01-0030993006/Tioga Pass Single Side, BIOS F08_3A18 12/20/2018
Call Trace:
 dump_stack+0x78/0xa0
 check_noncircular+0x165/0x180
 __lock_acquire+0x1272/0x2310
 lock_acquire+0x9e/0x360
 ? __might_fault+0x3e/0x90
 ? find_held_lock+0x72/0x90
 __might_fault+0x68/0x90
 ? __might_fault+0x3e/0x90
 _copy_to_user+0x1e/0x80
 copy_to_sk.isra.32+0x121/0x300
 ? btrfs_search_forward+0x2a6/0x360
 search_ioctl+0x106/0x200
 btrfs_ioctl_tree_search_v2+0x7b/0xf0
 btrfs_ioctl+0x106f/0x30a0
 ? __do_sys_newfstat+0x5a/0x70
 ? ksys_ioctl+0x83/0xc0
 ksys_ioctl+0x83/0xc0
 __x64_sys_ioctl+0x16/0x20
 do_syscall_64+0x50/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The problem is we're doing a copy_to_user() while holding tree locks,
which can deadlock if we have to do a page fault for the copy_to_user().
This exists even without my locking changes, so it needs to be fixed.
Rework the search ioctl to do the pre-fault and then
copy_to_user_nofault for the copying.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c |  8 ++++----
 fs/btrfs/extent_io.h |  6 +++---
 fs/btrfs/ioctl.c     | 27 ++++++++++++++++++++-------
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 617ea38e6fd7..c15ab6c1897f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5653,9 +5653,9 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 	}
 }
 
-int read_extent_buffer_to_user(const struct extent_buffer *eb,
-			       void __user *dstv,
-			       unsigned long start, unsigned long len)
+int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
+				       void __user *dstv,
+				       unsigned long start, unsigned long len)
 {
 	size_t cur;
 	size_t offset;
@@ -5675,7 +5675,7 @@ int read_extent_buffer_to_user(const struct extent_buffer *eb,
 
 		cur = min(len, (PAGE_SIZE - offset));
 		kaddr = page_address(page);
-		if (copy_to_user(dst, kaddr + offset, cur)) {
+		if (copy_to_user_nofault(dst, kaddr + offset, cur)) {
 			ret = -EFAULT;
 			break;
 		}
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 00a88f2eb5ab..30794ae58498 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -241,9 +241,9 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 void read_extent_buffer(const struct extent_buffer *eb, void *dst,
 			unsigned long start,
 			unsigned long len);
-int read_extent_buffer_to_user(const struct extent_buffer *eb,
-			       void __user *dst, unsigned long start,
-			       unsigned long len);
+int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
+				       void __user *dst, unsigned long start,
+				       unsigned long len);
 void write_extent_buffer_fsid(const struct extent_buffer *eb, const void *src);
 void write_extent_buffer_chunk_tree_uuid(const struct extent_buffer *eb,
 		const void *src);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index bd3511c5ca81..39448556f635 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2086,9 +2086,14 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 		sh.len = item_len;
 		sh.transid = found_transid;
 
-		/* copy search result header */
-		if (copy_to_user(ubuf + *sk_offset, &sh, sizeof(sh))) {
-			ret = -EFAULT;
+		/*
+		 * copy search result header, if we fault loop again so we can
+		 * fault in the pages and -EFAULT there if there's a problem,
+		 * otherwise we'll fault and then copy the buffer in properly
+		 * this next time through
+		 */
+		if (copy_to_user_nofault(ubuf + *sk_offset, &sh, sizeof(sh))) {
+			ret = 0;
 			goto out;
 		}
 
@@ -2096,10 +2101,14 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 
 		if (item_len) {
 			char __user *up = ubuf + *sk_offset;
-			/* copy the item */
-			if (read_extent_buffer_to_user(leaf, up,
-						       item_off, item_len)) {
-				ret = -EFAULT;
+			/* copy the item, same behavior as above, but reset the
+			 * sk_offset so we copy the full thing again.
+			*/
+			if (read_extent_buffer_to_user_nofault(leaf, up,
+							       item_off,
+							       item_len)) {
+				ret = 0;
+				*sk_offset -= sizeof(sh);
 				goto out;
 			}
 
@@ -2184,6 +2193,10 @@ static noinline int search_ioctl(struct inode *inode,
 	key.offset = sk->min_offset;
 
 	while (1) {
+		ret = fault_in_pages_writeable(ubuf, *buf_size - sk_offset);
+		if (ret)
+			break;
+
 		ret = btrfs_search_forward(root, &key, path, sk->min_transid);
 		if (ret != 0) {
 			if (ret > 0)
-- 
2.24.1

