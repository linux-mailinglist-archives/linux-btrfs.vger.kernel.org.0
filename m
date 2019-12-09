Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBADD116511
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 03:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfLIChV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Dec 2019 21:37:21 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:47038 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfLIChV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Dec 2019 21:37:21 -0500
Received: by mail-io1-f68.google.com with SMTP id t26so1692294ioi.13
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Dec 2019 18:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IujxRJjVh4vfoHDqajw/P9cKnD9pwSYelOpS4N85eJE=;
        b=UP03SF3N9Ydh66TNqQMtxebEBrRtaCWJKR2iJ4sMuPYAaRwNIkrSL4CMDDl/9ZEOiS
         swMlNwRG5Ct4iLjs8irGfG0bGGyQUCfBQjj+trMRle/U6FFSQyUYPKVRCetWS+mKjcvi
         mKUWMC0MU0GQIWmNPdkvvcKUry9ZzCo+elOZcfff6cj9lhy3GZJlDPsHtFIzA/TuN55y
         DqBv66O3OwGn1KpoooifEfpG9JOEQgfJvJ/n2n0qWKrCnJg0DI+9OzvFLfxVWbX91pBQ
         TLhKpbNbaBRuAa+nhbRDf7PNKRuaKC+UTJDI5QnqwIk+AEU7jDPPmmWG+BnclaTSEsfz
         rn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IujxRJjVh4vfoHDqajw/P9cKnD9pwSYelOpS4N85eJE=;
        b=nDKtEr5316qcWRpS82i6JjkFBvpapn7Qy4AXWmYuKBLBSrtG3rA08snZbD9F3CfrjS
         ysMTFBTSuZMfmCZryfLNjzrFPjDtqiYFn/NWFy+nugMA0m3RUl6q6PTKM2Y8U4qCIX8l
         1VDuFyLLvTCzmAqnZwnb3EDoVwcwwPUeFcTXL3s54qUKn1UK21KRm1Fjj0OsejVkGhrF
         vDo6x5ZIHiq5WKVS2pjceYkdHy37qKu5C9rqRJRCk/I+gW43S1QAeJ2WlsPyXDGmUj+X
         HloVDN6C/OrgtNqOn2PwbN/d9AfD4ItYZ41WdQf9JVdWaWwZqu34glXbnzlaferLFDdC
         lwrQ==
X-Gm-Message-State: APjAAAVrFJu1U4ksz7wESBdOJPn/2L+zkLyY/Av9ZI20ozXh9kEXOzyY
        fRPeOJPkQ9OarQRuy8j76NN0zkePXhpa7S86vyg=
X-Google-Smtp-Source: APXvYqxJaF7Bv/xkrQPPAxmtTH+PkIndym6Ou9nEi+AHzz0EW+Y71G7dZ0ws+aJoV5p9JIORQnpANNF1d2Ee7edTSDY=
X-Received: by 2002:a02:630a:: with SMTP id j10mr18254201jac.102.1575859040059;
 Sun, 08 Dec 2019 18:37:20 -0800 (PST)
MIME-Version: 1.0
References: <CAJ0EP41toGSPQwB4Ys4aNzGGJNDBS-NHgPOcGanBk6d6Nn_LWw@mail.gmail.com>
 <5eae7d6d-a462-53f4-df0c-3b273426e2b2@gmx.com> <CAJ0EP40Wj59=CevVnn1rjxoc4CtGqbRjKFBSbU8BsrSjRC48ng@mail.gmail.com>
 <6c3454b9-cc23-d22b-c3a7-59697add9b88@gmx.com> <CAJ0EP40a6DpTu1YmMtBezun58pfFXhWwYEXpnnGLkup0OvLQPw@mail.gmail.com>
 <ae3289dd-c1f0-3aa8-dfbb-240ec4952b6e@gmx.com> <CAJ0EP40UUPe9VrF1x8mxnEhFxiTzgC9DkQZB684UuMF1571D+Q@mail.gmail.com>
 <d954ccdb-ac9a-1209-130c-e3b34e4a7a45@gmx.com> <5506e5de-a9f8-4830-8172-c07343da4218@gmx.com>
In-Reply-To: <5506e5de-a9f8-4830-8172-c07343da4218@gmx.com>
From:   Mike Gilbert <floppymaster@gmail.com>
Date:   Sun, 8 Dec 2019 21:37:15 -0500
Message-ID: <CAJ0EP40Pf7m7G77egwRjpSRSjvoMKB_PaRzmRxr0weohCr7tBw@mail.gmail.com>
Subject: Re: Unable to remove directory entry
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 8, 2019 at 9:20 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/12/9 =E4=B8=8A=E5=8D=8810:05, Qu Wenruo wrote:
> >
> >
> > On 2019/12/9 =E4=B8=8A=E5=8D=889:51, Mike Gilbert wrote:
> > [...]
> >>
> >> Here you go.
> >>
> >> I ran this while the filesystem was mounted; if you need it to be run
> >> while offline, I'll have to fire up a livecd.
> > The info is good enough, no need to go livecd.
> >
> >> --
> >>        item 6 key (4065004 INODE_ITEM 0) itemoff 15158 itemsize 160
> >>                generation 21397 transid 21397 size 12261 nbytes 12288
> >>                block group 0 mode 100644 links 1 uid 250 gid 250 rdev =
0
> >>                sequence 23 flags 0x0(none)
> >>                atime 1565546668.383680243 (2019-08-11 14:04:28)
> >>                ctime 1565546668.383680243 (2019-08-11 14:04:28)
> >>                mtime 1565546668.383680243 (2019-08-11 14:04:28)
> >>                otime 1565546668.336681213 (2019-08-11 14:04:28)
> >>        item 7 key (4065004 INODE_REF 486836) itemoff 15104 itemsize 54
> >>                index 13905 namelen 44 name:
> >> 0390cb341d248c589c419007da68b2-7351.manifest
> >
> > That inode exists and is good.
> >
> >>        item 8 key (4065004 EXTENT_DATA 0) itemoff 15051 itemsize 53
> >>                generation 21397 type 1 (regular)
> >>                extent data disk byte 6288928768 nr 12288
> >>                extent data offset 0 nr 12288 ram 12288
> >>                extent compression 0 (none)
> >>        item 9 key (4210974 INODE_ITEM 0) itemoff 14891 itemsize 160
> >>        item 63 key (486836 DIR_INDEX 13905) itemoff 6199 itemsize 74
> >>                location key (4065004 INODE_ITEM 0) type FILE
> >>                transid 21397 data_len 0 name_len 44
> >>                name: 0390cb341d248c589c419007da68b2-7351.manifest
> >
> > Good parent dir index.
> >
> >> leaf 533498265600 items 128 free space 6682 generation 176439 owner FS=
_TREE
> >> leaf 533498265600 flags 0x1(WRITTEN) backref revision 1
> >> fs uuid 5e9dcab6-036d-40f1-8b40-24ab4c062bf6
> >> chunk uuid 0be705de-5d3b-4c23-979e-d7aaad224cfb
> >>        item 62 key (486836 DIR_ITEM 2543451757) itemoff 6273 itemsize =
74
> >>                location key (4065004 INODE_ITEM 1073741824) type FILE
> >>                transid 21397 data_len 0 name_len 44
> >>                name: 0390cb341d248c589c419007da68b2-7351.manifest
> >
> > This is the problem, bad parent dir hash.
> >
> > The key should be (4065004 INODE_ITEM 0). The 1073741824 (0x40000000) i=
s
> > completely garbage.
> >
> > That garbage looks like a bit flip at runtime.
> > It's recommended to check your memory.
> >
> > I'll add extra tree-check checks, so that such runtime problem can be
> > detected before corrupted data reach disk.
> >
> >
> > For repair, I'll craft a special btrfs-progs for you to handle it, as
> > that should be the safest way.
> > Please wait for another 15min for that tool.
>
> Here is the special branch for you:
> https://github.com/adam900710/btrfs-progs/tree/dirty_fix_for_mike
>
> After compile, you can use btrfs-corrupt-block (I know it's a bad name)
> to repair your fs (must be unmounted):
>
> # ./btrfs-corrupt-block -X /dev/sda3
>
> If anything wrong happened, your fs should be kept untouched.
> If repaired successfully, there should be no output.
>
> Thanks,
> Qu

That worked. Thank you very much for your help with this!

Now, I guess I'll fire up Memtest86 overnight.
