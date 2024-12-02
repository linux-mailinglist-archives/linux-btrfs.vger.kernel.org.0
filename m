Return-Path: <linux-btrfs+bounces-10009-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0B79E0574
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 15:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013E628A041
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 14:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E1C205E04;
	Mon,  2 Dec 2024 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isgVWt3g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32770205AD6
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Dec 2024 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150083; cv=none; b=oZ3ev8FiKhEPjXl4CtDilYl/ab+Nk5esTAByirB10oN04Js24yCrG6xm7lJ4qqE2YtiLvaQ4SLrrNlF9rhV29rf6NoeFTvZs+jf0POrxAmxxMmunTPileT8awrJo3ZpAmkPlK0jPbx8y6nC1rOR5K/2WxkLL/Xf/F8p4rxkPvfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150083; c=relaxed/simple;
	bh=ZCIoFmADqXF65mEMJ0Q/FyEnL3BZUqVhFb5UZDw6lFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aNKQBxXYVlWvWk2yH0OLBEhjAn9d2kokcGqXx8L5Q0MjacRJf9Kp7q20J5bnqU2h+jFx8GnvFYgCqD3gbXnQ46o0zQ/Hn76TNrjfKl+f9R0NY2PoBsY/3Et3qMaGQFEjAPId8SrLQwnDSXKWVoz9h5bdfL8wnhYUdC6qJpmmkvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isgVWt3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDA6C4CED1
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Dec 2024 14:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733150081;
	bh=ZCIoFmADqXF65mEMJ0Q/FyEnL3BZUqVhFb5UZDw6lFU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=isgVWt3gQlZYD6NimNcvIvAQ+j6McpxG2LhMh+wKySxTA8kFw5cREcXy2TQY7hWJ0
	 fI+SAgrgv0RzzRFBr50kel40q4QkwiK+n5UpYnH7xRk2Nge/qaUHuHhZZKyf+RiIUa
	 ZjtmlOxzNWEKJusUMbAe1dY7wxz5WRDvhhTlv14QUtpfGQAXAlWaNBl3cyZBYK6aU9
	 jUhrdUMIkUlQwJVCEBucuL00rGiTYaFyBdyR863nmzo8RjFJrqwc5OfSBAvFNxC4Af
	 UTgLj2+nA2hm0ZDBxrA1xVrOVqD3mIgdMulPSv0FK5PFoEVtNZfCbuLsPASA9XMKNX
	 7R+I5vl7UWjCA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d0c7c8cd6cso3886676a12.0
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Dec 2024 06:34:41 -0800 (PST)
X-Gm-Message-State: AOJu0YwXWteBxQKUGviSADXvDnHUz200oCyjXBvTEbW9geHPNHV3ws9P
	atKQZ5s+BsokjMCh+SJNzvOitb+llIyHydkxh9MZhg2TQMDuxT0lc8n+f3B8jhGnT6RxTFCaUKr
	JbHznDyN3cp055vgd6anExYIcpq0=
X-Google-Smtp-Source: AGHT+IHVxx0I6K8nR9SASmz9MCUcyu+sVYLVdQ4ZPRoT27+gKAgvyIa9EpHZthEoO7aC3vVNnrN9pLOqpjzy49/7pDw=
X-Received: by 2002:a17:906:1da9:b0:aa5:3853:553b with SMTP id
 a640c23a62f3a-aa5945fb07bmr1854500366b.20.1733150080212; Mon, 02 Dec 2024
 06:34:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7fae80d0a144312c09e4e40ff3491b6ce77ee4f5.1732952536.git.wqu@suse.com>
In-Reply-To: <7fae80d0a144312c09e4e40ff3491b6ce77ee4f5.1732952536.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 2 Dec 2024 14:34:03 +0000
X-Gmail-Original-Message-ID: <CAL3q7H65joDrgUKMYhKnghjHUA1b3Woo8Uq-aKgp5DmnUAmMVA@mail.gmail.com>
Message-ID: <CAL3q7H65joDrgUKMYhKnghjHUA1b3Woo8Uq-aKgp5DmnUAmMVA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: properly wait for writeback before buffered write
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, 
	syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2024 at 7:43=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> Syzbot reported a crash where btrfs is call folio_start_writeback()
> while the folio is already marked writeback:
>
> ------------[ cut here ]------------
> kernel BUG at mm/page-writeback.c:3119!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:1 Not tainted 6.12.0-syzkaller-084=
46-g228a1157fb9f #0
> Workqueue: btrfs-delalloc btrfs_work_helper
> RIP: 0010:__folio_start_writeback+0xc06/0x1050 mm/page-writeback.c:3119
>  <TASK>
>  process_one_folio fs/btrfs/extent_io.c:187 [inline]
>  __process_folios_contig+0x31c/0x540 fs/btrfs/extent_io.c:216
>  submit_one_async_extent fs/btrfs/inode.c:1229 [inline]
>  submit_compressed_extents+0xdb3/0x16e0 fs/btrfs/inode.c:1632
>  run_ordered_work fs/btrfs/async-thread.c:245 [inline]
>  btrfs_work_helper+0x56b/0xc50 fs/btrfs/async-thread.c:324
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> ---[ end trace 0000000000000000 ]---
>
> Furthermore syzbot bisected the cause to commit c87c299776e4
> ("btrfs: make buffered write to copy one page a time").
>
> [CAUSE]
> Unfortunately I'm not able to reproduce the bug with my usual debug
> kernel config.
> But thanks to the bisection result, I can take a deeper look into the
> offending commit.
>
> One of the change is to use FGP_STABLE to wait for folio writeback.

change -> changes

But I'm a bit confused.
The commit that adds the use of GFP_STABLE is e820dbeb6ad1 ("btrfs:
convert btrfs_buffered_write() to use folios"), but indirectly through
the use of FGP_WRITEBEGIN.

But you (and syzbot), say the offending commit is c87c299776e4
("btrfs: make buffered write to copy one page a time").

> But unfortunately FGP_STABLE is not ensured to wait for writeback, it
> only calls folio_wait_stable(), which only calls folio_wait_writeback()
> if the address space has AS_STABLE_WRITES.
>
> Normally that flag is only set if the super block has
> SB_I_STABLE_WRITES, and that is normally set if the that block device
> has integrity checks or requires stable writes feature (normally has
> some kind of digest to check).
>
> Although I'd argue btrfs should set such flag due to its data checksum,

What about nocow writes?

The change looks good and sane, just confused about that part in the change=
log.

Thanks.

> for now we do not have that flag, meaning FGP_STABLE will not wait for
> any folio writeback to finish.
>
> This is going to cause races between buffered write and folio writeback,
> leading to various data corruption/checksum mismatch.
>
> [FIX]
> Instead of fully rely on FGP_STABLE, manually do the folio writeback
> wait, until we set the btrfs super block with SB_I_STABLE_WRITES
> manually.
>
> Reported-by: syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com
> Fixes: c87c299776e4 ("btrfs: make buffered write to copy one page a time"=
)
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/file.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index fbb753300071..8734f5fc681f 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -911,6 +911,7 @@ static noinline int prepare_one_folio(struct inode *i=
node, struct folio **folio_
>                         ret =3D PTR_ERR(folio);
>                 return ret;
>         }
> +       folio_wait_writeback(folio);
>         /* Only support page sized folio yet. */
>         ASSERT(folio_order(folio) =3D=3D 0);
>         ret =3D set_folio_extent_mapped(folio);
> --
> 2.47.1
>
>

