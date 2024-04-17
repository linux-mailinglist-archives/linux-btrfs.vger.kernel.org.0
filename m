Return-Path: <linux-btrfs+bounces-4354-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D788A8536
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 15:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4521F23C2C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 13:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0989614036F;
	Wed, 17 Apr 2024 13:49:04 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F1313F42D
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361743; cv=none; b=ePW+VW69jluTtzURySGImpmboNZULHxV32B2gEjRtIPEfNH9Gk1I7mOcSKxoMS6FhBdVVnz0HkNwa58IAAecyEAPncvUwMIyvkRoG7zh7elBoYDGraIzNYaw3SvA/HQiSm5M77kuBuxnsQDUuGBghRHUOgbzzmb+UiQlp+SMGUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361743; c=relaxed/simple;
	bh=TVjW9bNaN6C1uAQVAorACTv5UJ10z+cayvOZbnuGLNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CT4iYlKmyMTHUVnNgzU2BOM8tVSHxWSO/0LXj4s9iyHayd5EwitTzbyrRnSnTz+/MtcPtB+BmR2QaTRSotbsvQvdbaDWAjQorYgn+nMTA/SdYnsSEzDvwCxwGjcUNcJTQSam+G8me6l6oT2h5NtDuKlZ2R8httuYNNsoH8iBxt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e69a51a33so5674452a12.1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 06:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713361740; x=1713966540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOlh93nirIbJ4LvXLzf74TpsukGQQqz8+wkUaza2FuQ=;
        b=TTJhdiMS/XsKEQfmSdTpkBBSFVBYtLzUbgblKQrKcxliAbOr4muDG7ChT1XfQLNDqS
         eqcVHMX3DL+cmHChFqoWEv0P1wIhDD0rzON71WLdKf+oGeH42m4+E3J3SsqOttA+cKx/
         Eaydn7sD2vnU6V0eKGUk5HfvhPoTe/HF7vq6kWYuJ9Tgk32exxfdmOGJmJs+XwNWDZVg
         ukakYBzY3nPrV3nLfv27WxA8VV7YxSC7jz9hzmbxz8L+G289ag2h33KZ1M3fbH1nCdN5
         +Yoz+OSdjLMlzqOXaGg6S5c8cFL0liM65Y8lQE9BZU4JoUzUQD1qhN7MDB3K1CeFIdbi
         Fu+A==
X-Gm-Message-State: AOJu0Yy/3ujnh+uc+DUAALyQYvHpCd/4tMHa3PBFUKgBeqYgFdYr4i0I
	Rv3F54pFTfp/iXpD8K9cyLJ3c3Werr9Txb49K8QB8Td9VKRqkjaLAfUbUg==
X-Google-Smtp-Source: AGHT+IEamFiOWn+FlnYyLvAnaidwGP5Quwy7EyV+C3ZPkUISBX0b0FjJ48wU01zJCGV7gWefotGWaQ==
X-Received: by 2002:a50:ccd2:0:b0:570:1ea8:cd20 with SMTP id b18-20020a50ccd2000000b005701ea8cd20mr8013078edj.3.1713361740054;
        Wed, 17 Apr 2024 06:49:00 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f7068b00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f706:8b00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id cs5-20020a0564020c4500b005705b3ed752sm866667edb.69.2024.04.17.06.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 06:48:59 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Filipe Manana <fdmanana@kernel.org>,
	syzbot+510a1abbb8116eeb341d@syzkaller.appspotmail.com,
	Johannes Thumshirn <Johannes.thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2] btrfs: fix information leak in btrfs_ioctl_logical_to_ino()
Date: Wed, 17 Apr 2024 15:48:49 +0200
Message-Id: <7eb2d171cdb1a2a89288a989dc0ef28c21bebc59.1713361686.git.jth@kernel.org>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Syzbot reported the following information leak for in
btrfs_ioctl_logical_to_ino():

BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x110 lib/usercopy.c:40
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 _copy_to_user+0xbc/0x110 lib/usercopy.c:40
 copy_to_user include/linux/uaccess.h:191 [inline]
 btrfs_ioctl_logical_to_ino+0x440/0x750 fs/btrfs/ioctl.c:3499
 btrfs_ioctl+0x714/0x1260
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl+0x261/0x450 fs/ioctl.c:890
 __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:890
 x64_sys_call+0x1883/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __kmalloc_large_node+0x231/0x370 mm/slub.c:3921
 __do_kmalloc_node mm/slub.c:3954 [inline]
 __kmalloc_node+0xb07/0x1060 mm/slub.c:3973
 kmalloc_node include/linux/slab.h:648 [inline]
 kvmalloc_node+0xc0/0x2d0 mm/util.c:634
 kvmalloc include/linux/slab.h:766 [inline]
 init_data_container+0x49/0x1e0 fs/btrfs/backref.c:2779
 btrfs_ioctl_logical_to_ino+0x17c/0x750 fs/btrfs/ioctl.c:3480
 btrfs_ioctl+0x714/0x1260
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl+0x261/0x450 fs/ioctl.c:890
 __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:890
 x64_sys_call+0x1883/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Bytes 40-65535 of 65536 are uninitialized
Memory access of size 65536 starts at ffff888045a40000

This happens, because we're copying a 'struct btrfs_data_container' back
to user-space. This btrfs_data_container is allocated in
'init_data_container()' via kvmalloc(), which does not zero-fill the
memory.

Fix this by using kvzalloc() which zeroes out the memory on allocation.

Reported-by:  <syzbot+510a1abbb8116eeb341d@syzkaller.appspotmail.com>
Signed-off-by: Johannes Thumshirn <Johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 0bc81b340295..a2de5c05f97c 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2770,20 +2770,14 @@ struct btrfs_data_container *init_data_container(u32 total_bytes)
 	size_t alloc_bytes;
 
 	alloc_bytes = max_t(size_t, total_bytes, sizeof(*data));
-	data = kvmalloc(alloc_bytes, GFP_KERNEL);
+	data = kvzalloc(alloc_bytes, GFP_KERNEL);
 	if (!data)
 		return ERR_PTR(-ENOMEM);
 
-	if (total_bytes >= sizeof(*data)) {
+	if (total_bytes >= sizeof(*data))
 		data->bytes_left = total_bytes - sizeof(*data);
-		data->bytes_missing = 0;
-	} else {
+	else
 		data->bytes_missing = sizeof(*data) - total_bytes;
-		data->bytes_left = 0;
-	}
-
-	data->elem_cnt = 0;
-	data->elem_missed = 0;
 
 	return data;
 }
-- 
2.35.3


