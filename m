Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39FA24F146
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 04:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHXCrc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Aug 2020 22:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgHXCrb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Aug 2020 22:47:31 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B055C061573
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Aug 2020 19:47:30 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 145so776629lfi.8
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Aug 2020 19:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JIXlaoGbpB64EEA0N7LXVv1ZQeASxZoegf3cSlrd2fE=;
        b=Gx+qZcRrg5Trv3mvbsA9gQ1kP8Oc0D116DLkHQEbKUZ+rbcecOmtWGUBJnW3ot7fEY
         msPhlbu3YiZR5LbvUMdO/bot8A3nbc7kvcbRAAP+i8IA5ANbYlP26AMG1kQHn7E4PnCh
         EAJiW44kNZKBKVKwnpER2c1HohNHVEpkFkbljZxEFfC+/kVfjknOcdMGVt/HNvN7XwdA
         Ch2KlZdkUu6b4HijY91lXt9iYb66nAWXwnVbYwF03HAeHnToyYH0exl0+7PxvWQIZHY8
         HWXxDgQGG6S92E0I7XtOdGaH6E79sfXXCGzU5I5/Vp7R/0CxtLOSGMREUFD7RAnWY7xR
         JfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JIXlaoGbpB64EEA0N7LXVv1ZQeASxZoegf3cSlrd2fE=;
        b=UTADgJOMmtzayVNqEa6sF1sGezffXCfqVNvofEmANZfXXWjWg2maG0Yv/JJMPaSNEW
         kRyMOwFeT1E9aPUoUkU3mxzxirDDrJmtizm3a4UT4qnXw3eKmA5PKy0QlEM46FpaKJEh
         C0X1nM08XugLa+qyAmJt0DpaBdatbIGj8zKGztmDpuWLky3kFq6hmJe+7Zi29BqC46SP
         MM/ITU4f8qIWaT6njVlJw/lDWojPmLhipZA8LWAAtBgaItpOPMQ+cPG8TbOjpEbOu3gg
         UA4noggYCPnLnD8f9ZA+RRi3SgoVdBxlswGIWKd25xkUmMIcgg5tbHc6ja54WjJgATuU
         BS8w==
X-Gm-Message-State: AOAM533r/rni1zVqeG4tVxDrkCVd7Adw5pVg+VBVk9yGq9HvTQYx093q
        NVLIaJI6lq9hYeaARjiFAF5w8lv/j74+BFbK8ZE=
X-Google-Smtp-Source: ABdhPJyX0Y/G+VYHcK64QhWjh/qgzJxS+jIBsJBzYabxC+ZL8ikIIFOlBINHTtCjVOMDYEWQ2gIKcLiyspQWrYTaDOw=
X-Received: by 2002:ac2:4570:: with SMTP id k16mr1596124lfm.60.1598237248593;
 Sun, 23 Aug 2020 19:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <bbd08948-6672-4fb1-0e84-802482da7228@gmx.com> <CAJheHN3qgr+FNq+N3DiAQaPkbdcmV+1O8TetAX_HLU5V304Phw@mail.gmail.com>
 <155abe60-8970-c345-5f28-b4c2713d0c1e@gmx.com> <CAJheHN0EOPu9CuTT2hg=5HZskaC-yB2V5LSwNkrhP4XYYyv5+A@mail.gmail.com>
 <63677627-ca0a-663e-5443-9bd1b12ff5a9@gmx.com> <CAJheHN2mQX7VZxMZo+-GBhxeOWFu1tYAUfJ9Ut7hokMh-+ua-Q@mail.gmail.com>
 <5a9a2592-063a-5dfc-c157-47771d8bfb2b@gmx.com> <CAJheHN2-PbGC8S3f74CAFipsjxwXgip5N0zKG_xs-m8ky=WD2A@mail.gmail.com>
 <CAJheHN3qwDAGY=z14zfO4LBrxNJZZ_rvAMsWLwe-k+4+t3zLog@mail.gmail.com>
 <11fe4ad3-928c-5b6b-4424-26fc05baa28d@gmx.com> <CAJheHN2kY7kVyfo+kv0=DymXfnjiacX_a=rg7oXkeNV4x_XvHw@mail.gmail.com>
 <CAJheHN0qqOn2u4Rks6u+Epsr+L+ijs0E=G=AUCV3F-yLvsLasA@mail.gmail.com>
 <98c633bc-658c-d8d9-a2cd-4c9b9e477552@gmx.com> <6bc0816e-b58c-1d74-7c0e-e07a38a5a027@gmx.com>
 <CAJheHN25gNo-jgykeQ6=ZQAm1ZHG9+-rWhBp3S-x2c1xi5j-og@mail.gmail.com> <4d1bb444-921c-9773-ff68-b6ea074ff35d@gmx.com>
In-Reply-To: <4d1bb444-921c-9773-ff68-b6ea074ff35d@gmx.com>
From:   Tyler Richmond <t.d.richmond@gmail.com>
Date:   Sun, 23 Aug 2020 22:47:18 -0400
Message-ID: <CAJheHN1+AQR-irSbaH8f7HGj=rDN4+uUCyqjvtezGewQkQoDpg@mail.gmail.com>
Subject: Re: Fwd: Read time tree block corruption detected
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu,

Finally finished another repair and captured the output.

https://pastebin.com/ffcbwvd8

Does that show you what you need? Or should I still do one in lowmem mode?

Thanks for your help!

On Sun, Aug 23, 2020 at 12:28 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/8/23 =E4=B8=8A=E5=8D=8810:49, Tyler Richmond wrote:
> > Well, I can guarantee that I didn't create this fs before 2015 (just
> > checked the order confirmation from when I bought the server), but I
> > may have just used whatever was in the Ubuntu package manager at the
> > time. So maybe I don't have a v0 ref?
>
> Then btrfs-image shouldn't report that.
>
> There is an item smaller than any valid btrfs item, normally it means
> it's a v0 ref.
> If not, then it could be a bigger problem.
>
> Could you please provide the full btrfs-check output?
> Also, if possible result from "btrfs check --mode=3Dlowmem" would also he=
lp.
>
> Also, if you really go "--repair", then the full output would also be
> needed to determine what's going wrong.
> There is a report about "btrfs check --repair" didn't repair the inode
> generation, if that's the case we must have a bug then.
>
> Thanks,
> Qu
> >
> > On Sat, Aug 22, 2020 at 10:31 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
> >>
> >>
> >>
> >> On 2020/8/23 =E4=B8=8A=E5=8D=889:51, Qu Wenruo wrote:
> >>>
> >>>
> >>> On 2020/8/23 =E4=B8=8A=E5=8D=889:15, Tyler Richmond wrote:
> >>>> Is my best bet just to downgrade the kernel and then try to delete t=
he
> >>>> broken files? Or should I rebuild from scratch? Just don't know
> >>>> whether it's worth the time to try and figure this out or if the
> >>>> problems stem from the FS being too old and it's beyond trying to
> >>>> repair.
> >>>
> >>> All invalid inode generations, should be able to be repaired by lates=
t
> >>> btrfs-check.
> >>>
> >>> If not, please provide the btrfs-image dump for us to determine what'=
s
> >>> going wrong.
> >>>
> >>> Thanks,
> >>> Qu
> >>>>
> >>>> On Tue, Aug 18, 2020 at 8:18 AM Tyler Richmond <t.d.richmond@gmail.c=
om> wrote:
> >>>>>
> >>>>> I didn't check dmesg during the btrfs check, but that was the only
> >>>>> output during the rm -f before it was forced readonly. I just check=
ed
> >>>>> dmesg for inode generation values, and there are a lot of them.
> >>>>>
> >>>>> https://pastebin.com/stZdN0ta
> >>>>> The dmesg output had 990 lines containing inode generation.
> >>>>>
> >>>>> However, these were at least later. I tried to do a btrfs balance
> >>>>> -mconvert raid1 and it failed with an I/O error. That is probably w=
hat
> >>>>> generated these specific errors, but maybe they were also happening
> >>>>> during the btrfs repair.
> >>>>>
> >>>>> The FS is ~45TB, but the btrfs-image -c9 failed anway with:
> >>>>> ERROR: either extent tree is corrupted or deprecated extent ref for=
mat
> >>>>> ERROR: create failed: -5
> >>
> >> Oh, forgot this part.
> >>
> >> This means you have v0 ref?!
> >>
> >> Then the fs is too old, no progs/kernel support after all.
> >>
> >> In that case, please rollback to the last working kernel and copy your=
 data.
> >>
> >> In fact, that v0 ref should only be in the code base for several weeks
> >> before 2010, thus it's really too old.
> >>
> >> The good news is, with tree-checker, we should never experience such
> >> too-old-to-be-usable problem (at least I hope so)
> >>
> >> Thanks,
> >> Qu
> >>
> >>>>>
> >>>>>
> >>>>> On Tue, Aug 18, 2020 at 2:07 AM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 2020/8/18 =E4=B8=8A=E5=8D=8811:35, Tyler Richmond wrote:
> >>>>>>> Qu,
> >>>>>>>
> >>>>>>> Sorry to resurrect this thread, but I just ran into something tha=
t I
> >>>>>>> can't really just ignore. I've found a folder that is full of fil=
es
> >>>>>>> which I guess have been broken somehow. I found a backup and rest=
ored
> >>>>>>> them, but I want to delete this folder of broken files. But whene=
ver I
> >>>>>>> try, the fs is forced into readonly mode again. I just finished a=
nother
> >>>>>>> btrfs check --repair but it didn't fix the problem.
> >>>>>>>
> >>>>>>> https://pastebin.com/eTV3s3fr
> >>>>>>
> >>>>>> Is that the full output?
> >>>>>>
> >>>>>> No inode generation bugs?
> >>>>>>>
> >>>>>>>  I'm already on btrfs-progs v5.7. Any new suggestions?
> >>>>>>
> >>>>>> Strange.
> >>>>>>
> >>>>>> The detection and repair should have been merged into v5.5.
> >>>>>>
> >>>>>> If your fs is small enough, would you please provide the "btrfs-im=
age
> >>>>>> -c9" dump?
> >>>>>>
> >>>>>> It would contain the filenames and directories names, but doesn't
> >>>>>> contain file contents.
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Qu
> >>>>>>>
> >>>>>>> On Fri, May 8, 2020 at 9:52 AM Tyler Richmond <t.d.richmond@gmail=
.com
> >>>>>>> <mailto:t.d.richmond@gmail.com>> wrote:
> >>>>>>>
> >>>>>>>     5.6.1 also failed the same way. Here's the usage output. This=
 is the
> >>>>>>>     part where you see I've been using RAID5 haha
> >>>>>>>
> >>>>>>>     WARNING: RAID56 detected, not implemented
> >>>>>>>     Overall:
> >>>>>>>         Device size:                  60.03TiB
> >>>>>>>         Device allocated:             98.06GiB
> >>>>>>>         Device unallocated:           59.93TiB
> >>>>>>>         Device missing:                  0.00B
> >>>>>>>         Used:                         92.56GiB
> >>>>>>>         Free (estimated):                0.00B      (min: 8.00EiB=
)
> >>>>>>>         Data ratio:                       0.00
> >>>>>>>         Metadata ratio:                   2.00
> >>>>>>>         Global reserve:              512.00MiB      (used: 0.00B)
> >>>>>>>         Multiple profiles:                  no
> >>>>>>>
> >>>>>>>     Data,RAID5: Size:40.35TiB, Used:40.12TiB (99.42%)
> >>>>>>>        /dev/sdh        8.07TiB
> >>>>>>>        /dev/sdf        8.07TiB
> >>>>>>>        /dev/sdg        8.07TiB
> >>>>>>>        /dev/sdd        8.07TiB
> >>>>>>>        /dev/sdc        8.07TiB
> >>>>>>>        /dev/sde        8.07TiB
> >>>>>>>
> >>>>>>>     Metadata,RAID1: Size:49.00GiB, Used:46.28GiB (94.44%)
> >>>>>>>        /dev/sdh       34.00GiB
> >>>>>>>        /dev/sdf       32.00GiB
> >>>>>>>        /dev/sdg       32.00GiB
> >>>>>>>
> >>>>>>>     System,RAID1: Size:32.00MiB, Used:2.20MiB (6.87%)
> >>>>>>>        /dev/sdf       32.00MiB
> >>>>>>>        /dev/sdg       32.00MiB
> >>>>>>>
> >>>>>>>     Unallocated:
> >>>>>>>        /dev/sdh        2.81TiB
> >>>>>>>        /dev/sdf        2.81TiB
> >>>>>>>        /dev/sdg        2.81TiB
> >>>>>>>        /dev/sdd        1.03TiB
> >>>>>>>        /dev/sdc        1.03TiB
> >>>>>>>        /dev/sde        1.03TiB
> >>>>>>>
> >>>>>>>     On Fri, May 8, 2020 at 1:47 AM Qu Wenruo <quwenruo.btrfs@gmx.=
com
> >>>>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
> >>>>>>>     >
> >>>>>>>     >
> >>>>>>>     >
> >>>>>>>     > On 2020/5/8 =E4=B8=8B=E5=8D=881:12, Tyler Richmond wrote:
> >>>>>>>     > > If this is saying there's no extra space for metadata, is=
 that why
> >>>>>>>     > > adding more files often makes the system hang for 30-90s?=
 Is there
> >>>>>>>     > > anything I should do about that?
> >>>>>>>     >
> >>>>>>>     > I'm not sure about the hang though.
> >>>>>>>     >
> >>>>>>>     > It would be nice to give more info to diagnosis.
> >>>>>>>     > The output of 'btrfs fi usage' is useful for space usage pr=
oblem.
> >>>>>>>     >
> >>>>>>>     > But the common idea is, to keep at 1~2 Gi unallocated (not =
avaiable
> >>>>>>>     > space in vanilla df command) space for btrfs.
> >>>>>>>     >
> >>>>>>>     > Thanks,
> >>>>>>>     > Qu
> >>>>>>>     >
> >>>>>>>     > >
> >>>>>>>     > > Thank you so much for all of your help. I love how flexib=
le BTRFS is
> >>>>>>>     > > but when things go wrong it's very hard for me to trouble=
shoot.
> >>>>>>>     > >
> >>>>>>>     > > On Fri, May 8, 2020 at 1:07 AM Qu Wenruo <quwenruo.btrfs@=
gmx.com
> >>>>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
> >>>>>>>     > >>
> >>>>>>>     > >>
> >>>>>>>     > >>
> >>>>>>>     > >> On 2020/5/8 =E4=B8=8B=E5=8D=8812:23, Tyler Richmond wrot=
e:
> >>>>>>>     > >>> Something went wrong:
> >>>>>>>     > >>>
> >>>>>>>     > >>> Reinitialize checksum tree
> >>>>>>>     > >>> Unable to find block group for 0
> >>>>>>>     > >>> Unable to find block group for 0
> >>>>>>>     > >>> Unable to find block group for 0
> >>>>>>>     > >>> ctree.c:2272: split_leaf: BUG_ON `1` triggered, value 1
> >>>>>>>     > >>> btrfs(+0x6dd94)[0x55a933af7d94]
> >>>>>>>     > >>> btrfs(+0x71b94)[0x55a933afbb94]
> >>>>>>>     > >>> btrfs(btrfs_search_slot+0x11f0)[0x55a933afd6c8]
> >>>>>>>     > >>> btrfs(btrfs_csum_file_block+0x432)[0x55a933b19d09]
> >>>>>>>     > >>> btrfs(+0x360b2)[0x55a933ac00b2]
> >>>>>>>     > >>> btrfs(+0x46a3e)[0x55a933ad0a3e]
> >>>>>>>     > >>> btrfs(main+0x98)[0x55a933a9fe88]
> >>>>>>>     > >>>
> >>>>>>>     /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf3)[0x7f2=
63ed550b3]
> >>>>>>>     > >>> btrfs(_start+0x2e)[0x55a933a9fa0e]
> >>>>>>>     > >>> Aborted
> >>>>>>>     > >>
> >>>>>>>     > >> This means no space for extra metadata...
> >>>>>>>     > >>
> >>>>>>>     > >> Anyway the csum tree problem shouldn't be a big thing, y=
ou
> >>>>>>>     could leave
> >>>>>>>     > >> it and call it a day.
> >>>>>>>     > >>
> >>>>>>>     > >> BTW, as long as btrfs check reports no extra problem for=
 the inode
> >>>>>>>     > >> generation, it should be pretty safe to use the fs.
> >>>>>>>     > >>
> >>>>>>>     > >> Thanks,
> >>>>>>>     > >> Qu
> >>>>>>>     > >>>
> >>>>>>>     > >>> I just noticed I have btrfs-progs 5.6 installed and 5.6=
.1 is
> >>>>>>>     > >>> available. I'll let that try overnight?
> >>>>>>>     > >>>
> >>>>>>>     > >>> On Thu, May 7, 2020 at 8:11 PM Qu Wenruo
> >>>>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrot=
e:
> >>>>>>>     > >>>>
> >>>>>>>     > >>>>
> >>>>>>>     > >>>>
> >>>>>>>     > >>>> On 2020/5/7 =E4=B8=8B=E5=8D=8811:52, Tyler Richmond wr=
ote:
> >>>>>>>     > >>>>> Thank you for helping. The end result of the scan was=
:
> >>>>>>>     > >>>>>
> >>>>>>>     > >>>>>
> >>>>>>>     > >>>>> [1/7] checking root items
> >>>>>>>     > >>>>> [2/7] checking extents
> >>>>>>>     > >>>>> [3/7] checking free space cache
> >>>>>>>     > >>>>> [4/7] checking fs roots
> >>>>>>>     > >>>>
> >>>>>>>     > >>>> Good news is, your fs is still mostly fine.
> >>>>>>>     > >>>>
> >>>>>>>     > >>>>> [5/7] checking only csums items (without verifying da=
ta)
> >>>>>>>     > >>>>> there are no extents for csum range 0-69632
> >>>>>>>     > >>>>> csum exists for 0-69632 but there is no extent record
> >>>>>>>     > >>>>> ...
> >>>>>>>     > >>>>> ...
> >>>>>>>     > >>>>> there are no extents for csum range 946692096-9468272=
64
> >>>>>>>     > >>>>> csum exists for 946692096-946827264 but there is no e=
xtent
> >>>>>>>     record
> >>>>>>>     > >>>>> there are no extents for csum range 946831360-9479127=
04
> >>>>>>>     > >>>>> csum exists for 946831360-947912704 but there is no e=
xtent
> >>>>>>>     record
> >>>>>>>     > >>>>> ERROR: errors found in csum tree
> >>>>>>>     > >>>>
> >>>>>>>     > >>>> Only extent tree is corrupted.
> >>>>>>>     > >>>>
> >>>>>>>     > >>>> Normally btrfs check --init-csum-tree should be able t=
o
> >>>>>>>     handle it.
> >>>>>>>     > >>>>
> >>>>>>>     > >>>> But still, please be sure you're using the latest btrf=
s-progs
> >>>>>>>     to fix it.
> >>>>>>>     > >>>>
> >>>>>>>     > >>>> Thanks,
> >>>>>>>     > >>>> Qu
> >>>>>>>     > >>>>
> >>>>>>>     > >>>>> [6/7] checking root refs
> >>>>>>>     > >>>>> [7/7] checking quota groups skipped (not enabled on t=
his FS)
> >>>>>>>     > >>>>> found 44157956026368 bytes used, error(s) found
> >>>>>>>     > >>>>> total csum bytes: 42038602716
> >>>>>>>     > >>>>> total tree bytes: 49688616960
> >>>>>>>     > >>>>> total fs tree bytes: 1256427520
> >>>>>>>     > >>>>> total extent tree bytes: 1709105152
> >>>>>>>     > >>>>> btree space waste bytes: 3172727316
> >>>>>>>     > >>>>> file data blocks allocated: 261625653436416
> >>>>>>>     > >>>>>  referenced 47477768499200
> >>>>>>>     > >>>>>
> >>>>>>>     > >>>>> What do I need to do to fix all of this?
> >>>>>>>     > >>>>>
> >>>>>>>     > >>>>> On Thu, May 7, 2020 at 1:52 AM Qu Wenruo
> >>>>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrot=
e:
> >>>>>>>     > >>>>>>
> >>>>>>>     > >>>>>>
> >>>>>>>     > >>>>>>
> >>>>>>>     > >>>>>> On 2020/5/7 =E4=B8=8B=E5=8D=881:43, Tyler Richmond w=
rote:
> >>>>>>>     > >>>>>>> Well, the repair doesn't look terribly successful.
> >>>>>>>     > >>>>>>>
> >>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
> >>>>>>>     6875841 found 6876224
> >>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
> >>>>>>>     6875841 found 6876224
> >>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
> >>>>>>>     6875841 found 6876224
> >>>>>>>     > >>>>>>> Ignoring transid failure
> >>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995=
6061184
> >>>>>>>     item=3D84
> >>>>>>>     > >>>>>>> parent level=3D1
> >>>>>>>     > >>>>>>>                                             child l=
evel=3D4
> >>>>>>>     > >>>>>>
> >>>>>>>     > >>>>>> This means there are more problems, not only the has=
h name
> >>>>>>>     mismatch.
> >>>>>>>     > >>>>>>
> >>>>>>>     > >>>>>> This means the fs is already corrupted, the name has=
h is
> >>>>>>>     just one
> >>>>>>>     > >>>>>> unrelated symptom.
> >>>>>>>     > >>>>>>
> >>>>>>>     > >>>>>> The only good news is, btrfs-progs abort the transac=
tion,
> >>>>>>>     thus no
> >>>>>>>     > >>>>>> further damage to the fs.
> >>>>>>>     > >>>>>>
> >>>>>>>     > >>>>>> Please run a plain btrfs-check to show what's the pr=
oblem
> >>>>>>>     first.
> >>>>>>>     > >>>>>>
> >>>>>>>     > >>>>>> Thanks,
> >>>>>>>     > >>>>>> Qu
> >>>>>>>     > >>>>>>
> >>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
> >>>>>>>     6875841 found 6876224
> >>>>>>>     > >>>>>>> Ignoring transid failure
> >>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995=
6061184
> >>>>>>>     item=3D84
> >>>>>>>     > >>>>>>> parent level=3D1
> >>>>>>>     > >>>>>>>                                             child l=
evel=3D4
> >>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
> >>>>>>>     6875841 found 6876224
> >>>>>>>     > >>>>>>> Ignoring transid failure
> >>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995=
6061184
> >>>>>>>     item=3D84
> >>>>>>>     > >>>>>>> parent level=3D1
> >>>>>>>     > >>>>>>>                                             child l=
evel=3D4
> >>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
> >>>>>>>     6875841 found 6876224
> >>>>>>>     > >>>>>>> Ignoring transid failure
> >>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995=
6061184
> >>>>>>>     item=3D84
> >>>>>>>     > >>>>>>> parent level=3D1
> >>>>>>>     > >>>>>>>                                             child l=
evel=3D4
> >>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
> >>>>>>>     6875841 found 6876224
> >>>>>>>     > >>>>>>> Ignoring transid failure
> >>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995=
6061184
> >>>>>>>     item=3D84
> >>>>>>>     > >>>>>>> parent level=3D1
> >>>>>>>     > >>>>>>>                                             child l=
evel=3D4
> >>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
> >>>>>>>     6875841 found 6876224
> >>>>>>>     > >>>>>>> Ignoring transid failure
> >>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995=
6061184
> >>>>>>>     item=3D84
> >>>>>>>     > >>>>>>> parent level=3D1
> >>>>>>>     > >>>>>>>                                             child l=
evel=3D4
> >>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
> >>>>>>>     6875841 found 6876224
> >>>>>>>     > >>>>>>> Ignoring transid failure
> >>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995=
6061184
> >>>>>>>     item=3D84
> >>>>>>>     > >>>>>>> parent level=3D1
> >>>>>>>     > >>>>>>>                                             child l=
evel=3D4
> >>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
> >>>>>>>     6875841 found 6876224
> >>>>>>>     > >>>>>>> Ignoring transid failure
> >>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995=
6061184
> >>>>>>>     item=3D84
> >>>>>>>     > >>>>>>> parent level=3D1
> >>>>>>>     > >>>>>>>                                             child l=
evel=3D4
> >>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
> >>>>>>>     6875841 found 6876224
> >>>>>>>     > >>>>>>> Ignoring transid failure
> >>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995=
6061184
> >>>>>>>     item=3D84
> >>>>>>>     > >>>>>>> parent level=3D1
> >>>>>>>     > >>>>>>>                                             child l=
evel=3D4
> >>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
> >>>>>>>     6875841 found 6876224
> >>>>>>>     > >>>>>>> Ignoring transid failure
> >>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995=
6061184
> >>>>>>>     item=3D84
> >>>>>>>     > >>>>>>> parent level=3D1
> >>>>>>>     > >>>>>>>                                             child l=
evel=3D4
> >>>>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wan=
ted
> >>>>>>>     6875841 found 6876224
> >>>>>>>     > >>>>>>> Ignoring transid failure
> >>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D22504995=
6061184
> >>>>>>>     item=3D84
> >>>>>>>     > >>>>>>> parent level=3D1
> >>>>>>>     > >>>>>>>                                             child l=
evel=3D4
> >>>>>>>     > >>>>>>> ERROR: failed to zero log tree: -17
> >>>>>>>     > >>>>>>> ERROR: attempt to start transaction over already ru=
nning one
> >>>>>>>     > >>>>>>> WARNING: reserved space leaked, flag=3D0x4 bytes_re=
served=3D4096
> >>>>>>>     > >>>>>>> extent buffer leak: start 225049066086400 len 4096
> >>>>>>>     > >>>>>>> extent buffer leak: start 225049066086400 len 4096
> >>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
> >>>>>>>     225049066086400 len 4096
> >>>>>>>     > >>>>>>> extent buffer leak: start 225049066094592 len 4096
> >>>>>>>     > >>>>>>> extent buffer leak: start 225049066094592 len 4096
> >>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
> >>>>>>>     225049066094592 len 4096
> >>>>>>>     > >>>>>>> extent buffer leak: start 225049066102784 len 4096
> >>>>>>>     > >>>>>>> extent buffer leak: start 225049066102784 len 4096
> >>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
> >>>>>>>     225049066102784 len 4096
> >>>>>>>     > >>>>>>> extent buffer leak: start 225049066131456 len 4096
> >>>>>>>     > >>>>>>> extent buffer leak: start 225049066131456 len 4096
> >>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
> >>>>>>>     225049066131456 len 4096
> >>>>>>>     > >>>>>>>
> >>>>>>>     > >>>>>>> What is going on?
> >>>>>>>     > >>>>>>>
> >>>>>>>     > >>>>>>> On Wed, May 6, 2020 at 9:30 PM Tyler Richmond
> >>>>>>>     <t.d.richmond@gmail.com <mailto:t.d.richmond@gmail.com>> wrot=
e:
> >>>>>>>     > >>>>>>>>
> >>>>>>>     > >>>>>>>> Chris, I had used the correct mountpoint in the co=
mmand.
> >>>>>>>     I just edited
> >>>>>>>     > >>>>>>>> it in the email to be /mountpoint for consistency.
> >>>>>>>     > >>>>>>>>
> >>>>>>>     > >>>>>>>> Qu, I'll try the repair. Fingers crossed!
> >>>>>>>     > >>>>>>>>
> >>>>>>>     > >>>>>>>> On Wed, May 6, 2020 at 9:13 PM Qu Wenruo
> >>>>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrot=
e:
> >>>>>>>     > >>>>>>>>>
> >>>>>>>     > >>>>>>>>>
> >>>>>>>     > >>>>>>>>>
> >>>>>>>     > >>>>>>>>> On 2020/5/7 =E4=B8=8A=E5=8D=885:54, Tyler Richmon=
d wrote:
> >>>>>>>     > >>>>>>>>>> Hello,
> >>>>>>>     > >>>>>>>>>>
> >>>>>>>     > >>>>>>>>>> I looked up this error and it basically says ask=
 a
> >>>>>>>     developer to
> >>>>>>>     > >>>>>>>>>> determine if it's a false error or not. I just s=
tarted
> >>>>>>>     getting some
> >>>>>>>     > >>>>>>>>>> slow response times, and looked at the dmesg log=
 to
> >>>>>>>     find a ton of
> >>>>>>>     > >>>>>>>>>> these errors.
> >>>>>>>     > >>>>>>>>>>
> >>>>>>>     > >>>>>>>>>> [192088.446299] BTRFS critical (device sdh): cor=
rupt
> >>>>>>>     leaf: root=3D5
> >>>>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, =
invalid inode
> >>>>>>>     generation:
> >>>>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
> >>>>>>>     > >>>>>>>>>> [192088.449823] BTRFS error (device sdh):
> >>>>>>>     block=3D203510940835840 read
> >>>>>>>     > >>>>>>>>>> time tree block corruption detected
> >>>>>>>     > >>>>>>>>>> [192088.459238] BTRFS critical (device sdh): cor=
rupt
> >>>>>>>     leaf: root=3D5
> >>>>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, =
invalid inode
> >>>>>>>     generation:
> >>>>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
> >>>>>>>     > >>>>>>>>>> [192088.462773] BTRFS error (device sdh):
> >>>>>>>     block=3D203510940835840 read
> >>>>>>>     > >>>>>>>>>> time tree block corruption detected
> >>>>>>>     > >>>>>>>>>> [192088.464711] BTRFS critical (device sdh): cor=
rupt
> >>>>>>>     leaf: root=3D5
> >>>>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, =
invalid inode
> >>>>>>>     generation:
> >>>>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
> >>>>>>>     > >>>>>>>>>> [192088.468457] BTRFS error (device sdh):
> >>>>>>>     block=3D203510940835840 read
> >>>>>>>     > >>>>>>>>>> time tree block corruption detected
> >>>>>>>     > >>>>>>>>>>
> >>>>>>>     > >>>>>>>>>> btrfs device stats, however, doesn't show any er=
rors.
> >>>>>>>     > >>>>>>>>>>
> >>>>>>>     > >>>>>>>>>> Is there anything I should do about this, or sho=
uld I
> >>>>>>>     just continue
> >>>>>>>     > >>>>>>>>>> using my array as normal?
> >>>>>>>     > >>>>>>>>>
> >>>>>>>     > >>>>>>>>> This is caused by older kernel underflow inode ge=
neration.
> >>>>>>>     > >>>>>>>>>
> >>>>>>>     > >>>>>>>>> Latest btrfs-progs can fix it, using btrfs check =
--repair.
> >>>>>>>     > >>>>>>>>>
> >>>>>>>     > >>>>>>>>> Or you can go safer, by manually locating the ino=
de
> >>>>>>>     using its inode
> >>>>>>>     > >>>>>>>>> number (1311670), and copy it to some new locatio=
n using
> >>>>>>>     previous
> >>>>>>>     > >>>>>>>>> working kernel, then delete the old file, copy th=
e new
> >>>>>>>     one back to fix it.
> >>>>>>>     > >>>>>>>>>
> >>>>>>>     > >>>>>>>>> Thanks,
> >>>>>>>     > >>>>>>>>> Qu
> >>>>>>>     > >>>>>>>>>
> >>>>>>>     > >>>>>>>>>>
> >>>>>>>     > >>>>>>>>>> Thank you!
> >>>>>>>     > >>>>>>>>>>
> >>>>>>>     > >>>>>>>>>
> >>>>>>>     > >>>>>>
> >>>>>>>     > >>>>
> >>>>>>>     > >>
> >>>>>>>     >
> >>>>>>>
> >>>>>>
> >>>
> >>
>
