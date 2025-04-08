Return-Path: <linux-btrfs+bounces-12871-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E95EA80F07
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 16:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2E21885332
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 14:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6F922258B;
	Tue,  8 Apr 2025 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCUW96J6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5071F582C;
	Tue,  8 Apr 2025 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124023; cv=none; b=QZVZXQenTOi6PXYzhynZWJPGpzG1kzT2gzp+6rBYGCvZAFNGOPGFkNIDtAOg+k+w+q1Emfhu8FWu/DfoEtTmW/IyTpJnQpf2CcQK0/Wiz9mw8/I37x5eCuPl/l0OIYB3iEq2YdWkSaEf01Ld1Hw7n390drqWH8QTIy1sYT8VHFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124023; c=relaxed/simple;
	bh=gTJsDnTp1L4bSMY7tC7A/z2FtBDVtOYUqwQSxdOm8fY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9sy+sGbRS1XddKueOdzWq4x6VqW3WpeVxyOhxRwsodHHMy4wyb32o6cbsRjpDE+r6bNvuL122MZa9tZLKkvq/zSGMZ3D1btLB9T14vOkHAcLWXMX2sPgPCTn3yWrVqYvIP6NwtxL63W1Wgv9z6jwVmaHntgNJ3l+Z4g1zl2FYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCUW96J6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B1EC4CEEC;
	Tue,  8 Apr 2025 14:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744124023;
	bh=gTJsDnTp1L4bSMY7tC7A/z2FtBDVtOYUqwQSxdOm8fY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uCUW96J6UP+79EgwdzXM7xKXQLhbxEc7QN/UNfTJhpI7YR3lJwJKk604pZLMcMbAi
	 yC7ix3DJM1ZhPCTPX/I9Y7QntHLi+YUe/mpkkMKbqSBNk/DoAGRY33986FfsgfIaIl
	 rODGrWzViWbV2+1J1kLpj2glrxzF5OqCJHTsfidxHRf0sYjIWxYR8J9iitRa5vniW+
	 KSfneRL0kF3kSPyyjlL6fvI+440GjCLgPjsxXawC+N+yu6IocM5/7lp0Wzybo5cl+d
	 p/HCdQHAgKvVkJDaElK72Wj4J2Y6yfobdeTH/airvFIG9awR++URotw0geWKmJq6Ix
	 rNUASh8SviWxg==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so9380761a12.2;
        Tue, 08 Apr 2025 07:53:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXM2hMdSmDVdT8oZ1VYCyQ5DFsWXW5C8p9diE4PUSu94d25twPobh/qV2myPjMC+iULyzlUazfwAZHVPoJ@vger.kernel.org, AJvYcCVehXcmG3XsH7xLfzbvQ4HsD1OxnNeUhaZIJB7TxIFBVpUJKXfLnpjsZBMYJHzAcBJkPauWVY0bY/GtjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/90Gg5HbUePKqxTz8oO95FOclDpPJZoNlXfB+jQDTR7HAXRHN
	1Ie+wkyudwvrrLa6+/HWPe9ghGe0l6yFIeVetmIwUeY/If0ljh+TEmxAQzSeXjWfVOtQ1O4y4uI
	hlXPvCNRtB0JwVF3G5KeZWBxsr+0=
X-Google-Smtp-Source: AGHT+IH67g8qwU75Ow54CtjFFP/+oeE+MFw5PXwIURCefOPl6V/Y2jnK/gEYbPNMz7ja+KzZsdf9N6R9g63qATIu9JQ=
X-Received: by 2002:a17:907:970b:b0:ac3:cab6:719e with SMTP id
 a640c23a62f3a-ac7d1854ad4mr1355933966b.11.1744124021627; Tue, 08 Apr 2025
 07:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408122933.121056-1-frank.li@vivo.com> <20250408122933.121056-4-frank.li@vivo.com>
In-Reply-To: <20250408122933.121056-4-frank.li@vivo.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 8 Apr 2025 15:53:04 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7BS6juCS0eRdo6sqM4jzeMMi1o=huG38wgKYumD7qmmw@mail.gmail.com>
X-Gm-Features: ATxdqUFPx3hKSJXKNZwNPCum0SY93yIVS3AchSMgEFM7yEdIBRGy2IzNzbS33_k
Message-ID: <CAL3q7H7BS6juCS0eRdo6sqM4jzeMMi1o=huG38wgKYumD7qmmw@mail.gmail.com>
Subject: Re: [PATCH 4/4] btrfs: Fix transaction abort during failure in del_balance_item()
To: Yangtao Li <frank.li@vivo.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 1:19=E2=80=AFPM Yangtao Li <frank.li@vivo.com> wrote=
:
>
> Handle errors by adding explicit btrfs_abort_transaction
> and btrfs_end_transaction calls.

Again, like in the previous patch, why?
This provides no reason at all why we should abort.
And the same comment below.

>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/btrfs/volumes.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 347c475028e0..23739d18d833 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3777,7 +3777,7 @@ static int del_balance_item(struct btrfs_fs_info *f=
s_info)
>         struct btrfs_trans_handle *trans;
>         BTRFS_PATH_AUTO_FREE(path);
>         struct btrfs_key key;
> -       int ret, err;
> +       int ret;
>
>         path =3D btrfs_alloc_path();
>         if (!path)
> @@ -3800,10 +3800,13 @@ static int del_balance_item(struct btrfs_fs_info =
*fs_info)
>         }
>
>         ret =3D btrfs_del_item(trans, root, path);
> +       if (ret)
> +               goto out;
> +
> +       return btrfs_commit_transaction(trans);
>  out:
> -       err =3D btrfs_commit_transaction(trans);
> -       if (err && !ret)
> -               ret =3D err;
> +       btrfs_abort_transaction(trans, ret);
> +       btrfs_end_transaction(trans);

A transaction abort will turn the fs into RO mode, and it's meant to
be used when we can't proceed with changes to the fs after we did
partial changes, to avoid leaving things in an inconsistent state.
Here we don't abort because we haven't done any changes before using
the transaction handle, so an abort is pointless and will turn the fs
into RO mode unnecessarily.

Thanks.

>         return ret;
>  }
>
> --
> 2.39.0
>
>

