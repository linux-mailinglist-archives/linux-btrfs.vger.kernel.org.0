Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D537C2763B1
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 00:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgIWWS6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 18:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIWWS5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 18:18:57 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF887C0613CE
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Sep 2020 15:18:57 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q5so1193650ilj.1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Sep 2020 15:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TITV6wjSakumv03bQwJ/jmvc8gen2aBv8Dq1oW8jiCU=;
        b=XsstD3bUKwUAkoQ50QxG+0DjnHD+gWlg7vF6mQOmCe4mDHL064VgI/mu4VauvgrujB
         3QUoc/1TA63KGotAa549Me/8VmYzV3d6Z1ymeFTqy12BObZlMKITGwOyKFMW/E5gEjPQ
         a2Pc/RxicKv6KJfvjcpdJoMaTp2HG1bQhVMCtJQfFmen+764kcWWkUpPsvr+hoksQHwA
         rG48co5mWagivX2iR9zbtFAoOZhUM1QKjpJtjhaakF3YdytMYNnP+04rkCB0RGOA6bix
         MVJ3PrAXK4k0sCCw7Yv3zGv9aZ39+Z00z+EK0IbNXIHEx7UTIbhQwCFCeLPiOoYQhfIg
         AiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TITV6wjSakumv03bQwJ/jmvc8gen2aBv8Dq1oW8jiCU=;
        b=mvqfa7vJArY2KdAfdRRPo/ZyLOjrAQgoDf2oBqkKVa5h2vZdNLjD5v9KAbfLrfD01p
         ozYdN/7qhyetB1WRezxXsQkT0iQNSK/bT1M8E27ZyB73NlVX6a+QoNbupLGkKpTX3MZ7
         CFxsS5a1K2BgJP1qTfaIhrwYvflmdo6EimCXWBgav+eYUF/IE2W7yXi8qk5C2cYGLIth
         EOmdUyObE1R8xqlXsjc4Fa3CY6naMfE1frfP+6BOqNIC5/deJeYHC4et3SlQNYhOU4F7
         fkc5pjwhoCAogIEOxNF8Na0faOB+NoteJyNUPR8mllCDkUsdCj+wGF18yMAbId6r+LOW
         fm+g==
X-Gm-Message-State: AOAM532iTuR+w6cO14PvL4yI0JaZU+i2jxsWdrMVqcLJ1GhgUVFxHhN+
        co7R0SpyVRPmGwWYUBsk/45V6ohC9gjG0ya3drM=
X-Google-Smtp-Source: ABdhPJxXTa9VvU9cnetSgW1oZGLMEAC90Iun9VLFVEqgxKAV89IvhgQoM411eNCQz5WPNJDlXJQLhlLNUbordCTGyYE=
X-Received: by 2002:a92:2901:: with SMTP id l1mr1606298ilg.10.1600899537013;
 Wed, 23 Sep 2020 15:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200923171405.17456-1-marcos@mpdesouza.com>
In-Reply-To: <20200923171405.17456-1-marcos@mpdesouza.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 23 Sep 2020 18:18:21 -0400
Message-ID: <CAEg-Je8P+1G+Z932OT0KCx8yBvSYL8+MvGf=6g3mw2nXB4AhbQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: convert: Mention which reserve_space call failed
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 23, 2020 at 1:44 PM Marcos Paulo de Souza
<marcos@mpdesouza.com> wrote:
>
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>
> btrfs-convert currently can't handle more fragmented block groups when
> converting ext4 because the minimum size of a data chunk is 32Mb.
>
> When converting an ext4 fs with more fragmented block group and the disk
> almost full, we can end up hitting a ENOSPC problem [1] since smaller
> block groups (10Mb for example) end up being extended to 32Mb, leaving
> the free space tree smaller when converting it to btrfs.
>
> This patch adds error messages telling which needed bytes couldn't be
> allocated from the free space tree:
>
> create btrfs filesystem:
>         blocksize: 4096
>         nodesize:  16384
>         features:  extref, skinny-metadata (default)
>         checksum:  crc32c
> free space report:
>         total:     1073741824
>         free:      39124992 (3.64%)
> ERROR: failed to reserve 33554432 bytes from free space for metadata chun=
k
> ERROR: unable to create initial ctree: No space left on device
>
> Link: https://github.com/kdave/btrfs-progs/issues/251
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  convert/common.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/convert/common.c b/convert/common.c
> index 048629df..6392e7f4 100644
> --- a/convert/common.c
> +++ b/convert/common.c
> @@ -812,8 +812,10 @@ int make_convert_btrfs(int fd, struct btrfs_mkfs_con=
fig *cfg,
>          */
>         ret =3D reserve_free_space(free_space, BTRFS_STRIPE_LEN,
>                                  &cfg->super_bytenr);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               error("failed to reserve %d bytes from free space for tem=
porary superblock", BTRFS_STRIPE_LEN);
>                 goto out;
> +       }
>
>         /*
>          * Then reserve system chunk space
> @@ -823,12 +825,16 @@ int make_convert_btrfs(int fd, struct btrfs_mkfs_co=
nfig *cfg,
>          */
>         ret =3D reserve_free_space(free_space, BTRFS_MKFS_SYSTEM_GROUP_SI=
ZE,
>                                  &sys_chunk_start);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               error("failed to reserve %d bytes from free space for sys=
tem chunk", BTRFS_MKFS_SYSTEM_GROUP_SIZE);
>                 goto out;
> +       }
>         ret =3D reserve_free_space(free_space, BTRFS_CONVERT_META_GROUP_S=
IZE,
>                                  &meta_chunk_start);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               error("failed to reserve %d bytes from free space for met=
adata chunk", BTRFS_CONVERT_META_GROUP_SIZE);
>                 goto out;
> +       }
>
>         /*
>          * Allocated meta/sys chunks will be mapped 1:1 with device offse=
t.
> --
> 2.28.0
>

Reviewed-by: Neal Gompa <ngompa13@gmail.com>


--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
