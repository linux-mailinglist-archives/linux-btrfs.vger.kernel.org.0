Return-Path: <linux-btrfs+bounces-3189-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62668784B3
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 17:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F338282221
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 16:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB280481A2;
	Mon, 11 Mar 2024 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJgDgi8m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C9245943
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Mar 2024 16:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173595; cv=none; b=D6iFznEGn1SSpQTlUi1fWdCon5oaKYiLAo/hGvy4EyQOxIF0v2O0YAT32Xe96eje1X/ql64zsHW9IgojLIbni6kYB4EyrtdWi2rW7eMPFOjncY3vuvOhaY0g82bp1nLq0zsO6389gSeLm2hQdGvcTy/MVMkiazyTo/BWXOowULo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173595; c=relaxed/simple;
	bh=Rta6drMO+AK57/b9y32y0Xq1vQo/zSijwEWCBOgZ+bE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7604ElfVKKX2T3tFIm1gWrgY1hjVltyJqewLn7MIxuI7xDff6Gey47gZcBx70pfld+7Jl4W1iQkbx6zpKodmRzN+phT3aYqda3X4fpPgbpOLOvrKtdD0ta5/oADVPFx0ZZ58RbRLZLBiCGV4ylbfPKEMwxbPUtexx+TGlDFs4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJgDgi8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE35C43394
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Mar 2024 16:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710173594;
	bh=Rta6drMO+AK57/b9y32y0Xq1vQo/zSijwEWCBOgZ+bE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CJgDgi8mm+p/YyU+u0v9evT5Bdwe+hjU/n6x7BRr35hnq9Lsdh7dJli6miB2bi/Nz
	 AmoToAPNbIRjHvPaWiiIYtqKCnFc6q4AUaJ+Xnts2HYHzLYnXzROmBjLCOL/tagCgO
	 USlRc5x83+guKkkvIDFHgA+ieq4B74CcoQ3aqpESeLDTINgAuUN0FFKPlpBA0RngbV
	 cM2nIj6kg56wf+vZMidvfpbRfRqEe4RImZgRZJ8wmuwrUctE5raTkq1mKGn1NYtksR
	 9RlJsaENFNi+dGGwVdVfDhkrUNwumydpqs2C2IPtLiXZM6AzUv1afpA5BtYPU+6Wjm
	 Wx3j9csGjwD9w==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a461e09ddddso166411066b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Mar 2024 09:13:14 -0700 (PDT)
X-Gm-Message-State: AOJu0YwMWhCH1iIKW4NBy0tbxc7YWsKTFOs3L1m0ducSSOAhaRn76MSC
	OwRFH04PMzR7pw87MnYErkK/5uxm/uWelRGP1Esnr5AN7Q7xcXcs05WJPc6ICZ+mU4dNSR5lMj2
	Vb7kB+GXwC7SGJJ5sOLXiXLR5SsU=
X-Google-Smtp-Source: AGHT+IH6+uGk5ykbd4QRigCRSEIFCB9EW10JatdObwcDbdVW+7sFWyop6PzqhqymWKQUXLBKcqK4dci/BWt08PdL9Io=
X-Received: by 2002:a17:907:d40a:b0:a45:2f1b:c07d with SMTP id
 vi10-20020a170907d40a00b00a452f1bc07dmr5135839ejc.10.1710173592912; Mon, 11
 Mar 2024 09:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c6ca670979be870fb7c4c2ad98c5b9a1b9938a05.1710173195.git.jth@kernel.org>
In-Reply-To: <c6ca670979be870fb7c4c2ad98c5b9a1b9938a05.1710173195.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 11 Mar 2024 16:12:35 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4prTn3uU_m83SGNs5HQBwt8uUEONYnp7p8gBpKhZE2pQ@mail.gmail.com>
Message-ID: <CAL3q7H4prTn3uU_m83SGNs5HQBwt8uUEONYnp7p8gBpKhZE2pQ@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: zoned: fix use-after-free in do_zone_finish
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, Filipe Manana <fdmanana@suse.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 4:07=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
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
> Also take the fs_info::dev_replace::rwsem to prevent
> btrfs_dev_replace_update_device_in_mapping_tree() from changing the devic=
e
> underneath us again.
>
> Note: btrfs_dev_replace_update_device_in_mapping_tree() is holding
> fs_info::mapping_tree_lock, but as this is a spinning read/write lock we
> cannot take it as the call to blkdev_zone_mgmt() requires a memory
> allocation which may not sleep.
> But btrfs_dev_replace_update_device_in_mapping_tree() is always called wi=
th
> the fs_info::dev_replace::rwsem held in write mode.
>
> Many thanks to Shinichiro for analyzing the bug.
>
> Cc: Filipe Manana <fdmanana@suse.com>
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

>
> ---
> Changes to v2:
> - Also hold fs_info::dev_replace::rwsem to close race with replaceing
> - v2 can be found here: https://lore.kernel.org/linux-btrfs/bb74e2b2a5979=
7e085e2dfd44c904113439ecb46.1709539467.git.jth@kernel.org
> Changes to v1:
> - Don't clone chunk map but grab a reference
> - v1 can be found here: https://lore.kernel.org/linux-btrfs/94b4286e-7c64=
-4573-a680-0360305d2db4@kernel.org
> ---
>  fs/btrfs/zoned.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 3317bebfca95..459d1af02c3c 100644
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
> @@ -2162,6 +2157,7 @@ static int do_zone_finish(struct btrfs_block_group =
*block_group, bool fully_writ
>         struct btrfs_chunk_map *map;
>         const bool is_metadata =3D (block_group->flags &
>                         (BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_S=
YSTEM));
> +       struct btrfs_dev_replace *dev_replace =3D &fs_info->dev_replace;
>         int ret =3D 0;
>         int i;
>
> @@ -2237,6 +2233,7 @@ static int do_zone_finish(struct btrfs_block_group =
*block_group, bool fully_writ
>         btrfs_clear_data_reloc_bg(block_group);
>         spin_unlock(&block_group->lock);
>
> +       down_read(&dev_replace->rwsem);
>         map =3D block_group->physical_map;
>         for (i =3D 0; i < map->num_stripes; i++) {
>                 struct btrfs_device *device =3D map->stripes[i].dev;
> @@ -2251,13 +2248,16 @@ static int do_zone_finish(struct btrfs_block_grou=
p *block_group, bool fully_writ
>                                        zinfo->zone_size >> SECTOR_SHIFT,
>                                        GFP_NOFS);
>
> -               if (ret)
> +               if (ret) {
> +                       up_read(&dev_replace->rwsem);
>                         return ret;
> +               }
>
>                 if (!(block_group->flags & BTRFS_BLOCK_GROUP_DATA))
>                         zinfo->reserved_active_zones++;
>                 btrfs_dev_clear_active_zone(device, physical);
>         }
> +       up_read(&dev_replace->rwsem);
>
>         if (!fully_written)
>                 btrfs_dec_block_group_ro(block_group);
> --
> 2.35.3
>
>

