Return-Path: <linux-btrfs+bounces-10020-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A419C9E151C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 09:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70D3AB2A0B1
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 07:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B721B87C5;
	Tue,  3 Dec 2024 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7P6EOTd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7701B1AD41F;
	Tue,  3 Dec 2024 07:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212619; cv=none; b=N4MXE0PNDRB8UR1QE+Oc4gsUt2pVkqWQr6X4c3z9NydlKuuM5zlJ5o3TWmeWg+PRRuzPmZ0GNHQ4DjpvJ6cu3Opk+QfxcAQoKemtT6FB3kKGO+/FwsMhp7DgZ1PAyO/AxtlPD9ObhiSVtjToJtaXADUamBSp6J81GwEMjy+/DVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212619; c=relaxed/simple;
	bh=QUVDHU0IjAcTgbw3CCMufUawOcfgwSEz6clrhCZ06KQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f9qW8sP5tNz1sVIEGsEuMjA8vQY6JQZ0P5I26pHMkK6LgkUdSGJwsydwfqWxd/KBUefetMuGNY494WXTiGpID/N/KgWXz/+nM9uJlzRIr8hZOCk0Pc/93zdMRoAFr/n/bFOHc3sedLGtCNRRS7ZQ8vjDS9U+lRFpj8YPcLoAC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7P6EOTd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21577f65bdeso16405135ad.0;
        Mon, 02 Dec 2024 23:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733212618; x=1733817418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hMYGLHfU7+KQ2fFLiW8OTlCvCX1GYDLMCzf6zrjTTU=;
        b=C7P6EOTdBt0C7nKdfypUuHcPnJmyGvNoBn7+RyFeoB57kxbuJdgFTXHqKntN0WCpFK
         LczKDvSa/2FREyKm/qW3EDGBp7nOoKRvjYDZb7Vrit85Zr3Q+Xg5LMbVQssxcmFv1aVE
         yY7mIVrGaWnwjj4HayHT2An0MhZBvx6ljyWzUfI7deyZ/g1cGqExs7DfoXODAHtICwV2
         FZi50w+xURpeC+a6zqJLAuuIp0mZWtAACbpGFKKSxlSJMR7B2lZvbkGAKbOcemsi6Yz4
         1sKace+i7pnCbf0kftYTKa4Zalv8k8tH9O8bJC546otoZ0L4op1XDJjFratIgmmNxoRb
         yHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733212618; x=1733817418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hMYGLHfU7+KQ2fFLiW8OTlCvCX1GYDLMCzf6zrjTTU=;
        b=OND5ylueraAhii/CR/uu/HEpOJ4wAVXkEKCxD8BhU1hL32UyjoBartD+E60cHGI5Q6
         hlWPdGdA+UNdwedkExWiven7x4sEE3hSq7n0Ll0htQV6opDgnwg+KPruy6jdhBMhnRJY
         6pyYni9hmZgffwxrns5lk8DlU1HImgcjHcOdrldam1lQupg39UGzxdQPpeAuqu07y/2V
         dEb22bAvYKg8l/BVe5gAKyiS4W56hegFkwq4p/l0scwr83xnVpvNkYE1PGcQKW0/ZyVb
         LIO4+dvGKUhYi0mEAFA8UWPziGECEoIYANG6wfAnDQLLMfjcDFht4NlUB6TjQfhTip/Y
         jWkA==
X-Forwarded-Encrypted: i=1; AJvYcCUBNg63tpIFqGeG08c6kGEx4Q+ZqyEEPMKCTcaGlKD1AnboXoKwaRv2t1cnxwyEfnMMEBLnjFAf15QpfA+D@vger.kernel.org, AJvYcCWaF+tkjwG35S0ZBpdyhClcWpqnJ0Nrsr63kaSyf/CBHjwcKl7+8kn/kcJBHdF+yJo+ExrmzRcm0CjYsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUhjaiVMLCcD7lG8W/3sAL8h1hBgUkf+Vpv3OEgJ0a8MbIQLNc
	9dj1PJNn+HKUAlli+XgTgTgcC3KUtdvoCqXMtt8XKWrTXutyhKFWizkDOT7SPyA=
X-Gm-Gg: ASbGnctCexFwFHxkrHVrF/flpcDAt3ouykPMgtUJ0zv+FC3RFZ9d1xnFiTqQsQ0xSl+
	AJd7OgPugR5cu/6A3MM27UZ+QO5+88OtBttw4U+kQeVyhpD+MCCXRlOf95yZ6hLBRDDBz372tH8
	HOF4oCnchdVuVTv0ZrNZ6tB/n1qyBfGi90FwQkW1V3CYLbSNZSmeLXnW8hlnJBrZG+xGmohzsmz
	ycLrrGsQcJdggYrjdia8Rjcy78CMbtb1YlMx7nCwXtNQKva8dP+VfE=
X-Google-Smtp-Source: AGHT+IFEH3x4/cqFFoxzCoohJ7Np7GFcVYf4bEPw559T5VYqzWR5D2aB0tjKiIO3dJaRI1lzvUqZ4w==
X-Received: by 2002:a17:902:dac4:b0:215:5f17:428a with SMTP id d9443c01a7336-2155f17455fmr213957595ad.15.1733212617757;
        Mon, 02 Dec 2024 23:56:57 -0800 (PST)
Received: from localhost ([124.127.236.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2153bad2480sm74943815ad.75.2024.12.02.23.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 23:56:57 -0800 (PST)
From: Hao-ran Zheng <zhenghaoran154@gmail.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: baijiaju1990@gmail.com,
	zhenghaoran154@gmail.com,
	21371365@buaa.edu.cn
Subject: [PATCH v3] btrfs: fix data race when accessing the inode's disk_i_size at btrfs_drop_extents()
Date: Tue,  3 Dec 2024 15:56:51 +0800
Message-Id: <20241203075651.109899-1-zhenghaoran154@gmail.com>
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

The main purpose of the modify_tree variable is to optimize the
acquisition of read-write locks at or after the end of file (EOF).
When the value of modify_tree is modified due to concurrency, resulting
in unnecessary acquisition of write locks, the correctness of the
system will not be affected. When the system requires a write lock but
does not acquire the write lock because the value of modify_tree is
incorrect, the path will be subsequently released and the lock will
be reacquired to ensure the correctness of the system.

Since this data race does not affect the correctness of the function,
it is a harmless data race, and it is recommended to use `data_race`
to mark it.

Signed-off-by: Hao-ran Zheng <zhenghaoran154@gmail.com>
---
V2->V3: Added details on why this is a harmless data race
V1->V2: Modified patch description and format
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 4fb521d91b06..559c177456e6 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -242,7 +242,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 	if (args->drop_cache)
 		btrfs_drop_extent_map_range(inode, args->start, args->end - 1, false);
 
-	if (args->start >= inode->disk_i_size && !args->replace_extent)
+	if (data_race(args->start >= inode->disk_i_size) && !args->replace_extent)
 		modify_tree = 0;
 
 	update_refs = (btrfs_root_id(root) != BTRFS_TREE_LOG_OBJECTID);
-- 
2.34.1


