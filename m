Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C776134C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 12:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJaLor (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 07:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiJaLoK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 07:44:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EACF00C
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 04:44:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2B42B815F0
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 11:44:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165EDC433D6
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 11:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667216640;
        bh=5oafm8rp5ySajE76Qegl5WWLuwq50zs2xsH+Fab+3xM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sHaGGecKItsszQLuvL73jiI0zRrEOxluWpxlYunpkBTEkQv8uL0aUxrK5AYqBsjiG
         pYu7i5uFauPsqukDpM/BYeylhG0hMIosc6eND2QseHmlBTDRoRng+OrJE7B3gaoTHn
         WJ/EDxT0zJbGyUjDjGyzCebIMswNByvhQvb1LiUrURHG8IRG8N4Sg377bOL6zqEd4O
         5zedLebJJrGyfgoL33TPzu9nIZB2G6W6YruXmaRyNQdWx/3E2/CG+pL+my4Eo61Und
         0RpL2vyvyYKVEAs7bGr4B+/rTxPTFCrGqUxU7kacPQ0ai/cdtAazS8pu6Qc2pY+TmV
         bORwZ05Mzn1sg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix lost file sync on direct IO write with nowait and dsync iocb
Date:   Mon, 31 Oct 2022 11:43:55 +0000
Message-Id: <84cb2eb28538c98cbde50e83a770de476528a4f1.1667215075.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667215075.git.fdmanana@suse.com>
References: <cover.1667215075.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing a direct IO write using a iocb with nowait and dsync set, we
end up not syncing the file once the write completes.

This is because we tell iomap to not call generic_write_sync(), which
would result in calling btrfs_sync_file(), in order to avoid a deadlock
since iomap can call it while we are holding the inode's lock and
btrfs_sync_file() needs to acquire the inode's lock. The deadlock happens
only if the write happens synchronously, when iomap_dio_rw() calls
iomap_dio_complete() before it returns. Instead we do the sync ourselves
at btrfs_do_write_iter().

For a nowait write however we can end up not doing the sync ourselves at
at btrfs_do_write_iter() because the write could have been queued, and
therefore we get -EIOCBQUEUED returned from iomap in such case. That makes
us skip the sync call at btrfs_do_write_iter(), as we don't do it for
any error returned from btrfs_direct_write(). We can't simply do the call
even if -EIOCBQUEUED is returned, since that would block the task waiting
for IO, both for the data since there are bios still in progress as well
as potentially blocking when joining a log transaction and when syncing
the log (writing log trees, super blocks, etc).

So let iomap do the sync call itself and in order to avoid deadlocks for
the case of synchronous writes (without nowait), use __iomap_dio_rw() and
have ourselves call iomap_dio_complete() after unlocking the inode.

A test case will later be sent for fstests, after this is fixed in Linus'
tree.

Fixes: 51bd9563b678 ("btrfs: fix deadlock due to page faults during direct IO reads and writes")
Reported-by: Марк Коренберг <socketpair@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CAEmTpZGRKbzc16fWPvxbr6AfFsQoLmz-Lcg-7OgJOZDboJ+SGQ@mail.gmail.com/
CC: stable@vger.kernel.org # 6.0+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h |  5 ++++-
 fs/btrfs/file.c        | 22 ++++++++++++++++------
 fs/btrfs/inode.c       | 14 +++++++++++---
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 79a9f06c2434..d21c30bf7053 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -526,7 +526,10 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 			       const struct btrfs_ioctl_encoded_io_args *encoded);
 
-ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter, size_t done_before);
+ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter,
+		       size_t done_before);
+struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
+				  size_t done_before);
 
 extern const struct dentry_operations btrfs_dentry_operations;
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 838b3c0ea329..6e2889bc73d8 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1453,6 +1453,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	loff_t endbyte;
 	ssize_t err;
 	unsigned int ilock_flags = 0;
+	struct iomap_dio *dio;
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		ilock_flags |= BTRFS_ILOCK_TRY;
@@ -1513,11 +1514,22 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 * So here we disable page faults in the iov_iter and then retry if we
 	 * got -EFAULT, faulting in the pages before the retry.
 	 */
-again:
 	from->nofault = true;
-	err = btrfs_dio_rw(iocb, from, written);
+	dio = btrfs_dio_write(iocb, from, written);
 	from->nofault = false;
 
+	/*
+	 * iomap_dio_complete() will call btrfs_sync_file() if we have a dsync
+	 * iocb, and that needs to lock the inode. So unlock it before calling
+	 * iomap_dio_complete() to avoid a deadlock.
+	 */
+	btrfs_inode_unlock(inode, ilock_flags);
+
+	if (IS_ERR_OR_NULL(dio))
+		err = PTR_ERR_OR_ZERO(dio);
+	else
+		err = iomap_dio_complete(dio);
+
 	/* No increment (+=) because iomap returns a cumulative value. */
 	if (err > 0)
 		written = err;
@@ -1543,12 +1555,10 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		} else {
 			fault_in_iov_iter_readable(from, left);
 			prev_left = left;
-			goto again;
+			goto relock;
 		}
 	}
 
-	btrfs_inode_unlock(inode, ilock_flags);
-
 	/*
 	 * If 'err' is -ENOTBLK or we have not written all data, then it means
 	 * we must fallback to buffered IO.
@@ -3752,7 +3762,7 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
 	 */
 	pagefault_disable();
 	to->nofault = true;
-	ret = btrfs_dio_rw(iocb, to, read);
+	ret = btrfs_dio_read(iocb, to, read);
 	to->nofault = false;
 	pagefault_enable();
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fd26282edace..b1e7bfd5f525 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8176,13 +8176,21 @@ static const struct iomap_dio_ops btrfs_dio_ops = {
 	.bio_set		= &btrfs_dio_bioset,
 };
 
-ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter, size_t done_before)
+ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter, size_t done_before)
 {
 	struct btrfs_dio_data data;
 
 	return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
-			    IOMAP_DIO_PARTIAL | IOMAP_DIO_NOSYNC,
-			    &data, done_before);
+			    IOMAP_DIO_PARTIAL, &data, done_before);
+}
+
+struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
+				  size_t done_before)
+{
+	struct btrfs_dio_data data;
+
+	return __iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
+			    IOMAP_DIO_PARTIAL, &data, done_before);
 }
 
 static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
-- 
2.35.1

