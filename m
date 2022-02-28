Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE544C612A
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 03:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiB1CgW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Feb 2022 21:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiB1CgV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Feb 2022 21:36:21 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1944E6C917
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 18:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646015736;
        bh=lEdj75RO2HDVoAxc/I81dQQuGF2OKuVNYtZUrClgDjs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WGax7QMT9uKZQdlahbQwCU2jt/8lZInCo089j1TlIyAL16H39GYXUcZ37scAGTEJc
         UYgwNDBvuRsyY5Hxl7vgAWc+BgKiQq6EQu18exjk1fBZgxN9jbYPIEnR18XBsNNa/G
         U8e7RceNqvC31bzeKN29Su9GttcfRuHfXeAlvO/U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWzfl-1nic5m1nNh-00XOIV; Mon, 28
 Feb 2022 03:35:36 +0100
Message-ID: <00f162f7-774c-b7d4-9d1f-e04cc89b2aee@gmx.com>
Date:   Mon, 28 Feb 2022 10:35:31 +0800
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <43aea7a1-7b4b-8285-020b-7747a29dc9a6@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wJ4NwyXNsYNkOg0tvyrg7i1+79DzceIh0vBmiS2cbf3qoSO6N60
 jB3+hO9JN7UWhMspEcDeFrvqtEPiMjl6pJl1XSuNRBte53sk3Iag1pkA47JRolLVQoj/aIT
 sICswTQuDAABNL0ojia8h65foGuAyAEFRH33MAgsJIYo7mRvYOFH/p0ARkK96NirbGlwnlg
 /ZRXjz8nNzmDSeSyJN+iA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Uz58Y/evLU=:sKrqmom6Q+CbI2auGEb0rr
 EY4PVDY9M4qJA8uVuf8rP37wDCdEs9oiS8VeAm+mAkm7YgRr4ZmEFg6yWdUp2l5FrpZ/3VGCD
 Pxx9Jxb3TyRzZ1BnLu1OwD+2HCN5PvEjWgaFMAJKonMxrM/RotcHafDq+lOdmkVv8aaIGOxls
 A11BbhtzUjmOmC05Jxvm3TF+TZfkSaEDZMCwbsIySBLmm2+9CL8gXoQVyhLejo43j5RUC4fxG
 tSyVFGJNqHrjtxQTFwA5CemnhRRTtTsQ6G4HLcsyeVzrGyNgggdlKiAVtRP2tldh+KjlZygKg
 XG4rOzTk7MOh7df7a6pN+zYctVH7hjiOFvacEJ7dFCJk6hYvJDQAUFm+zrN8EqMg1THBPEo1P
 +xEhVxYRLYlb6ZTln0yeZTeM4FcTpTfT5FpIXER+7FbvI4NES3B3Rb4soq1cnAhF/WBbVMhTX
 0Sln3qQdKTK6zX/SmWaISuj/zonyv0M1MgObhI7oKOjAOnXHvs1L7seK8niWB6wM/wTL3sb2N
 X2qOI+YJgBrCzivMr6+wwI5JMpbH3nF4fqy/6Ad3dvvk4LMp35YjSGJlh+2JRxaJ1ZxG+q5GO
 mkAH62t2LIItXQv7Jggi8QAa+7I9cE57GK2pT9dtkhepWRfxH+cV7a4nVzPERZqy7R7MHRndk
 P9wRiS8hfgjLtzJEoQTuxcPSkUZrT/mVH//Nx/D4Vy+8vBQXcOfsbnaA15xeNzjfKAcjXLEOV
 SCX6Q2HGjd1yo+lgHYEWQaAokfNWeo0SzxVoQGCOx1R8HyaTHr//XDnOlLeU9fX5KPTsBBfbj
 TZerqnciWKL6BwixHBGaHhC2pM84i3IkKCcyTxGXA1uSjTbOv4hHWknGZZ04l4Ttlg3o0Ewdq
 IOuQUPgaeklpm1cTqRNOLHWJO1HXcKQXjaciqog5PhWGjdXJJ2TnysO7vOvxuU0Uq6lddzHIi
 D1D8WYWG0oQ/6PE7Hp5MGfqYobfqJtxHIom77c4yYEvG7jajX6ViAX//zm/M5TJvvqxiusUNc
 HKxsFABLq+BYC77PTBwBBCfsmhj5ydGFgiOjQyTJEKmr/D8NFzv3mDEsQ50ULLrN9SBGXWPaJ
 fpnhY1+TXFykN8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/28 10:01, Anand Jain wrote:
> On 28/02/2022 07:56, Qu Wenruo wrote:
>>
>>
>> On 2022/2/26 03:18, Omar Sandoval wrote:
>>> On Fri, Feb 25, 2022 at 09:36:32PM +0800, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2022/2/25 19:47, David Sterba wrote:
>>>>> On Fri, Feb 25, 2022 at 06:08:20PM +0800, Qu Wenruo wrote:
>>>>>> Hi,
>>>>>>
>>>>>> The very basic seed device usage is broken again:
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0mkfs.btrfs -f $dev1 > /dev/null
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0btrfstune -S 1 $dev1
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0mount $dev1 $mnt
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0btrfs dev add $dev2 $mnt
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0umount $mnt
>>>>>>
>>>>>>
>>>>>> I'm not sure how many guys are really using seed device.
>>>>>>
>>>>>> But I see a lot of weird operations, like calling a definite write
>>>>>> operation (device add) on a RO mounted fs.
>>>>>
>>>>> That's how the seeding device works, in what way would you want to d=
o
>>>>> the ro->rw change?
>>>>
>>>> In progs-only, so that in kernel we can make dev add ioctl as a real =
RW
>>>> operation, not adding an exception for dev add.
>>>>
>>>>>
>>>>>> Can we make at least the seed sprouting part into btrfs-progs
>>>>>> instead?
>>>>>
>>>>> How? What do you mean? This is an in kernel operation that is done
>>>>> on a
>>>>> mounted filesystem, progs can't do that.
>>>>
>>>> Why not?
>>>>
>>>> Progs has the same ability to read-write the fs, I see no reason why =
we
>>>> shouldn't do it in user space.
>>>>
>>>> We're just adding a device, update related trees (which will only be
>>>> written to the new device). I see no special reason why it can't be
>>>> done
>>>> in user space.
>>>>
>>>> Furthermore, the ability to add device in user space can be a good
>>>> safenet for some ENOSPC space.
>>>>
>>>>>
>>>>>> And can seed device even support the upcoming extent-tree-v2?
>>>>>
>>>>> I should, it operates on the device level.
>>>>>
>>>>>> Personally speaking I prefer to mark seed device deprecated
>>>>>> completely.
>>>>>
>>>>> If we did that with every feature some developer does not like we'd
>>>>> have
>>>>> nothing left you know. Seeding is a documented usecase, as long as i=
t
>>>>> works it's fine to have it available.
>>>>
>>>> A documented usecase doesn't mean it can't be deprecated.
>>>>
>>>> Furthermore, a documented use case doesn't validate the use case
>>>> itself.
>>>>
>>>> So, please tell me when did you use seed device last time?
>>>> Or anyone in the mail list, please tell me some real world usecase fo=
r
>>>> seed devices.
>>>>
>>>> I did remember some planned use case like a way to use seed device as=
 a
>>>> VM/container template, but no, it doesn't get much attention.
>>>>
>>>>
>>>> I'm not asking for deprecate the feature just because I don't like it=
.
>>>>
>>>> This feature is asking for too many exceptions, from the extra
>>>> fs_devices hack (we have in fact two fs_devices, one for rw devices,
>>>> one
>>>> for seed only), to the dev add ioctl.
>>>>
>>>> But the little benefit is not really worthy for the cost.
>>>
>>> We use seed devices in production. The use case is for servers where w=
e
>>> don't want to persist any sensitive data. The seed device contains a
>>> basic boot environment, then we sprout it with a dm-crypt device and
>>> throw away the encryption key. This ensures that nothing sensitive can
>>> ever be recovered. We previously did this with overlayfs, but seed
>>> devices ended up working better for reasons I don't remember.
>>>
>>> Davide Cavalca also told me that "Fedora is also interested in
>>> leveraging seed devices down the road. e.g. doing seed/sprout for clou=
d
>>> provisioning, and using seed devices for OEM factory recovery on
>>> laptops."
>>>
>>> There are definitely hacks we need to fix for seed devices, but there
>>> are valid use cases and we can't just deprecate it.
>>
>> OK, then it looks we need to keep the feature.
>>
>> Then would you mind to share your preference between things like:
>>
>> a) The current way
>> =C2=A0=C2=A0=C2=A0 mkfs + btrfstune + mount + dev add
>
>  =C2=A0 And further, dev-remove seed if needed.
>
>> b) All user space way
>> =C2=A0=C2=A0=C2=A0 mkfs /dev/seed
>> =C2=A0=C2=A0=C2=A0 btrfstune -S 1 /dev/seed
>> =C2=A0=C2=A0=C2=A0 mkfs -S /dev/seed /dev/new
>> =C2=A0=C2=A0=C2=A0 (using seed device as seed, and sprout to the new de=
vice)
>
>  =C2=A0Does the -S option copy all blocks here?

Nope, just the same as dev add.

>  =C2=A0How does it work if /dev/new needed to be an independent filesyst=
em
>  =C2=A0only at some later point? Add another btrfstune option?

The same dev remove.

>
>> With method b, at least we can make dev add ioctl to be completely RW i=
n
>> the long run.
>
>  =C2=A0Could you please add more clarity here? Very confusing.

Isn't it an awful thing that device add ioctl can even be executed on a
RO mounted fs?

Thanks,
Qu

>
> Thanks, Anand
>
>> Thanks,
>> Qu
>
