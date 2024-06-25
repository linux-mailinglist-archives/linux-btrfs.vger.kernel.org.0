Return-Path: <linux-btrfs+bounces-5955-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE38916559
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 12:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 980BE2826E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 10:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DB414AD20;
	Tue, 25 Jun 2024 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSjnJNY2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B6114A632
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719311892; cv=none; b=I+ypb2jVy96+u933ypfqok7GcHfJyogN1ULcOlczQsQkIcUnSm4I49pZwW4K57LKNAGLrv1U0A95KlOzCRS16MmeJex3n09UO2yINLZT4MIn0zXtqB8IqTk90GZu1AuGE+n4QfyATns3Z4v1DsjUxRdsEguY6Fol/BZJ7xPJTHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719311892; c=relaxed/simple;
	bh=uapIYEvq/QUcIN/YV/9PlOKB0euEcTNxB9jlTjeCGB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anehv2q+LhIJLjHodqxN78/nb2cNJh3/lyUQj7Ddq3D/y+Ln/ygGbqQL0tqK4KDQDYD5BBICQ6fGtlgyD8IvHuykLLss1T17jBT+GdWgrOav+A+0+wpPx87HPIjeEuTBQebStUw4O91pKkv9u6mOLKAGFw6/cRoKtsjSeROHpBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSjnJNY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393D2C32781
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 10:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719311892;
	bh=uapIYEvq/QUcIN/YV/9PlOKB0euEcTNxB9jlTjeCGB4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nSjnJNY2oset0IWfNQp6Kr/HTnhWJGCqDsu0Oc/28QMI/ohRuk3tm4yWccJXiqLsX
	 O5PdsQhqlbYf8kzP2o+bB+yb1ncBr44lT4dKKXEZfFj1jqxUlRPZWJEhQoXqtxX/4S
	 Yuxtpwxt7VLRf3O0Gfvqq+F3vD9VgKdV6EV9nfLmBWlWNubcor9O2EzmcSvwkXwnYG
	 SJvWAHEvK3uvBszuPs9pnwlJbKSF3hr4G2OXR6Gltz3j+ScDnVMC5PLJYWQ6aj65yL
	 4YnmiEET6ANz8AxUbRizdOBWf/BVyJc9P9ozi9DIpO/6uPyEWRXQl2An6HPcoJQ0xr
	 lhUJe1qTChgQA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a724b9b34b0so258375066b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 03:38:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YyPcTXZThhCH4jGNGZPYsOvHsISiUestiixOterY4EHKA1ZihgL
	tDLA6bEgcTbhoNlfcnqIJh2Ugut5dBKF0IWGpxJPQq3WEOVKBI3PQUGl9rkBWoj3NmVheEIssWx
	jxT7pWdch35zO+NgQ1X13pqzZFrA=
X-Google-Smtp-Source: AGHT+IFUPYmfHX69UUrcOvVRVxKrce6NbD3S9C/VeXnzaXrrKDnI9DCdz43HZCBzRniiTZ6yBLKAd0jDRGLIzQpq+kU=
X-Received: by 2002:a17:907:d402:b0:a72:6849:cb21 with SMTP id
 a640c23a62f3a-a726849d851mr154077566b.54.1719311890849; Tue, 25 Jun 2024
 03:38:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719291793.git.wqu@suse.com> <75a7f80c92184ced08a904dc3ce0d43518d399a5.1719291793.git.wqu@suse.com>
In-Reply-To: <75a7f80c92184ced08a904dc3ce0d43518d399a5.1719291793.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 25 Jun 2024 11:37:34 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4hrGg3gkhWow1bRYonKZK=xeFWY8U-SGZUnfa26Ygk9w@mail.gmail.com>
Message-ID: <CAL3q7H4hrGg3gkhWow1bRYonKZK=xeFWY8U-SGZUnfa26Ygk9w@mail.gmail.com>
Subject: Re: [PATCH 4/4] btrfs: tree-checker: add extra ram_bytes and
 disk_num_bytes check
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 6:08=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> This is to ensure non-compressed file extents (both regular and
> prealloc) should have matching ram_bytes and disk_num_bytes.
>
> This is only for CONFIG_BTRFS_DEBUG and CONFIG_BTRFS_ASSERT case,

I would leave just for DEBUG.

> furthermore this will not return error, but just a kernel warning to
> inform developers.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/tree-checker.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index a2c3651a3d8f..cddabd9a0e37 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -340,6 +340,25 @@ static int check_extent_data_item(struct extent_buff=
er *leaf,
>                 }
>         }
>
> +       /*
> +        * For non-compressed data extents, ram_bytes should match its di=
sk_bytenr.
> +        * However we do not really utilize ram_bytes in this case, so th=
is check
> +        * is only optional for DEBUG+ASSERT builds for developers to cat=
ch the
> +        * unexpected behaviors.
> +        */
> +       if (IS_ENABLED(CONFIG_BTRFS_DEBUG) && IS_ENABLED(CONFIG_BTRFS_ASS=
ERT) &&
> +           btrfs_file_extent_compression(leaf, fi) =3D=3D BTRFS_COMPRESS=
_NONE &&
> +           btrfs_file_extent_disk_bytenr(leaf, fi)) {
> +               if (unlikely(btrfs_file_extent_ram_bytes(leaf, fi) !=3D
> +                            btrfs_file_extent_disk_num_bytes(leaf, fi)))=
 {
> +                       file_extent_err(leaf, slot,
> +"mismatch ram_bytes (%llu) and disk_num_bytes (%llu) for non-compressed =
extent",
> +                                       btrfs_file_extent_ram_bytes(leaf,=
 fi),
> +                                       btrfs_file_extent_disk_num_bytes(=
leaf, fi));
> +                       WARN_ON(1);

Instead of adding here a WARN_ON(1) and unlikely in the if condition,
just make the if condition use WARN_ON:

if (WARN_ON(btrfs_file_extent_ram_bytes(leaf, fi) !=3D
btrfs_file_extent_disk_num_bytes(leaf, fi)))

The WARN_ON includes the unlikely, and further this makes it conform
to our preference of having error messages after stack traces.

Thanks.

> +               }
> +       }
> +
>         return 0;
>  }
>
> --
> 2.45.2
>
>

