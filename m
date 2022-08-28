Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723315A3D0A
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Aug 2022 11:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiH1JzE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Aug 2022 05:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiH1JzD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Aug 2022 05:55:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB1F1C13B
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Aug 2022 02:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661680496;
        bh=qZ1fbAIcTgLLljqW5fJimqKsXlLCqlPoUXQYzFfSPlE=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=TQX0C4KAmyTm1pV8QuzMpscXdYQjjm/CIFy/D+wzCLTnDs/Q+TAp6/TEMxAiCnZbL
         h5Z2owF6yEe5IWgb03Cn6euJrL5iWG1PUl8/N8iU/K4YjDH+8jhpcguaLNVTb75mZg
         WutEQKQDheoOoNIEFFt/uuFUU3IhwgqwRzQcqL/4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSbx3-1oqBlO3BYP-00T0PT; Sun, 28
 Aug 2022 11:54:56 +0200
Message-ID: <76515426-abd4-2ed7-ea58-db1ba7e3a123@gmx.com>
Date:   Sun, 28 Aug 2022 17:54:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     li zhang <zhanglikernel@gmail.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <1661357103-22735-1-git-send-email-zhanglikernel@gmail.com>
 <c3dc352c-8393-c564-4366-42fb9ece021e@gmx.com>
 <PH0PR04MB7416B660C501F73F47E7D4159B729@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAAa-AGk67Ex8woPz=F-P-GdsY1i2N0w==AP9Bk2YpH=Yk+vPdg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] Make btrfs_prepare_device parallel during mkfs.btrfs
In-Reply-To: <CAAa-AGk67Ex8woPz=F-P-GdsY1i2N0w==AP9Bk2YpH=Yk+vPdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zMO7DovjDhjBqLioeLks/dQD5W9WmEaE0WBLOkB8L1UO/J1lnrH
 LetwE+nme9xgjc+u2V9j3TZ4hP0Ds96o2jvx14ixCnkDsMcLiovYGvQXiPS6j0i8YSIdIoV
 AFG4hcEneHWvNrjntrAMegWH0n2aZJ2Ibv8GD+KvnyRPkzAAffqAVAVMIKICqILR5PXhRqK
 bxQah0unGIEFXEQ4qfHxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uWgJXKGA4Z4=:4chuu/8P9p8jEpB+kR7D99
 Zya0dXUKwTDOk16b9J2rKH/toiiGmSecWEovpnRbo98OtvWAp8SEQFtLx8aamdEH7mRWt7j4i
 MBZCewVKjtmcmKSJx8Opbw8pgKDFd7towdaWCgRlzMtoBRy3JIiCq/2d8Z6iuwtQxIdEuTTmp
 exKB+oV2L7iafdv/SIDmqa8KST8p60ZYc5Hv9jWnJ0m05d1CDtH7Utoh+fYQJflGQfEBgA4ir
 bZrkYNGs+2UCm+9pre7puBgLUp+oYzbeWgGwBdoBV/0nv0J5B4XGa9ARAQqLg5uqkjTmf2LN+
 8cV0tA6yjaSIc+gVFiOBWXB4mY3ynXwCQtpVfu212DCuP1y7N5MDiRPoXmvMOJceBewf40abK
 FXKJkuxvqS1u8Gs+NjzHdpvAD5gJcPusUmBHqPbGunmJunixPQjfTQxX0r1si9XiXRdtMn51n
 Vfzj+A60FREV97S5iNEutUkF0cZsrLKVCZqOHfD86Sp7eQ/axu7BC9wAROeTGWxwMLzazu37D
 a8LLa6EGZgoFMFPwPovGcR1l+j2hbiI5NPvV7Po9S5ffECSOqG8CmLSWOGbQukEhExoVa0r1Z
 jpVz38G/CSzODdmQhA+a7z4Ae4Kv6uGuf9phbSkkvegJr5yQMgzBGi1eQb/1jgkVmuxM6CAr4
 rZEhoSA+elGhzDhhAjWUGS/0c+AuhR1IbNv2D+FSbJoNXrmXHPcMwLZ6ZOz9Hc4tR8h//zPZC
 L2Es7TOvNrunny9M7c6bxZnTtplWgMxIazeNrNNQObcMtRmBBZXiltPyURHXJkLjeVc6nLJpb
 HFUtoLMFi0vmlnyjFX95QN+DB2TjY1PRlr5kmEDOa3/lAEiAF96PJWFcokGaCYijPLA2xmzRu
 l3rBe3gzFLLfc6cTVccZOFk4DXnbx1mVIbaY2xURDq+mDXsHvPDYmlbv2y8BLZ7NTlglgw5LR
 2OIqELWgY5IuBbZkJG0NgN/maf4pshLsiC/oOJF4gJ1tqmxD7mw1eTJpkZ34RXOmI7+hs1QE2
 SG95oLNOL3egjmmsPBNYxPbWVzLiiStoO4mXkUP7lxGopj7O+glrIt3GrgFC11mk2Ejpn25/b
 j4pq9Ro5Mepv8ngVYkxf7XxnFLuRm2Ai5dZ5WJYERwHb614tyqm6Ymd+Q==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/28 16:53, li zhang wrote:
> Hi, I'm a bit confused, do you mean if you open a zoned device
> without O_DIRECT it will fail?

Not a zoned device expert, but to my understanding, if we write into
zoned device, without O_DIRECT, there is no guarantee that the data you
submitted will end at the same bytenr you specified.

E.g. if you do a pwrite() with a 1M buffer, at device bytenr 4M.

Without O_DIRECT, the zoned code can re-locate the bytenr to any range
after the write pointer inside the same zone.

AKA, for zoned device, without O_DIRECT (queue length 1), you can only
known the real physical bytenr after the write has fully finished.

(The final physical bytenr is determined by the zoned device, no longer
the write initiator).

>
> I tested and found that if I open a device with the O_DIRECT flag
> on a virtual device like a loop device, the device cannot be written
> to, but with or without O_DIRECT, it works fine on a real
> device (for me, I only test A normal block device since I don't have
> any zoned devices)

IIRC currently there is no zoned emulation for loop device.

If you want to test zoned device, you can use null block kernel module,
with fully memory backed storage:

https://zonedstorage.io/docs/getting-started/nullblk


Or go a little further, using tcmu-runner to create file backed zoned
device:

https://zonedstorage.io/docs/tools/tcmu-runner

>
> If we use the same flags for all devices,
> does that mean we can't use mkfs.btrfs
> on both real and virtual devices at the same time.
>
>
> Below is my test program and test results.
>
> code(main idea):
> printf("filename:%s.\n", argv[1]);
> int fd =3D open(argv[1], O_RDWR | O_DIRECT);
> if (fd < 0) {
>       printf("fd:error.\n");
>       return -1;
> }
> int num =3D write(fd, "123", 3);
> printf("num:%d.\n", num);

O_DIRECT requires strict memory alignment, obviously the length 3 is not
properly aligned.

Please check open(2p) for the full requirement.

For mkfs usage, all of our write is at least 4K aligned, thus O_DIRECT
can work correctly.


Back to btrfs-progs work, I'd say before we do anything, let's check all
the devices passed in to determine if we want zoned mode (any zoned
device should make it zoned).

Then we can determine the open flags for all devices, and for regular
devices, O_DIRECT mostly makes no difference (maybe a little slower, but
may not even be observable).

Thanks,
Qu


> close(fd);
>
> result:
> $ sudo losetup /dev/loop1 loopDev/loop1
> $ sudo ./a.out /dev/loop1
> filename:/dev/loop1.
> num:-1.
> # cannot write to loop1
>
>
> Thanks,
> Li Zhang
>
> Johannes Thumshirn <Johannes.Thumshirn@wdc.com> =E4=BA=8E2022=E5=B9=B48=
=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 16:31=E5=86=99=E9=81=93=EF=BC=9A
>>
>> On 25.08.22 07:20, Qu Wenruo wrote:
>>>> +                    if (zoned && zoned_model(file) =3D=3D ZONED_HOST=
_MANAGED)
>>>> +                            prepare_ctx[i].oflags =3D O_RDWR | O_DIR=
ECT;
>>> Do we need to treat the initial and other devices differently?
>>>
>>> Can't we use the same flags for all devices?
>>>
>>>
>>
>> Yep we need to have the same flags for all devices. Otherwise only
>> device 0 will be opened with O_DIRECT, in case of a host-managed one an=
d
>> the subsequent will be opened without O_DIRECT causing mkfs to fail.
