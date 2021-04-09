Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2935B359D87
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Apr 2021 13:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhDILhc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Apr 2021 07:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDILhb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Apr 2021 07:37:31 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261D5C061760
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Apr 2021 04:37:19 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id h7so3886972qtx.3
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Apr 2021 04:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Afm/a4t7gYXRFobyWi/OY9CMGxUjyrC2Dz9xHQz4ypI=;
        b=u3Y73EFNMux+f4F1Ct2NuuBRfxmbzRwlPeiMQKw5ZY0+vnSXaMKRfartG9Ob70DIoQ
         QYngAdVabD7PrTlVLFvvSh2XWyAiDJoH06HdE/QKY5nHnqs/JKLeG3slx1bDcGLkCCYs
         R7Ljj3cdmr0fWdnHfgfdzMddDQ2vJrlhBKVp4HoWu6zLqZeCHxZcPoI2njZF+bAmeXqa
         hBKFawcxJVNKQGoNyj/3ICWHxTMcgK+m9zr/ZKQdYxzwO0wWn9+cVUF16v/HGXDwAXKM
         ZiuPrmqw7SnlmV50UNYjQwMgydp/T6MskavLVRiHNODIgzJ52GXSOtNJr/FiKow1Ajiv
         kR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Afm/a4t7gYXRFobyWi/OY9CMGxUjyrC2Dz9xHQz4ypI=;
        b=tMNH8SA2ve2bYTWMILO1bxcRW7Z4JcOluz/tbC12Tf61qzANhZY3nOGs3P38QDGqMw
         KWKlByPDRRZeyqW32rwI2Sg/NAycyVhl11f1VOwOXXm59bp4e6JSfscAn5UnpfHCn3AN
         7Ulx9GO208uV96r6WYjrDdFPS/lY/ANFAHQX/IM2LDRN7WgX3YNLcmM/hVmovfAVPONH
         YuxajuJYmG5t/24RyXaT/awFbMxB4fYawe9OLqiCG15vjUULqSedf6gIQ6iUcQ13/mGH
         uvE2Jeomx71HIsfuCaPcpmroNwqSFyaugJfPqkAXnp1xX/S1ht56b/O7fbWmPl32L9fO
         4KiQ==
X-Gm-Message-State: AOAM533z7ZO6gHSnvk01NXHYAjUY4O40jDOnsb48ri/S5fNS4OT/xfTb
        vhiDlGOWJFgugSGY2IcrXKGPlLd0xylsQL1BdLyVWy7jsAn9Vw==
X-Google-Smtp-Source: ABdhPJzXhmZoQKqhb7+kCMUzb5Fg8Rh1p97Ug0rvxqk9I7pjEV1fTaOJwEaWywOnRD/36j2bjoAaJ7X4ciUO+UlaXHI=
X-Received: by 2002:ac8:1246:: with SMTP id g6mr12039191qtj.183.1617968238400;
 Fri, 09 Apr 2021 04:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617962110.git.johannes.thumshirn@wdc.com> <459e2932c48e12e883dcfd3dda828d9da251d5b5.1617962110.git.johannes.thumshirn@wdc.com>
In-Reply-To: <459e2932c48e12e883dcfd3dda828d9da251d5b5.1617962110.git.johannes.thumshirn@wdc.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 9 Apr 2021 12:37:07 +0100
Message-ID: <CAL3q7H4SjS_d5rBepfTMhU8Th3bJzdmyYd0g4Z60yUgC_rC_ZA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] btrfs: discard relocated block groups
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

On Fri, Apr 9, 2021 at 11:54 AM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> When relocating a block group the freed up space is not discarded. On
> devices like SSDs this hint is useful to tell the device the space is
> freed now. On zoned block devices btrfs' discard code will reset the zone
> the block group is on, freeing up the occupied space.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/volumes.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 6d9b2369f17a..d9ef8bce0cde 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3103,6 +3103,10 @@ static int btrfs_relocate_chunk(struct btrfs_fs_in=
fo *fs_info, u64 chunk_offset)
>         struct btrfs_root *root =3D fs_info->chunk_root;
>         struct btrfs_trans_handle *trans;
>         struct btrfs_block_group *block_group;
> +       const bool trim =3D btrfs_is_zoned(fs_info) ||
> +                               btrfs_test_opt(fs_info, DISCARD_SYNC);
> +       u64 trimmed;
> +       u64 length;
>         int ret;
>
>         /*
> @@ -3130,6 +3134,7 @@ static int btrfs_relocate_chunk(struct btrfs_fs_inf=
o *fs_info, u64 chunk_offset)
>         if (!block_group)
>                 return -ENOENT;
>         btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
> +       length =3D block_group->length;
>         btrfs_put_block_group(block_group);
>
>         trans =3D btrfs_start_trans_remove_block_group(root->fs_info,
> @@ -3144,6 +3149,14 @@ static int btrfs_relocate_chunk(struct btrfs_fs_in=
fo *fs_info, u64 chunk_offset)
>          * step two, delete the device extents and the
>          * chunk tree entries
>          */
> +       if (trim) {
> +               ret =3D btrfs_discard_extent(fs_info, chunk_offset, lengt=
h,
> +                                          &trimmed);

Ideally we do IO and potentially slow operations such as discard while
not holding a transaction handle open, to avoid slowing down anyone
trying to commit the transaction.

> +               if (ret) {
> +                       btrfs_abort_transaction(trans, ret);

This is leaking the transaction, still need to call btrfs_end_transaction()=
.

Making the discard before joining/starting transaction, would fix both thin=
gs.

Now more importantly, I don't see why the freed space isn't already
discarded at this point.
Relocation creates delayed references to drop extents from the block
group, and when the delayed references are run, we pin the extents
through:

__btrfs_free_extent() -> btrfs_update_block_group()

Then at the very end of the transaction commit, we discard pinned
extents and then unpin them, at btrfs_finish_extent_commit().
Relocation commits the transaction at the end of
relocate_block_group(), so the delayed references are fun, and then we
discard and unpin their extents.
So that's why I don't get it why the discard is needed here (at least
when we are not on a zoned filesystem).

Thanks.




> +                       return ret;
> +               }
> +       }
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
