Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABE89B3C78
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2019 16:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388624AbfIPOWi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Sep 2019 10:22:38 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:35626 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388541AbfIPOWi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Sep 2019 10:22:38 -0400
Received: by mail-vs1-f41.google.com with SMTP id b11so23406996vsq.2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2019 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liland-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5H5lw7KfJ3I3X1GpJ4RDFS6hRLVVXvB9HXaL2oR4r3M=;
        b=EDvvHQTzbIFlseuhtBNzSvAgW9V7XgnqxDwfMt81Tml27SRzfct0StrS937CKgyiie
         B2AH8JcWst4m/wjkKDWC8UvxWdDuoCTUIouui7Z49PTEDwYx0oUmFGTHRGuFy+CXIawo
         7uD6WGchW1U/alfZWml4xNBLBqLwJx6Ci/98Hi9yXDFnpd8TWHGQPqFul3DnsaRavmjF
         nn62UcR9+4NcpoAYc96e9Z12JiQu7Xhryq+K1FbRCVnQ8//tVthsOxIWfmTOZuDRc2y6
         bhQYDj9kuoVquT74HW0Ppd3p+bRXl/ST3HGIRE0GOoBQ6xKFJox8fYIj0Vqw99R5NBtW
         DwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5H5lw7KfJ3I3X1GpJ4RDFS6hRLVVXvB9HXaL2oR4r3M=;
        b=mf31uUwuLTMlg355Dkw4C5CYWCpg5sytFq8+gfth2Rb93uO89j2zm7JtrQDZyY48C4
         8eKu2DS+L7dvZTxX/Nr9yzTUW/1y1zPF1W7yJltSj6VsyEnbojo/xN3KPkKBoEaBU9M4
         kH3jCPw+bUCN41Cdh3Hnq13ASOArw0hsz1uaZffxAY1m/wQkK0z9Yr0GLITxAOYukDmf
         nr9aJ2HVSRZdHvbCpRwEnjo4s1iZbRfyGGu+Jx3SJ9moc7uzl0bneyGBClBOu4nPaTZl
         ZbVONM22jq1SAAVAqHyOH4epvbd99Zz8S/YJAFXxXsvLdG3QXUoN85DvbXcUIxybFXca
         XJqw==
X-Gm-Message-State: APjAAAUdIaLpJ+/vQ7BMjzUKWJlZyZXbe+GETUjU9Mo4EyY9Eu6cnumU
        7q4ZPJfWz1JP7qXnzAHXvd+TKx/kZ3u8YVUe2Jn3xdUo03PFViamTmHEHCTs27cXGyPsnz1Dpo5
        0Jnq7l826qKT+fGn4tKJUWRmcJnYEhJeP
X-Google-Smtp-Source: APXvYqwN+gZl8nYMX11QGG6AaaT99UTc99YQpdd5LMTS+qv1vtRzdxGIFlAkZDMo8lNacwJjq9zcm6r76TLyc4MJmo0=
X-Received: by 2002:a67:6746:: with SMTP id b67mr32122933vsc.135.1568643756177;
 Mon, 16 Sep 2019 07:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <f58d5ec1-4b38-ad8b-068d-d3bb1f616ec2@liland.com>
 <CAJCQCtTqetLF1sMmgoPyN=2FOHu+MSSW-MGsN6NairLPdNmK+g@mail.gmail.com>
 <c57b8314-4914-628c-f62b-c5291a6be53c@liland.com> <CAJCQCtT5WecG26YXE6EVwhv52xSY_sm8GqgLDoQbZBUom4Pw7Q@mail.gmail.com>
 <51d54d67-bfd3-ee18-d612-330d07d9f714@liland.com> <CAJCQCtSAmCmonFBSBiMCrn+1X__WHDvHgLwWFyScvnfOGRD_4w@mail.gmail.com>
 <6d535ae3-fac4-8fca-4823-2eeceb80529c@liland.com> <CAJCQCtQiw-DOPSpc=qdQa01=4iQHRq2gx-kR==uDduHUYn=sRw@mail.gmail.com>
In-Reply-To: <CAJCQCtQiw-DOPSpc=qdQa01=4iQHRq2gx-kR==uDduHUYn=sRw@mail.gmail.com>
From:   "Urbani, Edmund" <edmund.urbani@liland.com>
Date:   Mon, 16 Sep 2019 16:22:25 +0200
Message-ID: <CAG4ZH3t3OdiJh4PcOZTFOLvSGjqe8fp2kBr6DdvTwRsimMv0JA@mail.gmail.com>
Subject: Re: Unmountable degraded BTRFS RAID6 filesystem
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Fr., 6. Sept. 2019 um 00:33 Uhr schrieb Chris Murphy
<lists@colorremedies.com>:
>
> On Thu, Sep 5, 2019 at 2:44 PM Edmund Urbani <edmund.urbani@liland.com> w=
rote:
> >
> > I did not need the degraded option. And so far I see no HW I/O errors i=
n
> > dmesg. I have encountered a few errors while copying files and found
> > these in the log:
> >
> > [ 3560.273634] btrfs_print_data_csum_error: 50 callbacks suppressed
> > [ 3560.273639] BTRFS warning (device sdg1): csum failed root 262 ino
> > 1838364 off 14467072 csum 0x98f94189 expected csum 0xcb3af09a mirror 1
>
> Not a bit flip
> 0x98f94189
> 10011000111110010100000110001001
> 0xcb3af09a
> 11001011001110101111000010011010
>
>
> > [ 3560.825942] BTRFS warning (device sdg1): csum failed root 262 ino
> > 1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 2
> > [ 3560.826588] BTRFS warning (device sdg1): csum failed root 262 ino
> > 1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 3
> > [ 3560.827813] BTRFS warning (device sdg1): csum failed root 262 ino
> > 1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 4
> > [ 3560.829063] BTRFS warning (device sdg1): csum failed root 262 ino
> > 1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 5
> > [ 3560.830366] BTRFS warning (device sdg1): csum failed root 262 ino
> > 1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 6
> > [ 3560.831559] BTRFS warning (device sdg1): csum failed root 262 ino
> > 1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 7
> > [ 3560.832998] BTRFS warning (device sdg1): csum failed root 262 ino
> > 1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 8
> > [ 3560.834649] BTRFS warning (device sdg1): csum failed root 262 ino
> > 1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 9
> > [ 3560.836188] BTRFS warning (device sdg1): csum failed root 262 ino
> > 1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 10
>
> Also not a bit flip.
> 0xc0248289
> 11000000001001001000001010001001
> 0xcb3af09a
> 11001011001110101111000010011010
>
> I'm not sure what it means or suggests has happened, that all the
> copies are wrong. Plausible with raid5 metadata. But seems unlikely
> with raid6 metadata, and also with all devices accounted for.
>
> The file itself is probably fine - these look like metadata
> complaints. If you find the file this inode belongs to, either
> duplicating it or deleting it is fine, should cause this bad leaf to
> just go away. Make sure you delete the correct file, each subvolume
> has its own list of inodes, this one is in subvol id 262.
>
> >
> > and also:
> >
> > [ 3889.813300] btree_readpage_end_io_hook: 1860 callbacks suppressed
> > [ 3889.813304] BTRFS error (device sdg1): bad tree block start, want
> > 34958548107264 have 0
> > [ 3889.825732] BTRFS error (device sdg1): bad tree block start, want
> > 34958548107264 have 12157064991241308972
> > [ 3889.826375] BTRFS error (device sdg1): bad tree block start, want
> > 34958548107264 have 12157064991241308972
> > [ 3889.828149] BTRFS error (device sdg1): bad tree block start, want
> > 34958548107264 have 12157064991241308972
> > [ 3889.829649] BTRFS error (device sdg1): bad tree block start, want
> > 34958548107264 have 12157064991241308972
> > [ 3889.831592] BTRFS error (device sdg1): bad tree block start, want
> > 34958548107264 have 12157064991241308972
> > [ 3889.833436] BTRFS error (device sdg1): bad tree block start, want
> > 34958548107264 have 12157064991241308972
> > [ 3889.835458] BTRFS error (device sdg1): bad tree block start, want
> > 34958548107264 have 12157064991241308972
> > [ 3889.836968] BTRFS error (device sdg1): bad tree block start, want
> > 34958548107264 have 12157064991241308972
> > [ 3889.848545] BTRFS error (device sdg1): bad tree block start, want
> > 34958548107264 have 12157064991241308972
>
> I'm skeptical that a scrub will fix these things, because Btrfs is
> passively scrubbing on reads, so any checksum mismatches should get
> fixed up, if they can be fixed, from reconstruction, on the fly as
> well as scrub. This is a different problem, I'm not sure how serious
> it is.
>
> I would still do the full scrub. And then unmount it and run 'btrfs
> check --mode=3Dlowmem'. On a file system of this size it will take a
> long time. So maybe do it over a weekend
>
> >
> > I think that Input/output error btrfsck is showing is actually a
> > filesystem checksum error and not triggered by faulty hardware (not
> > anymore, I hope). If there actually are any more failing drives here, I
> > will most likely do the ddrescue thing again. Currently there are no
> > free SATA ports in that system to connect an additional drive, so I
> > cannot simply add one (at least not without also installing an
> > additional SATA controller).
>
> I suggest start planning how to migrate the data to a new Btrfs
> volume. If the problems can't be repaired, this becomes inevitable. A
> reasonable strategy is to take read-only snapshots of each subvolume
> you want to preserve. And either 'btrfs send/receive' or 'rsync' to
> new storage. That way you can keep using the volume rw in the
> meantime. Once that completes, do another read only snapshot of each
> subvolume, and do an incremental 'send -p' or rsync to migrate the
> much smaller changes.
>
>
> --
> Chris Murphy


Here's a little status update. I am still in the process of salvaging
files (remounting rw did not work for long and btrfs soon reverted to
read-only state and I left it that way for now). After completing my
first rsync pass I was still missing several large directory trees and
found corresponding errors in the logs:
Sep 15 20:34:39 phoenix kernel: BTRFS error (device sdg1): parent
transid verify failed on 34960626352128 wanted 3332854 found 3332691

I remounted with ro,recover,nospace_cache,clear_cache. Now I am able
to access more of the filesystem, but some errors still remain. I am
seeing plenty of csum errors in the logs:
Sep 16 12:08:53 phoenix kernel: BTRFS info (device sdg1): no csum
found for inode 6126287 start 1673527296

then there's these (for all 10 mirrors):
Sep 16 12:09:13 phoenix kernel: BTRFS warning (device sdg1): csum
failed root 261 ino 6126287 off 1734606848 csum 0x7430ddcb expected
csum 0x00000000 mirror 10
curiously at least the recent log entries all refer to inode 6126287
(start, offset etc. vary).

And then there's also still occasionally this:
Sep 16 12:09:19 phoenix kernel: BTRFS error (device sdg1): parent
transid verify failed on 34960627597312 wanted 3332854 found 3332691

I'll investigate the logs further when the second rsync pass is done.

Kind regards,
 Edmund

--=20
*Liland IT GmbH*


Ferlach =E2=97=8F Wien =E2=97=8F M=C3=BCnchen
Tel: +43 463 220111
Tel: +49 89=20
458 15 940
office@Liland.com
https://Liland.com <https://Liland.com>=C2=A0



Copyright =C2=A9 2019 Liland IT GmbH=C2=A0

Diese Mail enthaelt vertrauliche und/oder=20
rechtlich geschuetzte=C2=A0Informationen.=C2=A0
Wenn Sie nicht der richtige Adressat=20
sind oder diese Email irrtuemlich=C2=A0erhalten haben, informieren Sie bitt=
e=20
sofort den Absender und vernichten=C2=A0Sie diese Mail. Das unerlaubte Kopi=
eren=20
sowie die unbefugte Weitergabe=C2=A0dieser Mail ist nicht gestattet.=C2=A0

This=20
email may contain confidential and/or privileged information.=C2=A0
If you are=20
not the intended recipient (or have received this email in=C2=A0error) plea=
se=20
notify the sender immediately and destroy this email. Any=C2=A0unauthorised=
=20
copying, disclosure or distribution of the material in this=C2=A0email is=
=20
strictly forbidden.

