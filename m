Return-Path: <linux-btrfs+bounces-9991-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B7E9DF561
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Dec 2024 12:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5598B21044
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Dec 2024 11:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB54F148FE1;
	Sun,  1 Dec 2024 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jv0/LLtO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33484087C;
	Sun,  1 Dec 2024 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733052357; cv=none; b=iLWJ3kEzJSJqo4q3oKffVbhHlfqWSaHxpN2jbVQgPfbrFotHo8o/uj+xAKdGBlcxxjtMGiw6Sl7gOSd2LY7sfT4Lf1mX1so27z9Gu3RfnVEtCEnssp8pYktAdraA+ctac0MNbZ3EWoa01zXW8Re+kYcsQwfJMU4NXyR9b4Uq0+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733052357; c=relaxed/simple;
	bh=aLiPd1ZyaA4vE6FaBl/ubjUjIvKFEI+ix8HCLTCzUHk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GoOqcv2f8Fh6m9VqIIvuGSEuHQxp5P+8So3EcXv8XEJ0Thzi0zhilNV+rZJtRJKD260BQF1u5qNoaJLN6DBYozqUjKL/YvMVe8GWeihVnWa3XqHwgV2lafx9RVAbkKkn+rvAiJUuYMfZaCBYf6RKP0Hi7iczTxVqaKC5UrSPHyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jv0/LLtO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21583cf5748so2077315ad.1;
        Sun, 01 Dec 2024 03:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733052355; x=1733657155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=diXW2Q6TDuLVNuEyV9kd48FoXlCkptaJhvtTgIMi2ZU=;
        b=Jv0/LLtOMHsaXa2wjS9nm0Soc6vmunhFJGnqfl6xwsgqsx2yvauf/pg5EGv+LtngBQ
         DZ6OXFUi6adkfaZPzJyoK27oqX3Iqz37yLzLksoW0ykokfdnJaXpP8mgOvV6ecZ1vwrj
         NpPda9n1JWOfqc7hnDV4cw2cNB43b1kBtVbZOMcxh1W2yK3bQlPaqkS8zaQ+RzfhaMcK
         muZIx6gFlLNptkwPYQfXRu5E3sF3GFtiKT/kTe8fYsZ987x6zR/O/ISQUdDqNqjiOtjg
         fUefdMJ/ZUu1h9fBrmPCN077xsLsAB5PQhVzOu9k+exG8spE8JUcmKjb2gvbM8IDMF7o
         KIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733052355; x=1733657155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=diXW2Q6TDuLVNuEyV9kd48FoXlCkptaJhvtTgIMi2ZU=;
        b=RdZtG5XeWKZRg0x9eh1Ti2B023heSxF4OsL1MntKriH37AJOrSwUTyCNQ1jlstd8hq
         FR6H/r9DsqBvczf2Q2TaI4kM2XFQYfD2HjJ4zyR9Tg0W6GjupC3o7ajdqhmsPSepgoRf
         /afpFRz+bxOIuODYnZWpRBh/s+yrc8ZStTyIpAhiWbqkdX6jZfvTW6msAzdL0c6kRDTr
         pXs8NSaC497YYOvJIDLE5aOtue0BkyXnf5AEAeeNPYZi9TgR/1CDpZtlEi9msFLurgFx
         7jnrJwymfxpcsv+54o6pPIRMjOve3obVlBljMvpwrNWT1E2tDSMQSc/5h6FaxJkGBbR4
         dxYw==
X-Forwarded-Encrypted: i=1; AJvYcCVNk82L9at8NnPJyN19HPEpVIHlMd5oKDYfCCmyxk9TnQH1qNo6GmxxdzvZW08KM0bd6VySVGh2FDksDw==@vger.kernel.org, AJvYcCXxaaOQBHP/mAyTRrimM8ROUbU0S8yNThDtjtGKyE6nyMheR7LAA2VE7kvzb6aic0jcvLZaFO7WNOdrT7lJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxPgEQau9MvLYys16OwHp325YEPDu/zJKVGNaAMNLa7PlQKxXrd
	zYtIL2rLtxskVs4HuDdm1qvBuEXXc27dWPwWoDbe3OjHbraTS3yWpYH1SfJZ
X-Gm-Gg: ASbGncuiazy1yPBnJiNGgMhV4RSnZswVIVOvQ/h+VGlTISbazH+HL6l8aCqHLscmfvV
	PFrQYqN08vGromhhzBTcY46WoeIiwgTzS6JC+fRAk6+1GSAy4Ck/fqSZW2MOJ8ddy9oLgySAxV8
	Nev4Z/b1ZO8RqrKkM9v+yMbNWXDFBBsxI7XeyQltucMDPG9MKP7pjntBJVlxhHqoNYRLEvUs7rT
	1VBe7BheixGG+Znqjr1dp9+GmZ7G4GOAJqVVvZoHgOg1zi/vwtfIfU=
X-Google-Smtp-Source: AGHT+IGyBGwyQSGiO77wbbGoGqjqTKzW9iv8rVk3Vf0qMZapEJS5NZnthWmso9hbYGHYXcSh2Xlcrw==
X-Received: by 2002:a17:902:ced0:b0:215:6f62:3091 with SMTP id d9443c01a7336-2156f623995mr37704435ad.20.1733052354938;
        Sun, 01 Dec 2024 03:25:54 -0800 (PST)
Received: from localhost ([124.127.236.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541761474sm6470379b3a.32.2024.12.01.03.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 03:25:54 -0800 (PST)
From: Hao-ran Zheng <zhenghaoran154@gmail.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: baijiaju1990@gmail.com,
	zhenghaoran154@gmail.com,
	21371365@buaa.edu.cn
Subject: [PATCH] fs: Fix data race in btrfs_drop_extents
Date: Sun,  1 Dec 2024 19:25:50 +0800
Message-Id: <20241201112550.107383-1-zhenghaoran154@gmail.com>
X-Mailer: git-send-email 2.34.1
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
`btrfs_inode_safe_disk_i_size_write()`to cause data competition when
writing inode->disk_i_size, thus affecting the value of `modify_tree`,
leading to some unexpected results such as disk data being overwritten.
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

To address this issue, it is recommended to add locks when reading
inode->disk_i_size and setting the value of modify_tree to prevent
data inconsistency.

Signed-off-by: Hao-ran Zheng <zhenghaoran154@gmail.com>
---
 fs/btrfs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 4fb521d91b06..189708e6e91a 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -242,8 +242,10 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 	if (args->drop_cache)
 		btrfs_drop_extent_map_range(inode, args->start, args->end - 1, false);
 
+	spin_lock(&inode->lock);
 	if (args->start >= inode->disk_i_size && !args->replace_extent)
 		modify_tree = 0;
+	spin_unlock(&inode->lock);
 
 	update_refs = (btrfs_root_id(root) != BTRFS_TREE_LOG_OBJECTID);
 	while (1) {
-- 
2.34.1


