Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9A73486CC
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 03:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbhCYCGx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Mar 2021 22:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbhCYCG3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Mar 2021 22:06:29 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A38DC06174A;
        Wed, 24 Mar 2021 19:06:29 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z136so353926iof.10;
        Wed, 24 Mar 2021 19:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PCmATWxWzGsdvC0bhPmdLm7Vp6wPPAQcv+Ld4R4h/gk=;
        b=lsy7l0VpOOB75uBNWFvkCziYTjvQi0HzEWtJCcg38GryyDua8Kc65qK6gm4SWYkQGm
         6QkwABaUsj6pG7fUwe8PpGXCMbojSAvyVzd8txHZBHykpPBzbz6mMSdFW6DzhMyESL8G
         HbNmT7mWHa/KRqoeLVNt/tfWGlxwaSdJe1KRRsP7A3P0WrsW1SHoAZonJrbib0iyh7yF
         PvGQ56mPr3qc3+7Xei+dWHARdaqtBSlKd12Z089fN08yLjbDgCH4CGCU0jk8P1oR4WZ5
         S4vKnxt8YOtxDAVQmvnaxDTkeqecPNuMvoZBiYGYXuD79WtObpC74JgI5hwra0SGEVhs
         skCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PCmATWxWzGsdvC0bhPmdLm7Vp6wPPAQcv+Ld4R4h/gk=;
        b=AkdcMmcfUKyJGaz23KD3ZFqTTaFxN7UVfi6o3XIVG7eE74FIrvr6w1Elrk3OYGLpFU
         asfi8gLYnCLtnBL+tq+LLaMx5Bbsv+YyKwgI72nQSDjjZBOGUWZcZJbQQ4xEPzzm1fJ7
         XQLwY45l1p/6QT9MD2NLrlp1+ghoozOcv6IL/1KFnXHb+iACKFhXcvUaSeaKZ59+cycC
         rNrK60On+hz1nnD06Ph2LZKHtYlFw6paPFwrfyeWceUA7wqkeCgIgT8V8hoAuMFlvu6y
         GeFwO+kMXT5XiO5e/jbc1MqocEzq5mDOd8VlBn5JIBlbp5Z6z/gOa/uMd5BkoHAhLVZx
         3CXw==
X-Gm-Message-State: AOAM531nsh1QZyBRtLCpOyTMiS3LU7jbYDG0k89lwo3YomsKD8WwPCzt
        QZX8/ZCV5A5v7OE7lA+U+RJb9nolaWaRbEMH/gcd22TJuFirTA==
X-Google-Smtp-Source: ABdhPJyY4puJCDw1KnaRIiQ/GXlKVX40G7Mc1BPeTx6qKqGbHPE7b42iOcITjM0i1IxaoXmP2+YjlQyWAT5nrCl6xys=
X-Received: by 2002:a6b:d318:: with SMTP id s24mr4761591iob.89.1616637988528;
 Wed, 24 Mar 2021 19:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <1616578270-7365-1-git-send-email-bingjingc@synology.com> <CAL3q7H7YGA0PFJp6J7vFvK0EPSixY7chnReS6Zbqa_9S2p_QRQ@mail.gmail.com>
In-Reply-To: <CAL3q7H7YGA0PFJp6J7vFvK0EPSixY7chnReS6Zbqa_9S2p_QRQ@mail.gmail.com>
From:   bingjing chang <bxxxjxxg@gmail.com>
Date:   Thu, 25 Mar 2021 10:06:17 +0800
Message-ID: <CAMmgxWFc7O6=Pwbv4T=Z3PAotj+3xn+q+KRCnss4ZKOOgC9iTA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix a potential hole-punching failure
To:     fdmanana@gmail.com
Cc:     bingjingc <bingjingc@synology.com>,
        Josef Bacik <josef@toxicpanda.com>,
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

In order to reply in plain text, I send the mail from Gmail.

Filipe Manana <fdmanana@gmail.com> =E6=96=BC 2021=E5=B9=B43=E6=9C=8824=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:16=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Mar 24, 2021 at 11:15 AM bingjingc <bingjingc@synology.com> wrote=
:
> >
> > From: BingJing Chang <bingjingc@synology.com>
> >
> > In commit d77815461f04 ("btrfs: Avoid trucating page or punching hole i=
n
> > a already existed hole."), existed holes can be skipped by calling
> > find_first_non_hole() to adjust *start and *len. However, if the given
> > len is invalid and large, when an EXTENT_MAP_HOLE extent is found, the
> > *len will not be set to zero because (em->start + em->len) is less than
> > (*start + *len). Then the ret will be 1 but the *len will not be set to
> > 0. The propagated non-zero ret will result in fallocate failure.
> >
> > In the while-loop of btrfs_replace_file_extents(), len is not updated
> > every time before it calls find_first_non_hole(). That is, if the last
> > file extent in the given hole-punching range has been dropped but
> > btrfs_drop_extents() fails with -ENOSPC (btrfs_drop_extents() runs out
> > of reserved space of the given transaction), the problem can happen.
>
> This is not entirely clear. Dropping the last extent and still
> returning ENOSPC is confusing.
> I think you mean that it drops the last file extent item that does not
> represent hole (disk_bytenr > 0), and after it there's only one file
> extent item representing a hole (disk_bytenr =3D=3D 0).
> It fails with -ENOSPC when attempting to drop the file extent item
> representing the hole, after successfully dropping the non-hole file
> extent item.
> Is that it?
>

Thank you for your comments. You're right.
Saying the last file extent is not correct and confusing.
I revised and send the v2 patch for fixing the commit message. Thank you.

> > After it calls find_first_non_hole(), the cur_offset will be adjusted
> > to be larger than or equal to end. However, since the len is not set to
> > zero. The break-loop condition (ret && !len) will not meet. After it
> > leaves the while-loop, uncleared ret will result in fallocate failure.
>
> Ok, fallocate will return 1, an unexpected return value.
>
> >
> > We're not able to construct a reproducible way to let
> > btrfs_drop_extents() fails with -ENOSPC after it drops the last file
> > extent but with remaining holes. However, it's quite easy to fix. We
> > just need to update and check the len every time before we call
> > find_first_non_hole(). To make the while loop more readable, we also
> > pull the variable updates to the bottom of loop like this:
> > while (cur_offset < end) {
> >         ...
> >         // update cur_offset & len
> >         // advance cur_offset & len in hole-punching case if needed
> > }
> >
> > Reported-by: Robbie Ko <robbieko@synology.com>
> > Fixes: d77815461f04 ("btrfs: Avoid trucating page or punching hole in a
> > already existed hole.")
> > Reviewed-by: Robbie Ko <robbieko@synology.com>
> > Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
> > Signed-off-by: BingJing Chang <bingjingc@synology.com>
>
> Looks good.
> Please just update that paragraph to be more clear about what is going on=
.
>
> Thanks.
>
> > ---
> >  fs/btrfs/file.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 0e155f0..dccb017 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -2735,8 +2735,6 @@ int btrfs_replace_file_extents(struct inode *inod=
e, struct btrfs_path *path,
> >                         extent_info->file_offset +=3D replace_len;
> >                 }
> >
> > -               cur_offset =3D drop_args.drop_end;
> > -
> >                 ret =3D btrfs_update_inode(trans, root, BTRFS_I(inode))=
;
> >                 if (ret)
> >                         break;
> > @@ -2756,7 +2754,9 @@ int btrfs_replace_file_extents(struct inode *inod=
e, struct btrfs_path *path,
> >                 BUG_ON(ret);    /* shouldn't happen */
> >                 trans->block_rsv =3D rsv;
> >
> > -               if (!extent_info) {
> > +               cur_offset =3D drop_args.drop_end;
> > +               len =3D end - cur_offset;
> > +               if (!extent_info && len) {
> >                         ret =3D find_first_non_hole(BTRFS_I(inode), &cu=
r_offset,
> >                                                   &len);
> >                         if (unlikely(ret < 0))
> > --
> > 2.7.4
> >
>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D

Thanks,
BingJing Chang
