Return-Path: <linux-btrfs+bounces-2998-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0FD870845
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 18:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8607828287D
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 17:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB931612E7;
	Mon,  4 Mar 2024 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/iu5YVU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126401FA4
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Mar 2024 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709573394; cv=none; b=PhnzinSllOQ1kS/LcP5m+FCl6jdDnzdKOehSNR2cV5e6lnK0w4YVGm+mSiBPNEj8zRxH1+rObIkCaZQW4ImDWqWUmrvu627sjJ7kgPvx/ZMcvbh1DXldwLYRBn9/+AdrE9J14F81M74wwwUVm+aFc8/k4ws8oMbI7VzlLL2X+80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709573394; c=relaxed/simple;
	bh=hhXwc3N+37gWmWMlcERPYyuejmbseFka62Xo+el17PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jem4O140AZuRnG4YSMtZbepkP5PZg8vpaWGShUyUx47HHbSj1f46RY31Sq+x0V82UbLTvgK8iojaZgRaa/SKQzVzMlZ1rz8ktdvgechL0BPwD8FheBzz9vMC4y/4uHpxQ0H5qmmMr0Ov1gNKjIXdlIroNdQwrrD/Cneo75yu7wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/iu5YVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD1DC43394
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Mar 2024 17:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709573393;
	bh=hhXwc3N+37gWmWMlcERPYyuejmbseFka62Xo+el17PQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A/iu5YVUx5vty4EIrJVFklIN6huoYI7Y5NbOXIUYBKChf7fyGcZ7CM+rsq8a5sbGB
	 RpVEa5/hjrv57KHXaZl5X3HhTANk9wVEje8N67jYpJxvyOv0q5WtO3ThVRefaZ/NfH
	 5KBLF5+go/rcP6y+/LyReQhkGzgXG0nO5hPIshcynZAltF+gpVrcASVsxpVpBtqI6Z
	 LXLp+7xcJb1R7qwZvzMCH+vKWweXSnP6483/mfhyZ7h0xI8WaXHwmcH/4ZOL+CW0w7
	 vtJCUwXM1gSKtrYg5Exn/5Ji/2RvudXptbCxvjb3JxbcfxXU3RWH7+uNrGgRcRhdhC
	 5ir6Lo/Br3cPQ==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5654f700705so6478403a12.1
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Mar 2024 09:29:53 -0800 (PST)
X-Gm-Message-State: AOJu0Yys1ZL0mRaEo5hrvyQ5XCVO3ympqgrWFWF1Bs61DfRqa3Z4o2am
	yxyoFh/JiWsmNyn9NzuOiATAaUXxBOHnAqMgNpXZ66tcUgDO9OKJPegKRTglGtHVWBEE9M1I7kU
	Z/7Wc7YNl81G40cS8C8sBq6eE0Rk=
X-Google-Smtp-Source: AGHT+IFHA4cF+6N0Vs5EC4gNf8DwYJI2SqCIOeHZS8P3k+HMUCJxelZvK5HpYPexu2WKYnL5+D/L0lbgQ2cSe6kLn3Q=
X-Received: by 2002:a17:906:40cf:b0:a3f:1cb6:fb00 with SMTP id
 a15-20020a17090640cf00b00a3f1cb6fb00mr6997899ejk.69.1709573392002; Mon, 04
 Mar 2024 09:29:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bb74e2b2a59797e085e2dfd44c904113439ecb46.1709539467.git.jth@kernel.org>
In-Reply-To: <bb74e2b2a59797e085e2dfd44c904113439ecb46.1709539467.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 4 Mar 2024 17:29:14 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7Gvcxi1PCeX8QzqFidXQi5ozP=WZ6AKi2pTPb1aCwLWQ@mail.gmail.com>
Message-ID: <CAL3q7H7Gvcxi1PCeX8QzqFidXQi5ozP=WZ6AKi2pTPb1aCwLWQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: zoned: fix use-after-free in do_zone_finish
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 11:46=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
 wrote:
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
> The staleness comes from the fact, that btrfs_block_group::physical_map i=
s
> not a pointer to a btrfs_chunk_map but a memory copy of it.
>
> Many thanks to Shinichiro for analyzing the bug.
>
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> ---
> Changes to v1:
> - Don't clone chunk map but grab a reference
> - v1 can be found here: https://lore.kernel.org/linux-btrfs/94b4286e-7c64=
-4573-a680-0360305d2db4@kernel.org
> ---
>  fs/btrfs/zoned.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 3317bebfca95..6aaeb72e00d7 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1561,11 +1561,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_=
block_group *cache, bool new)
>         if (!map)
>                 return -EINVAL;
>
> -       cache->physical_map =3D btrfs_clone_chunk_map(map, GFP_NOFS);
> -       if (!cache->physical_map) {
> -               ret =3D -ENOMEM;
> -               goto out;
> -       }
> +       cache->physical_map =3D map;
>
>         zone_info =3D kcalloc(map->num_stripes, sizeof(*zone_info), GFP_N=
OFS);
>         if (!zone_info) {
> @@ -1677,7 +1673,6 @@ int btrfs_load_block_group_zone_info(struct btrfs_b=
lock_group *cache, bool new)
>         }
>         bitmap_free(active);
>         kfree(zone_info);
> -       btrfs_free_chunk_map(map);
>
>         return ret;
>  }
> @@ -2238,6 +2233,7 @@ static int do_zone_finish(struct btrfs_block_group =
*block_group, bool fully_writ
>         spin_unlock(&block_group->lock);
>
>         map =3D block_group->physical_map;
> +       refcount_inc(&map->refs);

Why do we need to increment the ref count here?

Normally we would do this when caching the chunk map in the block
group, above at btrfs_load_block_group_zone_info().
That's the pattern we usually follow, for example when adding a block
group to the unused or reclaim lists, we increment the block group's
ref count, and then drop it when removed from the list.

Also, this doesn't seem race free.

See below.


>         for (i =3D 0; i < map->num_stripes; i++) {
>                 struct btrfs_device *device =3D map->stripes[i].dev;

Here we grab the old device, before
btrfs_dev_replace_update_device_in_mapping_tree() replaces it with the
new one (target device),
and then before we're done using the device, replace finishes and
frees the old (source) device - we'll have a use-after-free.

This is the same type of race as fixed in commit
57ba4cb85bffc0c7c6567c89d23713721fea9655
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3D57ba4cb85bffc0c7c6567c89d23713721fea9655).

>                 const u64 physical =3D map->stripes[i].physical;
> @@ -2259,6 +2255,8 @@ static int do_zone_finish(struct btrfs_block_group =
*block_group, bool fully_writ
>                 btrfs_dev_clear_active_zone(device, physical);
>         }
>
> +       btrfs_free_chunk_map(map);

There's a missing btrfs_free_chunk_map() call in an error path, in
case we return from the loop above due to an error returned by
blkdev_zone_mgmt().

Thanks.


> +
>         if (!fully_written)
>                 btrfs_dec_block_group_ro(block_group);
>
> --
> 2.35.3
>
>

