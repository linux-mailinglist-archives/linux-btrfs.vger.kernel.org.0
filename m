Return-Path: <linux-btrfs+bounces-12402-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52506A684E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 07:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BE7881778
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 06:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E71250C01;
	Wed, 19 Mar 2025 06:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="ZOqsCtpu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DAD250BE5
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 06:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364814; cv=none; b=jHwJgjiGkVPz2Rgkxp2vJs25IL7gjG/Ibo4LnO7ykmurEqFyNvM5+EUsjffXo/4x+2CRRhjllugeUnOp6xveja5blJI7vYZCZBpnZZHHnBkFhdAQBKDNrdM7UYQRQ0OOKWrf2FcsPq0zHCz910gLQYyfDwWVihPzFy+r45MAons=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364814; c=relaxed/simple;
	bh=oYciIjC4rs6s5STw/xs6kdWP2TAKeNAc+tUFNO4Yp0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHo2upPo2OOFmuSqhHpitYIPDSRwbfJ49XfKf1qR2utq+/8KjlD8CUbehqivcBYF4lkKVvC45MMllJmaWQ2cLAIyzyP9ZC5ODdi0THH8JZF35S7EuS70sDKE7CTXCOc9u2FRZm73/XYrB1j2ckAxACCTIXPsJKIUTlCPWZz/q50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=ZOqsCtpu; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-301493f461eso4711212a91.3
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 23:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742364813; x=1742969613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=autIi02mQOQDOvMtdJVsC4xB36voEA7M/gHvacF/Km8=;
        b=ZOqsCtpuDhkCuT/HVOSTKeII4BQgwD+IEaHELWGBGVFV5CaW4p4AxqQx5sCjq00iBT
         aOF9iY7sJgPGztT9MCusn3ES/hI/8ZK4ycbQ/Y9CVma7YFtL6MXb0FQSALzPgtVOyx+D
         BupwtJFCJxxCgNiA8tLjpgYHDqiQYk+fNWopU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742364813; x=1742969613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=autIi02mQOQDOvMtdJVsC4xB36voEA7M/gHvacF/Km8=;
        b=J5WQdiVVnlJHfagJo3Avx18LC4KJvR8zVshJ0iuEymBu6j6LorjXdN+E5JoDmCK5nL
         q9HF4c3UtiGXK++SwSovXXHZPYNeL2XbiHgNQl3nCVrIb4Qc+eCNxjczBrIOHmGOmDa0
         02HKnjF0ajIMFCdKC/fPOpPVbptHjH0iEvChpsn73MCVZ1cjsP+7fGMu0hjQ9p03/Kf9
         /XvRoUznR8F4UwCIgkXHdlXxa26DtGP095j4RaqeBnPLch1MIIi1MFfOc6IVcukzLnLq
         63LRguc5AXDcdih+YrfLG2yePEysbqIDEdx/nzKhnEbk9lCoDGX27VmSE+uad5JkDSNv
         vrOg==
X-Gm-Message-State: AOJu0Ywhax3cJDLtmMMqObU42oFA7V2JuHIDxzxszE/mbCFFhU/bvlEv
	Kjr3whYZkXwR4sBxuWgKsEltxIRnwf/cvrISpRBBTQoD8vJndsst5UkjS0fMPw0=
X-Gm-Gg: ASbGnctjh/Hz/DxT5s00fKfZ3UOmTXPAdGY1gAR+g3eRzGU5l3TtsCYEpQZmP36dlDJ
	97+f22czv6AVXlRq2VwRSsxfO7GgFzQHP3YfGZ8E644TQHsS/MNt73cuHu60x8F5yOoUPC6sch/
	lIfXsLO2Wx1cP/Ot8xwHjFVINJ9tRsEmGTxsUhCG5BoeFX6sp8S0AtQOJHh4gk1EBcW1OTPzSvz
	7SZ3bcL3Uwibw6JbnDjJ8XBPNRfLFAw+1/0XfGd02SUTYB9xU4yYT9Rlhfo8v9iPepbXZ6NQL1e
	z907KNUAJC07JqxwX/QF5c7FtWET4geqlX9FBBPdBd3j1I2movxkvPRYraaKlUOHdHYG/3KceMy
	z9prJ
X-Google-Smtp-Source: AGHT+IEai+OcJT8yk913mhD/xW86Gxo7BwT+qp3PGV+FzY19u9roByHP0Sc4MTXXudcClCLxtzma/g==
X-Received: by 2002:a17:90b:3ec1:b0:2ef:67c2:4030 with SMTP id 98e67ed59e1d1-301be1d94d1mr2484193a91.27.1742364812826;
        Tue, 18 Mar 2025 23:13:32 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf589b07sm645103a91.11.2025.03.18.23.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 23:13:32 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [RFC PATCH v5 4/5] io_uring/cmd: introduce io_uring_cmd_import_fixed_vec
Date: Wed, 19 Mar 2025 06:12:50 +0000
Message-ID: <20250319061251.21452-5-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319061251.21452-1-sidong.yang@furiosa.ai>
References: <20250319061251.21452-1-sidong.yang@furiosa.ai>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

io_uring_cmd_import_fixed_vec() is a cmd helper around vectored
registered buffer import functions, which caches the memory under
the hood. The lifetime of the vectore and hence the iterator is bound to
the request. Furthermore, the user is not allowed to call it multiple
times for a single request.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/io_uring/cmd.h | 13 +++++++++++++
 io_uring/uring_cmd.c         | 19 +++++++++++++++++++
 io_uring/uring_cmd.h         |  6 ++++++
 3 files changed, 38 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 598cacda4aa3..e6723fa95160 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -43,6 +43,11 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct iov_iter *iter,
 			      struct io_uring_cmd *ioucmd,
 			      unsigned int issue_flags);
+int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
+				  const struct iovec __user *uvec,
+				  size_t uvec_segs,
+				  int ddir, struct iov_iter *iter,
+				  unsigned issue_flags);
 
 /*
  * Completes the request, i.e. posts an io_uring CQE and deallocates @ioucmd
@@ -76,6 +81,14 @@ io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 {
 	return -EOPNOTSUPP;
 }
+static inline int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
+						const struct iovec __user *uvec,
+						size_t uvec_segs,
+						int ddir, struct iov_iter *iter,
+						unsigned issue_flags)
+{
+	return -EOPNOTSUPP;
+}
 static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret,
 		u64 ret2, unsigned issue_flags)
 {
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index abcc1ad236ef..c3eb2c263520 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -279,6 +279,25 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
 
+int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
+				  const struct iovec __user *uvec,
+				  size_t uvec_segs,
+				  int ddir, struct iov_iter *iter,
+				  unsigned issue_flags)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+	struct io_async_cmd *ac = req->async_data;
+	int ret;
+
+	ret = io_prep_reg_iovec(req, &ac->vec, uvec, uvec_segs);
+	if (ret)
+		return ret;
+
+	return io_import_reg_vec(ddir, iter, req, &ac->vec, uvec_segs,
+				 issue_flags);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed_vec);
+
 void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
diff --git a/io_uring/uring_cmd.h b/io_uring/uring_cmd.h
index b45ec7cffcd1..14e525255854 100644
--- a/io_uring/uring_cmd.h
+++ b/io_uring/uring_cmd.h
@@ -16,3 +16,9 @@ bool io_uring_try_cancel_uring_cmd(struct io_ring_ctx *ctx,
 				   struct io_uring_task *tctx, bool cancel_all);
 
 void io_cmd_cache_free(const void *entry);
+
+int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
+				  const struct iovec __user *uvec,
+				  size_t uvec_segs,
+				  int ddir, struct iov_iter *iter,
+				  unsigned issue_flags);
-- 
2.43.0


