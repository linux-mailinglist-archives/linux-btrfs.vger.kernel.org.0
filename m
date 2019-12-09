Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD141164D7
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 02:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLIBvO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Dec 2019 20:51:14 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44625 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfLIBvO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Dec 2019 20:51:14 -0500
Received: by mail-io1-f66.google.com with SMTP id z23so12974323iog.11
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Dec 2019 17:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1f1Bqlv1Nq1kZ63hk087dqMbrdEWFg9+1OO3bcVaRxA=;
        b=QD+gRE/1WIxczl3C4qbvqkyyVdEmRKpv8yNTf8sa1aDpk+of1ITaQG6ioK2psr8QMS
         Xo+aK+2nS6vTouNVdvIreXn5hUqteiRjzSriYPnFjN8x6duoyEnu/hFFTRmNdcpsQj1+
         i6mAS2hRTQoFn00o0E/wI6bbF8OGxoRu3bHWM+iOU2PsmuyIew2OhJYClueRo28UMtz0
         3HFa+iOt7Ll9zr1e5QB7UYIVANIoTcHJPq4094Z0D3GS7s2oCzpfEhky5vPJm1McST3F
         iFW9mN9+WcXT8UKNQioihIn7Ho+LKWAGP41O1l41tjOuhtipmNoxoQuRde0AtV2fNuTh
         REGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1f1Bqlv1Nq1kZ63hk087dqMbrdEWFg9+1OO3bcVaRxA=;
        b=QltZvPBHmq442Dm85CJwiFhdfkX3o3vryd4vlVoOxL6SKUz+ZwCmQelor3A14WEq3W
         cUZ5ljLnqkKE45FdR6XOyvz3o/tLcakfNI6v/aag1eDvsAfTEVoWVORWQ2wJG1tylUO8
         xAt8jIpwVINhJ8pTO9WcHuKMyCPEcI5oZVfrE3nqYLjC4V1yBKbq+iHmUpgsr9kk4r1P
         hOUi/XhQfh2hvHjHn7HuJQCb48+fYCnjiemtSXdhcv25uO4yEo+iJG6c+2HTx8joggF4
         cjUw0pTriOkptsod9xPf4gRwcbjohrZ0nBSCh7N8hJs26pvPRtSRBbCaqFseJnUypCZD
         S1EQ==
X-Gm-Message-State: APjAAAVvfobiHALJyTgKS4xYWZdGDUYj0xH0pLW5BnSe+ZKzGvd2igeb
        g2+V2Dzd+vdLi8w8T8TpVsm2yypQV0xohKgxpIJeNc/prJU=
X-Google-Smtp-Source: APXvYqzZqcxB6OqRlqVlpPxdqtImnrhy5RW0R9pl3xp4X4Eebx20c5Bw12lhCWhH4ZCq70f8k+ch9CuI+v95rDy++5I=
X-Received: by 2002:a6b:4f0b:: with SMTP id d11mr18683860iob.30.1575856273073;
 Sun, 08 Dec 2019 17:51:13 -0800 (PST)
MIME-Version: 1.0
References: <CAJ0EP41toGSPQwB4Ys4aNzGGJNDBS-NHgPOcGanBk6d6Nn_LWw@mail.gmail.com>
 <5eae7d6d-a462-53f4-df0c-3b273426e2b2@gmx.com> <CAJ0EP40Wj59=CevVnn1rjxoc4CtGqbRjKFBSbU8BsrSjRC48ng@mail.gmail.com>
 <6c3454b9-cc23-d22b-c3a7-59697add9b88@gmx.com> <CAJ0EP40a6DpTu1YmMtBezun58pfFXhWwYEXpnnGLkup0OvLQPw@mail.gmail.com>
 <ae3289dd-c1f0-3aa8-dfbb-240ec4952b6e@gmx.com>
In-Reply-To: <ae3289dd-c1f0-3aa8-dfbb-240ec4952b6e@gmx.com>
From:   Mike Gilbert <floppymaster@gmail.com>
Date:   Sun, 8 Dec 2019 20:51:01 -0500
Message-ID: <CAJ0EP40UUPe9VrF1x8mxnEhFxiTzgC9DkQZB684UuMF1571D+Q@mail.gmail.com>
Subject: Re: Unable to remove directory entry
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 8, 2019 at 8:45 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/12/9 =E4=B8=8A=E5=8D=889:31, Mike Gilbert wrote:
> > On Sun, Dec 8, 2019 at 7:41 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
> >>
> >>
> >>
> >> On 2019/12/9 =E4=B8=8A=E5=8D=888:30, Mike Gilbert wrote:
> >>> On Sun, Dec 8, 2019 at 7:11 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
> >>>>
> >>>>
> >>>>
> >>>> On 2019/12/9 =E4=B8=8A=E5=8D=883:19, Mike Gilbert wrote:
> >>>>> Hello,
> >>>>>
> >>>>> I have a directory entry that cannot be stat-ed or unlinked. This
> >>>>> issue persists across reboots, so it seems there is something wrong=
 on
> >>>>> disk.
> >>>>>
> >>>>> % ls -l /var/cache/ccache.bad/2/c
> >>>>> ls: cannot access
> >>>>> '/var/cache/ccache.bad/2/c/0390cb341d248c589c419007da68b2-7351.mani=
fest':
> >>>>> No such
> >>>>> file or directory
> >>>>> total 0
> >>>>> -????????? ? ? ? ?            ? 0390cb341d248c589c419007da68b2-7351=
.manifest
> >>>>
> >>>> Dmesg if any, please.
> >>>
> >>> There's nothing btrfs-related in the dmesg output.
> >>>
> >>>>>
> >>>>> % uname -a
> >>>>> Linux naomi 4.19.67 #4 SMP Sun Aug 18 14:35:39 EDT 2019 x86_64 AMD
> >>>>> Phenom(tm) II X6 1055T Processor
> >>>>> AuthenticAMD GNU/Linux
> >>>>
> >>>> The kernel is not new enough to btrfs' standard.
> >>>>
> >>>> For this possibility name hash mismatch bug, newer kernel will repor=
ted
> >>>> detailed problems.
> >>>
> >>> Would 4.19.88 suffice, or do I need to switch to a newer release bran=
ch?
> >>>
> >> I'd recommend to go at least latest LTS (v5.3.x).
> >>
> >> .88 is just backports, nothing really different. And sometimes big fix=
es
> >> won't get backported.
> >
> > I upgraded to linux-5.4.2, and attempted to remove the file, with the
> > same results.
> >
> > ls: cannot access
> > '/var/cache/ccache.bad/2/c/0390cb341d248c589c419007da68b2-7351.manifest=
':
> > No such
> > file or directory
> > total 0
> > -????????? ? ? ? ?            ? 0390cb341d248c589c419007da68b2-7351.man=
ifest
> >
> > rm: cannot remove
> > '/var/cache/ccache.bad/2/c/0390cb341d248c589c419007da68b2-7351.manifest=
':
> > No such
> > file or directory
> >
> > I don't see any output in dmesg. Is there some option I need to enable?
> >
> Then it's not name hash mismatch, but just index mismatch.
>
> In that case, kernel won't detect such problem by tree-checker. I'll
> update tree-checker to handle the case.
>
> I guess the only way to fix it is to rely on btrfs check --mode=3Dlowmem
> --repair.
> But before that, would you please provde the following dump? So that I
> can be sure before crafting the enhanced tree-checker patch.
>
> # btrfs ins dump-tree -t 5 /dev/sda3 | grep "(4065004 INO" -A7
> # btrfs ins dump-tree -t 5 /dev/sda3 | grep "(486836.*13905)" -A7
> # btrfs ins dump-tree -t 5 /dev/sda3 | grep "(486836.*2543451757)" -A7

Here you go.

I ran this while the filesystem was mounted; if you need it to be run
while offline, I'll have to fire up a livecd.

                location key (4065004 INODE_ITEM 1073741824) type FILE
               transid 21397 data_len 0 name_len 44
               name: 0390cb341d248c589c419007da68b2-7351.manifest
       item 63 key (486836 DIR_INDEX 13905) itemoff 6199 itemsize 74
               location key (4065004 INODE_ITEM 0) type FILE
               transid 21397 data_len 0 name_len 44
               name: 0390cb341d248c589c419007da68b2-7351.manifest
leaf 533498265600 items 128 free space 6682 generation 176439 owner FS_TREE
leaf 533498265600 flags 0x1(WRITTEN) backref revision 1
fs uuid 5e9dcab6-036d-40f1-8b40-24ab4c062bf6
chunk uuid 0be705de-5d3b-4c23-979e-d7aaad224cfb
       item 0 key (1059762 INODE_ITEM 0) itemoff 16123 itemsize 160
--
       item 6 key (4065004 INODE_ITEM 0) itemoff 15158 itemsize 160
               generation 21397 transid 21397 size 12261 nbytes 12288
               block group 0 mode 100644 links 1 uid 250 gid 250 rdev 0
               sequence 23 flags 0x0(none)
               atime 1565546668.383680243 (2019-08-11 14:04:28)
               ctime 1565546668.383680243 (2019-08-11 14:04:28)
               mtime 1565546668.383680243 (2019-08-11 14:04:28)
               otime 1565546668.336681213 (2019-08-11 14:04:28)
       item 7 key (4065004 INODE_REF 486836) itemoff 15104 itemsize 54
               index 13905 namelen 44 name:
0390cb341d248c589c419007da68b2-7351.manifest
       item 8 key (4065004 EXTENT_DATA 0) itemoff 15051 itemsize 53
               generation 21397 type 1 (regular)
               extent data disk byte 6288928768 nr 12288
               extent data offset 0 nr 12288 ram 12288
               extent compression 0 (none)
       item 9 key (4210974 INODE_ITEM 0) itemoff 14891 itemsize 160
       item 63 key (486836 DIR_INDEX 13905) itemoff 6199 itemsize 74
               location key (4065004 INODE_ITEM 0) type FILE
               transid 21397 data_len 0 name_len 44
               name: 0390cb341d248c589c419007da68b2-7351.manifest
leaf 533498265600 items 128 free space 6682 generation 176439 owner FS_TREE
leaf 533498265600 flags 0x1(WRITTEN) backref revision 1
fs uuid 5e9dcab6-036d-40f1-8b40-24ab4c062bf6
chunk uuid 0be705de-5d3b-4c23-979e-d7aaad224cfb
       item 62 key (486836 DIR_ITEM 2543451757) itemoff 6273 itemsize 74
               location key (4065004 INODE_ITEM 1073741824) type FILE
               transid 21397 data_len 0 name_len 44
               name: 0390cb341d248c589c419007da68b2-7351.manifest
       item 63 key (486836 DIR_INDEX 13905) itemoff 6199 itemsize 74
               location key (4065004 INODE_ITEM 0) type FILE
               transid 21397 data_len 0 name_len 44
               name: 0390cb341d248c589c419007da68b2-7351.manifest
parent transid verify failed on 629293056 wanted 177041 found 177044
parent transid verify failed on 629293056 wanted 177041 found 177044
Ignoring transid failure
