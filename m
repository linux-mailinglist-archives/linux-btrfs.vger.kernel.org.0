Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031AA4C61C9
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 04:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbiB1D2I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Feb 2022 22:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiB1D2H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Feb 2022 22:28:07 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A304E5F74
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 19:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646018841;
        bh=ILhlWz1NEhgh4BHDCi8y8RiOWOdU4WpmwRaBaNSaLRs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=akNexa/8Jk2PtyYWusiOxan+OClg9UXls2fOqGWrhpSqmQGgrZZBE6CVCI+7RZN4a
         YEQAnQ7VxjQqCr6Q0DXAdZSPNT8+0VoteO12No5Kls+nhIBaeYPtk6wH2o6WrwdTGv
         BzSJaF9k3YBgW8s1GjA+yL0dTDRbs1tMAmkMyM3w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiJZO-1nsw5m2Mkg-00fOQG; Mon, 28
 Feb 2022 04:27:21 +0100
Message-ID: <4661c891-b15e-3a8f-6b98-f298e104262e@gmx.com>
Date:   Mon, 28 Feb 2022 11:27:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Seed device is broken, again.
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
References: <88176dfc-2500-1e9c-bac0-5e293b2c0b5c@suse.com>
 <20220225114729.GE12643@twin.jikos.cz>
 <56a6fe34-7556-c6c3-68da-f3ada22bd5ba@gmx.com>
 <YhkrfyzmCgOGG+5n@relinquished.localdomain>
 <f4525052-8938-42f9-543d-c333200353dd@gmx.com>
 <43aea7a1-7b4b-8285-020b-7747a29dc9a6@oracle.com>
 <00f162f7-774c-b7d4-9d1f-e04cc89b2aee@gmx.com>
 <508772bc-237a-552b-5b63-80827a5b268a@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <508772bc-237a-552b-5b63-80827a5b268a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hvej+3rp0qOOaA6lOmGKlutMpUGUyRFpXJwuRL1rBpWUCEk5/D+
 OEwm2CCc+7lvrLqAkcoaqdiK4PlVRff6vDVHfaWs+2FsfRCWpdLmKzBYOhOQ/coQ47wqaKW
 XCw8VKWA5U4e6XCRT1bnudux/Vat1tNWJDvxHgFn+dyJvXeogZmiaHHWo5Zh8BistKblQqr
 E0M/Z5usaf0tn6wCgMmHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PfZErEu3OpE=:+TVQrz6Ilk7bJmxZCbuNbE
 MHFzfgY6lE23hGTP3aeHblmPxqogLs2QHEfmLp855Ku1LvZ3GoP9yKX3jbzDF7kwa2icLFx2/
 gCyhs9eY9R45xaliU+BZKKP6OYC7kfsOW3fqujYeDgmz1jPm5X6U2ceMfYRxM7f9MuD3XArMU
 cVFqih/ScEw/ZufD40EnllOiWS9eDEcYoNAoO/yNWrsS2NnqAL2r5UqviODd4iS0pHqJt8VBO
 FAPAepVTiraa+c08ue/aZgRSsnr/Dty2+xsWdlXRbX2NaueOBnOy9P6uIOWk+BBcDq2wSKyCP
 4VmYksOc5PIToSr83uYl/U/xZiFHfP7lhLUtLwOCIbOWI3PYXFCvhCIE3aRRYRXnM86wsmn6N
 SHQPjb/g0UTWpS5c6vJZQPMi5AelRFbDy72jK7iZfC2ukV5xWZ2TAt501Vtat/WTQ82tAZOih
 DTirY6JJJniLaL0Ucsn3IV1flSnPO0wqsS/q0ofHvDe0ZgjwUA8JoHLOTTiZkKLYfOTSJ1J6v
 WvlOZa7Yg5a9fGOMDKk1ydYznZQCh662L5Uu11VC2jgxU+ReQmr8p0NuqGpQ6PcLCic68g9gd
 4DkL8b2JwJLNk+Mvky2MIrIRzqfbTEFbyukIBInzu+Kp0cENRCtBZb/nHuOS8biJtpE6evOOO
 gqQkAINcOwhC4S9b747JjRYcL14NL622Z58bE33Cyn8PrSMaJI3HX/5FwmtG4gsOOguOBQBu4
 hJc/mTo2IwoCufemIlH35ZWoqmJ6fbeOqoLLZiBzcY8aE4fKngcIlQF4qffh/NSeauIOsjqLu
 RrAtPGAsEa31hc4T9S1TumnhuP4As2yAINLLmIhEp7PHbNw8FoVQJZlBSlIJ9K0/7uG72SK7I
 xz/JevjKkDN4U/FKbq6zWrqRWkBWJv4frfVb132qpImrxgkXc8l+gRQ85ilK7HK81/qL+So69
 xWvbOJF9BU/ccqIozVGGWObN41IM0Nh6vNul/9zinDP5bNXGtp2qL7QltRM8inCk7Lrwtp5wP
 fq+HbUoSLniw34LKZbltNuf/6AwA01dtk3ksVi3H7hxLqcdw4wyjAware9NPn7J1TawQBVFrI
 02k1dPSeyM0FsM=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/28 11:24, Anand Jain wrote:
>
>
> On 28/02/2022 10:35, Qu Wenruo wrote:
>>
>>
>> On 2022/2/28 10:01, Anand Jain wrote:
>>> On 28/02/2022 07:56, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2022/2/26 03:18, Omar Sandoval wrote:
>>>>> On Fri, Feb 25, 2022 at 09:36:32PM +0800, Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> On 2022/2/25 19:47, David Sterba wrote:
>>>>>>> On Fri, Feb 25, 2022 at 06:08:20PM +0800, Qu Wenruo wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> The very basic seed device usage is broken again:
>>>>>>>>
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0mkfs.btrfs -f $dev1 > /dev/null
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0btrfstune -S 1 $dev1
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0mount $dev1 $mnt
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0btrfs dev add $dev2 $mnt
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0umount $mnt
>>>>>>>>
>>>>>>>>
>>>>>>>> I'm not sure how many guys are really using seed device.
>>>>>>>>
>>>>>>>> But I see a lot of weird operations, like calling a definite writ=
e
>>>>>>>> operation (device add) on a RO mounted fs.
>>>>>>>
>>>>>>> That's how the seeding device works, in what way would you want
>>>>>>> to do
>>>>>>> the ro->rw change?
>>>>>>
>>>>>> In progs-only, so that in kernel we can make dev add ioctl as a
>>>>>> real RW
>>>>>> operation, not adding an exception for dev add.
>>>>>>
>>>>>>>
>>>>>>>> Can we make at least the seed sprouting part into btrfs-progs
>>>>>>>> instead?
>>>>>>>
>>>>>>> How? What do you mean? This is an in kernel operation that is done
>>>>>>> on a
>>>>>>> mounted filesystem, progs can't do that.
>>>>>>
>>>>>> Why not?
>>>>>>
>>>>>> Progs has the same ability to read-write the fs, I see no reason
>>>>>> why we
>>>>>> shouldn't do it in user space.
>>>>>>
>>>>>> We're just adding a device, update related trees (which will only b=
e
>>>>>> written to the new device). I see no special reason why it can't be
>>>>>> done
>>>>>> in user space.
>>>>>>
>>>>>> Furthermore, the ability to add device in user space can be a good
>>>>>> safenet for some ENOSPC space.
>>>>>>
>>>>>>>
>>>>>>>> And can seed device even support the upcoming extent-tree-v2?
>>>>>>>
>>>>>>> I should, it operates on the device level.
>>>>>>>
>>>>>>>> Personally speaking I prefer to mark seed device deprecated
>>>>>>>> completely.
>>>>>>>
>>>>>>> If we did that with every feature some developer does not like we'=
d
>>>>>>> have
>>>>>>> nothing left you know. Seeding is a documented usecase, as long
>>>>>>> as it
>>>>>>> works it's fine to have it available.
>>>>>>
>>>>>> A documented usecase doesn't mean it can't be deprecated.
>>>>>>
>>>>>> Furthermore, a documented use case doesn't validate the use case
>>>>>> itself.
>>>>>>
>>>>>> So, please tell me when did you use seed device last time?
>>>>>> Or anyone in the mail list, please tell me some real world usecase
>>>>>> for
>>>>>> seed devices.
>>>>>>
>>>>>> I did remember some planned use case like a way to use seed device
>>>>>> as a
>>>>>> VM/container template, but no, it doesn't get much attention.
>>>>>>
>>>>>>
>>>>>> I'm not asking for deprecate the feature just because I don't like
>>>>>> it.
>>>>>>
>>>>>> This feature is asking for too many exceptions, from the extra
>>>>>> fs_devices hack (we have in fact two fs_devices, one for rw devices=
,
>>>>>> one
>>>>>> for seed only), to the dev add ioctl.
>>>>>>
>>>>>> But the little benefit is not really worthy for the cost.
>>>>>
>>>>> We use seed devices in production. The use case is for servers
>>>>> where we
>>>>> don't want to persist any sensitive data. The seed device contains a
>>>>> basic boot environment, then we sprout it with a dm-crypt device and
>>>>> throw away the encryption key. This ensures that nothing sensitive c=
an
>>>>> ever be recovered. We previously did this with overlayfs, but seed
>>>>> devices ended up working better for reasons I don't remember.
>>>>>
>>>>> Davide Cavalca also told me that "Fedora is also interested in
>>>>> leveraging seed devices down the road. e.g. doing seed/sprout for
>>>>> cloud
>>>>> provisioning, and using seed devices for OEM factory recovery on
>>>>> laptops."
>>>>>
>>>>> There are definitely hacks we need to fix for seed devices, but ther=
e
>>>>> are valid use cases and we can't just deprecate it.
>>>>
>>>> OK, then it looks we need to keep the feature.
>>>>
>>>> Then would you mind to share your preference between things like:
>>>>
>>>> a) The current way
>>>> =C2=A0=C2=A0=C2=A0 mkfs + btrfstune + mount + dev add
>>>
>>> =C2=A0=C2=A0 And further, dev-remove seed if needed.
>>>
>>>> b) All user space way
>>>> =C2=A0=C2=A0=C2=A0 mkfs /dev/seed
>>>> =C2=A0=C2=A0=C2=A0 btrfstune -S 1 /dev/seed
>>>> =C2=A0=C2=A0=C2=A0 mkfs -S /dev/seed /dev/new
>>>> =C2=A0=C2=A0=C2=A0 (using seed device as seed, and sprout to the new =
device)
>>>
>>> =C2=A0=C2=A0Does the -S option copy all blocks here?
>>
>> Nope, just the same as dev add.
>>
>>> =C2=A0=C2=A0How does it work if /dev/new needed to be an independent f=
ilesystem
>>> =C2=A0=C2=A0only at some later point? Add another btrfstune option?
>>
>> The same dev remove.
>>
>>>
>>>> With method b, at least we can make dev add ioctl to be completely
>>>> RW in
>>>> the long run.
>>>
>>> =C2=A0=C2=A0Could you please add more clarity here? Very confusing.
>>
>> Isn't it an awful thing that device add ioctl can even be executed on a
>> RO mounted fs?
>>
>
> Ah. That's fine, IMO. It is a matter of understanding the nature of the
> seed device. No?
> The RO mount used to turn into an RW mount after the device-add a long
> ago. It got changed without a trace.

Think twice about this, have you every seen another fs allowing a RO
mount to be converted to RW without even remounting?

Still think this doesn't provide any surprise to end users?

Thanks,
Qu

>
> Thanks, Anand
>
>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks, Anand
>>>
>>>> Thanks,
>>>> Qu
>>>
