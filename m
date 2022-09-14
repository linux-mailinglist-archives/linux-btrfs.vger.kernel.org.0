Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25C65B9050
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 23:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiINVy7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 17:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiINVy4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 17:54:56 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493CF1BEA4
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 14:54:55 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-12b542cb1d3so34999514fac.13
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 14:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date;
        bh=E94LtXjr5Gt/LA85Q3GvntdQ3/H7WaZAnIpnnFipIaE=;
        b=D1RvHnmgJYn+JYJPaO2Lpj9CE5j7GynQqjgnpHkF+LJLaRrObYMA5cCD41M7L1kLoV
         cBQmoYwVlYGkeEZLmghtwhxws5ZzaBdrcxabNo91qeYarhFT8VDAV5cVHDAIdo44K5+x
         sShA8ST784o2IhVPutpudGSWBIG9BmxkE5KTr4Aj7aOY1DawRgrqSsyh6uil5YVFDKH5
         dA/sI8bhM7x70j9fJn/rm5cjJcDgBpS+Bnd7xgYDu8y18PnlI0osPYvJ10z++SiUdzk3
         uLuQQcMJKZ8vNXR/NUeWbofbIbqlbAkCZ/1DH+e52N24XGqKHLyoqhESCbGvI0Tqmhn6
         5HmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=E94LtXjr5Gt/LA85Q3GvntdQ3/H7WaZAnIpnnFipIaE=;
        b=g0JQehQ/pveCvN1JdBEww4Fu9b8nx/XT9ZRgyKv7RKo6WA0SDb39nInTr0DDi0dzy4
         Pt9bt1A/IiPyh9as2IihLLTmO24L5QuxdrgAPK8YII6akWhqC0iWMAmxQz50/sCknoq5
         tj4jYI+UUhM9DIqt+Sf4MfRYhVsK2KdGTrhopYCkX+FVE4hbyWPormX67HdItT21LfQ8
         mzbMd4nUiXsV+UjbcuJa440ApiNcPbVwcaUzC1M7Dq5OP3qoBg/dEa2V2EfB82Nce5Ck
         JeuIWlQYiu9cLFpVYoRX7q+Z8StKnrCb0i1ehtqTW6SbDCAZzraJ7ixKvvHxR9isT3NS
         mqRA==
X-Gm-Message-State: ACgBeo3hRiFxIEOysjU724zxfTp9oDPpoRhcWGXEaV1JvlQ7uZYwecsK
        HIllpoaezja8CgNBq5i4zUtno7bUZXMgeFmlUbqVbP3h
X-Google-Smtp-Source: AA6agR5e/N1OW8aJWPyqtmEc2Ni/4aK4XTBZMZZv9SXvp9dH3M6B0G5g4LuqTAGLJ+9cN30+iRyJifCdP0f44Ne1NyU=
X-Received: by 2002:a05:6870:63a6:b0:12b:85ee:59ff with SMTP id
 t38-20020a05687063a600b0012b85ee59ffmr3679201oap.98.1663192494453; Wed, 14
 Sep 2022 14:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <17e7c38b0cc6fe90c90f4b383734c06eafd2f9b5.1660806386.git.wqu@suse.com>
In-Reply-To: <17e7c38b0cc6fe90c90f4b383734c06eafd2f9b5.1660806386.git.wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 14 Sep 2022 22:54:17 +0100
Message-ID: <CAL3q7H4=KkPc8HD6KuOR7KafaqcsBtKtgL08ub7fMM2pP-Vgbw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix the max chunk size and stripe length calculation
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 18, 2022 at 8:22 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BEHAVIOR CHANGE]
> Since commit f6fca3917b4d ("btrfs: store chunk size in space-info
> struct"), btrfs no longer can create larger data chunks than 1G:
>
>   mkfs.btrfs -f -m raid1 -d raid0 $dev1 $dev2 $dev3 $dev4
>   mount $dev1 $mnt
>
>   btrfs balance start --full $mnt
>   btrfs balance start --full $mnt
>   umount $mnt
>
>   btrfs ins dump-tree -t chunk $dev1 | grep "DATA|RAID0" -C 2
>
> Before that offending commit, what we got is a 4G data chunk:
>
>         item 6 key (FIRST_CHUNK_TREE CHUNK_ITEM 9492758528) itemoff 15491=
 itemsize 176
>                 length 4294967296 owner 2 stripe_len 65536 type DATA|RAID=
0
>                 io_align 65536 io_width 65536 sector_size 4096
>                 num_stripes 4 sub_stripes 1
>
> Now what we got is only 1G data chunk:
>
>         item 6 key (FIRST_CHUNK_TREE CHUNK_ITEM 6271533056) itemoff 15491=
 itemsize 176
>                 length 1073741824 owner 2 stripe_len 65536 type DATA|RAID=
0
>                 io_align 65536 io_width 65536 sector_size 4096
>                 num_stripes 4 sub_stripes 1
>
> This will increase the number of data chunks by the number of devices,
> not only increase system chunk usage, but also greatly increase mount
> time.
>
> Without a properly reason, we should not change the max chunk size.
>
> [CAUSE]
> Previously, we set max data chunk size to 10G, while max data stripe
> length to 1G.
>
> Commit f6fca3917b4d ("btrfs: store chunk size in space-info struct")
> completely ignored the 10G limit, but use 1G max stripe limit instead,
> causing above shrink in max data chunk size.
>
> [FIX]
> Fix the max data chunk size to 10G, and in decide_stripe_size_regular()
> we limit stripe_size to 1G manually.
>
> This should only affect data chunks, as for metadata chunks we always
> set the max stripe size the same as max chunk size (256M or 1G
> depending on fs size).
>
> Now the same script result the same old result:
>
>         item 6 key (FIRST_CHUNK_TREE CHUNK_ITEM 9492758528) itemoff 15491=
 itemsize 176
>                 length 4294967296 owner 2 stripe_len 65536 type DATA|RAID=
0
>                 io_align 65536 io_width 65536 sector_size 4096
>                 num_stripes 4 sub_stripes 1
>
> Reported-by: Wang Yugui <wangyugui@e16-tech.com>
> Fixes: f6fca3917b4d ("btrfs: store chunk size in space-info struct")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Btw, btrfs/253 now fails.
Probably needs to be updated after this patch.

Thanks.

> ---
>  fs/btrfs/space-info.c | 2 +-
>  fs/btrfs/volumes.c    | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 477e57ace48d..b74bc31e9a8e 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -199,7 +199,7 @@ static u64 calc_chunk_size(const struct btrfs_fs_info=
 *fs_info, u64 flags)
>         ASSERT(flags & BTRFS_BLOCK_GROUP_TYPE_MASK);
>
>         if (flags & BTRFS_BLOCK_GROUP_DATA)
> -               return SZ_1G;
> +               return BTRFS_MAX_DATA_CHUNK_SIZE;
>         else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
>                 return SZ_32M;
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 8c64dda69404..e0fd1aecf447 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5264,6 +5264,9 @@ static int decide_stripe_size_regular(struct alloc_=
chunk_ctl *ctl,
>                                        ctl->stripe_size);
>         }
>
> +       /* Stripe size should never go beyond 1G. */
> +       ctl->stripe_size =3D min_t(u64, ctl->stripe_size, SZ_1G);
> +
>         /* Align to BTRFS_STRIPE_LEN */
>         ctl->stripe_size =3D round_down(ctl->stripe_size, BTRFS_STRIPE_LE=
N);
>         ctl->chunk_size =3D ctl->stripe_size * data_stripes;
> --
> 2.37.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
