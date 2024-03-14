Return-Path: <linux-btrfs+bounces-3299-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD4487C20B
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 18:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606691C20B2C
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 17:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FF574BEB;
	Thu, 14 Mar 2024 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nms0Snzo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B977745CB
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436778; cv=none; b=amUtutieWdU5Wt17BKLEH4NW748NEgKKX6k3Um91Pe3x5GYyUXAJUf3V2ews686nhq52TIJoseuJJEucNJwUzr070t69BsrZf+C2avQskwu8QO5SCR1pAx46wVC8wq8ciOpLcm6NfEVOE7nD+2N6j3HWXEzSJCbU1y+gVTO0Wl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436778; c=relaxed/simple;
	bh=ugBYUsDxwXZIfWjTB/pvxqMxRjrDljpai3EOqJUIbIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d36ryARsgpraYHR8Fb3PkuPiBQdlOEwDxb68xTq2fAxNUepxrFo5zSG46Cb7w3NXElIEVXlkth8ZWQYN0wps+Zt2mm/vehFp6b3GviWHobxd/Z7DcyuIkbztbZpzeVWcKPoRQZWpmilosT8eWoZ3E19sUd2cp4ITiUZKbLW6Onc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nms0Snzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59810C433F1
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 17:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710436778;
	bh=ugBYUsDxwXZIfWjTB/pvxqMxRjrDljpai3EOqJUIbIo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Nms0SnzoipKLixNAt+OiORSObW69CHFJIK3nDAhv4szwsYq8At3RVozy/+wcXQ5+S
	 9NMcRbetft60fFK+PveiXlQXQ1Uokbo1klD9B/jCVbO9S34VvS3Jj/lz9PvnqVbUv7
	 fDVb63dn/PBw9O7BTyygQ/waP6dPiCZqkmVjJ3KazTzA4gl+OzQy1GfM9VJPPELzup
	 YZl9Mm8aPBNe6ldgW7uH61Y1GZ4X8XNSG/VO03egPbb1cWzh5jSnVuCUQ7W+XN7Ur8
	 TLP2T5LKkVWUc3ugUky2JQeHAypDkJP86F2UO5SUkndT4HSUhp/lhkU2bBLGRdlcUF
	 8ZMfqYJbga2oQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a449c5411e1so158677566b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 10:19:38 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz5oHeOiQYrWQl0yp/N5MydJtXaj06TYC0+cwy6eF+U2LcrgDs/
	q40b6GArraZ5xGKLKfAoC/CDwLFaIqf7Spmwc8r5KcWXlLFQ57vszx9W4whdbnczNojcozzeFJO
	YMb9kzqrZXiuE5LtJZd/FUl9IlL4=
X-Google-Smtp-Source: AGHT+IFMIsRLYxgDF1wGHpiScp3WLLmoyxdRrplwThGHFK3px9arbQyBnUB67GT0DnrbY56iWFqepqALn83TXJaawSs=
X-Received: by 2002:a17:906:e11:b0:a46:302d:75ff with SMTP id
 l17-20020a1709060e1100b00a46302d75ffmr1821123eji.26.1710436776982; Thu, 14
 Mar 2024 10:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710409033.git.wqu@suse.com> <9c33e49522e2910e2c6735a32592080325ed395d.1710409033.git.wqu@suse.com>
In-Reply-To: <9c33e49522e2910e2c6735a32592080325ed395d.1710409033.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 14 Mar 2024 17:19:00 +0000
X-Gmail-Original-Message-ID: <CAL3q7H40j4yWLf-nRRgO1ZxN8kG6HzXnx0HoiMHjvUBueTjN2Q@mail.gmail.com>
Message-ID: <CAL3q7H40j4yWLf-nRRgO1ZxN8kG6HzXnx0HoiMHjvUBueTjN2Q@mail.gmail.com>
Subject: Re: [PATCH 3/7] btrfs: scrub: remove unused is_super parameter from scrub_print_common_warning()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 9:50=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Since commit 2a2dc22f7e9d ("btrfs: scrub: use dedicated super block
> verification function to scrub one super block"), the super block
> scrubbing is handled in a dedicated helper, thus
> scrub_print_common_warning() no longer needs to print warning for super
> block errors.
>
> Just remove the parameter.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/scrub.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 119e98797b21..5e371ffdb37b 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -476,7 +476,7 @@ static int scrub_print_warning_inode(u64 inum, u64 of=
fset, u64 num_bytes,
>  }
>
>  static void scrub_print_common_warning(const char *errstr, struct btrfs_=
device *dev,
> -                                      bool is_super, u64 logical, u64 ph=
ysical)
> +                                      u64 logical, u64 physical)
>  {
>         struct btrfs_fs_info *fs_info =3D dev->fs_info;
>         struct btrfs_path *path;
> @@ -488,12 +488,6 @@ static void scrub_print_common_warning(const char *e=
rrstr, struct btrfs_device *
>         u32 item_size;
>         int ret;
>
> -       /* Super block error, no need to search extent tree. */
> -       if (is_super) {
> -               btrfs_warn_in_rcu(fs_info, "%s on device %s, physical %ll=
u",
> -                                 errstr, btrfs_dev_name(dev), physical);
> -               return;
> -       }
>         path =3D btrfs_alloc_path();
>         if (!path)
>                 return;
> @@ -966,15 +960,15 @@ static void scrub_stripe_report_errors(struct scrub=
_ctx *sctx,
>
>                 if (test_bit(sector_nr, &stripe->io_error_bitmap))
>                         if (__ratelimit(&rs) && dev)
> -                               scrub_print_common_warning("i/o error", d=
ev, false,
> +                               scrub_print_common_warning("i/o error", d=
ev,
>                                                      logical, physical);
>                 if (test_bit(sector_nr, &stripe->csum_error_bitmap))
>                         if (__ratelimit(&rs) && dev)
> -                               scrub_print_common_warning("checksum erro=
r", dev, false,
> +                               scrub_print_common_warning("checksum erro=
r", dev,
>                                                      logical, physical);
>                 if (test_bit(sector_nr, &stripe->meta_error_bitmap))
>                         if (__ratelimit(&rs) && dev)
> -                               scrub_print_common_warning("header error"=
, dev, false,
> +                               scrub_print_common_warning("header error"=
, dev,
>                                                      logical, physical);
>         }
>
> --
> 2.44.0
>
>

