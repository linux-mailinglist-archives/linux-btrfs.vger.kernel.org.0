Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1440624EAF4
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Aug 2020 04:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgHWCuG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Aug 2020 22:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgHWCuE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Aug 2020 22:50:04 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C45C061573
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Aug 2020 19:50:03 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m22so5914900ljj.5
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Aug 2020 19:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mAOn1QxiBsGhvrnLaCjoPUeakIBomIjAMIGN3yZV7Sg=;
        b=YFjaFbKXy1PmZcbo4lhKdaEDF0TZPBzbUmpnTp7QjzzCcyP05jK5aLtC/oUR06vsFs
         Gy176VbozqADvl2s6tV7DndP+r06Nbd5l+RfbsPqOEM9OjfKmXBCCJwJihkkmBrg6uvN
         BpSb12NlUkzjH5rwmwvygPrVmfffOmCNl50E174XmBmZEZzecOlGn5GR8fiQf3vMDKsF
         2jM8bUe2fwpLCTkejOONwp6/uMo3NXN2jvpbCrFpGkMiXygXVdZiYi2ezuzon4RjVCJy
         6XFjE+iVzpTvU9fKsfisMIYh+1OUDmF8lNwOvKkh81BS2GelC/OH/qG0m6wyv+aI0BWH
         YtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mAOn1QxiBsGhvrnLaCjoPUeakIBomIjAMIGN3yZV7Sg=;
        b=TY97SNB/3obnMuuOqHKdfaQj0oe1hC519uac2zteR++0ltBKWPFGQIHHPs2U2/7H/D
         4IDjawKMkmtdUbGiBCsbI2FfIQ8jiF0kn1TizzKCeoj92cyXpMOvhE6iE+0atxyBm5/1
         +MegbRfAaWYyDPnqkFUYUGR7rOiPrzkUYOSc3rTGM9bw3fZ6Oan7VYzEXCZJJQqFb3R2
         TNVFnkxthaSWnq36cSOHjpSKKuiYRXypSrba3EacV3VItHKvM3CswqwpaHpw7w5fcCRI
         RnsWRKD3803vK1nzGq5W45rAuW7CpcHXL2yNQScUIDLWr6cT51RfqfNqYX7Q7OxO/hTM
         +sqQ==
X-Gm-Message-State: AOAM532n+3u0h9LFrbAQdeVJPrjcCHpN/V3jzw0Rf7XxR3e7z+55o8t3
        ORJ0Wlhzx2vWv24lA1Hag39LH8KpYVRvlh9bi2rpW0l5
X-Google-Smtp-Source: ABdhPJwzxHBtSHQWP5k3hwN43cRu/ebyqiDU7+lJZgq94PNDTJ7tXJP/XYmrS6d2Raadg5MY9HDSf7dGO5w1qrZ9JzE=
X-Received: by 2002:a2e:b6d4:: with SMTP id m20mr74065ljo.465.1598151001772;
 Sat, 22 Aug 2020 19:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <CAJheHN26GYa7ezw-Jw_y5voFicoywwEJ2pJ4KKx96x-WA2h1eA@mail.gmail.com>
 <CAJheHN18TmG7g=-Sgi36hVmWka4z99rQRfaf=3FCRvat07C8pg@mail.gmail.com>
 <bbd08948-6672-4fb1-0e84-802482da7228@gmx.com> <CAJheHN3qgr+FNq+N3DiAQaPkbdcmV+1O8TetAX_HLU5V304Phw@mail.gmail.com>
 <155abe60-8970-c345-5f28-b4c2713d0c1e@gmx.com> <CAJheHN0EOPu9CuTT2hg=5HZskaC-yB2V5LSwNkrhP4XYYyv5+A@mail.gmail.com>
 <63677627-ca0a-663e-5443-9bd1b12ff5a9@gmx.com> <CAJheHN2mQX7VZxMZo+-GBhxeOWFu1tYAUfJ9Ut7hokMh-+ua-Q@mail.gmail.com>
 <5a9a2592-063a-5dfc-c157-47771d8bfb2b@gmx.com> <CAJheHN2-PbGC8S3f74CAFipsjxwXgip5N0zKG_xs-m8ky=WD2A@mail.gmail.com>
 <CAJheHN3qwDAGY=z14zfO4LBrxNJZZ_rvAMsWLwe-k+4+t3zLog@mail.gmail.com>
 <11fe4ad3-928c-5b6b-4424-26fc05baa28d@gmx.com> <CAJheHN2kY7kVyfo+kv0=DymXfnjiacX_a=rg7oXkeNV4x_XvHw@mail.gmail.com>
 <CAJheHN0qqOn2u4Rks6u+Epsr+L+ijs0E=G=AUCV3F-yLvsLasA@mail.gmail.com>
 <98c633bc-658c-d8d9-a2cd-4c9b9e477552@gmx.com> <6bc0816e-b58c-1d74-7c0e-e07a38a5a027@gmx.com>
In-Reply-To: <6bc0816e-b58c-1d74-7c0e-e07a38a5a027@gmx.com>
From:   Tyler Richmond <t.d.richmond@gmail.com>
Date:   Sat, 22 Aug 2020 22:49:50 -0400
Message-ID: <CAJheHN25gNo-jgykeQ6=ZQAm1ZHG9+-rWhBp3S-x2c1xi5j-og@mail.gmail.com>
Subject: Re: Fwd: Read time tree block corruption detected
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Well, I can guarantee that I didn't create this fs before 2015 (just
checked the order confirmation from when I bought the server), but I
may have just used whatever was in the Ubuntu package manager at the
time. So maybe I don't have a v0 ref?

On Sat, Aug 22, 2020 at 10:31 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/8/23 =E4=B8=8A=E5=8D=889:51, Qu Wenruo wrote:
> >
> >
> > On 2020/8/23 =E4=B8=8A=E5=8D=889:15, Tyler Richmond wrote:
> >> Is my best bet just to downgrade the kernel and then try to delete the
> >> broken files? Or should I rebuild from scratch? Just don't know
> >> whether it's worth the time to try and figure this out or if the
> >> problems stem from the FS being too old and it's beyond trying to
> >> repair.
> >
> > All invalid inode generations, should be able to be repaired by latest
> > btrfs-check.
> >
> > If not, please provide the btrfs-image dump for us to determine what's
> > going wrong.
> >
> > Thanks,
> > Qu
> >>
> >> On Tue, Aug 18, 2020 at 8:18 AM Tyler Richmond <t.d.richmond@gmail.com=
> wrote:
> >>>
> >>> I didn't check dmesg during the btrfs check, but that was the only
> >>> output during the rm -f before it was forced readonly. I just checked
> >>> dmesg for inode generation values, and there are a lot of them.
> >>>
> >>> https://pastebin.com/stZdN0ta
> >>> The dmesg output had 990 lines containing inode generation.
> >>>
> >>> However, these were at least later. I tried to do a btrfs balance
> >>> -mconvert raid1 and it failed with an I/O error. That is probably wha=
t
> >>> generated these specific errors, but maybe they were also happening
> >>> during the btrfs repair.
> >>>
> >>> The FS is ~45TB, but the btrfs-image -c9 failed anway with:
> >>> ERROR: either extent tree is corrupted or deprecated extent ref forma=
t
> >>> ERROR: create failed: -5
>
> Oh, forgot this part.
>
> This means you have v0 ref?!
>
> Then the fs is too old, no progs/kernel support after all.
>
> In that case, please rollback to the last working kernel and copy your da=
ta.
>
> In fact, that v0 ref should only be in the code base for several weeks
> before 2010, thus it's really too old.
>
> The good news is, with tree-checker, we should never experience such
> too-old-to-be-usable problem (at least I hope so)
>
> Thanks,
> Qu
>
> >>>
> >>>
> >>> On Tue, Aug 18, 2020 at 2:07 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
> >>>>
> >>>>
> >>>>
> >>>> On 2020/8/18 =E4=B8=8A=E5=8D=8811:35, Tyler Richmond wrote:
> >>>>> Qu,
> >>>>>
> >>>>> Sorry to resurrect this thread, but I just ran into something that =
I
> >>>>> can't really just ignore. I've found a folder that is full of files
> >>>>> which I guess have been broken somehow. I found a backup and restor=
ed
> >>>>> them, but I want to delete this folder of broken files. But wheneve=
r I
> >>>>> try, the fs is forced into readonly mode again. I just finished ano=
ther
> >>>>> btrfs check --repair but it didn't fix the problem.
> >>>>>
> >>>>> https://pastebin.com/eTV3s3fr
> >>>>
> >>>> Is that the full output?
> >>>>
> >>>> No inode generation bugs?
> >>>>>
> >>>>>  I'm already on btrfs-progs v5.7. Any new suggestions?
> >>>>
> >>>> Strange.
> >>>>
> >>>> The detection and repair should have been merged into v5.5.
> >>>>
> >>>> If your fs is small enough, would you please provide the "btrfs-imag=
e
> >>>> -c9" dump?
> >>>>
> >>>> It would contain the filenames and directories names, but doesn't
> >>>> contain file contents.
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>>>
> >>>>> On Fri, May 8, 2020 at 9:52 AM Tyler Richmond <t.d.richmond@gmail.c=
om
> >>>>> <mailto:t.d.richmond@gmail.com>> wrote:
> >>>>>
> >>>>>     5.6.1 also failed the same way. Here's the usage output. This i=
s the
> >>>>>     part where you see I've been using RAID5 haha
> >>>>>
> >>>>>     WARNING: RAID56 detected, not implemented
> >>>>>     Overall:
> >>>>>         Device size:                  60.03TiB
> >>>>>         Device allocated:             98.06GiB
> >>>>>         Device unallocated:           59.93TiB
> >>>>>         Device missing:                  0.00B
> >>>>>         Used:                         92.56GiB
> >>>>>         Free (estimated):                0.00B      (min: 8.00EiB)
> >>>>>         Data ratio:                       0.00
> >>>>>         Metadata ratio:                   2.00
> >>>>>         Global reserve:              512.00MiB      (used: 0.00B)
> >>>>>         Multiple profiles:                  no
> >>>>>
> >>>>>     Data,RAID5: Size:40.35TiB, Used:40.12TiB (99.42%)
> >>>>>        /dev/sdh        8.07TiB
> >>>>>        /dev/sdf        8.07TiB
> >>>>>        /dev/sdg        8.07TiB
> >>>>>        /dev/sdd        8.07TiB
> >>>>>        /dev/sdc        8.07TiB
> >>>>>        /dev/sde        8.07TiB
> >>>>>
> >>>>>     Metadata,RAID1: Size:49.00GiB, Used:46.28GiB (94.44%)
> >>>>>        /dev/sdh       34.00GiB
> >>>>>        /dev/sdf       32.00GiB
> >>>>>        /dev/sdg       32.00GiB
> >>>>>
> >>>>>     System,RAID1: Size:32.00MiB, Used:2.20MiB (6.87%)
> >>>>>        /dev/sdf       32.00MiB
> >>>>>        /dev/sdg       32.00MiB
> >>>>>
> >>>>>     Unallocated:
> >>>>>        /dev/sdh        2.81TiB
> >>>>>        /dev/sdf        2.81TiB
> >>>>>        /dev/sdg        2.81TiB
> >>>>>        /dev/sdd        1.03TiB
> >>>>>        /dev/sdc        1.03TiB
> >>>>>        /dev/sde        1.03TiB
> >>>>>
> >>>>>     On Fri, May 8, 2020 at 1:47 AM Qu Wenruo <quwenruo.btrfs@gmx.co=
m
> >>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
> >>>>>     >
> >>>>>     >
> >>>>>     >
> >>>>>     > On 2020/5/8 =E4=B8=8B=E5=8D=881:12, Tyler Richmond wrote:
> >>>>>     > > If this is saying there's no extra space for metadata, is t=
hat why
> >>>>>     > > adding more files often makes the system hang for 30-90s? I=
s there
> >>>>>     > > anything I should do about that?
> >>>>>     >
> >>>>>     > I'm not sure about the hang though.
> >>>>>     >
> >>>>>     > It would be nice to give more info to diagnosis.
> >>>>>     > The output of 'btrfs fi usage' is useful for space usage prob=
lem.
> >>>>>     >
> >>>>>     > But the common idea is, to keep at 1~2 Gi unallocated (not av=
aiable
> >>>>>     > space in vanilla df command) space for btrfs.
> >>>>>     >
> >>>>>     > Thanks,
> >>>>>     > Qu
> >>>>>     >
> >>>>>     > >
> >>>>>     > > Thank you so much for all of your help. I love how flexible=
 BTRFS is
> >>>>>     > > but when things go wrong it's very hard for me to troublesh=
oot.
> >>>>>     > >
> >>>>>     > > On Fri, May 8, 2020 at 1:07 AM Qu Wenruo <quwenruo.btrfs@gm=
x.com
> >>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
> >>>>>     > >>
> >>>>>     > >>
> >>>>>     > >>
> >>>>>     > >> On 2020/5/8 =E4=B8=8B=E5=8D=8812:23, Tyler Richmond wrote:
> >>>>>     > >>> Something went wrong:
> >>>>>     > >>>
> >>>>>     > >>> Reinitialize checksum tree
> >>>>>     > >>> Unable to find block group for 0
> >>>>>     > >>> Unable to find block group for 0
> >>>>>     > >>> Unable to find block group for 0
> >>>>>     > >>> ctree.c:2272: split_leaf: BUG_ON `1` triggered, value 1
> >>>>>     > >>> btrfs(+0x6dd94)[0x55a933af7d94]
> >>>>>     > >>> btrfs(+0x71b94)[0x55a933afbb94]
> >>>>>     > >>> btrfs(btrfs_search_slot+0x11f0)[0x55a933afd6c8]
> >>>>>     > >>> btrfs(btrfs_csum_file_block+0x432)[0x55a933b19d09]
> >>>>>     > >>> btrfs(+0x360b2)[0x55a933ac00b2]
> >>>>>     > >>> btrfs(+0x46a3e)[0x55a933ad0a3e]
> >>>>>     > >>> btrfs(main+0x98)[0x55a933a9fe88]
> >>>>>     > >>>
> >>>>>     /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf3)[0x7f263=
ed550b3]
> >>>>>     > >>> btrfs(_start+0x2e)[0x55a933a9fa0e]
> >>>>>     > >>> Aborted
> >>>>>     > >>
> >>>>>     > >> This means no space for extra metadata...
> >>>>>     > >>
> >>>>>     > >> Anyway the csum tree problem shouldn't be a big thing, you
> >>>>>     could leave
> >>>>>     > >> it and call it a day.
> >>>>>     > >>
> >>>>>     > >> BTW, as long as btrfs check reports no extra problem for t=
he inode
> >>>>>     > >> generation, it should be pretty safe to use the fs.
> >>>>>     > >>
> >>>>>     > >> Thanks,
> >>>>>     > >> Qu
> >>>>>     > >>>
> >>>>>     > >>> I just noticed I have btrfs-progs 5.6 installed and 5.6.1=
 is
> >>>>>     > >>> available. I'll let that try overnight?
> >>>>>     > >>>
> >>>>>     > >>> On Thu, May 7, 2020 at 8:11 PM Qu Wenruo
> >>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrote:
> >>>>>     > >>>>
> >>>>>     > >>>>
> >>>>>     > >>>>
> >>>>>     > >>>> On 2020/5/7 =E4=B8=8B=E5=8D=8811:52, Tyler Richmond wrot=
e:
> >>>>>     > >>>>> Thank you for helping. The end result of the scan was:
> >>>>>     > >>>>>
> >>>>>     > >>>>>
> >>>>>     > >>>>> [1/7] checking root items
> >>>>>     > >>>>> [2/7] checking extents
> >>>>>     > >>>>> [3/7] checking free space cache
> >>>>>     > >>>>> [4/7] checking fs roots
> >>>>>     > >>>>
> >>>>>     > >>>> Good news is, your fs is still mostly fine.
> >>>>>     > >>>>
> >>>>>     > >>>>> [5/7] checking only csums items (without verifying data=
)
> >>>>>     > >>>>> there are no extents for csum range 0-69632
> >>>>>     > >>>>> csum exists for 0-69632 but there is no extent record
> >>>>>     > >>>>> ...
> >>>>>     > >>>>> ...
> >>>>>     > >>>>> there are no extents for csum range 946692096-946827264
> >>>>>     > >>>>> csum exists for 946692096-946827264 but there is no ext=
ent
> >>>>>     record
> >>>>>     > >>>>> there are no extents for csum range 946831360-947912704
> >>>>>     > >>>>> csum exists for 946831360-947912704 but there is no ext=
ent
> >>>>>     record
> >>>>>     > >>>>> ERROR: errors found in csum tree
> >>>>>     > >>>>
> >>>>>     > >>>> Only extent tree is corrupted.
> >>>>>     > >>>>
> >>>>>     > >>>> Normally btrfs check --init-csum-tree should be able to
> >>>>>     handle it.
> >>>>>     > >>>>
> >>>>>     > >>>> But still, please be sure you're using the latest btrfs-=
progs
> >>>>>     to fix it.
> >>>>>     > >>>>
> >>>>>     > >>>> Thanks,
> >>>>>     > >>>> Qu
> >>>>>     > >>>>
> >>>>>     > >>>>> [6/7] checking root refs
> >>>>>     > >>>>> [7/7] checking quota groups skipped (not enabled on thi=
s FS)
> >>>>>     > >>>>> found 44157956026368 bytes used, error(s) found
> >>>>>     > >>>>> total csum bytes: 42038602716
> >>>>>     > >>>>> total tree bytes: 49688616960
> >>>>>     > >>>>> total fs tree bytes: 1256427520
> >>>>>     > >>>>> total extent tree bytes: 1709105152
> >>>>>     > >>>>> btree space waste bytes: 3172727316
> >>>>>     > >>>>> file data blocks allocated: 261625653436416
> >>>>>     > >>>>>  referenced 47477768499200
> >>>>>     > >>>>>
> >>>>>     > >>>>> What do I need to do to fix all of this?
> >>>>>     > >>>>>
> >>>>>     > >>>>> On Thu, May 7, 2020 at 1:52 AM Qu Wenruo
> >>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrote:
> >>>>>     > >>>>>>
> >>>>>     > >>>>>>
> >>>>>     > >>>>>>
> >>>>>     > >>>>>> On 2020/5/7 =E4=B8=8B=E5=8D=881:43, Tyler Richmond wro=
te:
> >>>>>     > >>>>>>> Well, the repair doesn't look terribly successful.
> >>>>>     > >>>>>>>
> >>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wante=
d
> >>>>>     6875841 found 6876224
> >>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wante=
d
> >>>>>     6875841 found 6876224
> >>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wante=
d
> >>>>>     6875841 found 6876224
> >>>>>     > >>>>>>> Ignoring transid failure
> >>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D2250499560=
61184
> >>>>>     item=3D84
> >>>>>     > >>>>>>> parent level=3D1
> >>>>>     > >>>>>>>                                             child lev=
el=3D4
> >>>>>     > >>>>>>
> >>>>>     > >>>>>> This means there are more problems, not only the hash =
name
> >>>>>     mismatch.
> >>>>>     > >>>>>>
> >>>>>     > >>>>>> This means the fs is already corrupted, the name hash =
is
> >>>>>     just one
> >>>>>     > >>>>>> unrelated symptom.
> >>>>>     > >>>>>>
> >>>>>     > >>>>>> The only good news is, btrfs-progs abort the transacti=
on,
> >>>>>     thus no
> >>>>>     > >>>>>> further damage to the fs.
> >>>>>     > >>>>>>
> >>>>>     > >>>>>> Please run a plain btrfs-check to show what's the prob=
lem
> >>>>>     first.
> >>>>>     > >>>>>>
> >>>>>     > >>>>>> Thanks,
> >>>>>     > >>>>>> Qu
> >>>>>     > >>>>>>
> >>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wante=
d
> >>>>>     6875841 found 6876224
> >>>>>     > >>>>>>> Ignoring transid failure
> >>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D2250499560=
61184
> >>>>>     item=3D84
> >>>>>     > >>>>>>> parent level=3D1
> >>>>>     > >>>>>>>                                             child lev=
el=3D4
> >>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wante=
d
> >>>>>     6875841 found 6876224
> >>>>>     > >>>>>>> Ignoring transid failure
> >>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D2250499560=
61184
> >>>>>     item=3D84
> >>>>>     > >>>>>>> parent level=3D1
> >>>>>     > >>>>>>>                                             child lev=
el=3D4
> >>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wante=
d
> >>>>>     6875841 found 6876224
> >>>>>     > >>>>>>> Ignoring transid failure
> >>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D2250499560=
61184
> >>>>>     item=3D84
> >>>>>     > >>>>>>> parent level=3D1
> >>>>>     > >>>>>>>                                             child lev=
el=3D4
> >>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wante=
d
> >>>>>     6875841 found 6876224
> >>>>>     > >>>>>>> Ignoring transid failure
> >>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D2250499560=
61184
> >>>>>     item=3D84
> >>>>>     > >>>>>>> parent level=3D1
> >>>>>     > >>>>>>>                                             child lev=
el=3D4
> >>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wante=
d
> >>>>>     6875841 found 6876224
> >>>>>     > >>>>>>> Ignoring transid failure
> >>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D2250499560=
61184
> >>>>>     item=3D84
> >>>>>     > >>>>>>> parent level=3D1
> >>>>>     > >>>>>>>                                             child lev=
el=3D4
> >>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wante=
d
> >>>>>     6875841 found 6876224
> >>>>>     > >>>>>>> Ignoring transid failure
> >>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D2250499560=
61184
> >>>>>     item=3D84
> >>>>>     > >>>>>>> parent level=3D1
> >>>>>     > >>>>>>>                                             child lev=
el=3D4
> >>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wante=
d
> >>>>>     6875841 found 6876224
> >>>>>     > >>>>>>> Ignoring transid failure
> >>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D2250499560=
61184
> >>>>>     item=3D84
> >>>>>     > >>>>>>> parent level=3D1
> >>>>>     > >>>>>>>                                             child lev=
el=3D4
> >>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wante=
d
> >>>>>     6875841 found 6876224
> >>>>>     > >>>>>>> Ignoring transid failure
> >>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D2250499560=
61184
> >>>>>     item=3D84
> >>>>>     > >>>>>>> parent level=3D1
> >>>>>     > >>>>>>>                                             child lev=
el=3D4
> >>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wante=
d
> >>>>>     6875841 found 6876224
> >>>>>     > >>>>>>> Ignoring transid failure
> >>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D2250499560=
61184
> >>>>>     item=3D84
> >>>>>     > >>>>>>> parent level=3D1
> >>>>>     > >>>>>>>                                             child lev=
el=3D4
> >>>>>     > >>>>>>> parent transid verify failed on 218620880703488 wante=
d
> >>>>>     6875841 found 6876224
> >>>>>     > >>>>>>> Ignoring transid failure
> >>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D2250499560=
61184
> >>>>>     item=3D84
> >>>>>     > >>>>>>> parent level=3D1
> >>>>>     > >>>>>>>                                             child lev=
el=3D4
> >>>>>     > >>>>>>> ERROR: failed to zero log tree: -17
> >>>>>     > >>>>>>> ERROR: attempt to start transaction over already runn=
ing one
> >>>>>     > >>>>>>> WARNING: reserved space leaked, flag=3D0x4 bytes_rese=
rved=3D4096
> >>>>>     > >>>>>>> extent buffer leak: start 225049066086400 len 4096
> >>>>>     > >>>>>>> extent buffer leak: start 225049066086400 len 4096
> >>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
> >>>>>     225049066086400 len 4096
> >>>>>     > >>>>>>> extent buffer leak: start 225049066094592 len 4096
> >>>>>     > >>>>>>> extent buffer leak: start 225049066094592 len 4096
> >>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
> >>>>>     225049066094592 len 4096
> >>>>>     > >>>>>>> extent buffer leak: start 225049066102784 len 4096
> >>>>>     > >>>>>>> extent buffer leak: start 225049066102784 len 4096
> >>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
> >>>>>     225049066102784 len 4096
> >>>>>     > >>>>>>> extent buffer leak: start 225049066131456 len 4096
> >>>>>     > >>>>>>> extent buffer leak: start 225049066131456 len 4096
> >>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): start
> >>>>>     225049066131456 len 4096
> >>>>>     > >>>>>>>
> >>>>>     > >>>>>>> What is going on?
> >>>>>     > >>>>>>>
> >>>>>     > >>>>>>> On Wed, May 6, 2020 at 9:30 PM Tyler Richmond
> >>>>>     <t.d.richmond@gmail.com <mailto:t.d.richmond@gmail.com>> wrote:
> >>>>>     > >>>>>>>>
> >>>>>     > >>>>>>>> Chris, I had used the correct mountpoint in the comm=
and.
> >>>>>     I just edited
> >>>>>     > >>>>>>>> it in the email to be /mountpoint for consistency.
> >>>>>     > >>>>>>>>
> >>>>>     > >>>>>>>> Qu, I'll try the repair. Fingers crossed!
> >>>>>     > >>>>>>>>
> >>>>>     > >>>>>>>> On Wed, May 6, 2020 at 9:13 PM Qu Wenruo
> >>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrote:
> >>>>>     > >>>>>>>>>
> >>>>>     > >>>>>>>>>
> >>>>>     > >>>>>>>>>
> >>>>>     > >>>>>>>>> On 2020/5/7 =E4=B8=8A=E5=8D=885:54, Tyler Richmond =
wrote:
> >>>>>     > >>>>>>>>>> Hello,
> >>>>>     > >>>>>>>>>>
> >>>>>     > >>>>>>>>>> I looked up this error and it basically says ask a
> >>>>>     developer to
> >>>>>     > >>>>>>>>>> determine if it's a false error or not. I just sta=
rted
> >>>>>     getting some
> >>>>>     > >>>>>>>>>> slow response times, and looked at the dmesg log t=
o
> >>>>>     find a ton of
> >>>>>     > >>>>>>>>>> these errors.
> >>>>>     > >>>>>>>>>>
> >>>>>     > >>>>>>>>>> [192088.446299] BTRFS critical (device sdh): corru=
pt
> >>>>>     leaf: root=3D5
> >>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, in=
valid inode
> >>>>>     generation:
> >>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
> >>>>>     > >>>>>>>>>> [192088.449823] BTRFS error (device sdh):
> >>>>>     block=3D203510940835840 read
> >>>>>     > >>>>>>>>>> time tree block corruption detected
> >>>>>     > >>>>>>>>>> [192088.459238] BTRFS critical (device sdh): corru=
pt
> >>>>>     leaf: root=3D5
> >>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, in=
valid inode
> >>>>>     generation:
> >>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
> >>>>>     > >>>>>>>>>> [192088.462773] BTRFS error (device sdh):
> >>>>>     block=3D203510940835840 read
> >>>>>     > >>>>>>>>>> time tree block corruption detected
> >>>>>     > >>>>>>>>>> [192088.464711] BTRFS critical (device sdh): corru=
pt
> >>>>>     leaf: root=3D5
> >>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, in=
valid inode
> >>>>>     generation:
> >>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
> >>>>>     > >>>>>>>>>> [192088.468457] BTRFS error (device sdh):
> >>>>>     block=3D203510940835840 read
> >>>>>     > >>>>>>>>>> time tree block corruption detected
> >>>>>     > >>>>>>>>>>
> >>>>>     > >>>>>>>>>> btrfs device stats, however, doesn't show any erro=
rs.
> >>>>>     > >>>>>>>>>>
> >>>>>     > >>>>>>>>>> Is there anything I should do about this, or shoul=
d I
> >>>>>     just continue
> >>>>>     > >>>>>>>>>> using my array as normal?
> >>>>>     > >>>>>>>>>
> >>>>>     > >>>>>>>>> This is caused by older kernel underflow inode gene=
ration.
> >>>>>     > >>>>>>>>>
> >>>>>     > >>>>>>>>> Latest btrfs-progs can fix it, using btrfs check --=
repair.
> >>>>>     > >>>>>>>>>
> >>>>>     > >>>>>>>>> Or you can go safer, by manually locating the inode
> >>>>>     using its inode
> >>>>>     > >>>>>>>>> number (1311670), and copy it to some new location =
using
> >>>>>     previous
> >>>>>     > >>>>>>>>> working kernel, then delete the old file, copy the =
new
> >>>>>     one back to fix it.
> >>>>>     > >>>>>>>>>
> >>>>>     > >>>>>>>>> Thanks,
> >>>>>     > >>>>>>>>> Qu
> >>>>>     > >>>>>>>>>
> >>>>>     > >>>>>>>>>>
> >>>>>     > >>>>>>>>>> Thank you!
> >>>>>     > >>>>>>>>>>
> >>>>>     > >>>>>>>>>
> >>>>>     > >>>>>>
> >>>>>     > >>>>
> >>>>>     > >>
> >>>>>     >
> >>>>>
> >>>>
> >
>
