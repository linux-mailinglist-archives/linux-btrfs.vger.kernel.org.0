Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADF2361CFF
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 12:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241340AbhDPJM2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 05:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241192AbhDPJM1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 05:12:27 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD36C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 02:12:02 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id c6so20307554qtc.1
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 02:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=k0HTeTRztA+DtT+jTnw0IJEUNTyYpY7EKx6Y2uEeAXA=;
        b=tbdKDEQml8DhbLujsnLKdrJC42F5mdBuvS3z44IxBRPCLGSYoYCYy2o7ZLOW+6yFnb
         5NJE0Nl6AJ88bJ2CsG/b+99Iv7vM1FrlYbG2317/pa2SexAkon8gBO8mmNHF04wQjsVV
         ICRkYh453O/mGXTaCDZeluBAFYQFRtg7ZU9V2VpK6E8QfDVBHt9rwfLWM4tJC7A5VJF+
         GJb/RzB9BcIGL/cT/juOb9KwYYzPEmQ3piu4gJA7Bd3BabQobdPxrWKv1raW17/BddVO
         lHFvz1Bua4v763KtbY0iW5S4zlyxw5AOkBX/GeM1TVv0OOdioD6h3wRRJgIKGEiTSWuB
         US1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=k0HTeTRztA+DtT+jTnw0IJEUNTyYpY7EKx6Y2uEeAXA=;
        b=OEunlF2aXe2RP4USWNkAbDfOc3zUbqLU8hTRxbP5gflVvlO16Maj1Uk4u1fT7XoWSo
         DWpxee3A7SO3MTL1+JF/GLZK/LQ2eLyvi5HDLB43Tc0M1PNJhk7whpiVKkZc+U+1Uaik
         lrvUuwQZY1xlXMlZoCG70dnFwLd3TYVnle7CgUxOlVB9ffulbOFMaFjv1W2t6fGJSawt
         FMwlvxAotWTSfunP2xYMCjmk6b7/0Fq0V7hSq/gs1fSWwAEG0SK064Bl3zwY52o8TBiS
         EPHfwlBsRESXULk8HSFXNBJ82b92oNnjDjdbNpyWRMD+9gyfjxmIJJgpZoCvhIgr4c3c
         ugwg==
X-Gm-Message-State: AOAM532vi1mm/KWXK3B63SDiHWE19fFnTOUSgopQfSoMz4ZXL2rtJ8qH
        8AwfD9ItP5bI1/1eyQgNGuWqK1TiV+yXjxnwWseVgFQ1goY=
X-Google-Smtp-Source: ABdhPJwJJjTLgToQWi2DEIvSdzFVfz9QUNeNRQLynoqXnprVu2O3um61t7p9M6/3gOZuvNPlN7GMpZKJBIXIYkHHPNE=
X-Received: by 2002:ac8:5e8e:: with SMTP id r14mr6952441qtx.213.1618564321593;
 Fri, 16 Apr 2021 02:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1618494550.git.johannes.thumshirn@wdc.com> <d3aec3e168a547dcc39a764f242d1df9d3489928.1618494550.git.johannes.thumshirn@wdc.com>
In-Reply-To: <d3aec3e168a547dcc39a764f242d1df9d3489928.1618494550.git.johannes.thumshirn@wdc.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 16 Apr 2021 10:11:50 +0100
Message-ID: <CAL3q7H4WKR4bamLij43gDL9RA9gREi_zNFME7LRqj7ex-YBLaw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] btrfs: zoned: reset zones of relocated block groups
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 15, 2021 at 3:00 PM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> When relocating a block group the freed up space is not discarded in one
> big block, but each extent is discarded on it's own with -odisard=3Dsync.
>
> For a zoned filesystem we need to discard the whole block group at once,
> so btrfs_discard_extent() will translate the discard into a
> REQ_OP_ZONE_RESET operation, which then resets the device's zone.
>
> Link: https://lore.kernel.org/linux-btrfs/459e2932c48e12e883dcfd3dda828d9=
da251d5b5.1617962110.git.johannes.thumshirn@wdc.com
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/volumes.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 6d9b2369f17a..b1bab75ec12a 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3103,6 +3103,7 @@ static int btrfs_relocate_chunk(struct btrfs_fs_inf=
o *fs_info, u64 chunk_offset)
>         struct btrfs_root *root =3D fs_info->chunk_root;
>         struct btrfs_trans_handle *trans;
>         struct btrfs_block_group *block_group;
> +       u64 length;
>         int ret;
>
>         /*
> @@ -3130,8 +3131,24 @@ static int btrfs_relocate_chunk(struct btrfs_fs_in=
fo *fs_info, u64 chunk_offset)
>         if (!block_group)
>                 return -ENOENT;
>         btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
> +       length =3D block_group->length;
>         btrfs_put_block_group(block_group);
>
> +       /*
> +        * Step two, delete the device extents and the chunk tree entries=
.
> +        *
> +        * On a zoned file system, discard the whole block group, this wi=
ll
> +        * trigger a REQ_OP_ZONE_RESET operation on the device zone. If
> +        * resetting the zone fails, don't treat it as a fatal problem fr=
om the
> +        * filesystem's point of view.
> +        */
> +       if (btrfs_is_zoned(fs_info)) {
> +               ret =3D btrfs_discard_extent(fs_info, chunk_offset, lengt=
h, NULL);
> +               if (ret)
> +                       btrfs_info(fs_info, "failed to reset zone %llu",
> +                                  chunk_offset);
> +       }
> +
>         trans =3D btrfs_start_trans_remove_block_group(root->fs_info,
>                                                      chunk_offset);
>         if (IS_ERR(trans)) {
> @@ -3140,10 +3157,6 @@ static int btrfs_relocate_chunk(struct btrfs_fs_in=
fo *fs_info, u64 chunk_offset)
>                 return ret;
>         }
>
> -       /*
> -        * step two, delete the device extents and the
> -        * chunk tree entries
> -        */

This hunk seems unrelated and unintentional.
Not that the comment adds any value, but if the removal was
intentional, I would suggest a separate patch for that.

Other than that, it looks good, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

>         ret =3D btrfs_remove_chunk(trans, chunk_offset);
>         btrfs_end_transaction(trans);
>         return ret;
> --
> 2.30.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
