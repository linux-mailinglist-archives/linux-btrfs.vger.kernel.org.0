Return-Path: <linux-btrfs+bounces-1248-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A5382493C
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 20:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91907B21CB6
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 19:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5842C691;
	Thu,  4 Jan 2024 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="xbUHSVtK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA362C1A1
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jan 2024 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d3eb299e2eso5937935ad.2
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Jan 2024 11:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1704397734; x=1705002534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPvFTJvV4/1h96WVM00g20lCAa15yhRY48d7A4EI9n8=;
        b=xbUHSVtKX2184Vj1qXMnHwXKkfEotg4NYtWL1zI27sHIFaiAyh4yVXFRRE/EZ3VAq1
         twCspJR9GlPGYoCbA7oNE7y+e10XOZ3mrWxCw294x/AYw002lF58g4IXq0YexUM2nO09
         mF3HUmg7swVDsddrrFzEHtAmGUt9G8W+QF1Mn8Uga50buX5takboCRjjXXW3ktmNu3jM
         t5Yp3Fem/SZyItY2id2Bo/4pul3KdkJ5N2ghoYZCrXprThZ4YA0geMNXNZYmAgC79odh
         yqEJChauvz6r51XVOMaGrLFSm8w4xmciIiY26OValopbu/BXY9Cteo249HO5G1NJ8HsN
         n24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704397734; x=1705002534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPvFTJvV4/1h96WVM00g20lCAa15yhRY48d7A4EI9n8=;
        b=RG7kE9yoUK4JmYkJBftP6xUjfEKn09F94FjOJ9OrPYLatGV5oRn2/EWT8agZaLzAHV
         7VTniK06qOXu7Bxx3CZaOzPr+YFcHg/7RINEnrM1v3VXubMGGZnug2ALt2XdAU7pRzXW
         dv3pM++5KsyI/0zjhS46K+/fIAAu0Emab1aI6hnKus1IppNaCcGui+TXCGAomZbP68vc
         qJPI9hV8+fHLiiuXG4/7iLQyPBPZguNj9koyeFZHg+sgn1YF89pLFykDeGvqSOR67DGq
         9zU5Kyn1ou2cLaKw0V1J2+QNfjta99C7FFdkrM0B32LLUmd+8LHbqjkfNZXRCTF28XIf
         dq5Q==
X-Gm-Message-State: AOJu0YyIBpUkM+/PsCSMLaHCKukZPQIbw+/oEPsPuyWG944wgHfg4zm0
	wVMm9gIH2dIxc99B4/RabduSDf8Noyjk7NXAv7Amf8w4cUc=
X-Google-Smtp-Source: AGHT+IGs/yqjYmI5R+DaRhJQZipXc5+cZmznWdKE8vjE+Zw92teH8s+tZ4bDy24pNaI1AvwLMgXX2w==
X-Received: by 2002:a17:90b:1281:b0:28c:137e:7a42 with SMTP id fw1-20020a17090b128100b0028c137e7a42mr911552pjb.2.1704397733722;
        Thu, 04 Jan 2024 11:48:53 -0800 (PST)
Received: from telecaster.hsd1.wa.comcast.net ([2620:10d:c090:400::4:ff66])
        by smtp.gmail.com with ESMTPSA id gf23-20020a17090ac7d700b0028c89298d36sm98431pjb.27.2024.01.04.11.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 11:48:53 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v2 1/2] btrfs: don't abort filesystem when attempting to snapshot deleted subvolume
Date: Thu,  4 Jan 2024 11:48:46 -0800
Message-ID: <f22b6634bbcacd731ca1152ba837ede3e05c886e.1704397423.git.osandov@fb.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1704397423.git.osandov@fb.com>
References: <cover.1704397423.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

If the source file descriptor to the snapshot ioctl refers to a deleted
subvolume, we get the following abort:

  ------------[ cut here ]------------
  BTRFS: Transaction aborted (error -2)
  WARNING: CPU: 0 PID: 833 at fs/btrfs/transaction.c:1875 create_pending_snapshot+0x1040/0x1190 [btrfs]
  Modules linked in: pata_acpi btrfs ata_piix libata scsi_mod virtio_net blake2b_generic xor net_failover virtio_rng failover scsi_common rng_core raid6_pq libcrc32c
  CPU: 0 PID: 833 Comm: t_snapshot_dele Not tainted 6.7.0-rc6 #2
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-1.fc39 04/01/2014
  RIP: 0010:create_pending_snapshot+0x1040/0x1190 [btrfs]
  Code: e9 44 fe ff ff 44 89 e6 48 c7 c7 f8 59 7b c0 e8 d6 f4 a3 f7 0f 0b e9 4c fa ff ff 44 89 e6 48 c7 c7 f8 59 7b c0 e8 c0 f4 a3 f7 <0f> 0b e9 ef fe ff ff 44 89 e6 48 c7 c7 f8 59 7b c0 e8 aa f4 a3 f7
  RSP: 0018:ffffa09c01337af8 EFLAGS: 00010282
  RAX: 0000000000000000 RBX: ffff9982053e7c78 RCX: 0000000000000027
  RDX: ffff99827dc20848 RSI: 0000000000000001 RDI: ffff99827dc20840
  RBP: ffffa09c01337c00 R08: 0000000000000000 R09: ffffa09c01337998
  R10: 0000000000000003 R11: ffffffffb96da248 R12: fffffffffffffffe
  R13: ffff99820535bb28 R14: ffff99820b7bd000 R15: ffff99820381ea80
  FS:  00007fe20aadabc0(0000) GS:ffff99827dc00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000559a120b502f CR3: 00000000055b6000 CR4: 00000000000006f0
  Call Trace:
   <TASK>
   ? create_pending_snapshot+0x1040/0x1190 [btrfs]
   ? __warn+0x81/0x130
   ? create_pending_snapshot+0x1040/0x1190 [btrfs]
   ? report_bug+0x171/0x1a0
   ? handle_bug+0x3a/0x70
   ? exc_invalid_op+0x17/0x70
   ? asm_exc_invalid_op+0x1a/0x20
   ? create_pending_snapshot+0x1040/0x1190 [btrfs]
   ? create_pending_snapshot+0x1040/0x1190 [btrfs]
   create_pending_snapshots+0x92/0xc0 [btrfs]
   btrfs_commit_transaction+0x66b/0xf40 [btrfs]
   btrfs_mksubvol+0x301/0x4d0 [btrfs]
   btrfs_mksnapshot+0x80/0xb0 [btrfs]
   __btrfs_ioctl_snap_create+0x1c2/0x1d0 [btrfs]
   btrfs_ioctl_snap_create_v2+0xc4/0x150 [btrfs]
   btrfs_ioctl+0x8a6/0x2650 [btrfs]
   ? kmem_cache_free+0x22/0x340
   ? do_sys_openat2+0x97/0xe0
   __x64_sys_ioctl+0x97/0xd0
   do_syscall_64+0x46/0xf0
   entry_SYSCALL_64_after_hwframe+0x6e/0x76
  RIP: 0033:0x7fe20abe83af
  Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
  RSP: 002b:00007ffe6eff1360 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fe20abe83af
  RDX: 00007ffe6eff23c0 RSI: 0000000050009417 RDI: 0000000000000003
  RBP: 0000000000000003 R08: 0000000000000000 R09: 00007fe20ad16cd0
  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
  R13: 00007ffe6eff13c0 R14: 00007fe20ad45000 R15: 0000559a120b6d58
   </TASK>
  ---[ end trace 0000000000000000 ]---
  BTRFS: error (device vdc: state A) in create_pending_snapshot:1875: errno=-2 No such entry
  BTRFS info (device vdc: state EA): forced readonly
  BTRFS warning (device vdc: state EA): Skipping commit of aborted transaction.
  BTRFS: error (device vdc: state EA) in cleanup_transaction:2055: errno=-2 No such entry

This happens because create_pending_snapshot() initializes the new root
item as a copy of the source root item. This includes the refs field,
which is 0 for a deleted subvolume. The call to btrfs_insert_root()
therefore inserts a root with refs == 0. btrfs_get_new_fs_root() then
finds the root and returns -ENOENT if refs == 0, which causes
create_pending_snapshot() to abort.

Fix it by checking the source root's refs before attempting the snapshot
(but after locking subvol_sem to avoid racing with deletion).

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a1743904202b..0af214c8bef4 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -790,6 +790,9 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 		return -EOPNOTSUPP;
 	}
 
+	if (btrfs_root_refs(&root->root_item) == 0)
+		return -ENOENT;
+
 	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 		return -EINVAL;
 
-- 
2.43.0


