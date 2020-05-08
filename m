Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9213C1CA28D
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 07:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbgEHFMh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 01:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgEHFMh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 01:12:37 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D304C05BD43
        for <linux-btrfs@vger.kernel.org>; Thu,  7 May 2020 22:12:36 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id f11so328620ljp.1
        for <linux-btrfs@vger.kernel.org>; Thu, 07 May 2020 22:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kP40REXi+S9HgGauA0uvtUq2v4r8zY27xa7Oixvfhto=;
        b=ixs6tymVEzSEtB7F5xrCOlr97+PaCrrDJzdd4cU6t1ZrtmXEOKaZBs/M3YOGGc7oh1
         JGeeFJmmXtghOk3Qy9oNlItOkeleD0LpszRkRExfsh8wcttNmfBwtsZPaGdal7TQDUiM
         GmESMMEkdh3r2DxC+fHtmRzAy1S1ErHFWve6lEVyowwuTuWCN8dmZHZIyvHclIPb3Oun
         ZKiOwQExsd8P/5lDei7sXAEC3WZQYmuLVUOsijQbA60Yc7/v0a9ocX/+wf8UR36mx0R7
         zSc+Tgiwq9iFmc95L95vP+Jk0dfISFIN8Uv74teK1707uwxAxmfw9PtD1dKuXYt/680q
         gJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kP40REXi+S9HgGauA0uvtUq2v4r8zY27xa7Oixvfhto=;
        b=KYOlEsMyzAR1UmWE8m60GYDr8aYJ7nFuNJo2yBpEKeBCB/vqpgcRmC8tGkDhIe60qC
         t0qD3GAu0/uSvXgnrEjtLSGctkwlfyROxt82N4kvep5SG2PH6E6rwG36797owEeHLK7+
         vmJy0/iuXIMZf+/hXf5lBHLGJFvelhsuxGOcm1ZCidLEN1Ia6ZCaoKxWRT+DcSW+0IDy
         2Gr17iSUkLDWkhOSKxJeeMolfUNJn5XUjUXkblzX9Kmx/OVC5nrnSI/LXmhvgM3uzRqC
         duTQS2zkVb6dlp5UcM+XyrFYAsj93diZiyxVurdQC7/Mvrj5LgHIDhWPvhjWe/ty6xMi
         JzkA==
X-Gm-Message-State: AOAM5321xFEwdOKS5dRkrvhvTl/hzvEfCmYdEwuoquUaQJ59wa2nnek2
        rN/Z+Z8ARXtcjinCdzhGb+JZyrVDGTXYkEkFc0veAQ==
X-Google-Smtp-Source: ABdhPJzz9cTqFRud28v4CTPR45XjT3CuuOaDdGEJnNN/fx3eEWZeau8Avqt/TG75YfnH8mI6/cZTgHQdZxVbKsYQYFk=
X-Received: by 2002:a05:651c:390:: with SMTP id e16mr453189ljp.186.1588914753390;
 Thu, 07 May 2020 22:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <CAJheHN3J85eLmZZYs0-ACoUQFuv3FVHmAnoJTxB+Xu8CGnCy5A@mail.gmail.com>
 <a89afb42-facf-3e11-db53-c394cf8db2ce@gmx.com> <CAJheHN26GYa7ezw-Jw_y5voFicoywwEJ2pJ4KKx96x-WA2h1eA@mail.gmail.com>
 <CAJheHN18TmG7g=-Sgi36hVmWka4z99rQRfaf=3FCRvat07C8pg@mail.gmail.com>
 <bbd08948-6672-4fb1-0e84-802482da7228@gmx.com> <CAJheHN3qgr+FNq+N3DiAQaPkbdcmV+1O8TetAX_HLU5V304Phw@mail.gmail.com>
 <155abe60-8970-c345-5f28-b4c2713d0c1e@gmx.com> <CAJheHN0EOPu9CuTT2hg=5HZskaC-yB2V5LSwNkrhP4XYYyv5+A@mail.gmail.com>
 <63677627-ca0a-663e-5443-9bd1b12ff5a9@gmx.com>
In-Reply-To: <63677627-ca0a-663e-5443-9bd1b12ff5a9@gmx.com>
From:   Tyler Richmond <t.d.richmond@gmail.com>
Date:   Fri, 8 May 2020 01:12:20 -0400
Message-ID: <CAJheHN2mQX7VZxMZo+-GBhxeOWFu1tYAUfJ9Ut7hokMh-+ua-Q@mail.gmail.com>
Subject: Re: Fwd: Read time tree block corruption detected
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If this is saying there's no extra space for metadata, is that why
adding more files often makes the system hang for 30-90s? Is there
anything I should do about that?

Thank you so much for all of your help. I love how flexible BTRFS is
but when things go wrong it's very hard for me to troubleshoot.

On Fri, May 8, 2020 at 1:07 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/5/8 =E4=B8=8B=E5=8D=8812:23, Tyler Richmond wrote:
> > Something went wrong:
> >
> > Reinitialize checksum tree
> > Unable to find block group for 0
> > Unable to find block group for 0
> > Unable to find block group for 0
> > ctree.c:2272: split_leaf: BUG_ON `1` triggered, value 1
> > btrfs(+0x6dd94)[0x55a933af7d94]
> > btrfs(+0x71b94)[0x55a933afbb94]
> > btrfs(btrfs_search_slot+0x11f0)[0x55a933afd6c8]
> > btrfs(btrfs_csum_file_block+0x432)[0x55a933b19d09]
> > btrfs(+0x360b2)[0x55a933ac00b2]
> > btrfs(+0x46a3e)[0x55a933ad0a3e]
> > btrfs(main+0x98)[0x55a933a9fe88]
> > /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf3)[0x7f263ed550b3]
> > btrfs(_start+0x2e)[0x55a933a9fa0e]
> > Aborted
>
> This means no space for extra metadata...
>
> Anyway the csum tree problem shouldn't be a big thing, you could leave
> it and call it a day.
>
> BTW, as long as btrfs check reports no extra problem for the inode
> generation, it should be pretty safe to use the fs.
>
> Thanks,
> Qu
> >
> > I just noticed I have btrfs-progs 5.6 installed and 5.6.1 is
> > available. I'll let that try overnight?
> >
> > On Thu, May 7, 2020 at 8:11 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
> >>
> >>
> >>
> >> On 2020/5/7 =E4=B8=8B=E5=8D=8811:52, Tyler Richmond wrote:
> >>> Thank you for helping. The end result of the scan was:
> >>>
> >>>
> >>> [1/7] checking root items
> >>> [2/7] checking extents
> >>> [3/7] checking free space cache
> >>> [4/7] checking fs roots
> >>
> >> Good news is, your fs is still mostly fine.
> >>
> >>> [5/7] checking only csums items (without verifying data)
> >>> there are no extents for csum range 0-69632
> >>> csum exists for 0-69632 but there is no extent record
> >>> ...
> >>> ...
> >>> there are no extents for csum range 946692096-946827264
> >>> csum exists for 946692096-946827264 but there is no extent record
> >>> there are no extents for csum range 946831360-947912704
> >>> csum exists for 946831360-947912704 but there is no extent record
> >>> ERROR: errors found in csum tree
> >>
> >> Only extent tree is corrupted.
> >>
> >> Normally btrfs check --init-csum-tree should be able to handle it.
> >>
> >> But still, please be sure you're using the latest btrfs-progs to fix i=
t.
> >>
> >> Thanks,
> >> Qu
> >>
> >>> [6/7] checking root refs
> >>> [7/7] checking quota groups skipped (not enabled on this FS)
> >>> found 44157956026368 bytes used, error(s) found
> >>> total csum bytes: 42038602716
> >>> total tree bytes: 49688616960
> >>> total fs tree bytes: 1256427520
> >>> total extent tree bytes: 1709105152
> >>> btree space waste bytes: 3172727316
> >>> file data blocks allocated: 261625653436416
> >>>  referenced 47477768499200
> >>>
> >>> What do I need to do to fix all of this?
> >>>
> >>> On Thu, May 7, 2020 at 1:52 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
> >>>>
> >>>>
> >>>>
> >>>> On 2020/5/7 =E4=B8=8B=E5=8D=881:43, Tyler Richmond wrote:
> >>>>> Well, the repair doesn't look terribly successful.
> >>>>>
> >>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
> >>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
> >>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
> >>>>> Ignoring transid failure
> >>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D8=
4
> >>>>> parent level=3D1
> >>>>>                                             child level=3D4
> >>>>
> >>>> This means there are more problems, not only the hash name mismatch.
> >>>>
> >>>> This means the fs is already corrupted, the name hash is just one
> >>>> unrelated symptom.
> >>>>
> >>>> The only good news is, btrfs-progs abort the transaction, thus no
> >>>> further damage to the fs.
> >>>>
> >>>> Please run a plain btrfs-check to show what's the problem first.
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>>
> >>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
> >>>>> Ignoring transid failure
> >>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D8=
4
> >>>>> parent level=3D1
> >>>>>                                             child level=3D4
> >>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
> >>>>> Ignoring transid failure
> >>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D8=
4
> >>>>> parent level=3D1
> >>>>>                                             child level=3D4
> >>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
> >>>>> Ignoring transid failure
> >>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D8=
4
> >>>>> parent level=3D1
> >>>>>                                             child level=3D4
> >>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
> >>>>> Ignoring transid failure
> >>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D8=
4
> >>>>> parent level=3D1
> >>>>>                                             child level=3D4
> >>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
> >>>>> Ignoring transid failure
> >>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D8=
4
> >>>>> parent level=3D1
> >>>>>                                             child level=3D4
> >>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
> >>>>> Ignoring transid failure
> >>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D8=
4
> >>>>> parent level=3D1
> >>>>>                                             child level=3D4
> >>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
> >>>>> Ignoring transid failure
> >>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D8=
4
> >>>>> parent level=3D1
> >>>>>                                             child level=3D4
> >>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
> >>>>> Ignoring transid failure
> >>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D8=
4
> >>>>> parent level=3D1
> >>>>>                                             child level=3D4
> >>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
> >>>>> Ignoring transid failure
> >>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D8=
4
> >>>>> parent level=3D1
> >>>>>                                             child level=3D4
> >>>>> parent transid verify failed on 218620880703488 wanted 6875841 foun=
d 6876224
> >>>>> Ignoring transid failure
> >>>>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D8=
4
> >>>>> parent level=3D1
> >>>>>                                             child level=3D4
> >>>>> ERROR: failed to zero log tree: -17
> >>>>> ERROR: attempt to start transaction over already running one
> >>>>> WARNING: reserved space leaked, flag=3D0x4 bytes_reserved=3D4096
> >>>>> extent buffer leak: start 225049066086400 len 4096
> >>>>> extent buffer leak: start 225049066086400 len 4096
> >>>>> WARNING: dirty eb leak (aborted trans): start 225049066086400 len 4=
096
> >>>>> extent buffer leak: start 225049066094592 len 4096
> >>>>> extent buffer leak: start 225049066094592 len 4096
> >>>>> WARNING: dirty eb leak (aborted trans): start 225049066094592 len 4=
096
> >>>>> extent buffer leak: start 225049066102784 len 4096
> >>>>> extent buffer leak: start 225049066102784 len 4096
> >>>>> WARNING: dirty eb leak (aborted trans): start 225049066102784 len 4=
096
> >>>>> extent buffer leak: start 225049066131456 len 4096
> >>>>> extent buffer leak: start 225049066131456 len 4096
> >>>>> WARNING: dirty eb leak (aborted trans): start 225049066131456 len 4=
096
> >>>>>
> >>>>> What is going on?
> >>>>>
> >>>>> On Wed, May 6, 2020 at 9:30 PM Tyler Richmond <t.d.richmond@gmail.c=
om> wrote:
> >>>>>>
> >>>>>> Chris, I had used the correct mountpoint in the command. I just ed=
ited
> >>>>>> it in the email to be /mountpoint for consistency.
> >>>>>>
> >>>>>> Qu, I'll try the repair. Fingers crossed!
> >>>>>>
> >>>>>> On Wed, May 6, 2020 at 9:13 PM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On 2020/5/7 =E4=B8=8A=E5=8D=885:54, Tyler Richmond wrote:
> >>>>>>>> Hello,
> >>>>>>>>
> >>>>>>>> I looked up this error and it basically says ask a developer to
> >>>>>>>> determine if it's a false error or not. I just started getting s=
ome
> >>>>>>>> slow response times, and looked at the dmesg log to find a ton o=
f
> >>>>>>>> these errors.
> >>>>>>>>
> >>>>>>>> [192088.446299] BTRFS critical (device sdh): corrupt leaf: root=
=3D5
> >>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode ge=
neration:
> >>>>>>>> has 18446744073709551492 expect [0, 6875827]
> >>>>>>>> [192088.449823] BTRFS error (device sdh): block=3D20351094083584=
0 read
> >>>>>>>> time tree block corruption detected
> >>>>>>>> [192088.459238] BTRFS critical (device sdh): corrupt leaf: root=
=3D5
> >>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode ge=
neration:
> >>>>>>>> has 18446744073709551492 expect [0, 6875827]
> >>>>>>>> [192088.462773] BTRFS error (device sdh): block=3D20351094083584=
0 read
> >>>>>>>> time tree block corruption detected
> >>>>>>>> [192088.464711] BTRFS critical (device sdh): corrupt leaf: root=
=3D5
> >>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode ge=
neration:
> >>>>>>>> has 18446744073709551492 expect [0, 6875827]
> >>>>>>>> [192088.468457] BTRFS error (device sdh): block=3D20351094083584=
0 read
> >>>>>>>> time tree block corruption detected
> >>>>>>>>
> >>>>>>>> btrfs device stats, however, doesn't show any errors.
> >>>>>>>>
> >>>>>>>> Is there anything I should do about this, or should I just conti=
nue
> >>>>>>>> using my array as normal?
> >>>>>>>
> >>>>>>> This is caused by older kernel underflow inode generation.
> >>>>>>>
> >>>>>>> Latest btrfs-progs can fix it, using btrfs check --repair.
> >>>>>>>
> >>>>>>> Or you can go safer, by manually locating the inode using its ino=
de
> >>>>>>> number (1311670), and copy it to some new location using previous
> >>>>>>> working kernel, then delete the old file, copy the new one back t=
o fix it.
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> Qu
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Thank you!
> >>>>>>>>
> >>>>>>>
> >>>>
> >>
>
