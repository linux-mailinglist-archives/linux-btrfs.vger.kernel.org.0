Return-Path: <linux-btrfs+bounces-14993-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2C9AE9DB0
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 14:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6658A6A06F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 12:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B622E175E;
	Thu, 26 Jun 2025 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fl1q7bUB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9341A2E11BF;
	Thu, 26 Jun 2025 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750941501; cv=none; b=U4SpjucgO+Diko+LoJg3cKB29LsxpnPxyAoPUWQm7MtWehvEDb5QYzFGcUkjw0cHTHI3nXEhgQXAPdTWTBQmiA5OXl6lgZkRNsQlnzt82b8Uq7JqYAfacFqYGO4kkZQtgR26jrUfiA9TZJkNQL1Qsq3XjJOqAgn5cwMgUzsOIgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750941501; c=relaxed/simple;
	bh=qoJ/V6g3ybIgWJt3ixMc3C4/7uLcMcISIquwhMdpbzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qE3TnGjlNEqifK4iS4piRgOtIfEgDheqCItUYUQY3nT5UrviBhwaumD4lX7fx9REiehnsuqNu1ljA8Rth8RPGfiuXeWwzBKKyYOhmpd5qg/UCnayQ1Yt+nM50FEXBekOaBOklpJbu9iZEGlM2uBhu+MPm49j+txbmqZHbS/SWyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fl1q7bUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170C1C4CEF2;
	Thu, 26 Jun 2025 12:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750941501;
	bh=qoJ/V6g3ybIgWJt3ixMc3C4/7uLcMcISIquwhMdpbzY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Fl1q7bUBaFS6s0LdTuAPDfOVnNJjCjxMfnS10DMFAIv7q2ZJrlyNcznkGVnfjiTnS
	 WG3eD+z9NN2O+Kjayk+ruFD+JHeagw/otcRyUoSN3K7+nO6wI5CfQ7qAaK9YgxWWAF
	 FnIW2Jd1do8+lbon5lSPPOJCtT3ms9NqzkDPQs1G/nl2XNGdWNGO4vG6zumDnPCA7+
	 djBfo9hAAw1nr8tJ1uCT2b+irhxQNLECETsmQD3ZeCz7wUA3WHPgr6L7uqAi07eHV6
	 S4hXnnEFzvc5pl1tUFEeX1Fab5NdptTUboHeA26J35Fq91FfmzR/4zhaX0VuwTCndt
	 C2j2YDp2e+Jtw==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0d11bb2a7so129621566b.3;
        Thu, 26 Jun 2025 05:38:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4VZtBhaOSKtxOn4lcTEJsKvUr2SNM3bk0WKh99egpmvRg5M4lk0AOCmSkLGCO78w8GBuIIBRuVa/BIg==@vger.kernel.org, AJvYcCV0Lvw3knZB5S+5CvsjxzrNPKdf1T852VQNElXXbktJyQf4JCdHxsqAzpNcKzJpKN6GfkdOBx+EshCgmpoF@vger.kernel.org
X-Gm-Message-State: AOJu0YwexRRe8KYKEzbBgG8b71OtaVJUxOGru316OHbeTydUIZhOKiNa
	7MvH+o9N+jP0jMddWYr82dzzRozjaEs1wLTfKnjYFdd4vtdTMHwijbIrhdiy4nLDvKRvMu3xipd
	SPrCNcKXmkru6qe7MyB/W5R1lbL5hciA=
X-Google-Smtp-Source: AGHT+IGSo8di1mTgjiNFKcKBHT1kPgfvvEt28qnDnKWMQCww4lIuxf/VLshubGWazh1o7b/Dkq2MufvWrSTO2REYXR0=
X-Received: by 2002:a17:907:7e82:b0:ad8:9b5d:2c16 with SMTP id
 a640c23a62f3a-ae0bebe9319mr695342766b.11.1750941499578; Thu, 26 Jun 2025
 05:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626030806.665809-1-zhenghaoran154@gmail.com>
In-Reply-To: <20250626030806.665809-1-zhenghaoran154@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 26 Jun 2025 13:37:42 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6NVxiEHQfyMWbNQuszw74AyQqXo6_K9KzyKs=VRvK0yA@mail.gmail.com>
X-Gm-Features: Ac12FXxIVRZyqW6L4qPKIvkq4abNhSkmhlJ9uQjSStR8wU8cQblKBWbzuSXPjic
Message-ID: <CAL3q7H6NVxiEHQfyMWbNQuszw74AyQqXo6_K9KzyKs=VRvK0yA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Two data races in btrfs
To: Hao-ran Zheng <zhenghaoran154@gmail.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, zzzccc427@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 4:08=E2=80=AFAM Hao-ran Zheng <zhenghaoran154@gmail=
.com> wrote:
>
> Hello maintainers,
>
> I would like to report two data race bugs we discovered in BTRFS
> filesystem on Linux kernel v6.16-rc3. These issues were identified
> using our data race detector.

This sort of text is not proper for a patch... Saying hello and saying
that you are reporting is totally irrelevant and odd.

And what do you mean by "our data race detector"? Is it something else
other than KCSAN, something not in the linux kernel tree?

>
> These issues were deemed non-critical after evaluation, as they
> do not impact core functionality or security. To minimize
> performance overhead while ensuring clarity for future maintenance,
> I have annotated them with data_race() macros.

You have to explain things in far more detail.
To me it seems you are sprinkling data_race() randomly just because
it's fine in some other places.
You don't explain why "these issues were deemed non-critical after evaluati=
on".

>
> Below is a summary of the findings:
>
> ---
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D DATARACE =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>  extent_write_cache_pages fs/btrfs/extent_io.c:2439 [inline]
>  btrfs_writepages+0x34fc/0x3d20 fs/btrfs/extent_io.c:2376
>  do_writepages+0x302/0x7c0 mm/page-writeback.c:2687
>  filemap_fdatawrite_wbc mm/filemap.c:389 [inline]
>   __filemap_fdatawrite_range mm/filemap.c:422 [inline]
>  filemap_fdatawrite_range+0x145/0x1d0 mm/filemap.c:440
>  btrfs_fdatawrite_range fs/btrfs/file.c:3701 [inline]
>  start_ordered_ops fs/btrfs/file.c:1439 [inline]
>  btrfs_sync_file+0x6e7/0x1d70 fs/btrfs/file.c:1550
>  generic_write_sync include/linux/fs.h:2970 [inline]
>  btrfs_do_write_iter+0xd0c/0x12f0 fs/btrfs/file.c:1391
>  btrfs_file_write_iter+0x3d/0x60 fs/btrfs/file.c:1401
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0x940/0xd10 fs/read_write.c:679
>  ksys_write+0x116/0x200 fs/read_write.c:731
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1a0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  0x0
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DOTHER_INFO=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>  extent_write_cache_pages fs/btrfs/extent_io.c:2439 [inline]
>  btrfs_writepages+0x34fc/0x3d20 fs/btrfs/extent_io.c:2376
>  do_writepages+0x302/0x7c0 mm/page-writeback.c:2687
>  filemap_fdatawrite_wbc mm/filemap.c:389 [inline]
>  __filemap_fdatawrite_range mm/filemap.c:422 [inline]
>  filemap_fdatawrite_range+0x145/0x1d0 mm/filemap.c:440
>  btrfs_fdatawrite_range fs/btrfs/file.c:3701 [inline]
>  start_ordered_ops fs/btrfs/file.c:1439 [inline]
>  btrfs_sync_file+0x509/0x1d70 fs/btrfs/file.c:1521
>  generic_write_sync include/linux/fs.h:2970 [inline]
>  btrfs_do_write_iter+0xd0c/0x12f0 fs/btrfs/file.c:1391
>  btrfs_file_write_iter+0x3d/0x60 fs/btrfs/file.c:1401
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0x940/0xd10 fs/read_write.c:679
>  ksys_write+0x116/0x200 fs/read_write.c:731
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1a0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DEND=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3DDATA_RACE=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>  btrfs_inode_safe_disk_i_size_write+0x144/0x190 fs/btrfs/file-item.c:65
>  btrfs_finish_one_ordered+0x999/0x1330 fs/btrfs/inode.c:3203
>  btrfs_finish_ordered_io+0x33/0x50 fs/btrfs/inode.c:3308
>  finish_ordered_fn+0x3a/0x50 fs/btrfs/ordered-data.c:331
>  btrfs_work_helper+0x199/0x6c0 fs/btrfs/async-thread.c:314
>  process_one_work kernel/workqueue.c:3238 [inline]
>  process_scheduled_works+0x21f/0x520 kernel/workqueue.c:3319
>  worker_thread+0x323/0x4a0 kernel/workqueue.c:3400
>  kthread+0x2d5/0x300 kernel/kthread.c:464
>  ret_from_fork+0x4d/0x60 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DOTHER_INFO=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>  fill_stack_inode_item fs/btrfs/delayed-inode.c:1809 [inline]
>  btrfs_delayed_update_inode+0x1ab/0xa40 fs/btrfs/delayed-inode.c:1931
>  btrfs_update_inode+0x128/0x270 fs/btrfs/inode.c:4156
>  btrfs_setxattr_trans+0x143/0x280 fs/btrfs/xattr.c:266
>  btrfs_xattr_handler_set+0xb7/0xf0 fs/btrfs/xattr.c:380
>  __vfs_setxattr+0x21e/0x240 fs/xattr.c:200
>  __vfs_setxattr_noperm+0xa5/0x2d0 fs/xattr.c:234
>  vfs_setxattr+0xd5/0x1d0 fs/xattr.c:321
>  do_setxattr fs/xattr.c:636 [inline]
>  file_setxattr+0xb0/0x110 fs/xattr.c:646
>  path_setxattrat+0x217/0x260 fs/xattr.c:711
>  __do_sys_fsetxattr fs/xattr.c:761 [inline]
>  __se_sys_fsetxattr fs/xattr.c:758 [inline]
>  __x64_sys_fsetxattr+0x2c/0x40 fs/xattr.c:758
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1a0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Signed-off-by: Hao-ran Zheng <zhenghaoran154@gmail.com>
> ---
>  fs/btrfs/extent_io.c | 2 +-
>  fs/btrfs/file-item.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 849199768664..0c03fafc3ae0 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2436,7 +2436,7 @@ static int extent_write_cache_pages(struct address_=
space *mapping,
>         }
>
>         if (wbc->range_cyclic || (wbc->nr_to_write > 0 && range_whole))
> -               mapping->writeback_index =3D done_index;
> +               data_race(mapping->writeback_index =3D done_index);
>
>         btrfs_add_delayed_iput(BTRFS_I(inode));
>         return ret;
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 54d523d4f421..15572e79b6de 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -61,7 +61,7 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_in=
ode *inode, u64 new_i_siz
>                 i_size =3D min(i_size, end + 1);
>         else
>                 i_size =3D 0;
> -       inode->disk_i_size =3D i_size;
> +       data_race(inode->disk_i_size =3D i_size);


These are two completely different cases, each should be in a
dedicated patch with a proper analysis.

At least this one for disk_i_size, I don't think data_race() is a good solu=
tion.
It doesn't prevent store and load tearing, which would result in an
inode item with a bogus size.

Please provide a rationale for the proposed solution for each case.
We have gone through this in a patch you sent in the past (commit
5324c4e10e9c2ce307a037e904c0d9671d7137d9), and there data_race() was
ok because getting a stale value or some weird value due to the result
of a load/store tearing would only makes us take unnecessary locks,
therefore not affecting correctness - it's this type of analysis that
you should place in a change log.

Thanks.

>  out_unlock:
>         spin_unlock(&inode->lock);
>  }
> --
> 2.34.1
>
>

