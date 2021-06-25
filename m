Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39EF3B3C43
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jun 2021 07:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhFYFce (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Jun 2021 01:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbhFYFce (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Jun 2021 01:32:34 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BEFC061756
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Jun 2021 22:30:13 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id d7so1841307vkf.2
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Jun 2021 22:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qzbMQRjI0JLdtYGhTZsNjo53aIeU9l0ctc6bntYCLF0=;
        b=uXzUelZ3Pi9mFdbfWtvY0jnvIqYN5zKJZ4XOBL8nxJD30fCnbENT0qtBqQFvLNcvgE
         +BbWfz0F12Rzt7R3zkVppoBrFDPirv1pXHpaR/aT+IoFE+rrIGrAKhe/Zlyhzolx0mk2
         wI9SOUgWfOjjN3eYNKgvbG8D51F37H+mdpS+zaDPfIRNWSmSJmfkO4A5DwJNw8piR9l/
         y1XOMGtqpQZk6x4+Q8qH3ZVS8+J/i3635dgT2wvBZNzR9LKjfV1Jv8dOsB6yLWeMAD9O
         OAKvU3gxqOZ7mr6XBGNbzoQ5EFn70uz+iseiN9GKYmxl1V331UAZqo7p2Hpgn0Bv234r
         KoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qzbMQRjI0JLdtYGhTZsNjo53aIeU9l0ctc6bntYCLF0=;
        b=OQB1Ciqpsf311P+nT+U2BWPQ4kvgnFbrhTKrU7/xg54HAr9iS2tt4BWb6Ka0G6wi0a
         nGdZyFtZuroj+iB2qSF7bDYWyYH3yYOYiv6cACK1cS9FSrjs2ho7NbjS1Mo8fCFuoum2
         SjkqulGMULUWUD2zKxqM+LgLF+hTEP6VDJg50LKU+KXQ9H0xwJXdFN5dLIsrzJBzNGI2
         CMImWezpwraq6YFFNyi3l4gbdPMYlPlEkKuSR3dIvxISDEXyPjEYlV4+oRfcIvaqr3KX
         za4VyBD3ay6/hsTAOqYj22FH1Czh4DQ9toVZAIF985IATBSYaoUOa3jQ+NTMdR4IVjSu
         t/LQ==
X-Gm-Message-State: AOAM531AczbZO/uWLG0ainJl0nHUg19850S24C0uYOSZ6RPlO50uqVVn
        x3sUXGbsjJjfBvJUXG+AdiZaLRaV3BbEj+fGyB0=
X-Google-Smtp-Source: ABdhPJwZfXvFRQmYXI6wYgfw8K/LbHHZNhSh2nqwR7VUkOS1+zsmErpNu/t0OH/hz3uHgHrANJ6ZMlSuYETlOW/VBII=
X-Received: by 2002:ac5:c4c1:: with SMTP id a1mr6372638vkl.18.1624599012139;
 Thu, 24 Jun 2021 22:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ9tZB_kPgZCsBaoOV93G9UCabdPifUxks+RH0e6RUycJ5wMCA@mail.gmail.com>
 <bl7yotou.fsf@damenly.su> <CAJ9tZB9M=KOWVLH_azagtBnxDzpV2=ssnBcYsJx6Ao8cQOELhg@mail.gmail.com>
 <5yy5orgi.fsf@damenly.su> <CAJ9tZB8UjSYCmvLRJ19zyKWyXD=Qp1Am0mFPc=dY8QRgMxcPiA@mail.gmail.com>
 <900f5c2c-9058-54d4-bdc8-a32c37dd8bdc@gmx.com> <93eeea80-a5af-fc14-ec71-e111d801eff4@gmx.com>
 <CAJ9tZB8Y+yNoTQmEjuV3f9QL05+=abJ-Ue4m7iRkxAC0NDhTFw@mail.gmail.com>
 <3670289c-19fb-482f-d2ca-3c84eb5decbe@cobb.uk.net> <CAJ9tZB-7ogKcPCF=r72jJ3pvZLD3h6VfQbks-pfkB5N_yhJzTg@mail.gmail.com>
 <93bc4428-467f-9a08-0dbf-1fae8cec42dd@gmx.com> <CAJ9tZB9Zpnmkg-QTcVCHYKt8e5w4fBseZkJPGUT4wrH2zHokTg@mail.gmail.com>
 <c14fd9c7-3d4c-0498-de76-56025fe2f37b@gmx.com> <CAJ9tZB_35KKsBjXQ+qiDPv=2ffpsJnUH8JaBvp5MP3gUwVXK-A@mail.gmail.com>
 <e3df9e2f-7ae6-c3cd-766f-c881f965846b@gmx.com> <f139fbe5-1ac2-54b9-c57b-2c93724cd2e2@gmx.com>
In-Reply-To: <f139fbe5-1ac2-54b9-c57b-2c93724cd2e2@gmx.com>
From:   Zhenyu Wu <wuzy001@gmail.com>
Date:   Fri, 25 Jun 2021 13:30:00 +0800
Message-ID: <CAJ9tZB-G7KZkxGfrADbmHruuEfwyhV1bihUvRZrJ_ypt_iUVKg@mail.gmail.com>
Subject: Re: [question] free space of disk with btrfs is too different from
 other du
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Graham Cobb <g.btrfs@cobb.uk.net>, Su Yue <l@damenly.su>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

you are right. `btrfs subv delete -i` cannot work:
```
btrfs subv delete -i 6317 /mnt/gentoo
ERROR: Subvolume not found: No such file or directory
```

after `btrfs subv sync`, the subvolume 6317 still exists...

thanks!

On Fri, Jun 25, 2021 at 9:00 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/6/25 =E4=B8=8A=E5=8D=887:46, Qu Wenruo wrote:
> >
> >
> > On 2021/6/24 =E4=B8=8B=E5=8D=8810:38, Zhenyu Wu wrote:
> >> ```
> >> $ btrfs ins dump-tree -t data_reloc
> >> btrfs-progs v5.10.1
> >> data reloc tree key (DATA_RELOC_TREE ROOT_ITEM 0)
> >> leaf 57458688 items 2 free space 16061 generation 941500 owner
> >> DATA_RELOC_TREE
> >> leaf 57458688 flags 0x1(WRITTEN) backref revision 1
> >> fs uuid 644a9e91-5e05-4f5d-a79b-e0eccd21a1a8
> >> chunk uuid fa782e34-63ae-4917-ac63-bbbe56851d8b
> >> item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
> >> generation 3 transid 0 size 0 nbytes 16384
> >> block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
> >> sequence 0 flags 0x0(none)
> >> atime 1579910090.0 (2020-01-24 23:54:50)
> >> ctime 1579910090.0 (2020-01-24 23:54:50)
> >> mtime 1579910090.0 (2020-01-24 23:54:50)
> >> otime 1579910090.0 (2020-01-24 23:54:50)
> >> item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
> >> index 0 namelen 2 name: ..
> >> total bytes 499972575232
> >> bytes used 466593501184
> >> uuid 644a9e91-5e05-4f5d-a79b-e0eccd21a1a8
> >> $ btrfs ins dump-tree -t root 2>&1|tee root.txt
> >> # attachment
> >
> > This explains everything!
> >
> > There are 58 root items! Meaning all of those snapshots are still takin=
g
> > space.
> >
> > Furthermore, all those roots have no backref, meaning it's already
> > unlinked from the fs, thus btrfs subvolume list won't list them.
> >
> > For the worst part, they also have no orphan item marking them to be
> > deleted.
> > Thus they all become real ghost subvolumes.
> >
> > And since qgroup rescan only create subvolumes based on its ROOT_REF_KE=
Y
> > to create 0 level qgroups, all these ghost snapshots are not created,
> > causing the super weird result.
> >
> > I have no idea why this could happen, need to dig further into the code=
.
>
> A quick glance into the code, and it seems that for such ghost
> subvolumes, "btrfs subv delete -i" may not work.
>
> For that case, I'll craft you a special btrfs-progs branch so that we
> can add orphan items for those ghost roots and let them go for good.
>
> Thus if above "delete -i" doesn't work, please prepare a liveUSB in
> which you can compile btrfs-progs.
>
> Thanks,
> Qu
> >
> > But for now, you can try to delete all these 58 subvolumes by their
> > subvolume ID.
> >
> > You can try this as a quick test:
> >
> > # btrfs subv delete -i 6317 <mnt>
> > # btrfs subv sync <mnt>
> >
> > Then check if you still have "6317 ROOT_ITEM" in your root tree dump.
> >
> > If it's gone, repeat the process for all roots, I have extracted the
> > root list and attached, so that you can craft a bash script to delete
> > all of them.
> > (Note that above "subv sync" is not needed for each deletion if you wan=
t
> > to delete them in a batch)
> >
> > Thanks,
> > Qu
> >
> >> $ btrfs ins dump-tree -t extent 2>&1|tee extent.txt
> >> # it's too large, i'll upload it to a cloud disk
> >> ```
> >>
> >> thanks!
> >>
> >>
> >>
> >> On Thu, Jun 24, 2021 at 8:30 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
> >>>
> >>>
> >>>
> >>> On 2021/6/24 =E4=B8=8B=E5=8D=887:33, Zhenyu Wu wrote:
> >>>> the output has changed. do i need `btrfs ins dump-tree -t root`?
> >>>> ```
> >>>> $ sudo btrfs quota disable /
> >>>> $ sudo btrfs quota enable /
> >>>> $ sudo btrfs quota rescan -w /
> >>>> # after 22m11s
> >>>> $ sudo btrfs qgroup show -pcre /
> >>>> qgroupid         rfer         excl     max_rfer     max_excl parent
> >>>> child
> >>>> --------         ----         ----     --------     -------- ------
> >>>> -----
> >>>> 0/5          81.23GiB      6.90GiB         none         none ---
> >>>> ---
> >>>> ```
> >>>> thanks!
> >>>
> >>> Yes, dump tree output for both root and data_reloc is needed.
> >>>
> >>> There may be a larger dump needed, "btrfs ins dump-tree -t extent
> >>> <device>", as I guess there is some ghost trees not properly deleted =
at
> >>> all...
> >>>
> >>> The whole thing is going crazy now.
> >>>
> >>> Thanks,
> >>> Qu
> >>>>
> >>>> On Thu, Jun 24, 2021 at 6:07 PM Qu Wenruo <quwenruo.btrfs@gmx.com>
> >>>> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 2021/6/24 =E4=B8=8B=E5=8D=885:52, Zhenyu Wu wrote:
> >>>>>> i have rescan quota but it looks like nothing change...
> >>>>>> ```
> >>>>>> $ sudo btrfs quota rescan -w /
> >>>>>> quota rescan started
> >>>>>> # after 8m39s
> >>>>>> $ sudo btrfs qgroup show -pcre /
> >>>>>> qgroupid         rfer         excl     max_rfer     max_excl
> >>>>>> parent   child
> >>>>>> --------         ----         ----     --------     --------
> >>>>>> ------   -----
> >>>>>> 0/5          81.23GiB      6.89GiB         none         none
> >>>>>> ---      ---
> >>>>>> 0/265           0.00B        0.00B         none         none
> >>>>>> ---      ---
> >>>>>> 0/266           0.00B        0.00B         none         none
> >>>>>> ---      ---
> >>>>>> 0/267           0.00B        0.00B         none         none
> >>>>>> ---      ---
> >>>>>> 0/6482          0.00B        0.00B         none         none
> >>>>>> ---      ---
> >>>>>> 0/7501       16.00KiB     16.00KiB         none         none
> >>>>>> ---      ---
> >>>>>> 0/7502       16.00KiB     16.00KiB         none         none
> >>>>>> 255/7502 ---
> >>>>>> 0/7503       16.00KiB     16.00KiB         none         none
> >>>>>> 255/7503 ---
> >>>>>
> >>>>> This is now getting super weird now.
> >>>>>
> >>>>> Firstly, if there are some snapshots of subvolume 5, it should show=
 up
> >>>>> here, with size over several GiB.
> >>>>>
> >>>>> Thus there seems to be some ghost/hidden subvolumes that even don't
> >>>>> show
> >>>>> up in qgroup.
> >>>>>
> >>>>> It's possible that some qgroup is intentionally deleted, thus not
> >>>>> being
> >>>>> properly updated.
> >>>>>
> >>>>> For that case, you may want to disable qgroup, re-enable, then do a
> >>>>> rescan: (Can all be done on the running system)
> >>>>>
> >>>>> # btrfs quota disable <mnt>
> >>>>> # btrfs quota enable <mnt>
> >>>>> # btrfs quota rescan -w <mnt>
> >>>>>
> >>>>> Then provide the output of 'btrfs qgroup show -prce <mnt>"
> >>>>>
> >>>>> If the output doesn't change at all, after the full 10min rescan,
> >>>>> then I
> >>>>> guess you have to dump the root tree, along with the data_reloc tre=
e.
> >>>>>
> >>>>> # btrfs ins dump-tree -t root <device>
> >>>>> # btrfs ins dump-tree -t data_reloc <device>
> >>>>>
> >>>>> Thanks,
> >>>>> Qu
> >>>>>> 1/0             0.00B        0.00B         none         none
> >>>>>> ---      ---
> >>>>>> 255/7502     16.00KiB     16.00KiB         none         none
> >>>>>> ---      0/7502
> >>>>>> 255/7503     16.00KiB     16.00KiB         none         none
> >>>>>> ---      0/7503
> >>>>>> ```
> >>>>>>
> >>>>>> and i try to mount with option subvolid:
> >>>>>> ```
> >>>>>> $ mkdir /tmp/fulldisk
> >>>>>> $ sudo mount -o subvolid=3D5 /dev/sda2 /tmp/fulldisk
> >>>>>> $ ls -lA /tmp/fulldisk
> >>>>>> total 4
> >>>>>> drwxr-xr-x 1 root   root   1936 May  3 21:34 bin
> >>>>>> drwxr-xr-x 1 root   root      0 Jan 25  2020 boot
> >>>>>> drwxr-xr-x 1 root   root   1686 Jan 20  2020 dev
> >>>>>> drwxr-xr-x 1 wzy    wzy    5756 Jun 24 13:51 etc
> >>>>>> drwxr-xr-x 1 root   root     22 Oct 17  2020 home
> >>>>>> drwxr-xr-x 1 root   root   1332 May 18 14:13 lib
> >>>>>> drwxr-xr-x 1 root   root   6606 May 18 14:13 lib64
> >>>>>> lrwxrwxrwx 1 root   root     10 Jan 24 20:23 media -> /run/media
> >>>>>> drwxr-xr-x 1 wzy    wzy      38 Jan 27 16:51 mnt
> >>>>>> drwxr-xr-x 1 root   root    234 Jun 18 14:29 opt
> >>>>>> drwxr-xr-x 1 root   root      0 Jan 20  2020 proc
> >>>>>> drwx------ 1 wzy    wzy     536 Jun 15 20:26 root
> >>>>>> drwxr-xr-x 1 root   root     48 May 30 14:14 run
> >>>>>> drwxr-xr-x 1 root   root   4926 May 18 14:12 sbin
> >>>>>> drwxr-xr-x 1 root   root     10 Jan 20  2020 sys
> >>>>>> drwxrwxrwx 1 nobody nobody    0 Jun 18 14:34 tftproot
> >>>>>> drwxrwxrwt 1 root   root      0 May 30 14:25 tmp
> >>>>>> drwxr-xr-x 1 root   root    198 Mar 31 19:32 usr
> >>>>>> drwxr-xr-x 1 root   root    150 Apr  1 18:21 var
> >>>>>> $ sudo btrfs fi du -s /tmp/fulldisk/*
> >>>>>>         Total   Exclusive  Set shared  Filename
> >>>>>>      10.66MiB       0.00B    10.66MiB  /tmp/fulldisk/bin
> >>>>>>         0.00B       0.00B       0.00B  /tmp/fulldisk/boot
> >>>>>>         0.00B       0.00B       0.00B  /tmp/fulldisk/dev
> >>>>>>      33.34MiB    36.00KiB    33.30MiB  /tmp/fulldisk/etc
> >>>>>>      13.79GiB   784.05MiB    12.96GiB  /tmp/fulldisk/home
> >>>>>>     922.28MiB       0.00B   922.28MiB  /tmp/fulldisk/lib
> >>>>>>      23.11MiB       0.00B    23.11MiB  /tmp/fulldisk/lib64
> >>>>>> ERROR: cannot check space of '/tmp/fulldisk/media': Inappropriate
> >>>>>> ioctl for device
> >>>>>>         0.00B       0.00B       0.00B  /tmp/fulldisk/mnt
> >>>>>>      11.08GiB       0.00B    11.08GiB  /tmp/fulldisk/opt
> >>>>>>         0.00B       0.00B       0.00B  /tmp/fulldisk/proc
> >>>>>>      40.38MiB     4.35MiB    36.03MiB  /tmp/fulldisk/root
> >>>>>>         0.00B       0.00B       0.00B  /tmp/fulldisk/run
> >>>>>>      26.62MiB       0.00B    26.62MiB  /tmp/fulldisk/sbin
> >>>>>>         0.00B       0.00B       0.00B  /tmp/fulldisk/sys
> >>>>>>         0.00B       0.00B       0.00B  /tmp/fulldisk/tftproot
> >>>>>>         0.00B       0.00B       0.00B  /tmp/fulldisk/tmp
> >>>>>>      47.22GiB     1.03GiB    46.15GiB  /tmp/fulldisk/usr
> >>>>>>       5.80GiB     4.35GiB     1.45GiB  /tmp/fulldisk/var
> >>>>>> ```
> >>>>>>
> >>>>>> because media is a symbolic link so the ERROR should be normal.
> >>>>>> according to `btrfs fi du` it looks like i only use about 80GiB.
> >>>>>> it is
> >>>>>> too weird.
> >>>>>> thanks!
> >>>>>>
> >>>>>> On Thu, Jun 24, 2021 at 4:32 PM Graham Cobb <g.btrfs@cobb.uk.net>
> >>>>>> wrote:
> >>>>>>>
> >>>>>>> On 24/06/2021 08:45, Zhenyu Wu wrote:
> >>>>>>>> Thanks! this is some information of some programs.
> >>>>>>>> ```
> >>>>>>>> # boot from liveUSB
> >>>>>>>> $ btrfs check /dev/sda2
> >>>>>>>> [1/7] checking root items
> >>>>>>>> [2/7] checking extents
> >>>>>>>> [3/7] checking free space cache
> >>>>>>>> [4/7] checking fs roots
> >>>>>>>> [5/7] checking only csums items (without verifying data)
> >>>>>>>> [6/7] checking root refs
> >>>>>>>> [7/7] checking quota groups
> >>>>>>>> # after mount /dev/sda2 to /mnt/gentoo
> >>>>>>>
> >>>>>>> Did you do 'mount -o subvolid=3D5 /dev/sda2 /mnt/gentoo' to make
> >>>>>>> sure you
> >>>>>>> can see all subvolumes, not just the default subvolume? I guess i=
t
> >>>>>>> doesn't matter for quota, but it matters if you are using tools
> >>>>>>> like du.
> >>>>>>>
> >>>>>>> You don't even need to use a liveUSB. On your normal mounted
> >>>>>>> system you
> >>>>>>> can do...
> >>>>>>>
> >>>>>>> mkdir /tmp/fulldisk
> >>>>>>> mount -o subvolid=3D5 /dev/sda2 /tmp/fulldisk
> >>>>>>> ls -lA /tmp/fulldisk
> >>>>>>>
> >>>>>>> to see if there are other subvolumes which are not visible in /
