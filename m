Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5E7511F183
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2019 12:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbfLNLVX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 14 Dec 2019 06:21:23 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:46581 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfLNLVX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 Dec 2019 06:21:23 -0500
Received: by mail-vk1-f193.google.com with SMTP id u6so426280vkn.13
        for <linux-btrfs@vger.kernel.org>; Sat, 14 Dec 2019 03:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=LqDSZkZuqaZ+b0Gr2Jrsp1k7wmHA0yiyKNdvsL4mMsY=;
        b=gGybVfpjw/CH52em4o2oO94m4g4plHMoFlZF2utT0V4Bpg9tmtUnOchjEN55A5kW/9
         5bp4CVf3o+F5+DD/H47o7Onk4QwssrIQd8gCmL2KAZQLuqwjX7Fi43ncBM6Uvs5asQBy
         rI7/sO8POldpWkUM1bStkI8gAEjPr817azSY7Ua7HZZmz6IlCn/9jC7MC7LMnKazH4ix
         QTAVYUauL3aAUdL4A9tdpdgnaeQallPbCbzh9z3NmaDLXGSKCsIn7NevylvHnnLacU9F
         dIJrCDxQ23N88yyUmOeEd0X3lzAfH5j1RmSMlSrtntTdnQRKtcEmcU+kMC5uCkdxRmec
         Y4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=LqDSZkZuqaZ+b0Gr2Jrsp1k7wmHA0yiyKNdvsL4mMsY=;
        b=N5CjBkJSsVIdTkhNGBdzSNthEiH82gXEmRdBICZnyI6G7zw2Q7xnDh6Uko6bwsj3o5
         bYD4S6JGOQqnVFMUyGSZI3yGma2CEN1hzs+K5teR2rFNMqax34YlbU/YGLXiwOq3l+Cy
         ynCCWXXfBO60kAueGk0kSSm8FJ7MbG2DMwFY20Q/EU1HnwNARpaf1ppfRpJuxxnhH2Cb
         H8tb21UnHwMUarJe6VOZSsaV8xSDKLdg/FEgr9N7OKn4+m2TKaupFRcMouLRPrn7W2kp
         v6eQitwwTYQr/oZYwIRLuCW7bjMWCzZYkDUaPZ1/Z6qQsMNln0tT1qnJu0RcdfF4NeVB
         Z4pQ==
X-Gm-Message-State: APjAAAVRNtNuSiZ9qDPJpdSvzfaq78uUMC15EpkQiXWJ0EIaUFoXISdz
        frUS7Q2KXA5eQyj3GJmEiEPZwJ88RFVbkjYToRU=
X-Google-Smtp-Source: APXvYqyC30K3Dxn2Ek9l6Fv9G3h5PbsARRnp21BZ+WM5XBuMBvrokuc6mQSBWOJTacUXc9O+PV5yl3T/pGwQ2wWhKUk=
X-Received: by 2002:a1f:2753:: with SMTP id n80mr17779566vkn.24.1576322482104;
 Sat, 14 Dec 2019 03:21:22 -0800 (PST)
MIME-Version: 1.0
References: <2019-1576167349.500456@svIo.N5dq.dFFD> <691d3af5-da85-5381-7db3-c4ef011b1e4a@gmx.com>
 <20191214051938.GA13306@hungrycats.org>
In-Reply-To: <20191214051938.GA13306@hungrycats.org>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Sat, 14 Dec 2019 11:21:11 +0000
Message-ID: <CAL3q7H6Rj7VzdBh_bZaqosTwrBFgDs6jj0St5rqThvo-PCGO-g@mail.gmail.com>
Subject: Re: FIDEDUPERANGE woes
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, halfdog <me@halfdog.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Dec 14, 2019 at 5:46 AM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On Fri, Dec 13, 2019 at 05:32:14PM +0800, Qu Wenruo wrote:
> >
> >
> > On 2019/12/13 =E4=B8=8A=E5=8D=8812:15, halfdog wrote:
> > > Hello list,
> > >
> > > Using btrfs on
> > >
> > > Linux version 5.3.0-2-amd64 (debian-kernel@lists.debian.org) (gcc ver=
sion 9.2.1 20191109 (Debian 9.2.1-19)) #1 SMP Debian 5.3.9-3 (2019-11-19)
> > >
> > > the FIDEDUPERANGE exposes weird behaviour on two identical but
> > > not too large files that seems to be depending on the file size.
> > > Before FIDEDUPERANGE both files have a single extent, afterwards
> > > first file is still single extent, second file has all bytes sharing
> > > with the extent of the first file except for the last 4096 bytes.
> > >
> > > Is there anything known about a bug fixed since the above mentioned
> > > kernel version?
> > >
> > >
> > >
> > > If no, does following reproducer still show the same behaviour
> > > on current Linux kernel (my Python test tools also attached)?
> > >
> > >> dd if=3D/dev/zero bs=3D1M count=3D32 of=3Ddisk
> > >> mkfs.btrfs --mixed --metadata single --data single --nodesize 4096 d=
isk
> > >> mount disk /mnt/test
> > >> mkdir /mnt/test/x
> > >> dd bs=3D1 count=3D155489 if=3D/dev/urandom of=3D/mnt/test/x/file-0
> >
> > 155489 is not sector size aligned, thus the last extent will be padded
> > with zero.
> >
> > >> cat /mnt/test/x/file-0 > /mnt/test/x/file-1
> >
> > Same for the new file.
> >
> > For the tailing padding part, it's not aligned, and it's smaller than
> > the inode size.
> >
> > Thus we won't dedupe that tailing part.
>
> We definitely *must* dedupe the tailing part on btrfs; otherwise, we can'=
t
> eliminate the reference to the last (partial) block in the last extent of
> the file, and there is no way to dedupe the _entire_ file in this example=
.
> It does pretty bad things to dedupe hit rates on uncompressed contiguous
> files, where you can lose an average of 64MB of space per file.
>
> I had been wondering why dedupe scores seemed so low on recent kernels,
> and this bug would certainly contribute to that.
>
> It worked in 4.20, broken in 5.0.  My guess is commit
> 34a28e3d77535efc7761aa8d67275c07d1fe2c58 ("Btrfs: use
> generic_remap_file_range_prep() for cloning and deduplication") but I
> haven't run a test to confirm.

The problem comes from the generic (vfs) code, which always rounds
down the deduplication length to a multiple of the filesystem's sector
size.
That should be done only when the destination range's end does not
match the destination's file size, to avoid the corruption I found
over a year ago [1].
For some odd reason it has the correct behavior for cloning, it only
rounds down the destination range's end is less then the destination's
file size.

I'll see if I get that fixed next week.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dde02b9f6bb65a6a1848f346f7a3617b7a9b930c0

>
>
> > Thanks,
> > Qu
> >
> > >
> > >> ./SimpleIndexer x > x.json
> > >> ./IndexDeduplicationAnalyzer --IndexFile /mnt/test/x.json /mnt/test/=
x > dedup.list
> > > Got dict: {b'/mnt/test/x/file-0': [(0, 5316608, 155648)], b'/mnt/test=
/x/file-1': [(0, 5472256, 155648)]}
> > > ...
> > >> strace -s256 -f btrfs-extent-same 155489 /mnt/test/x/file-0 0 /mnt/t=
est/x/file-1 0 2>&1 | grep -E -e FIDEDUPERANGE
> > > ioctl(3, BTRFS_IOC_FILE_EXTENT_SAME or FIDEDUPERANGE, {src_offset=3D0=
, src_length=3D155489, dest_count=3D1, info=3D[{dest_fd=3D4, dest_offset=3D=
0}]} =3D> {info=3D[{bytes_deduped=3D155489, status=3D0}]}) =3D 0
> > >> ./IndexDeduplicationAnalyzer --IndexFile /mnt/test/x.json /mnt/test/=
x > dedup.list
> > > Got dict: {b'/mnt/test/x/file-0': [(0, 5316608, 155648)], b'/mnt/test=
/x/file-1': [(0, 5316608, 151552), (151552, 5623808, 4096)]}
> > > ...
> > >> strace -s256 -f btrfs-extent-same 155489 /mnt/test/x/file-0 0 /mnt/t=
est/x/file-1 0 2>&1 | grep -E -e FIDEDUPERANGE
> > > ioctl(3, BTRFS_IOC_FILE_EXTENT_SAME or FIDEDUPERANGE, {src_offset=3D0=
, src_length=3D155489, dest_count=3D1, info=3D[{dest_fd=3D4, dest_offset=3D=
0}]} =3D> {info=3D[{bytes_deduped=3D155489, status=3D0}]}) =3D 0
> > >> strace -s256 -f btrfs-extent-same 4096 /mnt/test/x/file-0 151552 /mn=
t/test/x/file-1 151552 2>&1 | grep -E -e FIDEDUPERANGE
> > > ioctl(3, BTRFS_IOC_FILE_EXTENT_SAME or FIDEDUPERANGE, {src_offset=3D1=
51552, src_length=3D4096, dest_count=3D1, info=3D[{dest_fd=3D4, dest_offset=
=3D151552}]}) =3D -1 EINVAL (Invalid argument)
> > >
> >
>
>
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
