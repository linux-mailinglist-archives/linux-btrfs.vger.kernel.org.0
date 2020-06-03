Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92C41ECE7A
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 13:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgFCLfs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 07:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgFCLfs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Jun 2020 07:35:48 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23939C08C5C0
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Jun 2020 04:35:47 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id z13so1158165vsn.10
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Jun 2020 04:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=SYyfU030opnKCIF2XGo6N4KrhX3G+YKuy6M3WIeOJRU=;
        b=QC/6cJdZ7840W+6NhHk6kchRg0nfFelqqUuNaz+tNtqp5NmODNg2whS3PI/lRx8oZC
         x8pxOHZqiZgOPwuVKzxjiUHxRxIsQQxjrqw5UgTLMHgI3ZRHB28kU9SpuPnW7sL7Od6z
         nm4ZqXB/WMdpnO2/7uXfMVbKqEad+SwD7ZNZ5EDeeTXReZgWitmR43nbUWLriLBAa1N0
         /v9kfxSr3baE2IeAHzJuaaeo8DJCSX/yzZDYprOENdKSmEuwCvZ4lAuD1u+l5BjJlv87
         d4egCbLCFPEBsUT0m+1bX2Up57GyYjYHyPqukFqYZpguE3XqCWyVoGhDkR+Ln8hi/y3l
         u14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=SYyfU030opnKCIF2XGo6N4KrhX3G+YKuy6M3WIeOJRU=;
        b=dKKsMpqnTqH+g6AMqOJyWzr1veirMafLVIBv/cVbeig7tEIEVhwZIcl9RhbQZr4X2K
         ObDnlFYGwsWlPdAxsu4/lTyrUyKhEFCs2LP/Y4WqE1pYASdT2onAsFgbD1cHtLyxZqrx
         41PqEZR2nHmTnwf10pCHvrB5qMA+JcxHyU4p6Ono2b9Vjof25fo0/A212cb0iGNpofsO
         X9HNE32iC6aFqZ1y5gdMiljBxbhl4TmjXxlw0YLnH1n7etuoPykweTHJsbbzILqgws5n
         NQYh80IL7N1aZ1EIMeQEykYpD/2cNWqlwQE5kgDJEpma2KFKI/qfkit0E0AlrXk2dDTI
         o9uQ==
X-Gm-Message-State: AOAM532e0PIczArEpnsGTOpAQ8PgVhJUiSOLzVUwvecr9wk0ghNlfyyw
        SCzFNFBILTpgawaziFrwF08raZhHXL4ooRoRH9g=
X-Google-Smtp-Source: ABdhPJxDxONKs1Fwhv9JZAVI/MQSAEAA0x9XkgyDHhIyxmYu0M/yywDFH8Qv7MQXfLb3asu5ehrJZOB5027GDdeZZBM=
X-Received: by 2002:a67:dc89:: with SMTP id g9mr20969178vsk.206.1591184146253;
 Wed, 03 Jun 2020 04:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200522123837.1196-1-rgoldwyn@suse.de> <20200522123837.1196-5-rgoldwyn@suse.de>
 <SN4PR0401MB35981C3BAEDA15CC85D13AE79BB00@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200526164428.sirhx6yjsghxpnqt@fiona> <CAL3q7H6eVOTggceRgZakmoh8jNRJm5BXwNqE0Mx3By5_GgH5YA@mail.gmail.com>
 <20200528163450.uykayisbrn6hfm2z@fiona> <CAL3q7H700X4E5-NjTWcWwosBwLuKeFPOPx00f+OVn=2fBfmJbQ@mail.gmail.com>
 <20200528183848.siuljkvqmxbqa436@fiona>
In-Reply-To: <20200528183848.siuljkvqmxbqa436@fiona>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 3 Jun 2020 12:35:35 +0100
Message-ID: <CAL3q7H4SMOJEkAgQEd+i=yeJP20Mv7AthbxaE2==BVr=SGtyjg@mail.gmail.com>
Subject: Re: [PATCH 4/7] btrfs: Switch to iomap_dio_rw() for dio
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 28, 2020 at 7:38 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
>
> On 17:45 28/05, Filipe Manana wrote:
> > On Thu, May 28, 2020 at 5:34 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wr=
ote:
> > > > And who locked the extent range before?
> > >
> > > This is usually locked by a previous buffered write or read.
> >
> > A previous buffered write/read that has already finished or is still
> > in progress?
> >
> > Because if it has finished we're not supposed to have the file range
> > locked anymore.
>
> In progress. Mixing buffered I/O with direct writes.
>
> >
> > >
> > > >
> > > > That seems alarming to me, specially if it's a direct IO write fail=
ing
> > > > to invalidate the page cache, since a subsequent buffered read coul=
d
> > > > get stale data (what's in the page cache), and not what the direct =
IO
> > > > write wrote.
> > > >
> > > > Can you elaborate more on all those details?
> > >
> > > The origin of the message is when iomap_dio_rw() tries to invalidate =
the
> > > inode pages, but fails and calls dio_warn_stale_pagecache().
> > >
> > > In the vanilla code, generic_file_direct_write() aborts direct writes
> > > and returns 0 so that it may fallback to buffered I/O. Perhaps this
> > > should be changed in iomap_dio_rw() as well. I will write a patch to
> > > accomodate that.
> >
> > On vanilla we have no problems of mixing buffered and direct
> > operations as long as they are done sequentially at least.
> > And even if done concurrently we take several measures to ensure that
> > are no surprises (locking ranges, waiting for any ordered extents in
> > progress, etc).
>
> Yes, it is because of the code in generic_file_direct_write(). Anyways,
> I did some tests with the following patch, and it seems to work. I will
> send a formal patch to so that it gets incorporated in iomap sequence as
> well.
>
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index e4addfc58107..215315be6233 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -483,9 +483,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *it=
er,
>          */
>         ret =3D invalidate_inode_pages2_range(mapping,
>                         pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> -       if (ret)
> -               dio_warn_stale_pagecache(iocb->ki_filp);
> -       ret =3D 0;
> +       /*
> +        * If a page can not be invalidated, return 0 to fall back
> +        * to buffered write.
> +        */
> +       if (ret) {
> +               if (ret =3D=3D -EBUSY)
> +                       ret =3D 0;
> +               goto out_free_dio;
> +       }
>
>         if (iov_iter_rw(iter) =3D=3D WRITE && !wait_for_completion &&
>             !inode->i_sb->s_dio_done_wq) {
>
>

Thanks. As I just replied on another thread for that patch, we
actually have a regression.
There's more than the annoying warning in dmesg, it also sets -EIO on
the inode's mapping and makes future fsyncs return that error despite
the fact that no actual errors or corruptions happened:

https://patchwork.kernel.org/patch/11576677/



>
> --
> Goldwyn



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
