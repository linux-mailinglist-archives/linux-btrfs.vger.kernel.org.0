Return-Path: <linux-btrfs+bounces-12095-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1023DA56A16
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 15:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32DF01764CF
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 14:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB8A21ADD6;
	Fri,  7 Mar 2025 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWtqeeGP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066F32185BC
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356836; cv=none; b=io3GYjytZHgmuseklKHL9/nt4xiCUn/2qVevOyQK1BFs2zCjOUZhcpiROkz3NIEMH5oOE9/TDge3vEkqA07C5biJbHI1mydz0FvF4XtQbBS7edhvTyfPn+qHunZUD6tu/EzlAmoF6n8C2XEbd4W/JC2O4U+v43xB13AWJFLOxwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356836; c=relaxed/simple;
	bh=ZGQ1b8NojolNGdZX27ppzne0wDRN+UzO4AADM2G7NaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3rVIf/89fVe/WpqUo/Ly6O1XUpLdEsOo/u7lMn4cjM9rOy5vz6okWQe5XxkbtDibYrTmQe0ZaQ2XEyJod/IGzxy5BaiOQRd6sf+Hd5gcS6GFFVtURAyJ5nM4JwhvB2EHUOW+VaTnCDHnR7eLJ/cKhiVZZk0ad0+UgCldaC4gKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWtqeeGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A86C4CED1
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 14:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741356835;
	bh=ZGQ1b8NojolNGdZX27ppzne0wDRN+UzO4AADM2G7NaM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HWtqeeGPNb7BYUmDxk6uihBOzH7hSjPIkwZBmu4/7OWZNYYzSrQDAqaKqnvYv1OWC
	 erio0fivp2QafWSRqcUt6xBZtGzdVkMiuOyZMyhFjnYldYtvOZYOw8XfmRpcoJrl2H
	 GFRm16/E3i81AesQYnT6TkDMsQw1zRwppcXm605zilOdRt8AZ+D34tQV9lJD5rZSpu
	 oKo+n10XU6RK0qlywviu0vp1OHkWW6YT3Qy4TCLcyzosSGKjhlEwNOT/iIg86mj1rX
	 kkMlWAlXeNOI35Tz+u+ym41dmyAyl3f1LNfLKA1fYJM8pq+IAXmIJoaDIvqBV0gQ3H
	 lpb7QT+K6QUxg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abf5e1a6cd3so350757066b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Mar 2025 06:13:55 -0800 (PST)
X-Gm-Message-State: AOJu0Yy0AM0zx3GwMQrxQqweOMXm/v1Uz5R9+QAfdeavDnjJfggtOKDj
	iU8MkJKjGxCFuWt96MNM5yaTerj0ul/fzbw59XFA3EdXnuI9hrBH4hhvHtLXu88cI6+mFuQMXGs
	ILsJkdBA8VnDK2pHJfRQMMVcqTvk=
X-Google-Smtp-Source: AGHT+IGW2EGKD3q1Sz9veIdv5MQA35pA5eNLCXXfslALlQqxjG9XaMjL7QsTg/NsD+mAOgl4QMJbXcVIdRnpVWEzMfY=
X-Received: by 2002:a17:906:dc90:b0:abf:59a3:df19 with SMTP id
 a640c23a62f3a-ac25302feb2mr380843566b.57.1741356833973; Fri, 07 Mar 2025
 06:13:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741306938.git.boris@bur.io> <f66e903dd583274967fcd45844e6444c4a49d98b.1741306938.git.boris@bur.io>
In-Reply-To: <f66e903dd583274967fcd45844e6444c4a49d98b.1741306938.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 7 Mar 2025 14:13:15 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4ErZWCa2qC1UgXVCfahA1Qx=WdeEGJ8E3COCLuH-n=5A@mail.gmail.com>
X-Gm-Features: AQ5f1JqCaa6TO3gJi0gWOX_yuZ_15n0Woz3D0KyAgB_K4s3SyK_o38BHNESjOh4
Message-ID: <CAL3q7H4ErZWCa2qC1UgXVCfahA1Qx=WdeEGJ8E3COCLuH-n=5A@mail.gmail.com>
Subject: Re: [PATCH 1/5] btrfs: fix bg refcount race in btrfs_create_pending_block_groups
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 12:31=E2=80=AFAM Boris Burkov <boris@bur.io> wrote:
>
> To avoid a race where mark_bg_unused spuriously "moved" the block_group
> from one bg_list attachment to another without taking a ref, we mark a
> new block group with the bit BLOCK_GROUP_FLAG_NEW.
>
> However, this fix is not quite complete. Since it does not use the
> unused_bg_lock, it is possible for the following race to occur:
>
> create_pending_block_groups                     mark_bg_unused

mark_bg_unused -> btrfs_mark_bg_unused

>                                            if list_empty // false
>         list_del_init
>         clear_bit
>                                            else if (test_bit) // true
>                                                 list_move_tail

This should mention how that sequence is possible, i.e. on a higher level.

For example the task that created the block group ended up not
allocating extents from it,
and other tasks allocated extents from it and deallocated so that the
block group became empty
and was added to the unused list before the task that created it
finished btrfs_create_pending_block_groups().

Or was it some other scenario?

Thanks.

>
> And we get into the exact same broken ref count situation.
> Those look something like:
> [ 1272.943113] ------------[ cut here ]------------
> [ 1272.943527] refcount_t: underflow; use-after-free.
> [ 1272.943967] WARNING: CPU: 1 PID: 61 at lib/refcount.c:28 refcount_warn=
_saturate+0xba/0x110
> [ 1272.944731] Modules linked in: btrfs virtio_net xor zstd_compress raid=
6_pq null_blk [last unloaded: btrfs]
> [ 1272.945550] CPU: 1 UID: 0 PID: 61 Comm: kworker/u32:1 Kdump: loaded Ta=
inted: G        W          6.14.0-rc5+ #108
> [ 1272.946368] Tainted: [W]=3DWARN
> [ 1272.946585] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S Arch Linux 1.16.3-1-1 04/01/2014
> [ 1272.947273] Workqueue: btrfs_discard btrfs_discard_workfn [btrfs]
> [ 1272.947788] RIP: 0010:refcount_warn_saturate+0xba/0x110
> [ 1272.948180] Code: 01 01 e8 e9 c7 a9 ff 0f 0b c3 cc cc cc cc 80 3d 3f 4=
a de 01 00 75 85 48 c7 c7 00 9b 9f 8f c6 05 2f 4a de 01 01 e8 c6 c7 a9 ff <=
0f> 0b c3 cc cc cc cc 80 3d 1d 4a de 01 00 0f 85 5e ff ff ff 48 c7
> [ 1272.949532] RSP: 0018:ffffbf1200247df0 EFLAGS: 00010282
> [ 1272.949901] RAX: 0000000000000000 RBX: ffffa14b00e3f800 RCX: 000000000=
0000000
> [ 1272.950437] RDX: 0000000000000000 RSI: ffffbf1200247c78 RDI: 00000000f=
fffdfff
> [ 1272.950986] RBP: ffffa14b00dc2860 R08: 00000000ffffdfff R09: ffffffff9=
0526268
> [ 1272.951512] R10: ffffffff904762c0 R11: 0000000063666572 R12: ffffa14b0=
0dc28c0
> [ 1272.952024] R13: 0000000000000000 R14: ffffa14b00dc2868 R15: 000001285=
dcd12c0
> [ 1272.952850] FS:  0000000000000000(0000) GS:ffffa14d33c40000(0000) knlG=
S:0000000000000000
> [ 1272.953458] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1272.953931] CR2: 00007f838cbda000 CR3: 000000010104e000 CR4: 000000000=
00006f0
> [ 1272.954474] Call Trace:
> [ 1272.954655]  <TASK>
> [ 1272.954812]  ? refcount_warn_saturate+0xba/0x110
> [ 1272.955173]  ? __warn.cold+0x93/0xd7
> [ 1272.955487]  ? refcount_warn_saturate+0xba/0x110
> [ 1272.955816]  ? report_bug+0xe7/0x120
> [ 1272.956103]  ? handle_bug+0x53/0x90
> [ 1272.956424]  ? exc_invalid_op+0x13/0x60
> [ 1272.956700]  ? asm_exc_invalid_op+0x16/0x20
> [ 1272.957011]  ? refcount_warn_saturate+0xba/0x110
> [ 1272.957399]  btrfs_discard_cancel_work.cold+0x26/0x2b [btrfs]
> [ 1272.957853]  btrfs_put_block_group.cold+0x5d/0x8e [btrfs]
> [ 1272.958289]  btrfs_discard_workfn+0x194/0x380 [btrfs]
> [ 1272.958729]  process_one_work+0x130/0x290
> [ 1272.959026]  worker_thread+0x2ea/0x420
> [ 1272.959335]  ? __pfx_worker_thread+0x10/0x10
> [ 1272.959644]  kthread+0xd7/0x1c0
> [ 1272.959872]  ? __pfx_kthread+0x10/0x10
> [ 1272.960172]  ret_from_fork+0x30/0x50
> [ 1272.960474]  ? __pfx_kthread+0x10/0x10
> [ 1272.960745]  ret_from_fork_asm+0x1a/0x30
> [ 1272.961035]  </TASK>
> [ 1272.961238] ---[ end trace 0000000000000000 ]---
>
> Though we have seen them in the async discard workfn as well. It is
> most likely to happen after a relocation finishes which cancels discard,
> tears down the block group, etc.
>
> Fix this fully by taking the lock around the list_del_init + clear_bit
> so that the two are done atomically.
>
> Fixes: 0657b20c5a76 ("btrfs: fix use-after-free of new block group that b=
ecame unused")
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/block-group.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 64f0268dcf02..2db1497b58d9 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2797,8 +2797,11 @@ void btrfs_create_pending_block_groups(struct btrf=
s_trans_handle *trans)
>                 /* Already aborted the transaction if it failed. */
>  next:
>                 btrfs_dec_delayed_refs_rsv_bg_inserts(fs_info);
> +
> +               spin_lock(&fs_info->unused_bgs_lock);
>                 list_del_init(&block_group->bg_list);
>                 clear_bit(BLOCK_GROUP_FLAG_NEW, &block_group->runtime_fla=
gs);
> +               spin_unlock(&fs_info->unused_bgs_lock);
>
>                 /*
>                  * If the block group is still unused, add it to the list=
 of
> --
> 2.48.1
>
>

