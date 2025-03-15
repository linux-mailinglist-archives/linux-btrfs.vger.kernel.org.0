Return-Path: <linux-btrfs+bounces-12307-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2510BA630AA
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 18:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39CF43BCEAB
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 17:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0184C205E21;
	Sat, 15 Mar 2025 17:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="SqWGaffJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8224205AD5
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742059441; cv=none; b=FyZUdDn02VrDptRRKTlfdrGnydjodXAs083byyeBl+90nGqPStgQLkU6t3iEzcDiStQGzJ8U/chob+jBJBNaNBMj/OjexlaEADdyLUOcIznci5+4WasoqLmN9ebGrX2MsEcA/6sidvdzNzAERWVN/XjLHqpdG1Txhr9LY6aX7N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742059441; c=relaxed/simple;
	bh=jjy/ipAsVAjM570PsPj8EFg1BR0qzO1tolMoinZ9Ul8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiY4KdERZY2Cc/KNcYRPPZ4vYW/I8JiC8ySbwzlpZE6IkA38CI8jyyw+dQ9910At2fNsHKE28DC39it9a0JQ96z2AG6yxx+Au/vvbSGfroSFIuth2X9sXl1JfJfH8THjHLnZR7asKfSXAqUHRhGqb5S3cQhJl6tny7b+/gZIF4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=SqWGaffJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2239c066347so62995425ad.2
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 10:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1742059439; x=1742664239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gA/GFNSLx9g8BrxtQW6nnUtMwtq8vRTEsCNTXthdg1I=;
        b=SqWGaffJ31cF0n2TnGYhCB3l/Fjtyoyzg4oYOUQod2ilK+ZNwYgZfK3MU+AxByZvHC
         VU3U5fDjL4ymMK6VpnovNAvbvM8K3uNwCqt2cH6J7xdAUqznHNGe8KV28Gyk9sKs4w0F
         b6/PaeUVs6rc4BslWUGAFDnrWOl5n03DYCIKniZdXFx/R81LMNj9RmTidvo1SJC0Eokn
         NREh7W2oMqbdk2rN2lWlouq6Qx/N+2tdTxw3BsrpA3O5HoU3gMmoL6EnLzL97RlwGrpq
         udBbPbs2vud3YX/HMj1HadMITiYiU8dxlLRaq6vWN/9SkP2ktoc/bu/4wFdDuwEGwuWA
         4LDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742059439; x=1742664239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gA/GFNSLx9g8BrxtQW6nnUtMwtq8vRTEsCNTXthdg1I=;
        b=cwGSXfWe8w/w2ommvt8RUfP8T9Gr8z2OO0DLHpKJiwgJx9P9LNFwHZ5AGWcBH5er00
         Km8PRrUjKVTe5bpOvfzgjlHHfEmbOSrqYQrqQHuj5RM80RX0qVH9JRfNxINvf/drH0c5
         N4HFj8i3EMuXiMcYqLupfXbJ5f7LwKyrP8ajJTH9tjwE+A/NSz48RChf5K1bDNZ7m/ju
         iJB7iSNE6MwzCRlwPB4Ir1ESzexreY8qHyEIvUw3Lmw3H4bptFqHTYCzCgRNFauRs/+S
         58uJC08i/rkMzE8uUK9RZWvGQJlFzS3MnfSoqAUaOaadiFXZ1/Hc7IlfDepBE4aCk9y2
         c4Tg==
X-Gm-Message-State: AOJu0Yx9yfCO3GWs9DuqHFnTqlAAdyO+4dtUKAXNybjyHt/AMgumB9ur
	OIjjfH3AX//i149IgDumrcidM89UUcMejQMMY6bJPVpvFr/3NF1gH7O9XMVjuG4N6s5YCsnNQbV
	3
X-Gm-Gg: ASbGncs2bieZVyu2eY/he9xa84xaaGwOy5DJ7IbXP/N8KYXLypx8e9pzYyTl3AjGhcm
	YNEGdgjE+cUlGllHmpXnVmIUVG6m+fnkuyfwTy2YDeh6DDhMge4E0GFgzutOTGx5HVlEs1X0hYW
	LcPmza3Fbg/+1REqJ1S321FSxFmagLAOHYi3vpxZa+L00cFyJfThK/WW29WRKnD04d8drD+B+HV
	kTfwND5jTWW5wa6//YxPtrYTgUqKV7XQoacnLL752UvQN9CZOyOe19GD1v4ovmw4coS1fI/uc7s
	sEVsLgiRnwdSg+Uc+gyxUbra6kkJO3Fd2B8EENe9nA==
X-Google-Smtp-Source: AGHT+IEbj/fYNWZdaI4EPbRWv9fRRPhjL9271b0qlYx3tRQZvXgQkMey08ub5woVXGP3tvnCVG45+g==
X-Received: by 2002:a05:6a00:3d0c:b0:736:4d05:2e2e with SMTP id d2e1a72fcca58-7372238f6c2mr7905409b3a.6.1742059439198;
        Sat, 15 Mar 2025 10:23:59 -0700 (PDT)
Received: from sidong.. ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115512f0sm4673013b3a.49.2025.03.15.10.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 10:23:58 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v3 3/3] btrfs: ioctl: introduce btrfs_uring_import_iovec()
Date: Sat, 15 Mar 2025 17:23:19 +0000
Message-ID: <20250315172319.16770-4-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315172319.16770-1-sidong.yang@furiosa.ai>
References: <20250315172319.16770-1-sidong.yang@furiosa.ai>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces btrfs_uring_import_iovec(). In encoded read/write
with uring cmd, it uses import_iovec without supporting fixed buffer.
btrfs_using_import_iovec() could use fixed buffer if cmd flags has
IORING_URING_CMD_FIXED.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 fs/btrfs/ioctl.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6c18bad53cd3..a7b52fd99059 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4802,6 +4802,28 @@ struct btrfs_uring_encoded_data {
 	struct iov_iter iter;
 };
 
+static int btrfs_uring_import_iovec(struct io_uring_cmd *cmd,
+				    unsigned int issue_flags, int rw)
+{
+	struct btrfs_uring_encoded_data *data =
+		io_uring_cmd_get_async_data(cmd)->op_data;
+	int ret;
+
+	if (cmd && (cmd->flags & IORING_URING_CMD_FIXED)) {
+		data->iov = NULL;
+		ret = io_uring_cmd_import_fixed_vec(cmd, data->args.iov,
+						    data->args.iovcnt,
+						    ITER_DEST, issue_flags,
+						    &data->iter);
+	} else {
+		data->iov = data->iovstack;
+		ret = import_iovec(rw, data->args.iov, data->args.iovcnt,
+				   ARRAY_SIZE(data->iovstack), &data->iov,
+				   &data->iter);
+	}
+	return ret;
+}
+
 static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
 	size_t copy_end_kernel = offsetofend(struct btrfs_ioctl_encoded_io_args, flags);
@@ -4874,10 +4896,7 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 			goto out_acct;
 		}
 
-		data->iov = data->iovstack;
-		ret = import_iovec(ITER_DEST, data->args.iov, data->args.iovcnt,
-				   ARRAY_SIZE(data->iovstack), &data->iov,
-				   &data->iter);
+		ret = btrfs_uring_import_iovec(cmd, issue_flags, ITER_DEST);
 		if (ret < 0)
 			goto out_acct;
 
@@ -5022,10 +5041,7 @@ static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issu
 		if (data->args.len > data->args.unencoded_len - data->args.unencoded_offset)
 			goto out_acct;
 
-		data->iov = data->iovstack;
-		ret = import_iovec(ITER_SOURCE, data->args.iov, data->args.iovcnt,
-				   ARRAY_SIZE(data->iovstack), &data->iov,
-				   &data->iter);
+		ret = btrfs_uring_import_iovec(cmd, issue_flags, ITER_SOURCE);
 		if (ret < 0)
 			goto out_acct;
 
-- 
2.43.0


