Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4006D7562
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 09:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbjDEHaY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 03:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjDEHaW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 03:30:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0354687
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 00:30:20 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MplXp-1qBJbg3jjx-00q9k2; Wed, 05
 Apr 2023 09:30:18 +0200
Message-ID: <719a413a-6912-672b-d4d5-cf50c766d36e@gmx.com>
Date:   Wed, 5 Apr 2023 15:30:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Bug] Device removal, writes to disk being removed
Content-Language: en-US
To:     Torstein Eide <torsteine@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CAL5DHTE6ffo2PUdOEeN1OqaCen_an15L3suOXS4cNkz__kPzXQ@mail.gmail.com>
 <3af78c98-3d14-4145-c57e-2fc761fcd1ad@gmx.com>
 <CAL5DHTEw7H-iQuUyd+9d+eNicyn=ZZH3+x9QLogYo-hP91awgw@mail.gmail.com>
 <0b2d4582-84dd-b8d2-cfd0-5930cddbecca@gmx.com>
 <CAL5DHTF1bC5mDFu_fBjJarYW=gB_i0vOveyTfy6z2NxXv+Sg8Q@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL5DHTF1bC5mDFu_fBjJarYW=gB_i0vOveyTfy6z2NxXv+Sg8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QFZt/Y/z42aQADEzqlHm2Yo5PtQIjy1guVE+FeJa0QzUUcAzxrS
 WlApWcAsrFf7EJ8CyqEOAdOPLF1QDO9Wu+odr/plkxxJgxo0yQ2cnl5hft3bltX+rBSxc8r
 7Qq4w+tktINjU0ru1bK4GQF4cpQlrICgzCmiStUEa+464prCZ0HD5SRbYp3ptyYtxvfNuEE
 f4CAxOx43t/qxMrt31uaw==
UI-OutboundReport: notjunk:1;M01:P0:v18jvUOPEKs=;GHAcJzTuTJW9EPwohFaT5SjDIiU
 0Coa0DeFpUH1+9b3xdgvgakEbky4ScXiv8Nrc1qSQTPMdYVZTH4r1bOOArChumVc/Moqg9JXy
 G9J10fJcTnUAkkOXRxGRSwRxhJWoDt/sr3/bRQoVIdj/RQxxqKFQmr5c8aPtvH2Ye+u8W93Nk
 /n2QuxHSQ+9cV+rEAMhrSGoQ3PpT7Fxn1M+GrXLDYOoNITP2ZLd7t8AM6/y8R2ezw4iVtsQkZ
 bCKxkvEg0d97Dv8uV60ly1yZkM02zdDWOJsXXSSpEjmIWdoMwxFsP6LFEcLHNbr/cAT6vxPTL
 yJF5o3iZFgkijPpweWE2nMUvhun5MwwJbdAl2A4PxJWoHFhDTN7M3YxBQy9LD665Qx25nqaYX
 csUMMtn+Tng0OzI1+ZcaLhfzfa45iMjO/OvC/1NKD40ebdoLtXLkD3mgoYSjW69WTHyOqIpZK
 WH4tl3ZrzhyVnb8pO4/hnBQJ7p2u65lZ+V9Vn17Awj6oR6/saJ0c6poWxb84r3/BFOh0o40/I
 z63PJcJlmqTaLX7XTMvcmmTOrkQkWOb9xsPq+/eiUYL/WL9XdT1mO31GsY3Op5vvVOEWS0/Ru
 noCsdTDigjZvX9DbkQQgWSqy1xMqubOnYwp15STLpkQkB0lvMNENH5xrEqP4kKZWrrMkV2bO6
 L6qcr3rbJWPe/i/cK2V2MnhSu+WAUhEQu/hoC9usQ4aAfeX2FdhctL0ubTJ84YxjNsCGs1nSi
 lupHLkZ1g2d4C0/pQF1E7QmnFpsBy/yY+j8Qm3oHuzxPI03JIG88Yi9wmMlf8lrApntMyrrsr
 QkWfx6zSTDBfgXHnsAVzNoOIw4WGuLrmxOSvIx6b8/4GxEYrkuwUKcclswgc+GdXDQDwbKzlu
 ys7F4XEDFg0wwW/P+JEqALGFwfsdu0IxGOeQ4qD7nUG4mYhN+2oOVxGeOvxJ/uUsmnj8dpzvO
 VdyYz1eGBjXJygDxRo1WxTz+g/c=
X-Spam-Status: No, score=-2.6 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/5 15:01, Torstein Eide wrote:
> I understand that the device removal ioctl can only handle one device one time.
> 
> But can't it be solved with a flag on devices that says "This device
> is to be removed, don't write to it"? And the BIO, checks at mount
> time, and when a flag is updated, what disk it should write
> new/updated chunks to.

That's feasible, but would need quite some big changes to both chunk 
allocator and the ioctl interface itself.

This behavior change mostly means we split the device removal to two 
different phases, the marking and the real work.

And the extra bit may lead to unexpected ENOSPC, thus it's not something 
we can easily implement right now.

Thanks,
Qu

> 
> ons. 5. apr. 2023 kl. 08:53 skrev Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>
>>
>>
>> On 2023/4/5 14:11, Torstein Eide wrote:
>>> ons. 5. apr. 2023 kl. 00:52 skrev Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>>
>>>>
>>>>
>>>> On 2023/4/5 04:21, Torstein Eide wrote:
>>>>> There is a bug with:
>>>>> -  `btrfs device remove $Disk_1 $Disk_2 $volume`
>>>>>
>>>>> When multiple devices from a volume, it still writes to $Disk_2, will
>>>>> removing $disk_1.
>>>>
>>>> Device removal is done by relocating all the chunks from the target
>>>> device, ONE BY ONE.
>>>>
>>>> Thus it means when removing disk1, we can still utilize the space in disk2.
>>>>
>>>> In fact, even removing disk1, it's still possible to write data into it
>>>> until the last chunk is being relocated.
>>>>
>>>> Thanks,
>>>> Qu
>>>
>>> I think iterating over all chunks from the target device, ONE By ONE,
>>> is the only way to go.
>>>
>>> But is it best practice to utilize the space in disk2? When the user
>>> has told the system this device is to be removed.
>>
>> Unfortunately the device removal ioctl can only handle one device one time.
>>
>> This means above "btrfs device remove disk1 disk2 mnt", it's no
>> different than "btrfs dev remove disk1 mnt && btrfs dev remove disk2 mnt".
>>
>> Thus no matter if it's chunk or device, they are all handled ONE BY ONE,
>> and when deleting the first device we may still write into the 2nd device.
>>
>> Thanks,
>> Qu
>>
>>>
>>> illustrated below with RAID5/6, that is shared between all devices.
>>>
>>> | Device | Starting | -1 Device | -2 Device |
>>> |-------:|:--------:|:---------:|:---------:|
>>> |    SDA |     X    |           |           |
>>> |    SDB |     X    |     X     |           |
>>> |    SDC |     X    |     X     |     X     |
>>> |    SDD |     X    |     X     |     X     |
>>> |    SDE |     X    |     X     |     X     |
>>> |    SDD |     X    |     X     |     X     |
>>>
>>> Instead of:
>>> | Device | Starting | -1 Device | -2 Device |
>>> |-------:|:--------:|:---------:|:---------:|
>>> |    SDA |     X    |           |           |
>>> |    SDB |     X    |           |           |
>>> |    SDC |     X    |     X     |     X     |
>>> |    SDD |     X    |     X     |     X     |
>>> |    SDE |     X    |     X     |     X     |
>>> |    SDD |     X    |     X     |     X     |
>>>
>>> When the same chuck is on disk2.
>>>
>>> The same for disk1, when the user has told the system this device is
>>> to be removed, is it best practice to write to it?
>>>
>>> One of the most common reasons to remove a disk is when its dying, is
>>> then best practice to add more writes to it?
>>>>>
>>>>> ## Command used:
>>>>> ````
>>>>> btrfs device remove /dev/bcache5 /dev/bcache3 /volum1/
>>>>> ````
>>>>>
>>>>> ## iostat
>>>>> ````
>>>>> Device             tps    MB_read/s    MB_wrtn/s    MB_dscd/s
>>>>> MB_read    MB_wrtn    MB_dscd
>>>>> sdc (R1)       225.00        27.19         0.00         0.00
>>>>> 27          0          0
>>>>> sdd (R2)        94.00         0.00       105.56         0.00
>>>>> 0        105          0
>>>>> sde              324.00        27.19       113.06         0.00
>>>>> 27        113          0
>>>>> sdf               322.00        26.75       113.13         0.00
>>>>>     26        113          0
>>>>> sdg              310.00        26.00       108.06         0.00
>>>>> 26        108          0
>>>>> sdh              325.00        27.19       113.06         0.00
>>>>> 27        113          0
>>>>> ````
>>>>>
>>>>> ## uname -a:
>>>>> ````
>>>>> Linux server2 5.15.0-69-generic #76~20.04.1-Ubuntu SMP Mon Mar 20
>>>>> 15:54:19 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
>>>>> ````
>>>>>
>>>>> ## btrfs version
>>>>> ````
>>>>> btrfs-progs v5.4.1
>>>>> ````
> 
> 
> 
