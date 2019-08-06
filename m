Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4535082FC5
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 12:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732409AbfHFKe4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 06:34:56 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39567 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFKez (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Aug 2019 06:34:55 -0400
Received: by mail-ua1-f68.google.com with SMTP id j8so33420971uan.6
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2019 03:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=pfunTOoivNmNd6P5ShI698y41nANkvZ4eiZa3Y1Z37I=;
        b=Et0XIeVZEn1YhIqWY7cJNC1uDNit9deNtH8Wl5/zgKs6ggV2rl/waDeQxjHQWsGXBc
         bFoqX3jLvdQF7ef+Im8YjfMV5w77LSFdDJpMoMeZqFmSRCr2Sp4Uh26szhuZzHJItTia
         sCYqJ3trfXT6gdkH6BL7vP5U4SX2cNY5PtUmdYpgvb6OLX4W+aA2CD759ja+KKs0pT1a
         VYXBMJPcx4tOE+K0Ngoa82ZfW45JrdGvWRsVvPRfxyi8TJURKG+8s3HaJaE02LFixsoz
         QCZi1TKukBuf+kUdZvLv84v7tRTZ0SREfr9oqI1Qu/wynkBwAcFvT2uE8XyauP15C0aK
         WLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=pfunTOoivNmNd6P5ShI698y41nANkvZ4eiZa3Y1Z37I=;
        b=kU7nmvwR7zAPbwFeFxNTX5RP1DkKfXVjOLoFHLf5VOQmMi9yjP0RPMSJa7Yjzqb/Pa
         E2jEAQW0q2sksyz+s9tiicPMqvlO1PlflnkMFnjGpQVZTj1DeBKwrS+UTy5iB7uzXNUe
         istQmFiknNJgIxu4CNCVO+MWAh5d5u7CmGeqJBEM8/60VC9vCEJEPaa1ca2VnEs3yd1A
         8mZJo2tg4oSbn8LG8Ow5va7VNWlzFXrJ+6AdwjlomRON5pR+bkh7rJHDKgnk0DeQ1Nom
         eY+WcZsrRdkgex0v8RrCD58fwPDeQHe0VM4kwJ2/MtMYT3642MT35cZRzq5RNZwG5ND+
         ZJfg==
X-Gm-Message-State: APjAAAVmeINAxLj63SyN8QyZwloRcSnbZJ7vz6kX1SWiZ+VjVqlylG6u
        DMz91qx4/EQK83uCfvTxr/YLb74sGcfNeJh9LvWpx28c
X-Google-Smtp-Source: APXvYqyGlX9Kzp9O6ijqxxhgzutmQ9mMY9bEUsX4PpjL11W+MvfALUHEOMFLCYZuVZcKTYdcVY1rLWAxyqEgArIhkFs=
X-Received: by 2002:ab0:18a6:: with SMTP id t38mr1748344uag.83.1565087694866;
 Tue, 06 Aug 2019 03:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190805144708.5432-1-nborisov@suse.com> <20190805144708.5432-7-nborisov@suse.com>
In-Reply-To: <20190805144708.5432-7-nborisov@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 6 Aug 2019 11:34:44 +0100
Message-ID: <CAL3q7H4bG0g7O8vUOR7pYBn9fvQbDvKVYUSucsPAcxBsNorrnw@mail.gmail.com>
Subject: Re: [PATCH 6/6] btrfs: Remove BUG_ON from run_delalloc_nocow
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 5, 2019 at 3:47 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
> Correctly handle failure cases when adding an ordered extents in case
> of REGULAR or PREALLOC extents.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

It's correct, but:

> ---
>  fs/btrfs/inode.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 6c3f9f3a7ed1..b935c301ca72 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1569,16 +1569,26 @@ static noinline int run_delalloc_nocow(struct ino=
de *inode,
>                                                        disk_bytenr, num_b=
ytes,
>                                                        num_bytes,
>                                                        BTRFS_ORDERED_PREA=
LLOC);
> +                       if (nocow)
> +                               btrfs_dec_nocow_writers(fs_info, disk_byt=
enr);
> +                       if (ret) {
> +                               btrfs_drop_extent_cache(BTRFS_I(inode),
> +                                                       cur_offset,
> +                                                       cur_offset + num_=
bytes - 1,
> +                                                       0);
> +                               goto error;
> +                       }
>                 } else {
>                         ret =3D btrfs_add_ordered_extent(inode, cur_offse=
t,
>                                                        disk_bytenr, num_b=
ytes,
>                                                        num_bytes,
>                                                        BTRFS_ORDERED_NOCO=
W);
> +                       if (nocow)
> +                               btrfs_dec_nocow_writers(fs_info, disk_byt=
enr);
> +                       if (ret)
> +                               goto error;

We are now duplicating some error handling. Could be done like before,
outside the if branches.

>                 }
>
> -               if (nocow)
> -                       btrfs_dec_nocow_writers(fs_info, disk_bytenr);
> -               BUG_ON(ret); /* -ENOMEM */

Just replacing the BUG_ON(ret) with "if (ret) goto error;".

>
>                 if (root->root_key.objectid =3D=3D
>                     BTRFS_DATA_RELOC_TREE_OBJECTID)
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
