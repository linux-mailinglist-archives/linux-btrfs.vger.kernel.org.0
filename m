Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77252347766
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Mar 2021 12:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhCXLay (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Mar 2021 07:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCXLaZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Mar 2021 07:30:25 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DBCC061763;
        Wed, 24 Mar 2021 04:30:25 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id j7so17225892qtx.5;
        Wed, 24 Mar 2021 04:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=1NwD+D09MxNMkHHIjKoYtWYoeiPO6llKDF7IfnR4kj8=;
        b=CHXscW1Vtic/hwNvX57CkIQfkxFGzPz1kKvVehJw8RA6mFUCNa9bQQVZ47GhJOsMIT
         WVN8ffqRc1kMFApqCmIH55EdS29+2gdZ0sMsT2fybCE2diCDUHZTHn20qWieXDmNVqMU
         f6w01Hs1whm2Tm/g+aYsLamaX/JlRC+nDFqwUgbxjftn3a52aM+G7beR0SvOdxXbYnzh
         PESVmkiFyOucuMyx0zGRai7AIZjkimSkJlWwFX0gueLsjRf4lnpbU14ihmX2v8d+VlMD
         oyjDXdgsCyTYlIQYilBmOBQHHnhZAdzLlsuEM7FRYASBliJxWj6oydKB1CPeeXqtXifn
         TwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=1NwD+D09MxNMkHHIjKoYtWYoeiPO6llKDF7IfnR4kj8=;
        b=m37zFJekod9O1ilDlfmqQeep6ORcnTaM4a9PXNk4oAhGz+aU/tA5zQwUB6MjUFDp+7
         ZWRWVQrfrFMQyPMeNtv/1u2OisnKN+3+PB16UmahFRw3uE/37qiGVS/YFL12MmO8CSYn
         COeAj/6CKI1e9HqQGfy1dNEi7lIjR2EBgD4XA5LdNxOXDqWh7mpwvDnjQyZUrPKpesk5
         8pikEQmJctHIKeBUlM4ahtdCHsTonSguHFdpLe4Bu0avW5fWGWwW23i9aRzVShxkk9Um
         Taz09IMgJv5YEeuMfYRW3Cj8qdrAPgHTqpwT46FQNaYo2Xut9WgD8QHBN8j34BleXrIt
         lrrQ==
X-Gm-Message-State: AOAM531KrTwnBx9AKSfs+qGnjj6P/XV/ZTbPKHPv33DdyECPJCARh4rs
        98f756uHPMpnZRN2H2R50cK6CCbsHcIy5KFfVxXvMaMCKkU=
X-Google-Smtp-Source: ABdhPJxh9O1xF11jsgRuSYRADzQ0QHd9acdPE8xzHFVhOn5mBkxhpYdORQSJP+Xc7wrkAmhhtzBmDn9gfASsHImTgXg=
X-Received: by 2002:ac8:4e86:: with SMTP id 6mr2449035qtp.213.1616585424116;
 Wed, 24 Mar 2021 04:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <1616578270-7365-1-git-send-email-bingjingc@synology.com>
In-Reply-To: <1616578270-7365-1-git-send-email-bingjingc@synology.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 24 Mar 2021 11:30:12 +0000
Message-ID: <CAL3q7H7YGA0PFJp6J7vFvK0EPSixY7chnReS6Zbqa_9S2p_QRQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix a potential hole-punching failure
To:     bingjingc <bingjingc@synology.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Qu Wenruo <quwenruo@cn.fujitsu.com>, Chris Mason <clm@fb.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cccheng@synology.com, Robbie Ko <robbieko@synology.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 24, 2021 at 11:15 AM bingjingc <bingjingc@synology.com> wrote:
>
> From: BingJing Chang <bingjingc@synology.com>
>
> In commit d77815461f04 ("btrfs: Avoid trucating page or punching hole in
> a already existed hole."), existed holes can be skipped by calling
> find_first_non_hole() to adjust *start and *len. However, if the given
> len is invalid and large, when an EXTENT_MAP_HOLE extent is found, the
> *len will not be set to zero because (em->start + em->len) is less than
> (*start + *len). Then the ret will be 1 but the *len will not be set to
> 0. The propagated non-zero ret will result in fallocate failure.
>
> In the while-loop of btrfs_replace_file_extents(), len is not updated
> every time before it calls find_first_non_hole(). That is, if the last
> file extent in the given hole-punching range has been dropped but
> btrfs_drop_extents() fails with -ENOSPC (btrfs_drop_extents() runs out
> of reserved space of the given transaction), the problem can happen.

This is not entirely clear. Dropping the last extent and still
returning ENOSPC is confusing.
I think you mean that it drops the last file extent item that does not
represent hole (disk_bytenr > 0), and after it there's only one file
extent item representing a hole (disk_bytenr =3D=3D 0).
It fails with -ENOSPC when attempting to drop the file extent item
representing the hole, after successfully dropping the non-hole file
extent item.
Is that it?

> After it calls find_first_non_hole(), the cur_offset will be adjusted
> to be larger than or equal to end. However, since the len is not set to
> zero. The break-loop condition (ret && !len) will not meet. After it
> leaves the while-loop, uncleared ret will result in fallocate failure.

Ok, fallocate will return 1, an unexpected return value.

>
> We're not able to construct a reproducible way to let
> btrfs_drop_extents() fails with -ENOSPC after it drops the last file
> extent but with remaining holes. However, it's quite easy to fix. We
> just need to update and check the len every time before we call
> find_first_non_hole(). To make the while loop more readable, we also
> pull the variable updates to the bottom of loop like this:
> while (cur_offset < end) {
>         ...
>         // update cur_offset & len
>         // advance cur_offset & len in hole-punching case if needed
> }
>
> Reported-by: Robbie Ko <robbieko@synology.com>
> Fixes: d77815461f04 ("btrfs: Avoid trucating page or punching hole in a
> already existed hole.")
> Reviewed-by: Robbie Ko <robbieko@synology.com>
> Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
> Signed-off-by: BingJing Chang <bingjingc@synology.com>

Looks good.
Please just update that paragraph to be more clear about what is going on.

Thanks.

> ---
>  fs/btrfs/file.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 0e155f0..dccb017 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2735,8 +2735,6 @@ int btrfs_replace_file_extents(struct inode *inode,=
 struct btrfs_path *path,
>                         extent_info->file_offset +=3D replace_len;
>                 }
>
> -               cur_offset =3D drop_args.drop_end;
> -
>                 ret =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
>                 if (ret)
>                         break;
> @@ -2756,7 +2754,9 @@ int btrfs_replace_file_extents(struct inode *inode,=
 struct btrfs_path *path,
>                 BUG_ON(ret);    /* shouldn't happen */
>                 trans->block_rsv =3D rsv;
>
> -               if (!extent_info) {
> +               cur_offset =3D drop_args.drop_end;
> +               len =3D end - cur_offset;
> +               if (!extent_info && len) {
>                         ret =3D find_first_non_hole(BTRFS_I(inode), &cur_=
offset,
>                                                   &len);
>                         if (unlikely(ret < 0))
> --
> 2.7.4
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
