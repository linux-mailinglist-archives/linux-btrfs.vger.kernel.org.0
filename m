Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA8E1D3122
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 May 2020 15:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgENNU6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 May 2020 09:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726011AbgENNU6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 May 2020 09:20:58 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72BAC061A0C
        for <linux-btrfs@vger.kernel.org>; Thu, 14 May 2020 06:20:57 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id z3so92435vka.10
        for <linux-btrfs@vger.kernel.org>; Thu, 14 May 2020 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Hwb7F/rC2WcHIU0TqB0pyaDR8cULaRfYzo6HxdYb+h8=;
        b=NvwLocQRGudU61Jl7dRbuG56faPz75HaLgBBhSBW6sGcd6dG9PS/T+wHnuZM4yJwXx
         qRYsdeedLA8TIuw/v9OuWe2VKICfVr0nVmS5jrb3YhjcfAl2RbbxUtGwktYBxVZcolni
         bFItEhSrwBVqVzOEXXCVQtq22YgC9LAndCr+KH03qF3SpaFlS23mzW2uo/Gnu9ObTTwp
         7f6aj2wYaOPrbHy/EgXTxH733bAnUnKIRVEKI5icsiF1VSXZkGD+vrQqyoinYY2Mz8Ps
         YJppWdOQbU30mUpj1cZnnw7mCn99u/uyq+uwS66+s3UGRYOY9dZMMFpl+zV/yrkmKMOi
         c0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Hwb7F/rC2WcHIU0TqB0pyaDR8cULaRfYzo6HxdYb+h8=;
        b=KAvOjlxgE67dC6AWeJoAoJozC0BEz/UM5MUTJn/1yo8DG/exfcpuyb/KMwFRbxXLuj
         GtujDmfh9wts87D+0pkK/9GX7UHgbcvKiQRmEu5uaAXlZU/R8K02PD+weu8Pk8LUUD5I
         NalVvBL6nXWc7KEYfX9sD1f8ENdpft7G9AZvVox7zSgroWjPiJJa2sTTrtCUyk0S1pBc
         3tusWAHH7VHkD2H/E5kIzp3rSVcQvZpLlwAS9hBaYGVjN2SZsO4uEA/3kGFfRCPD4xN0
         anFg+1SuRHPxm+3pQKgnPaTDpJ3c4DDrlImk7GcD9alqf1hvw08KzA4G7uUqJSdu4nzK
         Ld0g==
X-Gm-Message-State: AOAM530EhTwSrgnlXMDsrL/khKReVr8+4aNnP2zXJI560Y+BQaXz8eOt
        nHNP+JLwj4h+EPwuX7LGeu5Dj0iTw5blfa0T/tHwbw==
X-Google-Smtp-Source: ABdhPJxxQLkTBcrYHtm3daG6b5pe6ssqDwbrY7q4r4ICiRgkXN7IEewFTNwf2gj/pZBxWq3X8OIP/ZqJohViY2qxdrA=
X-Received: by 2002:a1f:3485:: with SMTP id b127mr3330259vka.69.1589462456914;
 Thu, 14 May 2020 06:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200514073325.33343-1-wqu@suse.com> <20200514073325.33343-3-wqu@suse.com>
In-Reply-To: <20200514073325.33343-3-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 14 May 2020 14:20:46 +0100
Message-ID: <CAL3q7H701a1eK9rfuZHnRitPNae4vG0DzXK-s86GUMQX0QwQQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] btrfs: inode: Cleanup the log tree exceptions in btrfs_truncate_inode_items()
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 14, 2020 at 8:35 AM Qu Wenruo <wqu@suse.com> wrote:
>
> There are a lot of root owner check in btrfs_truncate_inode_items()
> like:
>
>         if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
>             root =3D=3D fs_info->tree_root)
>
> But considering that, there are only those trees can have INODE_ITEMs:
> - tree root (For v1 space cache)
> - subvolume trees
> - tree reloc trees
> - data reloc tree
> - log trees
>
> And since subvolume/tree reloc/data reloc trees all have SHAREABLE bit,
> and we're checking tree root manually, so above check is just excluding
> log trees.
>
> This patch will replace two of such checks to a much simpler one:
>
>         if (root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID)
>
> This would merge btrfs_drop_extent_cache() and lock_extent_bits() call
> into the same if branch.
>
> Also since we're here, add one comment explaining why we don't want to
> call lock_extent_bits()/drop_extent_cache() on log trees.
>
> Finally replace ALIGN()/ALIGN_DOWN() to round_up()/round_down(), as I'm
> always bad at determing the alignement direction.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index a6c26c10ffc5..771af55038bf 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4101,7 +4101,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_h=
andle *trans,
>         u64 bytes_deleted =3D 0;
>         bool be_nice =3D false;
>         bool should_throttle =3D false;
> -       const u64 lock_start =3D ALIGN_DOWN(new_size, fs_info->sectorsize=
);
> +       const u64 lock_start =3D round_down(new_size, fs_info->sectorsize=
);

Hum, seriously? Why does ALIGN_DOWN confuses you? ALIGN, means to
align, and the DOWN part is very explicit about the direction.

>         struct extent_state *cached_state =3D NULL;
>
>         BUG_ON(new_size > 0 && min_type !=3D BTRFS_EXTENT_DATA_KEY);
> @@ -4121,20 +4121,22 @@ int btrfs_truncate_inode_items(struct btrfs_trans=
_handle *trans,
>                 return -ENOMEM;
>         path->reada =3D READA_BACK;
>
> -       if (root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID)
> -               lock_extent_bits(&BTRFS_I(inode)->io_tree, lock_start, (u=
64)-1,
> -                                &cached_state);
> -
>         /*
> -        * We want to drop from the next block forward in case this new s=
ize is
> -        * not block aligned since we will be keeping the last block of t=
he
> -        * extent just the way it is.
> +        * There will be a lot of exceptions for log trees, as log inodes=
 are
> +        * not real inodes, but an anchor for logged inodes.

This is a very confusing sentence, you're saying logged inodes are an
"anchor" (whatever that means) to themselves.
Either leave nothing as it was, or just say log tree operations aren't
supposed to change anything on the inodes.

Thanks.

>          */
> -       if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
> -           root =3D=3D fs_info->tree_root)
> -               btrfs_drop_extent_cache(BTRFS_I(inode), ALIGN(new_size,
> +       if (root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID) {
> +               /*
> +                * We want to drop from the next block forward in case th=
is
> +                * new size is not block aligned since we will be keeping=
 the
> +                * last block of the extent just the way it is.
> +                */
> +               lock_extent_bits(&BTRFS_I(inode)->io_tree, lock_start, (u=
64)-1,
> +                                &cached_state);
> +               btrfs_drop_extent_cache(BTRFS_I(inode), round_up(new_size=
,
>                                         fs_info->sectorsize),
>                                         (u64)-1, 0);
> +       }
>
>         /*
>          * This function is also used to drop the items in the log tree b=
efore
> @@ -4335,8 +4337,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_h=
andle *trans,
>                 should_throttle =3D false;
>
>                 if (found_extent &&
> -                   (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
> -                    root =3D=3D fs_info->tree_root)) {
> +                   root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID)=
 {
>                         struct btrfs_ref ref =3D { 0 };
>
>                         bytes_deleted +=3D extent_num_bytes;
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
