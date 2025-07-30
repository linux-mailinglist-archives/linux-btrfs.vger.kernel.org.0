Return-Path: <linux-btrfs+bounces-15745-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22484B15825
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 06:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A966C189003F
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 04:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ABB1DF738;
	Wed, 30 Jul 2025 04:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DETuxds2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885C313D51E;
	Wed, 30 Jul 2025 04:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753850636; cv=none; b=ZlU+JpaUrMR+zx4mQMBMvhllLLQ7jXOwLqyqvsu1m83i5Gy/1lpIBJmxNz7rvR0ijACeoXFvotl1qMXFvMopb9dwAHdZh4fZNeWuxmJF9CCmyIGvpu0LMDjAqgQrJtz2c6wKQ4/cM0SI/u2vVw9wP3a1tpYSGLrTtWle6L88zms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753850636; c=relaxed/simple;
	bh=ArhirCjSE+KuaG9WBv6a/37J3j7o/9JqWWGggu1xC8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QuP5F81lC6G/+4KGOHDQRxMOahne4PDf5x5lOKASa+Ksjcelb0Vla5Kznpu4ULr7vtd37dWHTXQ92P4NkiMtrlYl9Q17edmDAwCdCDYl2dH/RH2ziz3b7E8sJX6A8QW58VdI0zV0S2EmuLdbOf1qXeFd1jPNt9booNYksWRE4lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DETuxds2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24022261323so5708055ad.1;
        Tue, 29 Jul 2025 21:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753850635; x=1754455435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLDXGURs86h97z6jWxF3cuO6ta44E0HjO/F8hcc2gMA=;
        b=DETuxds2oaogpZCjlNVidNQB0MJiMY6wl5CPX0dZNveomY6yGP5m8YFA0OeZEnuWL6
         Bu+YZas0+57tceTo8/YTb2250goJyu/ZL3lVHF5YnV9SrsMvr+xZQHa1cuB1J5Nb7ESD
         YjN72Sy2pHpNk6jIKbvSex16ULZo+C2zROQgqBUOQAxCeQY61JzJoNYRNyeBAhWU3yR3
         V1ZyaCqmtyXe9c56q3ftOzDFfX1R4LFBM99wygPG6RiCHOOKvaMOfIYgPehzoLsX0D9S
         Ihuv4gg0Xpm1uZMBNNQ0E3YKJtrF62oQA3g6rMpbu+eCy4R04wP/zlazhBVcP8mhqRS7
         R5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753850635; x=1754455435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLDXGURs86h97z6jWxF3cuO6ta44E0HjO/F8hcc2gMA=;
        b=rSjyTVMutLAx6VBjVBOQXrxBLn8YuYrzcVhX5JsVk+0yWQiMuoUz07YOCchyLAMejm
         1/O+qJm7c/fwZ9g7MfWqDC+dRjISXvaifjyuM5C3JysEKMO1UiOmWt8S+cCind6doOQW
         9ayZAiEK2Hj2wAIJJiaUpWdHMXLOfr13hTNeuTBRxfNrL35q6DDlD34MeQrpCnMdg48i
         fGbnpwxu7MyVH/2mwqT282SsEJyDDoOVKg0TB3XbceV6LK/IkGR8N0ogAnDZkb12z7P7
         jwpE9XM/dI/uwYVFGW25qqPZ9d8aTvP/MM3tHotWmj+ro6cfcohWS/avS9uDTE9q7Gsv
         ezAg==
X-Forwarded-Encrypted: i=1; AJvYcCWxqrVbXZYftAr2/YwmQ3WhgHjCVx6cAul+Kj62GHA7j59FT+IjliaY75tDELadqQJz6CZL4txLVK7QrL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz77n43sp90QVe6WkG+FXnODbdBMKr/zid7/jPna7mCkbj3f/+W
	0uqT9cEVddd1dWQRRNoI7hgwDrU6alQxPmmTaHDZWIEgE1xdFAV2I06OvNt52w==
X-Gm-Gg: ASbGncuIjhxlRbsK7VDVlSx90//zfH6UEn4alTbHZimGxLpleXK/w94u4eUAAVq6wUG
	RIUX5bz+6JWkesjjHtONMLbZ5tAhor81Y3phb29/7g6DicecwTXl9xbixtKcyhxKFDri8hobkju
	FIjObOvabXTz2SiDhYKtxbpN2G8q6/7iMux/hvxKreEECyi0ucwm8oH29uRqGno44Itt3tBFFv3
	HRXlGa/gTcx2SF3XnsYBlOJBfV/OHOGewPIKSurTneHxVI9eRWm9V7YLQYtkS0HGTK4LZsHBu4s
	q4dIwryljobOLICMb0Xl2zf/2qGZNq3avwGdBDAhbnQa/48BLL2IoXblBagq/TNjRUS4qN5oO1x
	99btvBSLO6JcpVOULS8u/5ZL9vpx5MQ/nDDLcUsBBdElixem9AV7HTTpCMZAjzbyBusWHexM=
X-Google-Smtp-Source: AGHT+IGdXClyN34a3OR36rrME2GWuhkvxk4HFAhyz5PPjjhDPbYsTcmRm6jBKf0Fm+Bid2qa1Pt3UQ==
X-Received: by 2002:a17:903:190d:b0:240:3916:657c with SMTP id d9443c01a7336-24063dcb8d1mr77616965ad.26.1753850634738;
        Tue, 29 Jul 2025 21:43:54 -0700 (PDT)
Received: from mail.free-proletariat.dpdns.org ([182.215.2.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2403f335075sm49634075ad.185.2025.07.29.21.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 21:43:53 -0700 (PDT)
From: kmpfqgdwxucqz9@gmail.com
X-Google-Original-From: admin@mail.free-proletariat.dpdns.org
Received: from kernelkraze-550XDA.. (_gateway [192.168.219.1])
	by mail.free-proletariat.dpdns.org (Postfix) with ESMTPSA id 502CE4C064A;
	Wed, 30 Jul 2025 13:43:49 +0900 (KST)
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	KernelKraze <admin@mail.free-proletariat.dpdns.org>
Subject: [PATCH 1/1] btrfs: add integer overflow protection to flush_dir_items_batch allocation
Date: Wed, 30 Jul 2025 13:43:48 +0900
Message-ID: <20250730044348.133387-2-admin@mail.free-proletariat.dpdns.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250730044348.133387-1-admin@mail.free-proletariat.dpdns.org>
References: <20250730044348.133387-1-admin@mail.free-proletariat.dpdns.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: KernelKraze <admin@mail.free-proletariat.dpdns.org>

The flush_dir_items_batch() function performs memory allocation using
count * sizeof(u32) + count * sizeof(struct btrfs_key) without proper
integer overflow checking. When count is large enough, this multiplication
can overflow, resulting in an allocation smaller than expected, leading to
buffer overflows during subsequent array access.

In extreme cases with very large directory item counts, this could
theoretically lead to undersized memory allocation, though such scenarios
are unlikely in normal filesystem usage.

Fix this by:
1. Adding a reasonable upper limit (195) to the batch size, consistent
   with the limit used in log_delayed_insertion_items()
2. Using check_mul_overflow() and check_add_overflow() to detect integer
   overflows before performing the allocation
3. Returning -EOVERFLOW when overflow is detected
4. Adding appropriate warning and error messages for debugging

This ensures that memory allocations are always sized correctly and
prevents potential issues from integer overflow conditions, improving
overall code robustness.

Signed-off-by: KernelKraze <admin@mail.free-proletariat.dpdns.org>
---
 fs/btrfs/tree-log.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 9f05d454b9df..19b443314db0 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3655,14 +3655,35 @@ static int flush_dir_items_batch(struct btrfs_trans=
_handle *trans,
 	} else {
 		struct btrfs_key *ins_keys;
 		u32 *ins_sizes;
+		size_t keys_size, sizes_size, total_size;
=20
-		ins_data =3D kmalloc(count * sizeof(u32) +
-				   count * sizeof(struct btrfs_key), GFP_NOFS);
+		/*
+		 * Prevent integer overflow when calculating allocation size.
+		 * We use the same reasonable limit as log_delayed_insertion_items()
+		 * to prevent excessive memory allocation and potential DoS.
+		 */
+		if (count > 195) {
+			btrfs_warn(inode->root->fs_info,
+				   "dir items batch size %d exceeds safe limit, truncating",
+				   count);
+			count =3D 195;
+		}
+
+		/* Check for overflow in size calculations */
+		if (check_mul_overflow(count, sizeof(u32), &sizes_size) ||
+		    check_mul_overflow(count, sizeof(struct btrfs_key), &keys_size) ||
+		    check_add_overflow(sizes_size, keys_size, &total_size)) {
+			btrfs_err(inode->root->fs_info,
+				  "integer overflow in batch allocation size calculation");
+			return -EOVERFLOW;
+		}
+
+		ins_data =3D kmalloc(total_size, GFP_NOFS);
 		if (!ins_data)
 			return -ENOMEM;
=20
 		ins_sizes =3D (u32 *)ins_data;
-		ins_keys =3D (struct btrfs_key *)(ins_data + count * sizeof(u32));
+		ins_keys =3D (struct btrfs_key *)(ins_data + sizes_size);
 		batch.keys =3D ins_keys;
 		batch.data_sizes =3D ins_sizes;
 		batch.total_data_size =3D 0;
--=20
2.48.1


