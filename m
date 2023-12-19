Return-Path: <linux-btrfs+bounces-1065-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA72E819273
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 22:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B6628981F
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 21:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0136B3B297;
	Tue, 19 Dec 2023 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="TCNBQyQO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2503A8DB
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Dec 2023 21:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 0BAA28307C;
	Tue, 19 Dec 2023 16:36:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1703021772; bh=Ds+OqZU7S6hMogskxgRYqYX0xSI+4J3D+x+JT8CFbEc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TCNBQyQO77Q7WS4mkwGXb9qfqvaZutExql45Wm90jSPakkLfsNtc2f7QSXGofta7G
	 +U8w7WQ6PFcr4GF8eAGqCrY3EKt/7EqCb4H3Bpyn/L7rfxuXg3tnCKWCiL1kn35eh3
	 xlhaS1B1Iqq0nAmml5Z41NBcmF8xGDzXNLNe4AW7x/ao30F0fAhfSCT6/BdseIQnKn
	 Up5F9QyJW0RX2VbkV8b4oKTGaM+zaK6vwTIG2DqgUWRIYKXVsWm2oK5azs3UsN2TOD
	 ct7wJUTXKb+k0y9ffIDfnSvAjKRT2q23ePJpNVf802vUGqsLmyzkuRy+221SqIfgSZ
	 TcjSmXiJMiSTg==
Message-ID: <154c1684-f8ad-4593-97ce-136ee885cf71@dorminy.me>
Date: Tue, 19 Dec 2023 16:36:09 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] btrfs: don't abort filesystem when attempting to snapshot
 deleted subvolume
Content-Language: en-US
To: Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
References: <068014bd3e90668525c295660862db2932e25087.1703010314.git.osandov@fb.com>
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <068014bd3e90668525c295660862db2932e25087.1703010314.git.osandov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/23 13:29, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> If the source file descriptor to the snapshot ioctl refers to a deleted
> subvolume, we get the following abort:
> 
>    ------------[ cut here ]------------
>    BTRFS: Transaction aborted (error -2)
>    WARNING: CPU: 0 PID: 833 at fs/btrfs/transaction.c:1875 create_pending_snapshot+0x1040/0x1190 [btrfs]
>    Modules linked in: pata_acpi btrfs ata_piix libata scsi_mod virtio_net blake2b_generic xor net_failover virtio_rng failover scsi_common rng_core raid6_pq libcrc32c
>    CPU: 0 PID: 833 Comm: t_snapshot_dele Not tainted 6.7.0-rc6 #2
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-1.fc39 04/01/2014
>    RIP: 0010:create_pending_snapshot+0x1040/0x1190 [btrfs]
>    Code: e9 44 fe ff ff 44 89 e6 48 c7 c7 f8 59 7b c0 e8 d6 f4 a3 f7 0f 0b e9 4c fa ff ff 44 89 e6 48 c7 c7 f8 59 7b c0 e8 c0 f4 a3 f7 <0f> 0b e9 ef fe ff ff 44 89 e6 48 c7 c7 f8 59 7b c0 e8 aa f4 a3 f7
>    RSP: 0018:ffffa09c01337af8 EFLAGS: 00010282
>    RAX: 0000000000000000 RBX: ffff9982053e7c78 RCX: 0000000000000027
>    RDX: ffff99827dc20848 RSI: 0000000000000001 RDI: ffff99827dc20840
>    RBP: ffffa09c01337c00 R08: 0000000000000000 R09: ffffa09c01337998
>    R10: 0000000000000003 R11: ffffffffb96da248 R12: fffffffffffffffe
>    R13: ffff99820535bb28 R14: ffff99820b7bd000 R15: ffff99820381ea80
>    FS:  00007fe20aadabc0(0000) GS:ffff99827dc00000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 0000559a120b502f CR3: 00000000055b6000 CR4: 00000000000006f0
>    Call Trace:
>     <TASK>
>     ? create_pending_snapshot+0x1040/0x1190 [btrfs]
>     ? __warn+0x81/0x130
>     ? create_pending_snapshot+0x1040/0x1190 [btrfs]
>     ? report_bug+0x171/0x1a0
>     ? handle_bug+0x3a/0x70
>     ? exc_invalid_op+0x17/0x70
>     ? asm_exc_invalid_op+0x1a/0x20
>     ? create_pending_snapshot+0x1040/0x1190 [btrfs]
>     ? create_pending_snapshot+0x1040/0x1190 [btrfs]
>     create_pending_snapshots+0x92/0xc0 [btrfs]
>     btrfs_commit_transaction+0x66b/0xf40 [btrfs]
>     btrfs_mksubvol+0x301/0x4d0 [btrfs]
>     btrfs_mksnapshot+0x80/0xb0 [btrfs]
>     __btrfs_ioctl_snap_create+0x1c2/0x1d0 [btrfs]
>     btrfs_ioctl_snap_create_v2+0xc4/0x150 [btrfs]
>     btrfs_ioctl+0x8a6/0x2650 [btrfs]
>     ? kmem_cache_free+0x22/0x340
>     ? do_sys_openat2+0x97/0xe0
>     __x64_sys_ioctl+0x97/0xd0
>     do_syscall_64+0x46/0xf0
>     entry_SYSCALL_64_after_hwframe+0x6e/0x76
>    RIP: 0033:0x7fe20abe83af
>    Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
>    RSP: 002b:00007ffe6eff1360 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>    RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fe20abe83af
>    RDX: 00007ffe6eff23c0 RSI: 0000000050009417 RDI: 0000000000000003
>    RBP: 0000000000000003 R08: 0000000000000000 R09: 00007fe20ad16cd0
>    R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>    R13: 00007ffe6eff13c0 R14: 00007fe20ad45000 R15: 0000559a120b6d58
>     </TASK>
>    ---[ end trace 0000000000000000 ]---
>    BTRFS: error (device vdc: state A) in create_pending_snapshot:1875: errno=-2 No such entry
>    BTRFS info (device vdc: state EA): forced readonly
>    BTRFS warning (device vdc: state EA): Skipping commit of aborted transaction.
>    BTRFS: error (device vdc: state EA) in cleanup_transaction:2055: errno=-2 No such entry
> 
> This happens because create_pending_snapshot() initializes the new root
> item as a copy of the source root item. This includes the refs field,
> which is 0 for a deleted subvolume. The call to btrfs_insert_root()
> therefore inserts a root with refs == 0. btrfs_get_new_fs_root() then
> finds the root and returns -ENOENT if refs == 0, which causes
> create_pending_snapshot() to abort.
> 
> Fix it by checking the source root's refs before attempting the snapshot
> (but after locking subvol_sem to avoid racing with deletion).
> 

It's not likely, but I think there's still a race where deleting a 
subvol could have set the roots flags to BTRFS_ROOT_SUBVOL_DEAD, but not 
yet locked the subvol_sem, when create_pending_snapshot() makes a copy 
of the root including its flags. This would result in a snapshot subvol 
which couldn't have a swapfile and couldn't be sent, but I believe would 
otherwise be fully functional. It'd be unable to have the 
BTRFS_ROOT_SUBVOL_DEAD bit cleared and treechecker wouldn't complain 
either, which would be a bit awkward.

Maybe also clear the BTRFS_ROOT_SUBVOL_DEAD flag when copying the root? 
Or in create_pending_snapshot(), grab the root_item_lock around 
btrfs_copy_root() and error out if the flag is set?

Thanks!

Sweet Tea

