Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9732BAAF8
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Nov 2020 14:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgKTNSg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Nov 2020 08:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbgKTNSf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Nov 2020 08:18:35 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24366C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Nov 2020 05:18:34 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 10so8536433ybx.9
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Nov 2020 05:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O05VUuvMA3lc1dyyHmX8FwsslfzR87wNpAf+cyKPr+M=;
        b=Zp/Ppv/zo1ywB5DmgXefKJPKv+EKz18gHZzbaF7fHQzCb1HYkMMm/tQ1YdQSYLRhiw
         hUBjpO8aWjM3+Cj9FEhZpnO80ZT1bgHgCL94hVZQZlmyBZMCOlVnxWyFAYkgeM+Hbecu
         Ves5mXOpswdmH40jblWrqkjQCIzuvhKj90rOxueT8gGp64v9xWv5rF/8KXfHkQzZRnwJ
         WYZ4t+HN6viBIY0pl4l8tT3UCVxdDWOYzQmO4l8TO/a4woldb+Y4Mh40JhaSopQM+hsk
         wg7BOZqRbDlQx3/J2bvL8eqNVhCgmOeshZGavVRBjPAnkOg4f9PfAOizvHIg02GyRJz4
         QLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O05VUuvMA3lc1dyyHmX8FwsslfzR87wNpAf+cyKPr+M=;
        b=pxvWzdzYt2DOYqlt5lUSDaD9L8DyP/sYIKzXREnAoU7nGeJYxCsf6HtBUa+BcVqGGB
         wmMBK186d58m/qsAjwc6Ee3Qt5xUes9mW2bK9fugnzUop6rKY/UrGipjMX/lVCqPRa+Z
         WpWdEpy8Jx787CR5/AtSiFIrQfUKYdZNrjpgKsXuzQb3xZXloMfxvB6sVDYljNmXYRpG
         YFNXEBpdwd20PE8PKQ0MNrHUz/mZ1XRaqnsKhY7aFwZ3cZSsF9ZIcSuyQU7ElTAltnKL
         ekXwW1bEIPSZDQwlz9PT8j4q0OgD45IEH2d2LqLw+zNhbQ3OXZ35jlN8jiJY2gXCTz+H
         SDoA==
X-Gm-Message-State: AOAM531PSF7eaE+mY4aaYgl6vEK/7HH9RFtkfbIvREZloTGzpnhEGmnb
        6QcKaBIjGgE9nHdUyCcKu/8AG2tcWpyIhtqhaZV1NoT6JCaL5g==
X-Google-Smtp-Source: ABdhPJyqtMNKSc3G+Hppb7wP1E8KUc0e/m6qkA251vW2lZkDj5nZXBEZt71kt8xkg3TqKMpwC0dCwcmkWjm/UnyylwU=
X-Received: by 2002:a25:10c5:: with SMTP id 188mr21030732ybq.181.1605878312914;
 Fri, 20 Nov 2020 05:18:32 -0800 (PST)
MIME-Version: 1.0
References: <CABT3_pzBdRqe7SRBptM1E5MPJfwEGF6=YBovmZdj1Vxjs21iNQ@mail.gmail.com>
 <5fdc798c-c8eb-b4cf-b247-e70f5fd49fc4@gmx.com> <CABT3_pwG1CrxYBDXTzQZLVGYkLoxKpexEdyJWnm_7TCaskbOeA@mail.gmail.com>
 <1cf994f7-3efb-67ac-d5b1-22929e8ef3fd@gmx.com> <CABT3_pxFv0KAjO2DfmikeeT+yN-3BiDj=Mu_a=dC-K9DyL-T3w@mail.gmail.com>
 <b477b613-2190-2c2f-7fab-f9b712ece187@gmx.com> <CABT3_pycYRemohAVAbczjre0ruHL_k+pSMBP+ax0Rzcfq2B=BA@mail.gmail.com>
 <CABT3_pxz3hvCx3aKh5vibro1GX3t42kCV5pd=CsL5n+uJSW13w@mail.gmail.com>
 <d88f134b-2728-efb3-5be6-9ed114c27cd8@gmx.com> <CABT3_pyOs0G8D5uqJAQXxvQHFanEbniH0fAhntLvf8_hUEY5aw@mail.gmail.com>
 <3235a46e-a3ec-88ba-8343-ef9731194231@gmx.com> <CABT3_pzPwxmEeOBDD5OSaCu_qTEN+rTObJmUcsEaPcw3nGUH2Q@mail.gmail.com>
In-Reply-To: <CABT3_pzPwxmEeOBDD5OSaCu_qTEN+rTObJmUcsEaPcw3nGUH2Q@mail.gmail.com>
From:   Thorsten Rehm <thorsten.rehm@gmail.com>
Date:   Fri, 20 Nov 2020 14:17:56 +0100
Message-ID: <CABT3_pwACpykHdL1x9OHN1Zcyc-DiFffN71LJYDWpWUWfGDHRg@mail.gmail.com>
Subject: Re: corrupt leaf; invalid root item size
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I'm very sorry, but I didn't have the time to do the btrfs-image dump.
I was just about to go back to work on the problem, but first I've
updated my system and now the problem is gone.
My system (Debian testing) is running with the latest available kernel
5.9.0-2 and btrfs-progs 5.9.
The last time I updated my system was 60 days ago and at this point
the problem still existed.
So, for now, no more corrupt leaf; invalid root item size erros.

I just wanted you and others to know.
Thanks again!


On Tue, 16 Jun 2020 at 07:41, Thorsten Rehm <thorsten.rehm@gmail.com> wrote=
:
>
> Yepp, sure.
> I will do that in the next few days.
>
>
> On Fri, Jun 12, 2020 at 8:50 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >
> > Would you mind to create a btrfs-image dump?
> >
> > It would greatly help us to pin down the cause.
> >
> > # btrfs-image -c9 <device> <file>
> >
> > Although it may leak sensitive data like file and dir names, you can tr=
y
> > -s options to fuzz them since it's not important in this particular
> > case, but it would cause more time and may cause some extra problems.
> >
> > After looking into related code, and your SINGLE metadata profile, I
> > can't find any clues yet.
> >
> > Thanks,
> > Qu
> >
> >
> > On 2020/6/8 =E4=B8=8B=E5=8D=8810:41, Thorsten Rehm wrote:
> > > I just have to start my system with kernel 5.6. After that, the
> > > slot=3D32 error lines will be written. And only these lines:
> > >
> > > $ grep 'BTRFS critical' kern.log.1 | wc -l
> > > 1191
> > >
> > > $ grep 'slot=3D32' kern.log.1 | wc -l
> > > 1191
> > >
> > > $ grep 'corruption' kern.log.1 | wc -l
> > > 0
> > >
> > > Period: 10 Minutes (~1200 lines in 10 minutes).
> > >
> > > On Mon, Jun 8, 2020 at 3:29 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
> > >>
> > >>
> > >>
> > >> On 2020/6/8 =E4=B8=8B=E5=8D=889:25, Thorsten Rehm wrote:
> > >>> Hi,
> > >>>
> > >>> any more ideas to investigate this?
> > >>
> > >> If you can still hit the same bug, and the fs is still completely fi=
ne,
> > >> I could craft some test patches for you tomorrow.
> > >>
> > >> The idea behind it is to zero out all the memory for any bad eb.
> > >> Thus bad eb cache won't affect other read.
> > >> If that hugely reduced the frequency, I guess that would be the case=
.
> > >>
> > >>
> > >> But I'm still very interested in, have you hit "read time tree block
> > >> corruption detected" lines? Or just such slot=3D32 error lines?
> > >>
> > >> Thanks,
> > >> Qu
> > >>
> > >>>
> > >>> On Thu, Jun 4, 2020 at 7:57 PM Thorsten Rehm <thorsten.rehm@gmail.c=
om> wrote:
> > >>>>
> > >>>> Hmm, ok wait a minute:
> > >>>>
> > >>>> "But still, if you're using metadata without copy (aka, SINGLE, RA=
ID0)
> > >>>> then it would be a completely different story."
> > >>>>
> > >>>> It's a single disk (SSD):
> > >>>>
> > >>>> root@grml ~ # btrfs filesystem usage /mnt
> > >>>> Overall:
> > >>>>     Device size:         115.23GiB
> > >>>>     Device allocated:          26.08GiB
> > >>>>     Device unallocated:          89.15GiB
> > >>>>     Device missing:             0.00B
> > >>>>     Used:               7.44GiB
> > >>>>     Free (estimated):         104.04GiB    (min: 59.47GiB)
> > >>>>     Data ratio:                  1.00
> > >>>>     Metadata ratio:              2.00
> > >>>>     Global reserve:          25.25MiB    (used: 0.00B)
> > >>>>
> > >>>> Data,single: Size:22.01GiB, Used:7.11GiB (32.33%)
> > >>>>    /dev/mapper/foo      22.01GiB
> > >>>>
> > >>>> Metadata,single: Size:8.00MiB, Used:0.00B (0.00%)
> > >>>>    /dev/mapper/foo       8.00MiB
> > >>>>
> > >>>> Metadata,DUP: Size:2.00GiB, Used:167.81MiB (8.19%)
> > >>>>    /dev/mapper/foo       4.00GiB
> > >>>>
> > >>>> System,single: Size:4.00MiB, Used:0.00B (0.00%)
> > >>>>    /dev/mapper/foo       4.00MiB
> > >>>>
> > >>>> System,DUP: Size:32.00MiB, Used:4.00KiB (0.01%)
> > >>>>    /dev/mapper/foo      64.00MiB
> > >>>>
> > >>>> Unallocated:
> > >>>>    /dev/mapper/foo      89.15GiB
> > >>>>
> > >>>>
> > >>>> root@grml ~ # btrfs filesystem df /mnt
> > >>>> Data, single: total=3D22.01GiB, used=3D7.11GiB
> > >>>> System, DUP: total=3D32.00MiB, used=3D4.00KiB
> > >>>> System, single: total=3D4.00MiB, used=3D0.00B
> > >>>> Metadata, DUP: total=3D2.00GiB, used=3D167.81MiB
> > >>>> Metadata, single: total=3D8.00MiB, used=3D0.00B
> > >>>> GlobalReserve, single: total=3D25.25MiB, used=3D0.00B
> > >>>>
> > >>>> I did also a fstrim:
> > >>>>
> > >>>> root@grml ~ # cryptsetup --allow-discards open /dev/sda5 foo
> > >>>> Enter passphrase for /dev/sda5:
> > >>>> root@grml ~ # mount -o discard /dev/mapper/foo /mnt
> > >>>> root@grml ~ # fstrim -v /mnt/
> > >>>> /mnt/: 105.8 GiB (113600049152 bytes) trimmed
> > >>>> fstrim -v /mnt/  0.00s user 5.34s system 0% cpu 10:28.70 total
> > >>>>
> > >>>> The kern.log in the runtime of fstrim:
> > >>>> --- snip ---
> > >>>> Jun 04 12:32:02 grml kernel: BTRFS critical (device dm-0): corrupt
> > >>>> leaf: root=3D1 block=3D32505856 slot=3D32, invalid root item size,=
 have 239
> > >>>> expect 439
> > >>>> Jun 04 12:32:02 grml kernel: BTRFS critical (device dm-0): corrupt
> > >>>> leaf: root=3D1 block=3D32813056 slot=3D32, invalid root item size,=
 have 239
> > >>>> expect 439
> > >>>> Jun 04 12:32:37 grml kernel: BTRFS info (device dm-0): turning on =
sync discard
> > >>>> Jun 04 12:32:37 grml kernel: BTRFS info (device dm-0): disk space
> > >>>> caching is enabled
> > >>>> Jun 04 12:32:37 grml kernel: BTRFS critical (device dm-0): corrupt
> > >>>> leaf: root=3D1 block=3D32813056 slot=3D32, invalid root item size,=
 have 239
> > >>>> expect 439
> > >>>> Jun 04 12:32:37 grml kernel: BTRFS info (device dm-0): enabling ss=
d
> > >>>> optimizations
> > >>>> Jun 04 12:34:35 grml kernel: BTRFS critical (device dm-0): corrupt
> > >>>> leaf: root=3D1 block=3D32382976 slot=3D32, invalid root item size,=
 have 239
> > >>>> expect 439
> > >>>> Jun 04 12:36:50 grml kernel: BTRFS info (device dm-0): turning on =
sync discard
> > >>>> Jun 04 12:36:50 grml kernel: BTRFS info (device dm-0): disk space
> > >>>> caching is enabled
> > >>>> Jun 04 12:36:50 grml kernel: BTRFS critical (device dm-0): corrupt
> > >>>> leaf: root=3D1 block=3D32382976 slot=3D32, invalid root item size,=
 have 239
> > >>>> expect 439
> > >>>> Jun 04 12:36:50 grml kernel: BTRFS info (device dm-0): enabling ss=
d
> > >>>> optimizations
> > >>>> --- snap ---
> > >>>>
> > >>>> Furthermore the system runs for years now. I can't remember exactl=
y,
> > >>>> but think for 4-5 years. I've started with Debian Testing and just
> > >>>> upgraded my system on a regular basis. And and I started with btrf=
s of
> > >>>> course, but I can't remember with which version...
> > >>>>
> > >>>> The problem is still there after the fstrim. Any further suggestio=
ns?
> > >>>>
> > >>>> And isn't it a little bit strange, that someone had a very similia=
r problem?
> > >>>> https://lore.kernel.org/linux-btrfs/19acbd39-475f-bd72-e280-5f6c64=
96035c@web.de/
> > >>>>
> > >>>> root=3D1, slot=3D32, and "invalid root item size, have 239 expect =
439" are
> > >>>> identical to my errors.
> > >>>>
> > >>>> Thx so far!
> > >>>>
> > >>>>
> > >>>>
> > >>>> On Thu, Jun 4, 2020 at 2:06 PM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
> > >>>>>
> > >>>>>
> > >>>>>
> > >>>>> On 2020/6/4 =E4=B8=8B=E5=8D=886:52, Thorsten Rehm wrote:
> > >>>>>> The disk in question is my root (/) partition. If the filesystem=
 is
> > >>>>>> that highly damaged, I have to reinstall my system. We will see,=
 if
> > >>>>>> it's come to that. Maybe we find something interesting on the wa=
y...
> > >>>>>> I've downloaded the latest grml daily image and started my syste=
m from
> > >>>>>> a usb stick. Here we go:
> > >>>>>>
> > >>>>>> root@grml ~ # uname -r
> > >>>>>> 5.6.0-2-amd64
> > >>>>>>
> > >>>>>> root@grml ~ # cryptsetup open /dev/sda5 foo
> > >>>>>>
> > >>>>>>                                                                 =
  :(
> > >>>>>> Enter passphrase for /dev/sda5:
> > >>>>>>
> > >>>>>> root@grml ~ # file -L -s /dev/mapper/foo
> > >>>>>> /dev/mapper/foo: BTRFS Filesystem label "slash", sectorsize 4096=
,
> > >>>>>> nodesize 4096, leafsize 4096,
> > >>>>>> UUID=3D65005d0f-f8ea-4f77-8372-eb8b53198685, 7815716864/12373196=
8000
> > >>>>>> bytes used, 1 devices
> > >>>>>>
> > >>>>>> root@grml ~ # btrfs check /dev/mapper/foo
> > >>>>>> Opening filesystem to check...
> > >>>>>> Checking filesystem on /dev/mapper/foo
> > >>>>>> UUID: 65005d0f-f8ea-4f77-8372-eb8b53198685
> > >>>>>> [1/7] checking root items
> > >>>>>> [2/7] checking extents
> > >>>>>> [3/7] checking free space cache
> > >>>>>> [4/7] checking fs roots
> > >>>>>> [5/7] checking only csums items (without verifying data)
> > >>>>>> [6/7] checking root refs
> > >>>>>> [7/7] checking quota groups skipped (not enabled on this FS)
> > >>>>>> found 7815716864 bytes used, no error found
> > >>>>>> total csum bytes: 6428260
> > >>>>>> total tree bytes: 175968256
> > >>>>>> total fs tree bytes: 149475328
> > >>>>>> total extent tree bytes: 16052224
> > >>>>>> btree space waste bytes: 43268911
> > >>>>>> file data blocks allocated: 10453221376
> > >>>>>>  referenced 8746053632
> > >>>>>
> > >>>>> Errr, this is a super good news, all your fs metadata is complete=
ly fine
> > >>>>> (at least for the first copy).
> > >>>>> Which is completely different from the kernel dmesg.
> > >>>>>
> > >>>>>>
> > >>>>>> root@grml ~ # lsblk /dev/sda5 --fs
> > >>>>>> NAME  FSTYPE      FSVER LABEL UUID
> > >>>>>> FSAVAIL FSUSE% MOUNTPOINT
> > >>>>>> sda5  crypto_LUKS 1           d2b4fa40-8afd-4e16-b207-4d106096fd=
22
> > >>>>>> =E2=94=94=E2=94=80foo btrfs             slash 65005d0f-f8ea-4f77=
-8372-eb8b53198685
> > >>>>>>
> > >>>>>> root@grml ~ # mount /dev/mapper/foo /mnt
> > >>>>>> root@grml ~ # btrfs scrub start /mnt
> > >>>>>>
> > >>>>>> root@grml ~ # journalctl -k --no-pager | grep BTRFS
> > >>>>>> Jun 04 10:33:04 grml kernel: BTRFS: device label slash devid 1 t=
ransid
> > >>>>>> 24750795 /dev/dm-0 scanned by systemd-udevd (3233)
> > >>>>>> Jun 04 10:45:17 grml kernel: BTRFS info (device dm-0): disk spac=
e
> > >>>>>> caching is enabled
> > >>>>>> Jun 04 10:45:17 grml kernel: BTRFS critical (device dm-0): corru=
pt
> > >>>>>> leaf: root=3D1 block=3D54222848 slot=3D32, invalid root item siz=
e, have 239
> > >>>>>> expect 439
> > >>>>>
> > >>>>> One error line without "read time corruption" line means btrfs ke=
rnel
> > >>>>> indeed skipped to next copy.
> > >>>>> In this case, there is one copy (aka the first copy) corrupted.
> > >>>>> Strangely, if it's the first copy in kernel, it should also be th=
e first
> > >>>>> copy in btrfs check.
> > >>>>>
> > >>>>> And no problem reported from btrfs check, that's already super st=
range.
> > >>>>>
> > >>>>>> Jun 04 10:45:17 grml kernel: BTRFS info (device dm-0): enabling =
ssd
> > >>>>>> optimizations
> > >>>>>> Jun 04 10:45:17 grml kernel: BTRFS info (device dm-0): checking =
UUID tree
> > >>>>>> Jun 04 10:45:38 grml kernel: BTRFS info (device dm-0): scrub: st=
arted on devid 1
> > >>>>>> Jun 04 10:45:49 grml kernel: BTRFS critical (device dm-0): corru=
pt
> > >>>>>> leaf: root=3D1 block=3D29552640 slot=3D32, invalid root item siz=
e, have 239
> > >>>>>> expect 439
> > >>>>>> Jun 04 10:46:25 grml kernel: BTRFS critical (device dm-0): corru=
pt
> > >>>>>> leaf: root=3D1 block=3D29741056 slot=3D32, invalid root item siz=
e, have 239
> > >>>>>> expect 439
> > >>>>>> Jun 04 10:46:31 grml kernel: BTRFS info (device dm-0): scrub: fi=
nished
> > >>>>>> on devid 1 with status: 0
> > >>>>>> Jun 04 10:46:56 grml kernel: BTRFS critical (device dm-0): corru=
pt
> > >>>>>> leaf: root=3D1 block=3D29974528 slot=3D32, invalid root item siz=
e, have 239
> > >>>>>> expect 439
> > >>>>>
> > >>>>> This means the corrupted copy are also there for several (and I g=
uess
> > >>>>> unrelated) tree blocks.
> > >>>>> For scrub I guess it just try to read the good copy without bothe=
ring
> > >>>>> the bad one it found, so no error reported in scrub.
> > >>>>>
> > >>>>> But still, if you're using metadata without copy (aka, SINGLE, RA=
ID0)
> > >>>>> then it would be a completely different story.
> > >>>>>
> > >>>>>
> > >>>>>>
> > >>>>>> root@grml ~ # btrfs scrub status /mnt
> > >>>>>> UUID:             65005d0f-f8ea-4f77-8372-eb8b53198685
> > >>>>>> Scrub started:    Thu Jun  4 10:45:38 2020
> > >>>>>> Status:           finished
> > >>>>>> Duration:         0:00:53
> > >>>>>> Total to scrub:   7.44GiB
> > >>>>>> Rate:             143.80MiB/s
> > >>>>>> Error summary:    no errors found
> > >>>>>>
> > >>>>>>
> > >>>>>> root@grml ~ # for block in 54222848 29552640 29741056 29974528; =
do
> > >>>>>> btrfs ins dump-tree -b $block /dev/dm-0; done
> > >>>>>> btrfs-progs v5.6
> > >>>>>> leaf 54222848 items 33 free space 1095 generation 24750795 owner=
 ROOT_TREE
> > >>>>>> leaf 54222848 flags 0x1(WRITTEN) backref revision 1
> > >>>>>> fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
> > >>>>>> chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
> > >>>>>>     item 0 key (289 INODE_ITEM 0) itemoff 3835 itemsize 160
> > >>>>>>         generation 24703953 transid 24703953 size 262144 nbytes =
8595701760
> > >>>>> ...
> > >>>>>>         cache generation 24750791 entries 139 bitmaps 8
> > >>>>>>     item 32 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 1920 items=
ize 239
> > >>>>>
> > >>>>> So it's still there. The first copy is corrupted. Just btrfs-prog=
s can't
> > >>>>> detect it.
> > >>>>>
> > >>>>>>         generation 4 root_dirid 256 bytenr 29380608 level 0 refs=
 1
> > >>>>>>         lastsnap 0 byte_limit 0 bytes_used 4096 flags 0x0(none)
> > >>>>>>         drop key (0 UNKNOWN.0 0) level 0
> > >>>>>> btrfs-progs v5.6
> > >>>>>> leaf 29552640 items 33 free space 1095 generation 24750796 owner=
 ROOT_TREE
> > >>>>>> leaf 29552640 flags 0x1(WRITTEN) backref revision 1
> > >>>>>> fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
> > >>>>>> chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
> > >>>>> ...
> > >>>>>>     item 32 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 1920 items=
ize 239
> > >>>>>>         generation 4 root_dirid 256 bytenr 29380608 level 0 refs=
 1
> > >>>>>>         lastsnap 0 byte_limit 0 bytes_used 4096 flags 0x0(none)
> > >>>>>>         drop key (0 UNKNOWN.0 0) level 0
> > >>>>>
> > >>>>> This is different from previous copy, which means it should be an=
 CoWed
> > >>>>> tree blocks.
> > >>>>>
> > >>>>>> btrfs-progs v5.6
> > >>>>>> leaf 29741056 items 33 free space 1095 generation 24750797 owner=
 ROOT_TREE
> > >>>>>
> > >>>>> Even newer one.
> > >>>>>
> > >>>>> ...
> > >>>>>> btrfs-progs v5.6
> > >>>>>> leaf 29974528 items 33 free space 1095 generation 24750798 owner=
 ROOT_TREE
> > >>>>>
> > >>>>> Newer.
> > >>>>>
> > >>>>> So It looks the bad copy exists for a while, but at the same time=
 we
> > >>>>> still have one good copy to let everything float.
> > >>>>>
> > >>>>> To kill all the old corrupted copies, if it supports TRIM/DISCARD=
, I
> > >>>>> recommend to run scrub first, then fstrim on the fs.
> > >>>>>
> > >>>>> If it's HDD, I recommend to run a btrfs balance -m to relocate al=
l
> > >>>>> metadata blocks, to get rid the bad copies.
> > >>>>>
> > >>>>> Of course, all using v5.3+ kernels.
> > >>>>>
> > >>>>> Thanks,
> > >>>>> Qu
> > >>>>>>
> > >>>>>> On Thu, Jun 4, 2020 at 12:00 PM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
> > >>>>>>>
> > >>>>>>>
> > >>>>>>>
> > >>>>>>> On 2020/6/4 =E4=B8=8B=E5=8D=885:45, Thorsten Rehm wrote:
> > >>>>>>>> Thank you for you answer.
> > >>>>>>>> I've just updated my system, did a reboot and it's running wit=
h a
> > >>>>>>>> 5.6.0-2-amd64 now.
> > >>>>>>>> So, this is how my kern.log looks like, just right after the s=
tart:
> > >>>>>>>>
> > >>>>>>>
> > >>>>>>>>
> > >>>>>>>> There are too many blocks. I just picked three randomly:
> > >>>>>>>
> > >>>>>>> Looks like we need more result, especially some result doesn't =
match at all.
> > >>>>>>>
> > >>>>>>>>
> > >>>>>>>> =3D=3D=3D Block 33017856 =3D=3D=3D
> > >>>>>>>> $ btrfs ins dump-tree -b 33017856 /dev/dm-0
> > >>>>>>>> btrfs-progs v5.6
> > >>>>>>>> leaf 33017856 items 51 free space 17 generation 24749502 owner=
 FS_TREE
> > >>>>>>>> leaf 33017856 flags 0x1(WRITTEN) backref revision 1
> > >>>>>>>> fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
> > >>>>>>>> chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
> > >>>>>>> ...
> > >>>>>>>>         item 31 key (4000670 EXTENT_DATA 1933312) itemoff 2299=
 itemsize 53
> > >>>>>>>>                 generation 24749502 type 1 (regular)
> > >>>>>>>>                 extent data disk byte 1126502400 nr 4096
> > >>>>>>>>                 extent data offset 0 nr 8192 ram 8192
> > >>>>>>>>                 extent compression 2 (lzo)
> > >>>>>>>>         item 32 key (4000670 EXTENT_DATA 1941504) itemoff 2246=
 itemsize 53
> > >>>>>>>>                 generation 24749502 type 1 (regular)
> > >>>>>>>>                 extent data disk byte 0 nr 0
> > >>>>>>>>                 extent data offset 1937408 nr 4096 ram 4194304
> > >>>>>>>>                 extent compression 0 (none)
> > >>>>>>> Not root item at all.
> > >>>>>>> At least for this copy, it looks like kernel got one completely=
 bad
> > >>>>>>> copy, then discarded it and found a good copy.
> > >>>>>>>
> > >>>>>>> That's very strange, especially when all the other involved one=
s seems
> > >>>>>>> random and all at slot 32 is not a coincident.
> > >>>>>>>
> > >>>>>>>
> > >>>>>>>> =3D=3D=3D Block 44900352  =3D=3D=3D
> > >>>>>>>> btrfs ins dump-tree -b 44900352 /dev/dm-0
> > >>>>>>>> btrfs-progs v5.6
> > >>>>>>>> leaf 44900352 items 19 free space 591 generation 24749527 owne=
r FS_TREE
> > >>>>>>>> leaf 44900352 flags 0x1(WRITTEN) backref revision 1
> > >>>>>>>
> > >>>>>>> This block doesn't even have slot 32... It only have 19 items, =
thus slot
> > >>>>>>> 0 ~ slot 18.
> > >>>>>>> And its owner, FS_TREE shouldn't have ROOT_ITEM.
> > >>>>>>>
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>> =3D=3D=3D Block 55352561664 =3D=3D=3D
> > >>>>>>>> $ btrfs ins dump-tree -b 55352561664 /dev/dm-0
> > >>>>>>>> btrfs-progs v5.6
> > >>>>>>>> leaf 55352561664 items 33 free space 1095 generation 24749497 =
owner ROOT_TREE
> > >>>>>>>> leaf 55352561664 flags 0x1(WRITTEN) backref revision 1
> > >>>>>>>> fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
> > >>>>>>>> chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
> > >>>>>>> ...
> > >>>>>>>>         item 32 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 1920=
 itemsize 239
> > >>>>>>>>                 generation 4 root_dirid 256 bytenr 29380608 le=
vel 0 refs 1
> > >>>>>>>>                 lastsnap 0 byte_limit 0 bytes_used 4096 flags =
0x0(none)
> > >>>>>>>>                 drop key (0 UNKNOWN.0 0) level 0
> > >>>>>>>
> > >>>>>>> This looks like the offending tree block.
> > >>>>>>> Slot 32, item size 239, which is ROOT_ITEM, but in valid size.
> > >>>>>>>
> > >>>>>>> Since you're here, I guess a btrfs check without --repair on th=
e
> > >>>>>>> unmounted fs would help to identify the real damage.
> > >>>>>>>
> > >>>>>>> And again, the fs looks very damaged, it's highly recommended t=
o backup
> > >>>>>>> your data asap.
> > >>>>>>>
> > >>>>>>> Thanks,
> > >>>>>>> Qu
> > >>>>>>>
> > >>>>>>>> --- snap ---
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>> On Thu, Jun 4, 2020 at 3:31 AM Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
> > >>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>>> On 2020/6/3 =E4=B8=8B=E5=8D=889:37, Thorsten Rehm wrote:
> > >>>>>>>>>> Hi,
> > >>>>>>>>>>
> > >>>>>>>>>> I've updated my system (Debian testing) [1] several months a=
go (~
> > >>>>>>>>>> December) and I noticed a lot of corrupt leaf messages flood=
ing my
> > >>>>>>>>>> kern.log [2]. Furthermore my system had some trouble, e.g.
> > >>>>>>>>>> applications were terminated after some uptime, due to the b=
trfs
> > >>>>>>>>>> filesystem errors. This was with kernel 5.3.
> > >>>>>>>>>> The last time I tried was with Kernel 5.6.0-1-amd64 and the =
problem persists.
> > >>>>>>>>>>
> > >>>>>>>>>> I've downgraded my kernel to 4.19.0-8-amd64 from the Debian =
Stable
> > >>>>>>>>>> release and with this kernel there aren't any corrupt leaf m=
essages
> > >>>>>>>>>> and the problem is gone. IMHO, it must be something coming w=
ith kernel
> > >>>>>>>>>> 5.3 (or 5.x).
> > >>>>>>>>>
> > >>>>>>>>> V5.3 introduced a lot of enhanced metadata sanity checks, and=
 they catch
> > >>>>>>>>> such *obviously* wrong metadata.
> > >>>>>>>>>>
> > >>>>>>>>>> My harddisk is a SSD which is responsible for the root parti=
tion. I've
> > >>>>>>>>>> encrypted my filesystem with LUKS and just right after I ent=
ered my
> > >>>>>>>>>> password at the boot, the first corrupt leaf errors appear.
> > >>>>>>>>>>
> > >>>>>>>>>> An error message looks like this:
> > >>>>>>>>>> May  7 14:39:34 foo kernel: [  100.162145] BTRFS critical (d=
evice
> > >>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D35799040 slot=3D32, in=
valid root item
> > >>>>>>>>>> size, have 239 expect 439
> > >>>>>>>>>
> > >>>>>>>>> Btrfs root items have fixed size. This is already something v=
ery bad.
> > >>>>>>>>>
> > >>>>>>>>> Furthermore, the item size is smaller than expected, which me=
ans we can
> > >>>>>>>>> easily get garbage. I'm a little surprised that older kernel =
can even
> > >>>>>>>>> work without crashing the whole kernel.
> > >>>>>>>>>
> > >>>>>>>>> Some extra info could help us to find out how badly the fs is=
 corrupted.
> > >>>>>>>>> # btrfs ins dump-tree -b 35799040 /dev/dm-0
> > >>>>>>>>>
> > >>>>>>>>>>
> > >>>>>>>>>> "root=3D1", "slot=3D32", "have 239 expect 439" is always the=
 same at every
> > >>>>>>>>>> error line. Only the block number changes.
> > >>>>>>>>>
> > >>>>>>>>> And dumps for the other block numbers too.
> > >>>>>>>>>
> > >>>>>>>>>>
> > >>>>>>>>>> Interestingly it's the very same as reported to the ML here =
[3]. I've
> > >>>>>>>>>> contacted the reporter, but he didn't have a solution for me=
, because
> > >>>>>>>>>> he changed to a different filesystem.
> > >>>>>>>>>>
> > >>>>>>>>>> I've already tried "btrfs scrub" and "btrfs check --readonly=
 /" in
> > >>>>>>>>>> rescue mode, but w/o any errors. I've also checked the S.M.A=
.R.T.
> > >>>>>>>>>> values of the SSD, which are fine. Furthermore I've tested m=
y RAM, but
> > >>>>>>>>>> again, w/o any errors.
> > >>>>>>>>>
> > >>>>>>>>> This doesn't look like a bit flip, so not RAM problems.
> > >>>>>>>>>
> > >>>>>>>>> Don't have any better advice until we got the dumps, but I'd =
recommend
> > >>>>>>>>> to backup your data since it's still possible.
> > >>>>>>>>>
> > >>>>>>>>> Thanks,
> > >>>>>>>>> Qu
> > >>>>>>>>>
> > >>>>>>>>>>
> > >>>>>>>>>> So, I have no more ideas what I can do. Could you please hel=
p me to
> > >>>>>>>>>> investigate this further? Could it be a bug?
> > >>>>>>>>>>
> > >>>>>>>>>> Thank you very much.
> > >>>>>>>>>>
> > >>>>>>>>>> Best regards,
> > >>>>>>>>>> Thorsten
> > >>>>>>>>>>
> > >>>>>>>>>>
> > >>>>>>>>>>
> > >>>>>>>>>> 1:
> > >>>>>>>>>> $ cat /etc/debian_version
> > >>>>>>>>>> bullseye/sid
> > >>>>>>>>>>
> > >>>>>>>>>> $ uname -a
> > >>>>>>>>>> [no problem with this kernel]
> > >>>>>>>>>> Linux foo 4.19.0-8-amd64 #1 SMP Debian 4.19.98-1 (2020-01-26=
) x86_64 GNU/Linux
> > >>>>>>>>>>
> > >>>>>>>>>> $ btrfs --version
> > >>>>>>>>>> btrfs-progs v5.6
> > >>>>>>>>>>
> > >>>>>>>>>> $ sudo btrfs fi show
> > >>>>>>>>>> Label: 'slash'  uuid: 65005d0f-f8ea-4f77-8372-eb8b53198685
> > >>>>>>>>>>         Total devices 1 FS bytes used 7.33GiB
> > >>>>>>>>>>         devid    1 size 115.23GiB used 26.08GiB path /dev/ma=
pper/sda5_crypt
> > >>>>>>>>>>
> > >>>>>>>>>> $ btrfs fi df /
> > >>>>>>>>>> Data, single: total=3D22.01GiB, used=3D7.16GiB
> > >>>>>>>>>> System, DUP: total=3D32.00MiB, used=3D4.00KiB
> > >>>>>>>>>> System, single: total=3D4.00MiB, used=3D0.00B
> > >>>>>>>>>> Metadata, DUP: total=3D2.00GiB, used=3D168.19MiB
> > >>>>>>>>>> Metadata, single: total=3D8.00MiB, used=3D0.00B
> > >>>>>>>>>> GlobalReserve, single: total=3D25.42MiB, used=3D0.00B
> > >>>>>>>>>>
> > >>>>>>>>>>
> > >>>>>>>>>> 2:
> > >>>>>>>>>> [several messages per second]
> > >>>>>>>>>> May  7 14:39:34 foo kernel: [  100.162145] BTRFS critical (d=
evice
> > >>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D35799040 slot=3D32, in=
valid root item
> > >>>>>>>>>> size, have 239 expect 439
> > >>>>>>>>>> May  7 14:39:35 foo kernel: [  100.998530] BTRFS critical (d=
evice
> > >>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D35885056 slot=3D32, in=
valid root item
> > >>>>>>>>>> size, have 239 expect 439
> > >>>>>>>>>> May  7 14:39:35 foo kernel: [  101.348650] BTRFS critical (d=
evice
> > >>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D35926016 slot=3D32, in=
valid root item
> > >>>>>>>>>> size, have 239 expect 439
> > >>>>>>>>>> May  7 14:39:36 foo kernel: [  101.619437] BTRFS critical (d=
evice
> > >>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D35995648 slot=3D32, in=
valid root item
> > >>>>>>>>>> size, have 239 expect 439
> > >>>>>>>>>> May  7 14:39:36 foo kernel: [  101.874069] BTRFS critical (d=
evice
> > >>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D36184064 slot=3D32, in=
valid root item
> > >>>>>>>>>> size, have 239 expect 439
> > >>>>>>>>>> May  7 14:39:36 foo kernel: [  102.339087] BTRFS critical (d=
evice
> > >>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D36319232 slot=3D32, in=
valid root item
> > >>>>>>>>>> size, have 239 expect 439
> > >>>>>>>>>> May  7 14:39:37 foo kernel: [  102.629429] BTRFS critical (d=
evice
> > >>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D36380672 slot=3D32, in=
valid root item
> > >>>>>>>>>> size, have 239 expect 439
> > >>>>>>>>>> May  7 14:39:37 foo kernel: [  102.839669] BTRFS critical (d=
evice
> > >>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D36487168 slot=3D32, in=
valid root item
> > >>>>>>>>>> size, have 239 expect 439
> > >>>>>>>>>> May  7 14:39:37 foo kernel: [  103.109183] BTRFS critical (d=
evice
> > >>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D36597760 slot=3D32, in=
valid root item
> > >>>>>>>>>> size, have 239 expect 439
> > >>>>>>>>>> May  7 14:39:37 foo kernel: [  103.299101] BTRFS critical (d=
evice
> > >>>>>>>>>> dm-0): corrupt leaf: root=3D1 block=3D36626432 slot=3D32, in=
valid root item
> > >>>>>>>>>> size, have 239 expect 439
> > >>>>>>>>>>
> > >>>>>>>>>> 3:
> > >>>>>>>>>> https://lore.kernel.org/linux-btrfs/19acbd39-475f-bd72-e280-=
5f6c6496035c@web.de/
> > >>>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>
> > >>>>>
> > >>
> >
