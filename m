Return-Path: <linux-btrfs+bounces-6362-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37FB92E041
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 08:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A0B1C21BC6
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 06:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4BD12E1CA;
	Thu, 11 Jul 2024 06:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czn1ovPu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1AC8249A;
	Thu, 11 Jul 2024 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720679959; cv=none; b=RmBWlSkdrFsHygi756Uz3tpj0V+fpETq9tBsd6AnVO01r1M96KaGSlNrvNww78GSMuIOr1s1vnGhuGwm4CMgxN69HNv+QzvJ6ckWRZgHE42iJfvvUSJhJrWuFp1boy3/5TOcerhFLXWUMBlwb/njfMqqmhY/Cnq5Rgmro0Aoy4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720679959; c=relaxed/simple;
	bh=YYuzY+tLhiCKB0JfC01of+ILfufjHR1RA3FDo//2JiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YrC7Q+xA2zRJLRYJKkTW2idnrNgxZXlKudwT85/KgcBjXGH8LtzzNPXLM9nz7FnZYm1QJSVZuhsZjo47yhSZGsljkFUkoSiy6SQV9OGtFUj4U/dKWUhMi+y7oLvKyVjX+tiMyHmwVzXZH/lVmpCt6BUJIkRvBKJnHf6cCiSxk0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czn1ovPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92263C4AF0F;
	Thu, 11 Jul 2024 06:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720679958;
	bh=YYuzY+tLhiCKB0JfC01of+ILfufjHR1RA3FDo//2JiY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=czn1ovPuwZRPwkEMEGJNLqZvmdEJkCTC8Q03rhl6F5FW2JhUQHz63FjvRcr0ezkOr
	 bqISEZUFVnEVqmqnzxptnWxsXZyHc9JWJwMwnC+H12l41zNckcvZ5kDjCacyL8ovPs
	 s0E4oDvTj/5aRzMR2WwGI/DTrWNTh8tpeLvPUXEG7REvEZv6hyX27xhDhSz1kFoTmt
	 exJ1UpnnHMgR25/a+abQ4AOiijAjOmldne29PLalhniHo0rLQLtlzvlqyeOXhF+s7f
	 Srg9BVyAUxsaXdcfzeVDnE0age9uTF1q2tfzRl/5MlOoBy8Gvs7ql+kT1hK4tTDlOJ
	 1htJA36xFjXAw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77c9c5d68bso68738966b.2;
        Wed, 10 Jul 2024 23:39:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUILdRMWBRq4WvReZrV4mXuT7aqOKRRhSYZrN5ZUCWAwFzEFtdN6avzDfVjpfCz1TJ5lVdx9DxEEUQFUfMdIZCKK49WIBYP9mx4CwidPNosZkaJTMW67ci8zU4BTD0ebbj4cU97CxqooOm2HaiacD5gqV/0XZNRdFp5efxqWvzEnl0=
X-Gm-Message-State: AOJu0Yw1yb3mODtWqCkx5Iy0SxLdThN9OJDjjoWf+aD7KMs8DpMDuj0a
	SdBCus15IIIYOyojaG6DT7hmdDU96NfWflyhA08sP+JwSJaqeFYneG+kKJEWlYxDZGz9gVoAc7V
	mKEYG0jAFUmJ1UHHH9H122OpYOYw=
X-Google-Smtp-Source: AGHT+IEdES9ra8lhHWoM6RznNhYmve7qzUYd0yRVQr+T7mh+ANEEX2mvwgKpXCmmQQzLCaxjyKbu0vIgnqH3wKUV+64=
X-Received: by 2002:a17:907:da7:b0:a77:eb34:3b4b with SMTP id
 a640c23a62f3a-a780b68a989mr646569166b.11.1720679957126; Wed, 10 Jul 2024
 23:39:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710-bug11-v2-1-e7bc61f32e5d@gmail.com>
In-Reply-To: <20240710-bug11-v2-1-e7bc61f32e5d@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 11 Jul 2024 07:38:40 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6NisGBRqccRv3CiTDMJS0M7ZnvSrEDDHSOUn2TaWBBDw@mail.gmail.com>
Message-ID: <CAL3q7H6NisGBRqccRv3CiTDMJS0M7ZnvSrEDDHSOUn2TaWBBDw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: Fix slab-use-after-free Read in add_ra_bio_pages
To: Pei Li <peili.dev@gmail.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, skhan@linuxfoundation.org, 
	syzkaller-bugs@googlegroups.com, 
	linux-kernel-mentees@lists.linuxfoundation.org, 
	syzbot+853d80cba98ce1157ae6@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 5:29=E2=80=AFAM Pei Li <peili.dev@gmail.com> wrote:
>
> We are accessing the start and len field in em after it is free'd.
>
> This patch moves the line accessing the free'd values in em before
> they were free'd so we won't access free'd memory.
>
> Reported-by: syzbot+853d80cba98ce1157ae6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D853d80cba98ce1157ae6
> Signed-off-by: Pei Li <peili.dev@gmail.com>
> ---
> Syzbot reported the following error:
> BUG: KASAN: slab-use-after-free in add_ra_bio_pages.constprop.0.isra.0+0x=
f03/0xfb0 fs/btrfs/compression.c:529
>
> This is because we are reading the values from em right after freeing it
> before through free_extent_map(em).
>
> This patch moves the line accessing the free'd values in em before
> they were free'd so we won't access free'd memory.
>
> Fixes: 6a4049102055 ("btrfs: subpage: make add_ra_bio_pages() compatible"=
)

This type of useful information should be in the changelog, not after the -=
--

And btw, this was already fixed last week and it's in for-next:

https://github.com/btrfs/linux/commit/aaa2c8b3f54e7b4f31616fd03bb302cc17ccc=
f39
https://lore.kernel.org/linux-btrfs/20240704171031.GX21023@twin.jikos.cz/T/=
#m9a92a5d980230323ec351a24adf9a3738cfbbc40

Thanks.

> ---
> Changes in v2:
> - Adapt Qu's suggestion to move the read-after-free line before freeing
> - Cc stable kernel
> - Link to v1: https://lore.kernel.org/r/20240710-bug11-v1-1-aa02297fbbc9@=
gmail.com
> ---
>  fs/btrfs/compression.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 6441e47d8a5e..f271df10ef1c 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -514,6 +514,8 @@ static noinline int add_ra_bio_pages(struct inode *in=
ode,
>                         put_page(page);
>                         break;
>                 }
> +               add_size =3D min(em->start + em->len, page_end + 1) - cur=
;
> +
>                 free_extent_map(em);
>
>                 if (page->index =3D=3D end_index) {
> @@ -526,7 +528,6 @@ static noinline int add_ra_bio_pages(struct inode *in=
ode,
>                         }
>                 }
>
> -               add_size =3D min(em->start + em->len, page_end + 1) - cur=
;
>                 ret =3D bio_add_page(orig_bio, page, add_size, offset_in_=
page(cur));
>                 if (ret !=3D add_size) {
>                         unlock_extent(tree, cur, page_end, NULL);
>
> ---
> base-commit: 563a50672d8a86ec4b114a4a2f44d6e7ff855f5b
> change-id: 20240710-bug11-a8ac18afb724
>
> Best regards,
> --
> Pei Li <peili.dev@gmail.com>
>
>

