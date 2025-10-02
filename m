Return-Path: <linux-btrfs+bounces-17333-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C00BB3D3F
	for <lists+linux-btrfs@lfdr.de>; Thu, 02 Oct 2025 13:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68FF53AFED0
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Oct 2025 11:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4387130FF02;
	Thu,  2 Oct 2025 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmLwhNC7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D6727F010
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Oct 2025 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759406141; cv=none; b=sCDzq/I+fh38bqqReOQIIwsNB7BZCLYBRnd+dmcjhFqBmQp5IZTIXbztOjO161fR7qeJIGH1lB0V9WKswR8FVu0CPe/ghequgYWlDkozTTET0w1octhyOMB8ZIwpmUB1ySoS59lMo7LXaMT6vaO7PxhzRjxBtDwwIbdRNd3PkOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759406141; c=relaxed/simple;
	bh=TjLNfcpyj8VQq8zPQxWfQv7IU90Q9MWCSFBVuqlbqLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vDeLIkvHJUsn911sJarcm2esIVM4aC9AjaH8LHJ//ldu80a+3NXRmXm9EUu6yEx4tsiAdT/jOqddnfWTy0g1hbq1D6AlxYdrx4FeL7I2dENuTOlf48IyFK4N9/Jsxi6BHZ3r9C1WymAaKAVYV5bkcjTx9jX165ZUj2k6Z0VErNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmLwhNC7; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b54dd647edcso752922a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Oct 2025 04:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759406139; x=1760010939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wt/5jmDAVyCoiW6KDcDMEjjPV7Rh60NwdAgacjtgDdw=;
        b=BmLwhNC718N+z22PdsqvRN3TowvksWrM8kblxG9Qw0Z/cf8X+QUph5Mw+3jTZj8tF5
         JNAcPur5IdLCRdx4VFLxFAJb8Zj6SXejYpXedhLby0SBPnHqgtEmD3Ng1S7ETDw1554F
         +ITwtuFRzkPh8ZxpeG28vTyDRkCC1IuntpJFdGUc2tQgs3/E6BSVxoihRg5BLC7bEnik
         x/e11OgdMG9eOQvkDo33H0Sbv2NiPF2shITPaSAyVBl2XxeaakR1uVnmCaxZdMxxHw60
         u9M8BeRW30jVOaF7F7jmSHeSf/KEnsxvi/HuywxkPurXpVj8ZK0dgpaZVLOeBd9mgbt1
         Meig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759406139; x=1760010939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wt/5jmDAVyCoiW6KDcDMEjjPV7Rh60NwdAgacjtgDdw=;
        b=PxDo1COnhBeclkFQ5YpuGzNh+VsE86xrIGKEN7WJ9u8lIBo0k4Kzr/F8+oDysmSmAs
         1XDtkL5asAMks5ycq6BoXtuqZfg5YhwtDcU7T8fjMpv0ZKEm9f2ps/M4L6nARJnJSphE
         eRvqubNnFMyBC4HDmtZqHuBLUlSeVd4c0n7gWsu0+OXW52fRk+LX9/VWA5ZlzVVYO0x0
         4Tbim65a5hoVdQY39CjTOSzx0w18jDC8fJ6ZXyd/sbiPWvyweENaV+bn6tTmcofXFgoB
         5ZXHE/uNOmtsx+vNsJnljZIvZdPjbr/kmxjxjE8aWzHrqx/S5rJ3mO0as9cV8LQrOkgz
         8bPg==
X-Gm-Message-State: AOJu0YwPD8diCKvg3IWkkr/tW0NJClcgjXObPMzYK3qM8hyyhGm0gc4T
	NgbREY+YDdGda/ba3OB5vnZDUTJh3pm8ALg6OgyAplWnhPFHg7De3eZr
X-Gm-Gg: ASbGncs4lg8v/RHfZn/XcCho860GIQGWYoQCHYBU3XzuSbqAepZCkM+RrnEijnXE5tF
	4CeBibtA011Ph7AkY4Nc9gmyqlOkA8EoDkn3V7rXQDJB0HTfZYk6DqPbConFsaiqtu1uk3NFWOq
	LgtvXpvJsoY4LK9m7QikHImOd5bHmZl+Px6Zq2euZdpYn5jDg0do9sAmZtc1h2Gm+ZEoOYXX/NJ
	POa9HhhorJdi+d645n47PkKVznqFzzUwX+AOxDGSoLJn8n+kuhHfdjhlK7F7zJrB0K0RoieITvy
	BV/L2pCZHF0TyiMTu7b9POHK8Kmczzj2QOx3CXoIxHYsVw4OIpoVoip8Jqd4pOjVzy5uKvQwQZ6
	yjvZ8wbrvTID5dxoLRaH8fl4j6rhVu8thiU8K2u8uxUJmXD4bUMoQ45yOsD4ivb6/mTGY0eRRSF
	6ERyvBTTPL
X-Google-Smtp-Source: AGHT+IEXDQv5WzWFvUN7TK5i6ZwaXNev1K2Rc7O8ISKUuj2oex0jxGVKtUV/MHSCJ8NvEldO1g3n/A==
X-Received: by 2002:a17:903:1a0d:b0:28e:7ea4:2023 with SMTP id d9443c01a7336-28e7f441e8cmr81339725ad.46.1759406139161;
        Thu, 02 Oct 2025 04:55:39 -0700 (PDT)
Received: from fedora ([45.116.149.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d31c8sm20527535ad.95.2025.10.02.04.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 04:55:38 -0700 (PDT)
From: rtapadia730@gmail.com
To: dsterba@suse.com,
	clm@fb.com,
	fdmanana@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	Rajeev Tapadia <rtapadia730@gmail.com>
Subject: [PATCH] btrfs: push memalloc_nofs_save/restore() out of alloc_bitmap()
Date: Thu,  2 Oct 2025 17:24:28 +0530
Message-ID: <20251002115427.98773-2-rtapadia730@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rajeev Tapadia <rtapadia730@gmail.com>

alloc_bitmap() currently wraps its allocation in memalloc_nofs_save
/restore(), but this hides allocation context from callers. GFP_NOFS is
required to avoid recursion into the filesystem during transaction commits,
but the correct place to enforce that is at the call sites where we know
recursion is unsafe.

So now alloc_bitmap() just allocates a bitmap. Also completing the TODO
comment.

Signed-off-by: Rajeev Tapadia <rtapadia730@gmail.com>
---

The patch was tested by enabling CONFIG_BTRFS_FS_RUN_SANITY_TESTS
All tests passed while booting the kernel in qemu.

 fs/btrfs/free-space-tree.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index dad0b492a663..abdbdc74edf8 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -159,8 +159,6 @@ static inline u32 free_space_bitmap_size(const struct btrfs_fs_info *fs_info,
 
 static unsigned long *alloc_bitmap(u32 bitmap_size)
 {
-	unsigned long *ret;
-	unsigned int nofs_flag;
 	u32 bitmap_rounded_size = round_up(bitmap_size, sizeof(unsigned long));
 
 	/*
@@ -168,13 +166,11 @@ static unsigned long *alloc_bitmap(u32 bitmap_size)
 	 * into the filesystem as the free space bitmap can be modified in the
 	 * critical section of a transaction commit.
 	 *
-	 * TODO: push the memalloc_nofs_{save,restore}() to the caller where we
-	 * know that recursion is unsafe.
+	 * This function's caller is responsible for setting the appropriate
+	 * allocation context (e.g., using memalloc_nofs_save/restore())
+	 * to prevent recursion.
 	 */
-	nofs_flag = memalloc_nofs_save();
-	ret = kvzalloc(bitmap_rounded_size, GFP_KERNEL);
-	memalloc_nofs_restore(nofs_flag);
-	return ret;
+	return kvzalloc(bitmap_rounded_size, GFP_KERNEL);
 }
 
 static void le_bitmap_set(unsigned long *map, unsigned int start, int len)
@@ -217,7 +213,9 @@ int btrfs_convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 	int ret;
 
 	bitmap_size = free_space_bitmap_size(fs_info, block_group->length);
+	unsigned int nofs_flag = memalloc_nofs_save();
 	bitmap = alloc_bitmap(bitmap_size);
+	memalloc_nofs_restore(nofs_flag);
 	if (unlikely(!bitmap)) {
 		ret = -ENOMEM;
 		btrfs_abort_transaction(trans, ret);
@@ -360,7 +358,9 @@ int btrfs_convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 	int ret;
 
 	bitmap_size = free_space_bitmap_size(fs_info, block_group->length);
+	unsigned int nofs_flag = memalloc_nofs_save();
 	bitmap = alloc_bitmap(bitmap_size);
+	memalloc_nofs_restore(nofs_flag);
 	if (unlikely(!bitmap)) {
 		ret = -ENOMEM;
 		btrfs_abort_transaction(trans, ret);
-- 
2.51.0


