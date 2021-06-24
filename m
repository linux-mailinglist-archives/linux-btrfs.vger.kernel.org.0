Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E023B31C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jun 2021 16:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhFXOzQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Jun 2021 10:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhFXOzQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Jun 2021 10:55:16 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AB0C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Jun 2021 07:52:55 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id s194so1363973vka.5
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Jun 2021 07:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e8fp+WdktQOVB8l4r/ZJwp5t+TqlSt4IbCpq5qZGTKY=;
        b=AlEIIfW0WnAziNRkIDDaXOLlabp6aM5NvMErW3d774aOZy1J1fgICw9yVCvU5cZ3yA
         CS3I8BWQRKhp5hnK3gACsgizQWdcQOUAl47kSgC4Ks1tpacv9vTfPd/Qe6+x58cMpDP9
         OQMh3nA9GBlUneVVwaYiWzTcVVEkIE26yAIv+XFXyOpOV1vzZ0x+XKH58J2VPUukRtsq
         T6uSmak4vcg+cr+vJ+94SMFsyZpu0oAIkhlfpUJ+qMVDQoZaaYVIrUCWuLIdca0ygU61
         uPwOKUeImhkT6bSxwEl48ZJpKcnLqJxYV/sf0zV4Dl/6WFga9Ql97xr5na7AbbD33m2V
         u1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e8fp+WdktQOVB8l4r/ZJwp5t+TqlSt4IbCpq5qZGTKY=;
        b=nUjG8ilTiwtq+vyipeE1TFwvPtn+e0KgRg9KqDRnYTl54OvGj+32lNIEmaI48r9xgr
         AEHngw+PVlwvbl9wTvVgWrwYAkHZ4eNXxGbAIQcPr0vvZT0Ks5qAlNmGfXP7jBLhLSUS
         1IYeftMSaAmKY+wGAsX619whS9YtfmNoMAtST5qxxJH33bzOZ1HAg2KmLRbnLkyJDkk6
         iDXorUsls5HwHETcN6Xm4md1595mVJCMUUuIvM3CsIbPsG7jskTf/gn/wT16hesIDcN1
         3GhR7dKgEqbRGcmJEV8tR4QpWCKlqaqfobOYSAPERLv8eIRoymZylY2/RD1yKDM5G4BU
         Mopw==
X-Gm-Message-State: AOAM53028tjPRJPzD9AiX4ZnWR2ESuF2SZBvsRPE3+PyDq0MuG1c5gGl
        mOLOMaccUpyHQD1kpJ688pp/aADjHBbQNbmnTGw=
X-Google-Smtp-Source: ABdhPJxChA60RTTZC4/SU2AOVjpRVnisOhgHWKoF1sBq3CxANGpM8t+lCnDasoeczHIUyS+LHVFUGyCNrIj133a2F2w=
X-Received: by 2002:a1f:da86:: with SMTP id r128mr1861898vkg.6.1624546375004;
 Thu, 24 Jun 2021 07:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ9tZB_kPgZCsBaoOV93G9UCabdPifUxks+RH0e6RUycJ5wMCA@mail.gmail.com>
 <bl7yotou.fsf@damenly.su> <CAJ9tZB9M=KOWVLH_azagtBnxDzpV2=ssnBcYsJx6Ao8cQOELhg@mail.gmail.com>
 <5yy5orgi.fsf@damenly.su> <CAJ9tZB8UjSYCmvLRJ19zyKWyXD=Qp1Am0mFPc=dY8QRgMxcPiA@mail.gmail.com>
 <900f5c2c-9058-54d4-bdc8-a32c37dd8bdc@gmx.com> <93eeea80-a5af-fc14-ec71-e111d801eff4@gmx.com>
 <CAJ9tZB8Y+yNoTQmEjuV3f9QL05+=abJ-Ue4m7iRkxAC0NDhTFw@mail.gmail.com>
 <3670289c-19fb-482f-d2ca-3c84eb5decbe@cobb.uk.net> <CAJ9tZB-7ogKcPCF=r72jJ3pvZLD3h6VfQbks-pfkB5N_yhJzTg@mail.gmail.com>
 <93bc4428-467f-9a08-0dbf-1fae8cec42dd@gmx.com> <CAJ9tZB9Zpnmkg-QTcVCHYKt8e5w4fBseZkJPGUT4wrH2zHokTg@mail.gmail.com>
 <c14fd9c7-3d4c-0498-de76-56025fe2f37b@gmx.com> <CAJ9tZB_35KKsBjXQ+qiDPv=2ffpsJnUH8JaBvp5MP3gUwVXK-A@mail.gmail.com>
In-Reply-To: <CAJ9tZB_35KKsBjXQ+qiDPv=2ffpsJnUH8JaBvp5MP3gUwVXK-A@mail.gmail.com>
From:   Zhenyu Wu <wuzy001@gmail.com>
Date:   Thu, 24 Jun 2021 22:52:43 +0800
Message-ID: <CAJ9tZB_aVaBue9WTncNe3nObao_D0q-=9Mkmn=0=pPf92tm8gQ@mail.gmail.com>
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

the extent.txt has been uploaded to <https://share.weiyun.com/1G0Vkvv5>

thanks!

On Thu, Jun 24, 2021 at 10:38 PM Zhenyu Wu <wuzy001@gmail.com> wrote:
>
> ```
> $ btrfs ins dump-tree -t data_reloc
> btrfs-progs v5.10.1
> data reloc tree key (DATA_RELOC_TREE ROOT_ITEM 0)
> leaf 57458688 items 2 free space 16061 generation 941500 owner DATA_RELOC=
_TREE
> leaf 57458688 flags 0x1(WRITTEN) backref revision 1
> fs uuid 644a9e91-5e05-4f5d-a79b-e0eccd21a1a8
> chunk uuid fa782e34-63ae-4917-ac63-bbbe56851d8b
> item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
> generation 3 transid 0 size 0 nbytes 16384
> block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
> sequence 0 flags 0x0(none)
> atime 1579910090.0 (2020-01-24 23:54:50)
> ctime 1579910090.0 (2020-01-24 23:54:50)
> mtime 1579910090.0 (2020-01-24 23:54:50)
> otime 1579910090.0 (2020-01-24 23:54:50)
> item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
> index 0 namelen 2 name: ..
> total bytes 499972575232
> bytes used 466593501184
> uuid 644a9e91-5e05-4f5d-a79b-e0eccd21a1a8
> $ btrfs ins dump-tree -t root 2>&1|tee root.txt
> # attachment
> $ btrfs ins dump-tree -t extent 2>&1|tee extent.txt
> # it's too large, i'll upload it to a cloud disk
> ```
>
> thanks!
>
>
>
> On Thu, Jun 24, 2021 at 8:30 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >
> >
> >
> > On 2021/6/24 =E4=B8=8B=E5=8D=887:33, Zhenyu Wu wrote:
> > > the output has changed. do i need `btrfs ins dump-tree -t root`?
> > > ```
> > > $ sudo btrfs quota disable /
> > > $ sudo btrfs quota enable /
> > > $ sudo btrfs quota rescan -w /
> > > # after 22m11s
> > > $ sudo btrfs qgroup show -pcre /
> > > qgroupid         rfer         excl     max_rfer     max_excl parent  =
child
> > > --------         ----         ----     --------     -------- ------  =
-----
> > > 0/5          81.23GiB      6.90GiB         none         none ---     =
---
> > > ```
> > > thanks!
> >
> > Yes, dump tree output for both root and data_reloc is needed.
> >
> > There may be a larger dump needed, "btrfs ins dump-tree -t extent
> > <device>", as I guess there is some ghost trees not properly deleted at
> > all...
> >
> > The whole thing is going crazy now.
> >
> > Thanks,
> > Qu
> > >
> > > On Thu, Jun 24, 2021 at 6:07 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
> > >>
> > >>
> > >>
> > >> On 2021/6/24 =E4=B8=8B=E5=8D=885:52, Zhenyu Wu wrote:
> > >>> i have rescan quota but it looks like nothing change...
> > >>> ```
> > >>> $ sudo btrfs quota rescan -w /
> > >>> quota rescan started
> > >>> # after 8m39s
> > >>> $ sudo btrfs qgroup show -pcre /
> > >>> qgroupid         rfer         excl     max_rfer     max_excl parent=
   child
> > >>> --------         ----         ----     --------     -------- ------=
   -----
> > >>> 0/5          81.23GiB      6.89GiB         none         none ---   =
   ---
> > >>> 0/265           0.00B        0.00B         none         none ---   =
   ---
> > >>> 0/266           0.00B        0.00B         none         none ---   =
   ---
> > >>> 0/267           0.00B        0.00B         none         none ---   =
   ---
> > >>> 0/6482          0.00B        0.00B         none         none ---   =
   ---
> > >>> 0/7501       16.00KiB     16.00KiB         none         none ---   =
   ---
> > >>> 0/7502       16.00KiB     16.00KiB         none         none 255/75=
02 ---
> > >>> 0/7503       16.00KiB     16.00KiB         none         none 255/75=
03 ---
> > >>
> > >> This is now getting super weird now.
> > >>
> > >> Firstly, if there are some snapshots of subvolume 5, it should show =
up
> > >> here, with size over several GiB.
> > >>
> > >> Thus there seems to be some ghost/hidden subvolumes that even don't =
show
> > >> up in qgroup.
> > >>
> > >> It's possible that some qgroup is intentionally deleted, thus not be=
ing
> > >> properly updated.
> > >>
> > >> For that case, you may want to disable qgroup, re-enable, then do a
> > >> rescan: (Can all be done on the running system)
> > >>
> > >> # btrfs quota disable <mnt>
> > >> # btrfs quota enable <mnt>
> > >> # btrfs quota rescan -w <mnt>
> > >>
> > >> Then provide the output of 'btrfs qgroup show -prce <mnt>"
> > >>
> > >> If the output doesn't change at all, after the full 10min rescan, th=
en I
> > >> guess you have to dump the root tree, along with the data_reloc tree=
.
> > >>
> > >> # btrfs ins dump-tree -t root <device>
> > >> # btrfs ins dump-tree -t data_reloc <device>
> > >>
> > >> Thanks,
> > >> Qu
> > >>> 1/0             0.00B        0.00B         none         none ---   =
   ---
> > >>> 255/7502     16.00KiB     16.00KiB         none         none ---   =
   0/7502
> > >>> 255/7503     16.00KiB     16.00KiB         none         none ---   =
   0/7503
> > >>> ```
> > >>>
> > >>> and i try to mount with option subvolid:
> > >>> ```
> > >>> $ mkdir /tmp/fulldisk
> > >>> $ sudo mount -o subvolid=3D5 /dev/sda2 /tmp/fulldisk
> > >>> $ ls -lA /tmp/fulldisk
> > >>> total 4
> > >>> drwxr-xr-x 1 root   root   1936 May  3 21:34 bin
> > >>> drwxr-xr-x 1 root   root      0 Jan 25  2020 boot
> > >>> drwxr-xr-x 1 root   root   1686 Jan 20  2020 dev
> > >>> drwxr-xr-x 1 wzy    wzy    5756 Jun 24 13:51 etc
> > >>> drwxr-xr-x 1 root   root     22 Oct 17  2020 home
> > >>> drwxr-xr-x 1 root   root   1332 May 18 14:13 lib
> > >>> drwxr-xr-x 1 root   root   6606 May 18 14:13 lib64
> > >>> lrwxrwxrwx 1 root   root     10 Jan 24 20:23 media -> /run/media
> > >>> drwxr-xr-x 1 wzy    wzy      38 Jan 27 16:51 mnt
> > >>> drwxr-xr-x 1 root   root    234 Jun 18 14:29 opt
> > >>> drwxr-xr-x 1 root   root      0 Jan 20  2020 proc
> > >>> drwx------ 1 wzy    wzy     536 Jun 15 20:26 root
> > >>> drwxr-xr-x 1 root   root     48 May 30 14:14 run
> > >>> drwxr-xr-x 1 root   root   4926 May 18 14:12 sbin
> > >>> drwxr-xr-x 1 root   root     10 Jan 20  2020 sys
> > >>> drwxrwxrwx 1 nobody nobody    0 Jun 18 14:34 tftproot
> > >>> drwxrwxrwt 1 root   root      0 May 30 14:25 tmp
> > >>> drwxr-xr-x 1 root   root    198 Mar 31 19:32 usr
> > >>> drwxr-xr-x 1 root   root    150 Apr  1 18:21 var
> > >>> $ sudo btrfs fi du -s /tmp/fulldisk/*
> > >>>        Total   Exclusive  Set shared  Filename
> > >>>     10.66MiB       0.00B    10.66MiB  /tmp/fulldisk/bin
> > >>>        0.00B       0.00B       0.00B  /tmp/fulldisk/boot
> > >>>        0.00B       0.00B       0.00B  /tmp/fulldisk/dev
> > >>>     33.34MiB    36.00KiB    33.30MiB  /tmp/fulldisk/etc
> > >>>     13.79GiB   784.05MiB    12.96GiB  /tmp/fulldisk/home
> > >>>    922.28MiB       0.00B   922.28MiB  /tmp/fulldisk/lib
> > >>>     23.11MiB       0.00B    23.11MiB  /tmp/fulldisk/lib64
> > >>> ERROR: cannot check space of '/tmp/fulldisk/media': Inappropriate
> > >>> ioctl for device
> > >>>        0.00B       0.00B       0.00B  /tmp/fulldisk/mnt
> > >>>     11.08GiB       0.00B    11.08GiB  /tmp/fulldisk/opt
> > >>>        0.00B       0.00B       0.00B  /tmp/fulldisk/proc
> > >>>     40.38MiB     4.35MiB    36.03MiB  /tmp/fulldisk/root
> > >>>        0.00B       0.00B       0.00B  /tmp/fulldisk/run
> > >>>     26.62MiB       0.00B    26.62MiB  /tmp/fulldisk/sbin
> > >>>        0.00B       0.00B       0.00B  /tmp/fulldisk/sys
> > >>>        0.00B       0.00B       0.00B  /tmp/fulldisk/tftproot
> > >>>        0.00B       0.00B       0.00B  /tmp/fulldisk/tmp
> > >>>     47.22GiB     1.03GiB    46.15GiB  /tmp/fulldisk/usr
> > >>>      5.80GiB     4.35GiB     1.45GiB  /tmp/fulldisk/var
> > >>> ```
> > >>>
> > >>> because media is a symbolic link so the ERROR should be normal.
> > >>> according to `btrfs fi du` it looks like i only use about 80GiB. it=
 is
> > >>> too weird.
> > >>> thanks!
> > >>>
> > >>> On Thu, Jun 24, 2021 at 4:32 PM Graham Cobb <g.btrfs@cobb.uk.net> w=
rote:
> > >>>>
> > >>>> On 24/06/2021 08:45, Zhenyu Wu wrote:
> > >>>>> Thanks! this is some information of some programs.
> > >>>>> ```
> > >>>>> # boot from liveUSB
> > >>>>> $ btrfs check /dev/sda2
> > >>>>> [1/7] checking root items
> > >>>>> [2/7] checking extents
> > >>>>> [3/7] checking free space cache
> > >>>>> [4/7] checking fs roots
> > >>>>> [5/7] checking only csums items (without verifying data)
> > >>>>> [6/7] checking root refs
> > >>>>> [7/7] checking quota groups
> > >>>>> # after mount /dev/sda2 to /mnt/gentoo
> > >>>>
> > >>>> Did you do 'mount -o subvolid=3D5 /dev/sda2 /mnt/gentoo' to make s=
ure you
> > >>>> can see all subvolumes, not just the default subvolume? I guess it
> > >>>> doesn't matter for quota, but it matters if you are using tools li=
ke du.
> > >>>>
> > >>>> You don't even need to use a liveUSB. On your normal mounted syste=
m you
> > >>>> can do...
> > >>>>
> > >>>> mkdir /tmp/fulldisk
> > >>>> mount -o subvolid=3D5 /dev/sda2 /tmp/fulldisk
> > >>>> ls -lA /tmp/fulldisk
> > >>>>
> > >>>> to see if there are other subvolumes which are not visible in /
