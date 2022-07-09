Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1BF56CA70
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 17:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiGIPxo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 9 Jul 2022 11:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGIPxn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Jul 2022 11:53:43 -0400
Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A27DFE4
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Jul 2022 08:53:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 1D49D3F36F;
        Sat,  9 Jul 2022 17:53:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.91
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t9JY6n0_VXTx; Sat,  9 Jul 2022 17:53:37 +0200 (CEST)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id A4EAF3F324;
        Sat,  9 Jul 2022 17:53:37 +0200 (CEST)
Received: from [192.168.0.119] (port=59290)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1oACm0-000IbU-Vo; Sat, 09 Jul 2022 17:53:37 +0200
Date:   Sat, 9 Jul 2022 17:53:36 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     =?UTF-8?Q?=C4=90=E1=BA=A1t_Nguy=E1=BB=85n?= 
        <snapeandcandy@gmail.com>,
        linux-btrfs Mailinglist <linux-btrfs@vger.kernel.org>
Message-ID: <2baf551.831915f2.181e3aa9673@tnonline.net>
In-Reply-To: <CAGXSV6YJ-i8wUod27v-8yM0PtaTpxhee9hLjgBLCWyHT4AAu6g@mail.gmail.com>
References: <CAGXSV6aseVoQJGOBDC7JoNUpW_8UfBxWgsg6ExPQUWajtUeu=w@mail.gmail.com> <4e7b28c9-ad39-19cb-202e-f0efa1d501b5@tnonline.net> <CAGXSV6YisBQW-gmEgU2X0Rsq51U7SFe7Vsyw4x231DsDzDoR4Q@mail.gmail.com> <c539e06.6901844a.181e33e9d5a@tnonline.net> <CAGXSV6Zt6tr+8eU8RzC_qvaxHdjARrheqPp8RZmnmTwd73s4Ew@mail.gmail.com> <9c858f5.831915f1.181e37c5014@tnonline.net> <CAGXSV6YJ-i8wUod27v-8yM0PtaTpxhee9hLjgBLCWyHT4AAu6g@mail.gmail.com>
Subject: Re: Cannot mount
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: "Đạt Nguyễn" <snapeandcandy@gmail.com> -- Sent: 2022-07-09 - 17:31 ----

> There isn't such sdb2.
> 
> ~ ❯❯❯ sudo lsblk -e7
> NAME      MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
> sda         8:0    0   3,7T  0 disk
> ├─sda1      8:1    0   3,6T  0 part
> └─sda3      8:3    0    14G  0 part
> sdb         8:16   0   1,8T  0 disk
> ├─sdb1      8:17   0   1,8T  0 part
> └─sdb2      8:18   0  34,2G  0 part
> 

Here you have sdb2 of 34,2G



> As I recall, in the old system there is no sdb3, only sdb1 and sdb2. I
> created sdb2 and sda2 as spares partitions according to a
> recommendation (I saved that link but it is on the btrfs disks :)) )
> 
> ~ ❯❯❯ sudo dmesg -C
> ~ ❯❯❯ sudo mount -o compress=zstd /dev/sda1 /mnt/data
> ~ ❯❯❯ dmesg
> [256281.736750] BTRFS info (device sdb1): flagging fs with big metadata feature
> [256281.736757] BTRFS info (device sdb1): setting incompat feature
> flag for COMPRESS_ZSTD (0x10)
> [256281.736760] BTRFS info (device sdb1): use zstd compression, level 3
> [256281.736762] BTRFS info (device sdb1): disk space caching is enabled
> [256281.736763] BTRFS info (device sdb1): has skinny extents
> [256281.743955] BTRFS error (device sdb1): device total_bytes should
> be at most 1963658838016 but found 2000397864960
> [256281.743962] BTRFS error (device sdb1): failed to read chunk tree: -22
> [256281.766436] BTRFS error (device sdb1): open_ctree failed
> 
> 
> Now, I need your confirmation to use GParted to resize sdb1 to 2000397864960
> 

Do not use gparted. Resizing with gparted also means resizing the filesystem on the partition. This won't work good now. 

What you should do would be usng parted to remove sdb2 and resize the partition. I'm using a loop device as example here:

Before you start. Are you sure that the second partition of 36GB isn't used by anything? 

# parted /dev/loop0
GNU Parted 3.5
Using /dev/loop0
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) p
Model: Loopback device (loopback)
Disk /dev/loop0: 2000GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags:
Number  Start   End     Size    File system  Name   Flags
 1      1049kB  1964GB  1964GB               btrfs
 2      1964GB  2000GB  36.7GB
(parted) rm 2
(parted) resizepart 1
End?  [1964GB]? 100%
(parted) p
Model: Loopback device (loopback)
Disk /dev/loop0: 2000GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags:
Number  Start   End     Size    File system  Name   Flags
 1      1049kB  2000GB  2000GB               btrfs
(parted) q
Information: You may need to update /etc/fstab.

~~~~~~~~~~~~~~~~~~~~~~~~~~

Now you can try to mount the filesystem again. If it works you should issue the following command:

'btrfs filesystem resize /dev/sdb1:max /mnt/btrfs' (where you mounted the filesystem) 

If you can't mount, send us the dmesg output and the output of 'btrfs check --readonly'. 

Regards, 
Forza 

> Thanks,
> 
> 
> On Sat, Jul 9, 2022 at 10:03 PM Forza <forza@tnonline.net> wrote:
>>
>>
>>
>> ---- From: "Đạt Nguyễn" <snapeandcandy@gmail.com> -- Sent: 2022-07-09 - 16:05 ----
>>
>> > Hi, I'm sorry, this is the first time I use a mailing list.
>> >
>> > I have never tried to resize the partition. I only used mkfs.btrfs
>> > once using the tutorial from
>> > https://linuxhint.com/install-and-use-btrfs-on-ubuntu-lts/ in pc A,
>> > and it did work fine.
>> >
>> > I have to admit that although I'm working in the tech area and have
>> > some knowledge of CS, filesystems are not my things. If the problem
>> > persists on sdb only, could I remove sdb and recover datas from sda?
>> >
>>
>> No
>>
>> The solution is to remove the partition sdb2 and resize sdb1 to fill the disk. What is on sdb2 today?
>>
>> I guess the problem actually exists on PC A, but the kernel is older and doesn't check for this condition.
>>
>> Regards,
>> Forza
>>
>> > On Sat, Jul 9, 2022 at 8:55 PM Forza <forza@tnonline.net> wrote:
>> >>
>> >> Hi,
>> >>
>> >> I see you didn't email the mailing list? Can you resend the message there? It is useful for others to see the problems and if there are solutions.
>> >>
>> >> Basically Btrfs thinks that sdb1 is much larger than it is. In fact it is thinking that sdb1 is just 2088 sectors smaller than the whole sdb. Since sdb1 starts at 2048 sectors, it means that the entire disk except for the last 40 sectors.
>> >>
>> >> How did this happen?
>> >>
>> >> Did you try to resize the partition at some point? Did you 'mkfs.btrfs' or do 'btrfs device add' /dev/sdb instead of /dev/sdb1?
>> >>
>> >> Thanks,
>> >> Forza
>> >>
>> >> ---- From: "Đạt Nguyễn" <snapeandcandy@gmail.com> -- Sent: 2022-07-08 - 17:52 ----
>> >>
>> >> > ~ ❯❯❯ sudo fdisk -l --bytes /dev/sdb
>> >> > Disk /dev/sdb: 1,84 TiB, 2000398934016 bytes, 3907029168 sectors
>> >> > Disk model: WDC WD20EFAX-68F
>> >> > Units: sectors of 1 * 512 = 512 bytes
>> >> > Sector size (logical/physical): 512 bytes / 4096 bytes
>> >> > I/O size (minimum/optimal): 4096 bytes / 4096 bytes
>> >> > Disklabel type: gpt
>> >> > Disk identifier: 6FD408DC-62C6-4C42-B960-0079D9793A69
>> >> >
>> >> > Device          Start        End    Sectors          Size Type
>> >> > /dev/sdb1        2048 3835273215 3835271168 1963658838016 Linux filesystem
>> >> > /dev/sdb2  3835273216 3907029134   71755919   36739030528 Linux filesystem
>> >> >
>> >> > ~ ❯❯❯ sudo fdisk -l --bytes /dev/sda
>> >> > Disk /dev/sda: 3,65 TiB, 4000787030016 bytes, 7814037168 sectors
>> >> > Disk model: WDC WD40EFAX-68J
>> >> > Units: sectors of 1 * 512 = 512 bytes
>> >> > Sector size (logical/physical): 512 bytes / 4096 bytes
>> >> > I/O size (minimum/optimal): 4096 bytes / 4096 bytes
>> >> > Disklabel type: gpt
>> >> > Disk identifier: C637A86C-4D63-564B-B087-9FD4BEE18A18
>> >> >
>> >> > Device          Start        End    Sectors          Size Type
>> >> > /dev/sda1        2048 7784630271 7784628224 3985729650688 Linux filesystem
>> >> > /dev/sda3  7784630272 7814037134   29406863   15056313856 Linux filesystem
>> >> >
>> >> > Thanks,
>> >> >
>> >> > On Fri, Jul 8, 2022 at 10:03 PM Forza <forza@tnonline.net> wrote:
>> >> >>
>> >> >>
>> >> >>
>> >> >> On 2022-07-08 14:18, Đạt Nguyễn wrote:
>> >> >> > Hi,
>> >> >> >
>> >> >> > I have 2 drives in mirror mode in pc A (ubuntu 18.04 server). A
>> >> >> > mainboard problem occurred in pc A, then I attached those 2 drivers
>> >> >> > into pc B (ubuntu 20.04 desktop) but cannot mount them. Here is the
>> >> >> > information.
>> >> >> >
>> >> >> > ~ ❯❯❯ uname -a
>> >> >> > Linux pc 5.13.0-52-generic #59~20.04.1-Ubuntu SMP Thu Jun 16 21:21:28
>> >> >> > UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
>> >> >> > ~ ❯❯❯ btrfs --version
>> >> >> > btrfs-progs v5.4.1
>> >> >> > ~ ❯❯❯ sudo btrfs fi show
>> >> >> > Label: 'data'  uuid: f6abe13d-a8da-4bf4-9a5c-402fec4a2bce
>> >> >> >      Total devices 2 FS bytes used 656.04GiB
>> >> >> >      devid    1 size 1.82TiB used 701.03GiB path /dev/sdb1
>> >> >> >      devid    2 size 3.62TiB used 701.03GiB path /dev/sda1
>> >> >> >
>> >> >> > The dmesg log is in the attached file. Basically it just tell
>> >> >> >
>> >> >> > [111997.422691] BTRFS info (device sdb1): flagging fs with big metadata feature
>> >> >> > [111997.422716] BTRFS error (device sdb1): open_ctree failed
>> >> >> >
>> >> >>
>> >> >> An important line was omitted:
>> >> >>
>> >> >> [  576.780013] BTRFS error (device sdb1): device total_bytes should be
>> >> >> at most 1963658838016 but found 2000397864960
>> >> >>
>> >> >> What does `fdisk -l --bytes /dev/sdb` show?
>> >> >>
>> >> >>
>> >> >> > Please help me recover my data.
>> >> >> >
>> >> >> > Thanks and regards.
>> >> >> > Dat
>> >>
>> >>
>>
>>


