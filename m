Return-Path: <linux-btrfs+bounces-17213-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01CEBA3108
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 11:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97CDB17D131
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 09:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BDA279DCC;
	Fri, 26 Sep 2025 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxkKV6ae"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EEE72608
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758877492; cv=none; b=C8xrsPxh6q+Lmv78mQO2sVdVChgUpF9YsBNmNhM9NxqnJGCoxpjUnY/DJHkrTRg9qdMRpOKSW/pP1X2wGxhZjFmDWM8635KdkC69ccDVaUQpncFBmyYQlLHTEghIcjmLK/UC/NdRPl1Iq/V5twGsUeU2u5xvvqe/AAujv6FBhDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758877492; c=relaxed/simple;
	bh=y9uxlhWtFvfzIMPlNyO7wjBUm8CzNesN83NyBesFjFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zob+5p0ZXRx8qrum4MqVP7rX905SwmvAb2BRFRjihw6vshT+fjpNKCwejUWgheJGW3roeTr/FRD/T62xp09jGc4FgXMGW79rsJXifkSiaOrb45zWhguif7KbWVPLuXahv4KmLpeITOH0eMomBKl9/X4xu5iKwk0Hrz8LzM8ZgPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxkKV6ae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07483C116B1
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 09:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758877492;
	bh=y9uxlhWtFvfzIMPlNyO7wjBUm8CzNesN83NyBesFjFE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fxkKV6ae1YIWfWH0vCtIKUEbbvf4gml/qJ0mum8+5Bc4aaz/ZHF4R8Ilms1zuLhzG
	 sYprueZLjofain1+EkH6ccJSqmoE1wK5pOPDuvQebEreF5e+XFhzN88QOXKkApLW8h
	 Z1Qd8omjnwNOEN0eN7sDTl6dgQwSpxyhoq0qijeDDmDn7rtqC1KKRlhZF4vCR0x9pI
	 YXtdLN3snljlgeTF7ppXeDZIP7tloAvZ4N/lfLQXB9Q4sG/it3MwMjv7lFWGtrdmY3
	 wXSbWjIRLxrhDyeOy1F0C64auqfan0XEZi/j/HzaVrYBVJEfgN/NsvVTfEXTdEM1LX
	 t/ULMhv/RemSA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso4082423a12.3
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 02:04:51 -0700 (PDT)
X-Gm-Message-State: AOJu0YzIPj869xJiGB8h42dE4PMFlgxJNHVNRUTYbpEmPGRvKXq1Jci+
	9zqOd49wIaPuw60laTJ+atxZcAAr5UOyXllTt2nINdtG2laRZY6IbHZjQXtvt/nv6h0JV73lONi
	ORZM2NlXIH0xdoYMjtfzvPvrgw6sMPl8=
X-Google-Smtp-Source: AGHT+IHSiIWew1th6bTnJPsTsYOBIF5IDgsikuwgdP+Do7WPSqHWTaMNJpX+57wvklEoLrLG6qdZvaqjpbptGOvJYoo=
X-Received: by 2002:a17:907:7f26:b0:b04:75fe:e88 with SMTP id
 a640c23a62f3a-b34bb9e7465mr603728766b.49.1758877490580; Fri, 26 Sep 2025
 02:04:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925184139.403156-1-mssola@mssola.com>
In-Reply-To: <20250925184139.403156-1-mssola@mssola.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 26 Sep 2025 10:04:13 +0100
X-Gmail-Original-Message-ID: <CAL3q7H53nu8sGuDCbWzsVFHf5g1ybsRVrdyN6WaET61mk-g3mA@mail.gmail.com>
X-Gm-Features: AS18NWDBXpVG0hT1J_0jXI-7V7EuXUjwuvNYUW8Pw4zHRsgGl1DLD8e3nNy0xpY
Message-ID: <CAL3q7H53nu8sGuDCbWzsVFHf5g1ybsRVrdyN6WaET61mk-g3mA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: ioctl: Fix memory leak on duplicated memory
To: =?UTF-8?B?TWlxdWVsIFNhYmF0w6kgU29sw6A=?= <mssola@mssola.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com, wqu@suse.com, 
	linux-kernel@vger.kernel.org, Boris Burkov <boris@bur.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 11:42=E2=80=AFPM Miquel Sabat=C3=A9 Sol=C3=A0 <msso=
la@mssola.com> wrote:
>
> On 'btrfs_ioctl_qgroup_assign' we first duplicate the argument as
> provided by the user, which is kfree'd in the end. But this was not the
> case when allocating memory for 'prealloc'. In this case, if it somehow
> failed, then the previous code would go directly into calling
> 'mnt_drop_write_file', without freeing the string duplicated from the
> user space.
>
> Fixes: 4addc1ffd67a ("btrfs: qgroup: preallocate memory before adding a r=
elation")
> Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

I pushed it  into the for-next branch [1] with a changed subject to:

btrfs: fix memory leak on duplicated memory in the qgroup assign ioctl

Note that we don't capitalize the first word after the prefix in the subjec=
t.
I also made it more specific by mentioning which ioctl, since we have many.

Thanks.

[1] https://github.com/btrfs/linux/commits/for-next/

> ---
>  fs/btrfs/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 185bef0df1c2..8cb7d5a462ef 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3740,7 +3740,7 @@ static long btrfs_ioctl_qgroup_assign(struct file *=
file, void __user *arg)
>                 prealloc =3D kzalloc(sizeof(*prealloc), GFP_KERNEL);
>                 if (!prealloc) {
>                         ret =3D -ENOMEM;
> -                       goto drop_write;
> +                       goto out;
>                 }
>         }
>
> --
> 2.51.0
>

