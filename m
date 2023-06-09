Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E2F72A0BA
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jun 2023 18:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjFIQ4l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jun 2023 12:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFIQ4k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jun 2023 12:56:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA033A8C
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 09:56:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF4A46596B
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 16:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25980C4339C
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 16:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686329798;
        bh=YXa9x6j5/b46HIdZVJoh0tJ1NQxYqmp5CZOM6doAVUI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nUUBP8fFQReBKvdADne1O8swxDUB1bkedvMo8g3X2DL35tJLFHKymBDVlkcVqbpmh
         zGPAiUBXyTyzHLmtmg1QvcO0dwxaQbdP7JJT55xHmzfOrk/vf+2waA9hIY1O90z6Mh
         YxKOmQQBEI424XxG1XHn/bFQdoI+TXmpCfGjW0tquwvYS5k3HTd8ew5+Xye1Xaf5PN
         GjXUsUdmMZEoqZ7wmvJhtCv8wSfq0cFFRhfO+4l3bj+qxwlHe3fnCRSjHsfd+L/SgW
         ibPh2iXCxRLuipJpBoWmXKU/cCFRMX9/Mbo8fh76xh+gn9N5IV1bA+SbmgnW2UTLAF
         loDo1iEfC3cow==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-558c8a109bdso1938003eaf.1
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jun 2023 09:56:38 -0700 (PDT)
X-Gm-Message-State: AC+VfDwNwFADmmuG7iv2bZIATQZ1Gil8KLDJ9KcihbAv0eozH1UK/sqX
        FHSnjv0PJPxY0p7QBMiYNBRtDqgtrrh2LOyDiDo=
X-Google-Smtp-Source: ACHHUZ5bQVA217WghFshwsb95M3QinoLMkA5eOcepz35RHyQgjL+fcJxO+OQdfqBJzsi7X5dAT8vVMzbM7LlBRAlIQk=
X-Received: by 2002:aca:db83:0:b0:39a:7233:3340 with SMTP id
 s125-20020acadb83000000b0039a72333340mr3110397oig.23.1686329797293; Fri, 09
 Jun 2023 09:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230608091025.104716-1-hch@lst.de>
In-Reply-To: <20230608091025.104716-1-hch@lst.de>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 9 Jun 2023 17:56:01 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7YWKfdyWEyKRFwtV5WCV3p6cuJ2+jJKwEWujfi8Ax5LA@mail.gmail.com>
Message-ID: <CAL3q7H7YWKfdyWEyKRFwtV5WCV3p6cuJ2+jJKwEWujfi8Ax5LA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix iomap_begin length for nocow writes
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        nborisov@suse.com, linux-btrfs@vger.kernel.org,
        syzbot+ee90502d5c8fd1d0dd93@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 8, 2023 at 10:46=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> can_nocow_extent can reduce the len passed in, which needs to be
> propagated to btrfs_dio_iomap_begin so that iomap does not submit
> more data then is mapped.
>
> This problems exists since the btrfs_get_blocks_direct helper was added
> in commit c5794e51784a ("btrfs: Factor out write portion of
> btrfs_get_blocks_direct"), but the ordered_extent splitting added in
> commit b73a6fd1b1ef ("btrfs: split partial dio bios before submit")
> added a WARN_ON that made a syzcaller test fail.
>
> Fixes: c5794e51784a ("btrfs: Factor out write portion of btrfs_get_blocks=
_direct")
> Reported-by: syzbot+ee90502d5c8fd1d0dd93@syzkaller.appspotmail.com
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: syzbot+ee90502d5c8fd1d0dd93@syzkaller.appspotmail.com

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good to me, thanks.

> ---
>  fs/btrfs/inode.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 19c707bc8801a9..3f99f02dc1fe20 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7264,7 +7264,7 @@ static struct extent_map *create_io_em(struct btrfs=
_inode *inode, u64 start,
>  static int btrfs_get_blocks_direct_write(struct extent_map **map,
>                                          struct inode *inode,
>                                          struct btrfs_dio_data *dio_data,
> -                                        u64 start, u64 len,
> +                                        u64 start, u64 *lenp,
>                                          unsigned int iomap_flags)
>  {
>         const bool nowait =3D (iomap_flags & IOMAP_NOWAIT);
> @@ -7275,6 +7275,7 @@ static int btrfs_get_blocks_direct_write(struct ext=
ent_map **map,
>         struct btrfs_block_group *bg;
>         bool can_nocow =3D false;
>         bool space_reserved =3D false;
> +       u64 len =3D *lenp;
>         u64 prev_len;
>         int ret =3D 0;
>
> @@ -7345,15 +7346,19 @@ static int btrfs_get_blocks_direct_write(struct e=
xtent_map **map,
>                 free_extent_map(em);
>                 *map =3D NULL;
>
> -               if (nowait)
> -                       return -EAGAIN;
> +               if (nowait) {
> +                       ret =3D -EAGAIN;
> +                       goto out;
> +               }
>
>                 /*
>                  * If we could not allocate data space before locking the=
 file
>                  * range and we can't do a NOCOW write, then we have to f=
ail.
>                  */
> -               if (!dio_data->data_space_reserved)
> -                       return -ENOSPC;
> +               if (!dio_data->data_space_reserved) {
> +                       ret =3D -ENOSPC;
> +                       goto out;
> +               }
>
>                 /*
>                  * We have to COW and we have already reserved data space=
 before,
> @@ -7394,6 +7399,7 @@ static int btrfs_get_blocks_direct_write(struct ext=
ent_map **map,
>                 btrfs_delalloc_release_extents(BTRFS_I(inode), len);
>                 btrfs_delalloc_release_metadata(BTRFS_I(inode), len, true=
);
>         }
> +       *lenp =3D len;
>         return ret;
>  }
>
> @@ -7570,7 +7576,7 @@ static int btrfs_dio_iomap_begin(struct inode *inod=
e, loff_t start,
>
>         if (write) {
>                 ret =3D btrfs_get_blocks_direct_write(&em, inode, dio_dat=
a,
> -                                                   start, len, flags);
> +                                                   start, &len, flags);
>                 if (ret < 0)
>                         goto unlock_err;
>                 unlock_extents =3D true;
> --
> 2.39.2
>
