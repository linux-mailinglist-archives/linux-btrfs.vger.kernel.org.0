Return-Path: <linux-btrfs+bounces-17166-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACCEB9C721
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 01:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64DE73B7B0E
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 23:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DD1287514;
	Wed, 24 Sep 2025 23:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyQzqpV7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832DE27E066
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Sep 2025 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755160; cv=none; b=Lc5uqIiAMWbECdC5kSjF1K3RwzcfGppdyEVlz/XBgsnduB3VxjlOCYteOUJ27Pk8YfETrwRcc3lV3nYvWlMgXUv6nFHGghDWcpfXLN3r4FXABIbNDfPedSSo9BrTEv4Sfp2Huzdn4NiNLubXTJbSmsyaCSKyqoPlF3GBdrmvaXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755160; c=relaxed/simple;
	bh=uAIUM5kEWDxj2jhiX0kgAmV7e4LyfD5HXVUA7w8a9PE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pUTGthsTldizCrweDXtfgVvaxuQPUTIZtQAmmvrbG6F9illPQ7TGwoiAIzNrMcNdqdbJAIIucSPM7+3FVUE1kr3YsEn9o57ly+jMTllWjaIrcc7HSQeZ6fV6Yi9FCxGeQ5Kcy9CRI3p8TW4AqFKhJ3/dPFwpD6nGWdcAcdW7UJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyQzqpV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7BFC4CEF8
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Sep 2025 23:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758755160;
	bh=uAIUM5kEWDxj2jhiX0kgAmV7e4LyfD5HXVUA7w8a9PE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HyQzqpV7CAGHHy9MLziU+QeH2bYC2x15nYqBCvOzZq01KK8uQoRkqrZqheqRl785Y
	 iRwBJiV5py6WISIvlltk0GhghwIZAhxEIJ1WL/ugNqT8PiMuIvOK1m5dt2qxKSr5WR
	 yWn9oTiruXLDJVlcbUVVOBiw63sZtW7IxzGD/rb6UywQ/eQDnEjrMyyTrGFC1q45yh
	 iwWId6gNrvgoXG74o9x720xXJsOFEwqYD+gmLm9TIJvF8psSFm3SWcISmDkIo5eg/0
	 Y5K1O8AJy9eXiOMhk1pry/Wl69sf+k4xjrk2JPK2oJgBdvJ4z/g1mJUn/ei4Ent+DN
	 9nLvk2SIcYuxA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61a8c134533so522930a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Sep 2025 16:06:00 -0700 (PDT)
X-Gm-Message-State: AOJu0YyMKSh1S2Yjh9KpSWDgz3RTXPpOYDOBXF8djYc90+pMcIxg0AT9
	+QhlPQbrO8yV5rA8Uku/IwU/v/KdSpV+6XZzVGylp6bvCPoeV3zAY3PqbJSub6tPoN3yz0+SUJQ
	5EwWv/bC3PNhsx5lrrk6yZ4UVso8EAaI=
X-Google-Smtp-Source: AGHT+IHN/8bbObF6rkRUslEs33+O3JtUSW/t1q5/X3OThb6Fuxb/sAUocMsXGO11g/PBlGWk8OXRUe9LLDWBOlrCgUI=
X-Received: by 2002:a17:907:9805:b0:b33:a2ef:c7 with SMTP id
 a640c23a62f3a-b34beba93f8mr146461666b.55.1758755158731; Wed, 24 Sep 2025
 16:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0d537ef90213e54835f7aaa090498787db27b33a.1758752652.git.boris@bur.io>
In-Reply-To: <0d537ef90213e54835f7aaa090498787db27b33a.1758752652.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 25 Sep 2025 00:05:21 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7v-9M485_svy_5BCaWVaf+61DvFB6gMUEWhR=2ykM+qw@mail.gmail.com>
X-Gm-Features: AS18NWCzvw4dUCGnbLGsveKPy9wM-707qu_jpTA1nDUDWqfIAhsJ0y3iUZakBR4
Message-ID: <CAL3q7H7v-9M485_svy_5BCaWVaf+61DvFB6gMUEWhR=2ykM+qw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: don't ignore ENOMEM in btrfs_add_chunk_map()
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 11:24=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> btrfs_set_extent_bit() can return ENOMEM, which
> chunk_map_device_(set|clear)_bits() was ignoring, so
> btrfs_add_chunk_map() was silently failing in those cases. This led to
> double allocating dev extents, ultimately resulting in an EEXIST in
> add_dev_extent_item(): (ignore the btrfs_force_chunk_alloc_store thing,
> we are using a DEBUG feature that isn't widely used here)
>
>   ------------[ cut here ]------------
>   BTRFS: Transaction aborted (error -17)
>   WARNING: CPU: 5 PID: 3586339 at fs/btrfs/block-group.c:2764 btrfs_creat=
e_pending_block_groups+0x5fc/0x620
>   RIP: 0010:btrfs_create_pending_block_groups+0x5fc/0x620
>   Code: 9c fd ff ff 48 c7 c7 e8 69 64 82 44 89 ee e8 4b 87 e6 ff 0f 0b e9=
 99 fe ff ff 48 c7 c7 e8 69 64 82 48 8b 34 24 e8 34 87 e6 ff <0f> 0b eb a0 =
48 c7 c7 e8 69 64 82 44 89 e6 e8 21 87 e6 ff 0f 0b e9
>   RSP: 0018:ffffc90060693d38 EFLAGS: 00010286
>   RAX: 0000000000000026 RBX: ffff8882be92fed8 RCX: 0000000000000027
>   RDX: ffff88bf42f6e040 RSI: ffff88bf42f60c48 RDI: ffff88bf42f60c48
>   RBP: ffff888282585d18 R08: 0000000000000000 R09: 0000000000000000
>   R10: 4000000000000000 R11: 000000000000691d R12: ffff88c0471a3300
>   R13: 0000001dc6500000 R14: ffff8882829d9000 R15: ffff8882be92ff40
>   FS:  00007f7ccbc2c740(0000) GS:ffff88bf42f40000(0000) knlGS:00000000000=
00000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000004e421c8 CR3: 0000000cd6384001 CR4: 0000000000770ef0
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    ? __warn+0xa0/0x130
>    ? btrfs_create_pending_block_groups+0x5fc/0x620
>    ? report_bug+0xf2/0x150
>    ? handle_bug+0x3d/0x70
>    ? exc_invalid_op+0x16/0x40
>    ? asm_exc_invalid_op+0x16/0x20
>    ? btrfs_create_pending_block_groups+0x5fc/0x620
>    ? btrfs_create_pending_block_groups+0x5fc/0x620
>    __btrfs_end_transaction.llvm.3999538623537568469+0x3d/0x1c0
>    btrfs_force_chunk_alloc_store+0xaf/0x100
>    ? sysfs_kf_read+0x90/0x90
>    kernfs_fop_write_iter.llvm.10031329899921036925+0xd0/0x180
>    __x64_sys_write+0x279/0x5a0
>    do_syscall_64+0x63/0x130
>    ? exc_page_fault+0x63/0x130
>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
>   RIP: 0033:0x7f7ccb4ff28f
>   Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 a9 89 f8 ff 48 8b 54 24=
 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 =
ff ff 77 31 44 89 c7 48 89 44 24 08 e8 fc 89 f8 ff 48
>   RSP: 002b:00007ffda7138f20 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
>   RAX: ffffffffffffffda RBX: 0000000009c13140 RCX: 00007f7ccb4ff28f
>   RDX: 0000000000000001 RSI: 0000000004e401b0 RDI: 00000000000000c8
>   RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
>   R10: 0000000000008000 R11: 0000000000000293 R12: 0000000000000000
>   R13: 0000000000408820 R14: 0000000000407f00 R15: 00007ffda7138fc0
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
>   BTRFS: error (device nvme0n1p2 state A) in btrfs_create_pending_block_g=
roups:2764: errno=3D-17 Object already exists
>   BTRFS warning (device nvme0n1p2 state EA): Skipping commit of aborted t=
ransaction.
>   BTRFS: error (device nvme0n1p2 state EA) in cleanup_transaction:2018: e=
rrno=3D-17 Object already exists
>
> This was pretty confusing to debug and I think it would be helpful to
> get the proper ENOMEM error sent up to the appropriate transaction when
> it happens.
>
> Note:
> Most callsites of btrfs_set_extent_bit() are not checked, however, which
> does give me pause. Either we have a lot more inaccuracies like this out
> there, or I have misanalyzed this scenario. I was able to reproduce the
> above calltrace by injecting enomem errors in to the set_extent_bits
> path here, for what it's worth.

Most callers are not checking -ENOMEM (or other errors) because we
shouldn't have -ENOMEM with any of the functions that end up at
set_extent_bit().
There, under the 'again' label, before taking the io tree's lock we do:

prealloc =3D alloc_extent_state(mask);

If that returns NULL, we proceed, take the lock and navigate the rb tree.
If it turns out we need an extent state record (and we don't always
need one), we call alloc_extent_state_atomic().
If that fails (returns NULL) we do a goto 'search_again', which
unlocks the tree and does a goto to the 'again' label at the very top,
where we once again call alloc_extent_state() and repeat all those
steps again.

So if we can't allocate memory, we keep doing that loop over and over
until we can allocate or don't need to allocate (due to concurrent
changes in the tree) - we never return -ENOMEM in set_extent_bit().

The same logic applies to btrfs_clear_extent_bit_changeset(), the core
function to clear bits from a range - we don't ever return -ENOMEM and
keep looping until we can allocate.

The only io tree function we return -ENOMEM is for the convert
operation (btrfs_convert_extent_bit()), where the single caller can
deal with -ENOMEM (I remember doing that logic many years ago).

So I don't know what that error injection you mention is doing or that
btrfs_force_chunk_alloc_store thing you mention with some custom
debugging feature, but I don't see how we can return -ENOMEM.
Care to elaborate in detail?

Thanks.



>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/volumes.c | 47 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 35 insertions(+), 12 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 2bec544d8ba3..eda5b6b907d9 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5434,28 +5434,42 @@ static int decide_stripe_size(struct btrfs_fs_dev=
ices *fs_devices,
>         }
>  }
>
> -static void chunk_map_device_set_bits(struct btrfs_chunk_map *map, unsig=
ned int bits)
> +static int chunk_map_device_set_bits(struct btrfs_chunk_map *map, unsign=
ed int bits)
>  {
> +       int ret;
> +
>         for (int i =3D 0; i < map->num_stripes; i++) {
>                 struct btrfs_io_stripe *stripe =3D &map->stripes[i];
>                 struct btrfs_device *device =3D stripe->dev;
>
> -               btrfs_set_extent_bit(&device->alloc_state, stripe->physic=
al,
> -                                    stripe->physical + map->stripe_size =
- 1,
> -                                    bits | EXTENT_NOWAIT, NULL);
> +               ret =3D btrfs_set_extent_bit(
> +                       &device->alloc_state, stripe->physical,
> +                       stripe->physical + map->stripe_size - 1,
> +                       bits | EXTENT_NOWAIT, NULL);
> +               if (ret)
> +                       return ret;
>         }
> +       ret =3D 0;
> +       return ret;
>  }
>
> -static void chunk_map_device_clear_bits(struct btrfs_chunk_map *map, uns=
igned int bits)
> +static int chunk_map_device_clear_bits(struct btrfs_chunk_map *map, unsi=
gned int bits)
>  {
> +       int ret;
> +
>         for (int i =3D 0; i < map->num_stripes; i++) {
>                 struct btrfs_io_stripe *stripe =3D &map->stripes[i];
>                 struct btrfs_device *device =3D stripe->dev;
>
> -               btrfs_clear_extent_bit(&device->alloc_state, stripe->phys=
ical,
> -                                      stripe->physical + map->stripe_siz=
e - 1,
> -                                      bits | EXTENT_NOWAIT, NULL);
> +               ret =3D btrfs_clear_extent_bit(
> +                       &device->alloc_state, stripe->physical,
> +                       stripe->physical + map->stripe_size - 1,
> +                       bits | EXTENT_NOWAIT, NULL);
> +               if (ret)
> +                       return ret;
>         }
> +       ret =3D 0;
> +       return ret;
>  }
>
>  void btrfs_remove_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_=
chunk_map *map)
> @@ -5488,6 +5502,7 @@ static int btrfs_chunk_map_cmp(const struct rb_node=
 *new,
>  EXPORT_FOR_TESTS
>  int btrfs_add_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chun=
k_map *map)
>  {
> +       int ret;
>         struct rb_node *exist;
>
>         write_lock(&fs_info->mapping_tree_lock);
> @@ -5498,11 +5513,19 @@ int btrfs_add_chunk_map(struct btrfs_fs_info *fs_=
info, struct btrfs_chunk_map *m
>                 write_unlock(&fs_info->mapping_tree_lock);
>                 return -EEXIST;
>         }
> -       chunk_map_device_set_bits(map, CHUNK_ALLOCATED);
> -       chunk_map_device_clear_bits(map, CHUNK_TRIMMED);
> -       write_unlock(&fs_info->mapping_tree_lock);
>
> -       return 0;
> +       ret =3D chunk_map_device_set_bits(map, CHUNK_ALLOCATED);
> +       if (ret)
> +               goto out;
> +       ret =3D chunk_map_device_clear_bits(map, CHUNK_TRIMMED);
> +
> +out:
> +       if (ret) {
> +               rb_erase_cached(&map->rb_node, &fs_info->mapping_tree);
> +               RB_CLEAR_NODE(&map->rb_node);
> +       }
> +       write_unlock(&fs_info->mapping_tree_lock);
> +       return ret;
>  }
>
>  EXPORT_FOR_TESTS
> --
> 2.50.1
>
>

