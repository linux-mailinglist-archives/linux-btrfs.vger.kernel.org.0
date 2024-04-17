Return-Path: <linux-btrfs+bounces-4325-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DF28A7EE9
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 10:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39340281682
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 08:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DED13774A;
	Wed, 17 Apr 2024 08:55:40 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8C113699F
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344140; cv=none; b=Tcw+KO3NNjXnRYixuq063ZeN6B4NR5R+1JqivQt1ERiTqRAgGKtMGTVL/rNW1/nsWUP4KOeiVvzo/WLCvfM814GoqkcxfYciiDIbvQEmfY9Xa8HqyAwD07/EnRs6PJoXlto+DQxj26qEcNtDqRlFH4xXXvszA30u3PYnzcVyYb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344140; c=relaxed/simple;
	bh=N2Wx+BEpXRXcHh1KInp8disBY0M2ogOrnR3l+wAlB5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dW0tgOoXzp+zwgrJxkpmFDUQKmIQU2p6snAPEsbHaTmedP+ENsGUl7sJsZjJABofRSCxJ0zBP2GTYTPZg0kGovqU558CVHHGO4kmYNdhC4jYTH8pVnFy88ftBWSKCDb6S9HTS9PLO5EILGdISM+BNelz/TWlQSTY9M54zyc1oCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41551500a7eso29759365e9.2
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 01:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713344137; x=1713948937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IJhFJwWMwXJMYOuC0qnm31lgeYPhh91LZludqzVXkVg=;
        b=epNnUW9GTVetxZSSVNs0Oo1D8k//GnaBkAxUs4OxaaFthh7jFInFG411t/R4tDf2Dn
         LX5FIEUZvKtb3MiNr5UVQTSWoLSQpFcaVAYmzau9L/Hd+mm+hbKgKaWKlk6CZDoGWZDp
         tMxiznt3SrRy1idp8vfknXc5kojPijnYwJg7V+EQXQs9rPG8mzfO5N+AG4+LDUpS02mg
         j7SDuODKGMvDZpzKi+Z2bN87uk8nYFxRnmzqM40iKfDZPuTeCtlK4N2ywD2gWG01jS0m
         qOyoZIQLH9XKfDlQO4ljfcZaPxmR9OJjGK+qUELr1Yz7XEdNZW54U+nCHglTtcKnMzG5
         yFyQ==
X-Gm-Message-State: AOJu0YzV0U7+vW/Ri21ClSv7T1jxkfuqq3XpBcdlhYRlqlCYTLqLMd6i
	y+SBjHmgHSwWC4R01Zwp3RmiqGpL5UQh5EE0x9MVggYeoa9mEQidUan4hA==
X-Google-Smtp-Source: AGHT+IE25e3/aLKrYp8oAfzckIFsa3YepLYCabAqOrkFX/E6HuM/Wt8J/Sp5Bcdg8JJyRWNmc+o70w==
X-Received: by 2002:a05:600c:4e50:b0:417:e6b3:a3a2 with SMTP id e16-20020a05600c4e5000b00417e6b3a3a2mr10390504wmq.39.1713344136596;
        Wed, 17 Apr 2024 01:55:36 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f7068b00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f706:8b00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c248700b0041668770f37sm1886104wms.17.2024.04.17.01.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 01:55:35 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: josef@toxicpanda.com,
	dsterba@suse.com,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	syzbot+510a1abbb8116eeb341d@syzkaller.appspotmail.com,
	Johannes Thumshirn <Johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: fix information leak in btrfs_ioctl_logical_to_ino()
Date: Wed, 17 Apr 2024 10:55:16 +0200
Message-Id: <93ee5e5a0e35342480860317b1c3d4f5680f7e54.1713344114.git.jth@kernel.org>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Syzbot reported the information leak for in btrfs_ioctl_logical_to_ino():

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

Reported-by: syzbot+510a1abbb8116eeb341d@syzkaller.appspotmail.com
Signed-off-by: Johannes Thumshirn <Johannes.thumshirn@wdc.com>
---
 fs/btrfs/backref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index c1e6a5bbeeaf..4b993c7104fe 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2776,7 +2776,7 @@ struct btrfs_data_container *init_data_container(u32 total_bytes)
 	size_t alloc_bytes;
 
 	alloc_bytes = max_t(size_t, total_bytes, sizeof(*data));
-	data = kvmalloc(alloc_bytes, GFP_KERNEL);
+	data = kvzalloc(alloc_bytes, GFP_KERNEL);
 	if (!data)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.35.3


