Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24AC6AEFBD
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 18:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436853AbfIJQjO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 12:39:14 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34893 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436800AbfIJQjL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 12:39:11 -0400
Received: by mail-qk1-f193.google.com with SMTP id d26so17765339qkk.2;
        Tue, 10 Sep 2019 09:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lpZWq94qrk679Y3vz/0HnxpCxOg4F7I7xKpKBxCXn0s=;
        b=HjT3JYoyNzN4qhLK9VFybMhJawQHZpS3NfF/hEOoe+j2Uu4cLMM4NrQ/kHbqJipnZc
         2jQ+Bc2jdQke1G4uXkFNei+1HYOFGWW/GDNnQkn+xgiBBLp7GJ7NUFQHrmNDHpo0zbXT
         xds5eJAa8XFFktRc9p42mz0dOJHQTQhv1XIkWo65mblo0ahWNTSTVsitsU3LGcAGLX9R
         fhg+TIPBY8alRNY/Fq3KPJqVvTjXnpJaFgbCEAJ5bPtFM9z31P9anvb3e84l2JoGJmCG
         2v5LPPDJixPwT0oB+uuCbzzhrxRQn/58geab8xNNfm6+5//B7QkugCaWJfrtoDByVfjN
         bOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lpZWq94qrk679Y3vz/0HnxpCxOg4F7I7xKpKBxCXn0s=;
        b=c5M2X8wBjNWl+IL3tj6Sx45MopLoPIdmMt/V5ffOzI2+umxeM3Wc4E+olOo/4YR/OU
         qBSffYjWSg6BXFrHwYYCRkYMGr30V2DMsa1kUW+D0wsZigHIk7+ZXwk/bI20FG764NPu
         NUliKduW12xZfCMg19yii0sVCfnuNNBzlRJzZ2ltzORmM5wIKdKaPGgYR0oUUVm6JClh
         /jb8rDs0gV44aOa7tHQHI330Xb1E6fhYM7E2hmsFU7bVsTyOe8aUKINpwnozE2cCr9zC
         1BXuC9kYpNLBkM/X2n0iUYg7Yf2uIf3hUAdvY3U2iSroJvIJAH3xP2YxgLgphfPNwnSW
         jkgQ==
X-Gm-Message-State: APjAAAV/1k7kDJQw/iCBT9/kn9Ze0iViXmxOuXt8yA0xwbtx53u/sRGG
        sPMTcH8TqvrlmGNM3Zkf3/3RpqKkcXiuifMeZuQ=
X-Google-Smtp-Source: APXvYqzuYDTPkcD5G8eMEjdj1wRJTupI9im3I0ZWo5MrhxMrpw94COPRbtz42FtpofglGXvXTSIoDortHdMzxHvAU+8=
X-Received: by 2002:a37:7086:: with SMTP id l128mr12804031qkc.433.1568133548629;
 Tue, 10 Sep 2019 09:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190903033019.GA149622@LGEARND20B15>
In-Reply-To: <20190903033019.GA149622@LGEARND20B15>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Wed, 11 Sep 2019 01:39:03 +0900
Message-ID: <CADLLry6vC_bPEq9VLhz3_EXrDPZP1XDFLocnT3zxYEcCaX0QYw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix Wmaybe-uninitialized warning
To:     clm@fb.com, Josef Bacik <josef@toxicpanda.com>, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello, maintainers.

If you are available, please review this patch and share the feedback.

Thanks,
Austin Kim

2019=EB=85=84 9=EC=9B=94 3=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 12:30, A=
ustin Kim <austindh.kim@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> gcc throws warning message as below:
>
> =E2=80=98clone_src_i_size=E2=80=99 may be used uninitialized in this func=
tion
> [-Wmaybe-uninitialized]
>  #define IS_ALIGNED(x, a)  (((x) & ((typeof(x))(a) - 1)) =3D=3D 0)
>                        ^
> fs/btrfs/send.c:5088:6: note: =E2=80=98clone_src_i_size=E2=80=99 was decl=
ared here
>  u64 clone_src_i_size;
>    ^
> The clone_src_i_size is only used as call-by-reference
> in a call to get_inode_info().
>
> Silence the warning by initializing clone_src_i_size to 0.
>
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> ---
>  fs/btrfs/send.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index f856d6c..197536b 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -5085,7 +5085,7 @@ static int clone_range(struct send_ctx *sctx,
>         struct btrfs_path *path;
>         struct btrfs_key key;
>         int ret;
> -       u64 clone_src_i_size;
> +       u64 clone_src_i_size =3D 0;
>
>         /*
>          * Prevent cloning from a zero offset with a length matching the =
sector
> --
> 2.6.2
>
