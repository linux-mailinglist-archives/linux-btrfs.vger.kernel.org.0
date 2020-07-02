Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D79821222C
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 13:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgGBLZH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 07:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgGBLZH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 07:25:07 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EACC08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 04:25:07 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id p25so7272535vsg.4
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 04:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=3MV+d1lYw2U0jN82QQaTvanM86yF3M+Qt59b879javY=;
        b=MT+b0IonPuRK9IHAsFgCvgKPTl9+9rd70sXTZHc6QAHgqlB/QoL2XA+0w3Fc1R8Ss/
         WblraA7vvTdX9NSFO3V5UfsrRJi0NOEzrEAjM2B9Bo3SjFyqw7Fz1nUumS2+MN6ZlbFa
         N1fXZOlywqp1ArTrXA6JgQV5nDdyD+4iKvmpIBz5u5GfjtMyhRFkbJ7RFTRudaBivlrK
         SNFMmeue6hvc/fEekv5gaDMKYgvO+Pqy8q3obRXSec0VQQ/R82ooyiICA6jFKS7t2yd0
         XrAW/7sdbyYrORvl19FGpskdQbJy8XUyM8wrzgaSMLD5sh/Nus0WQ2oBJIwwudC/Hkq7
         kmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=3MV+d1lYw2U0jN82QQaTvanM86yF3M+Qt59b879javY=;
        b=pZyXTVuRSAdCAPBUlll0p7TBXMFrHKa0pDhV2Xehrgipv3qgniOJfjU/tKtdk4FFHZ
         ieQsfeorTQB2EJSGu5OqjH7CBmWg8XWxHE/ivw2MNytZk555JYrPA9yx05TpEdezZ6Yv
         sMXDKa4IKDRVEqLl9hugYSl5YqoIFuowx5EQARj7rlHUQLmV9w9HUG39AibchY3hIBLA
         OanduTYzaTzMzw7coijIQnvDgDvFIaKjlW0tUqofsPYl4tirMF0cC0co6CAPDCThVhpz
         MrFicIWwUMNtb4cLxV9Bv5ji8+yrHNNI0a5WJmJcDYugToNPetUG1JAwEr6Hg+ra9UNG
         vWzg==
X-Gm-Message-State: AOAM532a/so33s8M9mBTeBx1K2GvcE0v+d6Yf7fErY5zhBCtFVv3kfad
        5hkEr8ScSyKiBdc2ZPqP45VQO2v/s2yvCTc87LU=
X-Google-Smtp-Source: ABdhPJyha1k4hSN9THNaWgOF+xUzikKKpZC8e+LG7R1+zmjhkc+h2TsA78Q8UtkEmj77J+oKP6lvDzrJFTQqx/U2kOc=
X-Received: by 2002:a67:1e45:: with SMTP id e66mr21551814vse.95.1593689106418;
 Thu, 02 Jul 2020 04:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200701202219.11984-1-josef@toxicpanda.com> <20200701202219.11984-2-josef@toxicpanda.com>
In-Reply-To: <20200701202219.11984-2-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 2 Jul 2020 12:24:55 +0100
Message-ID: <CAL3q7H74qa0ggk=TY+ghC31CNha9RDmx=e7qzE_bb7rAzdDhWw@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: fix block group UAF bug with nocow
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 1, 2020 at 9:23 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> While debugging a patch that I wrote I was hitting UAF panics when
> accessing block groups on unmount.  This turned out to be because in the
> nocow case if we bail out of doing the nocow for whatever reason we need
> to call btrfs_dec_nocow_writers() if we called the inc.  This puts our
> block group, but a few error cases does
>
> if (nocow) {
>     btrfs_dec_nocow_writers();
>     goto error;
> }
>
> unfortunately, error is
>
> error:
>         if (nocow)
>                 btrfs_dec_nocow_writers();
>
> so we get a double put on our block group.  Fix this by dropping the
> error cases calling of btrfs_dec_nocow_writers(), as it's handled at the
> error label now.
>
> Fixes: 762bf09893b4 ("btrfs: improve error handling in run_delalloc_nocow=
")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good and the patch compiles and works just fine here on the
latest misc-next.
Thanks.

> ---
>  fs/btrfs/inode.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index d301550b9c70..cb18b1a13dca 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1694,12 +1694,8 @@ static noinline int run_delalloc_nocow(struct inod=
e *inode,
>                         ret =3D fallback_to_cow(inode, locked_page, cow_s=
tart,
>                                               found_key.offset - 1,
>                                               page_started, nr_written);
> -                       if (ret) {
> -                               if (nocow)
> -                                       btrfs_dec_nocow_writers(fs_info,
> -                                                               disk_byte=
nr);
> +                       if (ret)
>                                 goto error;
> -                       }
>                         cow_start =3D (u64)-1;
>                 }
>
> @@ -1715,9 +1711,6 @@ static noinline int run_delalloc_nocow(struct inode=
 *inode,
>                                           ram_bytes, BTRFS_COMPRESS_NONE,
>                                           BTRFS_ORDERED_PREALLOC);
>                         if (IS_ERR(em)) {
> -                               if (nocow)
> -                                       btrfs_dec_nocow_writers(fs_info,
> -                                                               disk_byte=
nr);
>                                 ret =3D PTR_ERR(em);
>                                 goto error;
>                         }
> --
> 2.24.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
