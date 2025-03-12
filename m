Return-Path: <linux-btrfs+bounces-12236-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD1FA5DD76
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 14:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0DE16351E
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 13:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0E624C074;
	Wed, 12 Mar 2025 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="0awkaYd9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A9724889F
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784985; cv=none; b=PSWOcBTi+XMHjFGX0qz7YDDX9ZpDOCDFSFaC91xFnJyxIdFtUoRWGJwaRJe0CnfxHwWL9xr74JV87NI4HopQcI6HPZDEIjXJ7dy9y9dKLLbO4QlxBL4ZSoXWZUNfa0S9rKkcuyBolHiLUABY1XtQgBrEJ4StpoUpX7L/6ExBpig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784985; c=relaxed/simple;
	bh=ga2LSmT61md5n2p7rdCucn4O99aWE/jCY95aOOLVTH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGtfojqux31zbvKaDrUMJ01J2Vu/Fcxm+m0aDw0I2MNx8U4i8sG3K5/548mOgNA9BCBGhKqIiM08714V5j3Tg5xzcH8GkPL2HkC28TOSH84QAt0aY4VC4RwyUPH0a3CFLFUwAHePGHvhcva1ayyyKK4gBmQaqHDI4zW3ZTjiU8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=0awkaYd9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224341bbc1dso92535095ad.3
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 06:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1741784983; x=1742389783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sf5Mim88v1zsUv2CF9zajfgiTTZumS4UoXrfg/qlMyE=;
        b=0awkaYd9We31IKpPedZDh3uvKNmfLqn9OtPI56bX2wSvlrJjNNEEkBqJ6EMF1bOdJu
         81ukfkIqH7bM5vRz/c7MeCLDiYJdDotmswVhUcZnF/Zyr7rnaj3NF0tnrbBVJJKFJqRk
         70P+fNaZNNZfrMl6arvVrn49RFaDB/1zmdl94VdKWhhCuBcFlBatDjWz9+VqaQqbi0BM
         WZuX72wNZ74DnD1eruYlAWmZgjvW+T6Sd+aC9Sj8eM6HOCZzeezgoGH/nFOQO+OlHAcX
         htWQG2U6cbNI/370ofEH7CyeAkZh4C+ZJOQtmkx9rsGvTPLfAYbGA3pdVDsiGtWjAA5s
         +l1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741784983; x=1742389783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sf5Mim88v1zsUv2CF9zajfgiTTZumS4UoXrfg/qlMyE=;
        b=H8nb04uUlBAN/5XOQ2QUhEpGUMSfSgkgEFk3Cb9N1NEVcQyWopdzgjPl17zHkrdt/5
         9l2v+0KZk+p5ZwTTM/OMn/MQXbAxuMXxsAhGqFOuNqpX4ahJoOhtsoKwKDY69GzXQ6ai
         lXLDXL7Csp2yXfXP3ZUsvHiMN/lGxhzDs1emB8cLntW4Nh4tVzV0ZFCNiFr9JCQOoyb7
         MgvKl/3tO0kwf+6cMKquVbOzhcN89J+MdLWM8aIiu4rBRRBkl8SIZGcw+62G9tEILICa
         sX54qj/RtPJrekCXHE5H0bNr7zErv8PrT0UyDgk3HnJHMKOnjttym51WoY+pidFK2ZNT
         fquw==
X-Forwarded-Encrypted: i=1; AJvYcCVu6a+cLcaHHSct3l02fso0c+9HNbCeztqze0QUA1mWDYDC0xngls/ehzgy6Y3G3x5rEHzdTfuFud7+iQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ/fq6xP7bnL9Q+/ZP9KOjYkReVC8bbCKElxLBGP2ipUpVjXYw
	Byq8Bhq/l8JRTd9YR6jeL1qhIRuHh1wVTIum1tV7/Ia9NA8TKcSix9OglqE2k8g=
X-Gm-Gg: ASbGncusCOjJB78rs73DVSeO47x4dK4fK7uSx+qnU7veZ3wvqTjK/bcKe4ewelx3Xeu
	OYWlbF8CafRM5maEkZE5z7TI8qzfwvgmd4vJbMw17U/b5RdknoKhcqcLLuxG9dfghXoWoNRK9FY
	J2NedQxBsxrKjOUZK2sI1mqZYzRMfLlPiGfSMRUxe39GlSwQIs0oBGN5O8UsEokgXUJlIE1GEGs
	bbm9dRh+zmzrpjc+okjmIuXrKgJO7F+/oTD/Uho4jvbtqkJWzI1SNKdNvb6cu6r/PRUT3hZWOL7
	xp1e+XGwOmdfDVnVvtwXkDxxW8xRFJ/J6UKIhkuK+rp91vupuxKZ+0ikv0/eCaVvuFia5plLoqg
	fC+6X
X-Google-Smtp-Source: AGHT+IHINSsNMXDf/ujoGNsvP22wMUl9hboDvbpyzHad1RW7/6Vo+ySwFx65tyhXFD9eKYlgsO5pNA==
X-Received: by 2002:a05:6a20:b68a:b0:1f5:619a:7f4c with SMTP id adf61e73a8af0-1f58cbb5ebbmr11897051637.29.1741784983366;
        Wed, 12 Mar 2025 06:09:43 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af5053a85c2sm9432299a12.10.2025.03.12.06.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:09:43 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Sidong Yang <sidong.yang@furiosa.ai>,
	linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [RFC PATCH v2 2/2] btrfs: ioctl: use registered buffer for IORING_URING_CMD_FIXED
Date: Wed, 12 Mar 2025 13:09:22 +0000
Message-ID: <20250312130924.11402-3-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312130924.11402-1-sidong.yang@furiosa.ai>
References: <20250312130924.11402-1-sidong.yang@furiosa.ai>
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


