Return-Path: <linux-btrfs+bounces-10004-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A689E065B
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 16:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52104B2A335
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 13:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8F31FF7C2;
	Mon,  2 Dec 2024 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wdaj6ome"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B37B487A7;
	Mon,  2 Dec 2024 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733146532; cv=none; b=GYRFe44RKRzQIuoaEQ0aBx4FEqgLzo8Do4Sebis+ehV/I3+1PE4DiFNSEabLFXYh9x4A6ZhPLg7taXhiuK4GyFeJMizC+diF0x1zzFN4vWofYQGF8+VuuBTfqovGcJhimWXIGgJ+bV96rma28s7Gv+SMBWQwNmCb42UatNh2Rvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733146532; c=relaxed/simple;
	bh=V/FYbiOCT/kCYaD6GFDAm/P64JyKs93uEeMGrr1MmVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qjzbA96BQ4+nkZl5c1vgx4vtvcFCb1J8rw3qzyPn5SdgD57sM2oLM8FJNcBCc726j3vX4HtIDXezudQdBZI5SDpO9q/SoqFYFs8K89LzSBfuEiGLlG+KKmuCt6iJpi3oGnsJqz4Cv5Tnh7JxxcRwKQwv5pPKWd3dWtbHzRPZers=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wdaj6ome; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7251abe0e69so3580613b3a.0;
        Mon, 02 Dec 2024 05:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733146530; x=1733751330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smgCxmLdHKKh3ZFHAWScvE252cZp2nZTWPB+7MjJ3cI=;
        b=Wdaj6omeuHj+KO+kHKpLUOUGi+t02yOoKQVEL7y/clxG6cwOvhtgnZi9K/4cKMKrz0
         vGFO4rrMPVyGHwUXnZfnQ+tjubmOeWTvSC2ZgpuBLIjMByOd0EKtCpKiZwceqKwfaZ1D
         72uSb1QmJecCj3MgzZQbi4WOEXoTKZpCMVT/hCcsm5ose6xLeWfDiwGBHxQRv5X1YwEF
         Xbbvt+u0lTSLKCvaFVI1Enu6U+jEW4v0zZ4IzWtbywvoUsOW9yDIqffpK0F1kuqcinre
         /R9HqogfNL3ec7clRYw6QPENvc97ANEGW/sdaNloFJxO4MAUmegYe7fTjkkIsyqwCbc0
         LNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733146530; x=1733751330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smgCxmLdHKKh3ZFHAWScvE252cZp2nZTWPB+7MjJ3cI=;
        b=TqE85tudwfOXmJR6MB/nKueGENrlFwjUMjSy63TPM0YobVlHG+4iaNoAuvD86Q/8Xe
         RiLjk8zVWcI6ZMmTanVV8ixyFVRhqQ9bkk9J7nsBE+dbIPY8YgYjlMol6OQhdUhA6Ktf
         DNZ30SaG3BP6kk0Xy2t6r1W9w5BrfoXF5W1eKa8WE6sJfPgDhLuRjbngV2sYgsXxXHp0
         rv/wRhSd7dL1eLz06f7AhisaKrko8C7wRu/V78YpNx1yB3xN58OEZXwMPACOEfeAWP0a
         I3FdLdq+xW3ZEI65h7Q/7K2TKYlc/AtntD/Y4q+xW2CTViRgOzeztrMmmt5LP5nPrKLN
         0dSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnxVbI1j7jjbogJ8rPcZys85qNTtQr8moe/kfTdoyPhE5MOFmBSOO3E3kNBC9XkNMe6pskUzxM5lIwfw==@vger.kernel.org, AJvYcCXy+yqgLDhdf39NtVbBg9cxUCWX5b6DKX8L2oP+eIrjLpnlOojUAG5loSR1jgsZhhJnaPe/TQwDPyOp2dqy@vger.kernel.org
X-Gm-Message-State: AOJu0YzwjSbMPPd/ttw/FhK/s155hOPHIWFLYOg+IJ4MhnzRC94aoNi0
	QKEfekKDAYguXdauvkaseiAEWyOhAHxRHy5pW95JP2viD29vp6cG
X-Gm-Gg: ASbGncvj+Gc1LaZCNzK/uTVUTf6SHEMR4OQq+w5TyOul5o+K/Poqp4TJxM5WursjEft
	SHZWKVNs8pzUjvMKOF6RU+HHtFHADAvcj1QtKBcITCWmQHTPkGfHSZuyFUXXMFY1VLJEJ2ZgC3W
	WDVT549zmVa1vKslGvNeTdfcLyZVKStIK93SurUErG3fh4ZOz8d8KmU99uzneFVvheeFSsD4R6P
	0kRD4J8w8rMdwJbxInY6k4vPnFL8RgUlIJjZUI6RivQXoIH7YizS2s=
X-Google-Smtp-Source: AGHT+IGlwAR3awVGb71fvY9wlnif2ljpg5ny/0usUHsGm36aFN4TuwUXBwIVFcf4ZN8w31L9Y2yTMA==
X-Received: by 2002:a05:6a00:845:b0:724:bf30:2d39 with SMTP id d2e1a72fcca58-72530043feemr26579504b3a.7.1733146530264;
        Mon, 02 Dec 2024 05:35:30 -0800 (PST)
Received: from localhost ([124.127.236.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fbfdesm8448059b3a.99.2024.12.02.05.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 05:35:29 -0800 (PST)
From: Hao-ran Zheng <zhenghaoran154@gmail.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: baijiaju1990@gmail.com,
	zhenghaoran154@gmail.com,
	21371365@buaa.edu.cn
Subject: [PATCH v2] btrfs: fix data race when accessing the inode's disk_i_size at btrfs_drop_extents()
Date: Mon,  2 Dec 2024 21:35:15 +0800
Message-Id: <20241202133515.92286-1-zhenghaoran154@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAL3q7H5U_88NA2PmyMvtwv1aZ7k+V6v=eetp7Hs2HqDdfVjokw@mail.gmail.com>
References: <CAL3q7H5U_88NA2PmyMvtwv1aZ7k+V6v=eetp7Hs2HqDdfVjokw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A data race occurs when the function `insert_ordered_extent_file_extent()`
and the function `btrfs_inode_safe_disk_i_size_write()` are executed
concurrently. The function `insert_ordered_extent_file_extent()` is not
locked when reading inode->disk_i_size, causing
`btrfs_inode_safe_disk_i_size_write()` to cause data competition when
writing inode->disk_i_size, thus affecting the value of `modify_tree`.

Since the impact of data race is limited, it is recommended to use the
`data_race` mark judgment.

The specific call stack that appears during testing is as follows:
============DATA_RACE============
 btrfs_drop_extents+0x89a/0xa060 [btrfs]
 insert_reserved_file_extent+0xb54/0x2960 [btrfs]
 insert_ordered_extent_file_extent+0xff5/0x1760 [btrfs]
 btrfs_finish_one_ordered+0x1b85/0x36a0 [btrfs]
 btrfs_finish_ordered_io+0x37/0x60 [btrfs]
 finish_ordered_fn+0x3e/0x50 [btrfs]
 btrfs_work_helper+0x9c9/0x27a0 [btrfs]
 process_scheduled_works+0x716/0xf10
 worker_thread+0xb6a/0x1190
 kthread+0x292/0x330
 ret_from_fork+0x4d/0x80
 ret_from_fork_asm+0x1a/0x30
============OTHER_INFO============
 btrfs_inode_safe_disk_i_size_write+0x4ec/0x600 [btrfs]
 btrfs_finish_one_ordered+0x24c7/0x36a0 [btrfs]
 btrfs_finish_ordered_io+0x37/0x60 [btrfs]
 finish_ordered_fn+0x3e/0x50 [btrfs]
 btrfs_work_helper+0x9c9/0x27a0 [btrfs]
 process_scheduled_works+0x716/0xf10
 worker_thread+0xb6a/0x1190
 kthread+0x292/0x330
 ret_from_fork+0x4d/0x80
 ret_from_fork_asm+0x1a/0x30
=================================

Signed-off-by: Hao-ran Zheng <zhenghaoran154@gmail.com>
---
V1->V2: Modify patch description and format
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 4fb521d91b06..f9631713f67d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -242,7 +242,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 	if (args->drop_cache)
 		btrfs_drop_extent_map_range(inode, args->start, args->end - 1, false);
 
-	if (args->start >= inode->disk_i_size && !args->replace_extent)
+	if (data_race(args->start >= inode->disk_i_size && !args->replace_extent))
 		modify_tree = 0;
 
 	update_refs = (btrfs_root_id(root) != BTRFS_TREE_LOG_OBJECTID);
-- 
2.34.1


