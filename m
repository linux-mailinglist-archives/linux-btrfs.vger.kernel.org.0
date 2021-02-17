Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430BA31D3E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Feb 2021 03:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhBQCGd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 21:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhBQCGb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 21:06:31 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDC0C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 18:05:49 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id p193so12358810yba.4
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 18:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EZ+HzO5sX4wrYvSQlGtjKLQh/1MocsCRmeBIizuC6e0=;
        b=sPFx4G3f0nacDgq0R9gDC8ApUlF5o+vRj0UP4bUsOnwW/j6M077rEoUaloiVRvQyTb
         DPt1BBE9HfuzpY9v6g3ZSnKPW3F70M4kbHBEYMW8AMRg8KqfUJVgwzp1FTu3damt/yfs
         sKAKftkDEUZx0ZuMeUQXaNLnQ0x+sBXwQ7qglo879swA/IJBeBDypU7vKKOwdNSw+pFC
         DMNS63tznkJWtmDpp6HOYNNl9h+3d3xyz8SOYq8cfiIUwUEOQQROXmJoMfJ8cZbaxUgc
         vby4U14Vu7DPfvLbDff2ORUuI0tylPTQdalus5a0lCn07HRyoZxMaiiAby44y4codGj2
         pxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EZ+HzO5sX4wrYvSQlGtjKLQh/1MocsCRmeBIizuC6e0=;
        b=aVvvQhAspLiMS3zP/JDFHLFho7Unbxaatqwz68r5Dzeiv0sXH9iIJ5Q2s1bb/bUSJE
         +VDxF4++wa8HdlcTj0SNczukdbOeHdKpV0Pva7xOp0hZGbEjimme+WyXNWODt4JJ0ZPf
         DrQsWLQd/mWQTsSHTWvFYERzZlDoWrUYWUaVgsfl55eVNpYLB4ntfGYkvpwLsgZhqFfy
         oBIt0UMfCKTISvDuoYIo3/JEiflAqB+Mo4hMKxi0iz+0jlTC+Viln33KBYs9U3ILXPf9
         HdQpCaqcYhieIoUH6ua+6tELhsWd23jg699YerdlaulLW8Pl7vayv+yvzIhJt1JLKbzs
         lKsA==
X-Gm-Message-State: AOAM5324grkvmIgpPNCXfbkcBxfQW805nIlKu8K5vD7aB01ya2TKoGRD
        L4MBusAF60B+wIU3IKN2CJZJAthv08RTxntkeWC0HusuuMzVDg==
X-Google-Smtp-Source: ABdhPJxwHyc3/oyL57HPcP+eAdqefDx6sdGFiTGq3BFo6HdmrFiomdQqFzme+gq+JiO+7QltAbw+6nRoluKU6RFC5lE=
X-Received: by 2002:a25:424f:: with SMTP id p76mr25161366yba.109.1613527549140;
 Tue, 16 Feb 2021 18:05:49 -0800 (PST)
MIME-Version: 1.0
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
 <0c4701b2-23ef-fd7a-d198-258b49eedea8@toxicpanda.com> <CAEg-Je9NGV0Mvhw7v8CwcyAZ9zd9T5Fmk2iQyZ1PFWVUOXaP+Q@mail.gmail.com>
 <90da9117-6b02-3c27-17a0-ff497eb04496@toxicpanda.com> <CAEg-Je-zRWrkKOQM-Y_Y17eHhUrJe+d1_H9iLzQB4w7T+Een=w@mail.gmail.com>
 <74ca64e1-3933-c12b-644a-21745cf2d849@toxicpanda.com>
In-Reply-To: <74ca64e1-3933-c12b-644a-21745cf2d849@toxicpanda.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Tue, 16 Feb 2021 21:05:13 -0500
Message-ID: <CAEg-Je9FZhLMx0MuxhyhTDUsRzfbi2_VZsHa3Bs+46jY8F82ZA@mail.gmail.com>
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 16, 2021 at 4:24 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 2/16/21 3:29 PM, Neal Gompa wrote:
> > On Tue, Feb 16, 2021 at 1:11 PM Josef Bacik <josef@toxicpanda.com> wrot=
e:
> >>
> >> On 2/16/21 11:27 AM, Neal Gompa wrote:
> >>> On Tue, Feb 16, 2021 at 10:19 AM Josef Bacik <josef@toxicpanda.com> w=
rote:
> >>>>
> >>>> On 2/14/21 3:25 PM, Neal Gompa wrote:
> >>>>> Hey all,
> >>>>>
> >>>>> So one of my main computers recently had a disk controller failure
> >>>>> that caused my machine to freeze. After rebooting, Btrfs refuses to
> >>>>> mount. I tried to do a mount and the following errors show up in th=
e
> >>>>> journal:
> >>>>>
> >>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): d=
isk space caching is enabled
> >>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): h=
as skinny extents
> >>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3=
): corrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D203657, inval=
id inode transid: has 888896 expect [0, 888895]
> >>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): =
block=3D796082176 read time tree block corruption detected
> >>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3=
): corrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D203657, inval=
id inode transid: has 888896 expect [0, 888895]
> >>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): =
block=3D796082176 read time tree block corruption detected
> >>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS warning (device sda3)=
: couldn't read tree root
> >>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): =
open_ctree failed
> >>>>>
> >>>>> I've tried to do -o recovery,ro mount and get the same issue. I can=
't
> >>>>> seem to find any reasonably good information on how to do recovery =
in
> >>>>> this scenario, even to just recover enough to copy data off.
> >>>>>
> >>>>> I'm on Fedora 33, the system was on Linux kernel version 5.9.16 and
> >>>>> the Fedora 33 live ISO I'm using has Linux kernel version 5.10.14. =
I'm
> >>>>> using btrfs-progs v5.10.
> >>>>>
> >>>>> Can anyone help?
> >>>>
> >>>> Can you try
> >>>>
> >>>> btrfs check --clear-space-cache v1 /dev/whatever
> >>>>
> >>>> That should fix the inode generation thing so it's sane, and then th=
e tree
> >>>> checker will allow the fs to be read, hopefully.  If not we can work=
 out some
> >>>> other magic.  Thanks,
> >>>>
> >>>> Josef
> >>>
> >>> I got the same error as I did with btrfs-check --readonly...
> >>>
> >>
> >> Oh lovely, what does btrfs check --readonly --backup do?
> >>
> >
> > No dice...
> >
> > # btrfs check --readonly --backup /dev/sda3
> >> Opening filesystem to check...
> >> parent transid verify failed on 791281664 wanted 888893 found 888895
> >> parent transid verify failed on 791281664 wanted 888893 found 888895
> >> parent transid verify failed on 791281664 wanted 888893 found 888895
>
> Hey look the block we're looking for, I wrote you some magic, just pull
>
> https://github.com/josefbacik/btrfs-progs/tree/for-neal
>
> build, and then run
>
> btrfs-neal-magic /dev/sda3 791281664 888895
>
> This will force us to point at the old root with (hopefully) the right by=
tenr
> and gen, and then hopefully you'll be able to recover from there.  This i=
s kind
> of saucy, so yolo, but I can undo it if it makes things worse.  Thanks,
>

# btrfs check --readonly /dev/sda3
> Opening filesystem to check...
> ERROR: could not setup extent tree
> ERROR: cannot open file system
# btrfs check --clear-space-cache v1 /dev/sda3
> Opening filesystem to check...
> ERROR: could not setup extent tree
> ERROR: cannot open file system

It's better, but still no dice... :(


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
