Return-Path: <linux-btrfs+bounces-6629-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBA593824C
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jul 2024 19:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9EE0281D1A
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jul 2024 17:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2A21487D4;
	Sat, 20 Jul 2024 17:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptJaJ1d1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0712B147C80;
	Sat, 20 Jul 2024 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721496448; cv=none; b=mTEXXFvuD7lZO9S8lkjRU4Lzc5Po+8gUchU8MKoZ382vruP3PEcRzBhd4kKBAUYpLFg008hyHcbCX7dCQkdRuMYoPLLeKVVPtJJ6mDLM/ibWUDckCiwPas73l65+/FXy31FSQL277RN2CXZQekAYWGxXCEmwMR0hDRfYaxouTK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721496448; c=relaxed/simple;
	bh=UTJTDTaY+qnqubzTCRfxofaQ3C7yFMD+fihOtl72oSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Td8Htp2X5cGLC0OAwqVjqHfs905QEwg/nocNV0oCAQQ0mDmyJe824clhjQ/cyfLiUMLIAsZs7F8KMuo0Qw2qFiIBg0f0WFzYrPMycIT+A5xFICm0tinXuSUTteF7dgyIkevNCzWWD9Dh15HniJSlmVvJUudSMcHO+9MBMPskDDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptJaJ1d1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC359C4AF09;
	Sat, 20 Jul 2024 17:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721496447;
	bh=UTJTDTaY+qnqubzTCRfxofaQ3C7yFMD+fihOtl72oSY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ptJaJ1d1OBSxvNAk3kdqNa7OThSg2NQIFMwJq92asDC59lMZSROiLrtiIm6blivNM
	 +X88gNfYS+EK+G/l6JkIqzW3CIuVcdraFKpvz6Bt4Ss1VzjxioVi2JG888qt37h56G
	 GY4slK6OnGvx9Z8TgNAn3mU31hCkjmn1jexSWRUXCNKm2eo38knv1s9CCGMVL5ovS7
	 Mj29Nrw9WWVjwEmK2GTMSSCNBjYQeHY/IuVmEWKL5QOanu4boT7C0xzoKPa/npKH80
	 dNz0w0sVlMGIDDir4WF4Zr3m/NeK0Ipg74Bqc0jhIfrO6RUmTVtqJK8iBcXA+jhl4Z
	 yWRFyRyQHFdcQ==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a77e7a6cfa7so302954566b.1;
        Sat, 20 Jul 2024 10:27:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXaL8m+nSIv45LdWtj6+jLZjkQANvkodIKOjqvN0FUe90t9LzVw7cCh67VE1ne3vZxsaM7g/Gtg7EmM9LUjKYZUABg0YNLrgk+pMFVq+wPhJlZzpr4xqRaLlZ9qe2s1PW4C4PgA
X-Gm-Message-State: AOJu0Yxdtt+SBhUVBH3nR2cZB8nqZ/taUJ7QkRS2o8fXPounYS02qJw7
	K0TIz58PBRu0gIHl/XrKf2ruyteifjg7ThiPCZDNYiflE1WicrIdnnIw90Qt7bRfUy4GD833/jK
	QWOBfMicZKiTTkfCh+y3tgXfAlbk=
X-Google-Smtp-Source: AGHT+IEfX4vbO7ZsYz7RPnPZl97yq+vWxd0um0lpMgys0EZt9R5flB9TwEyRmSHmLaRcjtfJ+paLO00KOA+4GdDEjP4=
X-Received: by 2002:a17:906:448f:b0:a77:cdaa:88ab with SMTP id
 a640c23a62f3a-a7a01119884mr741609766b.15.1721496446233; Sat, 20 Jul 2024
 10:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720083538.2999155-1-yangerkun@huawei.com>
In-Reply-To: <20240720083538.2999155-1-yangerkun@huawei.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 20 Jul 2024 18:26:49 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5AivAMSWk3FmmsrSqbeLfqMw_hr05b_Rdzk7hnnrsWiA@mail.gmail.com>
Message-ID: <CAL3q7H5AivAMSWk3FmmsrSqbeLfqMw_hr05b_Rdzk7hnnrsWiA@mail.gmail.com>
Subject: Re: [PATCH] generic/736: don't run it on tmpfs
To: Yang Erkun <yangerkun@huawei.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, linux-mm@kvack.org, 
	hughd@google.com, akpm@linux-foundation.org, 
	linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2024 at 9:38=E2=80=AFAM Yang Erkun <yangerkun@huawei.com> w=
rote:
>
> We use offset_readdir for tmpfs, and every we call rename, the offset
> for the parent dir will increase by 1. So for tmpfs we will always
> fail since the infinite readdir.

Having an infinite readdir sounds like a bug, or at least an
inconvenience and surprising for users.
We had that problem in btrfs which affected users/applications, see:

https://lore.kernel.org/linux-btrfs/2c8c55ec-04c6-e0dc-9c5c-8c7924778c35@la=
ndley.net/

which was surprising for them since every other filesystem they
used/tested didn't have that problem.
Why not fix tmpfs?

Thanks.

>
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>  tests/generic/736 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/generic/736 b/tests/generic/736
> index d2432a82..9fafa8df 100755
> --- a/tests/generic/736
> +++ b/tests/generic/736
> @@ -18,7 +18,7 @@ _cleanup()
>         rm -fr $target_dir
>  }
>
> -_supported_fs generic
> +_supported_fs generic ^tmpfs
>  _require_test
>  _require_test_program readdir-while-renames
>
> --
> 2.39.2
>
>

