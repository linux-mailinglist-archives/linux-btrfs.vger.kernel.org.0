Return-Path: <linux-btrfs+bounces-6038-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 265B091BBFD
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 11:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB131C223C3
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 09:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48B915382F;
	Fri, 28 Jun 2024 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q754dL4a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ED41C683
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719568622; cv=none; b=DWJfOlwtvDOV+8ccblw3hWH/+I9mlkcKPztbYUwuwJqu0d7p5+eKkXgG3INNpGzOsywA6FoTLygF7WKIbg6WcYjXVoDvw+/IWbEUIHSd4f3P0e/YCuT1SmmLV2W+FsTuFIUTlhXgOjm5+9lwcQ0soWV7LuH/39tvkwmqLAjgm68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719568622; c=relaxed/simple;
	bh=Pl8M4IowkSWhap5WpIBiHelZ+EeqpCELD7lKmZp91CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMnDIADsYdjRv6yjX+y5MTmtG8wTgvk5d9MO4+R2qHjbfu64/7ythO9trKDSKepgNZjpFUzhjYbj2Kog156pdyUvyN23fsnJ4/V2SD0Sb0ha1YwgwvghkqmI81sv7gLj87NCOJSkJ8eG3l40dG8k6ojzxq18EQCiqpsa8H/u3jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q754dL4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F41C2BD10
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 09:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719568621;
	bh=Pl8M4IowkSWhap5WpIBiHelZ+EeqpCELD7lKmZp91CA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q754dL4aTia9xhBJ2DUc5/oE/oTttCqLLkKcJFW9ptFb1eW/4Bevn2+RKyPS6DKB4
	 S9HFVtCgvPd3/2bOH3S6WjYQeXiCjMFrMbd5kzYtnhEFLX5YIFII3BVYlVZ04h0WLc
	 AUUAb9MAYKUWGTE00Eewwyf2+557xmHc8WvcrG9XtfPlqoEmik8Px4XFASMteY83v+
	 13T3rftHqcEI4PRcHzI/Dhe4v6LJMCEGzsDaD+mpuOlPrfzw+lv0WKMOJ1ZjoZPp0v
	 Z25dYhB9Y5BbcpLYegUNw4/WhNiaojq1ucptbMqd5O80kU8zWqty3n7SKevI8NjZyF
	 GCEUj4ox7R+UQ==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a724598cfe3so54799366b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 02:57:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8iRvNrvPoC40u/+UbDSRffuhfD2JJTjTWEyP+XKKEf4lomVjtyL+Em5XswJLoCjIzFzKVg20xyWk5r4Mv5InVxziNA6QlR3yVjLc=
X-Gm-Message-State: AOJu0YxieFEHmCLiosA2p63krKkENjZUf8A7IrEQUA8NvwUq4RsJDsfM
	xjFJOzPmxX9XZltsNdaGsctqMRtOTCJLXO7KO18rWqU48YVyGrFbGIlGcPt9wW8Fa1FKyVNDLjc
	4h9Qe9kFE0/WyeKR7A5I2PUVqxlg=
X-Google-Smtp-Source: AGHT+IEGekNxl8krxPpSsh5JPIRbMJUMy/RvVMRcQ6sZlk9yQWAWmYltJgDNKCbppPsWC3D2R1aaKrZGVlYBrQ00A8M=
X-Received: by 2002:a17:906:3090:b0:a6f:58a6:fed8 with SMTP id
 a640c23a62f3a-a7245ba45damr1199262066b.28.1719568620015; Fri, 28 Jun 2024
 02:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <58e8574ccd70645c613e6bc7d328e34c2f52421a.1719549099.git.naohiro.aota@wdc.com>
 <89357644-24e6-4894-86b6-fbe5d369dd0a@gmx.com>
In-Reply-To: <89357644-24e6-4894-86b6-fbe5d369dd0a@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 28 Jun 2024 10:56:23 +0100
X-Gmail-Original-Message-ID: <CAL3q7H61vRKdUq63ja_usTev6k74q6VBJ+tHcTty_wBqceCtTQ@mail.gmail.com>
Message-ID: <CAL3q7H61vRKdUq63ja_usTev6k74q6VBJ+tHcTty_wBqceCtTQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: avoid possible parallel list adding
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 6:37=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/6/28 14:02, Naohiro Aota =E5=86=99=E9=81=93:
> > There is a potential parallel list adding for retrying in
> > btrfs_reclaim_bgs_work and adding to the unused list. Since the block
> > group is removed from the reclaim list and it is on a relocation work,
> > it can be added into the unused list in parallel. When that happens,
> > adding it to the reclaim list will corrupt the list head and trigger
> > list corruption like below.
> >
> > Fix it by taking fs_info->unused_bgs_lock.
> >
> > [27177.504101][T2585409] BTRFS error (device nullb1): error relocating =
ch=3D unk 2415919104
> > [27177.514722][T2585409] list_del corruption. next->prev should be ff11=
00=3D 0344b119c0, but was ff11000377e87c70. (next=3D3Dff110002390cd9c0)
> > [27177.529789][T2585409] ------------[ cut here ]------------
> > [27177.537690][T2585409] kernel BUG at lib/list_debug.c:65!
> > [27177.545548][T2585409] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KA=
SAN NOPTI
> > [27177.555466][T2585409] CPU: 9 PID: 2585409 Comm: kworker/u128:2 Taint=
ed: G        W          6.10.0-rc5-kts #1
> > [27177.568502][T2585409] Hardware name: Supermicro SYS-520P-WTR/X12SPW-=
TF, BIOS 1.2 02/14/2022
> > [27177.579784][T2585409] Workqueue: events_unbound btrfs_reclaim_bgs_wo=
rk[btrfs]
> > [27177.589946][T2585409] RIP: 0010:__list_del_entry_valid_or_report.col=
d+0x70/0x72
> > [27177.600088][T2585409] Code: fa ff 0f 0b 4c 89 e2 48 89 de 48 c7 c7 c=
0
> > 8c 3b 93 e8 ab 8e fa ff 0f 0b 4c 89 e1 48 89 de 48 c7 c7 00 8e 3b 93 e8
> > 97 8e fa ff <0f> 0b 48 63 d1 4c 89 f6 48 c7 c7 e0 56 67 94 89 4c 24 04
> > e8 ff f2
> > [27177.624173][T2585409] RSP: 0018:ff11000377e87a70 EFLAGS: 00010286
> > [27177.633052][T2585409] RAX: 000000000000006d RBX: ff11000344b119c0 RC=
X:0000000000000000
> > [27177.644059][T2585409] RDX: 000000000000006d RSI: 0000000000000008 RD=
I:ffe21c006efd0f40
> > [27177.655030][T2585409] RBP: ff110002e0509f78 R08: 0000000000000001 R0=
9:ffe21c006efd0f08
> > [27177.665992][T2585409] R10: ff11000377e87847 R11: 0000000000000000 R1=
2:ff110002390cd9c0
> > [27177.676964][T2585409] R13: ff11000344b119c0 R14: ff110002e0508000 R1=
5:dffffc0000000000
> > [27177.687938][T2585409] FS:  0000000000000000(0000) GS:ff11000fec88000=
0(0000) knlGS:0000000000000000
> > [27177.700006][T2585409] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
> > [27177.709431][T2585409] CR2: 00007f06bc7b1978 CR3: 0000001021e86005 CR=
4:0000000000771ef0
> > [27177.720402][T2585409] DR0: 0000000000000000 DR1: 0000000000000000 DR=
2:0000000000000000
> > [27177.731337][T2585409] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR=
7:0000000000000400
> > [27177.742252][T2585409] PKRU: 55555554
> > [27177.748207][T2585409] Call Trace:
> > [27177.753850][T2585409]  <TASK>
> > [27177.759103][T2585409]  ? __die_body.cold+0x19/0x27
> > [27177.766405][T2585409]  ? die+0x2e/0x50
> > [27177.772498][T2585409]  ? do_trap+0x1ea/0x2d0
> > [27177.779139][T2585409]  ? __list_del_entry_valid_or_report.cold+0x70/=
0x72
> > [27177.788518][T2585409]  ? do_error_trap+0xa3/0x160
> > [27177.795649][T2585409]  ? __list_del_entry_valid_or_report.cold+0x70/=
0x72
> > [27177.805045][T2585409]  ? handle_invalid_op+0x2c/0x40
> > [27177.812022][T2585409]  ? __list_del_entry_valid_or_report.cold+0x70/=
0x72
> > [27177.820947][T2585409]  ? exc_invalid_op+0x2d/0x40
> > [27177.827608][T2585409]  ? asm_exc_invalid_op+0x1a/0x20
> > [27177.834637][T2585409]  ? __list_del_entry_valid_or_report.cold+0x70/=
0x72
> > [27177.843519][T2585409]  btrfs_delete_unused_bgs+0x3d9/0x14c0 [btrfs]
> >
> > There is a similar retry_list code in btrfs_delete_unused_bgs(), but it=
 is
> > safe, AFAIC. Since the block group was in the unused list, the used byt=
es
> > should be 0 when it was added to the unused list. Then, it checks
> > block_group->{used,resereved,pinned} are still 0 under the
> > block_group->lock. So, they should be still eligible for the unused lis=
t,
> > not the reclaim list.
> >
> > Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Suggested-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> > Fixes: 4eb4e85c4f81 ("btrfs: retry block group reclaim without infinite=
 loop")
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Just to mention, I find another location which may cause problems:
>
> - btrfs_make_block_group()
>    We call list_add_tail() to add the current bg to trans->new_bgs,
>    without any extra locking.
>
>    Not sure if it's racy, as it doesn't look that possible to call
>    btrfs_make_block_group() on the same trans handler, but maybe we want
>    to make sure it's safe.

It's safe there, because it happens in the first phase of block
creation before the block group can be found
by any task other than the task that created the block group.

If at that point anyone had already added the block group to the
reclaim list, or unused list, or any other list,
the second phase of block group creation would not happen, and things
would break pretty bad, we would
have extents pointing to block groups without all the items in the
chunk tree and device tree etc (chunk item,
device extent items).

>
> Thanks,
> Qu
> > ---
> >   fs/btrfs/block-group.c | 13 +++++++++++--
> >   1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index 7cde40fe6a50..498442d0c216 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -1945,8 +1945,17 @@ void btrfs_reclaim_bgs_work(struct work_struct *=
work)
> >   next:
> >               if (ret && !READ_ONCE(space_info->periodic_reclaim)) {
> >                       /* Refcount held by the reclaim_bgs list after sp=
lice. */
> > -                     btrfs_get_block_group(bg);
> > -                     list_add_tail(&bg->bg_list, &retry_list);
> > +                     spin_lock(&fs_info->unused_bgs_lock);
> > +                     /*
> > +                      * This block group might be added to the unused =
list
> > +                      * during the above process. Move it back to the
> > +                      * reclaim list otherwise.
> > +                      */
> > +                     if (list_empty(&bg->bg_list)) {
> > +                             btrfs_get_block_group(bg);
> > +                             list_add_tail(&bg->bg_list, &retry_list);
> > +                     }
> > +                     spin_unlock(&fs_info->unused_bgs_lock);
> >               }
> >               btrfs_put_block_group(bg);
> >
>

