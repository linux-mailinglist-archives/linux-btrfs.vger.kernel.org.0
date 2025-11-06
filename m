Return-Path: <linux-btrfs+bounces-18776-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AABC3ACF8
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 13:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 719F4351456
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 12:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1E832C925;
	Thu,  6 Nov 2025 12:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvZ8fiz6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87B332ABFE
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430893; cv=none; b=rKEfc+5TbQwymcmAB2HT8km/BWKMXTPg/D7dqmrSxKfGZz8dSOE2AZrFe0qksx7aDvMrFLg1hs3HVw3hP64UO1eVwcqBxV8cb2p67wHs3ON7eUBDbCPgzfrQiH6750iMljgUXfNnyKJsD25W4VKyGmJUknBccxgI5MY5U6Ylz/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430893; c=relaxed/simple;
	bh=Aar7eFd3R700xfzZm3sCk5Sec9d7OyY/+yvISPN/D40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LDWbZa/3PZnch1dTn8QJ7QGTxFA6yD00/SvcimQj81X2C2m+lO0kcBuXx5mrPR/15VIQE48U+qC0JiAYMoKK15mKIrNI/56P9R1kToVkRz5g9w5ksRRfL0hQELLMKWtOG8B5HLwHpWfXFNHuKwpMkk+qX0iAJfwlend3efyXQTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvZ8fiz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00F8C2BC86
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 12:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762430893;
	bh=Aar7eFd3R700xfzZm3sCk5Sec9d7OyY/+yvISPN/D40=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QvZ8fiz6EwxNyKkgcohUdcCq8lY8S9cxDQpZL3biPCMLeHFfqV/oW+NR8hkW0lahM
	 VGf5+cfApPzgyCU2Z/DPhwD5TTLzgzHoj2BP2/Ly5ATWRzNFb/CCID1OFWP5e9cFK5
	 6EjKgAVSNaHnLXYo6c7Yzobp0SnxZRGOmP6SZ1xqDwdcEJAeWIyO+kN0ezYQ8CRrD4
	 QWSsGeOG7lBfjEwf7b1KYEqdmVkigXC1IqFeod6bhEbNKcekl89/JHRO1p1G1Csa1d
	 8MuoMFcon3mnKx6T8I9mw2MM6/IXBvctzFDGIyEv+kWj7xqfk3PlK/8tqQlVXtUGAB
	 nRTzxESuV0lZw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b64cdbb949cso162764566b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Nov 2025 04:08:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfnnEGZ2ov9C8IBsKsNd0GvJXPGYX9xfsvSNaW5EufBPeG48BB0FS3sYktDJqEUENZ9wRpQNgzw++jLA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp+G3OI/eLVjCTckT5Rz7OJwYbugMwmBljoTlw5IThJrH1dUxz
	8BnMD2q5N8wuXKXkXQSvEKH9+UAbLw3iMvGiNA5rlT4fWgWMJzXeUjvqLOhCbm5cfUuWRpdngk5
	ojsF6C87m9ALMRunn/cGfOHsO97bo7y8=
X-Google-Smtp-Source: AGHT+IHJBojcI4LThKdQabx1Jr9H+Z/R/nBtoVin6b935q8j85JCsvlSy8xz6HbvSVrDz/QcgRJD5LVb0K3HU6TvfuI=
X-Received: by 2002:a17:907:7248:b0:b6d:62e4:a63a with SMTP id
 a640c23a62f3a-b72654ddbd0mr831230966b.40.1762430892135; Thu, 06 Nov 2025
 04:08:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106115815.3635405-1-zilin@seu.edu.cn>
In-Reply-To: <20251106115815.3635405-1-zilin@seu.edu.cn>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 6 Nov 2025 12:07:35 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7rWHsWrkwywymXeoqt-Ah0V4Y4JtzdVzMCDxTY0-Tk0w@mail.gmail.com>
X-Gm-Features: AWmQ_blToCLvXdJ-dGoHOpIXo2Rc6qTDsv_gGL000JsR-r2kPI93Xwio88VamZU
Message-ID: <CAL3q7H7rWHsWrkwywymXeoqt-Ah0V4Y4JtzdVzMCDxTY0-Tk0w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: avoid redundant cleanup when device allocation fails
To: Zilin Guan <zilin@seu.edu.cn>
Cc: clm@fb.com, dsterba@suse.com, fdmanana@suse.com, neal@gompa.dev, 
	boris@bur.io, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jianhao.xu@seu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 12:03=E2=80=AFPM Zilin Guan <zilin@seu.edu.cn> wrote=
:
>
> When device allocation fails, the chunk map has not been added to the
> mapping tree, so locking for cleanup is unnecessary. Simply free the
> chunk map as done when adding it to the mapping tree fails.
>
> Fixes: bf2e2eb060fa2 ("btrfs: Add self-tests for btrfs_rmap_block")

Seriously? How is this a bug?

It's fine as it is, it may be not optimal due to extra locking and
such, but this is an error path which should be rare, plus it's in the
self tests that run only when the module is loaded (needs
CONFIG_BTRFS_FS_RUN_SANITY_TESTS=3Dy).

It's an unnecessary patch.


> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
>  fs/btrfs/tests/extent-map-tests.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-ma=
p-tests.c
> index 42af6c737c6e..e227cfff1e8d 100644
> --- a/fs/btrfs/tests/extent-map-tests.c
> +++ b/fs/btrfs/tests/extent-map-tests.c
> @@ -1036,7 +1036,8 @@ static int test_rmap_block(struct btrfs_fs_info *fs=
_info,
>                 if (IS_ERR(dev)) {
>                         test_err("cannot allocate device");
>                         ret =3D PTR_ERR(dev);
> -                       goto out;
> +                       btrfs_free_chunk_map(map);
> +                       goto out_free;
>                 }
>                 map->stripes[i].dev =3D dev;
>                 map->stripes[i].physical =3D test->data_stripe_phys_start=
[i];
> --
> 2.34.1
>
>

