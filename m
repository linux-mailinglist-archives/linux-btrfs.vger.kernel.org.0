Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0D73B4DAA
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jun 2021 10:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhFZITp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Jun 2021 04:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZITo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Jun 2021 04:19:44 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F8DC061574
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Jun 2021 01:17:20 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id k9so4554984uaq.6
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Jun 2021 01:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j/BD3SneyZrMhuiFxFtaG17kpECmR+0sDX0lphq9UaY=;
        b=tUDV2TRKf5smmZstAF8/TDfjlOCuEcO0cS8slhBMyrLaAurAwx4wKo5qkj3gYzsyl1
         OO4im+Oy0IT+6WhnDcJPsMKWw9vXsP6IXQebHvjNBo14bTSQ9aL2tnTIWN1AFoWicXsc
         XvJ12hV3/7T34TIj4cAndZEvOHvYQNnF4f9Fb5iHmBDeExWaxhXrCvd3nEQ7yKR9SEDk
         kangKh1Wo+3pawNTgYcTgJCJIlWwgjSRts5rreJFMNrP5htPPkCWTurLoHKNIIfMGn6Z
         C+8j6OqDzF3ZtaHMuW5YUtHEZbBm6QF1ss8tPFBP/eeDx3x98/DvtEvbDa24Wmikt1ju
         HGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j/BD3SneyZrMhuiFxFtaG17kpECmR+0sDX0lphq9UaY=;
        b=kvccLeDkf9931mvdrHlYSdfIOnqPiUoXaLQmy0j0OHO3mtKh2K5EFfSgy7Sx//wCAs
         M3si4nfyfWNvWbmhTQD2SGQ07ErEq3yNDVqLgHDvETk7x7CbDzRG/aRjNJR5z0C4M71l
         3gJWFtO+brcqaDZ1xWcb6aj2DqjZMWSYvQxakLet4+j3Cn3l2Tk0GxzzzlRFH0MdBVJf
         7Y66CM625Qf1iso6+UIovLHktCK9At+k9aNtcUwzXQTuIHwhBeXtDf8foKoH19yNl6Jk
         SuIf9l6IC8PBPRZ2EtKeYmgYxKd5loTKLwHi6j+YIecKstZdHi+TvolICs8aMYQWovWq
         JCrw==
X-Gm-Message-State: AOAM533BtJQPveDLjY+tr8PwfFylhhNO706j+1ZvtAiqbkB6krvvzuGw
        w32MEI6QGYhAExY28guaVllpI3Tm/9Iu+kecCPc=
X-Google-Smtp-Source: ABdhPJyZMMPHA93wunDAaX0vf5BacH4nRK9Ap51dbsN3yzzqOz6hcBEjGoW+7UXpFm1nD54U7QDXCyV0/agixHF/tZc=
X-Received: by 2002:ab0:7305:: with SMTP id v5mr15265142uao.47.1624695439948;
 Sat, 26 Jun 2021 01:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ9tZB_kPgZCsBaoOV93G9UCabdPifUxks+RH0e6RUycJ5wMCA@mail.gmail.com>
 <5yy5orgi.fsf@damenly.su> <CAJ9tZB8UjSYCmvLRJ19zyKWyXD=Qp1Am0mFPc=dY8QRgMxcPiA@mail.gmail.com>
 <900f5c2c-9058-54d4-bdc8-a32c37dd8bdc@gmx.com> <93eeea80-a5af-fc14-ec71-e111d801eff4@gmx.com>
 <CAJ9tZB8Y+yNoTQmEjuV3f9QL05+=abJ-Ue4m7iRkxAC0NDhTFw@mail.gmail.com>
 <3670289c-19fb-482f-d2ca-3c84eb5decbe@cobb.uk.net> <CAJ9tZB-7ogKcPCF=r72jJ3pvZLD3h6VfQbks-pfkB5N_yhJzTg@mail.gmail.com>
 <93bc4428-467f-9a08-0dbf-1fae8cec42dd@gmx.com> <CAJ9tZB9Zpnmkg-QTcVCHYKt8e5w4fBseZkJPGUT4wrH2zHokTg@mail.gmail.com>
 <c14fd9c7-3d4c-0498-de76-56025fe2f37b@gmx.com> <CAJ9tZB_35KKsBjXQ+qiDPv=2ffpsJnUH8JaBvp5MP3gUwVXK-A@mail.gmail.com>
 <e3df9e2f-7ae6-c3cd-766f-c881f965846b@gmx.com> <f139fbe5-1ac2-54b9-c57b-2c93724cd2e2@gmx.com>
 <265bee57-2d24-9415-fcfc-f0ddcee68eda@gmx.com> <65c221d1-86cf-1084-4d6c-bdfe717c494a@gmx.com>
 <CAJ9tZB8yMRgL6RjTCR9X4Mb_XKAkuLMnGaW4nnrj-y2XMKoapA@mail.gmail.com> <78cbf538-19ba-6fce-4bc3-aadff4e3ce7c@gmx.com>
In-Reply-To: <78cbf538-19ba-6fce-4bc3-aadff4e3ce7c@gmx.com>
From:   Zhenyu Wu <wuzy001@gmail.com>
Date:   Sat, 26 Jun 2021 16:17:08 +0800
Message-ID: <CAJ9tZB9B03NC3Rer3sd728Pd2QShuSYTX6eYFCyO7yF0V_RxuA@mail.gmail.com>
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

if i notice this situation happened again, i will report it.

Thanks!

On Sat, Jun 26, 2021 at 4:05 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/6/26 =E4=B8=8B=E5=8D=883:17, Zhenyu Wu wrote:
> > Thank you very much!
> >
> > i spend about one whole day to delete 58 ghosts and now i have about
> > 370GiB free space. now i have enough space to snapper to make
> > snapshots. without your help, it is impossible.
>
> It takes much longer than I thought, thus I guess maybe qgroup is
> heavily slowing down the process?
>
> >
> > and i want to know if this circumstance which ghosts exist will
> > happened again? i need to do the same operation to delete these
> > ghosts? thanks!
>
> Looking into the subvolume deletion code, the orphan item and subvolume
> unlink all happen inside one transaction, thus it should not be possible
> to have subvolume unlinked but no orphan item.
>
> Maybe it's some special race/corner case where we inserted orphan item
> first, but I don't have a clue yet.
>
> I guess it could be related to the btrfs-zero-log call, but I'm not
> familiar enough to log tree code thus hard to say.
>
>
> Personally speaking, it shouldn't be an easy thing to trigger such
> situation anyway.
> If it happens again, please let us know, with the history so that we
> could have a better clue.
>
> >
> > btw, if i `btrfs-corrupt-block -X /dev/sda2` again, it will
> > ```
> > $ ./btrfs-corrupt-block -X /dev/sda2
> > Root XXXX is a ghost
> > # repeat 4 times
> > Inserted orhpan item for root XXXX
> > # repeat 4 times
> > Please mount the fs and kernel will try to delete above roots
> > $ ./btrfs-corrupt-block -X /dev/sda2
> > Root XXXX is a ghost
> > # repeat 4 times
> > btrfs-corrupt-block.c:1182: mark_roots_orphan: Assertion `ret =3D=3D 0`
> > failed, value 0
> > ./btrfs-corrupt-block(main+0x78d)[0x55df0ffee925]
> > /lib64/libc.so.6(__libc_start_main+0xcd)[0x7f72c889f7ed]
> > ./btrfs-corrupt-block(_start+0x2a)[0x55df0ffe083a]
> > Aborted
> > ```
> > it will not harm my data, will it?
>
> If it crashes, it won't write anything to your fs, thus you're
> completely safe.
>
> In fact, for your case, it's btrfs_insert_empty_item(), which means the
> orphan item is already inserted, and you're completely safe.
>
> I just didn't take the error handling too series as it's just a dirty hac=
k.
>
> We should have proper btrfs check for such case soon, thanks to your
> report and test!
>
> Thanks,
> Qu
>
> > thanks!
> >
> > On Fri, Jun 25, 2021 at 1:36 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
> >>
> >>
> >>
> >> On 2021/6/25 =E4=B8=8B=E5=8D=881:28, Qu Wenruo wrote:
> >>>
> >>>
> >>> On 2021/6/25 =E4=B8=8A=E5=8D=888:59, Qu Wenruo wrote:
> >>>>
> >>>>
> >>>> On 2021/6/25 =E4=B8=8A=E5=8D=887:46, Qu Wenruo wrote:
> >>>>>
> >>>>>
> >>>>> On 2021/6/24 =E4=B8=8B=E5=8D=8810:38, Zhenyu Wu wrote:
> >>>>>> ```
> >>>>>> $ btrfs ins dump-tree -t data_reloc
> >>>>>> btrfs-progs v5.10.1
> >>>>>> data reloc tree key (DATA_RELOC_TREE ROOT_ITEM 0)
> >>>>>> leaf 57458688 items 2 free space 16061 generation 941500 owner
> >>>>>> DATA_RELOC_TREE
> >>>>>> leaf 57458688 flags 0x1(WRITTEN) backref revision 1
> >>>>>> fs uuid 644a9e91-5e05-4f5d-a79b-e0eccd21a1a8
> >>>>>> chunk uuid fa782e34-63ae-4917-ac63-bbbe56851d8b
> >>>>>> item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
> >>>>>> generation 3 transid 0 size 0 nbytes 16384
> >>>>>> block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
> >>>>>> sequence 0 flags 0x0(none)
> >>>>>> atime 1579910090.0 (2020-01-24 23:54:50)
> >>>>>> ctime 1579910090.0 (2020-01-24 23:54:50)
> >>>>>> mtime 1579910090.0 (2020-01-24 23:54:50)
> >>>>>> otime 1579910090.0 (2020-01-24 23:54:50)
> >>>>>> item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
> >>>>>> index 0 namelen 2 name: ..
> >>>>>> total bytes 499972575232
> >>>>>> bytes used 466593501184
> >>>>>> uuid 644a9e91-5e05-4f5d-a79b-e0eccd21a1a8
> >>>>>> $ btrfs ins dump-tree -t root 2>&1|tee root.txt
> >>>>>> # attachment
> >>>>>
> >>>>> This explains everything!
> >>>>>
> >>>>> There are 58 root items! Meaning all of those snapshots are still t=
aking
> >>>>> space.
> >>>>>
> >>>>> Furthermore, all those roots have no backref, meaning it's already
> >>>>> unlinked from the fs, thus btrfs subvolume list won't list them.
> >>>>>
> >>>>> For the worst part, they also have no orphan item marking them to b=
e
> >>>>> deleted.
> >>>>> Thus they all become real ghost subvolumes.
> >>>>>
> >>>>> And since qgroup rescan only create subvolumes based on its ROOT_RE=
F_KEY
> >>>>> to create 0 level qgroups, all these ghost snapshots are not create=
d,
> >>>>> causing the super weird result.
> >>>>>
> >>>>> I have no idea why this could happen, need to dig further into the =
code.
> >>>>
> >>>> A quick glance into the code, and it seems that for such ghost
> >>>> subvolumes, "btrfs subv delete -i" may not work.
> >>>>
> >>>> For that case, I'll craft you a special btrfs-progs branch so that w=
e
> >>>> can add orphan items for those ghost roots and let them go for good.
> >>>>
> >>>> Thus if above "delete -i" doesn't work, please prepare a liveUSB in
> >>>> which you can compile btrfs-progs.
> >>>
> >>> Here you go, please use the branch of btrfs-progs in LiveUSB:
> >>>
> >>> https://github.com/adam900710/btrfs-progs/tree/dirty_fixes
> >>
> >> Forgot to mention, I have tested the tool locally without problem.
> >>
> >> But even if the tool crashes by somehow, it shouldn't change any thing
> >> of your fs, so feel free to use it.
> >>
> >> After digging into the kernel code, kernel will just drop snapshots on=
e
> >> by one, thus the limit is not really needed.
> >>
> >> You can change the line of "u64 orphan_roots[4] =3D { 0 };" to
> >> "u64 orphan_roots[64] =3D { 0 }", which will cover all your ghosts roo=
ts
> >> in one go.
> >>
> >> For the formal fix, I'll enhance btrfs-check to detect and fix the
> >> problem soon, but I'm afraid you have to use the dirty fix branch for =
now.
> >>
> >> Thanks,
> >> Qu
> >>>
> >>> It enhances btrfs-progs/btrfs-corrupt-block command (I know it's scar=
y,
> >>> but trust me, I make the extra option to be extra safe).
> >>>
> >>> Now in your liveUSB, make sure your fs is not mounted first.
> >>>
> >>> Then go the following loop:
> >>>
> >>> # ./btrfs-corrupt-block -X <device>
> >>>
> >>> It will output which roots are ghosts and will add back orphan items =
for
> >>> them.
> >>>
> >>> # mount <device> <mnt>
> >>>
> >>> # btrfs subv sync <mnt>
> >>>
> >>> It will wait for the 4 subvolumes to be deleted.
> >>>
> >>> # umount <mnt>
> >>>
> >>> Then go back to "corrupt-block -X" command and continue.
> >>> I made the command to only add orphans to at most 4 subvolumes, to ma=
ke
> >>> sure we won't trigger too many deletions at the same time.
> >>>
> >>> If you don't want above loop (you need to go at least 15 loops), nor
> >>> want to craft a small script to do that, I can change the code to do =
all
> >>> of them in one go, but I'm not sure if it's OK for the kernel to hand=
le
> >>> so many orphan roots.
> >>>
> >>> BTW, since you have qgroup enabled, it will make subvolume deletion
> >>> pretty slow, it's recommended to disable qgroup first. >
> >>> Thanks,
> >>> Qu
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>>>
> >>>>> But for now, you can try to delete all these 58 subvolumes by their
> >>>>> subvolume ID.
> >>>>>
> >>>>> You can try this as a quick test:
> >>>>>
> >>>>> # btrfs subv delete -i 6317 <mnt>
> >>>>> # btrfs subv sync <mnt>
> >>>>>
> >>>>> Then check if you still have "6317 ROOT_ITEM" in your root tree dum=
p.
> >>>>>
> >>>>> If it's gone, repeat the process for all roots, I have extracted th=
e
> >>>>> root list and attached, so that you can craft a bash script to dele=
te
> >>>>> all of them.
> >>>>> (Note that above "subv sync" is not needed for each deletion if you=
 want
> >>>>> to delete them in a batch)
> >>>>>
> >>>>> Thanks,
> >>>>> Qu
> >>>>>
> >>>>>> $ btrfs ins dump-tree -t extent 2>&1|tee extent.txt
> >>>>>> # it's too large, i'll upload it to a cloud disk
> >>>>>> ```
> >>>>>>
> >>>>>> thanks!
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On Thu, Jun 24, 2021 at 8:30 PM Qu Wenruo <quwenruo.btrfs@gmx.com>
> >>>>>> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On 2021/6/24 =E4=B8=8B=E5=8D=887:33, Zhenyu Wu wrote:
> >>>>>>>> the output has changed. do i need `btrfs ins dump-tree -t root`?
> >>>>>>>> ```
> >>>>>>>> $ sudo btrfs quota disable /
> >>>>>>>> $ sudo btrfs quota enable /
> >>>>>>>> $ sudo btrfs quota rescan -w /
> >>>>>>>> # after 22m11s
> >>>>>>>> $ sudo btrfs qgroup show -pcre /
> >>>>>>>> qgroupid         rfer         excl     max_rfer     max_excl par=
ent
> >>>>>>>> child
> >>>>>>>> --------         ----         ----     --------     -------- ---=
---
> >>>>>>>> -----
> >>>>>>>> 0/5          81.23GiB      6.90GiB         none         none ---
> >>>>>>>> ---
> >>>>>>>> ```
> >>>>>>>> thanks!
> >>>>>>>
> >>>>>>> Yes, dump tree output for both root and data_reloc is needed.
> >>>>>>>
> >>>>>>> There may be a larger dump needed, "btrfs ins dump-tree -t extent
> >>>>>>> <device>", as I guess there is some ghost trees not properly
> >>>>>>> deleted at
> >>>>>>> all...
> >>>>>>>
> >>>>>>> The whole thing is going crazy now.
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> Qu
> >>>>>>>>
> >>>>>>>> On Thu, Jun 24, 2021 at 6:07 PM Qu Wenruo <quwenruo.btrfs@gmx.co=
m>
> >>>>>>>> wrote:
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> On 2021/6/24 =E4=B8=8B=E5=8D=885:52, Zhenyu Wu wrote:
> >>>>>>>>>> i have rescan quota but it looks like nothing change...
> >>>>>>>>>> ```
> >>>>>>>>>> $ sudo btrfs quota rescan -w /
> >>>>>>>>>> quota rescan started
> >>>>>>>>>> # after 8m39s
> >>>>>>>>>> $ sudo btrfs qgroup show -pcre /
> >>>>>>>>>> qgroupid         rfer         excl     max_rfer     max_excl
> >>>>>>>>>> parent   child
> >>>>>>>>>> --------         ----         ----     --------     --------
> >>>>>>>>>> ------   -----
> >>>>>>>>>> 0/5          81.23GiB      6.89GiB         none         none
> >>>>>>>>>> ---      ---
> >>>>>>>>>> 0/265           0.00B        0.00B         none         none
> >>>>>>>>>> ---      ---
> >>>>>>>>>> 0/266           0.00B        0.00B         none         none
> >>>>>>>>>> ---      ---
> >>>>>>>>>> 0/267           0.00B        0.00B         none         none
> >>>>>>>>>> ---      ---
> >>>>>>>>>> 0/6482          0.00B        0.00B         none         none
> >>>>>>>>>> ---      ---
> >>>>>>>>>> 0/7501       16.00KiB     16.00KiB         none         none
> >>>>>>>>>> ---      ---
> >>>>>>>>>> 0/7502       16.00KiB     16.00KiB         none         none
> >>>>>>>>>> 255/7502 ---
> >>>>>>>>>> 0/7503       16.00KiB     16.00KiB         none         none
> >>>>>>>>>> 255/7503 ---
> >>>>>>>>>
> >>>>>>>>> This is now getting super weird now.
> >>>>>>>>>
> >>>>>>>>> Firstly, if there are some snapshots of subvolume 5, it should
> >>>>>>>>> show up
> >>>>>>>>> here, with size over several GiB.
> >>>>>>>>>
> >>>>>>>>> Thus there seems to be some ghost/hidden subvolumes that even d=
on't
> >>>>>>>>> show
> >>>>>>>>> up in qgroup.
> >>>>>>>>>
> >>>>>>>>> It's possible that some qgroup is intentionally deleted, thus n=
ot
> >>>>>>>>> being
> >>>>>>>>> properly updated.
> >>>>>>>>>
> >>>>>>>>> For that case, you may want to disable qgroup, re-enable, then =
do a
> >>>>>>>>> rescan: (Can all be done on the running system)
> >>>>>>>>>
> >>>>>>>>> # btrfs quota disable <mnt>
> >>>>>>>>> # btrfs quota enable <mnt>
> >>>>>>>>> # btrfs quota rescan -w <mnt>
> >>>>>>>>>
> >>>>>>>>> Then provide the output of 'btrfs qgroup show -prce <mnt>"
> >>>>>>>>>
> >>>>>>>>> If the output doesn't change at all, after the full 10min resca=
n,
> >>>>>>>>> then I
> >>>>>>>>> guess you have to dump the root tree, along with the data_reloc
> >>>>>>>>> tree.
> >>>>>>>>>
> >>>>>>>>> # btrfs ins dump-tree -t root <device>
> >>>>>>>>> # btrfs ins dump-tree -t data_reloc <device>
> >>>>>>>>>
> >>>>>>>>> Thanks,
> >>>>>>>>> Qu
> >>>>>>>>>> 1/0             0.00B        0.00B         none         none
> >>>>>>>>>> ---      ---
> >>>>>>>>>> 255/7502     16.00KiB     16.00KiB         none         none
> >>>>>>>>>> ---      0/7502
> >>>>>>>>>> 255/7503     16.00KiB     16.00KiB         none         none
> >>>>>>>>>> ---      0/7503
> >>>>>>>>>> ```
> >>>>>>>>>>
> >>>>>>>>>> and i try to mount with option subvolid:
> >>>>>>>>>> ```
> >>>>>>>>>> $ mkdir /tmp/fulldisk
> >>>>>>>>>> $ sudo mount -o subvolid=3D5 /dev/sda2 /tmp/fulldisk
> >>>>>>>>>> $ ls -lA /tmp/fulldisk
> >>>>>>>>>> total 4
> >>>>>>>>>> drwxr-xr-x 1 root   root   1936 May  3 21:34 bin
> >>>>>>>>>> drwxr-xr-x 1 root   root      0 Jan 25  2020 boot
> >>>>>>>>>> drwxr-xr-x 1 root   root   1686 Jan 20  2020 dev
> >>>>>>>>>> drwxr-xr-x 1 wzy    wzy    5756 Jun 24 13:51 etc
> >>>>>>>>>> drwxr-xr-x 1 root   root     22 Oct 17  2020 home
> >>>>>>>>>> drwxr-xr-x 1 root   root   1332 May 18 14:13 lib
> >>>>>>>>>> drwxr-xr-x 1 root   root   6606 May 18 14:13 lib64
> >>>>>>>>>> lrwxrwxrwx 1 root   root     10 Jan 24 20:23 media -> /run/med=
ia
> >>>>>>>>>> drwxr-xr-x 1 wzy    wzy      38 Jan 27 16:51 mnt
> >>>>>>>>>> drwxr-xr-x 1 root   root    234 Jun 18 14:29 opt
> >>>>>>>>>> drwxr-xr-x 1 root   root      0 Jan 20  2020 proc
> >>>>>>>>>> drwx------ 1 wzy    wzy     536 Jun 15 20:26 root
> >>>>>>>>>> drwxr-xr-x 1 root   root     48 May 30 14:14 run
> >>>>>>>>>> drwxr-xr-x 1 root   root   4926 May 18 14:12 sbin
> >>>>>>>>>> drwxr-xr-x 1 root   root     10 Jan 20  2020 sys
> >>>>>>>>>> drwxrwxrwx 1 nobody nobody    0 Jun 18 14:34 tftproot
> >>>>>>>>>> drwxrwxrwt 1 root   root      0 May 30 14:25 tmp
> >>>>>>>>>> drwxr-xr-x 1 root   root    198 Mar 31 19:32 usr
> >>>>>>>>>> drwxr-xr-x 1 root   root    150 Apr  1 18:21 var
> >>>>>>>>>> $ sudo btrfs fi du -s /tmp/fulldisk/*
> >>>>>>>>>>          Total   Exclusive  Set shared  Filename
> >>>>>>>>>>       10.66MiB       0.00B    10.66MiB  /tmp/fulldisk/bin
> >>>>>>>>>>          0.00B       0.00B       0.00B  /tmp/fulldisk/boot
> >>>>>>>>>>          0.00B       0.00B       0.00B  /tmp/fulldisk/dev
> >>>>>>>>>>       33.34MiB    36.00KiB    33.30MiB  /tmp/fulldisk/etc
> >>>>>>>>>>       13.79GiB   784.05MiB    12.96GiB  /tmp/fulldisk/home
> >>>>>>>>>>      922.28MiB       0.00B   922.28MiB  /tmp/fulldisk/lib
> >>>>>>>>>>       23.11MiB       0.00B    23.11MiB  /tmp/fulldisk/lib64
> >>>>>>>>>> ERROR: cannot check space of '/tmp/fulldisk/media': Inappropri=
ate
> >>>>>>>>>> ioctl for device
> >>>>>>>>>>          0.00B       0.00B       0.00B  /tmp/fulldisk/mnt
> >>>>>>>>>>       11.08GiB       0.00B    11.08GiB  /tmp/fulldisk/opt
> >>>>>>>>>>          0.00B       0.00B       0.00B  /tmp/fulldisk/proc
> >>>>>>>>>>       40.38MiB     4.35MiB    36.03MiB  /tmp/fulldisk/root
> >>>>>>>>>>          0.00B       0.00B       0.00B  /tmp/fulldisk/run
> >>>>>>>>>>       26.62MiB       0.00B    26.62MiB  /tmp/fulldisk/sbin
> >>>>>>>>>>          0.00B       0.00B       0.00B  /tmp/fulldisk/sys
> >>>>>>>>>>          0.00B       0.00B       0.00B  /tmp/fulldisk/tftproot
> >>>>>>>>>>          0.00B       0.00B       0.00B  /tmp/fulldisk/tmp
> >>>>>>>>>>       47.22GiB     1.03GiB    46.15GiB  /tmp/fulldisk/usr
> >>>>>>>>>>        5.80GiB     4.35GiB     1.45GiB  /tmp/fulldisk/var
> >>>>>>>>>> ```
> >>>>>>>>>>
> >>>>>>>>>> because media is a symbolic link so the ERROR should be normal=
.
> >>>>>>>>>> according to `btrfs fi du` it looks like i only use about 80Gi=
B.
> >>>>>>>>>> it is
> >>>>>>>>>> too weird.
> >>>>>>>>>> thanks!
> >>>>>>>>>>
> >>>>>>>>>> On Thu, Jun 24, 2021 at 4:32 PM Graham Cobb <g.btrfs@cobb.uk.n=
et>
> >>>>>>>>>> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> On 24/06/2021 08:45, Zhenyu Wu wrote:
> >>>>>>>>>>>> Thanks! this is some information of some programs.
> >>>>>>>>>>>> ```
> >>>>>>>>>>>> # boot from liveUSB
> >>>>>>>>>>>> $ btrfs check /dev/sda2
> >>>>>>>>>>>> [1/7] checking root items
> >>>>>>>>>>>> [2/7] checking extents
> >>>>>>>>>>>> [3/7] checking free space cache
> >>>>>>>>>>>> [4/7] checking fs roots
> >>>>>>>>>>>> [5/7] checking only csums items (without verifying data)
> >>>>>>>>>>>> [6/7] checking root refs
> >>>>>>>>>>>> [7/7] checking quota groups
> >>>>>>>>>>>> # after mount /dev/sda2 to /mnt/gentoo
> >>>>>>>>>>>
> >>>>>>>>>>> Did you do 'mount -o subvolid=3D5 /dev/sda2 /mnt/gentoo' to m=
ake
> >>>>>>>>>>> sure you
> >>>>>>>>>>> can see all subvolumes, not just the default subvolume? I gue=
ss it
> >>>>>>>>>>> doesn't matter for quota, but it matters if you are using too=
ls
> >>>>>>>>>>> like du.
> >>>>>>>>>>>
> >>>>>>>>>>> You don't even need to use a liveUSB. On your normal mounted
> >>>>>>>>>>> system you
> >>>>>>>>>>> can do...
> >>>>>>>>>>>
> >>>>>>>>>>> mkdir /tmp/fulldisk
> >>>>>>>>>>> mount -o subvolid=3D5 /dev/sda2 /tmp/fulldisk
> >>>>>>>>>>> ls -lA /tmp/fulldisk
> >>>>>>>>>>>
> >>>>>>>>>>> to see if there are other subvolumes which are not visible in=
 /
