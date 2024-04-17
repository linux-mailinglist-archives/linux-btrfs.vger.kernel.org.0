Return-Path: <linux-btrfs+bounces-4355-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A108A8543
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 15:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D901C20E7D
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 13:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB881411CC;
	Wed, 17 Apr 2024 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKMPMYk7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5538014037F
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361827; cv=none; b=i4NNxxUYO4mYA+7I7onE6/t1E7TixXDZ3pKfd20Rtq11pgi3sdJK9f88JGUMesrg1GvuEOZy9bzD47kMjpHUdG63vC9O2+xKiwsS5TQ0LengpUxrANVqLGC72vTiIzYvLtltMDR0OuUAMVSOBTGzOLrLTLEeRRX52Vpb597kwRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361827; c=relaxed/simple;
	bh=QmTkmSfh0EkJn+tOflbgxyTMgjeaRGf/46LlxrHg/Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulOwYDygcuCdfGydI7DuLCLLK2OT87zTUNRRvKIpFNngzEMzlIU0BlVxm+FsiJq3M25GCRLsVexFPgkqwgPs7yf9FOTjKf5VC3PAXQnWU1isJyXy4HZqKTZ/hmY1biWFXv3BvWa0e8MZRczlWs3Vh9Vfoxx4WzJI3kY/AuFBJY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKMPMYk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA531C3277B
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 13:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713361826;
	bh=QmTkmSfh0EkJn+tOflbgxyTMgjeaRGf/46LlxrHg/Go=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UKMPMYk7Sh5S/ZSUgPnb9/IAthTva84UQscz8MZAcsDvyID4h0IKW/qB2vQlWlL/K
	 7uBsbCAuW4y0/ri/evjgVsaiCQGD3uvktcSXw8auLEu8xtnkspTasAymw3t8916ysH
	 XZWcLN4JRg5xkppZMhHA5mN2e7tSxhQ/8YTuuglyYqMKF2qYCPiPyqMSi2p57903MO
	 Ce/GWup74axB3Ox6xVUscmhPUJDokKL49o3krJT3jhtepnjeoY4aZvfjr2DD4o41W4
	 O6dLcC+cxPw+SEHMWuEW1rApvbx2sXBdJH23RFvgzUpiXovY8TCMD4APHOvx1TTMXZ
	 8bVYSz7zXnGYQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so8705169a12.2
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 06:50:26 -0700 (PDT)
X-Gm-Message-State: AOJu0YzLmH9TrQMiQpGwTLtgPYh5E/mUj2zPjnwuKqlOQpFwVY3FtdS9
	w50GiFNxQndzmyfG1m0g4kIRdWwu5HC2m/Ta+klALSz28QUoa6+ZAwNm96aNsN7tEoy1+SmQHE3
	xCIT0DjewJd2kZk4iX8Y6hbw8sH4=
X-Google-Smtp-Source: AGHT+IFy2MOPmKcf+lviHe5zg4RVaYT8H5Cc0zbqag/MnfYQC55I93PQ1xOryPvFPLG9UFVfDd9a6Jr0rt/zRUB8k7I=
X-Received: by 2002:a17:907:2d07:b0:a55:621d:d961 with SMTP id
 gs7-20020a1709072d0700b00a55621dd961mr1117440ejc.0.1713361825429; Wed, 17 Apr
 2024 06:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7eb2d171cdb1a2a89288a989dc0ef28c21bebc59.1713361686.git.jth@kernel.org>
In-Reply-To: <7eb2d171cdb1a2a89288a989dc0ef28c21bebc59.1713361686.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 17 Apr 2024 14:49:48 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7J4uf85P7VNn=Bi8FwwiyVcArvsWNKn85aSGeekBAsrA@mail.gmail.com>
Message-ID: <CAL3q7H7J4uf85P7VNn=Bi8FwwiyVcArvsWNKn85aSGeekBAsrA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix information leak in btrfs_ioctl_logical_to_ino()
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
	syzbot+510a1abbb8116eeb341d@syzkaller.appspotmail.com, 
	Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 2:49=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Syzbot reported the following information leak for in
> btrfs_ioctl_logical_to_ino():
>
> BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/inst=
rumented.h:114 [inline]
> BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x110 lib/usercopy.c:40
>  instrument_copy_to_user include/linux/instrumented.h:114 [inline]
>  _copy_to_user+0xbc/0x110 lib/usercopy.c:40
>  copy_to_user include/linux/uaccess.h:191 [inline]
>  btrfs_ioctl_logical_to_ino+0x440/0x750 fs/btrfs/ioctl.c:3499
>  btrfs_ioctl+0x714/0x1260
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:904 [inline]
>  __se_sys_ioctl+0x261/0x450 fs/ioctl.c:890
>  __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:890
>  x64_sys_call+0x1883/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:=
17
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was created at:
>  __kmalloc_large_node+0x231/0x370 mm/slub.c:3921
>  __do_kmalloc_node mm/slub.c:3954 [inline]
>  __kmalloc_node+0xb07/0x1060 mm/slub.c:3973
>  kmalloc_node include/linux/slab.h:648 [inline]
>  kvmalloc_node+0xc0/0x2d0 mm/util.c:634
>  kvmalloc include/linux/slab.h:766 [inline]
>  init_data_container+0x49/0x1e0 fs/btrfs/backref.c:2779
>  btrfs_ioctl_logical_to_ino+0x17c/0x750 fs/btrfs/ioctl.c:3480
>  btrfs_ioctl+0x714/0x1260
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:904 [inline]
>  __se_sys_ioctl+0x261/0x450 fs/ioctl.c:890
>  __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:890
>  x64_sys_call+0x1883/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:=
17
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Bytes 40-65535 of 65536 are uninitialized
> Memory access of size 65536 starts at ffff888045a40000
>
> This happens, because we're copying a 'struct btrfs_data_container' back
> to user-space. This btrfs_data_container is allocated in
> 'init_data_container()' via kvmalloc(), which does not zero-fill the
> memory.
>
> Fix this by using kvzalloc() which zeroes out the memory on allocation.
>
> Reported-by:  <syzbot+510a1abbb8116eeb341d@syzkaller.appspotmail.com>
> Signed-off-by: Johannes Thumshirn <Johannes.thumshirn@wdc.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/backref.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 0bc81b340295..a2de5c05f97c 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -2770,20 +2770,14 @@ struct btrfs_data_container *init_data_container(=
u32 total_bytes)
>         size_t alloc_bytes;
>
>         alloc_bytes =3D max_t(size_t, total_bytes, sizeof(*data));
> -       data =3D kvmalloc(alloc_bytes, GFP_KERNEL);
> +       data =3D kvzalloc(alloc_bytes, GFP_KERNEL);
>         if (!data)
>                 return ERR_PTR(-ENOMEM);
>
> -       if (total_bytes >=3D sizeof(*data)) {
> +       if (total_bytes >=3D sizeof(*data))
>                 data->bytes_left =3D total_bytes - sizeof(*data);
> -               data->bytes_missing =3D 0;
> -       } else {
> +       else
>                 data->bytes_missing =3D sizeof(*data) - total_bytes;
> -               data->bytes_left =3D 0;
> -       }
> -
> -       data->elem_cnt =3D 0;
> -       data->elem_missed =3D 0;
>
>         return data;
>  }
> --
> 2.35.3
>

