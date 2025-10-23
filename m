Return-Path: <linux-btrfs+bounces-18226-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D774BC035AB
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 22:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509CF1A0869A
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 20:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810452D7814;
	Thu, 23 Oct 2025 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IkJaAyfv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f97.google.com (mail-wr1-f97.google.com [209.85.221.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41F4274B56
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761250720; cv=none; b=RT5Q29aL5pCJKEf/pfCmxYiKHjoRP4tK/uXeaNPM1K+u4rKWLK4h3SMMbR9jho6AwQQFS/UeqLOYobHh+XAp1jBbcLnXlId7+eBlf4div4+c++sNZBpR6aLSZNl75qCx6TerqDlZXUBGe/LVxAFq/IAxjLriYsq685kct3AsDRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761250720; c=relaxed/simple;
	bh=YLz5K1hAMTmuVA/ovyB70FrmtxVA0sRFV6UGU8kE6eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgGu0jNDqAhp94bF5vzEwIIErTzZBhFL3izDWa0ctms4OLBQRoRZ1mUkFrTCXfcK6wnIEoMYRnKkkvXfzBf6yuMfTDx/okQcthXsUGNVCKs739LYZRzx8vqjVeK4vuPDJ0Bi5colelTJEOGiAUeI47jUlDjfY39/82fIOAoYJ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IkJaAyfv; arc=none smtp.client-ip=209.85.221.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wr1-f97.google.com with SMTP id ffacd0b85a97d-4270a072a0bso225531f8f.0
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761250716; x=1761855516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWqWl9I6OaTJzpoQyIopXGaUVLHhxAn4/wC5EGBqgEo=;
        b=IkJaAyfvreH5wZ3sYPrq7Bp6dE6fkciLEaaHCEgbh0bc1sm7mukNilF/ToJNwlo1jO
         wQfZ00xnTjR+I8d3d+uPlOdy77b+TnUDprAZUbhiBAYcnBU+ePV5o92ih+YHAhuLfnmH
         Rst1niYy42jXd4KjEDc4tePpIPw2gkgVRXMuxHUTrgZMNKZ+sQVH9PJFcDY7KhNZ4s7w
         kQek6b8id6t2iUcJ0nYz+CuEu2CqX2SRpAQAKnkvyW61ViwmPwJUKldxsF124RZdVwfw
         65w1Pz9x7WAP1k3oWvHQSDSznYp09LH0kNP0iO62skLooI0LkORooSxM8/B/BwRDV62q
         gCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761250716; x=1761855516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWqWl9I6OaTJzpoQyIopXGaUVLHhxAn4/wC5EGBqgEo=;
        b=rtSXcPr6V5PA/LcASnFgOAKjwT8m2S1Vt6LBOr5lPSwDXTVzCOYkuD5RIdXSyYRFLA
         LnWURQW333e/EZKRe+ZvDgygzQwe2zx4m/yW7N+0e4Tf1NUNoIsMbY4JQPN7k0LCN5bK
         1x4YpkZndDySQ+WR061hdCCBMoNbJH4aL+19b/cyhIuHy1G11IEONI29NX3fiCXCF2Sy
         fZs0CmVxfpMM6RQOmPH6+QBCG1CbgwvqqUQrXHTlh/F9OVFpbOQMQwA/LSFaZoEJ8PtB
         ssIbn5IdNWTbTtSHm4YULwH1P7tXec70teTs7EUV9Grt6oT47N//0KoSj5v9epmT2Ndk
         6I0w==
X-Forwarded-Encrypted: i=1; AJvYcCXsT1wmKxuh+bD9mjKk7RSc62PurRBT5KPMNGElXkJ6b+M9pTZuqHrnuc6xoPo+ywNrK7ekFOVV26oKGg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5tQezVXMCZecjA7GJuqitrFndPWnPumWGpFC1EF1BEelz+0ps
	khTG3P1fys0BmSiwfJtMCbFSzJH5CNCWBvw+LfJex2vVZnUcZB68PsCDskxZ7ApWWLpNh1GRQ4S
	vD7E3b7LE3R0v3rjR3rafC9j8TiS2QArmQ9NU
X-Gm-Gg: ASbGncs2YWQJTTfBuh+R8q1g6smy2tBlWwOTszVxbt9AdgUPCxEWSYBizRWChOuZaPX
	NK5+22d9HBmVzrHNee6CUkCwru5HewGSeo2FelIzdQ8MneZPDX/Dy6Bjg/0zYFFwVE9/3MQ3RcM
	5pwtElfBZuLkd7e6kwOsju+2Ax2pYiFCBdnAQgpjX/y189+vNCUkm7E+zZrxovnT+GBbB19xIWv
	0f0zUqwRqjK/dWFz+lQ02YTx8VEURfWgdrNO7N6wNNTkdYBeRZIfsVRtri5MNxnDTvQSljdHCRJ
	Id2JLydab8r0AP5lDtiYURMhm4xqkZebZGwpzaX6B8CAtlxhKd1YE9c7I4vnJtvLbwlS7xe/0Yg
	upEFqJ5kcFohyw57sH5E0fEhV8P+f0AA=
X-Google-Smtp-Source: AGHT+IG+F7LvVb9q/feNRCz+uAzHxkM23HOpSSc2ZgklRM8Pol3wHaimWcAj/kEpeUsdrKVgqlM3uocuvYeU
X-Received: by 2002:a05:600c:1e8b:b0:46e:36f9:c57e with SMTP id 5b1f17b1804b1-47494305991mr53576475e9.5.1761250716185;
        Thu, 23 Oct 2025 13:18:36 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-475c427ca8bsm10719765e9.3.2025.10.23.13.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:18:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id ACE5E340884;
	Thu, 23 Oct 2025 14:18:34 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id ABEF0E41B1D; Thu, 23 Oct 2025 14:18:34 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 3/3] io_uring/uring_cmd: avoid double indirect call in task work dispatch
Date: Thu, 23 Oct 2025 14:18:30 -0600
Message-ID: <20251023201830.3109805-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251023201830.3109805-1-csander@purestorage.com>
References: <20251023201830.3109805-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_uring task work dispatch makes an indirect call to struct io_kiocb's
io_task_work.func field to allow running arbitrary task work functions.
In the uring_cmd case, this calls io_uring_cmd_work(), which immediately
makes another indirect call to struct io_uring_cmd's task_work_cb field.
Define the uring_cmd task work callbacks as functions whose signatures
match io_req_tw_func_t. Define a IO_URING_CMD_TASK_WORK_ISSUE_FLAGS
constant in io_uring/cmd.h to avoid manufacturing issue_flags in the
uring_cmd task work callbacks. Now uring_cmd task work dispatch makes a
single indirect call to the uring_cmd implementation's callback. This
also allows removing the task_work_cb field from struct io_uring_cmd,
freeing up some additional storage space.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/ioctl.c                |  4 +++-
 drivers/block/ublk_drv.c     | 15 +++++++++------
 drivers/nvme/host/ioctl.c    |  5 +++--
 fs/btrfs/ioctl.c             |  4 +++-
 fs/fuse/dev_uring.c          |  5 +++--
 include/linux/io_uring/cmd.h | 16 +++++++---------
 io_uring/uring_cmd.c         | 13 ++-----------
 7 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index d7489a56b33c..5c10d48fab27 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -767,13 +767,15 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 struct blk_iou_cmd {
 	int res;
 	bool nowait;
 };
 
-static void blk_cmd_complete(struct io_uring_cmd *cmd, unsigned int issue_flags)
+static void blk_cmd_complete(struct io_kiocb *req, io_tw_token_t tw)
 {
+	struct io_uring_cmd *cmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
 	struct blk_iou_cmd *bic = io_uring_cmd_to_pdu(cmd, struct blk_iou_cmd);
+	unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
 
 	if (bic->res == -EAGAIN && bic->nowait)
 		io_uring_cmd_issue_blocking(cmd);
 	else
 		io_uring_cmd_done(cmd, bic->res, issue_flags);
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0c74a41a6753..00439d1879b0 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1346,13 +1346,14 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 
 	if (ublk_prep_auto_buf_reg(ubq, req, io, issue_flags))
 		ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
 }
 
-static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
-			   unsigned int issue_flags)
+static void ublk_cmd_tw_cb(struct io_kiocb *req, io_tw_token_t tw)
 {
+	struct io_uring_cmd *cmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
+	unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct ublk_queue *ubq = pdu->ubq;
 
 	ublk_dispatch_req(ubq, pdu->req, issue_flags);
 }
@@ -1364,13 +1365,14 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
 
 	pdu->req = rq;
 	io_uring_cmd_complete_in_task(cmd, ublk_cmd_tw_cb);
 }
 
-static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
-		unsigned int issue_flags)
+static void ublk_cmd_list_tw_cb(struct io_kiocb *req, io_tw_token_t tw)
 {
+	struct io_uring_cmd *cmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
+	unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct request *rq = pdu->req_list;
 	struct request *next;
 
 	do {
@@ -2521,13 +2523,14 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 fail_put:
 	ublk_put_req_ref(io, req);
 	return NULL;
 }
 
-static void ublk_ch_uring_cmd_cb(struct io_uring_cmd *cmd,
-		unsigned int issue_flags)
+static void ublk_ch_uring_cmd_cb(struct io_kiocb *req, io_tw_token_t tw)
 {
+	struct io_uring_cmd *cmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
+	unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
 	int ret = ublk_ch_uring_cmd_local(cmd, issue_flags);
 
 	if (ret != -EIOCBQUEUED)
 		io_uring_cmd_done(cmd, ret, issue_flags);
 }
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index c212fa952c0f..df39cee94de1 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -396,13 +396,14 @@ static inline struct nvme_uring_cmd_pdu *nvme_uring_cmd_pdu(
 		struct io_uring_cmd *ioucmd)
 {
 	return io_uring_cmd_to_pdu(ioucmd, struct nvme_uring_cmd_pdu);
 }
 
-static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd,
-			       unsigned issue_flags)
+static void nvme_uring_task_cb(struct io_kiocb *req, io_tw_token_t tw)
 {
+	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
+	unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
 
 	if (pdu->bio)
 		blk_rq_unmap_user(pdu->bio);
 	io_uring_cmd_done32(ioucmd, pdu->status, pdu->result, issue_flags);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 185bef0df1c2..3b62eb8a50dc 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4647,13 +4647,15 @@ struct btrfs_uring_priv {
 struct io_btrfs_cmd {
 	struct btrfs_uring_encoded_data *data;
 	struct btrfs_uring_priv *priv;
 };
 
-static void btrfs_uring_read_finished(struct io_uring_cmd *cmd, unsigned int issue_flags)
+static void btrfs_uring_read_finished(struct io_kiocb *req, io_tw_token_t tw)
 {
+	struct io_uring_cmd *cmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
 	struct io_btrfs_cmd *bc = io_uring_cmd_to_pdu(cmd, struct io_btrfs_cmd);
+	unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
 	struct btrfs_uring_priv *priv = bc->priv;
 	struct btrfs_inode *inode = BTRFS_I(file_inode(priv->iocb.ki_filp));
 	struct extent_io_tree *io_tree = &inode->io_tree;
 	pgoff_t index;
 	u64 cur;
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 71b0c9662716..051136e94a33 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1207,13 +1207,14 @@ static void fuse_uring_send(struct fuse_ring_ent *ent, struct io_uring_cmd *cmd,
 /*
  * This prepares and sends the ring request in fuse-uring task context.
  * User buffers are not mapped yet - the application does not have permission
  * to write to it - this has to be executed in ring task context.
  */
-static void fuse_uring_send_in_task(struct io_uring_cmd *cmd,
-				    unsigned int issue_flags)
+static void fuse_uring_send_in_task(struct io_kiocb *req, io_tw_token_t tw)
 {
+	struct io_uring_cmd *cmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
+	unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
 	struct fuse_ring_ent *ent = uring_cmd_to_ring_ent(cmd);
 	struct fuse_ring_queue *queue = ent->queue;
 	int err;
 
 	if (!io_uring_cmd_should_terminate_tw(cmd)) {
diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index b84b97c21b43..3efad93404f9 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -9,18 +9,13 @@
 /* only top 8 bits of sqe->uring_cmd_flags for kernel internal use */
 #define IORING_URING_CMD_CANCELABLE	(1U << 30)
 /* io_uring_cmd is being issued again */
 #define IORING_URING_CMD_REISSUE	(1U << 31)
 
-typedef void (*io_uring_cmd_tw_t)(struct io_uring_cmd *cmd,
-				  unsigned issue_flags);
-
 struct io_uring_cmd {
 	struct file	*file;
 	const struct io_uring_sqe *sqe;
-	/* callback to defer completions to task context */
-	io_uring_cmd_tw_t task_work_cb;
 	u32		cmd_op;
 	u32		flags;
 	u8		pdu[32]; /* available inline for free use */
 };
 
@@ -58,11 +53,11 @@ int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
  */
 void __io_uring_cmd_done(struct io_uring_cmd *cmd, s32 ret, u64 res2,
 			 unsigned issue_flags, bool is_cqe32);
 
 void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
-			    io_uring_cmd_tw_t task_work_cb,
+			    io_req_tw_func_t task_work_cb,
 			    unsigned flags);
 
 /*
  * Note: the caller should never hard code @issue_flags and only use the
  * mask provided by the core io_uring code.
@@ -107,11 +102,11 @@ static inline int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 static inline void __io_uring_cmd_done(struct io_uring_cmd *cmd, s32 ret,
 		u64 ret2, unsigned issue_flags, bool is_cqe32)
 {
 }
 static inline void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
-			    io_uring_cmd_tw_t task_work_cb, unsigned flags)
+			    io_req_tw_func_t task_work_cb, unsigned flags)
 {
 }
 static inline void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
@@ -130,19 +125,22 @@ static inline bool io_uring_mshot_cmd_post_cqe(struct io_uring_cmd *ioucmd,
 {
 	return true;
 }
 #endif
 
+/* task_work executor checks the deferred list completion */
+#define IO_URING_CMD_TASK_WORK_ISSUE_FLAGS IO_URING_F_COMPLETE_DEFER
+
 /* users must follow the IOU_F_TWQ_LAZY_WAKE semantics */
 static inline void io_uring_cmd_do_in_task_lazy(struct io_uring_cmd *ioucmd,
-			io_uring_cmd_tw_t task_work_cb)
+			io_req_tw_func_t task_work_cb)
 {
 	__io_uring_cmd_do_in_task(ioucmd, task_work_cb, IOU_F_TWQ_LAZY_WAKE);
 }
 
 static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
-			io_uring_cmd_tw_t task_work_cb)
+			io_req_tw_func_t task_work_cb)
 {
 	__io_uring_cmd_do_in_task(ioucmd, task_work_cb, 0);
 }
 
 static inline bool io_uring_cmd_should_terminate_tw(struct io_uring_cmd *cmd)
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 35bdac35cf4d..5a80d35658dc 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -111,29 +111,20 @@ void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 		io_ring_submit_unlock(ctx, issue_flags);
 	}
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_mark_cancelable);
 
-static void io_uring_cmd_work(struct io_kiocb *req, io_tw_token_t tw)
-{
-	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
-
-	/* task_work executor checks the deffered list completion */
-	ioucmd->task_work_cb(ioucmd, IO_URING_F_COMPLETE_DEFER);
-}
-
 void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
-			io_uring_cmd_tw_t task_work_cb,
+			io_req_tw_func_t task_work_cb,
 			unsigned flags)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
 
 	if (WARN_ON_ONCE(req->flags & REQ_F_APOLL_MULTISHOT))
 		return;
 
-	ioucmd->task_work_cb = task_work_cb;
-	req->io_task_work.func = io_uring_cmd_work;
+	req->io_task_work.func = task_work_cb;
 	__io_req_task_work_add(req, flags);
 }
 EXPORT_SYMBOL_GPL(__io_uring_cmd_do_in_task);
 
 static inline void io_req_set_cqe32_extra(struct io_kiocb *req,
-- 
2.45.2


