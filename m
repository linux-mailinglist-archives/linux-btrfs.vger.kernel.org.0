Return-Path: <linux-btrfs+bounces-14973-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9942AE947C
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 05:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409CD1C40065
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 03:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8133219ABC6;
	Thu, 26 Jun 2025 03:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEYA/AVo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C93B11713;
	Thu, 26 Jun 2025 03:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750907293; cv=none; b=WSEwAFluKCpfhPxrzVIzvLpC9QafYh1nIWUJqDskiBfQnvFJM/eFIEN27TNSYcepOVEPPUIDZZhsD2mhu0tFqfDz0L11YbsxhI8/aHGvKozl2dbyfVZxkWByCen35ckt1i+F4Oisat9NOb0oACX7Tn/Y4qh9vrQ6nI061xvOmGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750907293; c=relaxed/simple;
	bh=lWo5an8OdaUAFaj7d4vEBfb/OZ6LH/dPxCLqHDE32pU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FQTuMRxpMJCIrmpO5gDF8A6O+RfcTt2fvRQfWqpWU7s8TJoqfF/3Rmisfmrnh+4YOgIO6+WumtO7nTotkTkzMjcoq0U7ZmRkKMyNTj8DkVcwfbjjc9ppvMD1CIuOXdlNTuPYO0KonlSMYeJbzCGgejkYxf4mDWXkMryd57UGvyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEYA/AVo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23508d30142so8645725ad.0;
        Wed, 25 Jun 2025 20:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750907292; x=1751512092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xetl4Q1nAdqIE8NowlSON/wr7o9z3LI7Y8QPRF2z6Io=;
        b=eEYA/AVo5ZCg2vHF1cPPyJGEivgT5KgscEW5fkicamDp55vgP2NC/6aDnUXV235qVz
         AtSzu7oIm206F7EXyJD7ulUyqBREeoyy6cI6/SHoaotgXTvwEF0yNxJS6g7ThfpzY7XM
         iWwAiYVD5ECgde1w94JiGcWdNiZcGSByq8DARl8LHHAtJi/pEYh+NzhbXBZM/etPHNrN
         8dbE8Gv/X57YtNnc9nrkmmmYUzQObSV/07NbyLw5ZIZMYuSWOcxnqS1IQRURErBkPcFU
         3Ow/LktESJTYyj/noN0oS+UZNblmXXvICpBG+MhsojZrshVUtYQX1ux6T76gJyMlCSCc
         iYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750907292; x=1751512092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xetl4Q1nAdqIE8NowlSON/wr7o9z3LI7Y8QPRF2z6Io=;
        b=VRBG5p/BWemmsX2o6fh/ls4OWEJ9Ert8PxlPN2COw+Zw9bBUgqsckJ7E8AvZfw2zI5
         IsOUBdcGv+GfcSYSYfKM+sBS/ylxwKkswnAXTzoqkva0o8x5nVBgklCDs1EvNygLdkqi
         bCuu9Ds5LPGITcX+3a9C25Dp8k9ZcdypAs8mI+Z+yQnnW+HErBX6+e87GI9fsXLFrYJX
         5TbEZNVFSbgk2F65bzTuXawbi4oLKbxAClKo6nng98lmm84ZsnUV/btizfaFmCYwOuHB
         S7764R/Er1L8Ol1tZsHe/KtaKvK/6DoES75cX1EmSu0Qr34YoauH6gn+KBK6qogp/Ve/
         2BdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsLnbJdrRbzrufkhEI05bKGdwKT0yIbMf+6ZJZbyvnyg5U0ekiYgX2UWNLz5zRYyL/cG4pfyYmJ2Wtubg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBNdhQpJR4OjFaxytf83Twkits3Qp3UY4Q86jznp/NKQcd9Rsd
	vehaAaD+MpCpr/M9Kjf/Wkeqe4aWkPnqsJNp+FW0+LTI/rQ5zGmCmZci
X-Gm-Gg: ASbGncu+ofslfc6W1jnf/hfz7f61ZAYQhrJTsCOgJbeKNiMoF+6Pns0fQedbGl3OeEc
	2LBMjy2r4oIFXNshpM79ePTIeT9jGIxx0X+bGe+FuQMWlYLRkh3Uj67fCz2AvknaG96asC87ZAz
	1RCWMmvFkjusfQPcr99Qo/7otf6W5IRjNxOJBYm0uBr95CbUucYQol6obi6Uv/vKC0xu7Vp4RdI
	5ipWExBHzWOeUhZNmWg+mptBBe2tfTOu8HVyvhnlVGs4tj3tzxaFr8nuIYU/LSt1Ewykm4YHuqr
	5RbPJm3RVMolEEYZf8DaM/zFOEWLxxr+fRKDirRo9CyBxsRhjvqjKAeQxMumfh5q
X-Google-Smtp-Source: AGHT+IFKo/7YFVk++cMRdtz8fShtah+X7Ozy2mMHd2aoe7W6PwQGPQeLb5mjGCspXZSFcYtbGYj6Uw==
X-Received: by 2002:a17:903:1a67:b0:234:f200:51a1 with SMTP id d9443c01a7336-23823f94c1fmr77830975ad.9.1750907291677;
        Wed, 25 Jun 2025 20:08:11 -0700 (PDT)
Received: from localhost ([1.203.169.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d860a8b4sm142984495ad.90.2025.06.25.20.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 20:08:11 -0700 (PDT)
From: Hao-ran Zheng <zhenghaoran154@gmail.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com,
	Hao-ran Zheng <zhenghaoran154@gmail.com>
Subject: [PATCH] btrfs: Two data races in btrfs
Date: Thu, 26 Jun 2025 11:08:06 +0800
Message-Id: <20250626030806.665809-1-zhenghaoran154@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello maintainers,

I would like to report two data race bugs we discovered in BTRFS
filesystem on Linux kernel v6.16-rc3. These issues were identified
using our data race detector.

These issues were deemed non-critical after evaluation, as they
do not impact core functionality or security. To minimize
performance overhead while ensuring clarity for future maintenance,
I have annotated them with data_race() macros.

Below is a summary of the findings:

---

============ DATARACE ============
 extent_write_cache_pages fs/btrfs/extent_io.c:2439 [inline]
 btrfs_writepages+0x34fc/0x3d20 fs/btrfs/extent_io.c:2376
 do_writepages+0x302/0x7c0 mm/page-writeback.c:2687
 filemap_fdatawrite_wbc mm/filemap.c:389 [inline]
  __filemap_fdatawrite_range mm/filemap.c:422 [inline]
 filemap_fdatawrite_range+0x145/0x1d0 mm/filemap.c:440
 btrfs_fdatawrite_range fs/btrfs/file.c:3701 [inline]
 start_ordered_ops fs/btrfs/file.c:1439 [inline]
 btrfs_sync_file+0x6e7/0x1d70 fs/btrfs/file.c:1550
 generic_write_sync include/linux/fs.h:2970 [inline]
 btrfs_do_write_iter+0xd0c/0x12f0 fs/btrfs/file.c:1391
 btrfs_file_write_iter+0x3d/0x60 fs/btrfs/file.c:1401
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x940/0xd10 fs/read_write.c:679
 ksys_write+0x116/0x200 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1a0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 0x0
============OTHER_INFO============
 extent_write_cache_pages fs/btrfs/extent_io.c:2439 [inline]
 btrfs_writepages+0x34fc/0x3d20 fs/btrfs/extent_io.c:2376
 do_writepages+0x302/0x7c0 mm/page-writeback.c:2687
 filemap_fdatawrite_wbc mm/filemap.c:389 [inline]
 __filemap_fdatawrite_range mm/filemap.c:422 [inline]
 filemap_fdatawrite_range+0x145/0x1d0 mm/filemap.c:440
 btrfs_fdatawrite_range fs/btrfs/file.c:3701 [inline]
 start_ordered_ops fs/btrfs/file.c:1439 [inline]
 btrfs_sync_file+0x509/0x1d70 fs/btrfs/file.c:1521
 generic_write_sync include/linux/fs.h:2970 [inline]
 btrfs_do_write_iter+0xd0c/0x12f0 fs/btrfs/file.c:1391
 btrfs_file_write_iter+0x3d/0x60 fs/btrfs/file.c:1401
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x940/0xd10 fs/read_write.c:679
 ksys_write+0x116/0x200 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1a0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
=================END==============

===========================DATA_RACE===========================
 btrfs_inode_safe_disk_i_size_write+0x144/0x190 fs/btrfs/file-item.c:65
 btrfs_finish_one_ordered+0x999/0x1330 fs/btrfs/inode.c:3203
 btrfs_finish_ordered_io+0x33/0x50 fs/btrfs/inode.c:3308
 finish_ordered_fn+0x3a/0x50 fs/btrfs/ordered-data.c:331
 btrfs_work_helper+0x199/0x6c0 fs/btrfs/async-thread.c:314
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0x21f/0x520 kernel/workqueue.c:3319
 worker_thread+0x323/0x4a0 kernel/workqueue.c:3400
 kthread+0x2d5/0x300 kernel/kthread.c:464
 ret_from_fork+0x4d/0x60 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
============OTHER_INFO============
 fill_stack_inode_item fs/btrfs/delayed-inode.c:1809 [inline]
 btrfs_delayed_update_inode+0x1ab/0xa40 fs/btrfs/delayed-inode.c:1931
 btrfs_update_inode+0x128/0x270 fs/btrfs/inode.c:4156
 btrfs_setxattr_trans+0x143/0x280 fs/btrfs/xattr.c:266
 btrfs_xattr_handler_set+0xb7/0xf0 fs/btrfs/xattr.c:380
 __vfs_setxattr+0x21e/0x240 fs/xattr.c:200
 __vfs_setxattr_noperm+0xa5/0x2d0 fs/xattr.c:234
 vfs_setxattr+0xd5/0x1d0 fs/xattr.c:321
 do_setxattr fs/xattr.c:636 [inline]
 file_setxattr+0xb0/0x110 fs/xattr.c:646
 path_setxattrat+0x217/0x260 fs/xattr.c:711
 __do_sys_fsetxattr fs/xattr.c:761 [inline]
 __se_sys_fsetxattr fs/xattr.c:758 [inline]
 __x64_sys_fsetxattr+0x2c/0x40 fs/xattr.c:758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1a0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
=================================

Signed-off-by: Hao-ran Zheng <zhenghaoran154@gmail.com>
---
 fs/btrfs/extent_io.c | 2 +-
 fs/btrfs/file-item.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 849199768664..0c03fafc3ae0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2436,7 +2436,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 	}
 
 	if (wbc->range_cyclic || (wbc->nr_to_write > 0 && range_whole))
-		mapping->writeback_index = done_index;
+		data_race(mapping->writeback_index = done_index);
 
 	btrfs_add_delayed_iput(BTRFS_I(inode));
 	return ret;
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 54d523d4f421..15572e79b6de 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -61,7 +61,7 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 		i_size = min(i_size, end + 1);
 	else
 		i_size = 0;
-	inode->disk_i_size = i_size;
+	data_race(inode->disk_i_size = i_size);
 out_unlock:
 	spin_unlock(&inode->lock);
 }
-- 
2.34.1


