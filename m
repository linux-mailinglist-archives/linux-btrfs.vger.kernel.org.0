Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7914C156840
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Feb 2020 01:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgBIAvx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Feb 2020 19:51:53 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40159 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgBIAvx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 8 Feb 2020 19:51:53 -0500
Received: by mail-vs1-f65.google.com with SMTP id g23so1957260vsr.7
        for <linux-btrfs@vger.kernel.org>; Sat, 08 Feb 2020 16:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VLi1Riah1UMtUjatXnU2gtOuKYPho7A5Wc92qPUAGFY=;
        b=Zz3vrib47YofJ3SiHuJQQcet179bjV5NUEbzx0KMu78EHc9Iy1V2qllEjGmtxhdHeR
         172TvSi0WtRq6khG0yjyNCNynLJWPBTMto1/aysK48Qe3zI/M8XI8w8vCjVrQT6riqMk
         q5Tu5CFlGlt96jDfz6bpw+Oavv5ZNRSBIYFtjMXZE2C1y1uITj3DXMBwHWQHYcUA7K5s
         4UCg7W+jCNSsNovguUL9sskSTpPDvxQBPoGR18vD9wtd6EMIW5af1Xfq1ofyD2lhHALO
         aJ86MB8EYacaiMFRPzwl34UgwsNsGquUqj2FpMALKB5mfaHjqyubZLfntyrGCnac8IeS
         hDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VLi1Riah1UMtUjatXnU2gtOuKYPho7A5Wc92qPUAGFY=;
        b=SqtgRLosNGoLlkweWOflNoJ2Tqu84dYriGYbZcLvCBqYqy5uGoPvC1NExaPHKi23m6
         DGj2B6uSK6yqjWymrT2flV+8MSXUxGbxfNwSNEaM7S0mzBJnB9W0jfdpQ5rfnaagfpI7
         5xmgQDlRzK7C3X/Tc9UE2TutsrR+xYRS9DS/hzR5zm/HqVJSQKzcHFmZrup4xQXUrdap
         3jKhINdm5ZRpXdsZOS43cn3D8QNPMQSWn15eITCDyqAR8Nl46+5GsLxjQ26DcwCJdIB/
         YCR0yf2bK9WW/kyxxOYjEj08Z27cCyxGbPxuAZhS1iu9Gg8GqMbmUVuMCFlHcu1wBp4i
         cccg==
X-Gm-Message-State: APjAAAX3SeFMeEDKcwZ+6VOI3dNota8KhtIkV+JKdT+yxg8ulDgSFVDC
        TWbi8zNwlZcnDz51eXMnuJRJe+zZQ6HKTGYvVn8=
X-Google-Smtp-Source: APXvYqz6PyjzrmYGykpuwdcVYEcJY6Niykcjuj7iUQFm98dneHGhZHozsjgM6SGfo2DE1aEmve5mTux7Lta1rZhOa44=
X-Received: by 2002:a67:e248:: with SMTP id w8mr2864442vse.74.1581209510659;
 Sat, 08 Feb 2020 16:51:50 -0800 (PST)
MIME-Version: 1.0
References: <CA+M2ft9zjGm7XJw1BUm364AMqGSd3a8QgsvQDCWz317qjP=o8g@mail.gmail.com>
 <CA+M2ft9ANwKT1+ENS6-w9HLtdx0MDOiVhi5RWKLucaT_WtZLkg@mail.gmail.com>
 <40b47145-f965-ec5f-2caf-68434c4fbc62@gmx.com> <CA+M2ft8zMv8nhs6VzZWnzgcP2nRasrwxLzjKgaZPnm_prtWQow@mail.gmail.com>
 <3e5f4de7-fec1-f8cd-c8b1-20b5a3f38f60@gmx.com> <CA+M2ft_6_1pkP75G79qj4dLxOjJr0bOGtATaGPTVQGn25sAo+A@mail.gmail.com>
 <CA+M2ft9dcMKKQstZVcGQ=9MREbfhPF5GG=xoMoh5Aq8MK9P8wA@mail.gmail.com> <75f86be2-80fe-26c1-235f-1c6d3a618eeb@gmx.com>
In-Reply-To: <75f86be2-80fe-26c1-235f-1c6d3a618eeb@gmx.com>
From:   John Hendy <jw.hendy@gmail.com>
Date:   Sat, 8 Feb 2020 18:51:39 -0600
Message-ID: <CA+M2ft9PjH29SY+nBqfFEapr9g7BjjMFeE_p2P0oL1q8xHGUBw@mail.gmail.com>
Subject: Re: btrfs root fs started remounting ro
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 8, 2020 at 5:56 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/2/9 =E4=B8=8A=E5=8D=885:57, John Hendy wrote:
> > On phone due to no OS, so apologies if this is in html mode. Indeed, I
> > can't mount or boot any longer. I get the error:
> >
> > Error (device dm-0) in btrfs_replay_log:2228: errno=3D-22 unknown (Fail=
ed
> > to recover log tree)
> > BTRFS error (device dm-0): open_ctree failed
>
> That can be easily fixed by `btrfs rescue zero-log`.
>

Whew. This was most helpful and it is wonderful to be booting at
least. I think the outstanding issues are:
- what should I do about `btrfs check --repair seg` faulting?
- how can I deal with this (probably related to seg fault) ghost file
that cannot be deleted?
- I'm not sure if you looked at the post --repair log, but there a ton
of these errors that didn't used to be there:

backpointer mismatch on [13037375488 20480]
ref mismatch on [13037395968 892928] extent item 0, found 1
data backref 13037395968 root 263 owner 4257169 offset 0 num_refs 0
not found in extent tree
incorrect local backref count on 13037395968 root 263 owner 4257169
offset 0 found 1 wanted 0 back 0x5627f59cadc0

Here is the latest btrfs check output after the zero-log operation.
- https://pastebin.com/KWeUnk0y

I'm hoping once that file is deleted, it's a matter of
--init-csum-tree and perhaps I'm set? Or --init-extent-tree?

Thanks,
John

> At least, btrfs check --repair didn't make things worse.
>
> Thanks,
> Qu
> >
> > John
> >
> > On Sat, Feb 8, 2020, 1:56 PM John Hendy <jw.hendy@gmail.com
> > <mailto:jw.hendy@gmail.com>> wrote:
> >
> >     This is not going so hot. Updates:
> >
> >     booted from arch install, pre repair btrfs check:
> >     - https://pastebin.com/6vNaSdf2
> >
> >     btrfs check --mode=3Dlowmem as requested by Chris:
> >     - https://pastebin.com/uSwSTVVY
> >
> >     Then I did btrfs check --repair, which seg faulted at the end. I've
> >     typed them off of pictures I took:
> >
> >     Starting repair.
> >     Opening filesystem to check...
> >     Checking filesystem on /dev/mapper/ssd
> >     [1/7] checking root items
> >     Fixed 0 roots.
> >     [2/7] checking extents
> >     parent transid verify failed on 20271138064 wanted 68719924810 foun=
d
> >     448074
> >     parent transid verify failed on 20271138064 wanted 68719924810 foun=
d
> >     448074
> >     Ignoring transid failure
> >     # ... repeated the previous two lines maybe hundreds of times
> >     # ended with this:
> >     ref mismatch on [12797435904 268505088] extent item 1, found 412
> >     [1] 1814 segmentation fault (core dumped) btrfs check --repair
> >     /dev/mapper/ssd
> >
> >     This was with btrfs-progs 5.4 (the install USB is maybe a month old=
).
> >
> >     Here is the output of btrfs check after the --repair attempt:
> >     - https://pastebin.com/6MYRNdga
> >
> >     I rebooted to write this email given the seg fault, as I wanted to
> >     make sure that I should still follow-up --repair with
> >     --init-csum-tree. I had pictures of the --repair output, but Firefo=
x
> >     just wouldn't load imgur.com <http://imgur.com> for me to post the
> >     pics and was acting
> >     really weird. In suspiciously checking dmesg, things have gone ro o=
n
> >     me :(  Here is the dmesg from this session:
> >     - https://pastebin.com/a2z7xczy
> >
> >     The gist is:
> >
> >     [   40.997935] BTRFS critical (device dm-0): corrupt leaf: root=3D7
> >     block=3D172703744 slot=3D0, csum end range (12980568064) goes beyon=
d the
> >     start range (12980297728) of the next csum item
> >     [   40.997941] BTRFS info (device dm-0): leaf 172703744 gen 450983
> >     total ptrs 34 free space 29 owner 7
> >     [   40.997942]     item 0 key (18446744073709551606 128 12979060736=
)
> >     itemoff 14811 itemsize 1472
> >     [   40.997944]     item 1 key (18446744073709551606 128 12980297728=
)
> >     itemoff 13895 itemsize 916
> >     [   40.997945]     item 2 key (18446744073709551606 128 12981235712=
)
> >     itemoff 13811 itemsize 84
> >     # ... there's maybe 30 of these item n key lines in total
> >     [   40.997984] BTRFS error (device dm-0): block=3D172703744 write t=
ime
> >     tree block corruption detected
> >     [   41.016793] BTRFS: error (device dm-0) in
> >     btrfs_commit_transaction:2332: errno=3D-5 IO failure (Error while
> >     writing out transaction)
> >     [   41.016799] BTRFS info (device dm-0): forced readonly
> >     [   41.016802] BTRFS warning (device dm-0): Skipping commit of abor=
ted
> >     transaction.
> >     [   41.016804] BTRFS: error (device dm-0) in cleanup_transaction:18=
90:
> >     errno=3D-5 IO failure
> >     [   41.016807] BTRFS info (device dm-0): delayed_refs has NO entry
> >     [   41.023473] BTRFS warning (device dm-0): Skipping commit of abor=
ted
> >     transaction.
> >     [   41.024297] BTRFS info (device dm-0): delayed_refs has NO entry
> >     [   44.509418] systemd-journald[416]:
> >     /var/log/journal/45c06c25e25f434195204efa939019ab/system.journal:
> >     Journal file corrupted, rotating.
> >     [   44.509440] systemd-journald[416]: Failed to rotate
> >     /var/log/journal/45c06c25e25f434195204efa939019ab/system.journal:
> >     Read-only file system
> >     [   44.509450] systemd-journald[416]: Failed to rotate
> >     /var/log/journal/45c06c25e25f434195204efa939019ab/user-1000.journal=
:
> >     Read-only file system
> >     [   44.509540] systemd-journald[416]: Failed to write entry (23 ite=
ms,
> >     705 bytes) despite vacuuming, ignoring: Bad message
> >     # ... then a bunch of these failed journal attempts (of note:
> >     /var/log/journal was one of the bad inodes from btrfs check
> >     previously)
> >
> >     Kindly let me know what you would recommend. I'm sadly back to an
> >     unusable system vs. a complaining/worrisome one. This is similar to
> >     the behavior I had with the m2.sata nvme drive in my original
> >     experience. After trying all of --repair, --init-csum-tree, and
> >     --init-extent-tree, I couldn't boot anymore. After my dm-crypt
> >     password at boot, I just saw a bunch of [FAILED] in the text splash
> >     output. Hoping to not repeat that with this drive.
> >
> >     Thanks,
> >     John
> >
> >
> >     On Sat, Feb 8, 2020 at 1:29 AM Qu Wenruo <quwenruo.btrfs@gmx.com
> >     <mailto:quwenruo.btrfs@gmx.com>> wrote:
> >     >
> >     >
> >     >
> >     > On 2020/2/8 =E4=B8=8B=E5=8D=8812:48, John Hendy wrote:
> >     > > On Fri, Feb 7, 2020 at 5:42 PM Qu Wenruo <quwenruo.btrfs@gmx.co=
m
> >     <mailto:quwenruo.btrfs@gmx.com>> wrote:
> >     > >>
> >     > >>
> >     > >>
> >     > >> On 2020/2/8 =E4=B8=8A=E5=8D=881:52, John Hendy wrote:
> >     > >>> Greetings,
> >     > >>>
> >     > >>> I'm resending, as this isn't showing in the archives. Perhaps
> >     it was
> >     > >>> the attachments, which I've converted to pastebin links.
> >     > >>>
> >     > >>> As an update, I'm now running off of a different drive (ssd,
> >     not the
> >     > >>> nvme) and I got the error again! I'm now inclined to think
> >     this might
> >     > >>> not be hardware after all, but something related to my setup
> >     or a bug
> >     > >>> with chromium.
> >     > >>>
> >     > >>> After a reboot, chromium wouldn't start for me and demsg show=
ed
> >     > >>> similar parent transid/csum errors to my original post below.
> >     I used
> >     > >>> btrfs-inspect-internal to find the inode traced to
> >     > >>> ~/.config/chromium/History. I deleted that, and got a new set=
 of
> >     > >>> errors tracing to ~/.config/chromium/Cookies. After I deleted
> >     that and
> >     > >>> tried starting chromium, I found that my btrfs /home/jwhendy
> >     pool was
> >     > >>> mounted ro just like the original problem below.
> >     > >>>
> >     > >>> dmesg after trying to start chromium:
> >     > >>> - https://pastebin.com/CsCEQMJa
> >     > >>
> >     > >> So far, it's only transid bug in your csum tree.
> >     > >>
> >     > >> And two backref mismatch in data backref.
> >     > >>
> >     > >> In theory, you can fix your problem by `btrfs check --repair
> >     > >> --init-csum-tree`.
> >     > >>
> >     > >
> >     > > Now that I might be narrowing in on offending files, I'll wait
> >     to see
> >     > > what you think from my last response to Chris. I did try the ab=
ove
> >     > > when I first ran into this:
> >     > > -
> >     https://lore.kernel.org/linux-btrfs/CA+M2ft8FpjdDQ7=3DXwMdYQazhyB95=
aha_D4WU_n15M59QrimrRg@mail.gmail.com/
> >     >
> >     > That RO is caused by the missing data backref.
> >     >
> >     > Which can be fixed by btrfs check --repair.
> >     >
> >     > Then you should be able to delete offending files them. (Or the w=
hole
> >     > chromium cache, and switch to firefox if you wish :P )
> >     >
> >     > But also please keep in mind that, the transid mismatch looks
> >     happen in
> >     > your csum tree, which means your csum tree is no longer reliable,=
 and
> >     > may cause -EIO reading unrelated files.
> >     >
> >     > Thus it's recommended to re-fill the csum tree by --init-csum-tre=
e.
> >     >
> >     > It can be done altogether by --repair --init-csum-tree, but to be
> >     safe,
> >     > please run --repair only first, then make sure btrfs check report=
s no
> >     > error after that. Then go --init-csum-tree.
> >     >
> >     > >
> >     > >> But I'm more interesting in how this happened.
> >     > >
> >     > > Me too :)
> >     > >
> >     > >> Have your every experienced any power loss for your NVME drive=
?
> >     > >> I'm not say btrfs is unsafe against power loss, all fs should
> >     be safe
> >     > >> against power loss, I'm just curious about if mount time log
> >     replay is
> >     > >> involved, or just regular internal log replay.
> >     > >>
> >     > >> From your smartctl, the drive experienced 61 unsafe shutdown
> >     with 2144
> >     > >> power cycles.
> >     > >
> >     > > Uhhh, hell yes, sadly. I'm a dummy running i3 and every time I =
get
> >     > > caught off gaurd by low battery and instant power-off, I kick m=
yself
> >     > > and mean to set up a script to force poweroff before that
> >     happens. So,
> >     > > indeed, I've lost power a ton. Surprised it was 61 times, but m=
aybe
> >     > > not over ~2 years. And actually, I mis-stated the age. I haven'=
t
> >     > > *booted* from this drive in almost 2yrs. It's a corporate lapto=
p,
> >     > > issued every 3, so the ssd drive is more like 5 years old.
> >     > >
> >     > >> Not sure if it's related.
> >     > >>
> >     > >> Another interesting point is, did you remember what's the
> >     oldest kernel
> >     > >> running on this fs? v5.4 or v5.5?
> >     > >
> >     > > Hard to say, but arch linux maintains a package archive. The nv=
me
> >     > > drive is from ~May 2018. The archives only go back to Jan 2019
> >     and the
> >     > > kernel/btrfs-progs was at 4.20 then:
> >     > > - https://archive.archlinux.org/packages/l/linux/
> >     >
> >     > There is a known bug in v5.2.0~v5.2.14 (fixed in v5.2.15), which =
could
> >     > cause metadata corruption. And the symptom is transid error, whic=
h
> >     also
> >     > matches your problem.
> >     >
> >     > Thanks,
> >     > Qu
> >     >
> >     > >
> >     > > Searching my Amazon orders, the SSD was in the 2015 time frame,
> >     so the
> >     > > kernel version would have been even older.
> >     > >
> >     > > Thanks for your input,
> >     > > John
> >     > >
> >     > >>
> >     > >> Thanks,
> >     > >> Qu
> >     > >>>
> >     > >>> Thanks for any pointers, as it would now seem that my purchas=
e
> >     of a
> >     > >>> new m2.sata may not buy my way out of this problem! While I d=
idn't
> >     > >>> want to reinstall, at least new hardware is a simple fix. Now=
 I'm
> >     > >>> worried there is a deeper issue bound to recur :(
> >     > >>>
> >     > >>> Best regards,
> >     > >>> John
> >     > >>>
> >     > >>> On Wed, Feb 5, 2020 at 10:01 AM John Hendy <jw.hendy@gmail.co=
m
> >     <mailto:jw.hendy@gmail.com>> wrote:
> >     > >>>>
> >     > >>>> Greetings,
> >     > >>>>
> >     > >>>> I've had this issue occur twice, once ~1mo ago and once a
> >     couple of
> >     > >>>> weeks ago. Chromium suddenly quit on me, and when trying to
> >     start it
> >     > >>>> again, it complained about a lock file in ~. I tried to dele=
te it
> >     > >>>> manually and was informed I was on a read-only fs! I ended u=
p
> >     biting
> >     > >>>> the bullet and re-installing linux due to the number of dead=
 end
> >     > >>>> threads and slow response rates on diagnosing these issues,
> >     and the
> >     > >>>> issue occurred again shortly after.
> >     > >>>>
> >     > >>>> $ uname -a
> >     > >>>> Linux whammy 5.5.1-arch1-1 #1 SMP PREEMPT Sat, 01 Feb 2020
> >     16:38:40
> >     > >>>> +0000 x86_64 GNU/Linux
> >     > >>>>
> >     > >>>> $ btrfs --version
> >     > >>>> btrfs-progs v5.4
> >     > >>>>
> >     > >>>> $ btrfs fi df /mnt/misc/ # full device; normally would be
> >     mounting a subvol on /
> >     > >>>> Data, single: total=3D114.01GiB, used=3D80.88GiB
> >     > >>>> System, single: total=3D32.00MiB, used=3D16.00KiB
> >     > >>>> Metadata, single: total=3D2.01GiB, used=3D769.61MiB
> >     > >>>> GlobalReserve, single: total=3D140.73MiB, used=3D0.00B
> >     > >>>>
> >     > >>>> This is a single device, no RAID, not on a VM. HP Zbook 15.
> >     > >>>> nvme0n1                                       259:5    0
> >     232.9G  0 disk
> >     > >>>> =E2=94=9C=E2=94=80nvme0n1p1                                 =
  259:6    0
> >      512M  0
> >     > >>>> part  (/boot/efi)
> >     > >>>> =E2=94=9C=E2=94=80nvme0n1p2                                 =
  259:7    0
> >      1G  0 part  (/boot)
> >     > >>>> =E2=94=94=E2=94=80nvme0n1p3                                 =
  259:8    0
> >     231.4G  0 part (btrfs)
> >     > >>>>
> >     > >>>> I have the following subvols:
> >     > >>>> arch: used for / when booting arch
> >     > >>>> jwhendy: used for /home/jwhendy on arch
> >     > >>>> vault: shared data between distros on /mnt/vault
> >     > >>>> bionic: root when booting ubuntu bionic
> >     > >>>>
> >     > >>>> nvme0n1p3 is encrypted with dm-crypt/LUKS.
> >     > >>>>
> >     > >>>> dmesg, smartctl, btrfs check, and btrfs dev stats attached.
> >     > >>>
> >     > >>> Edit: links now:
> >     > >>> - btrfs check: https://pastebin.com/nz6Bc145
> >     > >>> - dmesg: https://pastebin.com/1GGpNiqk
> >     > >>> - smartctl: https://pastebin.com/ADtYqfrd
> >     > >>>
> >     > >>> btrfs dev stats (not worth a link):
> >     > >>>
> >     > >>> [/dev/mapper/old].write_io_errs    0
> >     > >>> [/dev/mapper/old].read_io_errs     0
> >     > >>> [/dev/mapper/old].flush_io_errs    0
> >     > >>> [/dev/mapper/old].corruption_errs  0
> >     > >>> [/dev/mapper/old].generation_errs  0
> >     > >>>
> >     > >>>
> >     > >>>> If these are of interested, here are reddit threads where I
> >     posted the
> >     > >>>> issue and was referred here.
> >     > >>>> 1)
> >     https://www.reddit.com/r/btrfs/comments/ejqhyq/any_hope_of_recoveri=
ng_from_various_errors_root/
> >     > >>>> 2)
> >     https://www.reddit.com/r/btrfs/comments/erh0f6/second_time_btrfs_ro=
ot_started_remounting_as_ro/
> >     > >>>>
> >     > >>>> It has been suggested this is a hardware issue. I've already
> >     ordered a
> >     > >>>> replacement m2.sata, but for sanity it would be great to kno=
w
> >     > >>>> definitively this was the case. If anything stands out above=
 that
> >     > >>>> could indicate I'm not setup properly re. btrfs, that would
> >     also be
> >     > >>>> fantastic so I don't repeat the issue!
> >     > >>>>
> >     > >>>> The only thing I've stumbled on is that I have been mounting=
 with
> >     > >>>> rd.luks.options=3Ddiscard and that manually running fstrim i=
s
> >     preferred.
> >     > >>>>
> >     > >>>>
> >     > >>>> Many thanks for any input/suggestions,
> >     > >>>> John
> >     > >>
> >     >
> >
>
