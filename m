Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100703058C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 11:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbhA0KsA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 05:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbhA0Kpk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 05:45:40 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705A9C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 02:44:59 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id es14so823272qvb.3
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 02:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=BE3hbEvYnXepdoPqe4SXxH7E2xVEXlIkS9rgcMN068Q=;
        b=KcZkI1JKYcgG6wvsBExJE0xshMj+pwzOZXm2UJ3ruwhNrh1vYjwVVhVK/dCIgWXtqa
         tjRQkaG7IxSVzegoT6jWtLECKUo0tPpCKENCSxCAkgZKENBLC52uywKNeZYmpdmmRlZZ
         skL5sZdwXMNcgJgfz1R3PLyMnSbwQcs/O5yPhN9DIOOHb7GY6Rmy14xigAYUGKKmFIVj
         UiKIDFBV1X5pY/Q7p4zeOUo3gh1nwBE3Xlyeug7pLL+HQyRUCqBZH8dbhXC2B0DdXjqs
         kdl463bhZbdiCNFsM6bSyJhiEj+HI4iYJkTETe511eQwmSSN+xyzZVmU24B8tiUd002j
         VbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=BE3hbEvYnXepdoPqe4SXxH7E2xVEXlIkS9rgcMN068Q=;
        b=JUiK7Pqt6oM2+f/HjLfwx9SUqQAGQrunJv9lFv//7uzhmLB+tk8fXUuNJwXRve0Xyo
         veVUI914Dal3hN8/JYcI+QX32RJV2mERroYfF8fxY8o7O55RnBuQMEqHk+gtH79ZB/Kc
         +EZLBdjwlMjqo53eMIqDrRi6lVjzfj1JVjkYCcopNN9dBwPTiGkH+9yILAMpW54bp23o
         2glXueWlg7LW0ZL8Saj4YuWpuBL7EUiQINfqHnqdodUmJxTJ/XYk94Vc3aj56qW/l6hk
         h2tZgnbtxXL3SRMqOhqDpEEcsCqQeaUEZ5gTHpwZ9Ur3rluCQLbqVbxGyEb7T5JYw3ZI
         4fug==
X-Gm-Message-State: AOAM530sNRWELswId5oAXH49x+TaIfOge+Lbo6BTWGelKzfonZCOduwr
        MtPeHFyQNwyAzaXjaY7pNRTTqTePT890W6gMW1g=
X-Google-Smtp-Source: ABdhPJy/2Ym/BB5XWoXHwMjFVQwVKs+BtH1/Yhiu3Nyc5bHgEC4iOlt9C5Vgs2rvvKGewcT3UBiAvDoq9jVPyOFtSAc=
X-Received: by 2002:a05:6214:10e7:: with SMTP id q7mr9791078qvt.28.1611744298678;
 Wed, 27 Jan 2021 02:44:58 -0800 (PST)
MIME-Version: 1.0
References: <20210127063848.72528-1-wqu@suse.com>
In-Reply-To: <20210127063848.72528-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 27 Jan 2021 10:44:47 +0000
Message-ID: <CAL3q7H4kBWVewu8-yof-xzEZ1q24Xrz_h7hZHrOPEj_=9Lh1zA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix a bug that btrfs_invalidapge() can double
 account ordered extent for subpage
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 27, 2021 at 8:29 AM Qu Wenruo <wqu@suse.com> wrote:
>
> Commit dbfdb6d1b369 ("Btrfs: Search for all ordered extents that could
> span across a page") make btrfs_invalidapage() to search all ordered
> extents.
>
> The offending code looks like this:
>
> again:
>         start =3D page_start;
>         ordered =3D btrfs_lookup_ordered_range(inode, start, page_end - s=
tart + 1);
>         if (ordred) {
>                 end =3D min(page_end,
>                           ordered->file_offset + ordered->num_bytes - 1);
>
>                 /* Do the cleanup */
>
>                 start =3D end + 1;
>                 if (start < page_end)
>                         goto again;
>         }
>
> The behavior is indeed necessary for the incoming subpage support, but
> when it iterate through all the ordered extents, it also resets the
> search range @start.
>
> This means, for the following cases, we can double account the ordered
> extents, causing its bytes_left underflow:
>
>         Page offset
>         0               16K             32K
>         |<--- OE 1  --->|<--- OE 2 ---->|
>
> As the first iteration will find OE 1, which doesn't cover the full
> page, thus after cleanup code, we need to retry again.
> But again label will reset start to page_start, and we got OE 1 again,
> which causes double account on OE1, and cause OE1's byte_left to
> underflow.
>
> The only good news is, this problem can only happen for subpage case, as
> for regular sectorsize =3D=3D PAGE_SIZE case, we will always find a OE en=
ds
> at or after page end, thus no way to trigger the problem.
>
> This patch will move the again label after start =3D page_start, to fix
> the bug.
> This is just a quick fix, which is easy to backport.

Hum? Why does it need to be backported?
There are no kernel releases that support subpage sector size yet and
this does not affect the case where sector size is the same as the
page size.

>
> There will be more comprehensive rework to convert the open coded loop to
> a proper while loop.
>
> Fixes: dbfdb6d1b369 ("Btrfs: Search for all ordered extents that could sp=
an across a page")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Anyway, it looks good to me, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  fs/btrfs/inode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index ef6cb7b620d0..2eea7d22405a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8184,8 +8184,9 @@ static void btrfs_invalidatepage(struct page *page,=
 unsigned int offset,
>
>         if (!inode_evicting)
>                 lock_extent_bits(tree, page_start, page_end, &cached_stat=
e);
> -again:
> +
>         start =3D page_start;
> +again:
>         ordered =3D btrfs_lookup_ordered_range(inode, start, page_end - s=
tart + 1);
>         if (ordered) {
>                 found_ordered =3D true;
> --
> 2.30.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
