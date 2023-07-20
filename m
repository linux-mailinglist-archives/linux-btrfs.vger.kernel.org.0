Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AD075B3F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 18:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjGTQP7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 12:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjGTQPx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 12:15:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC57910D2;
        Thu, 20 Jul 2023 09:15:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 506ED61B50;
        Thu, 20 Jul 2023 16:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DA7C433CB;
        Thu, 20 Jul 2023 16:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689869750;
        bh=TPAunApq8i+SUaaLwE46mDZ/trLDSerwE/ZkljV1r8k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZDJHFFIUC34apAn8IgrUn1PPm61Jv6ZFkvi0V9I53Tp94QK90+YfXJ54x3zJ/8TRA
         tnwnPOJRItt/3M+BqVVgpWd0b5EgYrW0/OvuQ0KF1sLc385RNNH2mb5PkrcVwxRzF+
         l3hCIku24/+eGUIu0YtJWYDGAm8mU1vKpRSjcAb5/6dwBW8kRPKs8EqdoldtRgZMA8
         dUO67b/CVAZCWFVwWJBCphX5xU7hrsXm/lP0vo+z+qpi1XdC5esXBxZBNFq4H9+jDr
         t5jibgRKeqheE2Kx09vOOM3yPQSocBYmpcSYbSIT+uVUhcRGOWlBUN/ybFRf32CcON
         0cF5jtRCRd+CA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1b06777596cso733111fac.2;
        Thu, 20 Jul 2023 09:15:50 -0700 (PDT)
X-Gm-Message-State: ABy/qLZ2A+jHbaqN2d9xKHUj5sRgcAV5snYjq3NiCeNO9l3L3I1SkBiH
        91IAfYQTthIUAsfr5yMSLD+yRRaD1iqi1MYxqrw=
X-Google-Smtp-Source: APBJJlEiaQlTKd5g+UpnfHBh261BQ2QMdQYb2zRGnMv3+Lbkdp8uqGz/KOt7wrsVyT+nkHnWNRjJ8u/LoPW3otkwhoY=
X-Received: by 2002:a05:6870:3929:b0:1ba:989b:ca65 with SMTP id
 b41-20020a056870392900b001ba989bca65mr2442801oap.19.1689869749868; Thu, 20
 Jul 2023 09:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230720134123.13148-1-lhenriques@suse.de>
In-Reply-To: <20230720134123.13148-1-lhenriques@suse.de>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 20 Jul 2023 17:15:13 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4uqXttKMCucHH=tJDYkxOFuNRGR04ZSBD7eBMj4BE1iA@mail.gmail.com>
Message-ID: <CAL3q7H4uqXttKMCucHH=tJDYkxOFuNRGR04ZSBD7eBMj4BE1iA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: propagate error from function unpin_extent_cache()
To:     =?UTF-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 20, 2023 at 5:05=E2=80=AFPM Lu=C3=ADs Henriques <lhenriques@sus=
e.de> wrote:
>
> Function unpin_extent_cache() doesn't propagate an error if the call to
> lookup_extent_mapping() fails.  This patch adds an error return (EINVAL)
> and simply logs it in the only caller.
>
> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
> ---
> Hi!
>
> As per David and Johannes reviews, I'm now proposing a different approach=
.
> Note that I kept the WARN_ON() instead of replacing it by an ASSERT().  I=
n
> fact, I considered removing the WARN_ON() completely and simply return th=
e
> error if em->start !=3D start.  But I guess it may useful for debug.
>
> Changes since v1:
> Instead of changing unpin_extent_cache() into a void function, make it
> propage an error code instead.
>
>  fs/btrfs/extent_map.c | 4 +++-
>  fs/btrfs/inode.c      | 8 ++++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 0cdb3e86f29b..f4e7956edc05 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -304,8 +304,10 @@ int unpin_extent_cache(struct extent_map_tree *tree,=
 u64 start, u64 len,
>
>         WARN_ON(!em || em->start !=3D start);
>
> -       if (!em)
> +       if (!em) {
> +               ret =3D -EINVAL;
>                 goto out;
> +       }
>
>         em->generation =3D gen;
>         clear_bit(EXTENT_FLAG_PINNED, &em->flags);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index dbbb67293e34..21eb66fcc0df 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3273,8 +3273,12 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_=
extent *ordered_extent)
>                                                 ordered_extent->disk_num_=
bytes);
>                 }
>         }
> -       unpin_extent_cache(&inode->extent_tree, ordered_extent->file_offs=
et,
> -                          ordered_extent->num_bytes, trans->transid);
> +
> +       /* Proceed even if we fail to unpin extent from cache */
> +       if (unpin_extent_cache(&inode->extent_tree, ordered_extent->file_=
offset,
> +                              ordered_extent->num_bytes, trans->transid)=
 < 0)
> +               btrfs_warn(fs_info, "failed to unpin extent from cache");

Well, this is not very useful. It doesn't provide any more useful
information than what we get from the WARN_ON() at
unpin_extent_cache(), making the patch not useful.

This warning has actually happened a few times when running fstests
that exercise relocation (not sure if it's gone and accidently fixed
by something recently).
But to make this more useful, I would place the message at
unpin_extent_cache() with useful information such as:

- inode number
- id of the root the inode belongs to
- the file offset (the start argument) and extent length (or end offset)
- why the warning triggered: we didn't find the extent map or we found
one with a different start offset
- if we found an unexpected extent map, dump its flags (so we can see
if it happens only with compressed or prealloc extents for e.g.) and
other details (length/end offset for e.g.)

Thanks.

> +
>         if (ret < 0) {
>                 btrfs_abort_transaction(trans, ret);
>                 goto out;
