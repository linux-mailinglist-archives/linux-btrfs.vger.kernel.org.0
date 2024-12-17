Return-Path: <linux-btrfs+bounces-10490-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B81459F50ED
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 17:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E361888C39
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 16:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6133A1DF251;
	Tue, 17 Dec 2024 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLD8AGgC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AE013B780
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734452623; cv=none; b=HyU57fEaOd+lVKXB0pAW4/ezpmkxbFlWRJsvyyl0qQzoslhvW5WW0J6xU4rMvPEl/bpvTjXoC/CtaUqAw7M3WBNmiRCszVlSI7z4F10EksyWqw3ABRSICFYAO7QcyaAX3FsPZe8w9PX6qXc8AHxwWDKvNA5zLtKuBS3h9vDEsBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734452623; c=relaxed/simple;
	bh=MW7FNNWtTdUSt8QjlDhkLBzpvaJsQ5/oWsIUw0bnwos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWXjDaOG7Blyq01NwRpfFufaDO3iVpHIQmZ+yd9aZNjOMfBWc3SJRTpikuFiNSF4lj/Zd9Q5W7RFbJmZdUKSJsVCqkTfI244wa5Gr5GuuBRI+U9ieU02q0isvaVrGGTMZyo5Zve2zJq3BoqqGEIXpMJBwhVe5K40xQU5ZZAs6cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLD8AGgC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01159C4CEDE
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 16:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734452622;
	bh=MW7FNNWtTdUSt8QjlDhkLBzpvaJsQ5/oWsIUw0bnwos=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hLD8AGgCNLZpEUm95ppzhnx9ZPP4ffK7C4aYB3nKdkN08S0mqFAFMWaIUHPsbxkSP
	 my5+v/U+WezYoOevFtYGFNMjODUbLJFROgR5nYAppPT2Z3nVRUloRjDKhvePnKPK3N
	 yn0EdnUA12B9ekqdYmy+D4XM8bX7AjBAz75j9mWh9sAyOg5ivyIPb+JmgShVIrphy4
	 sE1G4vcgwGu9Ku9NlYUyhW5JPgDc71v8BleL0pWWpD9OXPD/hUHroR/MIjH3M5gnMc
	 4UZU9ClCcmD8/qYy+ZPDKXZ1Srbc6+bOdrDTWXWvvY9gmlQqi1pakNOsDkVBlmhvk0
	 zZ1cusEz5gM9Q==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3e9a88793so9184065a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 08:23:41 -0800 (PST)
X-Gm-Message-State: AOJu0YwT0BywMSqZKLbSJNyZ9pbqMY+IueLfHmUrLBzsaiXpPImlgHIR
	oaB0S6YCACweP3P+AncY409osd5FQVoLQuAzM8lXLu1SP5Jyk5zQ58vm88IahWSng+oNchRQcjc
	Ta5x7SBOyeYpOcQeFA4TdoWM7lUE=
X-Google-Smtp-Source: AGHT+IF0f1sXczzQ6lbWdKagIkHTaBBzyMYB9PSNF9nPPBaVQimgoN56zdhiW5TVI74Nqt7QYMT7mqw8IXURG6HVqhc=
X-Received: by 2002:a17:906:dc89:b0:aa6:6ea7:e5a7 with SMTP id
 a640c23a62f3a-aab779c7dc7mr1836640166b.28.1734452620515; Tue, 17 Dec 2024
 08:23:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733989299.git.jth@kernel.org> <1b225c76de3d41571e080a03d971a961de26d9bb.1733989299.git.jth@kernel.org>
In-Reply-To: <1b225c76de3d41571e080a03d971a961de26d9bb.1733989299.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Dec 2024 16:23:03 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7+AFOfQs090Ta=tv+H+D7qObZh2gBOfmzN3hcxUmrxjQ@mail.gmail.com>
Message-ID: <CAL3q7H7+AFOfQs090Ta=tv+H+D7qObZh2gBOfmzN3hcxUmrxjQ@mail.gmail.com>
Subject: Re: [PATCH 08/14] btrfs: don't use btrfs_set_item_key_safe on RAID stripe-extents
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Damien Le Moal <dlemoal@kernel.org>, David Sterba <dsterba@suse.com>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 7:56=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Don't use btrfs_set_item_key_safe() to modify the keys in the RAID
> stripe-tree as this can lead to corruption of the tree, which is caught b=
y
> the checks in btrfs_set_item_key_safe():
>
>  BTRFS critical (device nvme1n1): slot 201 key (5679448064 230 32768) new=
 key (5680439296 230 1028096)

Ok, so you cut one of the most interesting parts, the leaf dump which
would allow us to see the wrong key order.
It's interesting because it can tell us if we're in the wrong slot by
a shift of 1, 2, 3, etc.

>  ------------[ cut here ]------------
>  kernel BUG at fs/btrfs/ctree.c:2672!
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

Ok, but why does the bug happen?

If we get a corruption due to a bad key order when calling
btrfs_set_item_key_safe(), based on past experience with
btrfs_drop_extents() on subvolume trees and log trees,
it means we have one of the following 2 bugs (or we have both):

1) We computed a wrong new key which we pass to btrfs_set_item_key_safe();

2) We are calling btrfs_set_item_key_safe() with the path pointing to
an incorrect slot.

Does this still happen after all the previous fixes?

I would like to have the changelog explain why this bug happens.
Give an example leaf layout and an example range passed to
btrfs_delete_raid_extent(), and go through the steps that lead to the
bug.


Also,looking through all these fixes, and previous ones from the past,
I can't stop thinking:

This is the same problem solved by btrfs_drop_extents(), but instead
of file extent items, it's for stripe extent items.
But it's basically the same - we have items that represent ranges and
we want to delete and trim/adjust items that overlap a given range.

In fact this is a simplified case of btrfs_drop_extents(), because
unlike file extent items, there are no references (in the extent tree)
for stripe extent items, or inline extents or items representing holes
(disk_bytenr =3D=3D 0 in the case of file extent items).

So it seems btrfs_delete_raid_extent() could be literally a rip-off of
btrfs_drop_extents(), using stripe extent items instead of file extent
items and removing all that fat that doesn't exist for strip extent
items.

This way we would get all the correctness and optimizations from the
btrfs_drop_extents() algorithm which has been tested for well over a
decade.
Does it make sense?

Thanks.

>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/raid-stripe-tree.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 6ec72732c4ad..f713d8417681 100644
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
> --
> 2.43.0
>
>

