Return-Path: <linux-btrfs+bounces-12403-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B1CA684F0
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 07:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6DE419C513F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 06:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021F52512C3;
	Wed, 19 Mar 2025 06:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="cm+X6FzY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096AC24EF72
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 06:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364817; cv=none; b=ZsgWekoXGsAM5BaAkd7POrC8W92dLGA1D8CnmifWWpy1Fsf8mN2/HsnQAvzr4MF4DFgSkY29XOwO/Ty6zTUkRw0Ybwa3MVFSPyrm9BCbn/YHXmATOu3Dq95PDAtkpdnjJGiBteU7xm0A76V2DEX5g6Kq5g4Jmn1CnZsut2iPQ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364817; c=relaxed/simple;
	bh=eyjj1uHvjzoEdaKMraFRmuVcUzgVgA4sRhGNzePsgog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TY0/ZaBYXxYeU9blqHcFI90oMG4A6YvPsYpxBV4aBRaBK1lccgBwSVbbbVFiXiwIWhPEhYgT7S89VFVqMR3B1Fby/k0zi0iO0z8xxWOllbbdCNsPFSXyAxQhFGVqAQ5sllrFe6txsJlsaMdHbFdIJHwAw6SDLNlNroeXM40X+yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=cm+X6FzY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22423adf751so113864785ad.2
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 23:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742364815; x=1742969615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ae4PagFT38IepvXpzRbslA5V5XToKvo9V6NCx8IDEps=;
        b=cm+X6FzYD6gd65QlfG6VCTMkgJ4vWA1Z3zUvNtRUcOru8BnVt4wYYoxI9X/10J4NW7
         IbwwOXJpt5Bob+1aWQFnfPImETJTDUJFwxOEKisDdCxBuz151KnSwXJAJxru1FGDkop5
         Ik2l98iMPOzB2VPZmaDzqeoEQK7FSHI2ENKHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742364815; x=1742969615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ae4PagFT38IepvXpzRbslA5V5XToKvo9V6NCx8IDEps=;
        b=AirT9iI5Mn3F1dwgjyqFqAC1zMOPiT/b+Yz1krwGfqMZYO3FQvhs8RQHiRX6UCVunJ
         /Eb/Uhcea3YvnjJDCEvYJko0qpaGN27VYA3JePvXzsyOMoM0AzxBYuLRb206mQdg7q/x
         yK8MGe2PUEjBoE/g3r1M8Dhfa33IPh/rZuKtp6UUX72bhk/hngzhvqTPmqshpg9Wkh4M
         YKir0/iCzZVUXveWR8c8EhvCmpiYHLBC9zZV/cTebk8CZS/DM8DD85FwMy0apbD7Dsb9
         oW7kQljSgeeQ7jIcsi8k8EYo6/gpJBzNXxMdSnARFbl6pdOfRRHtXMBfgn0svgkOuiVx
         Pn6A==
X-Gm-Message-State: AOJu0YwgC3tvOjOkdgS4MbQDKkIp1mDUg0t22rBtk7hZgOXgd/yzNVMk
	k0HifRPSffWybHRaswj9dPCX4k7JzkVczMygq0lRn3vVhdzr37USa0bzGt97tAw=
X-Gm-Gg: ASbGnctkvMZxbXSZQpNd7d9H07bsARsdqZCXfncEyADeY1f5LFjNL3qNujkgZkFN6Lx
	cXGsExKIjJygudMFiQpsnuCmaKmmojAqRvgDyk98f9p95JRsBMA+77Iz1+oovSIw9JxeXScRUTa
	1p9yHba2xnghKGX5rkBeHLvpc2mERF6osD0+0pO0DnCXCzdXgAILfSNNEJY0mgqv2ZsVYUVQKD5
	BF3iuXafsE6XbGZ+0lzIjMD51aGuKerk58Vlk+fJ3o9jM0+9U9zo9m8of2v1id6NFd6HeQSyhht
	ZRHfTuodYQBDVWXGlpXq2scRSU5z/fDBS0qjG66KAMhhl3BznwZtkothENnUTfRqn9zzaDb471L
	kBcRX
X-Google-Smtp-Source: AGHT+IHce4wHjB8TrjarMeRb5jF9Qk1EWj8yU9d+p762t9eiTgkZ3MdU6c4esyFK68gM71Y2X9wSlA==
X-Received: by 2002:a17:902:e5c6:b0:223:5e6a:57ab with SMTP id d9443c01a7336-22649a7c112mr19578105ad.39.1742364815445;
        Tue, 18 Mar 2025 23:13:35 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf589b07sm645103a91.11.2025.03.18.23.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 23:13:35 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v5 5/5] btrfs: ioctl: introduce btrfs_uring_import_iovec()
Date: Wed, 19 Mar 2025 06:12:51 +0000
Message-ID: <20250319061251.21452-6-sidong.yang@furiosa.ai>
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

This patch introduces btrfs_uring_import_iovec(). In encoded read/write
with uring cmd, it uses import_iovec without supporting fixed buffer.
btrfs_using_import_iovec() could use fixed buffer if cmd flags has
IORING_URING_CMD_FIXED.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 fs/btrfs/ioctl.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6c18bad53cd3..e5b4af41ca6b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4802,7 +4802,29 @@ struct btrfs_uring_encoded_data {
 	struct iov_iter iter;
 };
 
-static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue_flags)
+static int btrfs_uring_import_iovec(struct io_uring_cmd *cmd,
+				    unsigned int issue_flags, int rw)
+{
+	struct btrfs_uring_encoded_data *data =
+		io_uring_cmd_get_async_data(cmd)->op_data;
+	int ret;
+
+	if (cmd->flags & IORING_URING_CMD_FIXED) {
+		data->iov = NULL;
+		ret = io_uring_cmd_import_fixed_vec(cmd, data->args.iov,
+						    data->args.iovcnt, rw,
+						    &data->iter, issue_flags);
+	} else {
+		data->iov = data->iovstack;
+		ret = import_iovec(rw, data->args.iov, data->args.iovcnt,
+				   ARRAY_SIZE(data->iovstack), &data->iov,
+				   &data->iter);
+	}
+	return ret;
+}
+
+static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd,
+				    unsigned int issue_flags)
 {
 	size_t copy_end_kernel = offsetofend(struct btrfs_ioctl_encoded_io_args, flags);
 	size_t copy_end;
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


