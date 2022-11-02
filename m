Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD301615C63
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Nov 2022 07:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiKBGlo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Nov 2022 02:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiKBGll (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Nov 2022 02:41:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85CE264AE
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 23:41:39 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MF3HU-1onwe8449Q-00FSrh; Wed, 02
 Nov 2022 07:41:37 +0100
Message-ID: <79c5a6b1-3ad1-307a-97e1-f6c0980e70f1@gmx.com>
Date:   Wed, 2 Nov 2022 14:41:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: BTRFS error (device md127): parent transid verify failed on
 981041152 wanted 1185298 found 1183981
Content-Language: en-US
To:     Purevdorj Nayanbuu <nrjnapu@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAKcKizKk5tkk1sZJjgOUh=pq6QOAM=3taBNx_S+1gAV+_cQkxw@mail.gmail.com>
 <CAKcKizJ=DCHoKRho=TPfTV63fe8jn4ZLKpvDRkLrwRdvU0oK6w@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAKcKizJ=DCHoKRho=TPfTV63fe8jn4ZLKpvDRkLrwRdvU0oK6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NMKi27nk5NMgLsyxRW2TEORXghUDvkdb3b0EiQy5+rXvCXI3A5t
 nesHzuK10O5H3mbxo2kukbPKeMcGm4uFWnDxex4vkWRxq2RJo+2z8OBGS3EvHw45DmRZ18t
 07RbGxnLbWY0Sr4F7fDaQKZLNKJn4uFz68sT0QyxCVfvr19hehRK0xFjYV8OSCvHlH/UF0R
 /DZ7EhTtFElCxov0otUmg==
UI-OutboundReport: notjunk:1;M01:P0:N3B8SWZUYz8=;BBB6Rrx6HmHL+ghqvUSSfzVVylI
 WhXUB6POJ9cx+vmaUzktwbSh/Wpvyqj0GlVqFQXiUOmY7REmgAzYFbUSiBbhohgX5i8N1ZM5N
 MUSYsccorf7oVN+/XDdywu9Fy8bduWyMZIhfVNcoMWP6Q9J1KTru2kWwxgmxUAQTY1/kCtKLi
 QNM4xNUMIZpJKSrhZG0Bixxd01gCIaAYBSvrfZ27bl3IoDXf6QUaHyV7Bbx8oIJPNhw6wDq/H
 kCdb6UfvFBX541/vd+b+nnlgbtSms7i2zHzNbm5x77h5/3jGU3bSypv2OLanct9MLUNZJGrx8
 hqNX+SHX0GeGDygAR+Sv6KuIzHBjFseOoOSCpnujext8OIusw3H15tnKDtlHQl4m9TUTp+WJW
 ZjP382Gxnpv6cfkf2z/eHBQC8zjyFZrZ/Cfv5mUaS5KBVG43XvWq6k34mBum55yWHuBqi/nla
 6six9lLxzaCSleWSmOD40d5nlTAiuGN5naY+8Oe+duyZap95lV+Qegs2xuiBNWaf6iXAtqu9f
 oH9jV0RZX3f35/vaoVZZTQaSGHHv/8Ecaz0lVeDqf+uvXXvexbsc3g5IjSuM+cPPdNdNyVc+m
 wVjFvg+tR33D/V9obg1UMTMNJ2ShGlgziXD1FumDXZtP3Trejh+u7Leu+c2oH61Fd+0cAtcY/
 qdytLV4PR69GIeNKk6Go7y5L/v5khCJtqp8m+YQ6XhS3EoE0JQIfRM4bXpRinFZPpkDnUvZmC
 rEcxMroaiSyAnEyMLbKkBPHvgjaCJx5XEPn/6BTJVd615i0wEq/Yw/gA0EQkiB5cFyhHC+SA4
 dAY4nMkloVUgt8fvKIMCdDyC+rUHqe+sg3FCoOm8NUFSj5O+DxtjOrqaXRYPhuWTk8G4rUIMl
 SRf67ukLd9HcoFvdWVtQLdY3pXRgSxn0XY/sfVerr3eM7XCW2FL6DYs0HAV8jUxcwiQxj0crL
 NUluczpQFkccwxqByUGK1Cdej4dx+Fm49liZnyEFNbdMH4BK4dIoUnAF8aZSPxDsaZq81g==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/2 14:29, Purevdorj Nayanbuu wrote:
> Hi BTRFS experts
> 
> I lost my data on Netgear ReadyNAS suddenly.
> 
> It seems all four HDD drives are fine without any SMART errors, but
> /dev/md127 cannot be mounted due to "parent transid verify failed"
> error.
> 
> I would greatly appreciate it if you could help me to restore my RAID
> or salvage the data.
> 
> Full set of logs from the Readynas is available from the below link
> https://drive.google.com/file/d/1XxeJ0PyTf_vqdvSymsXvtQIQ8ZfTPpc9/view?usp=share_link
> 
> Also, attached please find dmesg.log.
> 
> root@manai-nas:~# uname -a
> Linux manai-nas 4.4.218.x86_64.1 #1 SMP Mon Mar 14 21:33:09 UTC 2022 x86_64 GNU/
> Linux
> root@manai-nas:~# btrfs --version
> btrfs-progs v4.16
> root@manai-nas:~# btrfs fi show
> Label: '5e26dfbe:root'  uuid: d65e52ff-db9a-4268-90c1-70bd48e654b3
>          Total devices 1 FS bytes used 1011.57MiB
>          devid    1 size 4.00GiB used 2.05GiB path /dev/md0
> 
> Label: '5e26dfbe:data'  uuid: b818aade-1706-45fa-ba5c-74d66392f605
>          Total devices 1 FS bytes used 1.48TiB
>          devid    1 size 8.17TiB used 1.49TiB path /dev/md127

The raid is not handled by btrfs, but mdraid.

This brings mixed result.
On one hand, it won't provide the full potential to let btrfs to choose 
how to recover.

On the other hand, btrfs RAID56 has its own problems...

> 
> root@manai-nas:~# mount -t btrfs -o ro /dev/md127 /mnt
> mount: /dev/md127: can't read superblock
> 
> [Thu Oct 27 22:27:49 2022] md127: detected capacity change from 0 to
> 8986880507904
> [Thu Oct 27 22:27:49 2022] Adding 1044476k swap on /dev/md1.
> Priority:-1 extents:1 across:1044476k
> [Thu Oct 27 22:27:49 2022] BTRFS: device label 5e26dfbe:data devid 1
> transid 1185297 /dev/md127
> [Thu Oct 27 22:27:50 2022] BTRFS info (device md127): has skinny extents
> [Thu Oct 27 22:27:52 2022] BTRFS info (device md127): start tree-log replay
> [Thu Oct 27 22:27:52 2022] BTRFS error (device md127): parent transid
> verify failed on 981041152 wanted 1185298 found 1183981
> [Thu Oct 27 22:27:52 2022] BTRFS error (device md127): parent transid
> verify failed on 981041152 wanted 1185298 found 1183981
> [Thu Oct 27 22:27:52 2022] BTRFS warning (device md127): failed to read log tree

Thankfully this is the least problematic case, just log tree.

You can zero the log:

# btrfs rescue zero-log /dev/md127

And then try mount it again, if that's the only problem, it should mount 
without problem, and you can scrub to verify your data.

Thanks,
Qu

> [Thu Oct 27 22:27:53 2022] BTRFS error (device md127): open_ctree failed
> [Thu Oct 27 22:27:54 2022] NFSD: Using /var/lib/nfs/v4recovery as the
> NFSv4 state recovery directory
> [Thu Oct 27 22:27:54 2022] NFSD: starting 90-second grace period (net
> ffffffff88d782c0)
> [Thu Oct 27 22:28:20 2022] nfsd: last server has exited, flushing export cache
> [Thu Oct 27 22:28:20 2022] NFSD: Using /var/lib/nfs/v4recovery as the
> NFSv4 state recovery directory
> [Thu Oct 27 22:28:20 2022] NFSD: starting 90-second grace period (net
> ffffffff88d782c0)
> 
> Thanks
> 
> 
> 2022年11月1日(火) 18:27 Purevdorj Nayanbuu <nrjnapu@gmail.com>:
>>
>> Hi BTRFS experts
>>
>> I lost my data on Netgear ReadyNAS suddenly
>>
>> It seems all four HDD drives are fine without any SMART errors, but
>> /dev/md127 cannot be mounted due to "parent transid verify failed"
>> error.
>>
>> I would greatly appreciate it if you could help me to restore my RAID
>> or salvage the data.
>>
>>
>> root@manai-nas:~# uname -a
>> Linux manai-nas 4.4.218.x86_64.1 #1 SMP Mon Mar 14 21:33:09 UTC 2022 x86_64 GNU/
>> Linux
>> root@manai-nas:~# btrfs --version
>> btrfs-progs v4.16
>> root@manai-nas:~# btrfs fi show
>> Label: '5e26dfbe:root'  uuid: d65e52ff-db9a-4268-90c1-70bd48e654b3
>>          Total devices 1 FS bytes used 1011.57MiB
>>          devid    1 size 4.00GiB used 2.05GiB path /dev/md0
>>
>> Label: '5e26dfbe:data'  uuid: b818aade-1706-45fa-ba5c-74d66392f605
>>          Total devices 1 FS bytes used 1.48TiB
>>          devid    1 size 8.17TiB used 1.49TiB path /dev/md127
>>
>> root@manai-nas:~# mount -t btrfs -o ro /dev/md127 /mnt
>> mount: /dev/md127: can't read superblock
>>
>> [Thu Oct 27 22:27:49 2022] md127: detected capacity change from 0 to
>> 8986880507904
>> [Thu Oct 27 22:27:49 2022] Adding 1044476k swap on /dev/md1.
>> Priority:-1 extents:1 across:1044476k
>> [Thu Oct 27 22:27:49 2022] BTRFS: device label 5e26dfbe:data devid 1
>> transid 1185297 /dev/md127
>> [Thu Oct 27 22:27:50 2022] BTRFS info (device md127): has skinny extents
>> [Thu Oct 27 22:27:52 2022] BTRFS info (device md127): start tree-log replay
>> [Thu Oct 27 22:27:52 2022] BTRFS error (device md127): parent transid
>> verify failed on 981041152 wanted 1185298 found 1183981
>> [Thu Oct 27 22:27:52 2022] BTRFS error (device md127): parent transid
>> verify failed on 981041152 wanted 1185298 found 1183981
>> [Thu Oct 27 22:27:52 2022] BTRFS warning (device md127): failed to read log tree
>> [Thu Oct 27 22:27:53 2022] BTRFS error (device md127): open_ctree failed
>> [Thu Oct 27 22:27:54 2022] NFSD: Using /var/lib/nfs/v4recovery as the
>> NFSv4 state recovery directory
>> [Thu Oct 27 22:27:54 2022] NFSD: starting 90-second grace period (net
>> ffffffff88d782c0)
>> [Thu Oct 27 22:28:20 2022] nfsd: last server has exited, flushing export cache
>> [Thu Oct 27 22:28:20 2022] NFSD: Using /var/lib/nfs/v4recovery as the
>> NFSv4 state recovery directory
>> [Thu Oct 27 22:28:20 2022] NFSD: starting 90-second grace period (net
>> ffffffff88d782c0)
>>
>> Thanks
