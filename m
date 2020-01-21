Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55F19143C61
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 12:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgAUL56 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 06:57:58 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43283 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgAUL56 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 06:57:58 -0500
Received: by mail-oi1-f194.google.com with SMTP id p125so2252031oif.10
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2020 03:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0qBYK/GkAalVZnvADWvbdz1ZcjZBYvTuJhfYRtzcc0U=;
        b=q6ptStygj20oPj9kDcIg9F/FriQrIuIWrkvsw9HKKdip94Y2eNsDg9CiSgklxvJwP0
         V/9Fnt3g8/aR+U/6RsTaczcQXV+5ot1K96QsDIpe5NT9A+LnKChK7J/rizP6OAHvCbvJ
         A9sJntY7ga2BelkbExVMUCewSwlHIV3CRbC3H4G20rrlTKOrGRQ6uQzPqjmxI2wSP0Lj
         YJp5Zn/lVn7vIEw5FMDWLHWwiKWxyMpxSILn7HLMUQwxZtn+wSx1hdKgwqfs21QEd+16
         pn6r2/BX7jiw6ZALVav2pPkAK/t+DqVlQQYOcr3A467mejokw3w2abkyQjSZ07S/rg8Q
         ZEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0qBYK/GkAalVZnvADWvbdz1ZcjZBYvTuJhfYRtzcc0U=;
        b=Tp/oxf8UBnqUwtrzrqohE6UsrmQAxH9Z1QMsj7ZhofLpX6OWkblU+Mhnkf+L+l1eaq
         RJF0LRlSLUvAHfrDD4Zj+5hLgx8oPitt4GfG1FYWJXFIN4X1mhjRtc87SQuwhWsbEiCM
         SWVtJJ43kykjZ8m8zNdXkrqbbyAt9MYjGDyRc6lsWserN7bmmsD+ZwrBEovaaiddgnu0
         LgoWu5qBo8LbdNlpm85/QtJbLpyOIfaULIKiZObYC2sXck8GS7/eXn5f5PXsNzz57HFT
         tsj33A97UmEc929IvKUcMaWWuf6JdiNLzcSXqTxHM9/Bsj2YFHi7nk15y5ntsSKvWw6b
         hs4Q==
X-Gm-Message-State: APjAAAX38Q4rMV2QxSlhWP5TiqBKezO4rmPqQCsjtv2xLPldv7PGPhEf
        GnWjGDZF9pK9Pe2DCuh1dfDHNw8dSBNsy1tz3MM=
X-Google-Smtp-Source: APXvYqy/srhajOQgHNKQgZClLBZWQ7MGM39b9m0Zqy4ZBq/5J7IcoVKiGyA6enWc6yq9XCxDbrUDh1nUgY1ykfYp4CM=
X-Received: by 2002:a05:6808:10d:: with SMTP id b13mr2686080oie.69.1579607876647;
 Tue, 21 Jan 2020 03:57:56 -0800 (PST)
MIME-Version: 1.0
References: <CACurcBus8d2RYTtVOheAvJcohY5jmP=akKUw1hen5seccfGihA@mail.gmail.com>
 <91be9396-4142-94ba-ea79-0baf8dc4800a@gmx.com> <CACurcBtC3ynvVcgS0yo2aNkxELxevc9Y=LO9eQ+hZSoB+3cMDQ@mail.gmail.com>
 <3af6a8b4-4102-4f4e-67f7-deda839e0cf5@gmx.com> <CACurcBsoOye4bZ9JxSV2zaEiMRGnhgUs5EZdhcxf5=EXQ0_6yA@mail.gmail.com>
 <0949e592-6564-8617-4e8f-fda1e9bdcfb1@gmx.com> <CACurcBsdPYCba8SjvTRxToPkwKvy3Y_85+GhqV91uS51Tv4b4w@mail.gmail.com>
 <226182ca-e389-2506-1751-79b7d0b4ec24@gmx.com> <CACurcBs_q=Zvt4_f4iJ5fupUR0b5OnsFzx6mZ7GeAw8kSgtp8w@mail.gmail.com>
 <CACurcBueqFjkX43timLY_OCQ97KOdwwj742XEFJJY+d290SnYw@mail.gmail.com>
In-Reply-To: <CACurcBueqFjkX43timLY_OCQ97KOdwwj742XEFJJY+d290SnYw@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Date:   Tue, 21 Jan 2020 14:57:44 +0300
Message-ID: <CAA91j0U0ZZO+4Jzh566q61rTqwdPfYwpjgpk8=jr=AFN67P9hg@mail.gmail.com>
Subject: Re: BTRFS failure after resume from hibernate
To:     Robbie Smith <zoqaeski@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 21, 2020 at 2:01 PM Robbie Smith <zoqaeski@gmail.com> wrote:
>
> I think I have a hunch as to why this issue has occurred. I've had two
> btrfs partition failures, and both times it was upon resuming from
> hibernation. The key file for the encrypted swap was stored in
> /root/key-file, and the openswap hook unlocks the encrypted root,
> mounts it, reads the keyfile for the swap partition, and then unmounts
> it again. Could this action be causing the transid to be incremented
> somehow?
>

Of course. This means on-disk state is different from in-memory state
after resuming. You must not access filesystem stored in hibernation
image before resuming.

File bug report against whatever component does it.

> > /etc/initcpio/hooks/openswap
> > run_hook ()
> > {
> >     ## Optional: To avoid race conditions
> >     x=3D0;
> >     while [ ! -b /dev/mapper/cryptroot ] && [ $x -le 10 ]; do
> >        x=3D$((x+1))
> >        sleep .2
> >     done
> >     ## End of optional
> >
> >     mkdir crypto_key_device
> >     mount /dev/mapper/cryptroot crypto_key_device

What /may/ work is to mount read-only, although even in this case
btrfs may replay previous transaction. "mount -o ro,nologreplay" may
work.

> >     cryptsetup open --key-file crypto_key_device/root/key-file /dev/dis=
k/by-uuid/<UUID> swapDevice
> >     umount crypto_key_device
> > }
>
> The very first line of swsusp[1] has a big fat warning about touching
> data on the disk between suspend and resume, and in hindsight I
> imagine this action may count. The openswap hook doesn't write
> anything, but it's still accessing the disk (however, atime is
> disabled in my mount options).
>
> [1]https://www.kernel.org/doc/Documentation/power/swsusp.txt
>
> On Tue, 21 Jan 2020 at 14:51, Robbie Smith <zoqaeski@gmail.com> wrote:
> >
> > On Tue, 21 Jan 2020 at 14:05, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > >
> > >
> > >
> > > On 2020/1/21 =E4=B8=8A=E5=8D=8810:58, Robbie Smith wrote:
> > > [...]
> > > >>
> > > >> Really hard to say, there are at least 3 things related to this pr=
oblem.
> > > >>
> > > >> - Btrfs itself
> > > >> - Hibernation
> > > >> - Dm-crypt (less possible)
> > > >>
> > > >> For btrfs, if you have used kernel between version v5.2.0 and v5.2=
.15,
> > > >> then it's possible the fs is already corrupted but not detected.
> > > >>
> > > >> For the hibernation part, Linux is not the best place to utilize i=
t for
> > > >> the first place.
> > > >> (My ThinkPad X1 Carbon 6th suffers from hibernation, so I rarely u=
se
> > > >> suspension/hiberation)
> > > >>
> > > >> Since linux development is mostly server oriented, such daily cons=
umer
> > > >> operation may not be that well tested.
> > > >>
> > > >> Things like Windows updating certain firmware could break the cont=
roller
> > > >> behavior and cause unexpected behavior.
> > > >>
> > > >> So my personal recommendation is, to avoid hibernation/suspension,=
 use
> > > >> Windows as little as possible.
> > > >>
> > > >> Thanks,
> > > >> Qu
> > > >
> > > > Suspension works flawlessly for me, and hibernation usually does as
> > > > well. The one thing that has happened both times I've had a failure
> > > > has been something weird with the power: first time was a static sh=
ock
> > > > from walking on carpet and then touching the laptop, second time wa=
s
> > > > the BIOS reporting a wattage error with the charger.
> > >
> > > This doesn't look correct for ThinkPad T series machine...
> > >
> > > >
> > > > I tried mounting the FS from a live USB and the mount said: "can't
> > > > read superblock on /dev/mapper/cryptroot" in addition to the transi=
d
> > > > failures. Should I try running a `btrfs check --repair`? At this po=
int
> > > > I'm pretty much resigned to reinstalling today, so I can't make thi=
ngs
> > > > any worse, can I?
> > >
> > > Full output please.
> >
> > I can't get the output from that mount run as it's lost in the shell
> > history. Attempting to mount now does nothing and just spits out:
> > > # mount -t btrfs -o ro,usebackuproot /dev/mapper/cryptroot /mnt/crypt=
root
> > > [dmesg timestamp] BTRFS error (device dm-0): parent transid verify fa=
iled on 223452889088 wanted 144360 found 144376
> > > [dmesg timestamp] BTRFS error (device dm-0): parent transid verify fa=
iled on 223452889088 wanted 144360 found 144376
> >
> > btrfs check prints the UUID, and that's it.
> > > # btrfs check /dev/mapper/cryptroot
> > > Opening filesystem to check...
> > > Checking filesystem on /dev/mapper/cryptroot
> > > UUID: 25ac1f63-5986-4eb8-920f-ed7a5354c076
> >
> > Attempting a dry-run of btrfs restore gave me these messages. The fact
> > that it can read some files and find my /home subvolume gives me some
> > hope.
> > > # btrfs restore -D /dev/mapper/cryptroot /mnt/restore
> > > This is a dry-run, no files are going to be restored
> > > We have looped trying to restore files in /@home/robbie/.cache/chromi=
um/Default/Code Cache/js too many times to be making progress, stopping
> > > We have looped trying to restore files in /@home/robbie/.cache/chromi=
um/Default/Cache too many times to be making progress, stopping
> > > We have looped trying to restore files in /@home/robbie/.cache/chromi=
um/Profile 1/Cache too many times to be making progress, stopping
> > > We have looped trying to restore files in /@home/robbie/.cache/chromi=
um/Profile 2/Code Cache/js too many times to be making progress, stopping
> > > We have looped trying to restore files in /@home/robbie/.cache/chromi=
um/Profile 2/Cache too many times to be making progress, stopping
> > > We have looped trying to restore files in /@home/robbie/.cache/thumbn=
ails/large too many times to be making progress, stopping
> > > We have looped trying to restore files in /@home/robbie/.cache/mozill=
a/firefox/eedh8ma4.default-release/cache2/entries too many times to be maki=
ng progress, stopping
> > > We have looped trying to restore files in /@home/robbie/.config/disco=
rd/Cache too many times to be making progress, stopping
> >
> > I'm going to go get myself a new external drive, reformat it as ext4
> > or something (what would be the best filesystem to use?=E2=80=94they al=
ways
> > come out of the box as NTFS for Windows), and then try restoring my
> > filesystem to that. Maybe I can recover things before attempting a
> > `btrfs check --repair`. Worst case scenario then is that I have a few
> > corrupted files on a spare disk.
> >
> > >
> > > >
> > > > I've also used kernel between version 5.2.0 and 5.2.15 on both my
> > > > machines, so does that mean there's a risk of undetected disk error=
s
> > > > on my desktop as well?
> > >
> > > It's possible.
> > >
> > > > I don't have backups of my backups, and all my
> > > > drives use BTRFS because I like the subvolume/snapshot features. I
> > > > also don't have a backup of my music/video library because I don't
> > > > have another 5 TB HDD.
> > >
> > > You can just run "btrfs check" from a liveUSB to check if the fs is O=
K.
> > >
> > > Thanks,
> > > Qu
> > >
