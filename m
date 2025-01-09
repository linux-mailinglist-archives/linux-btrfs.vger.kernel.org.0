Return-Path: <linux-btrfs+bounces-10870-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F11A07C36
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072583A448B
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE3B21D5A5;
	Thu,  9 Jan 2025 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f41J9Ljf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC241FECBD;
	Thu,  9 Jan 2025 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437530; cv=none; b=mLf1SZrSpNKr2naDLKQJESCL59bjdBKJu2UuzwoY0z7QBtM9U4FMqjHBwA14G0pUdNbP86pcIgeA16gFiz901eviHFQ51sfzPZ0jANgbJqhFuHf/QnI1wZ+5ZmXvIWsrrIRTFGmZtjGqCF9nbqTdqTjfSUgvHSMZk8/b/jluhyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437530; c=relaxed/simple;
	bh=+15k3G6sGemho6gXe8AZhj+kkWo8GD6ekUtIlj7OQbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8kawEB/10hGN4FRlzQG1MVQT4EC3fJhM38L232tYdeZN4fOk+NocLIfZddFdpwzPmxp6+GXKnnZ6xR7wDbFIUyFQ083XidSEh6BrFovev2vuqO6Mnou8Cw3CcQZ2CiE/umsitK/cariPp7TQOXhtu2cevpU2JzXLzMUtnDKxsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f41J9Ljf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC863C4CED3;
	Thu,  9 Jan 2025 15:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736437528;
	bh=+15k3G6sGemho6gXe8AZhj+kkWo8GD6ekUtIlj7OQbA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f41J9LjftLnvBvJZoSAPB6hRiI9kypCMBtcYLwLS3+5mJQcmJS+M5G/+rSdWdKvxd
	 dWocsF94QeeIzqEcW2iOlg60ePEG295Ed1f8xEROlijqWsa12kADO4wsrBKUAydj8D
	 Fkr/wUgXwEjGRJYuETaifo3xlWkQAvHws+59WdzCZFTY9gJV9T1PDygoUaDM/a/+kn
	 M2oH/ZuasBfPZEvijdie0FS3dr5hMhhqF798EcrZyV0AJHyaDYiRLiPLeI2Gazo7VZ
	 ERmL4EO7SYK8Xh6ftQP6g/uQpJx0JbNbvPLRz7OaoOGdJHPR8lDoN5ElUvB1nAWSN6
	 f5W0xzm13ATTQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d437235769so1533248a12.2;
        Thu, 09 Jan 2025 07:45:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVG+HCyi2FkSF7BzMrIUZNL5gw6AgKNHVM7vak+wUyseN3aRZ9WwwHTc8iFHXn/1VRNLTYyMMW+TF9AKg==@vger.kernel.org, AJvYcCWgbS1s4kNy5r1tGYEdLYEFvecmekUZ/OsJpIqDbj79XUMoS/+3PyTRymA+MJj0cEKRMN/GsEvEejBzXvoK@vger.kernel.org
X-Gm-Message-State: AOJu0YxsXdkaxhshblntOLapwDuJTuWPVbTrYBMg5YmEG6YblkXqbxHc
	1jYXrtjBr6noUnntajDkoZEiHO7gBHm/JGp739tTtwW+VHv7NKzKgSgV+VLLBDaifk334ne57pq
	zws2ZiT1/xhz4t6jnRxUnUOrQlo4=
X-Google-Smtp-Source: AGHT+IESoBC0OQz8e3miNcOeViKg2PtljVUtwLgNHM5z0VWAtgdfnRJD9/BFk/u3bq8zr0Pw0bQuZ+Bh49hnieKu02o=
X-Received: by 2002:a17:907:2cc6:b0:aa6:23ba:d8c8 with SMTP id
 a640c23a62f3a-ab2ab6a8503mr663084666b.11.1736437527434; Thu, 09 Jan 2025
 07:45:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org> <20250107-rst-delete-fixes-v2-8-0c7b14c0aac2@kernel.org>
In-Reply-To: <20250107-rst-delete-fixes-v2-8-0c7b14c0aac2@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 9 Jan 2025 15:44:50 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5eRPN1GTOHdTwjgFuy-DWQtvju=qffGCVY_oi_KrDP7A@mail.gmail.com>
X-Gm-Features: AbW1kvb5VQAT1pncnkGWQK6_vTP-t8hBvGBWQdXcbP1eDYuYwnJcfN1PyOYVxlY
Message-ID: <CAL3q7H5eRPN1GTOHdTwjgFuy-DWQtvju=qffGCVY_oi_KrDP7A@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] btrfs: don't use btrfs_set_item_key_safe on RAID stripe-extents
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 12:59=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Don't use btrfs_set_item_key_safe() to modify the keys in the RAID
> stripe-tree as this can lead to corruption of the tree, which is caught b=
y
> the checks in btrfs_set_item_key_safe():
>
>  BTRFS info (device nvme1n1): leaf 49168384 gen 15 total ptrs 194 free sp=
ace 8329 owner 12
>  BTRFS info (device nvme1n1): refs 2 lock_owner 1030 current 1030
>   [ snip ]
>   item 105 key (354549760 230 20480) itemoff 14587 itemsize 16
>                   stride 0 devid 5 physical 67502080
>   item 106 key (354631680 230 4096) itemoff 14571 itemsize 16
>                   stride 0 devid 1 physical 88559616
>   item 107 key (354631680 230 32768) itemoff 14555 itemsize 16
>                   stride 0 devid 1 physical 88555520
>   item 108 key (354717696 230 28672) itemoff 14539 itemsize 16
>                   stride 0 devid 2 physical 67604480
>   [ snip ]
>  BTRFS critical (device nvme1n1): slot 106 key (354631680 230 32768) new =
key (354635776 230 4096)
>  ------------[ cut here ]------------
>  kernel BUG at fs/btrfs/ctree.c:2602!
>  Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
>  CPU: 1 UID: 0 PID: 1055 Comm: fsstress Not tainted 6.13.0-rc1+ #1464
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3=
-gd478f380-rebuilt.opensuse.org 04/01/2014
>  RIP: 0010:btrfs_set_item_key_safe+0xf7/0x270
>  Code: <snip>
>  RSP: 0018:ffffc90001337ab0 EFLAGS: 00010287
>  RAX: 0000000000000000 RBX: ffff8881115fd000 RCX: 0000000000000000
>  RDX: 0000000000000001 RSI: 0000000000000001 RDI: 00000000ffffffff
>  RBP: ffff888110ed6f50 R08: 00000000ffffefff R09: ffffffff8244c500
>  R10: 00000000ffffefff R11: 00000000ffffffff R12: ffff888100586000
>  R13: 00000000000000c9 R14: ffffc90001337b1f R15: ffff888110f23b58
>  FS:  00007f7d75c72740(0000) GS:ffff88813bd00000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007fa811652c60 CR3: 0000000111398001 CR4: 0000000000370eb0
>  Call Trace:
>   <TASK>
>   ? __die_body.cold+0x14/0x1a
>   ? die+0x2e/0x50
>   ? do_trap+0xca/0x110
>   ? do_error_trap+0x65/0x80
>   ? btrfs_set_item_key_safe+0xf7/0x270
>   ? exc_invalid_op+0x50/0x70
>   ? btrfs_set_item_key_safe+0xf7/0x270
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? btrfs_set_item_key_safe+0xf7/0x270
>   btrfs_partially_delete_raid_extent+0xc4/0xe0
>   btrfs_delete_raid_extent+0x227/0x240
>   __btrfs_free_extent.isra.0+0x57f/0x9c0
>   ? exc_coproc_segment_overrun+0x40/0x40
>   __btrfs_run_delayed_refs+0x2fa/0xe80
>   btrfs_run_delayed_refs+0x81/0xe0
>   btrfs_commit_transaction+0x2dd/0xbe0
>   ? preempt_count_add+0x52/0xb0
>   btrfs_sync_file+0x375/0x4c0
>   do_fsync+0x39/0x70
>   __x64_sys_fsync+0x13/0x20
>   do_syscall_64+0x54/0x110
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  RIP: 0033:0x7f7d7550ef90
>  Code: <snip>
>  RSP: 002b:00007ffd70237248 EFLAGS: 00000202 ORIG_RAX: 000000000000004a
>  RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f7d7550ef90
>  RDX: 000000000000013a RSI: 000000000040eb28 RDI: 0000000000000004
>  RBP: 000000000000001b R08: 0000000000000078 R09: 00007ffd7023725c
>  R10: 00007f7d75400390 R11: 0000000000000202 R12: 028f5c28f5c28f5c
>  R13: 8f5c28f5c28f5c29 R14: 000000000040b520 R15: 00007f7d75c726c8
>   </TASK>
>
> Instead copy the item, adjust the key and per-device physical addresses
> and re-insert it into the tree.

So my comments are basically the same as in the previous version.
Why do we hit this situation, what's the bug in the algorithm that
makes us try to set a key that breaks the key ordering in the leaf?

Did this happen even with all previous fixes applied?

Looking at this change log I'm reading it as "not sure what causes the
bug, so switching to a delete + insert as that always results in a
correct key order".

Thanks.


>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/raid-stripe-tree.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index d15df49c61a86a4188b822b05453428e444920b5..a4225ad043216e5d7035a71ea=
b6bcc49b242836f 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -13,12 +13,13 @@
>  #include "volumes.h"
>  #include "print-tree.h"
>
> -static void btrfs_partially_delete_raid_extent(struct btrfs_trans_handle=
 *trans,
> +static int btrfs_partially_delete_raid_extent(struct btrfs_trans_handle =
*trans,
>                                                struct btrfs_path *path,
>                                                const struct btrfs_key *ol=
dkey,
>                                                u64 newlen, u64 frontpad)
>  {
> -       struct btrfs_stripe_extent *extent;
> +       struct btrfs_root *stripe_root =3D trans->fs_info->stripe_root;
> +       struct btrfs_stripe_extent *extent, *new;
>         struct extent_buffer *leaf;
>         int slot;
>         size_t item_size;
> @@ -27,6 +28,7 @@ static void btrfs_partially_delete_raid_extent(struct b=
trfs_trans_handle *trans,
>                 .type =3D BTRFS_RAID_STRIPE_KEY,
>                 .offset =3D newlen,
>         };
> +       int ret;
>
>         ASSERT(newlen > 0);
>         ASSERT(oldkey->type =3D=3D BTRFS_RAID_STRIPE_KEY);
> @@ -34,17 +36,31 @@ static void btrfs_partially_delete_raid_extent(struct=
 btrfs_trans_handle *trans,
>         leaf =3D path->nodes[0];
>         slot =3D path->slots[0];
>         item_size =3D btrfs_item_size(leaf, slot);
> +
> +       new =3D kzalloc(item_size, GFP_NOFS);
> +       if (!new)
> +               return -ENOMEM;
> +
>         extent =3D btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent)=
;
>
>         for (int i =3D 0; i < btrfs_num_raid_stripes(item_size); i++) {
>                 struct btrfs_raid_stride *stride =3D &extent->strides[i];
>                 u64 phys;
>
> -               phys =3D btrfs_raid_stride_physical(leaf, stride);
> -               btrfs_set_raid_stride_physical(leaf, stride, phys + front=
pad);
> +               phys =3D btrfs_raid_stride_physical(leaf, stride) + front=
pad;
> +               btrfs_set_stack_raid_stride_physical(&new->strides[i], ph=
ys);
>         }
>
> -       btrfs_set_item_key_safe(trans, path, &newkey);
> +       ret =3D btrfs_del_item(trans, stripe_root, path);
> +       if (ret)
> +               goto out;
> +
> +       btrfs_release_path(path);
> +       ret =3D btrfs_insert_item(trans, stripe_root, &newkey, new, item_=
size);
> +
> +out:
> +       kfree(new);
> +       return ret;
>  }
>
>  int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start=
, u64 length)
>
> --
> 2.43.0
>
>

