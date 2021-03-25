Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A76348D79
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 10:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhCYJz6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 05:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCYJzd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 05:55:33 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F7CC06174A;
        Thu, 25 Mar 2021 02:55:33 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id v70so1116012qkb.8;
        Thu, 25 Mar 2021 02:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=RrZqSUgV0o2n+fC0ATR2Inwg8tiJ8Mrky0FeiVi+KiM=;
        b=rBwT8ok5vLPaKX3Wj0F4xnAOyDCodRRIM9F399QnknLuMLa58h6KCi4DQPUXD3OoEI
         LeAmDiYQjJhF/BjsUbsQWFlB1Dc9BojVinlYeq7eSf51pMTop/KRUCTGI2tYTwoIevE/
         ppwqnxlKxbddbbXLwQYUBYBmjHnhkCWtiw+M2pjBUHubfVDoUDyw4iPsmfUQ9SDztPPK
         dQZkbuA5bONlFNrgievfPPJkX6X+L1gzakrERpaDGJcx8ZGA8bCQW9qGFKNyDg0Is7XU
         yJ3aJ4f9vDbBO0GX9cfD6CVf86tnfiG+Qk+F6dP1pHTy0UEwYxrt+ID9clC4fFK33K2C
         9k+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=RrZqSUgV0o2n+fC0ATR2Inwg8tiJ8Mrky0FeiVi+KiM=;
        b=tw7KgqOvwN6zehoQpyo6Hy9eHuBFzDEUmsHf5lXFlJ2qdZU9RTdsmtAlSZJnAeds94
         tTpiZ7wgEwPZkdPTSoTaLjtQQWVNHHecAe5b1WCaEHd5H0V7+9QF0LcRk2K7Xo+v37AL
         OmLg1iW+OIXAmTFK5h2LKpP5It/UBcwqfaguLjJbyxHylMJ4ANyTjRn26CKYrPyisWYJ
         yr0g3Vho1B5Do9pZRkd03cL4P1oogKJYCbQ1dI7wVOC2FyvamOEg4IgJVq40FUSpUYwV
         X4UvQKH/29klxns9RqwuDKV9jLIm4fOKCRoxSfsvd6S8H0PzMMez8QO9xiSP5XTyotmW
         A8MQ==
X-Gm-Message-State: AOAM531Bu8n6pH/5Mx7dAJXT2IT3GcsQ9XiS9VOqcX44wi0VrOkiuDPK
        rJwQKq+88pnLWHDbOHWhpOf4u1ynOg/hCBBUNIM=
X-Google-Smtp-Source: ABdhPJwdQ21ro+wX/t1ZDuDtyGk5jKXHzmeVfFfrMH31CKbHaKVf0vXYN9Y/yl3XlrjW8ig68t8wFFpstkJ3/C0sH58=
X-Received: by 2002:a37:a44:: with SMTP id 65mr6934972qkk.479.1616666132779;
 Thu, 25 Mar 2021 02:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <1616637382-27311-1-git-send-email-bingjingc@synology.com>
In-Reply-To: <1616637382-27311-1-git-send-email-bingjingc@synology.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 25 Mar 2021 09:55:21 +0000
Message-ID: <CAL3q7H6G6owDc0nD4gK=YdnApTgL_02XqRq_FpP=05W6oxvjFw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix a potential hole-punching failure
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

On Thu, Mar 25, 2021 at 3:42 AM bingjingc <bingjingc@synology.com> wrote:
>
> From: BingJing Chang <bingjingc@synology.com>
>
> In commit d77815461f04 ("btrfs: Avoid trucating page or punching hole
> in a already existed hole."), existed holes can be skipped by calling
> find_first_non_hole() to adjust *start and *len. However, if the given
> len is invalid and large, when an EXTENT_MAP_HOLE extent is found, the
> *len will not be set to zero because (em->start + em->len) is less than
> (*start + *len). Then the ret will be 1 but the *len will not be set to
> 0. The propagated non-zero ret will result in fallocate failure.
>
> In the while-loop of btrfs_replace_file_extents(), len is not updated
> every time before it calls find_first_non_hole(). That is, after
> btrfs_drop_extents() successfully drops the last non-hole file extent,
> it may fail with -ENOSPC when attempting to drop a file extent item
> representing a hole. The problem can happen. After it calls
> find_first_non_hole(), the cur_offset will be adjusted to be larger
> than or equal to end. However, since the len is not set to zero. The
> break-loop condition (ret && !len) will not meet. After it leaves the
> while-loop, fallocate will return 1, which is an unexpected return
> value.
>
> We're not able to construct a reproducible way to let
> btrfs_drop_extents() fail with -ENOSPC after it drops the last non-hole
> file extent but with remaining holes left. However, it's quite easy to
> fix. We just need to update and check the len every time before we call
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

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
