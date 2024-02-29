Return-Path: <linux-btrfs+bounces-2923-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB6786C998
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 13:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DFBA28889D
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 12:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3487E0EC;
	Thu, 29 Feb 2024 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHSHeDSo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E727D092
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709211512; cv=none; b=ruXUXK/JJfgsiuaGhGzbhZkumch7naWHlrIyG4W3miq5N3hh3FIuMNH7XckNUEBrPZOUPGOvA21vTqfMDKRyDkPLryzXbr8xUFp+J7hKDu0GBkXPXQ5BN1UZZnmqW8ivQva72RVSsQ+VqzOtLFJNhshcwAwYHuzWV1cDM4u5vqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709211512; c=relaxed/simple;
	bh=5BPseqFgjTzq+APuYDbnJDIV8qihzilfQ1mr+il8P2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXpxhaD6j9mycK0xDva3ZRAT1Ci7PBewBX4oKatiAEveTETHF4tYZncV3TdtsXJoaaBP5pUk7CnWe+2WYwxx+C2CnE8/35pPlUkDD0jphc5PvxzZVRKam3m0k2u3OqeU2dP8OhlN9yjTjEYaKhe9azpIRvcXdIqfmIEY7klo50I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHSHeDSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74D7C433F1
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 12:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709211511;
	bh=5BPseqFgjTzq+APuYDbnJDIV8qihzilfQ1mr+il8P2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fHSHeDSo8GzJvDHDAGKVeH69rY3kxiOZ4D69c2dWGmYYkoWGKY+GomWzTKCRY18gr
	 /PLeM9VK2Z81o0slsC2Nj4vgK43JtQCH2NVmSP4CVCa0RaBl9gLA0OnQGtJO4RdXWF
	 8aBdSNuTwALIqtLKjFdquXKvSH7xouGxvqInr/LzMBdVWYCb1Iw08jGygjE7QDbgMV
	 XOZXLLFNadFtv10jyXAN03ncsVeH2klq0Ju4dTxMtT0dCeAgKq5xrx891V6bby6Rnm
	 e4+ZPNVfc82kf5ODVlncj0n6XT9wOeZXMV4Klp9PiKW8ZANwU9LJuOVCi7/58tTG6R
	 zW741Uql4YnHg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3e552eff09so123767766b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 04:58:31 -0800 (PST)
X-Gm-Message-State: AOJu0YwDVyh7J5haim6mghrbEnAlbuFFIXC1/LWuM83j+9Ulf6E2ugb4
	nnhrmYSLMMACj398ZdW/pNO4lU4FWkH5z4KO9ZiRTOxoviaPmJrNOgHqSkmDemJCOVEXYPsetJJ
	VS8/ou63DHEd0syxdtGtz671uqTE=
X-Google-Smtp-Source: AGHT+IFCMH8o3xbtyLfeXPo5kastckJDdQarmKGBUx6YfEu6GxLhx8ydBuhn0NFK3aQsQMNHS+XI/hZAq9yMHxOyWVU=
X-Received: by 2002:a17:906:ae4c:b0:a43:76d4:806c with SMTP id
 lf12-20020a170906ae4c00b00a4376d4806cmr1375271ejb.74.1709211510238; Thu, 29
 Feb 2024 04:58:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4b26736862c49050ef907e6f326ab34c0e82c6b8.1709208898.git.jth@kernel.org>
In-Reply-To: <4b26736862c49050ef907e6f326ab34c0e82c6b8.1709208898.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 29 Feb 2024 12:57:53 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7takPu4rcrwMv2v-F9Dt-Hh8i3N6oi2X=XFsZMkhRwfw@mail.gmail.com>
Message-ID: <CAL3q7H7takPu4rcrwMv2v-F9Dt-Hh8i3N6oi2X=XFsZMkhRwfw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zoned: fix use-after-free in do_zone_finish
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 12:37=E2=80=AFPM Johannes Thumshirn <jth@kernel.org=
> wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Shinichiro reported the following use-after-free triggered by the device
> replace operation in fstests btrfs/070.
>
>  BTRFS info (device nullb1): scrub: finished on devid 1 with status: 0
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  BUG: KASAN: slab-use-after-free in do_zone_finish+0x91a/0xb90 [btrfs]
>  Read of size 8 at addr ffff8881543c8060 by task btrfs-cleaner/3494007
>
>  CPU: 0 PID: 3494007 Comm: btrfs-cleaner Tainted: G        W          6.8=
.0-rc5-kts #1
>  Hardware name: Supermicro Super Server/X11SPi-TF, BIOS 3.3 02/21/2020
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x5b/0x90
>   print_report+0xcf/0x670
>   ? __virt_addr_valid+0x200/0x3e0
>   kasan_report+0xd8/0x110
>   ? do_zone_finish+0x91a/0xb90 [btrfs]
>   ? do_zone_finish+0x91a/0xb90 [btrfs]
>   do_zone_finish+0x91a/0xb90 [btrfs]
>   btrfs_delete_unused_bgs+0x5e1/0x1750 [btrfs]
>   ? __pfx_btrfs_delete_unused_bgs+0x10/0x10 [btrfs]
>   ? btrfs_put_root+0x2d/0x220 [btrfs]
>   ? btrfs_clean_one_deleted_snapshot+0x299/0x430 [btrfs]
>   cleaner_kthread+0x21e/0x380 [btrfs]
>   ? __pfx_cleaner_kthread+0x10/0x10 [btrfs]
>   kthread+0x2e3/0x3c0
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x31/0x70
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1b/0x30
>   </TASK>
>
>  Allocated by task 3493983:
>   kasan_save_stack+0x33/0x60
>   kasan_save_track+0x14/0x30
>   __kasan_kmalloc+0xaa/0xb0
>   btrfs_alloc_device+0xb3/0x4e0 [btrfs]
>   device_list_add.constprop.0+0x993/0x1630 [btrfs]
>   btrfs_scan_one_device+0x219/0x3d0 [btrfs]
>   btrfs_control_ioctl+0x26e/0x310 [btrfs]
>   __x64_sys_ioctl+0x134/0x1b0
>   do_syscall_64+0x99/0x190
>   entry_SYSCALL_64_after_hwframe+0x6e/0x76
>
>  Freed by task 3494056:
>   kasan_save_stack+0x33/0x60
>   kasan_save_track+0x14/0x30
>   kasan_save_free_info+0x3f/0x60
>   poison_slab_object+0x102/0x170
>   __kasan_slab_free+0x32/0x70
>   kfree+0x11b/0x320
>   btrfs_rm_dev_replace_free_srcdev+0xca/0x280 [btrfs]
>   btrfs_dev_replace_finishing+0xd7e/0x14f0 [btrfs]
>   btrfs_dev_replace_by_ioctl+0x1286/0x25a0 [btrfs]
>   btrfs_ioctl+0xb27/0x57d0 [btrfs]
>   __x64_sys_ioctl+0x134/0x1b0
>   do_syscall_64+0x99/0x190
>   entry_SYSCALL_64_after_hwframe+0x6e/0x76
>
>  The buggy address belongs to the object at ffff8881543c8000
>   which belongs to the cache kmalloc-1k of size 1024
>  The buggy address is located 96 bytes inside of
>   freed 1024-byte region [ffff8881543c8000, ffff8881543c8400)
>
>  The buggy address belongs to the physical page:
>  page:00000000fe2c1285 refcount:1 mapcount:0 mapping:0000000000000000 ind=
ex:0x0 pfn:0x1543c8
>  head:00000000fe2c1285 order:3 entire_mapcount:0 nr_pages_mapped:0 pincou=
nt:0
>  flags: 0x17ffffc0000840(slab|head|node=3D0|zone=3D2|lastcpupid=3D0x1ffff=
f)
>  page_type: 0xffffffff()
>  raw: 0017ffffc0000840 ffff888100042dc0 ffffea0019e8f200 dead000000000002
>  raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
>  page dumped because: kasan: bad access detected
>
>  Memory state around the buggy address:
>   ffff8881543c7f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   ffff8881543c7f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  >ffff8881543c8000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                         ^
>   ffff8881543c8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8881543c8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>
> This UAF happens because we're accessing stale zone information of a
> already removed btrfs_device in do_zone_finish().
>
> The sequence of events is as follows:
>
> btrfs_dev_replace_start
>   btrfs_scrub_dev
>    btrfs_dev_replace_finishing
>     btrfs_dev_replace_update_device_in_mapping_tree <-- devices replaced
>     btrfs_rm_dev_replace_free_srcdev
>      btrfs_free_device                              <-- device freed
>
> cleaner_kthread
>  btrfs_delete_unused_bgs
>   btrfs_zone_finish
>    do_zone_finish              <-- refers the freed device
>
> The reason for this is that we're using a cached pointer to the chunk_map
> from the block group, but on device replace this cached pointer can
> contain stale device entries.
>
> So grab a fresh reference to the chunk map and don't rely on the cached
> version.
>
> Many thanks to Shinichiro for analyzing the bug.
>
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/zoned.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 3317bebfca95..c27d2214136e 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2237,7 +2237,8 @@ static int do_zone_finish(struct btrfs_block_group =
*block_group, bool fully_writ
>         btrfs_clear_data_reloc_bg(block_group);
>         spin_unlock(&block_group->lock);
>
> -       map =3D block_group->physical_map;
> +       map =3D btrfs_find_chunk_map(fs_info, block_group->start,
> +                                  block_group->length);

This fits nicely within a single line, why the split?

So the whole problem comes from the fact that
block_group->physical_map is a clone of the original chunk map, which
the device replace operation didn't update.

Don't we need to update block_group->physical_map?
I don't see anywhere else updating it, it's only set when loading
block groups from disk at mount time or when creating a new one.
After a device is replaced it's never updated. So can't this
use-after-free happen in other code paths that use the stale chunk map
at block_group->physical_map?

Thanks.




>         for (i =3D 0; i < map->num_stripes; i++) {
>                 struct btrfs_device *device =3D map->stripes[i].dev;
>                 const u64 physical =3D map->stripes[i].physical;
> --
> 2.35.3
>
>

