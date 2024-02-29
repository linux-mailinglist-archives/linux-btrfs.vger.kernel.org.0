Return-Path: <linux-btrfs+bounces-2925-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A7786C9F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 14:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2621C20D34
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 13:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE41B7E111;
	Thu, 29 Feb 2024 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FK10S9kS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CBC7C6D6
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709212479; cv=none; b=ldW51F2tjVjkls/l11XKEJ4JM/PIb0kGcW6JZJrZmzsxAUHhPY+HJEKkiaP27I50exjsuHe1DhuB7ex3uVuluc5KwNmcqhVzX5rJRp1SKDVhhYH1OcbcdYUozUNreBx+z2y+g15XzYMJdgm1DbvhH6NC5p8Jtk2wm6kyKmebRmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709212479; c=relaxed/simple;
	bh=RNy/F1C2wNOfUFUiDFmeRWbEI7ct4pM9hidYxSutCEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOsiQkDeOYM7y1GqhQCrBRq7PM9M9c+9bCup670NhxIBMPAFXpRPhS3ChN2+LK4kNKoTF8C1r3qxdA14DEXaF/eoXnr1apVLtDt6nzU77sM/lcZxdnE4hEG7GLjpXDkEAcsowRYxZ8EWfIxwswYCHI2LMkBupaNaIx0WOs8KWB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FK10S9kS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62ACC43394
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 13:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709212478;
	bh=RNy/F1C2wNOfUFUiDFmeRWbEI7ct4pM9hidYxSutCEk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FK10S9kSZ3bx5xaxefisViCWe1X34m8DMx9GLM88nNl0vfo6eLn/MwEvI99XGeV6P
	 MqAAeLPlQuoGtpJ5yrxNpngo9F4xpGWgQIufoeWtVXGzVpnyqrrsDW6fT2Ce0++2qH
	 NGZJ1q7yQVosNkw3Fmi7WZ3hzdQeBV7kKklFvnMc/f2zZ8MeNngp5QMCVLonFCJWKt
	 FdffltkIaOdT9DxO+X7EvFGTORRVNz/WlX/ZIcKuMOxsdF8eRKIwco/VBZrhHWjHnz
	 Fr/vhvhr2eMccUISU6SMgSCnhtdZ1yUeWfY/f4Z+TmR+7xq6rI4S4STOgKM/WZJU93
	 0jOxyts44aDoQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso162692366b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 05:14:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVPIlpH05g/59ebpfh73DzzRubTuiBPMz/sWKstsNeIH4R2G5JTjIxmph8SSM/oaLS0osalK31Xg3HFxcPToNfIfKchG3mFs8DmbGM=
X-Gm-Message-State: AOJu0Yz8PapREdrIVvw6K8s5xjaM87wUbRTJhOUv5ILENyAs7e15fknz
	YI61iOVyIh0VxACQP2EQ+SwsKJUJXq7O3vU+jqPTW4VErn2tspamAN4Etf9OMSM6I1iyOKw/O45
	Cs7q7OFXZVoiylf3Bi9rX3zGTdp0=
X-Google-Smtp-Source: AGHT+IG1IzklkZsGnbGlxUuKI4TRzzSlEbxKutvoSi4Xdq8dpQ2QETYvNlHK1vWdQ8VCt0U5aHds24RFANs8dk+VNkI=
X-Received: by 2002:a17:906:f107:b0:a44:690:86de with SMTP id
 gv7-20020a170906f10700b00a44069086demr1498837ejb.0.1709212477020; Thu, 29 Feb
 2024 05:14:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4b26736862c49050ef907e6f326ab34c0e82c6b8.1709208898.git.jth@kernel.org>
 <CAL3q7H7takPu4rcrwMv2v-F9Dt-Hh8i3N6oi2X=XFsZMkhRwfw@mail.gmail.com> <bc225f09-2450-451b-b0f8-d280f2f90939@wdc.com>
In-Reply-To: <bc225f09-2450-451b-b0f8-d280f2f90939@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 29 Feb 2024 13:13:59 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6Mv8S_KdEj0ZA_8Ffs+CZtYcf=prwQ1--1P4x14J5Z_A@mail.gmail.com>
Message-ID: <CAL3q7H6Mv8S_KdEj0ZA_8Ffs+CZtYcf=prwQ1--1P4x14J5Z_A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zoned: fix use-after-free in do_zone_finish
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Johannes Thumshirn <jth@kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 1:10=E2=80=AFPM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 29.02.24 13:58, Filipe Manana wrote:
> > On Thu, Feb 29, 2024 at 12:37=E2=80=AFPM Johannes Thumshirn <jth@kernel=
.org> wrote:
> >>
> >> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >>
> >> Shinichiro reported the following use-after-free triggered by the devi=
ce
> >> replace operation in fstests btrfs/070.
> >>
> >>   BTRFS info (device nullb1): scrub: finished on devid 1 with status: =
0
> >>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>   BUG: KASAN: slab-use-after-free in do_zone_finish+0x91a/0xb90 [btrfs=
]
> >>   Read of size 8 at addr ffff8881543c8060 by task btrfs-cleaner/349400=
7
> >>
> >>   CPU: 0 PID: 3494007 Comm: btrfs-cleaner Tainted: G        W         =
 6.8.0-rc5-kts #1
> >>   Hardware name: Supermicro Super Server/X11SPi-TF, BIOS 3.3 02/21/202=
0
> >>   Call Trace:
> >>    <TASK>
> >>    dump_stack_lvl+0x5b/0x90
> >>    print_report+0xcf/0x670
> >>    ? __virt_addr_valid+0x200/0x3e0
> >>    kasan_report+0xd8/0x110
> >>    ? do_zone_finish+0x91a/0xb90 [btrfs]
> >>    ? do_zone_finish+0x91a/0xb90 [btrfs]
> >>    do_zone_finish+0x91a/0xb90 [btrfs]
> >>    btrfs_delete_unused_bgs+0x5e1/0x1750 [btrfs]
> >>    ? __pfx_btrfs_delete_unused_bgs+0x10/0x10 [btrfs]
> >>    ? btrfs_put_root+0x2d/0x220 [btrfs]
> >>    ? btrfs_clean_one_deleted_snapshot+0x299/0x430 [btrfs]
> >>    cleaner_kthread+0x21e/0x380 [btrfs]
> >>    ? __pfx_cleaner_kthread+0x10/0x10 [btrfs]
> >>    kthread+0x2e3/0x3c0
> >>    ? __pfx_kthread+0x10/0x10
> >>    ret_from_fork+0x31/0x70
> >>    ? __pfx_kthread+0x10/0x10
> >>    ret_from_fork_asm+0x1b/0x30
> >>    </TASK>
> >>
> >>   Allocated by task 3493983:
> >>    kasan_save_stack+0x33/0x60
> >>    kasan_save_track+0x14/0x30
> >>    __kasan_kmalloc+0xaa/0xb0
> >>    btrfs_alloc_device+0xb3/0x4e0 [btrfs]
> >>    device_list_add.constprop.0+0x993/0x1630 [btrfs]
> >>    btrfs_scan_one_device+0x219/0x3d0 [btrfs]
> >>    btrfs_control_ioctl+0x26e/0x310 [btrfs]
> >>    __x64_sys_ioctl+0x134/0x1b0
> >>    do_syscall_64+0x99/0x190
> >>    entry_SYSCALL_64_after_hwframe+0x6e/0x76
> >>
> >>   Freed by task 3494056:
> >>    kasan_save_stack+0x33/0x60
> >>    kasan_save_track+0x14/0x30
> >>    kasan_save_free_info+0x3f/0x60
> >>    poison_slab_object+0x102/0x170
> >>    __kasan_slab_free+0x32/0x70
> >>    kfree+0x11b/0x320
> >>    btrfs_rm_dev_replace_free_srcdev+0xca/0x280 [btrfs]
> >>    btrfs_dev_replace_finishing+0xd7e/0x14f0 [btrfs]
> >>    btrfs_dev_replace_by_ioctl+0x1286/0x25a0 [btrfs]
> >>    btrfs_ioctl+0xb27/0x57d0 [btrfs]
> >>    __x64_sys_ioctl+0x134/0x1b0
> >>    do_syscall_64+0x99/0x190
> >>    entry_SYSCALL_64_after_hwframe+0x6e/0x76
> >>
> >>   The buggy address belongs to the object at ffff8881543c8000
> >>    which belongs to the cache kmalloc-1k of size 1024
> >>   The buggy address is located 96 bytes inside of
> >>    freed 1024-byte region [ffff8881543c8000, ffff8881543c8400)
> >>
> >>   The buggy address belongs to the physical page:
> >>   page:00000000fe2c1285 refcount:1 mapcount:0 mapping:0000000000000000=
 index:0x0 pfn:0x1543c8
> >>   head:00000000fe2c1285 order:3 entire_mapcount:0 nr_pages_mapped:0 pi=
ncount:0
> >>   flags: 0x17ffffc0000840(slab|head|node=3D0|zone=3D2|lastcpupid=3D0x1=
fffff)
> >>   page_type: 0xffffffff()
> >>   raw: 0017ffffc0000840 ffff888100042dc0 ffffea0019e8f200 dead00000000=
0002
> >>   raw: 0000000000000000 0000000000100010 00000001ffffffff 000000000000=
0000
> >>   page dumped because: kasan: bad access detected
> >>
> >>   Memory state around the buggy address:
> >>    ffff8881543c7f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>    ffff8881543c7f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>   >ffff8881543c8000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >>                                                          ^
> >>    ffff8881543c8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >>    ffff8881543c8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >>
> >> This UAF happens because we're accessing stale zone information of a
> >> already removed btrfs_device in do_zone_finish().
> >>
> >> The sequence of events is as follows:
> >>
> >> btrfs_dev_replace_start
> >>    btrfs_scrub_dev
> >>     btrfs_dev_replace_finishing
> >>      btrfs_dev_replace_update_device_in_mapping_tree <-- devices repla=
ced
> >>      btrfs_rm_dev_replace_free_srcdev
> >>       btrfs_free_device                              <-- device freed
> >>
> >> cleaner_kthread
> >>   btrfs_delete_unused_bgs
> >>    btrfs_zone_finish
> >>     do_zone_finish              <-- refers the freed device
> >>
> >> The reason for this is that we're using a cached pointer to the chunk_=
map
> >> from the block group, but on device replace this cached pointer can
> >> contain stale device entries.
> >>
> >> So grab a fresh reference to the chunk map and don't rely on the cache=
d
> >> version.
> >>
> >> Many thanks to Shinichiro for analyzing the bug.
> >>
> >> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >> ---
> >>   fs/btrfs/zoned.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> >> index 3317bebfca95..c27d2214136e 100644
> >> --- a/fs/btrfs/zoned.c
> >> +++ b/fs/btrfs/zoned.c
> >> @@ -2237,7 +2237,8 @@ static int do_zone_finish(struct btrfs_block_gro=
up *block_group, bool fully_writ
> >>          btrfs_clear_data_reloc_bg(block_group);
> >>          spin_unlock(&block_group->lock);
> >>
> >> -       map =3D block_group->physical_map;
> >> +       map =3D btrfs_find_chunk_map(fs_info, block_group->start,
> >> +                                  block_group->length);
> >
> > This fits nicely within a single line, why the split?
>
> Could be because I did use btrfs_find_chunk_map_nolock() before and lock
> the whole loop, which cause deadlocks...
>
> > So the whole problem comes from the fact that
> > block_group->physical_map is a clone of the original chunk map, which
> > the device replace operation didn't update.
> >
> > Don't we need to update block_group->physical_map?
> > I don't see anywhere else updating it, it's only set when loading
> > block groups from disk at mount time or when creating a new one.
> > After a device is replaced it's never updated. So can't this
> > use-after-free happen in other code paths that use the stale chunk map
> > at block_group->physical_map?
>
> Yes I can give it a shot, but to do this conveniently we'd need to add a
> back-pointer from the chunk map to the block group.

Btw, the patch is also leaking the chunk map.

Because btrfs_find_chunk_map() adds a reference to the map, but then
there's no corresponding btrfs_free_chunk_map() call.

>
> Let me see how that'll look.
>

