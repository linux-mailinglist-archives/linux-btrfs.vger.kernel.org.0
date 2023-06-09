Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D330B729BE5
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jun 2023 15:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjFINqw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jun 2023 09:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjFINqu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jun 2023 09:46:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B3030FD
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 06:46:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C3506503E
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 13:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2758C433EF
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 13:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686318407;
        bh=iFDDs1buwdj9cicj8XpxDEJorF+kCYT0TrcMUvcSQPs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WgT1LY0x1ISne4mo/FSV54WYdeLxUV6Lac3O1DksrdUfa/cMHHLG0OVz6ooq0RE2V
         ay5Vm4uTnhamixIoNgQHSk1ufy7VcGx1UfV6Eh5waQmInD6NDHUgufVR1TSII4+pbU
         nHcWCrmbHFbgkXqiwJogYkEE48ymgwykk5CJPHMk/D8r421LetqcvxS7NI8mN0TTcq
         lZr/1fEKKohhY0oA8BZMsOTfg/xkgLtLDMWqR15oDeseR0DmhOToZ4qZZCaTJoaFtp
         RIhTO2Ehk6Yj8T4VURO2+4MgU5TH5QJz6BlR2kw8EocMiysNjTE0LeNy4ZoSS9ty60
         svzn2sDg720sQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-55b3fe7a788so1096380eaf.2
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jun 2023 06:46:47 -0700 (PDT)
X-Gm-Message-State: AC+VfDzdOMtzwWtWe5tmD8nF7+gkvh9KXykVOd3F+3T9kZTPH3OWlp/y
        n0nGj5cGhjDRAFrgHlLnRyLCOZhmvTxWXyu6334=
X-Google-Smtp-Source: ACHHUZ7eFfkV3hzUD/HUML2JbSXWQzQxvR+nqScCwnL5mOEWuP5kujcy/TqdTehxlKKjOsC74R13qt4wvEXzLePtWzs=
X-Received: by 2002:a4a:ead4:0:b0:558:ae64:6533 with SMTP id
 s20-20020a4aead4000000b00558ae646533mr874402ooh.8.1686318406962; Fri, 09 Jun
 2023 06:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <sw3jkfih2ztq4jsjwmkfu3mh7msqvbfripxael24krfp3ablgw@tqwogynwdix6>
In-Reply-To: <sw3jkfih2ztq4jsjwmkfu3mh7msqvbfripxael24krfp3ablgw@tqwogynwdix6>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 9 Jun 2023 14:46:11 +0100
X-Gmail-Original-Message-ID: <CAL3q7H51jrPGPPFs6YrsonEd2BOnHSjEfwzDBOi5oYStxT-BbQ@mail.gmail.com>
Message-ID: <CAL3q7H51jrPGPPFs6YrsonEd2BOnHSjEfwzDBOi5oYStxT-BbQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: check if page is extent locked early during release
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org
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

On Fri, Jun 9, 2023 at 2:36=E2=80=AFPM Goldwyn Rodrigues <rgoldwyn@suse.de>=
 wrote:
>
> While performing release, check for locking is the last step performed
> in try_release_extent_state(). This happens after finding the em and
> decoupling the em from the page. try_release_extent_mapping() also
> checks if extents are locked.
>
> During memory pressure, it is better to return early if btrfs cannot
> release a page and skip all the extent mapping finding and decoupling.
> Check if page is locked in try_release_extent_mapping() before starting
> extent map resolution. If locked, return immediately with zero (cannot
> free page).

That is better if the most common case is having the range of the page
currently locked in the inode io tree.
Otherwise it's not better, we are doing one more search in the io tree
than before, and the io trees can get pretty big sometimes.

Last time I checked, several years ago for a different optimization,
most of the time, by far, the page's range is not currently locked.
When it was currently locked, it accounted for something like 1% or 2%
of the cases, and it mostly corresponded to the case where
writeback just finished and btrfs_finished_ordered_io() is running and
has already locked the range.

Have you made some analysis and found the case where the page's range
is already locked to be the most common case?
I doubt things changed radically to make it the most common case.

Do you have details of a workload that gains anything from this
change, or benchmark results?

>
> Move extent locked check from try_release_extent_state() to
> try_release_extent_mapping().
>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/extent_io.c | 43 ++++++++++++++++++++-----------------------
>  1 file changed, 20 insertions(+), 23 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index e5bec73b5991..5b49ef95c653 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2352,31 +2352,24 @@ static int try_release_extent_state(struct extent=
_io_tree *tree,
>  {
>         u64 start =3D page_offset(page);
>         u64 end =3D start + PAGE_SIZE - 1;
> -       int ret =3D 1;
> -
> -       if (test_range_bit(tree, start, end, EXTENT_LOCKED, 0, NULL)) {
> -               ret =3D 0;
> -       } else {
> -               u32 clear_bits =3D ~(EXTENT_NODATASUM |
> -                                  EXTENT_DELALLOC_NEW | EXTENT_CTLBITS);

So this depends on the previous patch you have submitted shortly
before this one.
When there's such dependency, it's best to make them part of the same patch=
set.

Thanks.

> +       int ret;
> +       u32 clear_bits =3D ~(EXTENT_NODATASUM |
> +                       EXTENT_DELALLOC_NEW | EXTENT_CTLBITS);
>
> -               /*
> -                * At this point we can safely clear everything except th=
e
> -                * locked bit, the nodatasum bit and the delalloc new bit=
.
> -                * The delalloc new bit will be cleared by ordered extent
> -                * completion.
> -                */
> -               ret =3D __clear_extent_bit(tree, start, end, clear_bits, =
NULL, NULL);
> +       /*
> +        * At this point we can safely clear everything except the
> +        * locked bit, the nodatasum bit and the delalloc new bit.
> +        * The delalloc new bit will be cleared by ordered extent
> +        * completion.
> +        */
> +       ret =3D __clear_extent_bit(tree, start, end, clear_bits, NULL, NU=
LL);
>
> -               /* if clear_extent_bit failed for enomem reasons,
> -                * we can't allow the release to continue.
> -                */
> -               if (ret < 0)
> -                       ret =3D 0;
> -               else
> -                       ret =3D 1;
> -       }
> -       return ret;
> +       /* if clear_extent_bit failed for enomem reasons,
> +        * we can't allow the release to continue.
> +        */
> +       if (ret < 0)
> +               return 0;
> +       return 1;
>  }
>
>  /*
> @@ -2393,6 +2386,9 @@ int try_release_extent_mapping(struct page *page, g=
fp_t mask)
>         struct extent_io_tree *tree =3D &btrfs_inode->io_tree;
>         struct extent_map_tree *map =3D &btrfs_inode->extent_tree;
>
> +       if (test_range_bit(tree, start, end, EXTENT_LOCKED, 0, NULL))
> +               return 0;
> +
>         if (gfpflags_allow_blocking(mask) &&
>             page->mapping->host->i_size > SZ_16M) {
>                 u64 len;
> @@ -2413,6 +2409,7 @@ int try_release_extent_mapping(struct page *page, g=
fp_t mask)
>                                 free_extent_map(em);
>                                 break;
>                         }
> +                       /* Check if entire range is not locked */
>                         if (test_range_bit(tree, em->start,
>                                            extent_map_end(em) - 1,
>                                            EXTENT_LOCKED, 0, NULL))
> --
> 2.40.1
>
>
> --
> Goldwyn
