Return-Path: <linux-btrfs+bounces-14111-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E314ABBA55
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 11:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9551648D0
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 09:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA14D1FF61E;
	Mon, 19 May 2025 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kkphd5Yo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089DB1BC9F4
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747648388; cv=none; b=Az15NqALmu2xK7W6HX0vQNDuX9qhb3NBIf1btLl5ND5DsB0xdHTDcnYpncygrH8c9X7PSKI7Y/jkZYDngWzfQxqiAFHWp4T1cXPy0HSsVY4h8dzisif4qYaLT4WfHfXAXAupsvy5vXKjfSDi3dD6mZzzfC75Gkbvk1lDPP+P6Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747648388; c=relaxed/simple;
	bh=TKc56hl5Pn1dMRKX6Wgy4RkEyhl5LQIMcjI+uqP4NNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HbC0vp25Yk2emAGUOH7jPhcN+x6Br4534RYp4FlRK9HJjsTGYJ9c12sdhPP+SbKsuvP9iNewX5OYD+NCc7+1O1s03A2Q/5S25IxuBKanlFcbORatxmrTkAXep++cdTRdvhayVY7SdYp5L+HIH3mVvSMh9HEQ7RdbaqcOPleG+ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kkphd5Yo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C04C4CEEB
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 09:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747648386;
	bh=TKc56hl5Pn1dMRKX6Wgy4RkEyhl5LQIMcjI+uqP4NNE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Kkphd5Yob3xc9KoQzLIt726K0RgILgeJzx2i92E1dtQWNfJtNayzQReo+UYwBjXzX
	 aSUY2VBKK3Pv+xzCJn+Jjvt1a3xN33exIqPU4mzOUqQv/LsZS4yrKsnYlXyllLfATf
	 0j8cRt3yYNr+THYXXYrnjuVfePyiVFJd2cRduRA6NFNPye597W4X0vH0/PMhTVOp6x
	 5UbMIl8pmTb7pfcjVj4Am60bpF+omcEUcrq8n0n4h93S8szcK3OII6gfPtFWCen44L
	 N1CPfWRWdXE1V2fQvIxZhf30zVd70WxEomtt4vALz15DCHkK0xpE5Z9suCwrOtAFcN
	 8hCybuxxSF49Q==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-601ad859ec0so2930406a12.0
        for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 02:53:06 -0700 (PDT)
X-Gm-Message-State: AOJu0YxTg8Ocl4urXUU7Vnxp42mJ8dSgFnYhVhZ1HaAA0DsOLpCQO/+C
	K7LjcZGMWrYO6w+LN3Xi5d0MTwNrMO2Aae2U229H73w9mA53F01VdkEEHYxvTW4SMm3sojf0FsX
	z907Go8dUXV6u5VuZLveztmOY6Mb4k5k=
X-Google-Smtp-Source: AGHT+IG6+RxpaPES/UgzFYl56YANDnQNA/DX17EChVcGl5OTiMNRNCemnrq4j+IrKQLGqQJObzQ6A95YaaHhD+WVBYw=
X-Received: by 2002:a17:907:a08a:b0:ad4:f91d:bfc2 with SMTP id
 a640c23a62f3a-ad52d43826emr1077110166b.11.1747648384954; Mon, 19 May 2025
 02:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517190357.3027788-1-dsterba@suse.com>
In-Reply-To: <20250517190357.3027788-1-dsterba@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 19 May 2025 10:52:28 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4Z7n5MzdmY+3JOvtGNZcnOvAqywVPm2ck4XL_b_w+YhQ@mail.gmail.com>
X-Gm-Features: AX0GCFuYvKHzu0EkC_3jBXek3Y4KtM4P2TfKJtbJWtEr11WayQSqtZ1oUrxKbQQ
Message-ID: <CAL3q7H4Z7n5MzdmY+3JOvtGNZcnOvAqywVPm2ck4XL_b_w+YhQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: move transaction aborts to the error site in add_block_group_free_space()
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 17, 2025 at 8:04=E2=80=AFPM David Sterba <dsterba@suse.com> wro=
te:
>
> Transaction aborts should be done next to the place the error happens,
> which was not done in add_block_group_free_space().
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/free-space-tree.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index 0c573d46639ae9..6cbdb578e66c1f 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -1408,16 +1408,17 @@ int add_block_group_free_space(struct btrfs_trans=
_handle *trans,
>         path =3D btrfs_alloc_path();
>         if (!path) {
>                 ret =3D -ENOMEM;
> +               btrfs_abort_transaction(trans, ret);
>                 goto out;
>         }
>
>         ret =3D __add_block_group_free_space(trans, block_group, path);
> +       if (ret)
> +               btrfs_abort_transaction(trans, ret);
>
>  out:
>         btrfs_free_path(path);
>         mutex_unlock(&block_group->free_space_lock);
> -       if (ret)
> -               btrfs_abort_transaction(trans, ret);
>         return ret;
>  }
>
> --
> 2.49.0
>
>

