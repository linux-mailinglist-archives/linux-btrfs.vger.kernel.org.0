Return-Path: <linux-btrfs+bounces-10976-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51754A12E30
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2025 23:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0797C18827F9
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2025 22:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192421DD87D;
	Wed, 15 Jan 2025 22:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4m/a3+C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3481DB372
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2025 22:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736979507; cv=none; b=bn3yYVt0kj7wQssMKY1iKb7TJHFfbr3umyA9VuumaW3YlR7Na3zeBw90m0P8ytXVZw1NMiNpZV1XMl2NLftJI7i9r9VtV++PWtAl6REu8gjD4DyKMkkVtB3L2xEIl7VCnqA8YUTbXBvKgdbSyk65d9ZTTExCtqZCnj3jgAzXBxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736979507; c=relaxed/simple;
	bh=O1juii2meqxBM7YUPHGNk5O/gcDRi/SmgkoAoK4mmOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrCszA5etHfgY8UIpkr6qeTQ4YUXhqV8LvOQi3W5YiomYx+dsh20T3eQjaCY+l8+sCI55YMOjviw3TagwGtFGyEN7YSetUXgcJuHLG+VfqaR09vqUGMlrOvpR/d8eMs88Ob/RDX+NU+q1GN58uTyBYrCRd786gOeAQP00KnwPGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4m/a3+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191CFC4CED1
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2025 22:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736979507;
	bh=O1juii2meqxBM7YUPHGNk5O/gcDRi/SmgkoAoK4mmOU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b4m/a3+CXc3NjqhmUsh1mTOiYLNh4FXo21eHlzqy4K1OwIFiEpdpsI+iGJwhPmMiS
	 ruWjb9/oZmhY3XYMdC/ZdsVyv2FfpdiRyKirZ6cgZ3f8FfLGUTJyS+62hpVpls4xMy
	 YiI4uFPUEl1HvlvrpjiSsTh24Ci6YpT0dE8vRgsDopz50iwRNUS+AcToHtflgxOaav
	 uuuAhdEina2rDIjgVUFkMPXTWj7XPb5dSm+S4tBX/bCG+YdA07pYkgGi1YY4nMJCVb
	 suev6UYqfKeNlWTWm/M4Redw1tIda1OsPISlEd3cD/aHBKfDyx/HSRypT/5H/0u9Ip
	 92LoLINDjfprw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaeec07b705so49824066b.2
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2025 14:18:27 -0800 (PST)
X-Gm-Message-State: AOJu0YwnITwzEQXgryp79HL/GAB/tcx2GDGnzvG3RDCrY+iuEvvy4Keh
	MZl1lsuLZ9ertbkjkbtLOcSTgF5xsPV4leuf+e1MQ6gGsee5lHSgDUG9S+aRQI3lkFyIKRRmnrU
	lZA/OK0h8vi1ibnklrZpK0FDeem8=
X-Google-Smtp-Source: AGHT+IHnliEAcOECM/MTF8JtTSwiIFoogBJ7gD9fnhetx2ElWcijV/YYufcuD7m2dqNFcQek+KeO3Mgzdl4Ru3Et4kY=
X-Received: by 2002:a17:906:7308:b0:ab2:faed:f180 with SMTP id
 a640c23a62f3a-ab2faedfd79mr1902369966b.33.1736979505599; Wed, 15 Jan 2025
 14:18:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <efe1ae546864e0f22b4e29794115e3cedb602c30.1736782338.git.fdmanana@suse.com>
 <ef836984-61a0-4a09-95d5-901d499aec4a@gmx.com> <CAL3q7H7ctFOu-naGsfxREKuN7664fXUK=Rd_V_RFk70tXJhcFA@mail.gmail.com>
 <29d889d3-3625-4178-a605-1e54efe1e3b0@gmx.com>
In-Reply-To: <29d889d3-3625-4178-a605-1e54efe1e3b0@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 15 Jan 2025 22:17:48 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4g0N207pdUTmqBMboNdJOVC+BKMn8V609MBFVmCh8AwQ@mail.gmail.com>
X-Gm-Features: AbW1kvYm6UldWPF-TebGE0QG2oFLaas7-3MXSxzsd7Dc89fJcRMa999KDgTGcNY
Message-ID: <CAL3q7H4g0N207pdUTmqBMboNdJOVC+BKMn8V609MBFVmCh8AwQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix assertion failure when splitting ordered
 extent after transaction abort
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 9:37=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/1/15 05:22, Filipe Manana =E5=86=99=E9=81=93:
> > On Mon, Jan 13, 2025 at 9:12=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2025/1/14 02:02, fdmanana@kernel.org =E5=86=99=E9=81=93:
> >>> From: Filipe Manana <fdmanana@suse.com>
> >>>
> >>> If while we are doing a direct IO write a transaction abort happens, =
we
> >>> mark all existing ordered extents with the BTRFS_ORDERED_IOERR flag (=
done
> >>> at btrfs_destroy_ordered_extents()), and then after that if we enter
> >>> btrfs_split_ordered_extent() and the ordered extent has bytes left
> >>> (meaning we have a bio that doesn't cover the whole ordered extent, s=
ee
> >>> details at btrfs_extract_ordered_extent()), we will fail on the follo=
wing
> >>> assertion at btrfs_split_ordered_extent():
> >>>
> >>>      ASSERT(!(flags & ~BTRFS_ORDERED_TYPE_FLAGS));
> >>>
> >>> because the BTRFS_ORDERED_IOERR flag is set and the definition of
> >>> BTRFS_ORDERED_TYPE_FLAGS is just the union of all flags that identify=
 the
> >>> type of write (regular, nocow, prealloc, compressed, direct IO, encod=
ed).
> >>>
> >>> Fix this by returning an error from btrfs_extract_ordered_extent() if=
 we
> >>> find the BTRFS_ORDERED_IOERR flag in the ordered extent. The error wi=
ll
> >>> be the error that resulted in the transaction abort or -EIO if no
> >>> transaction abort happened.
> >>>
> >>> This was recently reported by syzbot with the following trace:
> >>>
> >>>      FAULT_INJECTION: forcing a failure.
> >>>      name failslab, interval 1, probability 0, space 0, times 1
> >>>      CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted 6.13.0-rc5-syz=
kaller #0
> >>>      Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-=
debian-1.16.3-2~bpo12+1 04/01/2014
> >>>      Call Trace:
> >>>       <TASK>
> >>>       __dump_stack lib/dump_stack.c:94 [inline]
> >>>       dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >>>       fail_dump lib/fault-inject.c:53 [inline]
> >>>       should_fail_ex+0x3b0/0x4e0 lib/fault-inject.c:154
> >>>       should_failslab+0xac/0x100 mm/failslab.c:46
> >>>       slab_pre_alloc_hook mm/slub.c:4072 [inline]
> >>>       slab_alloc_node mm/slub.c:4148 [inline]
> >>>       __do_kmalloc_node mm/slub.c:4297 [inline]
> >>>       __kmalloc_noprof+0xdd/0x4c0 mm/slub.c:4310
> >>>       kmalloc_noprof include/linux/slab.h:905 [inline]
> >>>       kzalloc_noprof include/linux/slab.h:1037 [inline]
> >>>       btrfs_chunk_alloc_add_chunk_item+0x244/0x1100 fs/btrfs/volumes.=
c:5742
> >>>       reserve_chunk_space+0x1ca/0x2c0 fs/btrfs/block-group.c:4292
> >>>       check_system_chunk fs/btrfs/block-group.c:4319 [inline]
> >>>       do_chunk_alloc fs/btrfs/block-group.c:3891 [inline]
> >>>       btrfs_chunk_alloc+0x77b/0xf80 fs/btrfs/block-group.c:4187
> >>>       find_free_extent_update_loop fs/btrfs/extent-tree.c:4166 [inlin=
e]
> >>>       find_free_extent+0x42d1/0x5810 fs/btrfs/extent-tree.c:4579
> >>>       btrfs_reserve_extent+0x422/0x810 fs/btrfs/extent-tree.c:4672
> >>>       btrfs_new_extent_direct fs/btrfs/direct-io.c:186 [inline]
> >>>       btrfs_get_blocks_direct_write+0x706/0xfa0 fs/btrfs/direct-io.c:=
321
> >>>       btrfs_dio_iomap_begin+0xbb7/0x1180 fs/btrfs/direct-io.c:525
> >>>       iomap_iter+0x697/0xf60 fs/iomap/iter.c:90
> >>>       __iomap_dio_rw+0xeb9/0x25b0 fs/iomap/direct-io.c:702
> >>>       btrfs_dio_write fs/btrfs/direct-io.c:775 [inline]
> >>>       btrfs_direct_write+0x610/0xa30 fs/btrfs/direct-io.c:880
> >>>       btrfs_do_write_iter+0x2a0/0x760 fs/btrfs/file.c:1397
> >>>       do_iter_readv_writev+0x600/0x880
> >>>       vfs_writev+0x376/0xba0 fs/read_write.c:1050
> >>>       do_pwritev fs/read_write.c:1146 [inline]
> >>>       __do_sys_pwritev2 fs/read_write.c:1204 [inline]
> >>>       __se_sys_pwritev2+0x196/0x2b0 fs/read_write.c:1195
> >>>       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >>>       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >>>       entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >>>      RIP: 0033:0x7f1281f85d29
> >>>      Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f=
8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d=
 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> >>>      RSP: 002b:00007f12819fe038 EFLAGS: 00000246 ORIG_RAX: 0000000000=
000148
> >>>      RAX: ffffffffffffffda RBX: 00007f1282176080 RCX: 00007f1281f85d2=
9
> >>>      RDX: 0000000000000001 RSI: 0000000020000240 RDI: 000000000000000=
5
> >>>      RBP: 00007f12819fe090 R08: 0000000000000000 R09: 000000000000000=
3
> >>>      R10: 0000000000007000 R11: 0000000000000246 R12: 000000000000000=
2
> >>>      R13: 0000000000000000 R14: 00007f1282176080 R15: 00007ffcb9e2332=
8
> >>>       </TASK>
> >>>      BTRFS error (device loop0 state A): Transaction aborted (error -=
12)
> >>>      BTRFS: error (device loop0 state A) in btrfs_chunk_alloc_add_chu=
nk_item:5745: errno=3D-12 Out of memory
> >>>      BTRFS info (device loop0 state EA): forced readonly
> >>>      assertion failed: !(flags & ~BTRFS_ORDERED_TYPE_FLAGS), in fs/bt=
rfs/ordered-data.c:1234
> >>>      ------------[ cut here ]------------
> >>>      kernel BUG at fs/btrfs/ordered-data.c:1234!
> >>>      Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> >>>      CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted 6.13.0-rc5-syz=
kaller #0
> >>>      Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-=
debian-1.16.3-2~bpo12+1 04/01/2014
> >>>      RIP: 0010:btrfs_split_ordered_extent+0xd8d/0xe20 fs/btrfs/ordere=
d-data.c:1234
> >>>      Code: 43 fd 90 0f 0b e8 43 c4 db fd 48 c7 c7 20 0c 4c 8c 48 c7 c=
6 80 0f 4c 8c 48 c7 c2 e0 0b 4c 8c b9 d2 04 00 00 e8 04 57 43 fd 90 <0f> 0b=
 e8 1c c4 db fd eb 5b e8 15 c4 db fd 48 c7 c7 20 0c 4c 8c 48
> >>>      RSP: 0018:ffffc9000d1df2b8 EFLAGS: 00010246
> >>>      RAX: 0000000000000057 RBX: 000000000006a000 RCX: 9ce21886c419530=
0
> >>>      RDX: 0000000000000000 RSI: 0000000080000000 RDI: 000000000000000=
0
> >>>      RBP: 0000000000000091 R08: ffffffff817f0a3c R09: 1ffff92001a3bdf=
4
> >>>      R10: dffffc0000000000 R11: fffff52001a3bdf5 R12: 1ffff1100a45f40=
1
> >>>      R13: ffff8880522fa018 R14: dffffc0000000000 R15: 000000000006a00=
0
> >>>      FS:  00007f12819fe6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000=
000000000000
> >>>      CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>      CR2: 0000557750bd7da8 CR3: 00000000400ea000 CR4: 0000000000352ef=
0
> >>>      DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000000000=
0
> >>>      DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000000040=
0
> >>>      Call Trace:
> >>>       <TASK>
> >>>       btrfs_extract_ordered_extent fs/btrfs/direct-io.c:702 [inline]
> >>>       btrfs_dio_submit_io+0x4be/0x6d0 fs/btrfs/direct-io.c:737
> >>>       iomap_dio_submit_bio fs/iomap/direct-io.c:85 [inline]
> >>>       iomap_dio_bio_iter+0x1022/0x1740 fs/iomap/direct-io.c:447
> >>>       __iomap_dio_rw+0x13b7/0x25b0 fs/iomap/direct-io.c:703
> >>>       btrfs_dio_write fs/btrfs/direct-io.c:775 [inline]
> >>>       btrfs_direct_write+0x610/0xa30 fs/btrfs/direct-io.c:880
> >>>       btrfs_do_write_iter+0x2a0/0x760 fs/btrfs/file.c:1397
> >>>       do_iter_readv_writev+0x600/0x880
> >>>       vfs_writev+0x376/0xba0 fs/read_write.c:1050
> >>>       do_pwritev fs/read_write.c:1146 [inline]
> >>>       __do_sys_pwritev2 fs/read_write.c:1204 [inline]
> >>>       __se_sys_pwritev2+0x196/0x2b0 fs/read_write.c:1195
> >>>       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >>>       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >>>       entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >>>      RIP: 0033:0x7f1281f85d29
> >>>      Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f=
8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d=
 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> >>>      RSP: 002b:00007f12819fe038 EFLAGS: 00000246 ORIG_RAX: 0000000000=
000148
> >>>      RAX: ffffffffffffffda RBX: 00007f1282176080 RCX: 00007f1281f85d2=
9
> >>>      RDX: 0000000000000001 RSI: 0000000020000240 RDI: 000000000000000=
5
> >>>      RBP: 00007f12819fe090 R08: 0000000000000000 R09: 000000000000000=
3
> >>>      R10: 0000000000007000 R11: 0000000000000246 R12: 000000000000000=
2
> >>>      R13: 0000000000000000 R14: 00007f1282176080 R15: 00007ffcb9e2332=
8
> >>>       </TASK>
> >>>      Modules linked in:
> >>>      ---[ end trace 0000000000000000 ]---
> >>>      RIP: 0010:btrfs_split_ordered_extent+0xd8d/0xe20 fs/btrfs/ordere=
d-data.c:1234
> >>>      Code: 43 fd 90 0f 0b e8 43 c4 db fd 48 c7 c7 20 0c 4c 8c 48 c7 c=
6 80 0f 4c 8c 48 c7 c2 e0 0b 4c 8c b9 d2 04 00 00 e8 04 57 43 fd 90 <0f> 0b=
 e8 1c c4 db fd eb 5b e8 15 c4 db fd 48 c7 c7 20 0c 4c 8c 48
> >>>      RSP: 0018:ffffc9000d1df2b8 EFLAGS: 00010246
> >>>      RAX: 0000000000000057 RBX: 000000000006a000 RCX: 9ce21886c419530=
0
> >>>      RDX: 0000000000000000 RSI: 0000000080000000 RDI: 000000000000000=
0
> >>>      RBP: 0000000000000091 R08: ffffffff817f0a3c R09: 1ffff92001a3bdf=
4
> >>>      R10: dffffc0000000000 R11: fffff52001a3bdf5 R12: 1ffff1100a45f40=
1
> >>>      R13: ffff8880522fa018 R14: dffffc0000000000 R15: 000000000006a00=
0
> >>>      FS:  00007f12819fe6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000=
000000000000
> >>>      CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>      CR2: 0000557750bd7da8 CR3: 00000000400ea000 CR4: 0000000000352ef=
0
> >>>      DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000000000=
0
> >>>      DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000000040=
0
> >>>
> >>> In this case the transaction abort was due to (an injected) memory
> >>> allocation failure when attempting to allocate a new chunk.
> >>>
> >>> Reported-by: syzbot+f60d8337a5c8e8d92a77@syzkaller.appspotmail.com
> >>> Link: https://lore.kernel.org/linux-btrfs/6777f2dd.050a0220.178762.00=
45.GAE@google.com/
> >>> Fixes: 52b1fdca23ac ("btrfs: handle completed ordered extents in btrf=
s_split_ordered_extent")
> >>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >>
> >> Reviewed-by: Qu Wenruo <wqu@suse.com>
> >>
> >> Thanks,
> >> Qu
> >>
> >>> ---
> >>>    fs/btrfs/ordered-data.c | 12 ++++++++++++
> >>>    1 file changed, 12 insertions(+)
> >>>
> >>> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> >>> index 30eceaf829a7..3cf95a801086 100644
> >>> --- a/fs/btrfs/ordered-data.c
> >>> +++ b/fs/btrfs/ordered-data.c
> >>> @@ -1229,6 +1229,18 @@ struct btrfs_ordered_extent *btrfs_split_order=
ed_extent(
> >>>         */
> >>>        if (WARN_ON_ONCE(len >=3D ordered->num_bytes))
> >>>                return ERR_PTR(-EINVAL);
> >>> +     /*
> >>> +      * If our ordered extent had an error there's no point in conti=
nuing.
> >>> +      * The error may have come from a transaction abort done either=
 by this
> >>> +      * task or some other concurrent task, and the transaction abor=
t path
> >>> +      * iterates over all existing ordered extents and sets the flag
> >>> +      * BTRFS_ORDERED_IOERR on them.
> >>> +      */
> >>> +     if (unlikely(flags & BTRFS_ORDERED_IOERR)) {
> >
> > This should be:
> >
> > flags & (1U << BTRFS_ORDERED_IOERR)
>
> Sorry I didn't mention before merging, you can use test_bit() instead.

Yes but flags being a local variable it doesn't make much sense.
We're also already doing a check with & above:

flags & (1U << BTRFS_ORDERED_COMPRESSED))

And also in the assertion triggered by the syzbot.
So for consistency as well, leaving it like that.

Thanks.

>
> Thanks,
> Qu
> >
> > I'll fix it up when committing to for-next, thanks.
> >
> >>> +             const int fs_error =3D BTRFS_FS_ERROR(fs_info);
> >>> +
> >>> +             return fs_error ? ERR_PTR(fs_error) : ERR_PTR(-EIO);
> >>> +     }
> >>>        /* We cannot split partially completed ordered extents. */
> >>>        if (ordered->bytes_left) {
> >>>                ASSERT(!(flags & ~BTRFS_ORDERED_TYPE_FLAGS));
> >>
>

