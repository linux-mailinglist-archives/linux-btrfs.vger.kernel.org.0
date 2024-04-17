Return-Path: <linux-btrfs+bounces-4353-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D67598A84FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 15:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28B21C20834
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 13:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942A41411D0;
	Wed, 17 Apr 2024 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFegkUE5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96BC13F42D
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361131; cv=none; b=bEODEKaGZ4aUoNHsMmPLJhveDSfxNdvQ9+htc9GtqD8KaNzGouL6HnOvHzihivcC/+09XyoQilOv+NbfwhS4zPBtFFY+DnflpfayF9FpL++V8OGQ6yG9QFD5A5WOqNXQr81egxSqFCg/prje9Tpl9MS9DKQMwZHJ4bTdxnlNOCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361131; c=relaxed/simple;
	bh=L0GXBDzowC3z4rhFB030m4mwICy/q1ZZ5xavWMp42HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xo8EVpngdlDYdzx94YB3QyAdOQtMCwuNXF/u681YduF8z1tr2JEo10m0iugeGqTghMSYaczYiIj3taeQ1ruT7E0FPsx5WR61EdVjcBcPc0Sakt+quA7ZZ8Xj9h3a91BgVNRiHetaNjVe1jHynNA/CZstim+mGfW6gAGSx3pGFjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFegkUE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A358C3277B
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 13:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713361131;
	bh=L0GXBDzowC3z4rhFB030m4mwICy/q1ZZ5xavWMp42HI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KFegkUE5BirOFVF6tXvh86qVrG9UrDr5pt/r6qWx4k4cXjq1tuCU7O1iIsOuw0Pe7
	 OBFVTc4370q2qeud2cD2DZQ0rvJ4+Efdv2YiLcjj0h5yetS1pdUntQNjqL3d0tLkqm
	 JbIXmnLlfA5oY9pDjXFnhSXRH5gD1Ux0VOqALI2a/veS7xwZNFu2dwgx5oRBsSpKXp
	 RhBwW1DpqoJ68XVlbvTwspWeA1RMJHd5r1OOHx+XJr7/fP4hHCejWfenb3DHg95qIe
	 2A0bWGxyPwvqRY0lkLIGd/pwtZ+ulw4KRpAIqgtDw1j+kqBwZcAl9wlgkHUrvXDLx6
	 XaCx8qL4PQ4uQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e1f3462caso7354540a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 06:38:51 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx6OKASH68VxkPPdJp64yj63MINNKdhEcok1SpB23WVAEuHTMcg
	CVBR27rPAduizYsIertnrsorVZjiHnPR4/wV5XshPzlDAUOm4Ha7mBcESrTK8PlAMd1WcmnHsgD
	W/tF0ab7lKbG0vqUCv6iJQrrbGro=
X-Google-Smtp-Source: AGHT+IHEmwzkOsLp3BpFSDEyjr5Kl2u8qPPsWnufgddDckFycNf3ECTsDhOjtlHoFM1dW3QrjiU080u6Wd8Y4pfLbnU=
X-Received: by 2002:a17:907:7d93:b0:a51:d1a7:ad6 with SMTP id
 oz19-20020a1709077d9300b00a51d1a70ad6mr15232596ejc.76.1713361129682; Wed, 17
 Apr 2024 06:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <93ee5e5a0e35342480860317b1c3d4f5680f7e54.1713344114.git.jth@kernel.org>
In-Reply-To: <93ee5e5a0e35342480860317b1c3d4f5680f7e54.1713344114.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 17 Apr 2024 14:38:12 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6LjU8UMvfv_BXUOPNK9hDpGbNcyxKeL61CJkbJ9LD0rg@mail.gmail.com>
Message-ID: <CAL3q7H6LjU8UMvfv_BXUOPNK9hDpGbNcyxKeL61CJkbJ9LD0rg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix information leak in btrfs_ioctl_logical_to_ino()
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, josef@toxicpanda.com, dsterba@suse.com, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
	syzbot+510a1abbb8116eeb341d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 9:59=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Syzbot reported the information leak for in btrfs_ioctl_logical_to_ino():
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
> Reported-by: syzbot+510a1abbb8116eeb341d@syzkaller.appspotmail.com
> Signed-off-by: Johannes Thumshirn <Johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/backref.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index c1e6a5bbeeaf..4b993c7104fe 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -2776,7 +2776,7 @@ struct btrfs_data_container *init_data_container(u3=
2 total_bytes)
>         size_t alloc_bytes;
>
>         alloc_bytes =3D max_t(size_t, total_bytes, sizeof(*data));
> -       data =3D kvmalloc(alloc_bytes, GFP_KERNEL);
> +       data =3D kvzalloc(alloc_bytes, GFP_KERNEL);

After this we can remove the initialization of several fields to 0
(down below, not seen in the diff), since they become redundant and
make the code shorter.

Thanks.

>         if (!data)
>                 return ERR_PTR(-ENOMEM);
>
> --
> 2.35.3
>
>

