Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E262A77A7
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 08:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgKEHBQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 02:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgKEHBP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 02:01:15 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F12BC0613CF
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 23:01:14 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id o13so406006ljj.11
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 23:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=baUXTpfSdUmGap4ScLuuPTl7y3xHWlHlnypaBrJfR9s=;
        b=DGa/Yt/MwIstyplOVG1ho6Z5b9wFABQInhQlMWjt1Knfi8ahOTEfXo2nSlmQfCTWc3
         BWLQAZPS7i0RNmzwUbFu2hVaeBHR4H8r7tvXx+j0wVIcvQHKm863KQ0g05DTdzaAu7pd
         +Jlvi/alMbtBfi9heD56oZgnVSZl7sAUw1TCSqs5wVQJ4DkyqS7oH5MFzqP4GydCgzqA
         TKmpDZ3S56BD+epoXIO9YRJPeurHmA09uYOAfCvj4C2NN416b5u41QVv1W2udqKdlj4R
         XG3/Imjk68Crvbhp5T1u07IDgURXnI5ymxRfFkvaVOLAOnNsgBmz+guFPP1tojv4V+aN
         CffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=baUXTpfSdUmGap4ScLuuPTl7y3xHWlHlnypaBrJfR9s=;
        b=dbIwNBIPVWs2T4+BH2bYWWOb5Joby2iBmNCCK+2MJy1fMCwhcrSogJMrw6F++mUF4K
         Ym6nQrg8TbiCaNVbey17ii4MCHIihAnt6/vChu+wgUeiCxkM+QhVI8w5+mYL/te1wcbA
         5E/PwmodWmkovJOT+Wa/HXzwR2UHmKjVo48RSkq4SySjtQM4ytnigitTRjwVScCsaSt6
         ZW8m8lBXqh/VWvkJ8mA40rCJS2fc5Wro05hLdt8BqjuARDyiFdpyMSQjQiGFVc1/XCkQ
         UvzBvH9yXLUksCofdC6DLscWXohjWWqzOd2jU1etpjddemCdzeCsQM1R/Co3Q+ZCxip1
         9RJg==
X-Gm-Message-State: AOAM531NQf6gjpDETauB6/e92v8cR9XGn6TbSSJhp3l1Cph1/NskCsLX
        9ZaXnJFdCxYCNv2GnndONwc1VItfXsBU6PHrO8+93C/JM2YYVg==
X-Google-Smtp-Source: ABdhPJz57WeFyXkNAd5bSZcLF5vCrBSzCiRhAq9bNrakI+9o87k5SaSYDR0phRg6dZEfKplFg52tXMBtOFb0Ejva/Bc=
X-Received: by 2002:a2e:946:: with SMTP id 67mr346694ljj.199.1604559672760;
 Wed, 04 Nov 2020 23:01:12 -0800 (PST)
MIME-Version: 1.0
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <5a9a2592-063a-5dfc-c157-47771d8bfb2b@gmx.com> <CAJheHN2-PbGC8S3f74CAFipsjxwXgip5N0zKG_xs-m8ky=WD2A@mail.gmail.com>
 <CAJheHN3qwDAGY=z14zfO4LBrxNJZZ_rvAMsWLwe-k+4+t3zLog@mail.gmail.com>
 <11fe4ad3-928c-5b6b-4424-26fc05baa28d@gmx.com> <CAJheHN2kY7kVyfo+kv0=DymXfnjiacX_a=rg7oXkeNV4x_XvHw@mail.gmail.com>
 <CAJheHN0qqOn2u4Rks6u+Epsr+L+ijs0E=G=AUCV3F-yLvsLasA@mail.gmail.com>
 <98c633bc-658c-d8d9-a2cd-4c9b9e477552@gmx.com> <6bc0816e-b58c-1d74-7c0e-e07a38a5a027@gmx.com>
 <CAJheHN25gNo-jgykeQ6=ZQAm1ZHG9+-rWhBp3S-x2c1xi5j-og@mail.gmail.com>
 <4d1bb444-921c-9773-ff68-b6ea074ff35d@gmx.com> <CAJheHN1+AQR-irSbaH8f7HGj=rDN4+uUCyqjvtezGewQkQoDpg@mail.gmail.com>
 <5346c4af-c73e-84b3-ec4f-8f169c0a732a@gmx.com> <CAJheHN0NmgVoGF+AsnUNQkQnEJ46JCmpg4o5nwAkqi+VoGMjfw@mail.gmail.com>
 <e04680b4-f4c0-254f-24ba-f2053e4ad8b3@gmx.com> <CAJheHN0THhKcqKY3cGtJqUGaub=E0tuCmi6wuNeCGBxyAHmecQ@mail.gmail.com>
 <e2c8eaaf-6adb-374f-4005-a1edcbcb8f79@gmx.com> <CAJheHN1U4j1KsD96oFuCVwP+6RVP6V6oAZP-aGOTtfm7tDL3BA@mail.gmail.com>
In-Reply-To: <CAJheHN1U4j1KsD96oFuCVwP+6RVP6V6oAZP-aGOTtfm7tDL3BA@mail.gmail.com>
From:   Tyler Richmond <t.d.richmond@gmail.com>
Date:   Thu, 5 Nov 2020 02:01:00 -0500
Message-ID: <CAJheHN3pTj-6dOQZVKqA_r38F+WVNrjVO6-Z_hFeq96uTNK5zw@mail.gmail.com>
Subject: Re: Fwd: Read time tree block corruption detected
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu,

I'm wondering, was a fix for this ever implemented? I recently added a
new drive to expand the array, and during the rebalance it dropped
itself back to a read only filesystem. I suspect it's related to the
issues discussed earlier in this thread. Is there anything I can do to
complete the balance? The error that caused it to drop to read only is
here: https://pastebin.com/GGYVMaiG

Thanks!


On Tue, Aug 25, 2020 at 9:43 AM Tyler Richmond <t.d.richmond@gmail.com> wro=
te:
>
> Great, glad we got somewhere! I'll look forward to the fix!
>
> On Tue, Aug 25, 2020 at 9:38 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >
> >
> >
> > On 2020/8/25 =E4=B8=8B=E5=8D=889:30, Tyler Richmond wrote:
> > > Qu,
> > >
> > > The dump of the block is:
> > >
> > > https://pastebin.com/ran85JJv
> > >
> > > I've also completed the btrfs-image, but it's almost 50gb. What's the
> > > best way to get it to you? Also, does it work with -ss or are the
> > > original filenames important?
> >
> > 50G is too big for me to even receive.
> >
> > But your dump shows the problem!
> >
> > It's not inode generation, but inode transid, which would affect send.
> >
> > This is not even checked in btrfs-progs, thus no wonder why it doesn't
> > detect them.
> >
> > And copy-pasted kernel message shares the same "generation" word, not
> > using proper transid to show the problem.
> >
> > Your dump really saved the day!
> >
> > The fix for kernel and btrfs-progs would come in next few days.
> >
> > Thanks,
> > Qu
> > >
> > > Thanks again!
> > >
> > >
> > > On Tue, Aug 25, 2020 at 2:37 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
> > >>
> > >>
> > >>
> > >> On 2020/8/25 =E4=B8=8B=E5=8D=881:25, Tyler Richmond wrote:
> > >>> Qu,
> > >>>
> > >>> Yes, it's btrfs-progs 5.7. Here is the result of the lowmem check:
> > >>>
> > >>> https://pastebin.com/8Tzx23EX
> > >>
> > >> That doesn't detect any inode generation problem at all, which is no=
t a
> > >> good sign.
> > >>
> > >> Would you also pvode the dump for the offending block?
> > >>
> > >>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode gener=
ation:
> > >> has 18446744073709551492 expect [0, 6875827]
> > >>
> > >> For this case, would you please provide the tree dump of "2035109408=
35840" ?
> > >>
> > >> # btrfs ins dump-tree -b 203510940835840 <device>
> > >>
> > >> And, since btrfs-image can't dump with regular extent tree, the "-w"
> > >> dump would also help.
> > >>
> > >> Thanks,
> > >> Qu
> > >>
> > >>
> > >>> Thanks!
> > >>>
> > >>> On Mon, Aug 24, 2020 at 4:26 AM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
> > >>>>
> > >>>>
> > >>>>
> > >>>> On 2020/8/24 =E4=B8=8A=E5=8D=8810:47, Tyler Richmond wrote:
> > >>>>> Qu,
> > >>>>>
> > >>>>> Finally finished another repair and captured the output.
> > >>>>>
> > >>>>> https://pastebin.com/ffcbwvd8
> > >>>>>
> > >>>>> Does that show you what you need? Or should I still do one in low=
mem mode?
> > >>>>
> > >>>> Lowmem mode (no need for --repair) is recommended since original m=
ode
> > >>>> doesn't detect the inode generation problem.
> > >>>>
> > >>>> And it's already btrfs-progs v5.7 right?
> > >>>>
> > >>>> THanks,
> > >>>> Qu
> > >>>>>
> > >>>>> Thanks for your help!
> > >>>>>
> > >>>>> On Sun, Aug 23, 2020 at 12:28 AM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
> > >>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>> On 2020/8/23 =E4=B8=8A=E5=8D=8810:49, Tyler Richmond wrote:
> > >>>>>>> Well, I can guarantee that I didn't create this fs before 2015 =
(just
> > >>>>>>> checked the order confirmation from when I bought the server), =
but I
> > >>>>>>> may have just used whatever was in the Ubuntu package manager a=
t the
> > >>>>>>> time. So maybe I don't have a v0 ref?
> > >>>>>>
> > >>>>>> Then btrfs-image shouldn't report that.
> > >>>>>>
> > >>>>>> There is an item smaller than any valid btrfs item, normally it =
means
> > >>>>>> it's a v0 ref.
> > >>>>>> If not, then it could be a bigger problem.
> > >>>>>>
> > >>>>>> Could you please provide the full btrfs-check output?
> > >>>>>> Also, if possible result from "btrfs check --mode=3Dlowmem" woul=
d also help.
> > >>>>>>
> > >>>>>> Also, if you really go "--repair", then the full output would al=
so be
> > >>>>>> needed to determine what's going wrong.
> > >>>>>> There is a report about "btrfs check --repair" didn't repair the=
 inode
> > >>>>>> generation, if that's the case we must have a bug then.
> > >>>>>>
> > >>>>>> Thanks,
> > >>>>>> Qu
> > >>>>>>>
> > >>>>>>> On Sat, Aug 22, 2020 at 10:31 PM Qu Wenruo <quwenruo.btrfs@gmx.=
com> wrote:
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>> On 2020/8/23 =E4=B8=8A=E5=8D=889:51, Qu Wenruo wrote:
> > >>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>>> On 2020/8/23 =E4=B8=8A=E5=8D=889:15, Tyler Richmond wrote:
> > >>>>>>>>>> Is my best bet just to downgrade the kernel and then try to =
delete the
> > >>>>>>>>>> broken files? Or should I rebuild from scratch? Just don't k=
now
> > >>>>>>>>>> whether it's worth the time to try and figure this out or if=
 the
> > >>>>>>>>>> problems stem from the FS being too old and it's beyond tryi=
ng to
> > >>>>>>>>>> repair.
> > >>>>>>>>>
> > >>>>>>>>> All invalid inode generations, should be able to be repaired =
by latest
> > >>>>>>>>> btrfs-check.
> > >>>>>>>>>
> > >>>>>>>>> If not, please provide the btrfs-image dump for us to determi=
ne what's
> > >>>>>>>>> going wrong.
> > >>>>>>>>>
> > >>>>>>>>> Thanks,
> > >>>>>>>>> Qu
> > >>>>>>>>>>
> > >>>>>>>>>> On Tue, Aug 18, 2020 at 8:18 AM Tyler Richmond <t.d.richmond=
@gmail.com> wrote:
> > >>>>>>>>>>>
> > >>>>>>>>>>> I didn't check dmesg during the btrfs check, but that was t=
he only
> > >>>>>>>>>>> output during the rm -f before it was forced readonly. I ju=
st checked
> > >>>>>>>>>>> dmesg for inode generation values, and there are a lot of t=
hem.
> > >>>>>>>>>>>
> > >>>>>>>>>>> https://pastebin.com/stZdN0ta
> > >>>>>>>>>>> The dmesg output had 990 lines containing inode generation.
> > >>>>>>>>>>>
> > >>>>>>>>>>> However, these were at least later. I tried to do a btrfs b=
alance
> > >>>>>>>>>>> -mconvert raid1 and it failed with an I/O error. That is pr=
obably what
> > >>>>>>>>>>> generated these specific errors, but maybe they were also h=
appening
> > >>>>>>>>>>> during the btrfs repair.
> > >>>>>>>>>>>
> > >>>>>>>>>>> The FS is ~45TB, but the btrfs-image -c9 failed anway with:
> > >>>>>>>>>>> ERROR: either extent tree is corrupted or deprecated extent=
 ref format
> > >>>>>>>>>>> ERROR: create failed: -5
> > >>>>>>>>
> > >>>>>>>> Oh, forgot this part.
> > >>>>>>>>
> > >>>>>>>> This means you have v0 ref?!
> > >>>>>>>>
> > >>>>>>>> Then the fs is too old, no progs/kernel support after all.
> > >>>>>>>>
> > >>>>>>>> In that case, please rollback to the last working kernel and c=
opy your data.
> > >>>>>>>>
> > >>>>>>>> In fact, that v0 ref should only be in the code base for sever=
al weeks
> > >>>>>>>> before 2010, thus it's really too old.
> > >>>>>>>>
> > >>>>>>>> The good news is, with tree-checker, we should never experienc=
e such
> > >>>>>>>> too-old-to-be-usable problem (at least I hope so)
> > >>>>>>>>
> > >>>>>>>> Thanks,
> > >>>>>>>> Qu
> > >>>>>>>>
> > >>>>>>>>>>>
> > >>>>>>>>>>>
> > >>>>>>>>>>> On Tue, Aug 18, 2020 at 2:07 AM Qu Wenruo <quwenruo.btrfs@g=
mx.com> wrote:
> > >>>>>>>>>>>>
> > >>>>>>>>>>>>
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> On 2020/8/18 =E4=B8=8A=E5=8D=8811:35, Tyler Richmond wrote=
:
> > >>>>>>>>>>>>> Qu,
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>> Sorry to resurrect this thread, but I just ran into somet=
hing that I
> > >>>>>>>>>>>>> can't really just ignore. I've found a folder that is ful=
l of files
> > >>>>>>>>>>>>> which I guess have been broken somehow. I found a backup =
and restored
> > >>>>>>>>>>>>> them, but I want to delete this folder of broken files. B=
ut whenever I
> > >>>>>>>>>>>>> try, the fs is forced into readonly mode again. I just fi=
nished another
> > >>>>>>>>>>>>> btrfs check --repair but it didn't fix the problem.
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>> https://pastebin.com/eTV3s3fr
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> Is that the full output?
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> No inode generation bugs?
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>>  I'm already on btrfs-progs v5.7. Any new suggestions?
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> Strange.
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> The detection and repair should have been merged into v5.5=
.
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> If your fs is small enough, would you please provide the "=
btrfs-image
> > >>>>>>>>>>>> -c9" dump?
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> It would contain the filenames and directories names, but =
doesn't
> > >>>>>>>>>>>> contain file contents.
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> Thanks,
> > >>>>>>>>>>>> Qu
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>> On Fri, May 8, 2020 at 9:52 AM Tyler Richmond <t.d.richmo=
nd@gmail.com
> > >>>>>>>>>>>>> <mailto:t.d.richmond@gmail.com>> wrote:
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>>     5.6.1 also failed the same way. Here's the usage outp=
ut. This is the
> > >>>>>>>>>>>>>     part where you see I've been using RAID5 haha
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>>     WARNING: RAID56 detected, not implemented
> > >>>>>>>>>>>>>     Overall:
> > >>>>>>>>>>>>>         Device size:                  60.03TiB
> > >>>>>>>>>>>>>         Device allocated:             98.06GiB
> > >>>>>>>>>>>>>         Device unallocated:           59.93TiB
> > >>>>>>>>>>>>>         Device missing:                  0.00B
> > >>>>>>>>>>>>>         Used:                         92.56GiB
> > >>>>>>>>>>>>>         Free (estimated):                0.00B      (min:=
 8.00EiB)
> > >>>>>>>>>>>>>         Data ratio:                       0.00
> > >>>>>>>>>>>>>         Metadata ratio:                   2.00
> > >>>>>>>>>>>>>         Global reserve:              512.00MiB      (used=
: 0.00B)
> > >>>>>>>>>>>>>         Multiple profiles:                  no
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>>     Data,RAID5: Size:40.35TiB, Used:40.12TiB (99.42%)
> > >>>>>>>>>>>>>        /dev/sdh        8.07TiB
> > >>>>>>>>>>>>>        /dev/sdf        8.07TiB
> > >>>>>>>>>>>>>        /dev/sdg        8.07TiB
> > >>>>>>>>>>>>>        /dev/sdd        8.07TiB
> > >>>>>>>>>>>>>        /dev/sdc        8.07TiB
> > >>>>>>>>>>>>>        /dev/sde        8.07TiB
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>>     Metadata,RAID1: Size:49.00GiB, Used:46.28GiB (94.44%)
> > >>>>>>>>>>>>>        /dev/sdh       34.00GiB
> > >>>>>>>>>>>>>        /dev/sdf       32.00GiB
> > >>>>>>>>>>>>>        /dev/sdg       32.00GiB
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>>     System,RAID1: Size:32.00MiB, Used:2.20MiB (6.87%)
> > >>>>>>>>>>>>>        /dev/sdf       32.00MiB
> > >>>>>>>>>>>>>        /dev/sdg       32.00MiB
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>>     Unallocated:
> > >>>>>>>>>>>>>        /dev/sdh        2.81TiB
> > >>>>>>>>>>>>>        /dev/sdf        2.81TiB
> > >>>>>>>>>>>>>        /dev/sdg        2.81TiB
> > >>>>>>>>>>>>>        /dev/sdd        1.03TiB
> > >>>>>>>>>>>>>        /dev/sdc        1.03TiB
> > >>>>>>>>>>>>>        /dev/sde        1.03TiB
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>>     On Fri, May 8, 2020 at 1:47 AM Qu Wenruo <quwenruo.bt=
rfs@gmx.com
> > >>>>>>>>>>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
> > >>>>>>>>>>>>>     >
> > >>>>>>>>>>>>>     >
> > >>>>>>>>>>>>>     >
> > >>>>>>>>>>>>>     > On 2020/5/8 =E4=B8=8B=E5=8D=881:12, Tyler Richmond =
wrote:
> > >>>>>>>>>>>>>     > > If this is saying there's no extra space for meta=
data, is that why
> > >>>>>>>>>>>>>     > > adding more files often makes the system hang for=
 30-90s? Is there
> > >>>>>>>>>>>>>     > > anything I should do about that?
> > >>>>>>>>>>>>>     >
> > >>>>>>>>>>>>>     > I'm not sure about the hang though.
> > >>>>>>>>>>>>>     >
> > >>>>>>>>>>>>>     > It would be nice to give more info to diagnosis.
> > >>>>>>>>>>>>>     > The output of 'btrfs fi usage' is useful for space =
usage problem.
> > >>>>>>>>>>>>>     >
> > >>>>>>>>>>>>>     > But the common idea is, to keep at 1~2 Gi unallocat=
ed (not avaiable
> > >>>>>>>>>>>>>     > space in vanilla df command) space for btrfs.
> > >>>>>>>>>>>>>     >
> > >>>>>>>>>>>>>     > Thanks,
> > >>>>>>>>>>>>>     > Qu
> > >>>>>>>>>>>>>     >
> > >>>>>>>>>>>>>     > >
> > >>>>>>>>>>>>>     > > Thank you so much for all of your help. I love ho=
w flexible BTRFS is
> > >>>>>>>>>>>>>     > > but when things go wrong it's very hard for me to=
 troubleshoot.
> > >>>>>>>>>>>>>     > >
> > >>>>>>>>>>>>>     > > On Fri, May 8, 2020 at 1:07 AM Qu Wenruo <quwenru=
o.btrfs@gmx.com
> > >>>>>>>>>>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
> > >>>>>>>>>>>>>     > >>
> > >>>>>>>>>>>>>     > >>
> > >>>>>>>>>>>>>     > >>
> > >>>>>>>>>>>>>     > >> On 2020/5/8 =E4=B8=8B=E5=8D=8812:23, Tyler Richm=
ond wrote:
> > >>>>>>>>>>>>>     > >>> Something went wrong:
> > >>>>>>>>>>>>>     > >>>
> > >>>>>>>>>>>>>     > >>> Reinitialize checksum tree
> > >>>>>>>>>>>>>     > >>> Unable to find block group for 0
> > >>>>>>>>>>>>>     > >>> Unable to find block group for 0
> > >>>>>>>>>>>>>     > >>> Unable to find block group for 0
> > >>>>>>>>>>>>>     > >>> ctree.c:2272: split_leaf: BUG_ON `1` triggered,=
 value 1
> > >>>>>>>>>>>>>     > >>> btrfs(+0x6dd94)[0x55a933af7d94]
> > >>>>>>>>>>>>>     > >>> btrfs(+0x71b94)[0x55a933afbb94]
> > >>>>>>>>>>>>>     > >>> btrfs(btrfs_search_slot+0x11f0)[0x55a933afd6c8]
> > >>>>>>>>>>>>>     > >>> btrfs(btrfs_csum_file_block+0x432)[0x55a933b19d=
09]
> > >>>>>>>>>>>>>     > >>> btrfs(+0x360b2)[0x55a933ac00b2]
> > >>>>>>>>>>>>>     > >>> btrfs(+0x46a3e)[0x55a933ad0a3e]
> > >>>>>>>>>>>>>     > >>> btrfs(main+0x98)[0x55a933a9fe88]
> > >>>>>>>>>>>>>     > >>>
> > >>>>>>>>>>>>>     /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf=
3)[0x7f263ed550b3]
> > >>>>>>>>>>>>>     > >>> btrfs(_start+0x2e)[0x55a933a9fa0e]
> > >>>>>>>>>>>>>     > >>> Aborted
> > >>>>>>>>>>>>>     > >>
> > >>>>>>>>>>>>>     > >> This means no space for extra metadata...
> > >>>>>>>>>>>>>     > >>
> > >>>>>>>>>>>>>     > >> Anyway the csum tree problem shouldn't be a big =
thing, you
> > >>>>>>>>>>>>>     could leave
> > >>>>>>>>>>>>>     > >> it and call it a day.
> > >>>>>>>>>>>>>     > >>
> > >>>>>>>>>>>>>     > >> BTW, as long as btrfs check reports no extra pro=
blem for the inode
> > >>>>>>>>>>>>>     > >> generation, it should be pretty safe to use the =
fs.
> > >>>>>>>>>>>>>     > >>
> > >>>>>>>>>>>>>     > >> Thanks,
> > >>>>>>>>>>>>>     > >> Qu
> > >>>>>>>>>>>>>     > >>>
> > >>>>>>>>>>>>>     > >>> I just noticed I have btrfs-progs 5.6 installed=
 and 5.6.1 is
> > >>>>>>>>>>>>>     > >>> available. I'll let that try overnight?
> > >>>>>>>>>>>>>     > >>>
> > >>>>>>>>>>>>>     > >>> On Thu, May 7, 2020 at 8:11 PM Qu Wenruo
> > >>>>>>>>>>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.co=
m>> wrote:
> > >>>>>>>>>>>>>     > >>>>
> > >>>>>>>>>>>>>     > >>>>
> > >>>>>>>>>>>>>     > >>>>
> > >>>>>>>>>>>>>     > >>>> On 2020/5/7 =E4=B8=8B=E5=8D=8811:52, Tyler Ric=
hmond wrote:
> > >>>>>>>>>>>>>     > >>>>> Thank you for helping. The end result of the =
scan was:
> > >>>>>>>>>>>>>     > >>>>>
> > >>>>>>>>>>>>>     > >>>>>
> > >>>>>>>>>>>>>     > >>>>> [1/7] checking root items
> > >>>>>>>>>>>>>     > >>>>> [2/7] checking extents
> > >>>>>>>>>>>>>     > >>>>> [3/7] checking free space cache
> > >>>>>>>>>>>>>     > >>>>> [4/7] checking fs roots
> > >>>>>>>>>>>>>     > >>>>
> > >>>>>>>>>>>>>     > >>>> Good news is, your fs is still mostly fine.
> > >>>>>>>>>>>>>     > >>>>
> > >>>>>>>>>>>>>     > >>>>> [5/7] checking only csums items (without veri=
fying data)
> > >>>>>>>>>>>>>     > >>>>> there are no extents for csum range 0-69632
> > >>>>>>>>>>>>>     > >>>>> csum exists for 0-69632 but there is no exten=
t record
> > >>>>>>>>>>>>>     > >>>>> ...
> > >>>>>>>>>>>>>     > >>>>> ...
> > >>>>>>>>>>>>>     > >>>>> there are no extents for csum range 946692096=
-946827264
> > >>>>>>>>>>>>>     > >>>>> csum exists for 946692096-946827264 but there=
 is no extent
> > >>>>>>>>>>>>>     record
> > >>>>>>>>>>>>>     > >>>>> there are no extents for csum range 946831360=
-947912704
> > >>>>>>>>>>>>>     > >>>>> csum exists for 946831360-947912704 but there=
 is no extent
> > >>>>>>>>>>>>>     record
> > >>>>>>>>>>>>>     > >>>>> ERROR: errors found in csum tree
> > >>>>>>>>>>>>>     > >>>>
> > >>>>>>>>>>>>>     > >>>> Only extent tree is corrupted.
> > >>>>>>>>>>>>>     > >>>>
> > >>>>>>>>>>>>>     > >>>> Normally btrfs check --init-csum-tree should b=
e able to
> > >>>>>>>>>>>>>     handle it.
> > >>>>>>>>>>>>>     > >>>>
> > >>>>>>>>>>>>>     > >>>> But still, please be sure you're using the lat=
est btrfs-progs
> > >>>>>>>>>>>>>     to fix it.
> > >>>>>>>>>>>>>     > >>>>
> > >>>>>>>>>>>>>     > >>>> Thanks,
> > >>>>>>>>>>>>>     > >>>> Qu
> > >>>>>>>>>>>>>     > >>>>
> > >>>>>>>>>>>>>     > >>>>> [6/7] checking root refs
> > >>>>>>>>>>>>>     > >>>>> [7/7] checking quota groups skipped (not enab=
led on this FS)
> > >>>>>>>>>>>>>     > >>>>> found 44157956026368 bytes used, error(s) fou=
nd
> > >>>>>>>>>>>>>     > >>>>> total csum bytes: 42038602716
> > >>>>>>>>>>>>>     > >>>>> total tree bytes: 49688616960
> > >>>>>>>>>>>>>     > >>>>> total fs tree bytes: 1256427520
> > >>>>>>>>>>>>>     > >>>>> total extent tree bytes: 1709105152
> > >>>>>>>>>>>>>     > >>>>> btree space waste bytes: 3172727316
> > >>>>>>>>>>>>>     > >>>>> file data blocks allocated: 261625653436416
> > >>>>>>>>>>>>>     > >>>>>  referenced 47477768499200
> > >>>>>>>>>>>>>     > >>>>>
> > >>>>>>>>>>>>>     > >>>>> What do I need to do to fix all of this?
> > >>>>>>>>>>>>>     > >>>>>
> > >>>>>>>>>>>>>     > >>>>> On Thu, May 7, 2020 at 1:52 AM Qu Wenruo
> > >>>>>>>>>>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.co=
m>> wrote:
> > >>>>>>>>>>>>>     > >>>>>>
> > >>>>>>>>>>>>>     > >>>>>>
> > >>>>>>>>>>>>>     > >>>>>>
> > >>>>>>>>>>>>>     > >>>>>> On 2020/5/7 =E4=B8=8B=E5=8D=881:43, Tyler Ri=
chmond wrote:
> > >>>>>>>>>>>>>     > >>>>>>> Well, the repair doesn't look terribly succ=
essful.
> > >>>>>>>>>>>>>     > >>>>>>>
> > >>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 21862088070=
3488 wanted
> > >>>>>>>>>>>>>     6875841 found 6876224
> > >>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 21862088070=
3488 wanted
> > >>>>>>>>>>>>>     6875841 found 6876224
> > >>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 21862088070=
3488 wanted
> > >>>>>>>>>>>>>     6875841 found 6876224
> > >>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
> > >>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D=
225049956061184
> > >>>>>>>>>>>>>     item=3D84
> > >>>>>>>>>>>>>     > >>>>>>> parent level=3D1
> > >>>>>>>>>>>>>     > >>>>>>>                                            =
 child level=3D4
> > >>>>>>>>>>>>>     > >>>>>>
> > >>>>>>>>>>>>>     > >>>>>> This means there are more problems, not only=
 the hash name
> > >>>>>>>>>>>>>     mismatch.
> > >>>>>>>>>>>>>     > >>>>>>
> > >>>>>>>>>>>>>     > >>>>>> This means the fs is already corrupted, the =
name hash is
> > >>>>>>>>>>>>>     just one
> > >>>>>>>>>>>>>     > >>>>>> unrelated symptom.
> > >>>>>>>>>>>>>     > >>>>>>
> > >>>>>>>>>>>>>     > >>>>>> The only good news is, btrfs-progs abort the=
 transaction,
> > >>>>>>>>>>>>>     thus no
> > >>>>>>>>>>>>>     > >>>>>> further damage to the fs.
> > >>>>>>>>>>>>>     > >>>>>>
> > >>>>>>>>>>>>>     > >>>>>> Please run a plain btrfs-check to show what'=
s the problem
> > >>>>>>>>>>>>>     first.
> > >>>>>>>>>>>>>     > >>>>>>
> > >>>>>>>>>>>>>     > >>>>>> Thanks,
> > >>>>>>>>>>>>>     > >>>>>> Qu
> > >>>>>>>>>>>>>     > >>>>>>
> > >>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 21862088070=
3488 wanted
> > >>>>>>>>>>>>>     6875841 found 6876224
> > >>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
> > >>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D=
225049956061184
> > >>>>>>>>>>>>>     item=3D84
> > >>>>>>>>>>>>>     > >>>>>>> parent level=3D1
> > >>>>>>>>>>>>>     > >>>>>>>                                            =
 child level=3D4
> > >>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 21862088070=
3488 wanted
> > >>>>>>>>>>>>>     6875841 found 6876224
> > >>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
> > >>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D=
225049956061184
> > >>>>>>>>>>>>>     item=3D84
> > >>>>>>>>>>>>>     > >>>>>>> parent level=3D1
> > >>>>>>>>>>>>>     > >>>>>>>                                            =
 child level=3D4
> > >>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 21862088070=
3488 wanted
> > >>>>>>>>>>>>>     6875841 found 6876224
> > >>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
> > >>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D=
225049956061184
> > >>>>>>>>>>>>>     item=3D84
> > >>>>>>>>>>>>>     > >>>>>>> parent level=3D1
> > >>>>>>>>>>>>>     > >>>>>>>                                            =
 child level=3D4
> > >>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 21862088070=
3488 wanted
> > >>>>>>>>>>>>>     6875841 found 6876224
> > >>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
> > >>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D=
225049956061184
> > >>>>>>>>>>>>>     item=3D84
> > >>>>>>>>>>>>>     > >>>>>>> parent level=3D1
> > >>>>>>>>>>>>>     > >>>>>>>                                            =
 child level=3D4
> > >>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 21862088070=
3488 wanted
> > >>>>>>>>>>>>>     6875841 found 6876224
> > >>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
> > >>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D=
225049956061184
> > >>>>>>>>>>>>>     item=3D84
> > >>>>>>>>>>>>>     > >>>>>>> parent level=3D1
> > >>>>>>>>>>>>>     > >>>>>>>                                            =
 child level=3D4
> > >>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 21862088070=
3488 wanted
> > >>>>>>>>>>>>>     6875841 found 6876224
> > >>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
> > >>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D=
225049956061184
> > >>>>>>>>>>>>>     item=3D84
> > >>>>>>>>>>>>>     > >>>>>>> parent level=3D1
> > >>>>>>>>>>>>>     > >>>>>>>                                            =
 child level=3D4
> > >>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 21862088070=
3488 wanted
> > >>>>>>>>>>>>>     6875841 found 6876224
> > >>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
> > >>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D=
225049956061184
> > >>>>>>>>>>>>>     item=3D84
> > >>>>>>>>>>>>>     > >>>>>>> parent level=3D1
> > >>>>>>>>>>>>>     > >>>>>>>                                            =
 child level=3D4
> > >>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 21862088070=
3488 wanted
> > >>>>>>>>>>>>>     6875841 found 6876224
> > >>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
> > >>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D=
225049956061184
> > >>>>>>>>>>>>>     item=3D84
> > >>>>>>>>>>>>>     > >>>>>>> parent level=3D1
> > >>>>>>>>>>>>>     > >>>>>>>                                            =
 child level=3D4
> > >>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 21862088070=
3488 wanted
> > >>>>>>>>>>>>>     6875841 found 6876224
> > >>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
> > >>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D=
225049956061184
> > >>>>>>>>>>>>>     item=3D84
> > >>>>>>>>>>>>>     > >>>>>>> parent level=3D1
> > >>>>>>>>>>>>>     > >>>>>>>                                            =
 child level=3D4
> > >>>>>>>>>>>>>     > >>>>>>> parent transid verify failed on 21862088070=
3488 wanted
> > >>>>>>>>>>>>>     6875841 found 6876224
> > >>>>>>>>>>>>>     > >>>>>>> Ignoring transid failure
> > >>>>>>>>>>>>>     > >>>>>>> ERROR: child eb corrupted: parent bytenr=3D=
225049956061184
> > >>>>>>>>>>>>>     item=3D84
> > >>>>>>>>>>>>>     > >>>>>>> parent level=3D1
> > >>>>>>>>>>>>>     > >>>>>>>                                            =
 child level=3D4
> > >>>>>>>>>>>>>     > >>>>>>> ERROR: failed to zero log tree: -17
> > >>>>>>>>>>>>>     > >>>>>>> ERROR: attempt to start transaction over al=
ready running one
> > >>>>>>>>>>>>>     > >>>>>>> WARNING: reserved space leaked, flag=3D0x4 =
bytes_reserved=3D4096
> > >>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066086400 l=
en 4096
> > >>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066086400 l=
en 4096
> > >>>>>>>>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): sta=
rt
> > >>>>>>>>>>>>>     225049066086400 len 4096
> > >>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066094592 l=
en 4096
> > >>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066094592 l=
en 4096
> > >>>>>>>>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): sta=
rt
> > >>>>>>>>>>>>>     225049066094592 len 4096
> > >>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066102784 l=
en 4096
> > >>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066102784 l=
en 4096
> > >>>>>>>>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): sta=
rt
> > >>>>>>>>>>>>>     225049066102784 len 4096
> > >>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066131456 l=
en 4096
> > >>>>>>>>>>>>>     > >>>>>>> extent buffer leak: start 225049066131456 l=
en 4096
> > >>>>>>>>>>>>>     > >>>>>>> WARNING: dirty eb leak (aborted trans): sta=
rt
> > >>>>>>>>>>>>>     225049066131456 len 4096
> > >>>>>>>>>>>>>     > >>>>>>>
> > >>>>>>>>>>>>>     > >>>>>>> What is going on?
> > >>>>>>>>>>>>>     > >>>>>>>
> > >>>>>>>>>>>>>     > >>>>>>> On Wed, May 6, 2020 at 9:30 PM Tyler Richmo=
nd
> > >>>>>>>>>>>>>     <t.d.richmond@gmail.com <mailto:t.d.richmond@gmail.co=
m>> wrote:
> > >>>>>>>>>>>>>     > >>>>>>>>
> > >>>>>>>>>>>>>     > >>>>>>>> Chris, I had used the correct mountpoint i=
n the command.
> > >>>>>>>>>>>>>     I just edited
> > >>>>>>>>>>>>>     > >>>>>>>> it in the email to be /mountpoint for cons=
istency.
> > >>>>>>>>>>>>>     > >>>>>>>>
> > >>>>>>>>>>>>>     > >>>>>>>> Qu, I'll try the repair. Fingers crossed!
> > >>>>>>>>>>>>>     > >>>>>>>>
> > >>>>>>>>>>>>>     > >>>>>>>> On Wed, May 6, 2020 at 9:13 PM Qu Wenruo
> > >>>>>>>>>>>>>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.co=
m>> wrote:
> > >>>>>>>>>>>>>     > >>>>>>>>>
> > >>>>>>>>>>>>>     > >>>>>>>>>
> > >>>>>>>>>>>>>     > >>>>>>>>>
> > >>>>>>>>>>>>>     > >>>>>>>>> On 2020/5/7 =E4=B8=8A=E5=8D=885:54, Tyler=
 Richmond wrote:
> > >>>>>>>>>>>>>     > >>>>>>>>>> Hello,
> > >>>>>>>>>>>>>     > >>>>>>>>>>
> > >>>>>>>>>>>>>     > >>>>>>>>>> I looked up this error and it basically =
says ask a
> > >>>>>>>>>>>>>     developer to
> > >>>>>>>>>>>>>     > >>>>>>>>>> determine if it's a false error or not. =
I just started
> > >>>>>>>>>>>>>     getting some
> > >>>>>>>>>>>>>     > >>>>>>>>>> slow response times, and looked at the d=
mesg log to
> > >>>>>>>>>>>>>     find a ton of
> > >>>>>>>>>>>>>     > >>>>>>>>>> these errors.
> > >>>>>>>>>>>>>     > >>>>>>>>>>
> > >>>>>>>>>>>>>     > >>>>>>>>>> [192088.446299] BTRFS critical (device s=
dh): corrupt
> > >>>>>>>>>>>>>     leaf: root=3D5
> > >>>>>>>>>>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1=
311670, invalid inode
> > >>>>>>>>>>>>>     generation:
> > >>>>>>>>>>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875=
827]
> > >>>>>>>>>>>>>     > >>>>>>>>>> [192088.449823] BTRFS error (device sdh)=
:
> > >>>>>>>>>>>>>     block=3D203510940835840 read
> > >>>>>>>>>>>>>     > >>>>>>>>>> time tree block corruption detected
> > >>>>>>>>>>>>>     > >>>>>>>>>> [192088.459238] BTRFS critical (device s=
dh): corrupt
> > >>>>>>>>>>>>>     leaf: root=3D5
> > >>>>>>>>>>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1=
311670, invalid inode
> > >>>>>>>>>>>>>     generation:
> > >>>>>>>>>>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875=
827]
> > >>>>>>>>>>>>>     > >>>>>>>>>> [192088.462773] BTRFS error (device sdh)=
:
> > >>>>>>>>>>>>>     block=3D203510940835840 read
> > >>>>>>>>>>>>>     > >>>>>>>>>> time tree block corruption detected
> > >>>>>>>>>>>>>     > >>>>>>>>>> [192088.464711] BTRFS critical (device s=
dh): corrupt
> > >>>>>>>>>>>>>     leaf: root=3D5
> > >>>>>>>>>>>>>     > >>>>>>>>>> block=3D203510940835840 slot=3D4 ino=3D1=
311670, invalid inode
> > >>>>>>>>>>>>>     generation:
> > >>>>>>>>>>>>>     > >>>>>>>>>> has 18446744073709551492 expect [0, 6875=
827]
> > >>>>>>>>>>>>>     > >>>>>>>>>> [192088.468457] BTRFS error (device sdh)=
:
> > >>>>>>>>>>>>>     block=3D203510940835840 read
> > >>>>>>>>>>>>>     > >>>>>>>>>> time tree block corruption detected
> > >>>>>>>>>>>>>     > >>>>>>>>>>
> > >>>>>>>>>>>>>     > >>>>>>>>>> btrfs device stats, however, doesn't sho=
w any errors.
> > >>>>>>>>>>>>>     > >>>>>>>>>>
> > >>>>>>>>>>>>>     > >>>>>>>>>> Is there anything I should do about this=
, or should I
> > >>>>>>>>>>>>>     just continue
> > >>>>>>>>>>>>>     > >>>>>>>>>> using my array as normal?
> > >>>>>>>>>>>>>     > >>>>>>>>>
> > >>>>>>>>>>>>>     > >>>>>>>>> This is caused by older kernel underflow =
inode generation.
> > >>>>>>>>>>>>>     > >>>>>>>>>
> > >>>>>>>>>>>>>     > >>>>>>>>> Latest btrfs-progs can fix it, using btrf=
s check --repair.
> > >>>>>>>>>>>>>     > >>>>>>>>>
> > >>>>>>>>>>>>>     > >>>>>>>>> Or you can go safer, by manually locating=
 the inode
> > >>>>>>>>>>>>>     using its inode
> > >>>>>>>>>>>>>     > >>>>>>>>> number (1311670), and copy it to some new=
 location using
> > >>>>>>>>>>>>>     previous
> > >>>>>>>>>>>>>     > >>>>>>>>> working kernel, then delete the old file,=
 copy the new
> > >>>>>>>>>>>>>     one back to fix it.
> > >>>>>>>>>>>>>     > >>>>>>>>>
> > >>>>>>>>>>>>>     > >>>>>>>>> Thanks,
> > >>>>>>>>>>>>>     > >>>>>>>>> Qu
> > >>>>>>>>>>>>>     > >>>>>>>>>
> > >>>>>>>>>>>>>     > >>>>>>>>>>
> > >>>>>>>>>>>>>     > >>>>>>>>>> Thank you!
> > >>>>>>>>>>>>>     > >>>>>>>>>>
> > >>>>>>>>>>>>>     > >>>>>>>>>
> > >>>>>>>>>>>>>     > >>>>>>
> > >>>>>>>>>>>>>     > >>>>
> > >>>>>>>>>>>>>     > >>
> > >>>>>>>>>>>>>     >
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>>
> > >>>>>>
> > >>>>
> > >>
> >
