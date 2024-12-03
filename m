Return-Path: <linux-btrfs+bounces-10031-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8430C9E1A13
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 11:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DCC1669BF
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 10:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1B91E3768;
	Tue,  3 Dec 2024 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulESmCAj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BC71E32D8
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Dec 2024 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223438; cv=none; b=Ky1A24F5buSw8sHUOZ0FBj0sFHVTcCEGoNllxti+CmYPGaVg0WJpDFeS977esuV9q3eN86O1fGuncl66nhk6eivEYJrFoQr1T7YoWJlpwVEcH4Ps7DO9lA3bW+4jro2jrrFx3fpPGyG36baCetCLwvZuVdTzcsDNfpCCydI423Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223438; c=relaxed/simple;
	bh=JQbvgshFsr6ud+nc+ET8xUHNuqQk/KCWCxEPb758Sjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhrVxBovRDrYecU3WD0P8BS9H54IzNmtz9SbU9yKdBm9oy36Wg3hMn5bfGqP+3/+i5AWlXt+Q0i8uHlWMh6/nbQ7k5nWj3a2ZT7Z9zSiJSCvlYbrgAcnLMmb4qYXtGuvZGNENR0njsxFoXfYv9GGJ/iEP9nvF4aFigrB7nx2VL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulESmCAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C81BC4CED9
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Dec 2024 10:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733223436;
	bh=JQbvgshFsr6ud+nc+ET8xUHNuqQk/KCWCxEPb758Sjs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ulESmCAjhQ53POeLxwMUJQxYwvasf7X2J0LH5n5Cncm+I8QaUP05d7AWy9gOXJQ94
	 4j7iIVoXgVsEYQGcY3PynsIefNndB7Rz2bPIj0j+mUpBc5UEqzl/ZVS7vcE9HZ3nyL
	 lPYimBxEBWmRhNqj+vZ3vdBERxyl6ujtN4xriTA5z6wCU51GI0z4B8eiTuz0mB3+Ai
	 PLS/MI/uN1kHYWDSMmdfOxJadyC/PXchFtxe1sFHc4aMAE1A4ksfSt8jC8DMRX9vv5
	 id2gPAmjpaefsus3tDZOn1U7bXqhpB/0tL31uJ9f4uk+DgNeXVO+ULwZ/OLJ4fDLCZ
	 WyUGM9GFr4PDQ==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9e8522445dso762577666b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Dec 2024 02:57:16 -0800 (PST)
X-Gm-Message-State: AOJu0YwRp3wlQQpTP4iGCgOGj6AIaVGaY/JvZarDDuznVHFYzHvkLyhq
	gaMo1StabzxAiAqIQQtzWgoMF3EjB4oJWxdDlJh82+gVEuyXlk/FJU1nOVsCpGRmo0xsYhBjLxE
	qeuJk183EPGiwRX/TFopKSXtWo7E=
X-Google-Smtp-Source: AGHT+IG0E5f2Q/GWAeleW7g/IRP41zC5LXwg8G2KvFO6TO+UGs8yWDaogf4+Enq3kjO3fnsP51SExHG/+KQ/2agCIjs=
X-Received: by 2002:a17:906:23e9:b0:a9e:c881:80bd with SMTP id
 a640c23a62f3a-aa5f7ecd26cmr117029466b.37.1733223435159; Tue, 03 Dec 2024
 02:57:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3fa83d6d472d78beb5fd519d0290b73d02d53d15.1733176045.git.wqu@suse.com>
In-Reply-To: <3fa83d6d472d78beb5fd519d0290b73d02d53d15.1733176045.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 3 Dec 2024 10:56:38 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6M9QW-Bx7ohYtsesQwk811Fd6H_QqQXq20hyjEJduYOw@mail.gmail.com>
Message-ID: <CAL3q7H6M9QW-Bx7ohYtsesQwk811Fd6H_QqQXq20hyjEJduYOw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: properly wait for writeback before buffered write
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 9:48=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> Before commit e820dbeb6ad1 ("btrfs: convert btrfs_buffered_write() to
> use folios"), function prepare_one_folio() will always wait for folio
> writeback to finish before returning the folio.
>
> However commit e820dbeb6ad1 ("btrfs: convert btrfs_buffered_write() to
> use folios") changed to use FGP_STABLE to do the writeback wait, but
> FGP_STABLE is calling folio_wait_stable(), which only calls
> folio_wait_writeback() if the address space has AS_STABLE_WRITES, which
> is not set for btrfs inodes.
>
> This means we will not wait for folio writeback at all.
>
> [CAUSE]
> The cause is FGP_STABLE is not wait for writeback unconditionally, but
> only for address spaces with AS_STABLE_WRITES, normally such flag is set
> when the super block has SB_I_STABLE_WRITES flag.
>
> Such super block flag is set when the block device has hardware digest
> support or has internal checksum requirement.
>
> I'd argue btrfs should set such super block due to its default data
> checksum behavior, but it is not set yet, so this means FGP_STABLE flag
> will have no effect at all.
>
> (For NODATACSUM inodes, we can skip the wait in theory but that should
> be an optimization in the future)
>
> This can lead to data checksum mismatch, as we can modify the folio
> meanwhile it's still under writeback, this will make the contents
> differ from the contents at submission and checksum calculation.
>
> [FIX]
> Instead of fully rely on FGP_STABLE, manually do the folio writeback
> wait, until we set the address space or super flag.
>
> Fixes: e820dbeb6ad1 ("btrfs: convert btrfs_buffered_write() to use folios=
")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks for the update of the changelog.

> ---
> v2:
> - Update the commit message and fixes by tag
>   I was too focused on the syzbot report, not noticing it's a different
>   commit causing the regression.
>   Now removed the syzbot report part.
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

