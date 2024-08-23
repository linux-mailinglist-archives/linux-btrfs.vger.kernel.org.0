Return-Path: <linux-btrfs+bounces-7430-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4C295C5FC
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 09:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C6E285062
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 07:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1D21E50B;
	Fri, 23 Aug 2024 07:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg7hn1AN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A135674D
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2024 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724396522; cv=none; b=pclz8y5hRhC4eo+m/Jew3yLA1gxMon7RCCt4zqktyuracGTZpDscx++CKntBAVTmBMdkBMBnvIRpz9Mr2ure/vnrN+J/xjIKVeS/MIicAmBqOd0GNue9GU6BVM/rGkCAE7ICUipl0YO++i0gFhH6o78jWAkPo0DZWbMBLWaoQ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724396522; c=relaxed/simple;
	bh=jf0UHY5qq/JZZhN8d0k3CgWi7fgL/VQRmck5aSk3iZI=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=cvu5rtOv2ou0XN+Di1JGcbnPDmYXFFP5qVHBQbck+H1NnjFHUEa/Ku1Pdav5Jw/sqozFAUnm3hfFKubH/TFlMD3yBv1twLImAmeQBAUPRHx4m7Uf/MAh4ImSYd3KzaZ6jmL3pAvBepNoXo0AEf1QfSce34/3PJ+nZ95q1fLXaJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg7hn1AN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-202146e9538so15193435ad.3
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2024 00:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724396520; x=1725001320; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dRXkD/NePjv3y4OoCH3XQ+8bsENKWxOEWgdZ4UM2INU=;
        b=gg7hn1AN0dNFAtmMQwbzBsp67L/vEDVchKYxmIyR7uO9L53UAszH8b+x/eEnUCh5RF
         kZDaly37ZlHhUT2zJEb4UjLgCIcwnTcsXqdwrOPZKWZNz5TW2TCddvonMfUwg7up4V9s
         lKSDBFHVbfTsMSwGN1ibh1XpEPTaOjQUfbSe4uQluHivpbeIgIMDzMA02MwsFKNMZ459
         s2obqO5dkYByie3RqdNEEyTTG+JSWr2U2hLeO9s9oOgYx3sXRhJMoe00Aq06BbYrBs25
         pkt/lRRPu4+HNl7zhKgJAXtI6ssCU2pb4+X2K/GMHcy12Wf0wSAYPGrw9nIYmNeGXESv
         xUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724396520; x=1725001320;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRXkD/NePjv3y4OoCH3XQ+8bsENKWxOEWgdZ4UM2INU=;
        b=F3UQ9ancIsVipdkb+7Y6fW8/wJBwrdnEqoZkgCJtuXxzNZWZJGjGHCFN04ntkg/ZFD
         kXq3Qe2qGGV0UGi3KB1qoeSwdukKNDLl5QNMGrTgxQlh9zNrP86JqWneYv7DUtVi/YO0
         FgoPsM8Z+q9xHSnHTHMX7Oj21YAq4xKCG5gDDZ87kaqSPVij6k/2D2UIMgOSPxfyGdpD
         LCQK9Pr9tfmktzHC0m3tlAXn5scxNj/76+8OUqnUzuEwNdkJtNeiipqUvvG4seTGvMO1
         iA/7OwToJojWNZ7p7Se9au5zQVPCi5g9l/eZlOxnj91nd+T6qxUL8bdPeRjdGUHO/K+O
         X2ug==
X-Gm-Message-State: AOJu0YzSNo7S5l0cSm2lb3JhiltRl8SfGJ/c5FfH5TGSxh9qXuE3eNmu
	mFNCsGmnaraZ3VbXXri+3xCkihUxcEWbU1EVhJsXun6Ow9rN2e/4Stk0MK3gjGUMiQ==
X-Google-Smtp-Source: AGHT+IHORkWt69tYZ7+hKpYcRws1E8BYP4SlS4JUFqn54Y9z95BsRy4RGp4WvgDL9Rcv/QPpXtWftw==
X-Received: by 2002:a17:902:ce92:b0:202:359:9f66 with SMTP id d9443c01a7336-2039e4fbbc8mr15008255ad.54.1724396519847;
        Fri, 23 Aug 2024 00:01:59 -0700 (PDT)
Received: from [127.0.0.1] ([174.139.202.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855dbf9asm22551475ad.179.2024.08.23.00.01.58
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 00:01:59 -0700 (PDT)
Message-ID: <c777c743d8a76e69286c26bb0447fb58acbc746e.camel@gmail.com>
Subject: bug report: assertion failed: list_empty(&fs_info->delayed_iputs)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-btrfs@vger.kernel.org
Date: Fri, 23 Aug 2024 15:01:55 +0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi, all

When I tried to reproduce a bug, I triggered another bug in btrfs.=C2=A0
It seems like a function called btrfs_add_delayed_iput() when btrfs-
cleaner was stopped.
The corresponding kernel commit is
d30d0e49da71de8df10bf3ff1b3de880653af562.=20

All my local change is like this, and AFAICT, it should not break vfs
or btrfs.
diff --git a/fs/inode.c b/fs/inode.c
index 3a41f83a4ba5..011f630777d0 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -723,6 +723,10 @@ void evict_inodes(struct super_block *sb)
                        continue;
=20
                spin_lock(&inode->i_lock);
+               if (atomic_read(&inode->i_count)) {
+                       spin_unlock(&inode->i_lock);
+                       continue;
+               }
                if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE))
{
                        spin_unlock(&inode->i_lock);
                        continue;

Below is the log when assertion was triggered.

[ 9128.500646][ T9526] loop0: detected capacity change from 0 to 32768
[ 9128.515885][ T9526] btrfs: Deprecated parameter 'usebackuproot'
[ 9128.519117][ T9526] BTRFS warning: 'usebackuproot' is deprecated,
use 'rescue=3Dusebackuproot' instead
[ 9128.524060][ T9526] BTRFS: device fsid c9fe44da-de57-406a-8241-
57ec7d4412cf devid 1 transid 8 /dev/loop0 (7:0) scanned by a.out (9526)
[ 9128.545516][ T9526] BTRFS info (device loop0): first mount of
filesystem c9fe44da-de57-406a-8241-57ec7d4412cf
[ 9128.552295][ T9526] BTRFS info (device loop0): using crc32c (crc32c-
intel) checksum algorithm
[ 9128.556318][ T9526] BTRFS info (device loop0): using free-space-tree
[ 9128.614215][ T9526] BTRFS info (device loop0): rebuilding free space
tree
[ 9128.681849][ T2342] BTRFS info (device loop0): last unmount of
filesystem c9fe44da-de57-406a-8241-57ec7d4412cf
[ 9128.696520][ T2342] assertion failed: list_empty(&fs_info-
>delayed_iputs), in fs/btrfs/disk-io.c:4335
[ 9128.707589][ T2342] ------------[ cut here ]------------
[ 9128.714989][ T2342] kernel BUG at fs/btrfs/disk-io.c:4335!
[ 9128.717351][ T2342] Oops: invalid opcode: 0000 [#1] PREEMPT SMP
KASAN NOPTI
[ 9128.720495][ T2342] CPU: 2 PID: 2342 Comm: a.out Not tainted 6.10.0-
rc2-00222-gd30d0e49da71-dirty #139
[ 9128.723837][ T2342] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 9128.727499][ T2342] RIP: 0010:close_ctree+0xd72/0xf90
[ 9128.729345][ T2342] Code: e9 ce f6 ff ff e8 ae 4d 79 fe b9 ef 10 00
00 48 c7 c2 40 8c ff 87 48 c7 c6 a0 c6 ff 87 48 c7 c7 c0 8c ff 87 e8 9f
89 5d fe 90 <0f> 0b e8 87 4d 79 fe b9 f8 10 00 00 48 c7 c2 40 8c ff 87
48 c7 c6
[ 9128.735768][ T2342] RSP: 0018:ffffc900028f7bf0 EFLAGS: 00010282
[ 9128.737996][ T2342] RAX: 0000000000000051 RBX: ffff888106320d38 RCX:
ffffffff81478d09
[ 9128.741659][ T2342] RDX: 0000000000000000 RSI: ffffffff81481876 RDI:
0000000000000005
[ 9128.748083][ T2342] RBP: ffff888106320010 R08: 0000000000000005 R09:
0000000000000000
[ 9128.750971][ T2342] R10: 0000000080000000 R11: 0000000000000001 R12:
0000000000000000
[ 9128.752244][ T2342] R13: ffff888015f34778 R14: ffff888106320000 R15:
ffff888014997e00
[ 9128.754897][ T2342] FS:  00007f2724596740(0000)
GS:ffff888064300000(0000) knlGS:0000000000000000
[ 9128.758469][ T2342] CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
[ 9128.761089][ T2342] CR2: 0000000020000000 CR3: 00000000146ac000 CR4:
0000000000750ef0
[ 9128.764292][ T2342] PKRU: 55555554
[ 9128.765768][ T2342] Call Trace:
[ 9128.767080][ T2342]  <TASK>
[ 9128.768216][ T2342]  ? show_regs+0x8c/0xa0
[ 9128.770237][ T2342]  ? die+0x36/0xa0
[ 9128.771127][ T2342]  ? do_trap+0x232/0x430
[ 9128.772506][ T2342]  ? close_ctree+0xd72/0xf90
[ 9128.774057][ T2342]  ? close_ctree+0xd72/0xf90
[ 9128.775561][ T2342]  ? do_error_trap+0xf4/0x230
[ 9128.777052][ T2342]  ? close_ctree+0xd72/0xf90
[ 9128.778530][ T2342]  ? handle_invalid_op+0x34/0x40
[ 9128.780192][ T2342]  ? close_ctree+0xd72/0xf90
[ 9128.781740][ T2342]  ? exc_invalid_op+0x2e/0x50
[ 9128.783261][ T2342]  ? asm_exc_invalid_op+0x1a/0x20
[ 9128.784917][ T2342]  ? __wake_up_klogd.part.0+0x99/0xf0
[ 9128.786648][ T2342]  ? vprintk+0x86/0xa0
[ 9128.787950][ T2342]  ? close_ctree+0xd72/0xf90
[ 9128.789463][ T2342]  ? _btrfs_printk+0x20b/0x4d0
[ 9128.791018][ T2342]  ? __pfx__btrfs_printk+0x10/0x10
[ 9128.792663][ T2342]  ? __pfx_close_ctree+0x10/0x10
[ 9128.794313][ T2342]  ? do_one_initcall+0x611/0x630
[ 9128.795985][ T2342]  ? __pfx_evict_inodes+0x10/0x10
[ 9128.797740][ T2342]  ? __pfx_btrfs_put_super+0x10/0x10
[ 9128.799526][ T2342]  generic_shutdown_super+0x151/0x3c0
[ 9128.801269][ T2342]  kill_anon_super+0x3a/0x60
[ 9128.802852][ T2342]  btrfs_kill_super+0x3b/0x50
[ 9128.804424][ T2342]  deactivate_locked_super+0xbe/0x1a0
[ 9128.806153][ T2342]  deactivate_super+0xde/0x100
[ 9128.807703][ T2342]  cleanup_mnt+0x222/0x450
[ 9128.809140][ T2342]  task_work_run+0x14e/0x250
[ 9128.810673][ T2342]  ? __pfx_task_work_run+0x10/0x10
[ 9128.812326][ T2342]  syscall_exit_to_user_mode+0x24b/0x250
[ 9128.814178][ T2342]  do_syscall_64+0xda/0x250
[ 9128.815714][ T2342]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 9128.817729][ T2342] RIP: 0033:0x7f27246a1a77
[ 9128.819276][ T2342] Code: 8f 93 0c 00 f7 d8 64 89 01 48 83 c8 ff c3
0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00
00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 59 93 0c 00 f7 d8 64
89 02 b8
[ 9128.825390][ T2342] RSP: 002b:00007ffe43d14828 EFLAGS: 00000206
ORIG_RAX: 00000000000000a6
[ 9128.828027][ T2342] RAX: 0000000000000000 RBX: 00007ffe43d15a88 RCX:
00007f27246a1a77
[ 9128.831355][ T2342] RDX: 0000000000000009 RSI: 0000000000000009 RDI:
00007ffe43d148d0
[ 9128.836004][ T2342] RBP: 00007ffe43d15910 R08: 0000000000000000 R09:
0000000000000073
[ 9128.837294][ T2342] R10: 0000000000000000 R11: 0000000000000206 R12:
0000000000000000
[ 9128.838490][ T2342] R13: 00007ffe43d15a98 R14: 000055b1294a9dd8 R15:
00007f27247cc020
[ 9128.840223][ T2342]  </TASK>
[ 9128.841271][ T2342] Modules linked in:
[ 9128.842681][ T2342] ---[ end trace 0000000000000000 ]---
[ 9128.844702][ T2342] RIP: 0010:close_ctree+0xd72/0xf90
[ 9128.846460][ T2342] Code: e9 ce f6 ff ff e8 ae 4d 79 fe b9 ef 10 00
00 48 c7 c2 40 8c ff 87 48 c7 c6 a0 c6 ff 87 48 c7 c7 c0 8c ff 87 e8 9f
89 5d fe 90 <0f> 0b e8 87 4d 79 fe b9 f8 10 00 00 48 c7 c2 40 8c ff 87
48 c7 c6
[ 9128.852712][ T2342] RSP: 0018:ffffc900028f7bf0 EFLAGS: 00010282
[ 9128.854784][ T2342] RAX: 0000000000000051 RBX: ffff888106320d38 RCX:
ffffffff81478d09
[ 9128.857375][ T2342] RDX: 0000000000000000 RSI: ffffffff81481876 RDI:
0000000000000005
[ 9128.860242][ T2342] RBP: ffff888106320010 R08: 0000000000000005 R09:
0000000000000000
[ 9128.862927][ T2342] R10: 0000000080000000 R11: 0000000000000001 R12:
0000000000000000
[ 9128.865550][ T2342] R13: ffff888015f34778 R14: ffff888106320000 R15:
ffff888014997e00
[ 9128.868349][ T2342] FS:  00007f2724596740(0000)
GS:ffff888064300000(0000) knlGS:0000000000000000
[ 9128.871514][ T2342] CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
[ 9128.873344][ T2342] CR2: 0000000020000000 CR3: 00000000146ac000 CR4:
0000000000750ef0
[ 9128.876159][ T2342] PKRU: 55555554
[ 9128.877352][ T2342] Kernel panic - not syncing: Fatal exception
[ 9128.879561][ T2342] Kernel Offset: disabled
[ 9128.881310][ T2342] Rebooting in 86400 seconds..

This[1] is the program that was used when it was triggered, but it's
unstable.
If more information was needed, please let me know.

[1]: https://syzkaller.appspot.com/x/repro.c?x=3D14c57f16980000

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

