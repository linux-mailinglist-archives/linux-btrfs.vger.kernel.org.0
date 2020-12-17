Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359792DD03D
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 12:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgLQLVJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 06:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgLQLVI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 06:21:08 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C14C061794
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 03:20:28 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id p12so13054838qvj.13
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 03:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=qtXXBhGaGqVWsw/7JTC8YgNEQrZ5dfPdoVhOdpI7dkA=;
        b=qql1xK1QmhlIpMtTmjxKM6u3f20Uo7CcjYHpSxfeBfeWobGSmren+/wkgwZtB4FIG3
         iYfLoaTPPQFCphE697ySw9Rs74B8Sv1v+x4mqXpfPhq3H9p2aozMACb9CA5FO7epDdkp
         2U2h7V/L7nNgY61D5syfjHdAM1NBKN9jbdsipxlFExStttqaM6JZgNJuVkhTLc9y7vMC
         6z9o+At+Zk5X6/t0MKTUQ5/rJ+ts0Fn08YRZBIE1mhV3pM0jClJT4H2TMAQBuDrXApTZ
         ExXahK/T8Ogn/xbSH2rRCwAoEEEbRpIO/JaKhSMQRhAee9W5/tnOyD64oe4dNunIGkAv
         Z8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=qtXXBhGaGqVWsw/7JTC8YgNEQrZ5dfPdoVhOdpI7dkA=;
        b=dpap/wj5YwJy9zuSceA9EyjD5p+0T30tKJ1Ko9OB6SiaoaDeR4G3dWc7HiZHWnzUsm
         JMBFbdJBuamzH7c2NBaRL3OBYS5nvF3Y7HcoYsfxg7Yek2RthrOoJaUROm4kTnqkYh+4
         mvcOQ2JRgyH7/3/HORyyYFStsprpdbwfVsgyhG2EOLLMp+f7udUBDf+rm7a9Hlqo8yS6
         /J5pTUL71dtUpXleC6xlQ6UKlwL0beDmVGpsUKVNXR5k+C5qDxRl40jSOiYnynjQIfkC
         4aAmceRSjs0tlYlNdf2wsPAfMJM3F+s1b1piIT7+O75llpnRvEF0jTUkMN4Ih6KJyM8m
         tt7A==
X-Gm-Message-State: AOAM530awEihqfCKEAgNMH9nMQyV0OTiiup7TCgn0onwzrLNbnKLNG2S
        Mjwo4tbJYM5cmSesyHWr/YQ+4P4DwGYTB4+47BdqMQip1sY=
X-Google-Smtp-Source: ABdhPJz97KXUZtSsyGFsBAFv9EU8yGF2xTsFRr8HO/V8vjLFW3GvObU2zoJW+eC/FsQPimFzmyhbegbhdrtjBIPvwhg=
X-Received: by 2002:a0c:da87:: with SMTP id z7mr27621010qvj.41.1608204027437;
 Thu, 17 Dec 2020 03:20:27 -0800 (PST)
MIME-Version: 1.0
References: <20201217045737.48100-1-wqu@suse.com> <20201217045737.48100-5-wqu@suse.com>
In-Reply-To: <20201217045737.48100-5-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 17 Dec 2020 11:20:16 +0000
Message-ID: <CAL3q7H7WTScxZmAwaNCztp-Q=zP6NSkRzh==quQS5mqxxbto2Q@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] btrfs: inode: make btrfs_invalidatepage() to be
 subpage compatible
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 17, 2020 at 5:03 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> With current subpage RW patchset, the following script can lead to
> filesystem hang:
>   # mkfs.btrfs -f -s 4k $dev
>   # mount $dev -o nospace_cache $mnt
>   # fsstress -w -n 100 -p 1 -s 1608140256 -v -d $mnt
>
> The file system will hang at wait_event() of
> btrfs_start_ordered_extent().
>
> [CAUSE]
> The root cause is, btrfs_invalidatepage() is freeing page::private which
> still has subpage dirty bit set.
>
> The offending situation happens like this:
> btrfs_fllocate()
> |- btrfs_zero_range()
>    |- btrfs_punch_hole_lock_range()
>       |- truncate_pagecache_range()
>          |- btrfs_invalidatepage()
>
> The involved range looks like:
>
> 0       32K     64K     96K     128K
>         |///////||//////|
>         | Range to drop |
>
> For the [32K, 64K) range, since the offset is 32K, the page won't be
> invalidated.
>
> But for the [64K, 96K) range, the offset is 0, current
> btrfs_invalidatepage() will call clear_page_extent_mapped() which will
> detach page::private, making the subpage dirty bitmap being cleared.
>
> This prevents later __extent_writepage_io() to locate any range to
> write, thus no way to wake up the ordered extents.
>
> [FIX]
> To fix the problem this patch will:
> - Only clear page status and detach page private when the full page
>   is invalidated
>
> - Change how we handle unfinished ordered extent
>   If there is any ordered extent unfinished in the page range, we can't
>   call clear_extent_bit() with delete =3D=3D true.
>
> [REASON FOR RFC]
> There is still uncertainty around the btrfs_releasepage() call.
>
> 1. Why we need btrfs_releasepage() call for non-full-page condition?
>    Other fs (aka. xfs) just exit without doing special handling if
>    invalidatepage() is called with part of the page.
>
>    Thus I didn't completely understand why btrfs_releasepage() here is
>    needed for non-full page call.
>
> 2. Why "if (offset)" is not causing problem for current code?
>    This existing if (offset) call can be skipped for cases like
>    offset =3D=3D 0 length =3D=3D 2K.
>    As MM layer can call invalidatepage() with unaligned offset/length,
>    for cases like truncate_inode_pages_range().
>    This will make btrfs_invalidatepage() to truncate the whole page when
>    we only need to zero part of the page.

I don't think you can ever get offset =3D=3D 0 and length < PAGE_SIZE
unless this is the last page in the file, the one containing eof, in
which it's perfectly valid to invalidate the whole page.

>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index eb493fbb65f9..872c5309b4ca 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8180,7 +8180,7 @@ static void btrfs_invalidatepage(struct page *page,=
 unsigned int offset,
>         int inode_evicting =3D inode->vfs_inode.i_state & I_FREEING;
>         bool cleared_private2;
>         bool found_ordered =3D false;
> -       bool completed_ordered =3D false;
> +       bool incompleted_ordered =3D false;
>
>         /*
>          * we have the page locked, so new writeback can't start,
> @@ -8191,7 +8191,13 @@ static void btrfs_invalidatepage(struct page *page=
, unsigned int offset,
>          */
>         wait_on_page_writeback(page);
>
> -       if (offset) {
> +       /*
> +        * The range doesn't cover the full page, just let btrfs_releasep=
age() to
> +        * check if we can release the extent mapping.
> +        * Any locked/pinned/logged extent map would prevent us freeing t=
he
> +        * extent mapping.
> +        */
> +       if (!(offset =3D=3D 0 && length =3D=3D PAGE_SIZE)) {
>                 btrfs_releasepage(page, GFP_NOFS);
>                 return;
>         }
> @@ -8208,9 +8214,10 @@ static void btrfs_invalidatepage(struct page *page=
, unsigned int offset,
>                 end =3D min(page_end,
>                           ordered->file_offset + ordered->num_bytes - 1);
>                 /*
> -                * IO on this page will never be started, so we need to a=
ccount
> -                * for any ordered extents now. Don't clear EXTENT_DELALL=
OC_NEW
> -                * here, must leave that up for the ordered extent comple=
tion.
> +                * IO on this ordered extent will never be started, so we=
 need
> +                * to account for any ordered extents now. Don't clear

So this comment update states that "IO on this ordered extent will
never be started".
That is not true, unless some other patch not in misc-next changed
something and I missed it (like splitting ordered extents).

If you have a 1M ordered extent, for file range [0, 1M[ for example,
and then truncate the file to 512K or punch a hole for the range
[512K, 1M[, then IO for the first 512K of the ordered extent is still
done.

So I think what you wanted to say is more like "IO for this subpage
will never be started ...".

> +                * EXTENT_DELALLOC_NEW here, must leave that up for the
> +                * ordered extent completion.
>                  */
>                 if (!inode_evicting)
>                         clear_extent_bit(tree, start, end,
> @@ -8234,7 +8241,8 @@ static void btrfs_invalidatepage(struct page *page,=
 unsigned int offset,
>                                                            start,
>                                                            end - start + =
1, 1)) {
>                                 btrfs_finish_ordered_io(ordered);
> -                               completed_ordered =3D true;
> +                       } else {
> +                               incompleted_ordered =3D true;
>                         }
>                 }
>
> @@ -8276,7 +8284,7 @@ static void btrfs_invalidatepage(struct page *page,=
 unsigned int offset,
>                  * is cleared if we don't delete, otherwise it can lead t=
o
>                  * corruptions if the i_size is extented later.
>                  */
> -               if (found_ordered && !completed_ordered)
> +               if (found_ordered && incompleted_ordered)

I find this naming, "incompleted_ordered" confusing, I think
"incompleted" is not even a valid english word.

What you mean is that if there is some ordered extent for the page
range that we could not complete ourselves.
I would suggest naming it to "completed_all_ordered", initialize it to
true and then set it to false when we can't complete an ordered extent
ourselves.

Then it would just be "if (found_ordered && !completed_all_ordered)
delete =3D false;".

Also, I haven't checked the other patchsets for subpage support, but
from looking only at this patchset, I'm assuming we can't set ranges
in the io tree smaller than page size, is that correct?
Otherwise this would be calling clear_extent_bit for each subpage range.

Thanks.

>                         delete =3D false;
>                 clear_extent_bit(tree, page_start, page_end, EXTENT_LOCKE=
D |
>                                  EXTENT_DELALLOC | EXTENT_UPTODATE |
> @@ -8286,6 +8294,7 @@ static void btrfs_invalidatepage(struct page *page,=
 unsigned int offset,
>                 __btrfs_releasepage(page, GFP_NOFS);
>         }
>
> +       ClearPagePrivate2(page);
>         ClearPageChecked(page);
>         clear_page_extent_mapped(page);
>  }
> --
> 2.29.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
