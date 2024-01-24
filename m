Return-Path: <linux-btrfs+bounces-1729-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC70283B03A
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AE2DB2D61C
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012E7129A8B;
	Wed, 24 Jan 2024 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ITYjqn5H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48AA129A7C
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116810; cv=none; b=JvjMCW6FSwpRgxwK8PoZ6UCkS5auKaAafqaZDo9fbesydSdXH3uLHmMrXS11IF1PYugcqtnKFeDNpNF8GQJ1o2rPpkFoyZFrFuVHFGp3r7otIjxMNuTcv1Qjysfwg8xdxgqdMqPWP7N+T3vyfsvJnqCpx83qgH3UM16uzKWTqaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116810; c=relaxed/simple;
	bh=aMZ1sG1wIZ909hXg3gcCjxQ2chtHW6W4pOfZATtQZWo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+xdnBK98/ISQrQLz/VZzdGKQThK81chNH1SbyKDsmi9ZRYw8PPxI4FfD6jPL8WSoLUTjvdGOP9xY0Aku5dTZFWpKe7i8yORMdv6HFeY92nwUPW99/h+xNBFktSXyHmcMPNVzjmKcCuMrhkY19fkdSFOzZQAF9X1Bi9zfMIHh+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ITYjqn5H; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60036bfdbfeso24004697b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116807; x=1706721607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Z/7Zf2IcaABhDb97kzy5ILjv4RdFqj8Flmg1tg10jg=;
        b=ITYjqn5Hs3XIjqC0Spinmmuen7Z0YPA+UNPI3n3dB63IlXpWpFMe5Q6N7xpRoIwHYG
         55y5Y/Fg685b+sH5kuF8WxeiJyG5CkOhMtird0xDPXmUDByCfdVckx6X/1Q/nCML+sSr
         FpFgBzm//LTXETuwIMso7belBK2gSJ0bh23GP7LEgZDByeEEEU1uvHsrj3gMWnWushoy
         JhquLVaAybVm0LJjUmrv2YYuWlJ8phm7C39ZbBPSDUcExIntBsN2kIzySyErpfZH46D9
         8yAFp+wIACqZcLGDdYONXGiEcV97KgqKkSIFvDBkjfM0hV6jA3uarE3CKDUsQYs6xIhF
         ezuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116807; x=1706721607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Z/7Zf2IcaABhDb97kzy5ILjv4RdFqj8Flmg1tg10jg=;
        b=g/ezJFJfoYMDFOqoX21VB9kma+yl1e6CNFnyzp6cHU8cvW6sW4QjyVywI3xtNWq9Gi
         +HBI1ajeg0ftdSjfeIogNrP9O2mcc5N2RGtrch/IUSPRTCbvKzxG/KwHgMgN0XgxVZvR
         viGjEoUtvl77hxnuGBsQ9qpv7RWsv4cUqqmseVoVHtGyHDWOhCELJBOS7CKIv/I7bdwg
         zGJmvPAaeLH2uQTkL1MyNCTMYJP0hnLHOoUYXjeQ6CLqu+zd/GzXDnbHD+GVpZYsdG+x
         U71GLDdx1aPRgzKd28/qu/Qi8tJbYGNxkOcsbpJUiB88T6E0ZB5M5z+X+WCvkNtAjNNf
         6TPA==
X-Gm-Message-State: AOJu0YwsHTMTfKxfjWDOAds1hGkmTWtuKeXRPzXB6l2oG3zlAOfpC4ct
	fIHVgjM1ReMT7Z/TniRyKQAvjzUvWanj9ubK2JhbJrOyp0hrVUTmcVWC5x4TiBEm6MriQeT7FmI
	e
X-Google-Smtp-Source: AGHT+IGDKuLNKmL6oQGAAFpJH2gkFDfQPHGzcNvDdTWKiSZX5/hBjzY0G5PDGiIQbJsZmlm8G2DQDw==
X-Received: by 2002:a81:4e05:0:b0:5ff:8117:4e7e with SMTP id c5-20020a814e05000000b005ff81174e7emr1152145ywb.70.1706116807669;
        Wed, 24 Jan 2024 09:20:07 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id s10-20020a81770a000000b005ff93c11cf5sm60774ywc.100.2024.01.24.09.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:20:07 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 47/52] btrfs: load the inode context before sending writes
Date: Wed, 24 Jan 2024 12:19:09 -0500
Message-ID: <a307def01bf28c3ed99398868a142180c6088527.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For send we will read the pages and copy them into our buffer.  Use the
fscrypt_inode_open helper to make sure the key is loaded properly before
trying to read from the inode so the contents are properly decrypted.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/send.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index f4680f72e148..d26ca7b64087 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5392,6 +5392,38 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 	return ret;
 }
 
+static int load_fscrypt_context(struct send_ctx *sctx)
+{
+	struct btrfs_root *root = sctx->send_root;
+	struct name_cache_entry *nce;
+	struct inode *dir;
+	int ret;
+
+	if (!btrfs_fs_incompat(root->fs_info, ENCRYPT))
+		return 0;
+
+	/*
+	 * If we're encrypted we need to load the parent inode in order to make
+	 * sure the encryption context is loaded.  We have to do this even if
+	 * we're not encrypted, as we need to make sure that we don't violate
+	 * the rule about encrypted children with non-encrypted parents, which
+	 * is enforced by __fscrypt_file_open.
+	 */
+	nce = name_cache_search(sctx, sctx->cur_ino, sctx->cur_inode_gen);
+	if (!nce) {
+		ASSERT(nce);
+		return -EINVAL;
+	}
+
+	dir = btrfs_iget(root->fs_info->sb, nce->parent_ino, root);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	ret = __fscrypt_file_open(dir, sctx->cur_inode);
+	iput(dir);
+	return ret;
+}
+
 /*
  * Read some bytes from the current inode/file and send a write command to
  * user space.
@@ -5415,7 +5447,9 @@ static int send_write(struct send_ctx *sctx, u64 offset, u32 len)
 	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
 	if (ret < 0)
 		goto out;
-
+	ret = load_fscrypt_context(sctx);
+	if (ret < 0)
+		goto out;
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
 	ret = put_file_data(sctx, offset, len);
-- 
2.43.0


