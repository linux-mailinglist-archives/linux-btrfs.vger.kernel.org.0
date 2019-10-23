Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF239E16A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 11:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403845AbfJWJvv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 05:51:51 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:35277 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732648AbfJWJvv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 05:51:51 -0400
Received: by mail-vk1-f195.google.com with SMTP id d66so4284595vka.2
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 02:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=pD7H+45x8osq5euf3c6+LlrNPlPMbrJmc6gRlAONuYk=;
        b=Cz2dzMYNBaAizpl3NiaKOuoRRua6zuSojssCierD5H+OQ/jPh+juCNwfZ5QitRuLqH
         4EPdkgjI6akhSG9cE+r4zKSDsMfTz+89YEWkapJ1BBCzG680xRaBpcKWy5SRwWw6GcEH
         ZzAYH8kIp6JPqeHMM8q95UWl4E6zApRsPZdHTGoy5iKxH4+dl4rL5EAy+hp4R/Q4sCbL
         QKKSfUjYF6BZbWzHoQMzYXwFIejHoMY9azml3dWIO1kFiRwNR7RCyVocJc0FzOU01zYG
         8HscKJm3+CyxsGqSmbQydARd0gwDrskj99Ju1pw4Cfca+OdHqBGBnkXY8cqPE8XlBP12
         Q76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=pD7H+45x8osq5euf3c6+LlrNPlPMbrJmc6gRlAONuYk=;
        b=Rckyqn44EfTqOm8gFDVwDYluOHBkwHm3DRNXPV/MQonTmxBXmS4UiHnEH2STg/X5eG
         0F0M6Y00bC/HAgsjakv7zS8oK59oe8eQJ7lWbfX2aKjnNLItXXlKz+0j3SdlHvFhnKYC
         l/6axE+50+eRbGRP9jWBfvaaMdhO6fshoaJrrY2PnoyPyOUrpcy2xs619Hu2i4h4Y8L2
         H6BGYtorJFzBVCfYhXLD66OlwRSXX6hxOQuaLZonZih/Al7ZqmwV3g4HUd6RSjIdAtcV
         OvPWr4wkv0HMKKHUoDCFf+5H6q4cIKsvos63f+4Wsl5u9OR4tQYg5v7M8oXVUzaE+eHK
         g7fg==
X-Gm-Message-State: APjAAAUUnMc2pf3/VlofGJ/WMZG/GJX6cARxd5GFbHheGYl+1I7Yy+vE
        SzLuHKIo9Hf+23jTN3I/tKOuUuu4f0DM5kdJbH0=
X-Google-Smtp-Source: APXvYqywn0v4bYWk0RngogGoMeLRuedU1GTNQkHGUqXOlmtvjdZWt/1ygoALTtt5p7xOwskly7SOBSzm8MSm4SYztR0=
X-Received: by 2002:a1f:a001:: with SMTP id j1mr4723429vke.24.1571824308154;
 Wed, 23 Oct 2019 02:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191023085037.14838-1-wqu@suse.com> <20191023085037.14838-3-wqu@suse.com>
In-Reply-To: <20191023085037.14838-3-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 23 Oct 2019 10:51:37 +0100
Message-ID: <CAL3q7H7EA1+xGVLQgAH-YZMo-9jdNyhr9+hiCcJcXnocKb7F_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: extent-tree: Ensure we trim ranges across
 block group boundary
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 23, 2019 at 9:52 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> When deleting large files (which cross block group boundary) with discard
> mount option, we find some btrfs_discard_extent() calls only trimmed part
> of its space, not the whole range:
>
>   btrfs_discard_extent: type=3D0x1 start=3D19626196992 len=3D2144530432 t=
rimmed=3D1073741824 ratio=3D50%
>
> type:           bbio->map_type, in above case, it's SINGLE DATA.
> start:          Logical address of this trim
> len:            Logical length of this trim
> trimmed:        Physically trimmed bytes
> ratio:          trimmed / len
>
> Thus leading some unused space not discarded.
>
> [CAUSE]
> When discard mount option is specified, after a transaction is fully
> committed (super block written to disk), we begin to cleanup pinned
> extents in the following call chain:
> btrfs_commit_transaction()
> |- write_all_supers()
> |- btrfs_finish_extent_commit()
>    |- find_first_extent_bit(unpin, 0, &start, &end, EXTENT_DIRTY);
>    |- btrfs_discard_extent()
>
> However pinned extents are recorded in an extent_io_tree, which can
> merge same extent states.

same -> adjacent
'same' would imply duplicate entries (same start offset and lengths)

>
> When a large file get deleted and it has adjacent file extents across
> block group boundary, we will get a large merged range.
>
> Then when we pass the large range into btrfs_discard_extent(),
> btrfs_discard_extent() will just trim the first part, without trimming
> the remaining part.
>
> Furthermore, this bug is not that reliably observed, as if the whole
> block group is empty, there will be another trim for that block group.
>
> So the most obvious way to find this missing trim needs to delete large
> extents at block group boundary without empting involved block groups.
>
> [FIX]
> Fix this bug by calling btrfs_map_block() in a loop, until we reach the
> end location.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

With that small change:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  fs/btrfs/extent-tree.c | 40 ++++++++++++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 49cb26fa7c63..45df45fa775b 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1306,8 +1306,10 @@ static int btrfs_issue_discard(struct block_device=
 *bdev, u64 start, u64 len,
>  int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
>                          u64 num_bytes, u64 *actual_bytes)
>  {
> -       int ret;
> +       int ret =3D 0;
>         u64 discarded_bytes =3D 0;
> +       u64 end =3D bytenr + num_bytes;
> +       u64 cur =3D bytenr;
>         struct btrfs_bio *bbio =3D NULL;
>
>
> @@ -1316,15 +1318,22 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs=
_info, u64 bytenr,
>          * associated to its stripes that don't go away while we are disc=
arding.
>          */
>         btrfs_bio_counter_inc_blocked(fs_info);
> -       /* Tell the block device(s) that the sectors can be discarded */
> -       ret =3D btrfs_map_block(fs_info, BTRFS_MAP_DISCARD, bytenr, &num_=
bytes,
> -                             &bbio, 0);
> -       /* Error condition is -ENOMEM */
> -       if (!ret) {
> -               struct btrfs_bio_stripe *stripe =3D bbio->stripes;
> +       while (cur < end) {
> +               struct btrfs_bio_stripe *stripe;
>                 int i;
>
> +               /* Tell the block device(s) that the sectors can be disca=
rded */
> +               ret =3D btrfs_map_block(fs_info, BTRFS_MAP_DISCARD, cur,
> +                                     &num_bytes, &bbio, 0);
> +               /*
> +                * Error can be -ENOMEM, -ENOENT (no such chunk mapping) =
or
> +                * -EOPNOTSUPP. For any such error, @num_bytes is not upd=
ated,
> +                * thus we can't continue anyway.
> +                */
> +               if (ret < 0)
> +                       goto out;
>
> +               stripe =3D bbio->stripes;
>                 for (i =3D 0; i < bbio->num_stripes; i++, stripe++) {
>                         u64 bytes;
>                         struct request_queue *req_q;
> @@ -1341,10 +1350,19 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs=
_info, u64 bytenr,
>                                                   stripe->physical,
>                                                   stripe->length,
>                                                   &bytes);
> -                       if (!ret)
> +                       if (!ret) {
>                                 discarded_bytes +=3D bytes;
> -                       else if (ret !=3D -EOPNOTSUPP)
> -                               break; /* Logic errors or -ENOMEM, or -EI=
O but I don't know how that could happen JDM */
> +                       } else if (ret !=3D -EOPNOTSUPP) {
> +                               /*
> +                                * Logic errors or -ENOMEM, or -EIO but I=
 don't
> +                                * know how that could happen JDM
> +                                *
> +                                * Ans since there are two loops, explici=
tly
> +                                * goto out to avoid confusion.
> +                                */
> +                               btrfs_put_bbio(bbio);
> +                               goto out;
> +                       }
>
>                         /*
>                          * Just in case we get back EOPNOTSUPP for some r=
eason,
> @@ -1354,7 +1372,9 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_i=
nfo, u64 bytenr,
>                         ret =3D 0;
>                 }
>                 btrfs_put_bbio(bbio);
> +               cur +=3D num_bytes;
>         }
> +out:
>         btrfs_bio_counter_dec(fs_info);
>
>         if (actual_bytes)
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
