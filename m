Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0321567A2
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Feb 2020 20:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgBHT5M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Feb 2020 14:57:12 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35505 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbgBHT5M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 8 Feb 2020 14:57:12 -0500
Received: by mail-ua1-f65.google.com with SMTP id y23so1108224ual.2
        for <linux-btrfs@vger.kernel.org>; Sat, 08 Feb 2020 11:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RoQEBsoFB04sjFK7zmuNfOKSj7DcnKUmciFxf6QoybA=;
        b=u/Cd7sNoKSswVQlR7ueNnWCt5dOWq3xoKzyNhRaOQCCodrJyxLN7b43X82002/ThaE
         f8Zpjx+WBPQVJQHDsIciVMYBZh4VZqZoNV3gp5+l/X4WI3duMsc0oKxmfwhAUIhXFntm
         dWagsMkTfCAXXABvd/vIRbgU1oGcs56XU/lgCqYaITtoIN8MFp0Y5SQtkCM5hNF6Budk
         tFfUdCWg7qBsS+GKcv3oUxleDKNBqH5enEPzuevoxooXbXrdY39I0wQToD9cKu/tzCXB
         sSmjetc7d+Uw3OukgITuRAqw1D6Cdo+h/D6ISGHgG+HX/u3vh7oN43RIb9Z8e96rBIbu
         3VWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RoQEBsoFB04sjFK7zmuNfOKSj7DcnKUmciFxf6QoybA=;
        b=cpFa/Lp/TVPIiGl6fPMecYqDTH/YPG6vRoX/PdNkrRRsQ23zZeNXjAml+CpSQZwgzm
         vd9CA7O+/aD3HQtjai9ifnWH0HDa+SdUVteNlVBPVVUAyRmE1MR6EYge9Bly9tGGbo0T
         qiLR8BCumSTUoSdJmr3BPYQ3SBAn1W4NnVfUSYtpAw2UNE9l7k1DoWM4PK4n7Dm+3NiQ
         /rxuyqRUNl5VoAsuhwzOIS71fAatP0NM3WNVJPlDU6aSJLBKA7tu7ZtTdbZ7H2Ziv3El
         wUtE7J8GLlQSMl9PWeoqhrJO4J8XJ9hPFJP9WebnuLRUlVaj19zf0pkrLzNj80S7d5RI
         rOOQ==
X-Gm-Message-State: APjAAAWydXGbRdmsqV4rADLCNmp4+mt4o/AJLgMCO+4sTM66PBzNveJw
        aiLKekAYRJmldcE1tne4bDGqrfqdUBkMDo4TKtf4pcIPR8w=
X-Google-Smtp-Source: APXvYqycuww7PF6nCmm+sGgIwwxl2gPXmsWJduKUyKujSu9y1JejMXeP/pngiQxNVvAMW95CKWoGefaP1tPdlSFyhMk=
X-Received: by 2002:ab0:6029:: with SMTP id n9mr2565691ual.35.1581191829311;
 Sat, 08 Feb 2020 11:57:09 -0800 (PST)
MIME-Version: 1.0
References: <CA+M2ft9zjGm7XJw1BUm364AMqGSd3a8QgsvQDCWz317qjP=o8g@mail.gmail.com>
 <CA+M2ft9ANwKT1+ENS6-w9HLtdx0MDOiVhi5RWKLucaT_WtZLkg@mail.gmail.com>
 <40b47145-f965-ec5f-2caf-68434c4fbc62@gmx.com> <CA+M2ft8zMv8nhs6VzZWnzgcP2nRasrwxLzjKgaZPnm_prtWQow@mail.gmail.com>
 <3e5f4de7-fec1-f8cd-c8b1-20b5a3f38f60@gmx.com>
In-Reply-To: <3e5f4de7-fec1-f8cd-c8b1-20b5a3f38f60@gmx.com>
From:   John Hendy <jw.hendy@gmail.com>
Date:   Sat, 8 Feb 2020 13:56:58 -0600
Message-ID: <CA+M2ft_6_1pkP75G79qj4dLxOjJr0bOGtATaGPTVQGn25sAo+A@mail.gmail.com>
Subject: Re: btrfs root fs started remounting ro
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is not going so hot. Updates:

booted from arch install, pre repair btrfs check:
- https://pastebin.com/6vNaSdf2

btrfs check --mode=3Dlowmem as requested by Chris:
- https://pastebin.com/uSwSTVVY

Then I did btrfs check --repair, which seg faulted at the end. I've
typed them off of pictures I took:

Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/mapper/ssd
[1/7] checking root items
Fixed 0 roots.
[2/7] checking extents
parent transid verify failed on 20271138064 wanted 68719924810 found 448074
parent transid verify failed on 20271138064 wanted 68719924810 found 448074
Ignoring transid failure
# ... repeated the previous two lines maybe hundreds of times
# ended with this:
ref mismatch on [12797435904 268505088] extent item 1, found 412
[1] 1814 segmentation fault (core dumped) btrfs check --repair /dev/mapper/=
ssd

This was with btrfs-progs 5.4 (the install USB is maybe a month old).

Here is the output of btrfs check after the --repair attempt:
- https://pastebin.com/6MYRNdga

I rebooted to write this email given the seg fault, as I wanted to
make sure that I should still follow-up --repair with
--init-csum-tree. I had pictures of the --repair output, but Firefox
just wouldn't load imgur.com for me to post the pics and was acting
really weird. In suspiciously checking dmesg, things have gone ro on
me :(  Here is the dmesg from this session:
- https://pastebin.com/a2z7xczy

The gist is:

[   40.997935] BTRFS critical (device dm-0): corrupt leaf: root=3D7
block=3D172703744 slot=3D0, csum end range (12980568064) goes beyond the
start range (12980297728) of the next csum item
[   40.997941] BTRFS info (device dm-0): leaf 172703744 gen 450983
total ptrs 34 free space 29 owner 7
[   40.997942]     item 0 key (18446744073709551606 128 12979060736)
itemoff 14811 itemsize 1472
[   40.997944]     item 1 key (18446744073709551606 128 12980297728)
itemoff 13895 itemsize 916
[   40.997945]     item 2 key (18446744073709551606 128 12981235712)
itemoff 13811 itemsize 84
# ... there's maybe 30 of these item n key lines in total
[   40.997984] BTRFS error (device dm-0): block=3D172703744 write time
tree block corruption detected
[   41.016793] BTRFS: error (device dm-0) in
btrfs_commit_transaction:2332: errno=3D-5 IO failure (Error while
writing out transaction)
[   41.016799] BTRFS info (device dm-0): forced readonly
[   41.016802] BTRFS warning (device dm-0): Skipping commit of aborted
transaction.
[   41.016804] BTRFS: error (device dm-0) in cleanup_transaction:1890:
errno=3D-5 IO failure
[   41.016807] BTRFS info (device dm-0): delayed_refs has NO entry
[   41.023473] BTRFS warning (device dm-0): Skipping commit of aborted
transaction.
[   41.024297] BTRFS info (device dm-0): delayed_refs has NO entry
[   44.509418] systemd-journald[416]:
/var/log/journal/45c06c25e25f434195204efa939019ab/system.journal:
Journal file corrupted, rotating.
[   44.509440] systemd-journald[416]: Failed to rotate
/var/log/journal/45c06c25e25f434195204efa939019ab/system.journal:
Read-only file system
[   44.509450] systemd-journald[416]: Failed to rotate
/var/log/journal/45c06c25e25f434195204efa939019ab/user-1000.journal:
Read-only file system
[   44.509540] systemd-journald[416]: Failed to write entry (23 items,
705 bytes) despite vacuuming, ignoring: Bad message
# ... then a bunch of these failed journal attempts (of note:
/var/log/journal was one of the bad inodes from btrfs check
previously)

Kindly let me know what you would recommend. I'm sadly back to an
unusable system vs. a complaining/worrisome one. This is similar to
the behavior I had with the m2.sata nvme drive in my original
experience. After trying all of --repair, --init-csum-tree, and
--init-extent-tree, I couldn't boot anymore. After my dm-crypt
password at boot, I just saw a bunch of [FAILED] in the text splash
output. Hoping to not repeat that with this drive.

Thanks,
John


On Sat, Feb 8, 2020 at 1:29 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/2/8 =E4=B8=8B=E5=8D=8812:48, John Hendy wrote:
> > On Fri, Feb 7, 2020 at 5:42 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
> >>
> >>
> >>
> >> On 2020/2/8 =E4=B8=8A=E5=8D=881:52, John Hendy wrote:
> >>> Greetings,
> >>>
> >>> I'm resending, as this isn't showing in the archives. Perhaps it was
> >>> the attachments, which I've converted to pastebin links.
> >>>
> >>> As an update, I'm now running off of a different drive (ssd, not the
> >>> nvme) and I got the error again! I'm now inclined to think this might
> >>> not be hardware after all, but something related to my setup or a bug
> >>> with chromium.
> >>>
> >>> After a reboot, chromium wouldn't start for me and demsg showed
> >>> similar parent transid/csum errors to my original post below. I used
> >>> btrfs-inspect-internal to find the inode traced to
> >>> ~/.config/chromium/History. I deleted that, and got a new set of
> >>> errors tracing to ~/.config/chromium/Cookies. After I deleted that an=
d
> >>> tried starting chromium, I found that my btrfs /home/jwhendy pool was
> >>> mounted ro just like the original problem below.
> >>>
> >>> dmesg after trying to start chromium:
> >>> - https://pastebin.com/CsCEQMJa
> >>
> >> So far, it's only transid bug in your csum tree.
> >>
> >> And two backref mismatch in data backref.
> >>
> >> In theory, you can fix your problem by `btrfs check --repair
> >> --init-csum-tree`.
> >>
> >
> > Now that I might be narrowing in on offending files, I'll wait to see
> > what you think from my last response to Chris. I did try the above
> > when I first ran into this:
> > - https://lore.kernel.org/linux-btrfs/CA+M2ft8FpjdDQ7=3DXwMdYQazhyB95ah=
a_D4WU_n15M59QrimrRg@mail.gmail.com/
>
> That RO is caused by the missing data backref.
>
> Which can be fixed by btrfs check --repair.
>
> Then you should be able to delete offending files them. (Or the whole
> chromium cache, and switch to firefox if you wish :P )
>
> But also please keep in mind that, the transid mismatch looks happen in
> your csum tree, which means your csum tree is no longer reliable, and
> may cause -EIO reading unrelated files.
>
> Thus it's recommended to re-fill the csum tree by --init-csum-tree.
>
> It can be done altogether by --repair --init-csum-tree, but to be safe,
> please run --repair only first, then make sure btrfs check reports no
> error after that. Then go --init-csum-tree.
>
> >
> >> But I'm more interesting in how this happened.
> >
> > Me too :)
> >
> >> Have your every experienced any power loss for your NVME drive?
> >> I'm not say btrfs is unsafe against power loss, all fs should be safe
> >> against power loss, I'm just curious about if mount time log replay is
> >> involved, or just regular internal log replay.
> >>
> >> From your smartctl, the drive experienced 61 unsafe shutdown with 2144
> >> power cycles.
> >
> > Uhhh, hell yes, sadly. I'm a dummy running i3 and every time I get
> > caught off gaurd by low battery and instant power-off, I kick myself
> > and mean to set up a script to force poweroff before that happens. So,
> > indeed, I've lost power a ton. Surprised it was 61 times, but maybe
> > not over ~2 years. And actually, I mis-stated the age. I haven't
> > *booted* from this drive in almost 2yrs. It's a corporate laptop,
> > issued every 3, so the ssd drive is more like 5 years old.
> >
> >> Not sure if it's related.
> >>
> >> Another interesting point is, did you remember what's the oldest kerne=
l
> >> running on this fs? v5.4 or v5.5?
> >
> > Hard to say, but arch linux maintains a package archive. The nvme
> > drive is from ~May 2018. The archives only go back to Jan 2019 and the
> > kernel/btrfs-progs was at 4.20 then:
> > - https://archive.archlinux.org/packages/l/linux/
>
> There is a known bug in v5.2.0~v5.2.14 (fixed in v5.2.15), which could
> cause metadata corruption. And the symptom is transid error, which also
> matches your problem.
>
> Thanks,
> Qu
>
> >
> > Searching my Amazon orders, the SSD was in the 2015 time frame, so the
> > kernel version would have been even older.
> >
> > Thanks for your input,
> > John
> >
> >>
> >> Thanks,
> >> Qu
> >>>
> >>> Thanks for any pointers, as it would now seem that my purchase of a
> >>> new m2.sata may not buy my way out of this problem! While I didn't
> >>> want to reinstall, at least new hardware is a simple fix. Now I'm
> >>> worried there is a deeper issue bound to recur :(
> >>>
> >>> Best regards,
> >>> John
> >>>
> >>> On Wed, Feb 5, 2020 at 10:01 AM John Hendy <jw.hendy@gmail.com> wrote=
:
> >>>>
> >>>> Greetings,
> >>>>
> >>>> I've had this issue occur twice, once ~1mo ago and once a couple of
> >>>> weeks ago. Chromium suddenly quit on me, and when trying to start it
> >>>> again, it complained about a lock file in ~. I tried to delete it
> >>>> manually and was informed I was on a read-only fs! I ended up biting
> >>>> the bullet and re-installing linux due to the number of dead end
> >>>> threads and slow response rates on diagnosing these issues, and the
> >>>> issue occurred again shortly after.
> >>>>
> >>>> $ uname -a
> >>>> Linux whammy 5.5.1-arch1-1 #1 SMP PREEMPT Sat, 01 Feb 2020 16:38:40
> >>>> +0000 x86_64 GNU/Linux
> >>>>
> >>>> $ btrfs --version
> >>>> btrfs-progs v5.4
> >>>>
> >>>> $ btrfs fi df /mnt/misc/ # full device; normally would be mounting a=
 subvol on /
> >>>> Data, single: total=3D114.01GiB, used=3D80.88GiB
> >>>> System, single: total=3D32.00MiB, used=3D16.00KiB
> >>>> Metadata, single: total=3D2.01GiB, used=3D769.61MiB
> >>>> GlobalReserve, single: total=3D140.73MiB, used=3D0.00B
> >>>>
> >>>> This is a single device, no RAID, not on a VM. HP Zbook 15.
> >>>> nvme0n1                                       259:5    0 232.9G  0 d=
isk
> >>>> =E2=94=9C=E2=94=80nvme0n1p1                                   259:6 =
   0   512M  0
> >>>> part  (/boot/efi)
> >>>> =E2=94=9C=E2=94=80nvme0n1p2                                   259:7 =
   0     1G  0 part  (/boot)
> >>>> =E2=94=94=E2=94=80nvme0n1p3                                   259:8 =
   0 231.4G  0 part (btrfs)
> >>>>
> >>>> I have the following subvols:
> >>>> arch: used for / when booting arch
> >>>> jwhendy: used for /home/jwhendy on arch
> >>>> vault: shared data between distros on /mnt/vault
> >>>> bionic: root when booting ubuntu bionic
> >>>>
> >>>> nvme0n1p3 is encrypted with dm-crypt/LUKS.
> >>>>
> >>>> dmesg, smartctl, btrfs check, and btrfs dev stats attached.
> >>>
> >>> Edit: links now:
> >>> - btrfs check: https://pastebin.com/nz6Bc145
> >>> - dmesg: https://pastebin.com/1GGpNiqk
> >>> - smartctl: https://pastebin.com/ADtYqfrd
> >>>
> >>> btrfs dev stats (not worth a link):
> >>>
> >>> [/dev/mapper/old].write_io_errs    0
> >>> [/dev/mapper/old].read_io_errs     0
> >>> [/dev/mapper/old].flush_io_errs    0
> >>> [/dev/mapper/old].corruption_errs  0
> >>> [/dev/mapper/old].generation_errs  0
> >>>
> >>>
> >>>> If these are of interested, here are reddit threads where I posted t=
he
> >>>> issue and was referred here.
> >>>> 1) https://www.reddit.com/r/btrfs/comments/ejqhyq/any_hope_of_recove=
ring_from_various_errors_root/
> >>>> 2)  https://www.reddit.com/r/btrfs/comments/erh0f6/second_time_btrfs=
_root_started_remounting_as_ro/
> >>>>
> >>>> It has been suggested this is a hardware issue. I've already ordered=
 a
> >>>> replacement m2.sata, but for sanity it would be great to know
> >>>> definitively this was the case. If anything stands out above that
> >>>> could indicate I'm not setup properly re. btrfs, that would also be
> >>>> fantastic so I don't repeat the issue!
> >>>>
> >>>> The only thing I've stumbled on is that I have been mounting with
> >>>> rd.luks.options=3Ddiscard and that manually running fstrim is prefer=
red.
> >>>>
> >>>>
> >>>> Many thanks for any input/suggestions,
> >>>> John
> >>
>
