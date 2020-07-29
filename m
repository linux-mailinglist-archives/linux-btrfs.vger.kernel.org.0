Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DFA231776
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 03:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbgG2B4m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jul 2020 21:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730428AbgG2B4m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jul 2020 21:56:42 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0033C061794
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jul 2020 18:56:41 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t18so18057646ilh.2
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jul 2020 18:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HxXh8ZqXR/s1wh0hmezkFfBVSyLch9IEByRJpIDUGQM=;
        b=L8EwWfEzf62ymS1QZT39CMT0dYJDqVdtEsPVr6y+8tT6oH0HQRVcu7tJHudgGburkc
         cggmatG9Ew/oKqEFjwrEqAN+osaopMpY+7fcUQRYHebzoI7G+KBDh2/IL4xDg/TC2ZMD
         m9lUuBTfNLIQHGA5XUsC5lo9tIQ6RqGrcFpJLgkT1s2l4XMZZo0rflFUgvSYG7wf8X08
         u/TXhRbRBMCtyY9Aj1SqqL7y0YtWaOsXM/pC6bnqpliLjPk1Rc3CUS+s2egH//dPecwI
         gNHvNL+WzD1KyK9mYivyL0d1/Von7FMCOWjQCCC6lY+Egbo13tD+HCtO+L5VC4BveglX
         UdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HxXh8ZqXR/s1wh0hmezkFfBVSyLch9IEByRJpIDUGQM=;
        b=rmtaZYVf8/Ar4tC1WwZWJ6zdjdCVjIrgLCljaSa934eCNT0GFtHc631Gs6VXkniMjR
         VgCHicE8vc07AE/SJ78YlzrxLOqsZ6cIbHdpZOx5Cjy4OIr6HvFZwQBTLZdGckeB0RYv
         2r5ZbgamKDx5LNyNIk+C6S1w4BZb0HJ9Y5EZhxSsDTCG6hFpEflsEYTREu2uY+OeXkw8
         AzsR+G0HxoxTdGCmhQfTkGI9owzoIvTIMRIzGtqUR1nchB5bJjIpspd8uGMMHJ22dePL
         N6CN+wdndqJBwuaSXmn0Sp0+UHD4J/+1sD1pxAW/a4KNhU7Q82vYkf+OuWhzLvsuzn+v
         FlfQ==
X-Gm-Message-State: AOAM5300okMfKmttKjVyZhsoGloHa8eJwAy87jR5sin59dEu7jB5CzKI
        Cdy/RE8tfEgjPJp2va6KRvZQrP09EmWeAtMcSlzq8dfAT7k=
X-Google-Smtp-Source: ABdhPJzRp/JKhkxW4E5xWgd25wrB1zhDqC43N4jxMrkEiZQ0IvA0IeCyKyrrCwxpqlT7ydD8QkDaMB66M/HqG5VviQA=
X-Received: by 2002:a92:5a92:: with SMTP id b18mr27350967ilg.9.1595987801254;
 Tue, 28 Jul 2020 18:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200720125109.93970-1-wqu@suse.com> <20200720160945.GH3703@twin.jikos.cz>
 <cf6386e1-a13b-e7cf-a365-db33a3afe2a9@gmx.com> <20200721095826.GJ3703@twin.jikos.cz>
 <0d3eb6c1-f88a-e7cd-7d12-92bce0f2025c@suse.com> <20200721135533.GL3703@twin.jikos.cz>
 <cccdcdc8-db5a-779d-7b99-346ef14133e5@gmx.com> <20200722113220.GR3703@twin.jikos.cz>
 <CAEg-Je-QVTWQeFg1gJMSXcBHzniSjMNxSXiN2L++_YVeTwZH_g@mail.gmail.com>
 <493ab1f9-9f58-6d8e-647a-9092e1e0480f@gmx.com> <CAEg-Je-VLKs1XO+PocCDVPb8mQPFbXZxYmC7CRnCqkSxVk1EBw@mail.gmail.com>
 <b49639fb-20c4-6944-1109-57c7a19c8039@gmx.com>
In-Reply-To: <b49639fb-20c4-6944-1109-57c7a19c8039@gmx.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Tue, 28 Jul 2020 21:56:05 -0400
Message-ID: <CAEg-Je8TAWG-mnBs1657CTuNNDyvO52t99v4ncO6NfK_V0H2_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs-progs: convert: Prevent bit overflow for cctx->total_bytes
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Christian Zangl <coralllama@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 28, 2020 at 9:20 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/7/28 =E4=B8=8B=E5=8D=889:14, Neal Gompa wrote:
> > On Thu, Jul 23, 2020 at 8:02 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
> >>
> >>
> >>
> >> On 2020/7/23 =E4=B8=8B=E5=8D=889:31, Neal Gompa wrote:
> >>> On Wed, Jul 22, 2020 at 7:33 AM David Sterba <dsterba@suse.cz> wrote:
> >>>>
> >>>> On Wed, Jul 22, 2020 at 06:58:39AM +0800, Qu Wenruo wrote:
> >>>>>>> Thus casting both would definitely be right, without the need to =
refer
> >>>>>>> to the complex rule book, thus save the reviewer several minutes.
> >>>>>>
> >>>>>> The opposite, if you send me code that's not following known schem=
es or
> >>>>>> idiomatic schemes I'll be highly suspicious and looking for the re=
asons
> >>>>>> why it's that way and making sure it's correct costs way more time=
.
> >>>>>>
> >>>>> OK, then would you please remove one casting at merge time, or do I=
 need
> >>>>> to resend?
> >>>>
> >>>> Yeah, I fix such things routinely no need to resend.
> >>>
> >>> I have a report[1] that seems to look like this patch solves it, is
> >>> that correct?
> >>>
> >>> [1]: https://bugzilla.redhat.com/show_bug.cgi?id=3D1851674#c7
> >>>
> >> Yep, looks like the same bug.
> >>
> >
> > So I backported this fix into btrfs-progs-5.7-4.fc32[1], and the
> > reporter is still seeing issues[2].
> >
> > Pasting from the bug comment[2]:
> >
> > [liveuser@localhost-live ~]$ sudo btrfs-convert /dev/sda2
> > create btrfs filesystem:
> >     blocksize: 4096
> >     nodesize:  16384
> >     features:  extref, skinny-metadata (default)
> >     checksum:  crc32c
> > creating ext2 image file
> > creating btrfs metadata
> > convert/source-ext2.c:845: ext2_copy_inodes: BUG_ON `ret` triggered, va=
lue -28
>
> This means we have no space left.
>
> We don't know if it's the fs already exhausted (little space left for
> EXT*), or it's btrfs' extent allocator not working.
>
> Would it possible to update the image?
>

I'm not sure what you're asking here? Do you mean update the live
environment? You can boot a Fedora 32 live environment and update the
btrfs-progs package before using it like the bug reporter did...

> BTW, even btrfs-convert crashed, the fs should be completely fine, just
> as nothing happened to it (from the point of view of ext*)
>

I figured as much, but we shouldn't have a case where btrfs-convert
crashes like this...





--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
