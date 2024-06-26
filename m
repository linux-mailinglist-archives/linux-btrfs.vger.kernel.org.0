Return-Path: <linux-btrfs+bounces-5991-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B53659183A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 16:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2D31F22ACF
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 14:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C6118413A;
	Wed, 26 Jun 2024 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4B0iwQp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1691E52A
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719410828; cv=none; b=ERbUur0EnivzT0VRl73DM9RM28EQSKo0dYpWJjzoZ/74itBpuQU0r8a3zIFaUrUOF7m62ve/1A42qlE9+ev2fJt4/epV4uYhSY2Apn7RX1vhuojTklJbrR/HVlxCWl+etkB4RtPrA2QM80/Nvdj8FT8yhKEy2Q0VdG3YzQIT5SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719410828; c=relaxed/simple;
	bh=+HyQ8ILf/W0yM6ZgpxZBzhy5V+0ygCwXs+fqp+Y0kA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4h611h0zhaznhJ8WcQD9iTB3Jr6A1KJ5C0WdElxyFrdaGDLlH1ZQLXGRjKc74o/wMlVsOFmijSzVm+A/E+e30Yh7dDePlUyB4wxcOlTieGFPjHUHespx2Ad0Rleis5gT68OxE3IEKE3YQ3KYpFWxyC9V7E66BvTk4uxXRIVl2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4B0iwQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B78C116B1
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 14:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719410828;
	bh=+HyQ8ILf/W0yM6ZgpxZBzhy5V+0ygCwXs+fqp+Y0kA0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k4B0iwQpR9aS6E1yHq80vR3gO5QvrHfyqp3y3sx/8p4y6ooRsW4cCcewaF8DI+pFK
	 oYw1A9de15lUMiTaPliiV5V5F+dMJk/DJ4bNTg9oCwkTakPfdkOHWnzGAVe6IR2qzw
	 cYr5hPBeJ6XbchLgGB2B7oB0mgtleM/dAOmagZBaIF88aGUvA9yzU5CMt+nydC4xVm
	 olmeuHFzA6dl11I91iUt7jP+mEs6DUNJxv9yksNYMXAKMVI5O8GW9KlBQPfPgfgbgu
	 Odu+AUxR7bHQdSfOa08Hokhs2DC/sZ0fSry7GFQ4zFk7TjTCDMz5sZ8HCl1rVgAHnj
	 L6OZY3oxQ7kVg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a725d756d41so106081766b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 07:07:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YwvAA4jOoClnCtS83JMRPOdSLkbovBFsUKnPLIgK38bqsMrk6/r
	pUx/OiQyHiBO1gOvi9e6PuZEjXgwmw3vW3JGKdzib8XlMkB3K/v4KBM2vvfNdRH3E8sRv3m3UXL
	jNHcC+GxR5bNR9MRS8KEOSc+4Pvc=
X-Google-Smtp-Source: AGHT+IFjXpCp/iIrINpbV27fpvrhaNGESO6ExN3jHpJsv+TunKg79qXpjOjvBC3MoGURhlY1c1vdn3BdjQ0DhBKJTvA=
X-Received: by 2002:a17:907:160e:b0:a72:7ede:4d12 with SMTP id
 a640c23a62f3a-a727fb41dfamr314062066b.5.1719410826859; Wed, 26 Jun 2024
 07:07:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719246104.git.dsterba@suse.com>
In-Reply-To: <cover.1719246104.git.dsterba@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 26 Jun 2024 15:06:29 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4SEL0vFz_r-BDre_RU+mM6SQ8TP5HuA2FS6fKbVVBvGg@mail.gmail.com>
Message-ID: <CAL3q7H4SEL0vFz_r-BDre_RU+mM6SQ8TP5HuA2FS6fKbVVBvGg@mail.gmail.com>
Subject: Re: [PATCH 00/11] Inode type conversion
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 5:24=E2=80=AFPM David Sterba <dsterba@suse.com> wro=
te:
>
> A small batch converting inode to btrfs_inode for internal functions and
> data structures.
>
> David Sterba (11):
>   btrfs: pass a btrfs_inode to btrfs_readdir_put_delayed_items()
>   btrfs: pass a btrfs_inode to btrfs_readdir_get_delayed_items()
>   btrfs: pass a btrfs_inode to is_data_inode()
>   btrfs: switch btrfs_block_group::inode to struct btrfs_inode
>   btrfs: pass a btrfs_inode to btrfs_ioctl_send()
>   btrfs: switch btrfs_pending_snapshot::dir to btrfs_inode
>   btrfs: switch btrfs_ordered_extent::inode to struct btrfs_inode
>   btrfs: pass a btrfs_inode to btrfs_compress_heuristic()
>   btrfs: pass a btrfs_inode to btrfs_set_prop()
>   btrfs: pass a btrfs_inode to btrfs_load_inode_props()
>   btrfs: pass a btrfs_inode to btrfs_inode_inherit_props()

One of these changes to the properties is broken.
btrfs/048 triggers this:

[74513.242475] BUG: kernel NULL pointer dereference, address: 0000000000000=
208
[74513.242651] #PF: supervisor read access in kernel mode
[74513.242796] #PF: error_code(0x0000) - not-present page
[74513.242935] PGD 0 P4D 0
[74513.243073] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
[74513.243217] CPU: 1 PID: 254085 Comm: btrfs Not tainted
6.10.0-rc5-btrfs-next-164+ #1
[74513.243363] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[74513.243511] RIP: 0010:prop_compression_apply+0x2f/0x150 [btrfs]
[74513.243724] Code: 53 48 89 fb 48 85 d2 0f 84 e7 00 00 00 48 89 f0
48 83 fa 02 74 44 48 83 fa 04 0f 84 f4 00 00 00 48 8b 93 78 fe ff ff
80 38 6c <4c> 8b 82 08 02 00 00 75 53 80 78 01 7a 75 4d 80 78 02 6f 75
47 48
[74513.244038] RSP: 0018:ffffa8a3850c79e0 EFLAGS: 00010246
[74513.244195] RAX: ffff893e8111b468 RBX: ffff893e91f12448 RCX: 00000000000=
00003
[74513.244353] RDX: 0000000000000000 RSI: ffff893e8111b468 RDI: ffff893e91f=
12448
[74513.244510] RBP: ffffffffc0c94c00 R08: 000000000000007a R09: 00000000000=
0006f
[74513.244668] R10: ffffa8a3850c7a10 R11: 6e6f697373657270 R12: 00000000000=
00000
[74513.244827] R13: ffff893e8111b468 R14: ffff893e803ca560 R15: 00000000000=
00003
[74513.244992] FS:  00007fcaf745c380(0000) GS:ffff8941afc40000(0000)
knlGS:0000000000000000
[74513.245147] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[74513.245302] CR2: 0000000000000208 CR3: 0000000117120006 CR4: 00000000003=
70ef0
[74513.245464] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[74513.245626] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[74513.245789] Call Trace:
[74513.245955]  <TASK>
[74513.246126]  ? __die_body+0x1b/0x60
[74513.246295]  ? page_fault_oops+0x158/0x4e0
[74513.246463]  ? do_user_addr_fault+0x63/0x820
[74513.246629]  ? exc_page_fault+0x73/0x170
[74513.246796]  ? asm_exc_page_fault+0x22/0x30
[74513.246967]  ? prop_compression_apply+0x2f/0x150 [btrfs]
[74513.247195]  inode_prop_iterator+0x22/0x70 [btrfs]
[74513.247420]  btrfs_load_inode_props+0x2c0/0x330 [btrfs]
[74513.247648]  btrfs_iget_path+0x497/0x700 [btrfs]
[74513.247872]  btrfs_lookup_dentry+0x355/0x5d0 [btrfs]
[74513.248097]  ? d_alloc_parallel+0x2a5/0x400
[74513.248281]  btrfs_lookup+0xe/0x30 [btrfs]
[74513.248509]  __lookup_slow+0x82/0x130
[74513.248703]  walk_component+0xe5/0x160
[74513.248900]  path_lookupat.isra.0+0x6e/0x150
[74513.249092]  filename_lookup+0xc7/0x190
[74513.249285]  ? do_pte_missing+0x86d/0xc50
[74513.249478]  ? __pte_offset_map+0x17/0x140
[74513.249674]  ? preempt_count_add+0x47/0xa0
(...)


>
>  fs/btrfs/bio.c              |  2 +-
>  fs/btrfs/block-group.c      |  4 ++--
>  fs/btrfs/block-group.h      |  2 +-
>  fs/btrfs/btrfs_inode.h      |  4 ++--
>  fs/btrfs/compression.c      |  6 +++---
>  fs/btrfs/compression.h      |  2 +-
>  fs/btrfs/delayed-inode.c    | 12 +++++------
>  fs/btrfs/delayed-inode.h    |  4 ++--
>  fs/btrfs/extent_io.c        |  2 +-
>  fs/btrfs/free-space-cache.c |  4 ++--
>  fs/btrfs/inode.c            | 18 ++++++++--------
>  fs/btrfs/ioctl.c            | 16 +++++++-------
>  fs/btrfs/ordered-data.c     | 22 +++++++++----------
>  fs/btrfs/ordered-data.h     |  2 +-
>  fs/btrfs/props.c            | 43 ++++++++++++++++++-------------------
>  fs/btrfs/props.h            |  8 +++----
>  fs/btrfs/relocation.c       |  2 +-
>  fs/btrfs/send.c             |  4 ++--
>  fs/btrfs/send.h             |  4 ++--
>  fs/btrfs/subpage.c          |  4 ++--
>  fs/btrfs/transaction.c      |  2 +-
>  fs/btrfs/transaction.h      |  2 +-
>  fs/btrfs/xattr.c            |  2 +-
>  fs/btrfs/zoned.c            |  8 +++----
>  24 files changed, 89 insertions(+), 90 deletions(-)
>
> --
> 2.45.0
>
>

