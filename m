Return-Path: <linux-btrfs+bounces-17089-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEADB92567
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 19:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CC3B7B0A51
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 17:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BF231329F;
	Mon, 22 Sep 2025 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XjRH3wMZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com [209.85.161.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC3C3128D3
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758560576; cv=none; b=nqUzrJRl4cSXVGmaTu9xntCZZ7zMpdQnn6A7JXGecV9MgCHYVP6M/NQvifdpHYYxDDYXS8spWmFzQ5gnCK8IXS+bH9/hkBEOJR077bQGvend1VhtUBBOAS+mtLPocii1Q8vuWC7ITkznnbO4FzZ2lDb7TZh608tKedodon7Bm48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758560576; c=relaxed/simple;
	bh=JypIUl1J7I4aTO6RIngxwIbvE3Bf0MU28iQ5ahgADgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r12S15oI8HHNTnuAvO8nU6Q0FyfZRXZRDGMKRYOXZcFDRKiwejT6zz0yV/3ZfEU3B7CHQuUVZyd1CJLgm0L4W+hyegJ+ZimeN7C+YzkE34WMpUQtfhd3zHaThMhnzYqLBvjE7IXYkXrvHdcOr/gEYy5PE3Bcm2Iq4o9nGnhqYjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XjRH3wMZ; arc=none smtp.client-ip=209.85.161.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oo1-f98.google.com with SMTP id 006d021491bc7-6218a296be8so74350eaf.2
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 10:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758560573; x=1759165373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X9Il64cUpTJjRu6b4mQHWeErfD8hD7D/QYu++Gqs37U=;
        b=XjRH3wMZYxbFVBQNU1/ia6FN7L8QvxflhV45+Y2WQYH2F3hwnn8rQacPoQs5oGLFrc
         QYHDLJRrx9sF+8+Bo1HP2JRwp0CYG+5s72AntDyWp4Br+a6bASuDdmyCI+PfWZw0AVa0
         /h5MPHvnoNAoV5TR7RNVtYBzG2aPwV3i8MjFnoNUPuM7Jh9ok9Qz2pSSnk0n2Z0tW1mO
         vEa5zLxVVWQegPr7zg8av5olR4lqwoSAa59nNogsURQSIFAPVFQRnmyw8fPWk/bD9c4G
         mv4EVFm0J3IuZR8sMVMtEryb3Xzm5GurmRxunPlI4SGapgs5VxS3G/xcCyp2oXIDUDnr
         L62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758560573; x=1759165373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9Il64cUpTJjRu6b4mQHWeErfD8hD7D/QYu++Gqs37U=;
        b=Rdgr+RmPQQGz8BIEfS90P+/mI4w8ZafJ2UQ9LPVoTrj794fJmguodpE5uBTe+XZGUV
         50w+4AcCysywJNcwpXoy1bfn5k5S+A0MKf05/uXvm1pA5qax8z1KpV3w+1R4w6Og0LQu
         OFi3DWzZs6FP4M5mo1bhGWVaUXAhYzgEYKz9oqxKcoQS0Q6lVlhRjqQZtYV047CrACU9
         G6LyEq7vtkzzfkVkmEtLJD8+y707fHD2eZoCwhOqu3ZD4GAMjnRGWvPZ+dC5JLqwMcS6
         5t0VaEdFmCvJn67XjO5g/8mBGPHrEUKvL2sqqZvhAyLf2vfPzSjtOlvXExwmnbmFcmoy
         phew==
X-Forwarded-Encrypted: i=1; AJvYcCVXhuqQbvLus8S7JT3n5KBGkvUpAcxX/x7D3n5egZufYPzZzK4oNSlahGYsPV8FCEjpQpv54mw/wQbR8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFCyRysRQHCAk4yfaX+g/mB24PDuZtDPaIXYLBekPWyoNBlzJe
	XMsf5BBkeeTo4LR9X4+PVne0l1tBdxXUZLdBfAjOzytobn88A7P6ANJPYQvBOgzEBrKfxI7xzcl
	9PU3IYIDoKJS+dnGAJ862DC6gqARJ4dZi70Q/PqGC0J4hT9F8lK74
X-Gm-Gg: ASbGncsJViYQk0MK8+O8sVvY/Sb3bjSL2tMovo6fpy8YKZ2jTFIPLal0dmUoi5ml8R4
	WHw100YPWBNZr6Vc852J/Sv+l0R6zChcEVXYpgJ2Q9k7Kk/Ww5AIVQJWhYApSX4EZEaL/15eqLv
	CINnLSe/neadaOZKub+8VNu7aUw3D68X0M/1hxcvNfG8KQuAuZ2yblZQET+CaM6ITGOP3vY1hcH
	lvgQUrz7Gt3XRwZUMdeD4K7OC7Hyc8DwtSWM+Aal/LcU/+rt38Rn5KopCtMkXvcyZwFkm02HZ5v
	KcHfQ2CMurta6i0A6+OFoXuf2DKAn2MAY8zGtNzwMftK/d4+xoCUyGwwVw==
X-Google-Smtp-Source: AGHT+IGgvjnxvdko/nCuAkBCNCdpc3qhLNgvtxgilGl8hD1yrabr5ZA1gFKHJa7ofAq5Qix3umS3FgQxvi+X
X-Received: by 2002:a05:6820:c8b:b0:61f:a265:6b9c with SMTP id 006d021491bc7-62724fddc3emr4069963eaf.0.1758560573320;
        Mon, 22 Sep 2025 10:02:53 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-625dae1d688sm484015eaf.9.2025.09.22.10.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 10:02:53 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D6914340408;
	Mon, 22 Sep 2025 11:02:52 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C3F93E414A1; Mon, 22 Sep 2025 11:02:52 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: Keith Busch <kbusch@meta.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH] io_uring/cmd: drop unused res2 param from io_uring_cmd_done()
Date: Mon, 22 Sep 2025 11:02:31 -0600
Message-ID: <20250922170234.2269956-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 79525b51acc1 ("io_uring: fix nvme's 32b cqes on mixed cq") split
out a separate io_uring_cmd_done32() helper for ->uring_cmd()
implementations that return 32-byte CQEs. The res2 value passed to
io_uring_cmd_done() is now unused because __io_uring_cmd_done() ignores
it when is_cqe32 is passed as false. So drop the parameter from
io_uring_cmd_done() to simplify the callers and clarify that it's not
possible to return an extra value beyond the 32-bit CQE result.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/ioctl.c                | 2 +-
 drivers/block/ublk_drv.c     | 6 +++---
 fs/btrfs/ioctl.c             | 2 +-
 fs/fuse/dev_uring.c          | 8 ++++----
 include/linux/io_uring/cmd.h | 4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index f7b0006ca45d..c9ea8e53871e 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -774,11 +774,11 @@ static void blk_cmd_complete(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	struct blk_iou_cmd *bic = io_uring_cmd_to_pdu(cmd, struct blk_iou_cmd);
 
 	if (bic->res == -EAGAIN && bic->nowait)
 		io_uring_cmd_issue_blocking(cmd);
 	else
-		io_uring_cmd_done(cmd, bic->res, 0, issue_flags);
+		io_uring_cmd_done(cmd, bic->res, issue_flags);
 }
 
 static void bio_cmd_bio_end_io(struct bio *bio)
 {
 	struct io_uring_cmd *cmd = bio->bi_private;
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 99abd67b708b..48c409d1e1bb 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1186,11 +1186,11 @@ static void ublk_complete_io_cmd(struct ublk_io *io, struct request *req,
 				 int res, unsigned issue_flags)
 {
 	struct io_uring_cmd *cmd = __ublk_prep_compl_io_cmd(io, req);
 
 	/* tell ublksrv one io request is coming */
-	io_uring_cmd_done(cmd, res, 0, issue_flags);
+	io_uring_cmd_done(cmd, res, issue_flags);
 }
 
 #define UBLK_REQUEUE_DELAY_MS	3
 
 static inline void __ublk_abort_rq(struct ublk_queue *ubq,
@@ -1803,11 +1803,11 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, unsigned tag,
 	if (!done)
 		io->flags |= UBLK_IO_FLAG_CANCELED;
 	spin_unlock(&ubq->cancel_lock);
 
 	if (!done)
-		io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, 0, issue_flags);
+		io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, issue_flags);
 }
 
 /*
  * The ublk char device won't be closed when calling cancel fn, so both
  * ublk device and queue are guaranteed to be live
@@ -2450,11 +2450,11 @@ static void ublk_ch_uring_cmd_cb(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
 	int ret = ublk_ch_uring_cmd_local(cmd, issue_flags);
 
 	if (ret != -EIOCBQUEUED)
-		io_uring_cmd_done(cmd, ret, 0, issue_flags);
+		io_uring_cmd_done(cmd, ret, issue_flags);
 }
 
 static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
 	if (unlikely(issue_flags & IO_URING_F_CANCEL)) {
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7e13de2bdcbf..168d84421a78 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4683,11 +4683,11 @@ static void btrfs_uring_read_finished(struct io_uring_cmd *cmd, unsigned int iss
 
 out:
 	btrfs_unlock_extent(io_tree, priv->start, priv->lockend, &priv->cached_state);
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 
-	io_uring_cmd_done(cmd, ret, 0, issue_flags);
+	io_uring_cmd_done(cmd, ret, issue_flags);
 	add_rchar(current, ret);
 
 	for (index = 0; index < priv->nr_pages; index++)
 		__free_page(priv->pages[index]);
 
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 249b210becb1..a30c44234a4e 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -349,11 +349,11 @@ static void fuse_uring_entry_teardown(struct fuse_ring_ent *ent)
 	list_move(&ent->list, &queue->ent_released);
 	ent->state = FRRS_RELEASED;
 	spin_unlock(&queue->lock);
 
 	if (cmd)
-		io_uring_cmd_done(cmd, -ENOTCONN, 0, IO_URING_F_UNLOCKED);
+		io_uring_cmd_done(cmd, -ENOTCONN, IO_URING_F_UNLOCKED);
 
 	if (req)
 		fuse_uring_stop_fuse_req_end(req);
 }
 
@@ -516,11 +516,11 @@ static void fuse_uring_cancel(struct io_uring_cmd *cmd,
 	}
 	spin_unlock(&queue->lock);
 
 	if (need_cmd_done) {
 		/* no queue lock to avoid lock order issues */
-		io_uring_cmd_done(cmd, -ENOTCONN, 0, issue_flags);
+		io_uring_cmd_done(cmd, -ENOTCONN, issue_flags);
 	}
 }
 
 static void fuse_uring_prepare_cancel(struct io_uring_cmd *cmd, int issue_flags,
 				      struct fuse_ring_ent *ring_ent)
@@ -731,11 +731,11 @@ static int fuse_uring_send_next_to_ring(struct fuse_ring_ent *ent,
 	ent->cmd = NULL;
 	ent->state = FRRS_USERSPACE;
 	list_move_tail(&ent->list, &queue->ent_in_userspace);
 	spin_unlock(&queue->lock);
 
-	io_uring_cmd_done(cmd, 0, 0, issue_flags);
+	io_uring_cmd_done(cmd, 0, issue_flags);
 	return 0;
 }
 
 /*
  * Make a ring entry available for fuse_req assignment
@@ -1198,11 +1198,11 @@ static void fuse_uring_send(struct fuse_ring_ent *ent, struct io_uring_cmd *cmd,
 	ent->state = FRRS_USERSPACE;
 	list_move_tail(&ent->list, &queue->ent_in_userspace);
 	ent->cmd = NULL;
 	spin_unlock(&queue->lock);
 
-	io_uring_cmd_done(cmd, ret, 0, issue_flags);
+	io_uring_cmd_done(cmd, ret, issue_flags);
 }
 
 /*
  * This prepares and sends the ring request in fuse-uring task context.
  * User buffers are not mapped yet - the application does not have permission
diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 02d50f08f668..7509025b4071 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -158,13 +158,13 @@ static inline void *io_uring_cmd_ctx_handle(struct io_uring_cmd *cmd)
 {
 	return cmd_to_io_kiocb(cmd)->ctx;
 }
 
 static inline void io_uring_cmd_done(struct io_uring_cmd *ioucmd, s32 ret,
-				     u64 res2, unsigned issue_flags)
+				     unsigned issue_flags)
 {
-	return __io_uring_cmd_done(ioucmd, ret, res2, issue_flags, false);
+	return __io_uring_cmd_done(ioucmd, ret, 0, issue_flags, false);
 }
 
 static inline void io_uring_cmd_done32(struct io_uring_cmd *ioucmd, s32 ret,
 				       u64 res2, unsigned issue_flags)
 {
-- 
2.45.2


