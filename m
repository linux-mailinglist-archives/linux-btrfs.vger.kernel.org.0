Return-Path: <linux-btrfs+bounces-15754-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A49B16351
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 17:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76BAD1AA3C67
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 15:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAB12DC323;
	Wed, 30 Jul 2025 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ia50tixh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32BF2DAFB4;
	Wed, 30 Jul 2025 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888004; cv=none; b=OymzleAhRJ+WGCHwgY4YsXe6mpazc0eDZQWIlNjxOcipfJ7oZTSQBDIzmrEWggrp+R+ULzGA2n1AvLZTl/9i9YBIr3Yo7wE2LXRmo9L5t132h+sau1lMUee7HH2XaCu/QaSplWXr9osVLB8PS5BeSHBECKmk0k1yklP/Rp4vQBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888004; c=relaxed/simple;
	bh=rUHhE4B5r/+RbL+7IXoPCmIBs8x7CEFdCaNUq5QQbqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHFFlBoHOHh8Mz2k5OZqofXh6bSGT7wFMCUWAHpxcF08yqHSLQeuY1BkkseyCe0Vb7fvUOU/WGZ7PWhKUEMj25fy35md4NHMnavk7xiafwYm4+i81bLQFqa6dbMTxtgQqTnunsjoMsch5LFC4O/LuNNMdS7DnSXSOwyR43NQue0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ia50tixh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2C9C4CEE3;
	Wed, 30 Jul 2025 15:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753888004;
	bh=rUHhE4B5r/+RbL+7IXoPCmIBs8x7CEFdCaNUq5QQbqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ia50tixhRQj9c+BUGwY3KMkL23tco6ri6u93cdyYQsaPRkqjAukDXSrzJTlNS6JxM
	 ZKA1/sHTjfflwd06aJKEUqvFGyMRWtW0axnCEVagIPeWP8B4qnXbeZcn2mVdBjC6gn
	 lpaXTHR+KZFjS/5Bdd4UwGifYPckc2dxrcp/f5ftviwhcSU6Fzjz51NV1Q6IHhNY4U
	 Y2Gg8O+T8xGpxhUgyRo/g3H6Z5n4WFx/EJ7CbgyKjYmqzlBoJiOH/FUhmPTe2dDS79
	 vHaI27yc1hyZb2F/z1JxGHQCX5jIUl5Tnzb57qrqiTQEKU1tvruoevK3R8hUJesu73
	 /JbSfEL+Un4qA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aec5a714ae9so999906066b.3;
        Wed, 30 Jul 2025 08:06:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWc7mSi79+f+pCovv1BP/F0X+hvNz+drF+NvJdToIDkA+mwYpFoLQ0iOWTu1oWdWw1YtNuRYlKmRnIJtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBITaPGZHksOi8JYCPfUUQczzYysrwlCsqO4ciGBaFWOMvRTll
	9gsukEgV6k5VmPAkBy9eFzm7DCFdKsIM5+JGPhzWJ1DSCeQUiFTgdqCNGbFp2NlMMZ6zg6vMKwO
	ALe/22FmgUHnbADPfkOvxE8myJtS6Nrk=
X-Google-Smtp-Source: AGHT+IEn8XpVN7XoGU2N0dK72A8zMzzypO5tzrllComIF5dFbqu8o4P+IXWVuyuN3i2Ofkcjc/nGBy56St4/AEfL/3Y=
X-Received: by 2002:a17:907:a909:b0:af3:af53:948c with SMTP id
 a640c23a62f3a-af8fd9760f0mr462262366b.29.1753888003207; Wed, 30 Jul 2025
 08:06:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753769382.git.nirjhar.roy.lists@gmail.com> <f48538de3ce4a98a2128f48aa0f005f51eb552ee.1753769382.git.nirjhar.roy.lists@gmail.com>
In-Reply-To: <f48538de3ce4a98a2128f48aa0f005f51eb552ee.1753769382.git.nirjhar.roy.lists@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 30 Jul 2025 16:06:05 +0100
X-Gmail-Original-Message-ID: <CAL3q7H65RB6+91qxJsNfsUKeig0hqNEUTSx9ZuquFnri5RSh2Q@mail.gmail.com>
X-Gm-Features: Ac12FXxLlFRHiROZ321AhaO2LpQkYU1qpPWobpgEzcqTKSZRolvEXemf96LEi1Q
Message-ID: <CAL3q7H65RB6+91qxJsNfsUKeig0hqNEUTSx9ZuquFnri5RSh2Q@mail.gmail.com>
Subject: Re: [PATCH 5/7] generic/563: Increase the write tolerance to 6% for
 larger nodesize
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org, 
	zlang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 7:24=E2=80=AFAM Nirjhar Roy (IBM)
<nirjhar.roy.lists@gmail.com> wrote:
>
> When tested with blocksize/nodesize 64K on powerpc
> with 64k  pagesize on btrfs, then the test fails
> with the folllowing error:
>      QA output created by 563
>      read/write
>      read is in range
>     -write is in range
>     +write has value of 8855552
>     +write is NOT in range 7969177.6 .. 8808038.4
>      write -> read/write
>     ...
> The slight increase in the amount of bytes that
> are written is because of the increase in the
> the nodesize(metadata) and hence it exceeds the tolerance limit slightly.
> Fix this by increasing the write tolerance limit from 5% from 6%
> for 64k blocksize btrfs.
>
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  tests/generic/563 | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/tests/generic/563 b/tests/generic/563
> index 89a71aa4..efcac1ec 100755
> --- a/tests/generic/563
> +++ b/tests/generic/563
> @@ -119,7 +119,22 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite -b $blk=
size 0 $iosize" -c fsync \
>         $SCRATCH_MNT/file >> $seqres.full 2>&1
>  switch_cg $cgdir
>  $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> -check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
> +blksz=3D`_get_block_size $SCRATCH_MNT`

Here the block size is captured, but then it's not used anywhere in the tes=
t...

Thanks.

> +
> +# On higher node sizes on btrfs, we observed slightly more
> +# writes, due to increased metadata sizes.
> +# Hence have a higher write tolerance for btrfs and when
> +# node size is greater than 4k.
> +if [[ "$FSTYP" =3D=3D "btrfs" ]]; then
> +       nodesz=3D$(_get_btrfs_node_size "$SCRATCH_DEV")
> +       if [[ "$nodesz" -gt 4096 ]]; then
> +               check_cg $cgdir/$seq-cg $iosize $iosize 5% 6%
> +       else
> +               check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
> +       fi
> +else
> +       check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
> +fi
>
>  # Write from one cgroup then read and write from a second. Writes are ch=
arged to
>  # the first group and nothing to the second.
> --
> 2.34.1
>

