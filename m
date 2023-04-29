Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950E86F26FA
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Apr 2023 00:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjD2WE4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 18:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjD2WEz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 18:04:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673EB1728
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 15:04:51 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdefJ-1qRfTD1piL-00ZczT; Sun, 30
 Apr 2023 00:04:49 +0200
Message-ID: <b52d8f32-a287-aeff-0fa8-81ae55c8de21@gmx.com>
Date:   Sun, 30 Apr 2023 06:04:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Tree block corrupted, bad tree block start
To:     Gunnar Grim <gunnar1@grim.se>, linux-btrfs@vger.kernel.org
References: <6553b40d-b674-3731-8644-b738c0ee21a0@grim.se>
 <aa6bfea9-b103-ed1a-102c-48a491b20dc2@gmx.com>
 <01f284f1-4aac-c732-1130-4846fbbe4a50@grim.se>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <01f284f1-4aac-c732-1130-4846fbbe4a50@grim.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xwQLSbbUTz3aeV72ai+RgQHH4lJrhRyGAKTbdbSXsskKf37/Tsm
 ZwKEVY0IJ9R72LnxuGbI92X5k+0YwUmnCC4wwRn/KWMeqIGuG2XRZpAYzEPQNykbfs6H7O3
 DPehjj6qcaZTNU+mJnzv5c49oWOlhttdTLDOww+PO/gSgkaAAwxU2MyTSXX6t54UX7tmdi3
 0q/+6JrEWga0i+5RIf+kA==
UI-OutboundReport: notjunk:1;M01:P0:Dkl2rb+G43A=;vXehOTK0NA4udGGxmdCJV81M3VO
 orvdV9RGCyxTYLx+1mlecjDydi41nQf0XWoMNRCaGk3dV23YP1U4fy/YurmZcbSThR+Hg56f6
 u6Gq7AXimXY66svtm4ZzEx1EGRsniBen0kjodMAHOLfj/q3BmRKmWLAAJNbZcOKaUROUzXsvJ
 aoUuRLD4sxyu9OUtzDXElpd0deUUsct8p6YoD46i6KlEE8R8zrPg77WRpQuZp6wUWN00ye9PS
 p8Epvcmd7B956jnJtjyFUFsK+pSdlgzGo5lZ8Jm7GojkVgmoGN12v25XRgIczBpNQkypyaUf8
 kzaVccrUKwvEgRfoULnarCgkT123o7YzobRr8CqEiJJ1UpurkvIeuRoSisNKwz2ns8KHLVFc7
 cwgFjZkTw4g3CVcsGv9VkJklYF4IapmWUv0IFrcnnyWSmEftzyXfclqPzSMWBkxYb2kOZ/Tdq
 wHfGVMGXp0Z12MNTUfabf7R5gxlnzrTZa2RabWTOmg8tDJIhSWSciyPLyhd13tg6reIdVbb1L
 YKNkODpw1VNs8Nm6s2hEa+wTQhyUIeGlZscHjwW8nyaquaRGyQS/R20khsM32YTx+XDL9jOWV
 hf0MaUuUNqd3tbraONZ6mBDTmOL7IiEjQJTR4sDgC9pjsYmajMh5rX6nfYlkJJDVuLJhkJ/+F
 cTmY9Me4OlAMlGVDbtbIFUz1yNB+9Mm6vQ3xLRF+sEUoJgXoGNygGWjT/UwxGkpiISjKiF7f/
 1RGH8cV4zxyqpbUodkh6EdrGDo71t+pO6TTXCeHueo8kioGnuK+K8hbR2vQTH644W+Ige96OT
 2mtzxNlqv394v1G6/dLCCtYhWKPV/hB9bMv2HdrMu0NHbqGx+T2Hz9fPN8Cjpqk8noHQNcznt
 ZN0r8qcgxLPMrQMJRBzLgjCXF5Xa37lduc9++0LP/9Pc2fTc3ZvDfX39SDktyIKNPZMvLcIKa
 G+S/UkcryRxco1LMR27fmUtL0sg=
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/29 20:09, Gunnar Grim wrote:
> Subvolume 7761, that is corrupted, seems to be deleted;
> 
> btrfs subvolume list -d /|grep 7761
> ID 7761gen 3027749 top level 0 path DELETED
> 
> Any way to get rid of the deleted subvolume?

If it's already deleted, "btrfs subv sync" should be able to wait for 
the full deletion of the subvolume.

Thanks,
Qu
> 
> /Gunnar
> 
> 
> On 2023-04-29 01:58, Qu Wenruo wrote:
>>
>>
>> On 2023/4/29 01:20, Gunnar Grim wrote:
>>> Hi!
>>>
>>> My clonezilla cloned root partition on my new SSD logs an error once 
>>> every minute:
>>
>> Not sure if clonezilla is doing a binary dump or understand the btrfs 
>> on-disk format and do a proper extent level copy.
>>
>>>
>>> BTRFS error (device nvme0n1p1): bad tree block start, want 
>>> 1603822157824 have 0
>>
>> This means some tree blocks is not properly written, thus it only got 
>> all zeros.
>>
>>
>>>
>>> The partition mounts fine and everything seems to work except for the 
>>> above logging and that both balance and scrub fails.
>>>
>>> I have tried to find if there is an unreadable file with
>>>      find /xxxx -type f -exec cp {} /dev/null ;
>>> where xxxx is all directories in / except dev, proc and sys. No error 
>>> was reported.
>>> Apparently all files on the root partition can be accessed and fully 
>>> read, still I get all those BTRFS errors logged.
>>>
>>> I don't dare run btrfs check --repair because of allthe warnings 
>>> here: https://btrfs.readthedocs.io/en/latest/btrfs-check.html
>>>
>>> Should I run btrfs check --repair or is there some less dangerous way 
>>> to fix the problem?
>>
>> According to the readonly check run, the corruption happens in a level 
>> 2 tree block, which means quite a lot of contents are lost in 
>> subvolume 7761.
>>
>> --repair won't be able to do much.
>>
>> However your scrub result is also very interesting. It only shows that 
>> tree block is corrupted.
>> This means the child tree blocks are in fact intact.
>>
>> In theory we are able to rebuild that level 2 tree block using all its 
>> child nodes, but it's not something done in btrfs check yet.
>>
>> If this is really caused by clonezilla, I'd like to know what's the 
>> method they go when cloning a btrfs, as it may be a bug in the cloning 
>> tool.
>>
>> Thanks,
>> Qu
>>
>>> TIA,
>>> Gunnar
>>>
>>> Below is the output from various commands:
>>>
>>> Output of uname -a
>>>
>>> Linux gunnar 5.14.21-150400.24.60-default #1 SMP PREEMPT_DYNAMIC Wed 
>>> Apr 12 12:13:32 UTC 2023 (93dbe2e) x86_64 x86_64 x86_64 GNU/Linux
>>>
>>> Output of btrfs --version
>>>
>>> btrfs-progs v5.14
>>>
>>> Output of btrfs fi show
>>>
>>> Label: none  uuid: 02e6a056-947f-41c5-a1f0-bf3a613864d4
>>>          Total devices 1 FS bytes used 66.22GiB
>>>          devid    1 size 202.86GiB used 80.03GiB path /dev/nvme0n1p1
>>>
>>> Label: none  uuid: 727abbd3-c7cc-4eaf-bf56-4ae088176abc
>>>          Total devices 1 FS bytes used 399.20GiB
>>>          devid    1 size 1.62TiB used 401.02GiB path /dev/nvme0n1p2
>>>
>>> Label: none  uuid: 38ba5ab4-cba0-40ec-ba77-d0c7bd3780aa
>>>          Total devices 1 FS bytes used 22.20GiB
>>>          devid    1 size 60.00GiB used 31.07GiB path /dev/sda3
>>>
>>>
>>> Output of btrfs fi df /
>>>
>>> Data, single: total=77.00GiB, used=63.86GiB
>>> System, single: total=32.00MiB, used=16.00KiB
>>> Metadata, single: total=3.00GiB, used=2.37GiB
>>> GlobalReserve, single: total=188.12MiB, used=0.00B
>>>
>>> Output of dmesg
>>>
>>> [ 9612.419056] BTRFS error (device nvme0n1p1): bad tree block start, 
>>> want 1603822157824 have 0
>>> [ 9643.152148] BTRFS error (device nvme0n1p1): bad tree block start, 
>>> want 1603822157824 have 0
>>> [ 9673.884090] BTRFS error (device nvme0n1p1): bad tree block start, 
>>> want 1603822157824 have 0
>>> [ 9704.596570] BTRFS error (device nvme0n1p1): bad tree block start, 
>>> want 1603822157824 have 0
>>> [ 9735.336245] BTRFS error (device nvme0n1p1): bad tree block start, 
>>> want 1603822157824 have 0
>>> [ 9766.026138] BTRFS error (device nvme0n1p1): bad tree block start, 
>>> want 1603822157824 have 0
>>> [ 9796.751880] BTRFS error (device nvme0n1p1): bad tree block start, 
>>> want 1603822157824 have 0
>>> [ 9827.464856] BTRFS error (device nvme0n1p1): bad tree block start, 
>>> want 1603822157824 have 0
>>> [ 9858.188082] BTRFS error (device nvme0n1p1): bad tree block start, 
>>> want 1603822157824 have 0
>>> [ 9888.911285] BTRFS error (device nvme0n1p1): bad tree block start, 
>>> want 1603822157824 have 0
>>>
>>> Output of btrfs-check /dev/nvme0n1p1 (unmouted from rescue USB)
>>>
>>> Opening filesystem to check...
>>> Checking filesystem on /dev/nvme0n1p1
>>> UUID: 02e6a056-947f-41c5-a1f0-bf3a613864d4
>>> The following tree block(s) is corrupted in tree 7761:
>>>      tree block bytenr: 1603858104320, level: 2, node key: (11723738, 
>>> 96, 3471)
>>> found 70855102464 bytes used, error(s) found
>>> total csum bytes: 58760784
>>> total tree bytes: 2535309312
>>> total fs tree bytes: 2338357248
>>> total extent tree bytes: 114114560
>>> btree space waste bytes: 439342803
>>> file data blocks allocated: 682434134016
>>>   referenced 231583764480
>>>
>>> Output of btrfs balance start
>>>
>>> [  +2,912330] BTRFS info (device nvme0n1p1): balance: start -d -m -s
>>> [  +0,000091] BTRFS info (device nvme0n1p1): relocating block group 
>>> 1611841667072 flags data
>>> [  +0,777521] BTRFS info (device nvme0n1p1): found 10 extents, stage: 
>>> move data extents
>>> [  +0,113849] BTRFS info (device nvme0n1p1): found 10 extents, stage: 
>>> update data pointers
>>> [  +0,060942] BTRFS info (device nvme0n1p1): relocating block group 
>>> 1611808112640 flags system
>>> [  +0,000052] BTRFS error (device nvme0n1p1): bad tree block start, 
>>> want 1603822157824 have 0
>>> [  +0,033844] BTRFS info (device nvme0n1p1): found 1 extents, stage: 
>>> move data extents
>>> [  +0,034096] BTRFS info (device nvme0n1p1): relocating block group 
>>> 1603822157824 flags metadata
>>> [  +0,020984] BTRFS error (device nvme0n1p1): bad tree block start, 
>>> want 1603822157824 have 0
>>> [  +0,000093] BTRFS error (device nvme0n1p1): bad tree block start, 
>>> want 1603822157824 have 0
>>> [  +0,013843] BTRFS info (device nvme0n1p1): balance: ended with 
>>> status: -5
>>>
>>> Output of btrfs scrub start -B /
>>>
>>> scrub done for 02e6a056-947f-41c5-a1f0-bf3a613864d4
>>> Scrub started:    Fri Apr 28 10:22:16 2023
>>> Status:           finished
>>> Duration:         0:00:22
>>> Total to scrub:   80.03GiB
>>> Rate:             3.01GiB/s
>>> Error summary:    csum=1
>>>    Corrected:      0
>>>    Uncorrectable:  1
>>>    Unverified:     0
>>> ERROR: there are uncorrectable errors
>>>
>>>
