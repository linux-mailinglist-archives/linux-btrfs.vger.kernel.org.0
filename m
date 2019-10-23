Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C317DE1694
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 11:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404127AbfJWJrj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 05:47:39 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40352 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404105AbfJWJrg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 05:47:36 -0400
Received: by mail-ua1-f66.google.com with SMTP id i13so5821598uaq.7
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 02:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ZAdt6sb4g2oGn5TwGqd33fNxOgxRjkp395xFW5LxaeU=;
        b=fJlFqHE9zOm8snfu4czfjsM+EiVuizFHfEY85EnXuXwW1tV0jJ/bRpCJ3nTqk1mciS
         qBSWwxChqylELBvOOQuZoNuRTy/EjuZYukDnyOkyekvIoAn2UMlc48wRa6sWnixLcskt
         dr/fbqyVb/kID+/4mpdhSwdu9W7QpECsRo89dk1DE3KzYwEfm1KKwflQAymMontxuVGI
         2EJ9MnE23jBGjEZGfuonxQ9mCgjhVbNpXbjL4fepIpIhaCQTez8ITAl6Rk2KO2//svln
         u/Q3n8KBgmC4gxgNuyXpVp8Fn3osoOA9v3vjZrXVr/GKvRz+fqjm2VU3VYf+jFmEEkyh
         Wr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ZAdt6sb4g2oGn5TwGqd33fNxOgxRjkp395xFW5LxaeU=;
        b=l2JfRL6stHu4OHBFWJF7ES0jLo8ZUg7gyUBZi1F4ZPpekfYaP2p01Qo6qGMfJSi6W3
         wbo7KtXPgUx8sM92zpjUK79HFMdSdUafGkdLPJ0jM3tIlCWybmm4BMJRSZDIOpSfcrmZ
         +T910EZzUc6eIJ/B6so70KRXmCN+nwiPLXs1I5YvriVj5trKfff+sOh/8iv2DzAQeU4S
         Ky+AB2c/bNXQSmk8/uVIWn0LuDY895wX4qbyLzgG9LvLKzJmizxWxqmVpGSfwulAUOpU
         crCIYM9XrM/LAa0Oh6jp5O0+dGhe1KFMpJdGu8sNdH5jtytLT1qEZzelqqlg+Z2RdJUD
         p0eg==
X-Gm-Message-State: APjAAAX2kgvceVQ0RJtbt4vcs1eDqOV9srC5+PcsSY8L/aFiFNafr4dF
        ooH/d8gGdhLsEEYEg8EdGYDDPUMyou+W1It1awY=
X-Google-Smtp-Source: APXvYqxfwShWGsd201g9gFFKtJo+YjTb5YXpzvwjvtbK8VAu0Gv2qReJ+IYXOPVEqR73o9qDGVtyJpPnmM/qZjRfzQA=
X-Received: by 2002:ab0:2250:: with SMTP id z16mr2835722uan.135.1571824055909;
 Wed, 23 Oct 2019 02:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191023085037.14838-1-wqu@suse.com> <20191023085037.14838-2-wqu@suse.com>
In-Reply-To: <20191023085037.14838-2-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 23 Oct 2019 10:47:25 +0100
Message-ID: <CAL3q7H5V0fapMLnznQhHuG8f1myhAdiy42WsUFr-6ryjV7orEQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: volumes: Return the mapped length for discard
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 23, 2019 at 9:53 AM Qu Wenruo <wqu@suse.com> wrote:
>

Hi Qu,

> For btrfs_map_block(), if we pass @op =3D=3D BTRFS_MAP_DISCARD, the @leng=
th
> parameter will not be updated to reflect the real mapped length.
>
> This means for discard operation, we won't know how many bytes are
> really mapped.

Ok, and what's the consequence? The changelog should really say what
is the problem, what the bug is.
The cover letter and the second patch explain what problems are being
solved, but not this change.

>
> Fix this by changing assigning the mapped range length to @length
> pointer, so btrfs_map_block() for BTRFS_MAP_DISCARD also return mapped
> length.
>
> During the change, also do a minor modification to make the length
> calculation a little more straightforward.
> Instead of previously calculated @offset, use "em->end - bytenr" to
> calculate the actually mapped length.

I really don't like much mixing a cleanup with a fix. I would prefer
two separate patches, no matter how small or trivial it is.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Other than that, it looks good to me.
Thanks.

> ---
>  fs/btrfs/volumes.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index cdd7af424033..f66bd0d03f44 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5578,12 +5578,13 @@ void btrfs_put_bbio(struct btrfs_bio *bbio)
>   * replace.
>   */
>  static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
> -                                        u64 logical, u64 length,
> +                                        u64 logical, u64 *length_ret,
>                                          struct btrfs_bio **bbio_ret)
>  {
>         struct extent_map *em;
>         struct map_lookup *map;
>         struct btrfs_bio *bbio;
> +       u64 length =3D *length_ret;
>         u64 offset;
>         u64 stripe_nr;
>         u64 stripe_nr_end;
> @@ -5616,7 +5617,8 @@ static int __btrfs_map_block_for_discard(struct btr=
fs_fs_info *fs_info,
>         }
>
>         offset =3D logical - em->start;
> -       length =3D min_t(u64, em->len - offset, length);
> +       length =3D min_t(u64, em->start + em->len - logical, length);
> +       *length_ret =3D length;
>
>         stripe_len =3D map->stripe_len;
>         /*
> @@ -6031,7 +6033,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *=
fs_info,
>
>         if (op =3D=3D BTRFS_MAP_DISCARD)
>                 return __btrfs_map_block_for_discard(fs_info, logical,
> -                                                    *length, bbio_ret);
> +                                                    length, bbio_ret);
>
>         ret =3D btrfs_get_io_geometry(fs_info, op, logical, *length, &geo=
m);
>         if (ret < 0)
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
