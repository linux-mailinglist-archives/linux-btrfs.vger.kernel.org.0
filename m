Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138BA25C4C9
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 17:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgICPSK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 11:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbgICPRA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 11:17:00 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C34C061244
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Sep 2020 08:16:55 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id p65so2194377qtd.2
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 08:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mBCvytrHjFeK8MCRMtLVJbr0H/ttQE3Wu6G5MDupV5M=;
        b=zQ9cb5fK5CQh2EglDUp7AlLSaUxro4IllhPkHq5r8ELFzFWX2ukzeamxvNHSBCXPAk
         qIt0/5kttblKKOgnJiGO1eeNdPf/Ws18mrVDG/dObhvaHhwbOkO58TWFflJeh3aZA6U/
         pmas+XBjzXp+Gg09rcv3Mj1uJ5QmmxqNRMyP/F+nL2S2Toz6jbRUpgSA0tcihnFjsIgm
         QYjHXVQbRsiYY4ZxjYhWsSYZmfLhM9uivdzz4nOCCN2S32b4PW3rVCk5bMEeFyS3ywFS
         uU/IlYcD5uXCVW/ymdx7WW37217Arpd8H0nhiQ5R8rfT4Hw+AklZx5vf9QxDzvURWYAg
         ecpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mBCvytrHjFeK8MCRMtLVJbr0H/ttQE3Wu6G5MDupV5M=;
        b=O7zxZOo5x3xMmiyaStrbZNAUovSviw6V8L2pry4mhCigSz3wFwyR9GZW5hSRQs104W
         wd1HimeZyduDwKHeOjiR4RJhEnaZpWZNeDPmNWXiOjVxzR8tc6oJTv5vArria5a0sfH6
         nfzTrYYClDsvesUL2p3uZP0PwXNNT/Rd9ga6pG7MqLvcZidnVODx1EQ9a/LDl6gtRjEB
         WzN5fWYbfg64wljBU6rvvTpyFZD988+Dd6/ASozt7qT6Bcjn1anP3PiGDc0L92etUByB
         s0kCaU2haRanoEpIizwuqrffkkaFZBCvS1/N7PtU4FEf7Viss1D5saFh47f3VMmLd+bT
         ncxw==
X-Gm-Message-State: AOAM533rezLz49nDwxfE1Z9Ec5uyVTcY3pijK1ujRmQiY1C4RjHpXdbh
        xnJ1EmC0WUkYp3XCX3pM0gn2QQUwcctVlLew
X-Google-Smtp-Source: ABdhPJzlpv+9Gm8fneTWZ3kmWA2O5VKU4JUVFE/W8D/yOWTHklwqL/zgFl9KSteMv3QEUj79bdXr3g==
X-Received: by 2002:ac8:5d01:: with SMTP id f1mr3913322qtx.299.1599146213746;
        Thu, 03 Sep 2020 08:16:53 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m30sm2267627qtm.46.2020.09.03.08.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 08:16:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: dio iomap DSYNC workaround
Date:   Thu,  3 Sep 2020 11:16:51 -0400
Message-Id: <82c9a7d696fa353738c6998a33b581d76414e4f9.1599146199.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

iomap dio will run generic_write_sync() for us if the iocb is DSYNC.
This is problematic for us because of 2 reason, 1 we hold the
inode_lock() during this operation, and we take it in
generic_write_sync().  Secondly we hold a read lock on the dio_sem but
take the write lock in fsync.

Since we don't want to rip out this code right now, but reworking the
locking is a bit much to do on such short of a notice, work around this
problem with this masterpiece of a patch.

First, we clear DSYNC on the iocb so that the iomap stuff doesn't know
that it needs to handle the sync.  We save this fact in
current->journal_info, because we need to see do special things once
we're in iomap_begin, and we have no way to pass private information
into iomap_dio_rw().

Next we specify a separate iomap_dio_ops for sync, which implements an
->end_io() callback that gets called when the dio completes.  This is
important for AIO, because we really do need to run generic_write_sync()
if we complete asynchronously.  However if we're still in the submitting
context when we enter ->end_io() we clear the flag so that the submitter
knows they're the ones that needs to run generic_write_sync().

This is meant to be temporary.  We need to work out how to eliminate the
inode_lock() and the dio_sem in our fsync and use another mechanism to
protect these operations.

Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c        | 33 ++++++++++++++++++++++
 fs/btrfs/inode.c       | 62 ++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/transaction.h |  1 +
 3 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 2cacb4424cd4..af4eab9cbc51 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2023,7 +2023,40 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		atomic_inc(&BTRFS_I(inode)->sync_writers);
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
+		/*
+		 * 1. We must always clear IOCB_DSYNC in order to not deadlock
+		 *    in iomap, as it calls generic_write_sync() in this case.
+		 * 2. If we are async, we can call iomap_dio_complete() either
+		 *    in
+		 *
+		 *    2.1. A worker thread from the last bio completed.  In this
+		 *	   case we need to mark the btrfs_dio_data that it is
+		 *	   async in order to call generic_write_sync() properly.
+		 *	   This is handled by setting BTRFS_DIO_SYNC_STUB in the
+		 *	   current->journal_info.
+		 *    2.2  The submitter context, because all IO completed
+		 *         before we exited iomap_dio_rw().  In this case we can
+		 *         just re-set the IOCB_DSYNC on the iocb and we'll do
+		 *         the sync below.  If our ->end_io() gets called and
+		 *         current->journal_info is set, then we know we're in
+		 *         our current context and we will clear
+		 *         current->journal_info to indicate that we need to
+		 *         sync below.
+		 */
+		if (sync) {
+			ASSERT(current->journal_info == NULL);
+			iocb->ki_flags &= ~IOCB_DSYNC;
+			current->journal_info = BTRFS_DIO_SYNC_STUB;
+		}
 		num_written = __btrfs_direct_write(iocb, from);
+
+		/*
+		 * As stated above, we cleared journal_info, so we need to do
+		 * the sync ourselves.
+		 */
+		if (sync && current->journal_info == NULL)
+			iocb->ki_flags |= IOCB_DSYNC;
+		current->journal_info = NULL;
 	} else {
 		num_written = btrfs_buffered_write(iocb, from);
 		if (num_written > 0)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3b63b858546e..170a929eec81 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -62,6 +62,7 @@ struct btrfs_dio_data {
 	loff_t length;
 	ssize_t submitted;
 	struct extent_changeset *data_reserved;
+	bool sync;
 };
 
 static const struct inode_operations btrfs_dir_inode_operations;
@@ -7334,6 +7335,17 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	int ret = 0;
 	u64 len = length;
 	bool unlock_extents = false;
+	bool sync = (current->journal_info == BTRFS_DIO_SYNC_STUB);
+
+	/*
+	 * We used current->journal_info here to see if we were sync, but
+	 * there's a lot of tests in the enospc machinery to not do flushing if
+	 * we have a journal_info set, so we need to clear this out and re-set
+	 * it in iomap_end.
+	 */
+	ASSERT(current->journal_info == NULL ||
+	       current->journal_info == BTRFS_DIO_SYNC_STUB);
+	current->journal_info = NULL;
 
 	if (!write)
 		len = min_t(u64, len, fs_info->sectorsize);
@@ -7359,6 +7371,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	if (!dio_data)
 		return -ENOMEM;
 
+	dio_data->sync = sync;
 	dio_data->length = length;
 	if (write) {
 		dio_data->reserve = round_up(length, fs_info->sectorsize);
@@ -7506,6 +7519,14 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		extent_changeset_free(dio_data->data_reserved);
 	}
 out:
+	/*
+	 * We're all done, we can re-set the current->journal_info now safely
+	 * for our endio.
+	 */
+	if (dio_data->sync) {
+		ASSERT(current->journal_info == NULL);
+		current->journal_info = BTRFS_DIO_SYNC_STUB;
+	}
 	kfree(dio_data);
 	iomap->private = NULL;
 
@@ -7914,6 +7935,30 @@ static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
 	return retval;
 }
 
+static inline int btrfs_maybe_fsync_end_io(struct kiocb *iocb, ssize_t size,
+					   int error, unsigned flags)
+{
+	/*
+	 * Now if we're still in the context of our submitter we know we can't
+	 * safely run generic_write_sync(), so clear our flag here so that the
+	 * caller knows to follow up with a sync.
+	 */
+	if (current->journal_info == BTRFS_DIO_SYNC_STUB) {
+		current->journal_info = NULL;
+		return error;
+	}
+
+	if (error)
+		return error;
+
+	if (size) {
+		iocb->ki_flags |= IOCB_DSYNC;
+		return generic_write_sync(iocb, size);
+	}
+
+	return 0;
+}
+
 static const struct iomap_ops btrfs_dio_iomap_ops = {
 	.iomap_begin            = btrfs_dio_iomap_begin,
 	.iomap_end              = btrfs_dio_iomap_end,
@@ -7923,6 +7968,11 @@ static const struct iomap_dio_ops btrfs_dops = {
 	.submit_io		= btrfs_submit_direct,
 };
 
+static const struct iomap_dio_ops btrfs_sync_dops = {
+	.submit_io		= btrfs_submit_direct,
+	.end_io			= btrfs_maybe_fsync_end_io,
+};
+
 ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
@@ -7951,8 +8001,16 @@ ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		down_read(&BTRFS_I(inode)->dio_sem);
 	}
 
-	ret = iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dops,
-			is_sync_kiocb(iocb));
+	/*
+	 * We have are actually a sync iocb, so we need our fancy endio to know
+	 * if we need to sync.
+	 */
+	if (current->journal_info)
+		ret = iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops,
+				   &btrfs_sync_dops, is_sync_kiocb(iocb));
+	else
+		ret = iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops,
+				   &btrfs_dops, is_sync_kiocb(iocb));
 
 	if (ret == -ENOTBLK)
 		ret = 0;
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 8241c050ba71..858d9153a1cd 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -112,6 +112,7 @@ struct btrfs_transaction {
 #define TRANS_EXTWRITERS	(__TRANS_START | __TRANS_ATTACH)
 
 #define BTRFS_SEND_TRANS_STUB	((void *)1)
+#define BTRFS_DIO_SYNC_STUB	((void *)2)
 
 struct btrfs_trans_handle {
 	u64 transid;
-- 
2.26.2

