Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 005FA82F98
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 12:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbfHFKO5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 06:14:57 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43424 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFKO5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Aug 2019 06:14:57 -0400
Received: by mail-ua1-f66.google.com with SMTP id o2so33450922uae.10
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2019 03:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=dcjQbSiDAwdlGcnz6izlBPEsQaN6nhAMzapwIt5ynHg=;
        b=CJwxkbiby9u661TreASrXKlHP8h27TZlaA74pPWB8umrDKiDZsm2QtIY7qXAmjaYx5
         GE3HMAqKWQVGENg8+MqABoXfoEnv7xFtQFhzS62THzjC8IvPZ7PfxT/F4Q/ztPpVoR5g
         zoAt/RNetZext0cnBXp/6UoeTuzVb3i7LyvMyEguEo/TKJ+5BPxcU0NXaZ1LwoB1Vk4p
         uys2/mLULKn/FeNPOdZHyHKnejiu6JFNWMcpxqjrl6y+hilXHwJZOO1NYlJzOqSkKBjo
         KSxnunMLaFnSqdClfJGCUVW2t0qhmjqPY4FiXre9OodU0UnAmodlMVyKr2qktTcSHrnT
         nAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=dcjQbSiDAwdlGcnz6izlBPEsQaN6nhAMzapwIt5ynHg=;
        b=FnWNATQw9HPuvsAHG1lg34eaiBDwyAkXaJVS1+YeFfjzhscRW6NJZPAuTp+gjTw8u0
         EKMV4NBAMkC85oGJZbCShxfnhzV63WE443T4BECvCpQLipQl7rg2GHS0OfMpHvBBjszp
         VeIeaNOIMAu3/SS5BtAm0g3phi/bdqZJORO267uZ8/XLRvwObpCAJ1gdvXxwEcpMy+gJ
         ZmrQR9HLYneRPBTW9A4zS9QY8y5t576JoP70XvvffKdHrQfObHvO9evp/1Kb9KkGhF44
         eLcVFE2rgT51klziYvu2GZSe6Rmiv/E9rCeAVGE6LtExvbJPkmS6lk91ORVUC3ScFB+v
         mA/w==
X-Gm-Message-State: APjAAAUNdFwUKZEEH4XM3eC0UragA/d65wtqCprmBnxOD8RXdltcqwh+
        ohn/yKBU5gwTzY3GFk5t+fg2TgTFaEfMF+KKSXUqcQ==
X-Google-Smtp-Source: APXvYqzFnISpN10x7i5bTXFUChtUbkU0dCiq6vLEkFWW+49gZrHM1vRBKljNXV9hFZLBZhOdmK7vGpFFIpFFbFw8Z60=
X-Received: by 2002:ab0:4a6:: with SMTP id 35mr1695414uaw.123.1565086496257;
 Tue, 06 Aug 2019 03:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190805144708.5432-1-nborisov@suse.com> <20190805144708.5432-6-nborisov@suse.com>
In-Reply-To: <20190805144708.5432-6-nborisov@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 6 Aug 2019 11:14:45 +0100
Message-ID: <CAL3q7H6CPM-NMXw6eZQAs=k2C_vcG-i9gChHjuHU9FZvqRCZOw@mail.gmail.com>
Subject: Re: [PATCH 5/6] btrfs: Simplify extent type check
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
> Extent type can only be regular/prealloc/inline. The main branch of the
> 'if' already handles the first two, leaving the 'else' to handle inline.
> Furthermore, tree-checker ensures that leaf items are correct.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  fs/btrfs/inode.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8e24b7641247..6c3f9f3a7ed1 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1502,18 +1502,14 @@ static noinline int run_delalloc_nocow(struct ino=
de *inode,
>                         if (!btrfs_inc_nocow_writers(fs_info, disk_bytenr=
))
>                                 goto out_check;
>                         nocow =3D true;
> -               } else if (extent_type =3D=3D BTRFS_FILE_EXTENT_INLINE) {
> -                       extent_end =3D found_key.offset +
> -                               btrfs_file_extent_ram_bytes(leaf, fi);
> -                       extent_end =3D ALIGN(extent_end,
> -                                          fs_info->sectorsize);
> +               } else {
> +                       extent_end =3D found_key.offset + ram_bytes;
> +                       extent_end =3D ALIGN(extent_end, fs_info->sectors=
ize);
>                         /* Skip extents outside of our requested range */
>                         if (extent_end <=3D start) {
>                                 path->slots[0]++;
>                                 goto next_slot;
>                         }
> -               } else {
> -                       BUG();
>                 }
>  out_check:
>                 /*
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
