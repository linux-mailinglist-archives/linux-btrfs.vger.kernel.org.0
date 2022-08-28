Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8565A3E06
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Aug 2022 16:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiH1O0f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Aug 2022 10:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1O0d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Aug 2022 10:26:33 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821C31D0E1
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Aug 2022 07:26:32 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id n124so7737234oih.7
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Aug 2022 07:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=LiNqOZxEpwACEQxYK5reKWLLmE1WjVOna1G/RFvai90=;
        b=lsphqf+zh7zqXCp7rmMPwaEm/8zJb0N0I7EG9msNF/AIE46Zq4CT5DsWQqTvlXQDz5
         1q8E0BMW15cl2j3F/LH1fpIQOL6GUVp5vt+4gvs1j+GHiZknn6yg0Q5oCofYFayLEvTI
         ItwVncPKXe+lDYWA+PLl/Hr059Fvd/pW7xL719FhcO0KpTwYmtuxBeey1ogqMQsSo1MF
         T4yfutV2qDuvSGDRHjnN7pGT8N4IDd3sOGWxxwRh2VIx1SvH70wBfJ/zdYoBekzHQHmA
         tcwzg8wifO1CkT+urzIfjAFE9Sdmu38NtRkIxwJgqhpbYwbtiVg1VFS3J0bOHoP3WBFa
         OPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=LiNqOZxEpwACEQxYK5reKWLLmE1WjVOna1G/RFvai90=;
        b=6JM2Rhqvwx0acZNZuBY1pHTU5ALhZbCIYfyMM1olQiGQXtlxulzLGJ/irROHavZpjE
         CkQHncm0j1LmmC5rh69seMTRe85ZnAhEW6WnebpoAHHXGbM/nCvmdZUfybG81zfJzVVo
         KhJgXAtAUE6uhiV9GckvjvEhJgD6Fy2y05In1Vm9fDsN3RSWaheCxPDIChvP+yJOOTfP
         Q96Dj5oiTMPwKeDaV4XtGr153bxN4ExJNpANDdxlj/2ZJQyPOI0/okK0iGdF9vueI9w3
         wfYim8J3lMQTIl8M+DrvjM1RbciGHNoj34hi/3s+xGYP0q5KtmG6xWhzr5vbOHRCL55u
         pgZw==
X-Gm-Message-State: ACgBeo0nbsX3HXv/ewcM9qskpvDCkJmwTcNSjqS265IiVaTcUxFf2bj7
        L4p2B5BZIunZotebpQ7TfBlRom5bAfZi44h2EruRbCYoQV0LiA==
X-Google-Smtp-Source: AA6agR74vWGlv7bSJRdpOr6+3mihnURFdl9g+kKD/OcoNUb/BbTPATfDWACWWTFGRrgUFjNDaCj3V/KQxSMCpSOHKks=
X-Received: by 2002:a05:6808:209c:b0:345:c3ec:639c with SMTP id
 s28-20020a056808209c00b00345c3ec639cmr3989007oiw.42.1661696791804; Sun, 28
 Aug 2022 07:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <1661357103-22735-1-git-send-email-zhanglikernel@gmail.com>
 <c3dc352c-8393-c564-4366-42fb9ece021e@gmx.com> <PH0PR04MB7416B660C501F73F47E7D4159B729@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAAa-AGk67Ex8woPz=F-P-GdsY1i2N0w==AP9Bk2YpH=Yk+vPdg@mail.gmail.com> <76515426-abd4-2ed7-ea58-db1ba7e3a123@gmx.com>
In-Reply-To: <76515426-abd4-2ed7-ea58-db1ba7e3a123@gmx.com>
From:   li zhang <zhanglikernel@gmail.com>
Date:   Sun, 28 Aug 2022 22:26:20 +0800
Message-ID: <CAAa-AGnBSR7RKbzZBz-J5S92qcO4HGe09cL-ZsVwJf9oyri1xg@mail.gmail.com>
Subject: Re: [PATCH] Make btrfs_prepare_device parallel during mkfs.btrfs
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Yes, I see what you mean.

There is no doubt that the loop device is not a zone device.
I simulated the zone device with the null_blk module and tested
mkfs.btrfs, but an error was reported. In addition, Not only
mkfs.btrfs does not work on null_blk zoned devices, mkfs.xfs and mkfs.ext2 =
also
do not work on null_blk zoned devices, here is the test log. My first
instinct is
the null_blk problem . But I didn't test tcmu-runner, I'll dig into it
later anyway.


#emulate zoned device using null_blk
$ sudo modprobe null_blk nr_devices=3D4 zoned=3D1

#mkfs.xfs failed
$ sudo mkfs.xfs -V
mkfs.xfs version 5.18.0
$ sudo mkfs.xfs /dev/nullb0 -f
meta-data=3D/dev/nullb0            isize=3D512    agcount=3D4, agsize=3D163=
84000 blks
         =3D                       sectsz=3D512   attr=3D2, projid32bit=3D1
         =3D                       crc=3D1        finobt=3D1, sparse=3D1, r=
mapbt=3D0
         =3D                       reflink=3D1    bigtime=3D1 inobtcount=3D=
1
data     =3D                       bsize=3D4096   blocks=3D65536000, imaxpc=
t=3D25
         =3D                       sunit=3D0      swidth=3D0 blks
naming   =3Dversion 2              bsize=3D4096   ascii-ci=3D0, ftype=3D1
log      =3Dinternal log           bsize=3D4096   blocks=3D32000, version=
=3D2
         =3D                       sectsz=3D512   sunit=3D0 blks, lazy-coun=
t=3D1
realtime =3Dnone                   extsz=3D4096   blocks=3D0, rtextents=3D0
mkfs.xfs: pwrite failed: Input/output error
libxfs_bwrite: write failed on (unknown) bno 0x1f3fff00/0x100, err=3D5
mkfs.xfs: Releasing dirty buffer to free list!
found dirty buffer (bulk) on free list!
mkfs.xfs: pwrite failed: Input/output error
libxfs_bwrite: write failed on (unknown) bno 0x0/0x100, err=3D5
mkfs.xfs: Releasing dirty buffer to free list!
found dirty buffer (bulk) on free list!
mkfs.xfs: pwrite failed: Input/output error
libxfs_bwrite: write failed on xfs_sb bno 0x0/0x1, err=3D5
mkfs.xfs: Releasing dirty buffer to free list!
mkfs.xfs: libxfs_device_zero write failed: Input/output error

#mkfs.btrfs failed
$ sudo mkfs.btrfs --version
mkfs.btrfs, part of btrfs-progs v5.19
$ sudo mkfs.btrfs -d single -m single -O zoned /dev/nullb0 /dev/nullb1
/dev/nullb2 -f
btrfs-progs v5.19
See http://btrfs.wiki.kernel.org for more information.

Resetting device zones /dev/nullb0 (1000 zones) ...
Resetting device zones /dev/nullb2 (1000 zones) ...
Resetting device zones /dev/nullb1 (1000 zones) ...
NOTE: several default settings have changed in version 5.15, please make su=
re
      this does not affect your deployments:
      - DUP for metadata (-m dup)
      - enabled no-holes (-O no-holes)
      - enabled free-space-tree (-R free-space-tree)

No valid Btrfs found on /dev/nullb0
ERROR: open ctree failed

#mkfs.ext2 failed
$ sudo mke2fs -V
mke2fs 1.46.5 (30-Dec-2021)
Using EXT2FS Library version 1.46.5
$ sudo mke2fs /dev/nullb0
mke2fs 1.46.5 (30-Dec-2021)
Creating filesystem with 65536000 4k blocks and 16384000 inodes
Filesystem UUID: 747350a2-a1d5-4944-9f46-0fe4ca76df9d
Superblock backups stored on blocks:
32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
4096000, 7962624, 11239424, 20480000, 23887872

Allocating group tables: done
Writing inode tables: done
Writing superblocks and filesystem accounting information: mke2fs:
Input/output error while writing out and closing file system



thanks,
Li Zhang

Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2022=E5=B9=B48=E6=9C=8828=E6=97=
=A5=E5=91=A8=E6=97=A5 17:54=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 2022/8/28 16:53, li zhang wrote:
> > Hi, I'm a bit confused, do you mean if you open a zoned device
> > without O_DIRECT it will fail?
>
> Not a zoned device expert, but to my understanding, if we write into
> zoned device, without O_DIRECT, there is no guarantee that the data you
> submitted will end at the same bytenr you specified.
>
> E.g. if you do a pwrite() with a 1M buffer, at device bytenr 4M.
>
> Without O_DIRECT, the zoned code can re-locate the bytenr to any range
> after the write pointer inside the same zone.
>
> AKA, for zoned device, without O_DIRECT (queue length 1), you can only
> known the real physical bytenr after the write has fully finished.
>
> (The final physical bytenr is determined by the zoned device, no longer
> the write initiator).
>
> >
> > I tested and found that if I open a device with the O_DIRECT flag
> > on a virtual device like a loop device, the device cannot be written
> > to, but with or without O_DIRECT, it works fine on a real
> > device (for me, I only test A normal block device since I don't have
> > any zoned devices)
>
> IIRC currently there is no zoned emulation for loop device.
>
> If you want to test zoned device, you can use null block kernel module,
> with fully memory backed storage:
>
> https://zonedstorage.io/docs/getting-started/nullblk
>
>
> Or go a little further, using tcmu-runner to create file backed zoned
> device:
>
> https://zonedstorage.io/docs/tools/tcmu-runner
>
> >
> > If we use the same flags for all devices,
> > does that mean we can't use mkfs.btrfs
> > on both real and virtual devices at the same time.
> >
> >
> > Below is my test program and test results.
> >
> > code(main idea):
> > printf("filename:%s.\n", argv[1]);
> > int fd =3D open(argv[1], O_RDWR | O_DIRECT);
> > if (fd < 0) {
> >       printf("fd:error.\n");
> >       return -1;
> > }
> > int num =3D write(fd, "123", 3);
> > printf("num:%d.\n", num);
>
> O_DIRECT requires strict memory alignment, obviously the length 3 is not
> properly aligned.
>
> Please check open(2p) for the full requirement.
>
> For mkfs usage, all of our write is at least 4K aligned, thus O_DIRECT
> can work correctly.
>
>
> Back to btrfs-progs work, I'd say before we do anything, let's check all
> the devices passed in to determine if we want zoned mode (any zoned
> device should make it zoned).
>
> Then we can determine the open flags for all devices, and for regular
> devices, O_DIRECT mostly makes no difference (maybe a little slower, but
> may not even be observable).
>
> Thanks,
> Qu
>
>
> > close(fd);
> >
> > result:
> > $ sudo losetup /dev/loop1 loopDev/loop1
> > $ sudo ./a.out /dev/loop1
> > filename:/dev/loop1.
> > num:-1.
> > # cannot write to loop1
> >
> >
> > Thanks,
> > Li Zhang
> >
> > Johannes Thumshirn <Johannes.Thumshirn@wdc.com> =E4=BA=8E2022=E5=B9=B48=
=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 16:31=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 25.08.22 07:20, Qu Wenruo wrote:
> >>>> +                    if (zoned && zoned_model(file) =3D=3D ZONED_HOS=
T_MANAGED)
> >>>> +                            prepare_ctx[i].oflags =3D O_RDWR | O_DI=
RECT;
> >>> Do we need to treat the initial and other devices differently?
> >>>
> >>> Can't we use the same flags for all devices?
> >>>
> >>>
> >>
> >> Yep we need to have the same flags for all devices. Otherwise only
> >> device 0 will be opened with O_DIRECT, in case of a host-managed one a=
nd
> >> the subsequent will be opened without O_DIRECT causing mkfs to fail.
