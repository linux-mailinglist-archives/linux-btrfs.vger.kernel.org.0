Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8B63F8AC5
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 17:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242918AbhHZPMh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 11:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbhHZPMg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 11:12:36 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EF4C061757
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Aug 2021 08:11:49 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id b1so2727167qtx.0
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Aug 2021 08:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=byi+MszWCpxHtxS5K19ala015VgwbhtCxXyg0N1qO0c=;
        b=l8IwzBAMSCfo2u4GlAa11FZpp4FVU+Md897hCCudPUGNq2NjZzF89+E4dK5G5dWvxH
         axNst1BmAJcLJDiSQCSOf+Ekcp4T+wtB5lQUFj2eNnMOy+NjAYaU7kkiTByCXYpG2W1J
         mnq/QRq9+V9rqxHR72wO7Xabg9fnwE96Gc0VMUqJfKey5dyCkYIieuw+6HgeU7cbp6OU
         gSQRwpggtF++h5654e94oPYx2nZJ6Gfi6iglpLWeeUtmoEMVqr9oBInxhLSUZ8pnYXxH
         b98hOd8qKCCqB0lOCEoh5NcbL/ziOGaIZ6Tkcd8y08omw545lSq9TvddWLI1RppVhj7h
         Wymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=byi+MszWCpxHtxS5K19ala015VgwbhtCxXyg0N1qO0c=;
        b=ipZYQdKLYxUIdYc4fQ62IjGkwfEeRvmH0kHH3bDuqCjYHWeE1C8LwAOEpqFUrY3nxZ
         bp+mpajAJ8hgIu5mFS4XfzWcOlUnmkzCTvZVuDARhUfiMA8HKGgZnXUwUacz0l40xfWK
         oWRVx3NMKSwSOotiKBG7OSvByqrf83o0rnG8fuZ6JSTMPVzHN4Jm1Ms6j2zAJahrlR6/
         R7CwZM13guKRKSwxUGPnknbYVnLgIXFBw9vK/2zZfdxaKx+v1lzh+15Pr9Q18AmF3lMz
         BOoejmJjdxn4yFB9Q9NkZbQ4l1tflzAuauTR0Jy5bV/6GQ3YEeUbBDUK80fhSXSNk+qS
         LURw==
X-Gm-Message-State: AOAM531T7vFCTVLAFqLbDNHBIIjzy3UY/wGIEQnvFo3WfRhZTs60Esos
        4tuZ9Z69681+HT1kB7khCEV3wv2XIhQ754v0yFHnYd3r
X-Google-Smtp-Source: ABdhPJz4pUTI8DXGW5PXOqVINeYFPs6qUoHCJw7lCgzUdsUIgvVQ7TK9Wio3M1kzMleE2dwkbmkao0D/MFE+fSIoUFE=
X-Received: by 2002:a05:622a:58f:: with SMTP id c15mr3808220qtb.21.1629990708387;
 Thu, 26 Aug 2021 08:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210826144436.19600-1-realwakka@gmail.com>
In-Reply-To: <20210826144436.19600-1-realwakka@gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 26 Aug 2021 16:11:37 +0100
Message-ID: <CAL3q7H6x0+KXz96UbtC89cVBa3Cdwwaj0wfTFxa2SgSxYMZ5nQ@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: reflink: Initialize return value to 0 in btrfs_extent_same()
To:     Sidong Yang <realwakka@gmail.com>
Cc:     David Sterba <dsterba@suse.cz>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 26, 2021 at 3:44 PM Sidong Yang <realwakka@gmail.com> wrote:
>
> This patch fixes a warning reported by smatch. It reported that ret
> could be returned without initialized. 0 would be proper value for
> initializing ret. Because dedupe operations are supposed to to return
> 0 for a 0 length range.
>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> v2:
>  - Removed assert and added initializing ret
> v3:
>  - Changed initializing value to 0
> ---
>  fs/btrfs/reflink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index 9b0814318e72..c71e49782e86 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -649,7 +649,7 @@ static int btrfs_extent_same_range(struct inode *src,=
 u64 loff, u64 len,
>  static int btrfs_extent_same(struct inode *src, u64 loff, u64 olen,
>                              struct inode *dst, u64 dst_loff)
>  {
> -       int ret;
> +       int ret =3D 0;
>         u64 i, tail_len, chunk_count;
>         struct btrfs_root *root_dst =3D BTRFS_I(dst)->root;
>
> --
> 2.25.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
