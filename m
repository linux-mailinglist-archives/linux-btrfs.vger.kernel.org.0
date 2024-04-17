Return-Path: <linux-btrfs+bounces-4368-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DB48A860E
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 16:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41B57B256CF
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 14:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E548214265C;
	Wed, 17 Apr 2024 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="i4V087Sj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ED914263B
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364582; cv=none; b=tNIKyhAqR5+ugmyp9UJGhfxVuuZg4LeSjB8CyQ3Kui1NYjJwd7YeUaV3ERRmPF1xG9cxUE07/LuA9GAvfSN7un7RuBVtzLiilxAVv2IHsjQVIC5jOO0pYITjNCo3geNe1NuZVw98WdxCXpCx3+6mmbSys4dH2HjdAwwZgMEJ7Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364582; c=relaxed/simple;
	bh=00hgfnVhoBcXg8GEywqQ4h/LLh2FYMxEtZlJ3iaidzo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZ8KSgiYQwNN+TxCKxUKJ7wA67yq56faoEWxkVnwaDUH52y1j2HsS267pbnSCtdR8v+JDOEysbByMBetnIYdoGl6J6CL4pHYez2FKvwWtJ2u+s++xi0ZSQEDN0BECd44ArgpT5RYANYsGG4GvNYqBF63E7zcKrmkZAjbV+RhfIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=i4V087Sj; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78d62c1e82bso377975885a.3
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713364579; x=1713969379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3op8i+QWOUfFMTbxcqBbWv42/JXJbDNCJwjyc1OBwNw=;
        b=i4V087SjH+t3EOCa23HUn415XzdCe6LdOp64E+av66rLdaoc34BxJdo33SXV8uDlnP
         Mrc1KANZuZY2fiseum2WzJ/3dfFaKDv1ZwcKEf1migxUYIczJLVbbUMGYUt6dFDpw57h
         gNNxbnD/qPPO9Y6aKYjQiF7SUIdozZupAHwmByxu0C6e6cAMQv3bRZW+25mBI7aRpHTb
         iL/fk5dqbi4FO/N/fq+NTj4WmIDXvA2rHPyHsghsYIZTG9lcxZGnDXNwCkXWrlfqZvKT
         dhoct+Y+ykGGms+uYi4aUMg6ANPTkoSlJtkDvciF0aFOr/xYj7j1XiBFZKgLeZSjq7DA
         amuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713364579; x=1713969379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3op8i+QWOUfFMTbxcqBbWv42/JXJbDNCJwjyc1OBwNw=;
        b=jzYiTeuqAEjelVPw0UQ1PlmHZi09IBJEoTcvZHHHYHOjzLBsiSA0DfRzhqQ2VIAHCO
         TZGycL9pqqG3td++lrAkG/P2x594zGmhnqkIskXPoXaw8Uf1kezP500Drpp7LkcxI/Ws
         Qf9muMRwaAriwPOQ5hGDrMmLxxVUDd+N/iNa3aHoAfZ/xDdKrDitRxAIkM/CcFZMVWhX
         IG6glvVMjZ9hhNoyblKXvI0oflAIKUWUjPzaRuFt6C/Kyt/YEKkOHEwr7B4hhbFSX6yD
         ChAmHajm8alRchF++Ye7dv0h0gXoUW8aVo9m47KgB+Uz0dwBWQ4ghtl2MBtgztwBirxj
         kghw==
X-Gm-Message-State: AOJu0YzGFmO79uCBT6ehczodKILFoT98mkDuWJNgGW+6pVNdFr+vSb0V
	ytrczF5AB2/mIJOuSPE6rEV1TjzpE7lLt/SqVyH+fDqBRVlMQHcis93qpfCQO8wyBxSjxTZRD3e
	S
X-Google-Smtp-Source: AGHT+IFFuEv9YQqTmPxo+qAtTjw7H+dYLlFfWXGy0/JMezpJ20IeCSN9MzBzDYfgDIRHu1vAseywjA==
X-Received: by 2002:a05:620a:521d:b0:78d:4dc2:5f94 with SMTP id dc29-20020a05620a521d00b0078d4dc25f94mr15836667qkb.2.1713364579638;
        Wed, 17 Apr 2024 07:36:19 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id wa11-20020a05620a4d0b00b0078ef9ad16adsm1175746qkn.130.2024.04.17.07.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:36:19 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 11/17] btrfs: push extent lock into run_delalloc_cow
Date: Wed, 17 Apr 2024 10:35:55 -0400
Message-ID: <139e8e88fb6e8eb6203ae211b0e7056729e6ed81.1713363472.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713363472.git.josef@toxicpanda.com>
References: <cover.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is used by zoned but also as the fallback for uncompressed extents
when we fail to compress the ranges.  Push the extent lock into
run_dealloc_cow(), and adjust the compression case to take the extent
lock after calling run_delalloc_cow().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9066d248b9aa..b1ae3308ecad 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1167,13 +1167,13 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 		if (!(start >= locked_page_end || end <= locked_page_start))
 			locked_page = async_chunk->locked_page;
 	}
-	lock_extent(io_tree, start, end, NULL);
 
 	if (async_extent->compress_type == BTRFS_COMPRESS_NONE) {
 		submit_uncompressed_range(inode, async_extent, locked_page);
 		goto done;
 	}
 
+	lock_extent(io_tree, start, end, NULL);
 	ret = btrfs_reserve_extent(root, async_extent->ram_size,
 				   async_extent->compressed_size,
 				   async_extent->compressed_size,
@@ -1722,6 +1722,8 @@ static noinline int run_delalloc_cow(struct btrfs_inode *inode,
 	u64 done_offset = end;
 	int ret;
 
+	lock_extent(&inode->io_tree, start, end, NULL);
+
 	while (start <= end) {
 		ret = cow_file_range(inode, locked_page, start, end, &done_offset,
 				     true, false);
@@ -2280,17 +2282,14 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 	    run_delalloc_compressed(inode, locked_page, start, end, wbc))
 		return 1;
 
-	/*
-	 * We're unlocked by the different fill functions below.
-	 */
-	lock_extent(&inode->io_tree, start, end, NULL);
-
-	if (zoned)
+	if (zoned) {
 		ret = run_delalloc_cow(inode, locked_page, start, end, wbc,
 				       true);
-	else
+	} else {
+		lock_extent(&inode->io_tree, start, end, NULL);
 		ret = cow_file_range(inode, locked_page, start, end, NULL,
 				     false, false);
+	}
 
 out:
 	if (ret < 0)
-- 
2.43.0


