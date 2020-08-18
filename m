Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38B52484A4
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Aug 2020 14:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHRMTG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Aug 2020 08:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgHRMTC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Aug 2020 08:19:02 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED274C061389
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Aug 2020 05:18:59 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i10so21180949ljn.2
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Aug 2020 05:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jwjPgdkMy5G/afZmc9bHgloNgA9NP8KwdVireXbhSdo=;
        b=a1v4dzBO1uJfC1v6z7pNH/47qh1mIJ7sX8BbxXPC0B62IhbzOGWoyfIUQC8yamuO8h
         HsdFM23RbbkUosqMqT5EYmtaAS1a4risBivS23LitR2BmdQK+DRSTAgAmQ9mQSPype0p
         O060OGehm/DQXh5ThvjX7Bx73987n5J1gA24xNyndXDW0YK+2FDwKIwurI74KMgFFXrJ
         E9/WM3e+ToNcmW4BtP6dHeYqYzvb0oq7hpXSZBMp7Bt3QdjNfyADM2wUVdrWok+TlhHx
         drb3K3Ibheeco94LURjweUgdrPW9A+lUtv3XEgTHyxc3NRi1Z4pNANSAtKkOIJsdoeUd
         IQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jwjPgdkMy5G/afZmc9bHgloNgA9NP8KwdVireXbhSdo=;
        b=tdXzbwf7YtzN/x8DrBY/fqE1kDaTXAjA7HMzzJeeOoQ2/RBrrE/3MVHpvb2X68+opF
         A4yT4aEfDKM+9/HYG7xEikgVCIZRKklQHttJWDSicNGqibgdftcH4LopokQJlENRssWx
         oWgoy+Mlds+XCz1qA6RBFrEwpwHnh/Pv0TS+KCCBjl2KicK1fw0exA/5iMIgmUGM7CFJ
         PuNgXfgroxUM4udcuW/W0my3QQtr6uWTnlCZdgmIVxtw2J3lDkoGx5+aiRkjUL8Pp6Gd
         tsW4N7j2thSLgF8A3EydlhWDEJvPQqfpz8QNCJlUYhtVD3n+9pTh7oG47aRwVuNd+RAq
         uhig==
X-Gm-Message-State: AOAM5335qtsUIO0a2kgaESr/bQQBrkwaMe/ia7P18qp+GQAvNARr02fG
        dsFzNOE9pjONE19qM4XEqpYzgCVkpSo8RZZYdZ49UQ40rZk=
X-Google-Smtp-Source: ABdhPJzpViORtKO6j8KTwhRgfkRdRls7jgLs2801YX7muQBEYLtsBLy0+j7O53S9HkFjKI1l6BQPfhRrgvY3pkLPq/4=
X-Received: by 2002:a05:651c:1293:: with SMTP id 19mr9148142ljc.427.1597753136166;
 Tue, 18 Aug 2020 05:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <CAJheHN3J85eLmZZYs0-ACoUQFuv3FVHmAnoJTxB+Xu8CGnCy5A@mail.gmail.com>
 <a89afb42-facf-3e11-db53-c394cf8db2ce@gmx.com> <CAJheHN26GYa7ezw-Jw_y5voFicoywwEJ2pJ4KKx96x-WA2h1eA@mail.gmail.com>
 <CAJheHN18TmG7g=-Sgi36hVmWka4z99rQRfaf=3FCRvat07C8pg@mail.gmail.com>
 <bbd08948-6672-4fb1-0e84-802482da7228@gmx.com> <CAJheHN3qgr+FNq+N3DiAQaPkbdcmV+1O8TetAX_HLU5V304Phw@mail.gmail.com>
 <155abe60-8970-c345-5f28-b4c2713d0c1e@gmx.com> <CAJheHN0EOPu9CuTT2hg=5HZskaC-yB2V5LSwNkrhP4XYYyv5+A@mail.gmail.com>
 <63677627-ca0a-663e-5443-9bd1b12ff5a9@gmx.com> <CAJheHN2mQX7VZxMZo+-GBhxeOWFu1tYAUfJ9Ut7hokMh-+ua-Q@mail.gmail.com>
 <5a9a2592-063a-5dfc-c157-47771d8bfb2b@gmx.com> <CAJheHN2-PbGC8S3f74CAFipsjxwXgip5N0zKG_xs-m8ky=WD2A@mail.gmail.com>
 <CAJheHN3qwDAGY=z14zfO4LBrxNJZZ_rvAMsWLwe-k+4+t3zLog@mail.gmail.com> <11fe4ad3-928c-5b6b-4424-26fc05baa28d@gmx.com>
In-Reply-To: <11fe4ad3-928c-5b6b-4424-26fc05baa28d@gmx.com>
From:   Tyler Richmond <t.d.richmond@gmail.com>
Date:   Tue, 18 Aug 2020 08:18:45 -0400
Message-ID: <CAJheHN2kY7kVyfo+kv0=DymXfnjiacX_a=rg7oXkeNV4x_XvHw@mail.gmail.com>
Subject: Re: Fwd: Read time tree block corruption detected
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I didn't check dmesg during the btrfs check, but that was the only
output during the rm -f before it was forced readonly. I just checked
dmesg for inode generation values, and there are a lot of them.

https://pastebin.com/stZdN0ta
The dmesg output had 990 lines containing inode generation.

However, these were at least later. I tried to do a btrfs balance
-mconvert raid1 and it failed with an I/O error. That is probably what
generated these specific errors, but maybe they were also happening
during the btrfs repair.

The FS is ~45TB, but the btrfs-image -c9 failed anway with:
ERROR: either extent tree is corrupted or deprecated extent ref format
ERROR: create failed: -5


On Tue, Aug 18, 2020 at 2:07 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/8/18 =E4=B8=8A=E5=8D=8811:35, Tyler Richmond wrote:
> > Qu,
> >
> > Sorry to resurrect this thread, but I just ran into something that I
> > can't really just ignore. I've found a folder that is full of files
> > which I guess have been broken somehow. I found a backup and restored
> > them, but I want to delete this folder of broken files. But whenever I
> > try, the fs is forced into readonly mode again. I just finished another
> > btrfs check --repair but it didn't fix the problem.
> >
> > https://pastebin.com/eTV3s3fr
>
> Is that the full output?
>
> No inode generation bugs?
> >
> >  I'm already on btrfs-progs v5.7. Any new suggestions?
>
> Strange.
>
> The detection and repair should have been merged into v5.5.
>
> If your fs is small enough, would you please provide the "btrfs-image
> -c9" dump?
>
> It would contain the filenames and directories names, but doesn't
> contain file contents.
>
> Thanks,
> Qu
> >
> > On Fri, May 8, 2020 at 9:52 AM Tyler Richmond <t.d.richmond@gmail.com
> > <mailto:t.d.richmond@gmail.com>> wrote:
> >
> >     5.6.1 also failed the same way. Here's the usage output. This is th=
e
> >     part where you see I've been using RAID5 haha
> >
> >     WARNING: RAID56 detected, not implemented
> >     Overall:
> >         Device size:                  60.03TiB
> >         Device allocated:             98.06GiB
> >         Device unallocated:           59.93TiB
> >         Device missing:                  0.00B
> >         Used:                         92.56GiB
> >         Free (estimated):                0.00B      (min: 8.00EiB)
> >         Data ratio:                       0.00
> >         Metadata ratio:                   2.00
> >         Global reserve:              512.00MiB      (used: 0.00B)
> >         Multiple profiles:                  no
> >
> >     Data,RAID5: Size:40.35TiB, Used:40.12TiB (99.42%)
> >        /dev/sdh        8.07TiB
> >        /dev/sdf        8.07TiB
> >        /dev/sdg        8.07TiB
> >        /dev/sdd        8.07TiB
> >        /dev/sdc        8.07TiB
> >        /dev/sde        8.07TiB
> >
> >     Metadata,RAID1: Size:49.00GiB, Used:46.28GiB (94.44%)
> >        /dev/sdh       34.00GiB
> >        /dev/sdf       32.00GiB
> >        /dev/sdg       32.00GiB
> >
> >     System,RAID1: Size:32.00MiB, Used:2.20MiB (6.87%)
> >        /dev/sdf       32.00MiB
> >        /dev/sdg       32.00MiB
> >
> >     Unallocated:
> >        /dev/sdh        2.81TiB
> >        /dev/sdf        2.81TiB
> >        /dev/sdg        2.81TiB
> >        /dev/sdd        1.03TiB
> >        /dev/sdc        1.03TiB
> >        /dev/sde        1.03TiB
> >
> >     On Fri, May 8, 2020 at 1:47 AM Qu Wenruo <quwenruo.btrfs@gmx.com
> >     <mailto:quwenruo.btrfs@gmx.com>> wrote:
> >     >
> >     >
> >     >
> >     > On 2020/5/8 =E4=B8=8B=E5=8D=881:12, Tyler Richmond wrote:
> >     > > If this is saying there's no extra space for metadata, is that =
why
> >     > > adding more files often makes the system hang for 30-90s? Is th=
ere
> >     > > anything I should do about that?
> >     >
> >     > I'm not sure about the hang though.
> >     >
> >     > It would be nice to give more info to diagnosis.
> >     > The output of 'btrfs fi usage' is useful for space usage problem.
> >     >
> >     > But the common idea is, to keep at 1~2 Gi unallocated (not avaiab=
le
> >     > space in vanilla df command) space for btrfs.
> >     >
> >     > Thanks,
> >     > Qu
> >     >
> >     > >
> >     > > Thank you so much for all of your help. I love how flexible BTR=
FS is
> >     > > but when things go wrong it's very hard for me to troubleshoot.
> >     > >
> >     > > On Fri, May 8, 2020 at 1:07 AM Qu Wenruo <quwenruo.btrfs@gmx.co=
m
> >     <mailto:quwenruo.btrfs@gmx.com>> wrote:
> >     > >>
> >     > >>
> >     > >>
> >     > >> On 2020/5/8 =E4=B8=8B=E5=8D=8812:23, Tyler Richmond wrote:
> >     > >>> Something went wrong:
> >     > >>>
> >     > >>> Reinitialize checksum tree
> >     > >>> Unable to find block group for 0
> >     > >>> Unable to find block group for 0
> >     > >>> Unable to find block group for 0
> >     > >>> ctree.c:2272: split_leaf: BUG_ON `1` triggered, value 1
> >     > >>> btrfs(+0x6dd94)[0x55a933af7d94]
> >     > >>> btrfs(+0x71b94)[0x55a933afbb94]
> >     > >>> btrfs(btrfs_search_slot+0x11f0)[0x55a933afd6c8]
> >     > >>> btrfs(btrfs_csum_file_block+0x432)[0x55a933b19d09]
> >     > >>> btrfs(+0x360b2)[0x55a933ac00b2]
> >     > >>> btrfs(+0x46a3e)[0x55a933ad0a3e]
> >     > >>> btrfs(main+0x98)[0x55a933a9fe88]
> >     > >>>
> >     /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf3)[0x7f263ed55=
0b3]
> >     > >>> btrfs(_start+0x2e)[0x55a933a9fa0e]
> >     > >>> Aborted
> >     > >>
> >     > >> This means no space for extra metadata...
> >     > >>
> >     > >> Anyway the csum tree problem shouldn't be a big thing, you
> >     could leave
> >     > >> it and call it a day.
> >     > >>
> >     > >> BTW, as long as btrfs check reports no extra problem for the i=
node
> >     > >> generation, it should be pretty safe to use the fs.
> >     > >>
> >     > >> Thanks,
> >     > >> Qu
> >     > >>>
> >     > >>> I just noticed I have btrfs-progs 5.6 installed and 5.6.1 is
> >     > >>> available. I'll let that try overnight?
> >     > >>>
> >     > >>> On Thu, May 7, 2020 at 8:11 PM Qu Wenruo
> >     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrote:
> >     > >>>>
> >     > >>>>
> >     > >>>>
> >     > >>>> On 2020/5/7 =E4=B8=8B=E5=8D=8811:52, Tyler Richmond wrote:
> >     > >>>>> Thank you for helping. The end result of the scan was:
> >     > >>>>>
> >     > >>>>>
> >     > >>>>> [1/7] checking root items
> >     > >>>>> [2/7] checking extents
> >     > >>>>> [3/7] checking free space cache
> >     > >>>>> [4/7] checking fs roots
> >     > >>>>
> >     > >>>> Good news is, your fs is still mostly fine.
> >     > >>>>
> >     > >>>>> [5/7] checking only csums items (without verifying data)
> >     > >>>>> there are no extents for csum range 0-69632
> >     > >>>>> csum exists for 0-69632 but there is no extent record
> >     > >>>>> ...
> >     > >>>>> ...
> >     > >>>>> there are no extents for csum range 946692096-946827264
> >     > >>>>> csum exists for 946692096-946827264 but there is no extent
> >     record
> >     > >>>>> there are no extents for csum range 946831360-947912704
> >     > >>>>> csum exists for 946831360-947912704 but there is no extent
> >     record
> >     > >>>>> ERROR: errors found in csum tree
> >     > >>>>
> >     > >>>> Only extent tree is corrupted.
> >     > >>>>
> >     > >>>> Normally btrfs check --init-csum-tree should be able to
> >     handle it.
> >     > >>>>
> >     > >>>> But still, please be sure you're using the latest btrfs-prog=
s
> >     to fix it.
> >     > >>>>
> >     > >>>> Thanks,
> >     > >>>> Qu
> >     > >>>>
> >     > >>>>> [6/7] checking root refs
> >     > >>>>> [7/7] checking quota groups skipped (not enabled on this FS=
)
> >     > >>>>> found 44157956026368 bytes used, error(s) found
> >     > >>>>> total csum bytes: 42038602716
> >     > >>>>> total tree bytes: 49688616960
> >     > >>>>> total fs tree bytes: 1256427520
> >     > >>>>> total extent tree bytes: 1709105152
> >     > >>>>> btree space waste bytes: 3172727316
> >     > >>>>> file data blocks allocated: 261625653436416
> >     > >>>>>  referenced 47477768499200
> >     > >>>>>
> >     > >>>>> What do I need to do to fix all of this?
> >     > >>>>>
> >     > >>>>> On Thu, May 7, 2020 at 1:52 AM Qu Wenruo
> >     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrote:
> >     > >>>>>>
> >     > >>>>>>
> >     > >>>>>>
> >     > >>>>>> On 2020/5/7 =E4=B8=8B=E5=8D=881:43, Tyler Richmond wrote:
> >     > >>>>>>> Well, the repair doesn't look terribly successful.
> >     > >>>>>>>
> >     > >>>>>>> parent transid verify failed on 218620880703488 wanted
> >     6875841 found 6876224
> >     > >>>>>>> parent transid verify failed on 218620880703488 wanted
> >     6875841 found 6876224
> >     > >>>>>>> parent transid verify failed on 218620880703488 wanted
> >     6875841 found 6876224
> >     > >>>>>>> Ignoring transid failure
> >     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606118=
4
> >     item=3D84
> >     > >>>>>>> parent level=3D1
> >     > >>>>>>>                                             child level=
=3D4
> >     > >>>>>>
> >     > >>>>>> This means there are more problems, not only the hash name
> >     mismatch.
> >     > >>>>>>
> >     > >>>>>> This means the fs is already corrupted, the name hash is
> >     just one
> >     > >>>>>> unrelated symptom.
> >     > >>>>>>
> >     > >>>>>> The only good news is, btrfs-progs abort the transaction,
> >     thus no
> >     > >>>>>> further damage to the fs.
> >     > >>>>>>
> >     > >>>>>> Please run a plain btrfs-check to show what's the problem
> >     first.
> >     > >>>>>>
> >     > >>>>>> Thanks,
> >     > >>>>>> Qu
> >     > >>>>>>
> >     > >>>>>>> parent transid verify failed on 218620880703488 wanted
> >     6875841 found 6876224
> >     > >>>>>>> Ignoring transid failure
> >     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606118=
4
> >     item=3D84
> >     > >>>>>>> parent level=3D1
> >     > >>>>>>>                                             child level=
=3D4
> >     > >>>>>>> parent transid verify failed on 218620880703488 wanted
> >     6875841 found 6876224
> >     > >>>>>>> Ignoring transid failure
> >     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606118=
4
> >     item=3D84
> >     > >>>>>>> parent level=3D1
> >     > >>>>>>>                                             child level=
=3D4
> >     > >>>>>>> parent transid verify failed on 218620880703488 wanted
> >     6875841 found 6876224
> >     > >>>>>>> Ignoring transid failure
> >     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606118=
4
> >     item=3D84
> >     > >>>>>>> parent level=3D1
> >     > >>>>>>>                                             child level=
=3D4
> >     > >>>>>>> parent transid verify failed on 218620880703488 wanted
> >     6875841 found 6876224
> >     > >>>>>>> Ignoring transid failure
> >     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606118=
4
> >     item=3D84
> >     > >>>>>>> parent level=3D1
> >     > >>>>>>>                                             child level=
=3D4
> >     > >>>>>>> parent transid verify failed on 218620880703488 wanted
> >     6875841 found 6876224
> >     > >>>>>>> Ignoring transid failure
> >     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606118=
4
> >     item=3D84
> >     > >>>>>>> parent level=3D1
> >     > >>>>>>>                                             child level=
=3D4
> >     > >>>>>>> parent transid verify failed on 218620880703488 wanted
> >     6875841 found 6876224
> >     > >>>>>>> Ignoring transid failure
> >     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606118=
4
> >     item=3D84
> >     > >>>>>>> parent level=3D1
> >     > >>>>>>>                                             child level=
=3D4
> >     > >>>>>>> parent transid verify failed on 218620880703488 wanted
> >     6875841 found 6876224
> >     > >>>>>>> Ignoring transid failure
> >     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606118=
4
> >     item=3D84
> >     > >>>>>>> parent level=3D1
> >     > >>>>>>>                                             child level=
=3D4
> >     > >>>>>>> parent transid verify failed on 218620880703488 wanted
> >     6875841 found 6876224
> >     > >>>>>>> Ignoring transid failure
> >     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606118=
4
> >     item=3D84
> >     > >>>>>>> parent level=3D1
> >     > >>>>>>>                                             child level=
=3D4
> >     > >>>>>>> parent transid verify failed on 218620880703488 wanted
> >     6875841 found 6876224
> >     > >>>>>>> Ignoring transid failure
> >     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606118=
4
> >     item=3D84
> >     > >>>>>>> parent level=3D1
> >     > >>>>>>>                                             child level=
=3D4
> >     > >>>>>>> parent transid verify failed on 218620880703488 wanted
> >     6875841 found 6876224
> >     > >>>>>>> Ignoring transid failure
> >     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995606118=
4
> >     item=3D84
> >     > >>>>>>> parent level=3D1
> >     > >>>>>>>                                             child level=
=3D4
> >     > >>>>>>> ERROR: failed to zero log tree: -17
> >     > >>>>>>> ERROR: attempt to start transaction over already running =
one
> >     > >>>>>>> WARNING: reserved space leaked, flag=3D0x4 bytes_reserved=
=3D4096
> >     > >>>>>>> extent buffer leak: start 225049066086400 len 4096
> >     > >>>>>>> extent buffer leak: start 225049066086400 len 4096
> >     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
> >     225049066086400 len 4096
> >     > >>>>>>> extent buffer leak: start 225049066094592 len 4096
> >     > >>>>>>> extent buffer leak: start 225049066094592 len 4096
> >     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
> >     225049066094592 len 4096
> >     > >>>>>>> extent buffer leak: start 225049066102784 len 4096
> >     > >>>>>>> extent buffer leak: start 225049066102784 len 4096
> >     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
> >     225049066102784 len 4096
> >     > >>>>>>> extent buffer leak: start 225049066131456 len 4096
> >     > >>>>>>> extent buffer leak: start 225049066131456 len 4096
> >     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
> >     225049066131456 len 4096
> >     > >>>>>>>
> >     > >>>>>>> What is going on?
> >     > >>>>>>>
> >     > >>>>>>> On Wed, May 6, 2020 at 9:30 PM Tyler Richmond
> >     <t.d.richmond@gmail.com <mailto:t.d.richmond@gmail.com>> wrote:
> >     > >>>>>>>>
> >     > >>>>>>>> Chris, I had used the correct mountpoint in the command.
> >     I just edited
> >     > >>>>>>>> it in the email to be /mountpoint for consistency.
> >     > >>>>>>>>
> >     > >>>>>>>> Qu, I'll try the repair. Fingers crossed!
> >     > >>>>>>>>
> >     > >>>>>>>> On Wed, May 6, 2020 at 9:13 PM Qu Wenruo
> >     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrote:
> >     > >>>>>>>>>
> >     > >>>>>>>>>
> >     > >>>>>>>>>
> >     > >>>>>>>>> On 2020/5/7 =E4=B8=8A=E5=8D=885:54, Tyler Richmond wrot=
e:
> >     > >>>>>>>>>> Hello,
> >     > >>>>>>>>>>
> >     > >>>>>>>>>> I looked up this error and it basically says ask a
> >     developer to
> >     > >>>>>>>>>> determine if it's a false error or not. I just started
> >     getting some
> >     > >>>>>>>>>> slow response times, and looked at the dmesg log to
> >     find a ton of
> >     > >>>>>>>>>> these errors.
> >     > >>>>>>>>>>
> >     > >>>>>>>>>> [192088.446299] BTRFS critical (device sdh): corrupt
> >     leaf: root=3D5
> >     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invali=
d inode
> >     generation:
> >     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
> >     > >>>>>>>>>> [192088.449823] BTRFS error (device sdh):
> >     block=3D203510940835840 read
> >     > >>>>>>>>>> time tree block corruption detected
> >     > >>>>>>>>>> [192088.459238] BTRFS critical (device sdh): corrupt
> >     leaf: root=3D5
> >     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invali=
d inode
> >     generation:
> >     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
> >     > >>>>>>>>>> [192088.462773] BTRFS error (device sdh):
> >     block=3D203510940835840 read
> >     > >>>>>>>>>> time tree block corruption detected
> >     > >>>>>>>>>> [192088.464711] BTRFS critical (device sdh): corrupt
> >     leaf: root=3D5
> >     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invali=
d inode
> >     generation:
> >     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
> >     > >>>>>>>>>> [192088.468457] BTRFS error (device sdh):
> >     block=3D203510940835840 read
> >     > >>>>>>>>>> time tree block corruption detected
> >     > >>>>>>>>>>
> >     > >>>>>>>>>> btrfs device stats, however, doesn't show any errors.
> >     > >>>>>>>>>>
> >     > >>>>>>>>>> Is there anything I should do about this, or should I
> >     just continue
> >     > >>>>>>>>>> using my array as normal?
> >     > >>>>>>>>>
> >     > >>>>>>>>> This is caused by older kernel underflow inode generati=
on.
> >     > >>>>>>>>>
> >     > >>>>>>>>> Latest btrfs-progs can fix it, using btrfs check --repa=
ir.
> >     > >>>>>>>>>
> >     > >>>>>>>>> Or you can go safer, by manually locating the inode
> >     using its inode
> >     > >>>>>>>>> number (1311670), and copy it to some new location usin=
g
> >     previous
> >     > >>>>>>>>> working kernel, then delete the old file, copy the new
> >     one back to fix it.
> >     > >>>>>>>>>
> >     > >>>>>>>>> Thanks,
> >     > >>>>>>>>> Qu
> >     > >>>>>>>>>
> >     > >>>>>>>>>>
> >     > >>>>>>>>>> Thank you!
> >     > >>>>>>>>>>
> >     > >>>>>>>>>
> >     > >>>>>>
> >     > >>>>
> >     > >>
> >     >
> >
>
