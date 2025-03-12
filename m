Return-Path: <linux-btrfs+bounces-12242-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6508CA5DEE3
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 15:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D81EE7ACB27
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 14:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D542512E0;
	Wed, 12 Mar 2025 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="bB3zlehi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844BF2505B9
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789449; cv=none; b=obefQpJjK3N06O85Spw3VJP//kd7KiIaVJLWGP2SIKVM1bbntdoy2KXGUcJZGTdkooigglHs8DyesWjFnIrZO+O5k8DovOOpQ/uJ/Hy+nqSPEUYcBwj4bJ6dJCjt+iStLDG1edtQw0H/x1epr9Fv57asdgTmRbyvMFLjtmmvY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789449; c=relaxed/simple;
	bh=ga2LSmT61md5n2p7rdCucn4O99aWE/jCY95aOOLVTH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nl7+ECGTa+v/r+hgzX9+/8AO4HgkOscEN4nBeRv3KmwZtMfN3b/u/DlJJfUtguShpweUF+gnkIWjg0jsOfySheBN0SZWknVbR0N061dhsNWv1zhNpC7GZwbOnTePQez9tZPqNRbDRxXr0tIiMlqqhFqVLsrxPQMOsqrsLLWH/xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=bB3zlehi; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223959039f4so136232445ad.3
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 07:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1741789448; x=1742394248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sf5Mim88v1zsUv2CF9zajfgiTTZumS4UoXrfg/qlMyE=;
        b=bB3zlehiZTFURQmVJcfQacyW7bM61oTMRio0061Ul84NaT+OpR0HreJbtIBbn5l5G1
         Awfru6ADxBPtzGeali+x/cD0Xgan7BJb/beK3eyfzmmMY7SnLnjMqckW5OrPpXUW1L/r
         92z5LkcWZjJ/brlJITek8PoT4axxVyFJ8BqfrUJABI3Z1BJd59zduodfxqJf/ZQ1Awlu
         2P5vChH/QxlRz92kfsEs9r7L/iu0RJiIilyO/s5SHtU5JIQD8iIDegSc/nG1+nWYIDY+
         9pS2wFqWSu0kRzjthDvr9C5GFjUdhiwV79/JeyfRYiZMatRalXqfxx1cQa5OHrVvvMCS
         8B2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741789448; x=1742394248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sf5Mim88v1zsUv2CF9zajfgiTTZumS4UoXrfg/qlMyE=;
        b=l89Mk0uaVYMnO9u06hRyqMRaZB3kvTMDcNTHIO5V/3DzR8xbpoDVIREiogQYb/jd0g
         ZlgmrbfGQYu4Wo49ShJ5S6JsuPYXjvDjtTEa0M4pPP2U+NNIM/ycwQ2Hk3vT+scpNkc6
         x9fTFBdl4E4bTsb1RJ3gifeTA/7WpWsPDcky4CDx1UAGxnMAzCAzw0xvNE915zki0eMQ
         F+sAfIi2ngrldApD26chv3sw8l6Vtftr/A82LBWB0tcoZlY9xHQ5owCydILGPrG+SIDQ
         bfc2eTwPSUBf/dXa1h6ZIkAEOklQSWzqn1qj3Ert12CLkhi9pXKm80L5ixrNjb2JFBFr
         iFlQ==
X-Gm-Message-State: AOJu0Yw0WRWWOzntEWdT7rQmWUPbCd8qXEeyY5cXSSO07bLGW/ujAc32
	Lnw83gFhg5/QmyUV3DNWFtZsUrC4F5pQL7UFP/Fbf2OKWMOccBgTX0PuI9DqbN0=
X-Gm-Gg: ASbGnctI/PdGPR6lmqwZGktImu8gACwoQmK9mDvPTJdFxp7ZCOxV3J2k3IlJFhc5+Df
	q3ocxAonQUI6OGd7G1zzMCCx+aQft5bP4oArvaDq+pj+Fp2q9YliCS1Hdq20dd7NsJYiPmSWHfo
	Mk5oxE55rUWamxoNMReSeGqJMPvLw3dEFl/NOLccCGLfMXy0UmEV9nY3siX9HTLvfdoSZwPEKXr
	3RIOhINsV2IWhBwRKlWqDUSefOqqBJU3ae3Cbmm8bSCHoTrZSE8hthZQM4SCz/A+SWksVYAlfZv
	z46qAxtgFbF+xWSL4ILJsuTdcJU/FbBJjO/zAacON7jXUu1DGzv5rmT1liB6EAwp42I02HVdzg+
	4CW8T
X-Google-Smtp-Source: AGHT+IEB7zRsn2sn891Qv++mKti8pmW2qB36bnhHeSKSGpIvhV7qeTB7jRROPtq3qpgTC2s59IzhKQ==
X-Received: by 2002:a05:6a00:1401:b0:736:34a2:8a23 with SMTP id d2e1a72fcca58-736aaabee7amr27951202b3a.15.1741789447564;
        Wed, 12 Mar 2025 07:24:07 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736cc972eabsm7413860b3a.144.2025.03.12.07.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 07:24:07 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v2 2/2] btrfs: ioctl: use registered buffer for IORING_URING_CMD_FIXED
Date: Wed, 12 Mar 2025 14:23:26 +0000
Message-ID: <20250312142326.11660-3-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312142326.11660-1-sidong.yang@furiosa.ai>
References: <20250312142326.11660-1-sidong.yang@furiosa.ai>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch supports IORING_URING_CMD_FIXED flags in io-uring cmd. It
means that user provided buf_index in sqe that is registered before
submitting requests. In this patch, btrfs_uring_encoded_read() makes
iov_iter bvec type by checking the io-uring cmd flag. And there is
additional bvec field in btrfs_uring_priv for remaining bvec
lifecycle.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 fs/btrfs/ioctl.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6c18bad53cd3..7ac5a387ae5d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2007 Oracle.  All rights reserved.
  */
 
+#include "linux/bvec.h"
 #include <linux/kernel.h>
 #include <linux/bio.h>
 #include <linux/file.h>
@@ -4644,6 +4645,7 @@ struct btrfs_uring_priv {
 	unsigned long nr_pages;
 	struct kiocb iocb;
 	struct iovec *iov;
+	struct bio_vec *bvec;
 	struct iov_iter iter;
 	struct extent_state *cached_state;
 	u64 count;
@@ -4711,6 +4713,7 @@ static void btrfs_uring_read_finished(struct io_uring_cmd *cmd, unsigned int iss
 
 	kfree(priv->pages);
 	kfree(priv->iov);
+	kfree(priv->bvec);
 	kfree(priv);
 }
 
@@ -4730,7 +4733,8 @@ static int btrfs_uring_read_extent(struct kiocb *iocb, struct iov_iter *iter,
 				   struct extent_state *cached_state,
 				   u64 disk_bytenr, u64 disk_io_size,
 				   size_t count, bool compressed,
-				   struct iovec *iov, struct io_uring_cmd *cmd)
+				   struct iovec *iov, struct io_uring_cmd *cmd,
+				   struct bio_vec *bvec)
 {
 	struct btrfs_inode *inode = BTRFS_I(file_inode(iocb->ki_filp));
 	struct extent_io_tree *io_tree = &inode->io_tree;
@@ -4767,6 +4771,7 @@ static int btrfs_uring_read_extent(struct kiocb *iocb, struct iov_iter *iter,
 	priv->start = start;
 	priv->lockend = lockend;
 	priv->err = 0;
+	priv->bvec = bvec;
 
 	ret = btrfs_encoded_read_regular_fill_pages(inode, disk_bytenr,
 						    disk_io_size, pages, priv);
@@ -4818,6 +4823,7 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 	u64 start, lockend;
 	void __user *sqe_addr;
 	struct btrfs_uring_encoded_data *data = io_uring_cmd_get_async_data(cmd)->op_data;
+	struct bio_vec *bvec = NULL;
 
 	if (!capable(CAP_SYS_ADMIN)) {
 		ret = -EPERM;
@@ -4875,9 +4881,19 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 		}
 
 		data->iov = data->iovstack;
-		ret = import_iovec(ITER_DEST, data->args.iov, data->args.iovcnt,
-				   ARRAY_SIZE(data->iovstack), &data->iov,
-				   &data->iter);
+
+		if (cmd && (cmd->flags & IORING_URING_CMD_FIXED)) {
+			ret = io_uring_cmd_import_fixed_vec(
+				cmd, data->args.iov, data->args.iovcnt,
+				ITER_DEST, issue_flags, &data->iter, &bvec);
+			data->iov = NULL;
+		} else {
+			ret = import_iovec(ITER_DEST, data->args.iov,
+					   data->args.iovcnt,
+					   ARRAY_SIZE(data->iovstack),
+					   &data->iov, &data->iter);
+		}
+
 		if (ret < 0)
 			goto out_acct;
 
@@ -4929,13 +4945,14 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 		ret = btrfs_uring_read_extent(&kiocb, &data->iter, start, lockend,
 					      cached_state, disk_bytenr, disk_io_size,
 					      count, data->args.compression,
-					      data->iov, cmd);
+					      data->iov, cmd, bvec);
 
 		goto out_acct;
 	}
 
 out_free:
 	kfree(data->iov);
+	kfree(bvec);
 
 out_acct:
 	if (ret > 0)
-- 
2.43.0


