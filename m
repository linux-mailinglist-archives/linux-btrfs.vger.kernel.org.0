Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E536143613
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 04:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgAUDvw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 22:51:52 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39843 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgAUDvv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 22:51:51 -0500
Received: by mail-vs1-f67.google.com with SMTP id y125so899344vsb.6
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jan 2020 19:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MmNTnJf3QXDZs23Z3b3KgM/oy0A7i7uXhmT1zyhekAw=;
        b=egjK3sjNdzpIRaDeI8R9OFVmmOqT8Dp7e7lTN0uvGf740zN+DuKQzlK12K3s6uXzHI
         xYUqZzz2tQGDbTupKob36zSFu3I8T5X7eXG1rvB5yAD2VHk3evRJ5LfL/ZIb8HLqWAkp
         PnaNSNyFXjA4CXgB2QxJrtEiXPVm3bUZDvN8pRhLuHyeNLtAlzTrR1mtSZO5vlGl4tiE
         MYKq3C02arLp9bU4TZx4GxxWKGnaXO6W+EWYsnTDc5zNSSUEM+3IabSC33LDrdgMLF0X
         eJkPbq9t+y6fy7+vNxU72dHwsT8pb3EBqSyzXdyvrCSG26q9qba9EsS5firwxEKrKP0q
         Nxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=MmNTnJf3QXDZs23Z3b3KgM/oy0A7i7uXhmT1zyhekAw=;
        b=hKECmf8DSfkcunewiQfU+FKp8+IZMYuyAxSrp06pwvaG8qbCGECvPSxpMB1uK1MljV
         7IlJekuz+ZMMkKxQU73H+wOcubeutqqVNhaykV62y2YROwcCU3LcRhT3XvIx7J6c1b9Z
         UrL4eMR1hJFo9cw00i1lgbQ3fZKdy7WYIl9beF3h0w3vc0qZEoxNZ2SCRj5v7NtUPakT
         ctkxAOvivqjBOR1ScEgTy3hBUe8ZGmREigNXvugPxFQJRHfwf+neDC6Wv9VKZJZK2yKK
         vPwttzscMhl8EnCWrIzFgEBldDsUsnjSxISgunMouiXGpg5d1lgCsKmwaTwEn12yz0wq
         irkw==
X-Gm-Message-State: APjAAAVjoDNLuomXvS/3c6ThYyiTdzI6xdvpZOl6V2z7qB4OoRUcnDRG
        Nvp6qcFBIoZGz9wwX8lqmnfGXBR0X2IIsec9rEycWcob4ig=
X-Google-Smtp-Source: APXvYqyo6R/gWRpdTayVCXCRio1S99IKH8onZgEwVpG70BLJx7AqxGb74VDfhHxeC+CfvThPU0wJ2925FZjgLv7144c=
X-Received: by 2002:a67:ee13:: with SMTP id f19mr1475667vsp.147.1579578709862;
 Mon, 20 Jan 2020 19:51:49 -0800 (PST)
MIME-Version: 1.0
References: <CACurcBus8d2RYTtVOheAvJcohY5jmP=akKUw1hen5seccfGihA@mail.gmail.com>
 <91be9396-4142-94ba-ea79-0baf8dc4800a@gmx.com> <CACurcBtC3ynvVcgS0yo2aNkxELxevc9Y=LO9eQ+hZSoB+3cMDQ@mail.gmail.com>
 <3af6a8b4-4102-4f4e-67f7-deda839e0cf5@gmx.com> <CACurcBsoOye4bZ9JxSV2zaEiMRGnhgUs5EZdhcxf5=EXQ0_6yA@mail.gmail.com>
 <0949e592-6564-8617-4e8f-fda1e9bdcfb1@gmx.com> <CACurcBsdPYCba8SjvTRxToPkwKvy3Y_85+GhqV91uS51Tv4b4w@mail.gmail.com>
 <226182ca-e389-2506-1751-79b7d0b4ec24@gmx.com>
In-Reply-To: <226182ca-e389-2506-1751-79b7d0b4ec24@gmx.com>
From:   Robbie Smith <zoqaeski@gmail.com>
Date:   Tue, 21 Jan 2020 14:51:38 +1100
Message-ID: <CACurcBs_q=Zvt4_f4iJ5fupUR0b5OnsFzx6mZ7GeAw8kSgtp8w@mail.gmail.com>
Subject: Re: BTRFS failure after resume from hibernate
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 21 Jan 2020 at 14:05, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/1/21 =E4=B8=8A=E5=8D=8810:58, Robbie Smith wrote:
> [...]
> >>
> >> Really hard to say, there are at least 3 things related to this proble=
m.
> >>
> >> - Btrfs itself
> >> - Hibernation
> >> - Dm-crypt (less possible)
> >>
> >> For btrfs, if you have used kernel between version v5.2.0 and v5.2.15,
> >> then it's possible the fs is already corrupted but not detected.
> >>
> >> For the hibernation part, Linux is not the best place to utilize it fo=
r
> >> the first place.
> >> (My ThinkPad X1 Carbon 6th suffers from hibernation, so I rarely use
> >> suspension/hiberation)
> >>
> >> Since linux development is mostly server oriented, such daily consumer
> >> operation may not be that well tested.
> >>
> >> Things like Windows updating certain firmware could break the controll=
er
> >> behavior and cause unexpected behavior.
> >>
> >> So my personal recommendation is, to avoid hibernation/suspension, use
> >> Windows as little as possible.
> >>
> >> Thanks,
> >> Qu
> >
> > Suspension works flawlessly for me, and hibernation usually does as
> > well. The one thing that has happened both times I've had a failure
> > has been something weird with the power: first time was a static shock
> > from walking on carpet and then touching the laptop, second time was
> > the BIOS reporting a wattage error with the charger.
>
> This doesn't look correct for ThinkPad T series machine...
>
> >
> > I tried mounting the FS from a live USB and the mount said: "can't
> > read superblock on /dev/mapper/cryptroot" in addition to the transid
> > failures. Should I try running a `btrfs check --repair`? At this point
> > I'm pretty much resigned to reinstalling today, so I can't make things
> > any worse, can I?
>
> Full output please.

I can't get the output from that mount run as it's lost in the shell
history. Attempting to mount now does nothing and just spits out:
> # mount -t btrfs -o ro,usebackuproot /dev/mapper/cryptroot /mnt/cryptroot
> [dmesg timestamp] BTRFS error (device dm-0): parent transid verify failed=
 on 223452889088 wanted 144360 found 144376
> [dmesg timestamp] BTRFS error (device dm-0): parent transid verify failed=
 on 223452889088 wanted 144360 found 144376

btrfs check prints the UUID, and that's it.
> # btrfs check /dev/mapper/cryptroot
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/cryptroot
> UUID: 25ac1f63-5986-4eb8-920f-ed7a5354c076

Attempting a dry-run of btrfs restore gave me these messages. The fact
that it can read some files and find my /home subvolume gives me some
hope.
> # btrfs restore -D /dev/mapper/cryptroot /mnt/restore
> This is a dry-run, no files are going to be restored
> We have looped trying to restore files in /@home/robbie/.cache/chromium/D=
efault/Code Cache/js too many times to be making progress, stopping
> We have looped trying to restore files in /@home/robbie/.cache/chromium/D=
efault/Cache too many times to be making progress, stopping
> We have looped trying to restore files in /@home/robbie/.cache/chromium/P=
rofile 1/Cache too many times to be making progress, stopping
> We have looped trying to restore files in /@home/robbie/.cache/chromium/P=
rofile 2/Code Cache/js too many times to be making progress, stopping
> We have looped trying to restore files in /@home/robbie/.cache/chromium/P=
rofile 2/Cache too many times to be making progress, stopping
> We have looped trying to restore files in /@home/robbie/.cache/thumbnails=
/large too many times to be making progress, stopping
> We have looped trying to restore files in /@home/robbie/.cache/mozilla/fi=
refox/eedh8ma4.default-release/cache2/entries too many times to be making p=
rogress, stopping
> We have looped trying to restore files in /@home/robbie/.config/discord/C=
ache too many times to be making progress, stopping

I'm going to go get myself a new external drive, reformat it as ext4
or something (what would be the best filesystem to use?=E2=80=94they always
come out of the box as NTFS for Windows), and then try restoring my
filesystem to that. Maybe I can recover things before attempting a
`btrfs check --repair`. Worst case scenario then is that I have a few
corrupted files on a spare disk.

>
> >
> > I've also used kernel between version 5.2.0 and 5.2.15 on both my
> > machines, so does that mean there's a risk of undetected disk errors
> > on my desktop as well?
>
> It's possible.
>
> > I don't have backups of my backups, and all my
> > drives use BTRFS because I like the subvolume/snapshot features. I
> > also don't have a backup of my music/video library because I don't
> > have another 5 TB HDD.
>
> You can just run "btrfs check" from a liveUSB to check if the fs is OK.
>
> Thanks,
> Qu
>
