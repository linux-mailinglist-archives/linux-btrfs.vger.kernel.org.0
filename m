Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F302223B03
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jul 2020 14:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgGQMAf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jul 2020 08:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgGQMAe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jul 2020 08:00:34 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484B0C061755
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 05:00:34 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id h1so2051837vkn.12
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 05:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=/05Hk8+FH6k9QgMWqja+flyZgvXJPIEOtdIrNBHpK68=;
        b=DmNjLJ+fhZkPuiwDEQhYB5ipnHtRIrqrUznXzWrEMzdQakiektktqtMiHMl1mU0ch9
         p4ra0NHV6utMfWGecyzWffrXh3WZCcd1Ijb+N+EpiYbH6c4gmJcoF+VhQqePa+hAzXak
         rcI5HWl1tN4XVD9WgLPvCmroP2bI72rf5F8OhmIEuAAC9Zpbje1SnamOXJP5BVuE4xGN
         4nxumfnCJOodO0qLZtk+5PwoCkqyhmZM/BJ3ujRq0Ua/AJVlVOmjsTUMzT7367x/FBiG
         rMfB6kZIAYF5Dh2noEGLbUWxm0be9w6Yip8lrMR5WsmwCksD9mccv7EWdkXFtpn6wDhh
         bMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=/05Hk8+FH6k9QgMWqja+flyZgvXJPIEOtdIrNBHpK68=;
        b=EUxKbXy1ITtOyfJAXbDdiRTjGVEBnP2Sx7WetVKuBh2h0UA7hUlS28R7J+AcJ724sn
         da3chPGY2+Ahr5s9mf4dcV1w9zYoxrqVbxDfVeOB2uiZ7B/WC1x3iBSHSDyAewingp1Z
         uJPJnwMWYkttbVUbfPCVOoV/8qjAL11iP+dvw0mbr8vWDLAFsEVINwFUwoNFUC2zB357
         J5oOOLMJp5m+X3zJa/R3VDcsaw/i2Nk/lF8yeRQ67Fm6SQ1TEzasb8N2+16VtQlgCyMs
         AdofEtTNfUGUrOFppdTZSG/3qCy3/LaBMjWoHu2NmjvQmw21Jvn5JfA9KTmmJFiqXKjI
         Wdmw==
X-Gm-Message-State: AOAM532W2/pZy+Udgdv5o9zzc5PBF37iMrJx2nIDRKW4KP4Ds3Dcq+Fe
        8dxoq3Wa5oe6iM76xDz5iPOumvvAfYO0sxklJ9ySMm9u
X-Google-Smtp-Source: ABdhPJyCXNrFqF6gSRwJsBJM36sKNT7Pd+4n2r+b2/kfF5nGmSBkvGecLZjpqIBllN5UrYEDcSPUAjomCx1SUccTtE0=
X-Received: by 2002:a1f:3d4a:: with SMTP id k71mr6820257vka.65.1594987233442;
 Fri, 17 Jul 2020 05:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200717102240.21742-1-robbieko@synology.com>
In-Reply-To: <20200717102240.21742-1-robbieko@synology.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 17 Jul 2020 13:00:22 +0100
Message-ID: <CAL3q7H4+yzwLm6yhSfmSLbh6d00geGQsM-h6TiZzgAQHWT+yiQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix memory leak for page count
To:     robbieko <robbieko@synology.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 17, 2020 at 11:23 AM robbieko <robbieko@synology.com> wrote:
>
> From: Robbie Ko <robbieko@synology.com>
>
> When lock_delalloc_page, we first lock the page and then
> check that the page dirty, if the page is not dirty, we
> will return -EAGAIN but all pages must be freed, otherwise
> page leak.

"When lock_delalloc_page" -> When locking pages for delalloc

We check if it's dirty and if the mapping still matches.

Btw, you can make line length closer to 75 characters, it makes things
a bit more readable.

The subject is also a bit confusing:

"btrfs: fix memory leak for page count"

something along the lines "btrfs: fix page leaks after failure to lock
page for delalloc" would be more clear to me at least,
it gives a clue about where the problem is.

>
> Signed-off-by: Robbie Ko <robbieko@synology.com>

The code looks correct, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  fs/btrfs/extent_io.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 68c96057ad2d..34d55b1e2a88 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1951,7 +1951,7 @@ static int __process_pages_contig(struct address_sp=
ace *mapping,
>         struct page *pages[16];
>         unsigned ret;
>         int err =3D 0;
> -       int i;
> +       int i, j;
>
>         if (page_ops & PAGE_LOCK) {
>                 ASSERT(page_ops =3D=3D PAGE_LOCK);
> @@ -1999,7 +1999,8 @@ static int __process_pages_contig(struct address_sp=
ace *mapping,
>                                 if (!PageDirty(pages[i]) ||
>                                     pages[i]->mapping !=3D mapping) {
>                                         unlock_page(pages[i]);
> -                                       put_page(pages[i]);
> +                                       for (j =3D i; j < ret; j++)
> +                                               put_page(pages[j]);
>                                         err =3D -EAGAIN;
>                                         goto out;
>                                 }
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
