Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF30C230B39
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 15:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbgG1NO6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jul 2020 09:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729853AbgG1NO6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jul 2020 09:14:58 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3A8C061794
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jul 2020 06:14:57 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id d18so20676599ion.0
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jul 2020 06:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wBbpxXe88STB9KjmaWhsjSYXpMq0wp1WBH8pKpGZ8IY=;
        b=aaIDLhD/aif/ECnSg19ggS/9vLYJZYZ7B/slK5vfEwDYwgqzxFQ4B3j6OhvH5Y4+lo
         YlNIq4RlfGDDR+HrWrB+9D+6OhOnxgULbpxw+RWS3xHzkQjv77mSk7hdlNjWJd/Z2wNP
         aYanehuFWFe3drdzHRTGix/qUkFyv83DKXi2t7mrioU9atgZlvVR33c/O4XbajVLT9vM
         Nq3oMoKziMsbOjmpeYK0JZEYkxNd68kfyQpkKKhIioR6HOivxYEmyehzG11VXMPtc6Td
         m8rFeUvjV9tXhyotms3GFcXnLc121tR+GWj80Yr5zEbWpZmhZsNnrNwTx/IXuRfh42qs
         BJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wBbpxXe88STB9KjmaWhsjSYXpMq0wp1WBH8pKpGZ8IY=;
        b=mXxPDHaDVSRmotoJGk8rdGg9frzLh3heiuVvK3caSs8SC96fSY+6mAGyBS4R9u9+c5
         uy2iOXNLj6gUhvx7ka4Z38u1bIWHouwPrde0pFW801iEBeO76ONwt7/76rSTthV6hsNo
         /WnR2ZkLWbt0ZLuWp5kZkbHJN+Xv6lJFW+VPoH1rP9eUfjulsi32sgcU8l3aupSGRZ3h
         t4KsOvw53PcFkeuLMty2F3gQQ+4OYocBp65ylWocMJ3XtTUcUcXIbAKevk6GMLO1cx4z
         u/adShwlx7fxnobjuE62lpGDrxOzwuiFFgss+L+Ty2gFSJ/0hW8BRb5YRinai0Qj8dkq
         oULw==
X-Gm-Message-State: AOAM5328QSDpS2Hc1bb3/R+WtVIkJ67DyFpZEs8umDFwSL3/NgOeOL2O
        nlxqEiW3N+mDA1oporZNZnmMASIAvUqPn9iMhzY=
X-Google-Smtp-Source: ABdhPJwXbUB+zQlCWcm6fDWpJjdnbXavUOKu0RoO32BJvGG1SHS5X+o51bNglCXVco50oARGYHWerZW4gdzxlgngeck=
X-Received: by 2002:a02:b610:: with SMTP id h16mr18512058jam.74.1595942097297;
 Tue, 28 Jul 2020 06:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200720125109.93970-1-wqu@suse.com> <20200720160945.GH3703@twin.jikos.cz>
 <cf6386e1-a13b-e7cf-a365-db33a3afe2a9@gmx.com> <20200721095826.GJ3703@twin.jikos.cz>
 <0d3eb6c1-f88a-e7cd-7d12-92bce0f2025c@suse.com> <20200721135533.GL3703@twin.jikos.cz>
 <cccdcdc8-db5a-779d-7b99-346ef14133e5@gmx.com> <20200722113220.GR3703@twin.jikos.cz>
 <CAEg-Je-QVTWQeFg1gJMSXcBHzniSjMNxSXiN2L++_YVeTwZH_g@mail.gmail.com> <493ab1f9-9f58-6d8e-647a-9092e1e0480f@gmx.com>
In-Reply-To: <493ab1f9-9f58-6d8e-647a-9092e1e0480f@gmx.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Tue, 28 Jul 2020 09:14:21 -0400
Message-ID: <CAEg-Je-VLKs1XO+PocCDVPb8mQPFbXZxYmC7CRnCqkSxVk1EBw@mail.gmail.com>
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

On Thu, Jul 23, 2020 at 8:02 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/7/23 =E4=B8=8B=E5=8D=889:31, Neal Gompa wrote:
> > On Wed, Jul 22, 2020 at 7:33 AM David Sterba <dsterba@suse.cz> wrote:
> >>
> >> On Wed, Jul 22, 2020 at 06:58:39AM +0800, Qu Wenruo wrote:
> >>>>> Thus casting both would definitely be right, without the need to re=
fer
> >>>>> to the complex rule book, thus save the reviewer several minutes.
> >>>>
> >>>> The opposite, if you send me code that's not following known schemes=
 or
> >>>> idiomatic schemes I'll be highly suspicious and looking for the reas=
ons
> >>>> why it's that way and making sure it's correct costs way more time.
> >>>>
> >>> OK, then would you please remove one casting at merge time, or do I n=
eed
> >>> to resend?
> >>
> >> Yeah, I fix such things routinely no need to resend.
> >
> > I have a report[1] that seems to look like this patch solves it, is
> > that correct?
> >
> > [1]: https://bugzilla.redhat.com/show_bug.cgi?id=3D1851674#c7
> >
> Yep, looks like the same bug.
>

So I backported this fix into btrfs-progs-5.7-4.fc32[1], and the
reporter is still seeing issues[2].

Pasting from the bug comment[2]:

[liveuser@localhost-live ~]$ sudo btrfs-convert /dev/sda2
create btrfs filesystem:
    blocksize: 4096
    nodesize:  16384
    features:  extref, skinny-metadata (default)
    checksum:  crc32c
creating ext2 image file
creating btrfs metadata
convert/source-ext2.c:845: ext2_copy_inodes: BUG_ON `ret` triggered, value =
-28
btrfs-convert(+0x13589)[0x558cfe4a6589]
btrfs-convert(+0x14549)[0x558cfe4a7549]
btrfs-convert(main+0xfc0)[0x558cfe4a22b0]
/lib64/libc.so.6(__libc_start_main+0xf2)[0x7fd2c6666042]
btrfs-convert(_start+0x2e)[0x558cfe4a35ce]
Aborted

Any idea what's going on here?


[1]: https://src.fedoraproject.org/rpms/btrfs-progs/c/e4a3d39e87313954cb3e8=
214e28ee0ba50bee874
[2]: https://bugzilla.redhat.com/show_bug.cgi?id=3D1851674#c13

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
