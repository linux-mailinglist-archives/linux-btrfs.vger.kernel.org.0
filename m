Return-Path: <linux-btrfs+bounces-4617-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 381A68B59FB
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 15:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7E11F21B75
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 13:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A404B7172F;
	Mon, 29 Apr 2024 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Dfoip9kz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A5E76402
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397415; cv=none; b=H5iwgDguN12vWTn8NiTTW70AxRQHGQezNT4dP8MqpnJp7lj/VDIlJYK9rbW6Ku5w0Zq1VqcdfNvCcGfDtd3TyL5y2C+LFYhgxANnDHyldhOl4U7cmt1fzlrv7KCdHVhYFfjph9O+PjHnGOCPJJf5i7QnIe1+4RcrL9l3wj519ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397415; c=relaxed/simple;
	bh=+F7jkBQmkmoIeckuwT6GTxxrfy05mKxtygXblBRMeD4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dtvrpa5pzGwpl1sv3T3/PrxiNIahU3sKHFaq2Hku8GRIo+oOq0NGeM843LXpYV9tBV3WyQEdV4pG7V/IH3qRSDfFGhTMQS3QySnqPUJbDASTcrqvGdtUlb7i1I5NnLgpzYXu7L8dGUvu6coAab2VmnE69bpi/UHAcXQn+m6lzkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Dfoip9kz; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43716ff5494so49297931cf.0
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 06:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1714397413; x=1715002213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLxhZSPgQ2ipmv45seTklPvQ3XnyCFN2Rew7PILRrPk=;
        b=Dfoip9kz3pHfccG+9WTjuaqj9sQ5agO6N2B//aBAwDDXjU6QBHMOfZGtFBVMGSDBUi
         jDwMxZkR54yHBCT4nfIILC2y/MXU/v3kEY4P8oOGZrUDEngLrWBLSiTmJiz4YrFqrOqb
         ihAgVDlE/ZpjQ8yUs9mEUncuYoXQ9j8lkgI5Zc/SdL8g59q8kspZ5efsXSTZyBrZaUBB
         bLQzS/LugEPDQrs/rpsTCqtODiRmFM9TuBazabFU6XHz2g7h7S1KK2ZsT2jRLc7+hJu3
         /siubosWFIpvt3HUPSZPN7dG/sssrmgaU/WOxK3O0Stys80hjXkvNw/kcxIT9gqW1Flj
         pmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397413; x=1715002213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLxhZSPgQ2ipmv45seTklPvQ3XnyCFN2Rew7PILRrPk=;
        b=vHEzYH6inEL5uAsslPDJgJHwPLiNIES0zKqLiTY9BlZS5/7s7yfmYqIyPqnWY8XkR7
         lzpzonUsQnL5DbRIWAdDrQftvrz3K0XDbbd7yPbN8nvzQ+LZ5fInnKpAn0Rix/7xPpVu
         boL4Md6H1ZOpLUDkp9sw3lZIkRigqGFC4kVV8GNdMch3U+fWLWxRDjKJqLcd4MQh4WRa
         T7PqErROZmsPGcRPfYJOQLhXuqwx5AhrFhk2T6kTyGGGw+XhiiEAtVF6Jo11RBiV76+H
         y0SqtmIqxryq2REoVwSVx0QRSeN4QeBLWuG4/Jpe0OASCY8LKPo2+Vtu9zY+uhb7h71d
         zwLg==
X-Gm-Message-State: AOJu0YxutVC5pE+UMr7d0ehoa7B0jTGCRELgkHa7LZpLQwc0cvcjGYAM
	E4BTtSzaY8GD+jII9wem+3IZXSbfpvL8Fa2/o4Atcq1dhIoBFFh88GrJLmV1PgMRsZTWVuaPWXf
	h
X-Google-Smtp-Source: AGHT+IEdwMlg9hvB+FkgsFYyWO/gBgZRO9/l4ErYvdkS6DUQFZvyldOHyFYOF4kDFpVi8fMuyGsSZg==
X-Received: by 2002:a0c:ec87:0:b0:6a0:a9dc:b11a with SMTP id u7-20020a0cec87000000b006a0a9dcb11amr14541922qvo.3.1714397413304;
        Mon, 29 Apr 2024 06:30:13 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id pp6-20020a056214138600b006a0d7154d13sm256381qvb.78.2024.04.29.06.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:30:13 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 14/15] btrfs: handle errors from btrfs_dec_ref properly
Date: Mon, 29 Apr 2024 09:29:49 -0400
Message-ID: <0aaac24b838a9bfe51987b1a30d02cc3f567c879.1714397223.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1714397222.git.josef@toxicpanda.com>
References: <cover.1714397222.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In walk_up_proc() we BUG_ON(ret) from btrfs_dec_ref().  This is
incorrect, we have proper error handling here, return the error.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 44d879b673f9..9228cdfc1cba 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5812,7 +5812,10 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 				ret = btrfs_dec_ref(trans, root, eb, 1);
 			else
 				ret = btrfs_dec_ref(trans, root, eb, 0);
-			BUG_ON(ret); /* -ENOMEM */
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
+				return ret;
+			}
 			if (is_fstree(btrfs_root_id(root))) {
 				ret = btrfs_qgroup_trace_leaf_items(trans, eb);
 				if (ret) {
-- 
2.43.0


