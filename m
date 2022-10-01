Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089325F2093
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Oct 2022 01:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiJAXND (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Oct 2022 19:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiJAXNC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Oct 2022 19:13:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9135457561
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Oct 2022 16:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664665952;
        bh=t2cs2BWORHq/+ZEpc4tI8dITs4rtC5h7EKztIRJxzwk=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=HcX7yFfauSG3I3DnyhMLK7QnJ0cbjokddRgm6IwTjTfZP6FCrZAlYjieDPQZnk/6g
         J1rTCwaZcyhRJNOcltDbKWUuI3cP7uWjLcBVh4CQxw6VHSSZk+Hrs91sMN1gdHess8
         UP67KS4wQ+hHvQdtiMjJc14pqvzkKprsk0MFMbY4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mi2O1-1p9igg2I5Z-00e36F; Sun, 02
 Oct 2022 01:12:32 +0200
Message-ID: <af39164a-6b87-ed76-4178-9eab0f2f9c31@gmx.com>
Date:   Sun, 2 Oct 2022 07:12:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Poor write performance with raid5 on 4 drives
To:     =?UTF-8?B?VG9tw6HFoSBIb2zDvQ==?= <vantomas@vantomas.net>,
        linux-btrfs@vger.kernel.org
References: <FB99D093-04BF-421D-8AE6-94BDA34728DB@vantomas.net>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <FB99D093-04BF-421D-8AE6-94BDA34728DB@vantomas.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R2uvzhOkowmM4yD1/gFKMGaQ3LiE0tomQmnsXpBWVt95U0EXFRj
 yL3qILBxDOu2w4ESSF90RDKV+oneTxlrT6EfmnpFUCDAz0+twNqkPwMudgWc1Ukh/y/AD+b
 hSsxvEcdv30Qv2vHl+Afwn8Gzo/KneXburfEjy0Vr8jtEIHGXqJ/i5WGdLooa4LNGuqIvFx
 X9f8hyD6o+wYFD1zDSpQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:akGU1LQeE0w=:lZTrr3tGYA/EnleifSVWEX
 4xZZAiJDybjh/lXfCiEVT9QOTBAkpSOoUbvZeZPnSjFmV7Cw+UvRkrm0vHmKvGqQ/jvjRcZwQ
 hWRxBgwz0H6KsKleLAEUvY+I0YxkyC7XzK5pS8hABIMTMT+KlEySFGfOTnRoS42tM4pE89HjJ
 oVy+1NWvmkhgAh09Ew6MPCiO+Au0P/Q16Ae0gHPSN3FUdi4Bi0Arh59pFofCt6D0gh+Jf7l0I
 32lG1mw+nf17lBmSh3Ike5v2smfZZw8eDX/EbwofRJufktPp8WY09T9nvtmpQoOIwaqn1sS8/
 KU4iXMot96dRCHg6EVln07kS/2VXUvOXftF1VtAVTu2xIoou3UUEIv5snFFYAHfLO4+gjc8Dx
 V+zflRaDWFbZrCYjxEgoC/HXip4QsfruIfM+0A2qJjxf6LTKwA7PpEvpUl/F2taaaR+PJytbz
 yNun19OhZk97/7UoX+zxw+K8MHSSb8HyfgpPk7xp/cZuaKHDeuPsUoKteqcn1CumwxwYFDF/l
 TxyJIIzIPec6vD4so7nFnZ+9F0w6/+znopz9QpOTrgJpui6wFIGrfHFzHW1y6MATzv1pqfvAl
 N8u7Kr5Pzg0t6ji7yIWZReQSW1E2FGGH+Q2ExCyoz5agJBG1LC3a+Bg8eC/MAHdtx9F0G+Re9
 Am+ZG/e57vDmPtNPeJFai+2t+3lFDkv6uxmp6mxlXqSfackqNKOLH6bt7uVuGgLeP1xC67i+x
 kPixQoBPjIgHnNKMcwuUaV1bl0/G4STevLG1RYulYThDHg9xXMkCM/zT7ps5+qdApepmCZcjq
 8l1+97FEHEV90fXKnQTRtQaEnXlBTdaQZFZ1rMWLsKCeH3/Kg+gWu9J0kygV4S/cTQsPxtJnt
 MNCzhfg6hy8K9sylxJW4Nz4WLoqCBZ/NnDvyeHkk3zCOKkz0UfyphF6PNSLmB29CJqw8pb18T
 hvi3MijhPxGfHbDoU1Wquem0SAreCWj6bJR66IH2yP1eQyTxqQGq0tziKGQaiZLmTcLOG4mwz
 E96Dv8hWoAjvXEbO9Y6cGyec3qxxSkpavwIqYcO53k/dPKA+uXNjpO+Blo1uJzGrD1WCwiO8/
 OxtVM4lrS/4tm5eM4QTzFWLMCQs5bKmnipv4/EMNlacD+CWtWTKIxHHQRTM5NfUfogN/PD1sB
 kBBSu4Cg8JxtOd0CXFvwtEnq/I
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/1 17:33, Tom=C3=A1=C5=A1 Hol=C3=BD wrote:
> Hello,
> I=E2=80=99m building my personal tertiary backup box running on HP Micro=
server G8 with 4x 6TB hard drives and I was planning to use raid5 profile =
for reasonable data ratio but I ran into really poor write performance on =
raid5 with 4 drives. On a filesystem with -d=3Draid5 -m=3Draid1c4 on 4 dri=
ves I only get about 40MB/s of write speed, but with -d=3Draid5 -m=3Draid1=
c3 on 3 drives or -d=3Draid6 -m raid1c4 on 4 drives I get 500MB/s of write=
 speed.
>
> I tried to investigate it somehow, I compared the properties of the file=
system and other variables in /sys/fs/btrfs between each other, but all I =
found was that raid5 on 4 drives reads from hard drives while writing data=
 and that would be whole problem with poor performance imho. But that=E2=
=80=99s where my skills end.
>
> Do you know if there is a solution to this or can you point me in which =
direction to look?
>
>
> Thanks,
> Tomas
>
>
>
>
> [root@backupcube ~]# uname -a
> Linux backupcube 5.19.11-200.fc36.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Sep =
23 15:07:44 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
> [root@backupcube ~]# btrfs --version
> btrfs-progs v5.18
>
>
> ### -d=3Draid5 -m=3Draid1c4 on 4 drives ###
>
> [root@backupcube ~]# mkfs.btrfs -f -d raid5 -m raid1c4 /dev/sda1 /dev/sd=
b1 /dev/sdd1 /dev/sde1
> btrfs-progs v5.18
> See http://btrfs.wiki.kernel.org for more information.
>
> WARNING: RAID5/6 support has known problems is strongly discouraged
> 	 to be used besides testing or evaluation.
>
> NOTE: several default settings have changed in version 5.15, please make=
 sure
>        this does not affect your deployments:
>        - DUP for metadata (-m dup)
>        - enabled no-holes (-O no-holes)
>        - enabled free-space-tree (-R free-space-tree)
>
> Label:              (null)
> UUID:               279a913f-bf4a-44ba-a5cd-26c94c954365
> Node size:          16384
> Sector size:        4096
> Filesystem size:    21.83TiB
> Block group profiles:
>    Data:             RAID5             3.00GiB
>    Metadata:         RAID1C4           1.00GiB
>    System:           RAID1C4           8.00MiB
> SSD detected:       no
> Zoned device:       no
> Incompat features:  extref, raid56, skinny-metadata, no-holes, raid1c34
> Runtime features:   free-space-tree
> Checksum:           crc32c
> Number of devices:  4
> Devices:
>     ID        SIZE  PATH
>      1     5.46TiB  /dev/sda1
>      2     5.46TiB  /dev/sdb1
>      3     5.46TiB  /dev/sdd1
>      4     5.46TiB  /dev/sde1
>
>
> [root@backupcube ~]# dd if=3D/dev/zero of=3D/mnt/sda1/tempfile bs=3D1M c=
ount=3D4096 conv=3Dfdatasync,notrunc status=3Dprogress oflag=3Ddirect

One thing I notice is, you're using blocksize which is not really
aligned to a full stripe length.

For 4 disk RAID5, it's *3* data stripes + 1 parity.

Thus the full stripe length is 64Kx3.

1M block size contains 5 and 1/3 of a full stripe, thus I'm wondering if
the 1/3 (substripe) write is causing problem.

Especially considering substripe will also have a wait time trying to
merge more substripe write into a full one.


Considering you have already tested 3 disks RAID5, if you have enough
disks, mind to test if 5 disks RAID5 would have a different result?

Thanks,
Qu

> 4270850048 bytes (4.3 GB, 4.0 GiB) copied, 106 s, 40.3 MB/s
> 4096+0 records in
> 4096+0 records out
> 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 106.619 s, 40.3 MB/s
>
>
> [root@backupcube ~]# dstat -d -D total,sda,sdb,sdd,sde
> --dsk/sda-----dsk/sdb-----dsk/sdd-----dsk/sde----dsk/total-
>   read  writ: read  writ: read  writ: read  writ: read  writ
> 1215k   13M:1215k   13M:1215k   13M:1215k   13M:4858k   52M
> 1216k   13M:1216k   13M:1216k   13M:1216k   13M:4864k   52M
> 1216k   13M:1216k   13M:1216k   13M:1216k   13M:4864k   52M
> 1280k   13M:1216k   13M:1216k   13M:1216k   13M:4928k   52M
> 1152k   13M:1216k   13M:1216k   13M:1216k   13M:4800k   52M
> 1216k   13M:1216k   13M:1216k   13M:1216k   13M:4864k   52M^C
>
> [root@backupcube ~]#
>
>
>
>
>
> ### -d=3Draid6 -m=3Draid1c4 on 4 drives ###
>
> [root@backupcube ~]# mkfs.btrfs -f -d raid6 -m raid1c4 /dev/sda1 /dev/sd=
b1 /dev/sdd1 /dev/sde1
> btrfs-progs v5.18
> See http://btrfs.wiki.kernel.org for more information.
>
> WARNING: RAID5/6 support has known problems is strongly discouraged
> 	 to be used besides testing or evaluation.
>
> NOTE: several default settings have changed in version 5.15, please make=
 sure
>        this does not affect your deployments:
>        - DUP for metadata (-m dup)
>        - enabled no-holes (-O no-holes)
>        - enabled free-space-tree (-R free-space-tree)
>
> Label:              (null)
> UUID:               9e4f6691-971d-4950-a032-d3c83f2fda26
> Node size:          16384
> Sector size:        4096
> Filesystem size:    21.83TiB
> Block group profiles:
>    Data:             RAID6             2.00GiB
>    Metadata:         RAID1C4           1.00GiB
>    System:           RAID1C4           8.00MiB
> SSD detected:       no
> Zoned device:       no
> Incompat features:  extref, raid56, skinny-metadata, no-holes, raid1c34
> Runtime features:   free-space-tree
> Checksum:           crc32c
> Number of devices:  4
> Devices:
>     ID        SIZE  PATH
>      1     5.46TiB  /dev/sda1
>      2     5.46TiB  /dev/sdb1
>      3     5.46TiB  /dev/sdd1
>      4     5.46TiB  /dev/sde1
>
>
> [root@backupcube ~]# dd if=3D/dev/zero of=3D/mnt/sda1/tempfile bs=3D1M c=
ount=3D4096 conv=3Dfdatasync,notrunc status=3Dprogress oflag=3Ddirect
> 4051697664 bytes (4.1 GB, 3.8 GiB) copied, 8 s, 506 MB/s
> 4096+0 records in
> 4096+0 records out
> 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 8.58926 s, 500 MB/s
>
> [root@backupcube ~]# dstat -d -D total,sda,sdb,sdd,sde
> --dsk/sda-----dsk/sdb-----dsk/sdd-----dsk/sde----dsk/total-
>   read  writ: read  writ: read  writ: read  writ: read  writ
>     0   238M:   0   238M:   0   238M:   0   238M:   0   953M
>     0   250M:   0   250M:   0   250M:   0   250M:   0  1001M
>     0   242M:   0   242M:   0   242M:   0   242M:   0   968M
>     0   238M:   0   238M:   0   238M:   0   238M:   0   953M
>     0   242M:   0   242M:   0   243M:   0   242M:   0   970M
>     0   243M:   0   243M:   0   243M:   0   243M:   0   972M
>     0   192M:   0   192M:   0   192M:   0   192M:   0   769M
>     0     0 :   0     0 :   0     0 :   0     0 :   0  6144B^C
>
>
>
>
>
> ### -d=3Draid5 -m=3Draid1c3 on 3 drives ###
>
> [root@backupcube ~]# mkfs.btrfs -f -d raid5 -m raid1c3 /dev/sda1 /dev/sd=
b1 /dev/sdd1
> btrfs-progs v5.18
> See http://btrfs.wiki.kernel.org for more information.
>
> WARNING: RAID5/6 support has known problems is strongly discouraged
> 	 to be used besides testing or evaluation.
>
> NOTE: several default settings have changed in version 5.15, please make=
 sure
>        this does not affect your deployments:
>        - DUP for metadata (-m dup)
>        - enabled no-holes (-O no-holes)
>        - enabled free-space-tree (-R free-space-tree)
>
> Label:              (null)
> UUID:               7f06fbb0-9655-4f8d-af4a-2d06d8dc1d80
> Node size:          16384
> Sector size:        4096
> Filesystem size:    16.37TiB
> Block group profiles:
>    Data:             RAID5             2.00GiB
>    Metadata:         RAID1C3           1.00GiB
>    System:           RAID1C3           8.00MiB
> SSD detected:       no
> Zoned device:       no
> Incompat features:  extref, raid56, skinny-metadata, no-holes, raid1c34
> Runtime features:   free-space-tree
> Checksum:           crc32c
> Number of devices:  3
> Devices:
>     ID        SIZE  PATH
>      1     5.46TiB  /dev/sda1
>      2     5.46TiB  /dev/sdb1
>      3     5.46TiB  /dev/sdd1
>
> [root@backupcube ~]# dd if=3D/dev/zero of=3D/mnt/sda1/tempfile bs=3D1M c=
ount=3D4096 conv=3Dfdatasync,notrunc status=3Dprogress oflag=3Ddirect
> 4034920448 bytes (4.0 GB, 3.8 GiB) copied, 8 s, 504 MB/s
> 4096+0 records in
> 4096+0 records out
> 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 8.61927 s, 498 MB/s
> [root@backupcube ~]#
>
>
> [root@backupcube ~]# dstat -d -D total,sda,sdb,sdd,sde
> --dsk/sda-----dsk/sdb-----dsk/sdd-----dsk/sde----dsk/total-
>   read  writ: read  writ: read  writ: read  writ: read  writ
>     0   231M:   0   231M:   0   231M:   0     0 :   0   694M
>     0   244M:   0   244M:   0   244M:   0     0 :   0   733M
>     0   250M:   0   250M:   0   250M:   0     0 :   0   751M
>     0   238M:   0   238M:   0   238M:   0     0 :   0   715M
>     0   239M:   0   239M:   0   239M:   0     0 :   0   718M
>     0   243M:   0   243M:   0   243M:   0     0 :   0   729M
>     0   243M:   0   243M:   0   243M:   0     0 :   0   728M
>     0   117M:   0   117M:   0   117M:   0     0 :   0   351M
>     0     0 :   0     0 :   0     0 :   0     0 :   0     0 ^C
