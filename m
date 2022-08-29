Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC505A4061
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Aug 2022 02:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiH2AgZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Aug 2022 20:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiH2AgY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Aug 2022 20:36:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3A52ED56
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Aug 2022 17:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661733375;
        bh=vLw1TfUTsRkx0QrrcsrqfIooyYW6bcB9ejCNHn2WLfQ=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=Bu2/zvSFVUgK9+eFy+A4YkrOXWgYeUPFhUPSFiN+vduzFlaIXludpmtE5IdHWSYH8
         u4z67qaWcSWTUISD/wMVupFuBVVW8Xh2gqNnoc1Rjsmk8UsCF31i+7bxqlKouP11RL
         nD39Yy6Dc1bJVZvMS5ksvG/kR8MYXmJ+nJj+PnDw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mj8qj-1p5OPL37y9-00fENc; Mon, 29
 Aug 2022 02:36:15 +0200
Message-ID: <da8bf536-f2c4-208f-b2e9-b760d24efdea@gmx.com>
Date:   Mon, 29 Aug 2022 08:36:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     li zhang <zhanglikernel@gmail.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <1661357103-22735-1-git-send-email-zhanglikernel@gmail.com>
 <c3dc352c-8393-c564-4366-42fb9ece021e@gmx.com>
 <PH0PR04MB7416B660C501F73F47E7D4159B729@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAAa-AGk67Ex8woPz=F-P-GdsY1i2N0w==AP9Bk2YpH=Yk+vPdg@mail.gmail.com>
 <76515426-abd4-2ed7-ea58-db1ba7e3a123@gmx.com>
 <CAAa-AGnBSR7RKbzZBz-J5S92qcO4HGe09cL-ZsVwJf9oyri1xg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] Make btrfs_prepare_device parallel during mkfs.btrfs
In-Reply-To: <CAAa-AGnBSR7RKbzZBz-J5S92qcO4HGe09cL-ZsVwJf9oyri1xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Syi9WY6RphcfAQPIgqhVEBYqJPUiOF2gsVJyYrSagKCcIVaeMDF
 l1P9fXUoM+Klp4zt1R23y55zc03cTbjkx1izzLACeT7X65gUyvdIQrvYSFcf1FQ4Ke/yB2Z
 WZNO5wbi6q6Ar9R+u+tR3D1ZkcN1U6trcOs9hfo6w7DdQpNHqZxn/55O4jylKf1J5nWCowk
 fucxjSU+Oa46IBjpytlUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rM2xbIx/Rg4=:em/bdBME4d1YfbQWOyMYHV
 lihrhRyYTg+yMAFJTIbff5aGehLSmDK6CgDprCzVz48Byw1R4Y3/0xkgzaE8zHP+SF8LgP8Pp
 F0SQEaH6QjYF68Gi7MgPMXNgLhplV3dEqEGoCV6WYqwygtMYKJoQzvOX4BbKCJIdKhOlzoOq9
 9WWGpIUnDdnK8qjHaerQ1gMd1KRM6jcTvg/2sOFgh+POWuIYaTesMn9l9qkOqb8dRvDmcJJ8A
 oPOstvPQ/ih9XVgg9V06Zz3br/UkGkd7iW/7i5uW2V8ig6E0OAkZT7J/houHFH4Akh9N/UEP9
 8eL00G+FRwzOI5Ht9fwzeskfPpBzd2Jz+m8+w+bjvoYJsWd1epNRCHLaoCJrk2BdRK9ch/2t9
 gMx3lA3P8n7VAe2k9CDsuCjQbv6xsBIyKXzFtCsiW7vszCxzQIb5TWBZ00IuMPZTKBO5X+p2U
 K8FQ0RGQ1eygOQeQ/USFeseDRZF5uk0A+naoh0nSCN/Ns84S88ca6BGnbPeJ2is5vwXunV+0C
 kyf+8sai1HSwEB9I/HJgbNL4Miz2RLZ99LGTvkJqjZJccFK5cLC6nAmvOqch4Ko4jwBcvGp2I
 OaI2MzzEc19t5C9kQVFC91g86XYqx0wXefPkxYY5vbZaJAEt5YmEYHmdLEuTJYFRi0B24NkZn
 YYnW3faPPKj4/nxnlVv117c8RfrONOoqCrzFvXxgrtAYJ2QIwbjeJGOW2Yhp4nZ1tahEwSPry
 lyChYgLrf/q/2xPjkUogMKhpolrxuS7Gv8mFJKJPznUgQq4uI+vda7uazVnGHiZZVsvQIH+N2
 7a6nhnyezF+bXs9GkMhUuqb+jWCQIpn/M/1/nnjI7VOZhFPVvMIz6HHG8FX7Ec0eprE0Tla1n
 dM8wGXPqZgpM3P1YhFR8nKgU8fl3XFq1+Nvfl3Wzc2LM8eDdkuRiK+G15KnwKVCTUv+Bmyl7u
 +2tAb4FdoT6cAUfSsc1fbu3Ymxgrh626LYJmTXiplnAcXoueqUCFayI73qBXhj4PwFNyxPosO
 mrQzeq9cUxuKYQptwk4OOFm0/F6qjS/xpGziRQLgPZiNAh6jJtkhBsGOXwr3+jRyByGYpiFiL
 dgfds1bn6UkPzWDdAitgDpJCKxm834g2fEJXhlt6QrhpM5E7YlKFLjcDg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/28 22:26, li zhang wrote:
> Yes, I see what you mean.
>
> There is no doubt that the loop device is not a zone device.
> I simulated the zone device with the null_blk module and tested
> mkfs.btrfs, but an error was reported. In addition, Not only
> mkfs.btrfs does not work on null_blk zoned devices, mkfs.xfs and mkfs.ex=
t2 also
> do not work on null_blk zoned devices, here is the test log. My first
> instinct is
> the null_blk problem . But I didn't test tcmu-runner, I'll dig into it
> later anyway.

Please get an overview of what zoned device can and can not in the first
place:

https://zonedstorage.io/docs/introduction/zoned-storage

In short, for zoned device it can not do any overwrite.

Johannes, please correct me if I'm wrong, it's only allowed to submit
write which bytenr is at (or beyond?) the write pointer inside a zone.

Thus that's why there are only very limited filesystems supporting zoned
device for now.

For current btrfs, we have mandatory metadata COW, thus can ensure all
our metadata are allocated in ascending bytenr, and uses queue depth 1
to make sure all our metadata can be written exactly where we specify.

For btrfs data, we let the zoned device to decide where the data should
be, and record the new bytenr returned by the zoned device into our
metadata (and follow above metadata write behavior to write them).

For btrfs super blocks, there are two (?) dedicated zones for
superblocks, we write super blocks into one zone like a ring buffer.
(Thus at mount we need to read the whole zone to find the newest copy)

So mkfs.xfs is *supposed* to fail, that's nothing new.
There are tons of things which can lead to write before the write
pointer, like to update the super block.


>
>
> #emulate zoned device using null_blk
> $ sudo modprobe null_blk nr_devices=3D4 zoned=3D1
>
> #mkfs.xfs failed
> $ sudo mkfs.xfs -V
> mkfs.xfs version 5.18.0
> $ sudo mkfs.xfs /dev/nullb0 -f
> meta-data=3D/dev/nullb0            isize=3D512    agcount=3D4, agsize=3D=
16384000 blks
>           =3D                       sectsz=3D512   attr=3D2, projid32bit=
=3D1
>           =3D                       crc=3D1        finobt=3D1, sparse=3D=
1, rmapbt=3D0
>           =3D                       reflink=3D1    bigtime=3D1 inobtcoun=
t=3D1
> data     =3D                       bsize=3D4096   blocks=3D65536000, ima=
xpct=3D25
>           =3D                       sunit=3D0      swidth=3D0 blks
> naming   =3Dversion 2              bsize=3D4096   ascii-ci=3D0, ftype=3D=
1
> log      =3Dinternal log           bsize=3D4096   blocks=3D32000, versio=
n=3D2
>           =3D                       sectsz=3D512   sunit=3D0 blks, lazy-=
count=3D1
> realtime =3Dnone                   extsz=3D4096   blocks=3D0, rtextents=
=3D0
> mkfs.xfs: pwrite failed: Input/output error
> libxfs_bwrite: write failed on (unknown) bno 0x1f3fff00/0x100, err=3D5
> mkfs.xfs: Releasing dirty buffer to free list!
> found dirty buffer (bulk) on free list!
> mkfs.xfs: pwrite failed: Input/output error
> libxfs_bwrite: write failed on (unknown) bno 0x0/0x100, err=3D5
> mkfs.xfs: Releasing dirty buffer to free list!
> found dirty buffer (bulk) on free list!
> mkfs.xfs: pwrite failed: Input/output error
> libxfs_bwrite: write failed on xfs_sb bno 0x0/0x1, err=3D5
> mkfs.xfs: Releasing dirty buffer to free list!
> mkfs.xfs: libxfs_device_zero write failed: Input/output error

That's expected.

>
> #mkfs.btrfs failed
> $ sudo mkfs.btrfs --version
> mkfs.btrfs, part of btrfs-progs v5.19
> $ sudo mkfs.btrfs -d single -m single -O zoned /dev/nullb0 /dev/nullb1
> /dev/nullb2 -f
> btrfs-progs v5.19
> See http://btrfs.wiki.kernel.org for more information.
>
> Resetting device zones /dev/nullb0 (1000 zones) ...
> Resetting device zones /dev/nullb2 (1000 zones) ...
> Resetting device zones /dev/nullb1 (1000 zones) ...
> NOTE: several default settings have changed in version 5.15, please make=
 sure
>        this does not affect your deployments:
>        - DUP for metadata (-m dup)
>        - enabled no-holes (-O no-holes)
>        - enabled free-space-tree (-R free-space-tree)
>
> No valid Btrfs found on /dev/nullb0

This looks like you're using null_blk in discard mode (aka, all writes
are just discarded).

You need to specify the memory_backed param to let it remember what you
have written.

To Johannes, maybe you want to update the null_blk page to specify the
memory_backed param?

With that specified, it works fine in my test env:

  # modprobe null_blk nr_devices=3D1 zoned=3D1 zone_size=3D128 gb=3D1
memory_backed=3D1
  # mkfs.btrfs  -f /dev/nullb0 -m single -d single
btrfs-progs v5.18.1
See http://btrfs.wiki.kernel.org for more information.

Zoned: /dev/nullb0: host-managed device detected, setting zoned feature
Resetting device zones /dev/nullb0 (8 zones) ...
NOTE: several default settings have changed in version 5.15, please make
sure
       this does not affect your deployments:
       - DUP for metadata (-m dup)
       - enabled no-holes (-O no-holes)
       - enabled free-space-tree (-R free-space-tree)

Label:              (null)
UUID:               d75978cc-cfff-4acd-abb3-5f8023d4f12f
Node size:          16384
Sector size:        4096
Filesystem size:    1.00GiB
Block group profiles:
   Data:             single          128.00MiB
   Metadata:         single          128.00MiB
   System:           single          128.00MiB
SSD detected:       yes
Zoned device:       yes
   Zone size:        128.00MiB
Incompat features:  extref, skinny-metadata, no-holes, zoned
Runtime features:   free-space-tree
Checksum:           crc32c
Number of devices:  1
Devices:
    ID        SIZE  PATH
     1     1.00GiB  /dev/nullb0

# mount /dev/nullb0  /mnt/btrfs/



Thanks,
Qu


> ERROR: open ctree failed
>
> #mkfs.ext2 failed
> $ sudo mke2fs -V
> mke2fs 1.46.5 (30-Dec-2021)
> Using EXT2FS Library version 1.46.5
> $ sudo mke2fs /dev/nullb0
> mke2fs 1.46.5 (30-Dec-2021)
> Creating filesystem with 65536000 4k blocks and 16384000 inodes
> Filesystem UUID: 747350a2-a1d5-4944-9f46-0fe4ca76df9d
> Superblock backups stored on blocks:
> 32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
> 4096000, 7962624, 11239424, 20480000, 23887872
>
> Allocating group tables: done
> Writing inode tables: done
> Writing superblocks and filesystem accounting information: mke2fs:
> Input/output error while writing out and closing file system
>
>
>
> thanks,
> Li Zhang
>
> Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2022=E5=B9=B48=E6=9C=8828=E6=
=97=A5=E5=91=A8=E6=97=A5 17:54=E5=86=99=E9=81=93=EF=BC=9A
>>
>>
>>
>> On 2022/8/28 16:53, li zhang wrote:
>>> Hi, I'm a bit confused, do you mean if you open a zoned device
>>> without O_DIRECT it will fail?
>>
>> Not a zoned device expert, but to my understanding, if we write into
>> zoned device, without O_DIRECT, there is no guarantee that the data you
>> submitted will end at the same bytenr you specified.
>>
>> E.g. if you do a pwrite() with a 1M buffer, at device bytenr 4M.
>>
>> Without O_DIRECT, the zoned code can re-locate the bytenr to any range
>> after the write pointer inside the same zone.
>>
>> AKA, for zoned device, without O_DIRECT (queue length 1), you can only
>> known the real physical bytenr after the write has fully finished.
>>
>> (The final physical bytenr is determined by the zoned device, no longer
>> the write initiator).
>>
>>>
>>> I tested and found that if I open a device with the O_DIRECT flag
>>> on a virtual device like a loop device, the device cannot be written
>>> to, but with or without O_DIRECT, it works fine on a real
>>> device (for me, I only test A normal block device since I don't have
>>> any zoned devices)
>>
>> IIRC currently there is no zoned emulation for loop device.
>>
>> If you want to test zoned device, you can use null block kernel module,
>> with fully memory backed storage:
>>
>> https://zonedstorage.io/docs/getting-started/nullblk
>>
>>
>> Or go a little further, using tcmu-runner to create file backed zoned
>> device:
>>
>> https://zonedstorage.io/docs/tools/tcmu-runner
>>
>>>
>>> If we use the same flags for all devices,
>>> does that mean we can't use mkfs.btrfs
>>> on both real and virtual devices at the same time.
>>>
>>>
>>> Below is my test program and test results.
>>>
>>> code(main idea):
>>> printf("filename:%s.\n", argv[1]);
>>> int fd =3D open(argv[1], O_RDWR | O_DIRECT);
>>> if (fd < 0) {
>>>        printf("fd:error.\n");
>>>        return -1;
>>> }
>>> int num =3D write(fd, "123", 3);
>>> printf("num:%d.\n", num);
>>
>> O_DIRECT requires strict memory alignment, obviously the length 3 is no=
t
>> properly aligned.
>>
>> Please check open(2p) for the full requirement.
>>
>> For mkfs usage, all of our write is at least 4K aligned, thus O_DIRECT
>> can work correctly.
>>
>>
>> Back to btrfs-progs work, I'd say before we do anything, let's check al=
l
>> the devices passed in to determine if we want zoned mode (any zoned
>> device should make it zoned).
>>
>> Then we can determine the open flags for all devices, and for regular
>> devices, O_DIRECT mostly makes no difference (maybe a little slower, bu=
t
>> may not even be observable).
>>
>> Thanks,
>> Qu
>>
>>
>>> close(fd);
>>>
>>> result:
>>> $ sudo losetup /dev/loop1 loopDev/loop1
>>> $ sudo ./a.out /dev/loop1
>>> filename:/dev/loop1.
>>> num:-1.
>>> # cannot write to loop1
>>>
>>>
>>> Thanks,
>>> Li Zhang
>>>
>>> Johannes Thumshirn <Johannes.Thumshirn@wdc.com> =E4=BA=8E2022=E5=B9=B4=
8=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 16:31=E5=86=99=E9=81=93=EF=BC=9A
>>>>
>>>> On 25.08.22 07:20, Qu Wenruo wrote:
>>>>>> +                    if (zoned && zoned_model(file) =3D=3D ZONED_HO=
ST_MANAGED)
>>>>>> +                            prepare_ctx[i].oflags =3D O_RDWR | O_D=
IRECT;
>>>>> Do we need to treat the initial and other devices differently?
>>>>>
>>>>> Can't we use the same flags for all devices?
>>>>>
>>>>>
>>>>
>>>> Yep we need to have the same flags for all devices. Otherwise only
>>>> device 0 will be opened with O_DIRECT, in case of a host-managed one =
and
>>>> the subsequent will be opened without O_DIRECT causing mkfs to fail.
