Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3224B20F1BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 11:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbgF3JhN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 05:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbgF3JhN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 05:37:13 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAFEC061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 02:37:12 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id t23so4397797vkt.5
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 02:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=GRWW2br88TWDL0pTjGx5KOqqK5AxzMt62Q6epVWq3Zg=;
        b=ZtccwlaoseyO0IdWhmfoxw4DqlFA/EA69WojqVvwSgPrDQHwksFaLmgb+Dx5wL2eU3
         rJqErjPW7DLwPUQYK1TezspxZaOfnWNKIioMOiJtNtUyX+DJA97zFDJE0CnIJ28ui7Cv
         j/Xcm+iKKfTBOxcvmiVCqoqZN0rJAEV7csJ3z9TWAQssdN556U0hbmkyArspbNlngSan
         EqbrBmQ/wwS/8PP3xyNjK24QuT7uqm2uvujuQJNxftujVnJZWV+sMOj1iEEJQChJicS9
         D0m26TzZZyAIfwQ2Jy35lVrXrPWFatm/G8Rlie8uNWHnlLiHMhRutDUJPPj8z5buB60/
         1MHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=GRWW2br88TWDL0pTjGx5KOqqK5AxzMt62Q6epVWq3Zg=;
        b=iOEUxysIf9IAEnH5gXec0UMVUjA278J+9C8TLeEhzrP8DnC/8qCetj2KQbEDfdh9yv
         Mi8umWdp8ZtoLzrQoz/Dw0mYNKJN+blRy1mQT5afouTuarsV8Vx86FmAMztlJKzqEiV3
         jP31dOHUs9tTKcaEy5ERWJ1k+lJo5X1X4dW1oPoNWrVvr549wofpkTQ+xnsuRT5wGj+M
         2Y075lhYPB9EfTlzapQwrhuO7rX1XG7UjWD6j3J/dfH1CPlPMQ/mOML15VedpVXmPPhP
         I72VSholhroa+w+BZlibf0ObqlnhNwixJSkfIzlVp2gNuoGBhovXkXzyizT7p1aT4Rzo
         H/Ug==
X-Gm-Message-State: AOAM533ZAVcOL3/2LzCuygDFbasK2Ff+zMQxW90DHjtJPiEFasPWRk/X
        PXTyNNxZFGrwAkNTvB+zl7UHP17ynuc4g0mvrfU=
X-Google-Smtp-Source: ABdhPJyvJwAz7mLYiKymLnyE1gTkkn5CXgdv4zbyyed/ouXqFzLu3/GBVPO6BmdnYNHPvvTGAGFQjDPmOAO8lZ28nKg=
X-Received: by 2002:a1f:1c13:: with SMTP id c19mr12892719vkc.24.1593509832136;
 Tue, 30 Jun 2020 02:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200622162017.21773-1-rgoldwyn@suse.de> <20200622162017.21773-7-rgoldwyn@suse.de>
In-Reply-To: <20200622162017.21773-7-rgoldwyn@suse.de>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 30 Jun 2020 10:37:00 +0100
Message-ID: <CAL3q7H4wL318dHrHcQKU_9n_p+_YFhySy1CzLSfTDYJYcv9pOA@mail.gmail.com>
Subject: Re: [PATCH 6/8] btrfs: Use shared inode lock for direct writes within EOF
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 22, 2020 at 5:22 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
>
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
>
> This is to parallelize direct writes within EOF or with direct I/O
> reads. This covers the race with truncate() accidentally increasing the
> filesize.
>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/file.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index aa6be931620b..c446a4aeb867 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1957,12 +1957,18 @@ static ssize_t btrfs_direct_write(struct kiocb *i=
ocb, struct iov_iter *from)
>         loff_t endbyte;
>         int err;
>         size_t count =3D 0;
> -       bool relock =3D false;
>         int flags =3D IOMAP_DIOF_PGINVALID_FAIL;
>         int ilock_flags =3D 0;
>
>         if (iocb->ki_flags & IOCB_NOWAIT)
>                 ilock_flags |=3D BTRFS_ILOCK_TRY;
> +       /*
> +        * If the write DIO within EOF,  use a shared lock
> +        */
> +       if (pos + count <=3D i_size_read(inode))
> +               ilock_flags |=3D BTRFS_ILOCK_SHARED;
> +       else if (iocb->ki_flags & IOCB_NOWAIT)
> +               return -EAGAIN;

In the next iteration, please rebase the patchset on a more recent misc-nex=
t.

That hunk returning -EAGAIN is buggy and was removed a couple weeks
ago in a patchset fixing several bugs with NOWAIT writes.

Thanks.

>
>         err =3D btrfs_inode_lock(inode, ilock_flags);
>         if (err < 0)
> @@ -1975,20 +1981,6 @@ static ssize_t btrfs_direct_write(struct kiocb *io=
cb, struct iov_iter *from)
>         if (check_direct_IO(fs_info, from, pos))
>                 goto buffered;
>
> -       count =3D iov_iter_count(from);
> -       /*
> -        * If the write DIO is beyond the EOF, we need update the isize, =
but it
> -        * is protected by i_mutex. So we can not unlock the i_mutex at t=
his
> -        * case.
> -        */
> -       if (pos + count <=3D inode->i_size) {
> -               inode_unlock(inode);
> -               relock =3D true;
> -       } else if (iocb->ki_flags & IOCB_NOWAIT) {
> -               err =3D -EAGAIN;
> -               goto out;
> -       }
> -
>         if (is_sync_kiocb(iocb))
>                 flags |=3D IOMAP_DIOF_WAIT_FOR_COMPLETION;
>
> @@ -1997,9 +1989,6 @@ static ssize_t btrfs_direct_write(struct kiocb *ioc=
b, struct iov_iter *from)
>                                flags);
>         up_read(&BTRFS_I(inode)->dio_sem);
>
> -       if (relock)
> -               inode_lock(inode);
> -
>         if (written < 0 || !iov_iter_count(from)) {
>                 err =3D written;
>                 goto error;
> --
> 2.25.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
