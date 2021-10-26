Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B6243AD2A
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Oct 2021 09:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhJZH1H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Oct 2021 03:27:07 -0400
Received: from mout.gmx.net ([212.227.15.15]:33491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhJZH1D (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Oct 2021 03:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635233076;
        bh=s1YalCFOq73e5XjW2skO/yVq3XSMrkx0kntYuLx+DNA=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=guKEShUfedSie2pSso03kuTLIfBKeX/ZnwdHkKCF+vz7hkokOFCsFOjd96OYOJSS9
         AptlaoOvkQb5zxQfRxhf1r/ZfULTVQJr/CoRH1+PS88p8/+wgA7GcVHjzyaKGSMS52
         HldNFaj6lhSvJiVsp6PFkAQkU/y/Y6/ezR0ho3NI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgNh7-1nADBk3LxP-00hvYm; Tue, 26
 Oct 2021 09:24:36 +0200
Message-ID: <654051a3-e069-a8bc-08a5-0fb5561144df@gmx.com>
Date:   Tue, 26 Oct 2021 15:24:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: filesystem corrupt - error -117
Content-Language: en-US
To:     Mia <9speysdx24@kr33.de>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <em969af203-04e6-4eff-a115-1129ae853867@frystation>
 <em33e101b0-d634-48b5-8a32-45e295f48f16@rx2.rx-server.de>
 <c2941415-e32f-b31d-0bc2-911ede3717b7@gmx.com>
 <69109d24-efa7-b9d1-e1df-c79b3989e7bf@rx2.rx-server.de>
 <em0473d04b-06b0-43aa-91d6-1b0298103701@rx2.rx-server.de>
 <146cff2c-3081-7d03-04c8-4cc2b4ef6ff1@suse.com>
 <884d76d1-5836-9a91-a39b-41c37441e020@rx2.rx-server.de>
 <em6e5eb690-6dcd-482d-b4f2-1b940b6cb770@rx2.rx-server.de>
 <3ce1dd17-b574-abe3-d6cc-eb16f00117cc@rx2.rx-server.de>
 <em2512c4e9-1e5e-4aa0-b9fc-fb68891e615d@rx2.rx-server.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <em2512c4e9-1e5e-4aa0-b9fc-fb68891e615d@rx2.rx-server.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wCbZzyDAzOf/ru6d0pT9aYH/fn+DMyuCBrB0jYQdJ51i2gq2kVi
 nPHQunF0eOCkLL9+2Q4APlATBwKUzpKSYLyK9AAflSJHpOcDCGPf04wJsyOsWZRSb5frA+r
 9HQB/dNVCFp00bWanDT3l/G44E4ArmGleHUPCDSQs3Kd2rlHGiWGjbOYppXJSNqCPwzfxEF
 4ETO8OLGsrU94RelDVjKw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bTz+SZJtrSA=:dGQmJzUzbB635B2hH6w/uX
 3cYtcZAxeTPPpJf7IVoapQZ6Wkpfq9qza+i0ZoFkXCRSCgr4CBA+tYKlf3VB/4udas+gPvJHa
 OJmMI3qHey3Jjags72MfnFJ23fTn91Z95t6Qr33HQeG+FD/8hGCzs98WCFbkUS5j8CRzU5Rfx
 lpzHvBW/+XsI+xiPWJ4d/QXONbgdejEMLm1sCODXiShnIE+/uThXnDQtrKVGGtVFTyyJq2/fJ
 AOBCQ+BxYsLtN0NEzOU+tTyqmBl77fmBFlc/lgjVufYyVxxecuqhg45RMWLy5yowAr2UMP8Br
 A/86Mj6v44l8+0a+e01mReOUeEwCh8n0UkKrAhovi+7ilNnxdtmx/E5jrQZkrnnmyqfMx/2jR
 QoWn/VK8PfuZUHYlhgbVJLgjTH1tbaqswIi+xuyb83DUMiGjcbLd/yneohHE6UUXE7Y41UUcf
 mvULORsCxxHHeujnQaEUoh8k+74tzm7ujYuyVjDVjGTslyFrI1Jayy4C+eKWWaIyKShVubjXr
 CC/z2AYKnOPVKwpX94Ia3lb0mSchsUysoKipoLuCmWxrunTuugPmJ61GqqzhLLLvRFo+eAFSK
 Gz2kig4JVZcR22Iu7mHYn0lmMR5c0TvfvmfOHgtu8U6kT7apMP2Qqy9E9o4VqTrMT7GIqqyvC
 elombM8wUvMfvVhImSAKcpJXJhsLM8jcFHryLWnnDpggkFUJpsHCZDRtB4ha8jYxstYC44pYH
 YREf6Jq51U3Z7c/wduMuFNx9qdC4hn5c00WbBn+1FsCO8bM36OrHgOSxjcE8sy7LqXgmtvI87
 C0wRMo1OT53yodmo5YlL/HrdaKq5jc8s4mUcfLYZVjvBRtvtNaF5a9NWOPt1HYg2T5gQ87+xV
 igEJ2sjTUc+IIP5BUWP15PNs9+30CoESAYSUyDeD1Ty6Z0+DrE4+BWAaqIg5ycVtHssXARGX4
 6S5RLtKyaYx5swFL3MQ2Q9GpA7QSENyMHh8947/qWwEf3NMg9i7as3XfY7tyX8/EB1qNvVnAO
 gStVDMeErLillgCMC+N/LkHPULxlXMr5KtTJLJe20WJK9LT93tqrTIwM5SCqArkO0Brfm8njH
 d44JI8tBuUbwqw=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/26 14:03, Mia wrote:
> Hi Qu,
>
> thanks for clarification.
> So I should just ignore these errors for now?

Yes, none of them is going to cause any direct problems.

> What about these ones, you haven't mentioned:
> bad metadata [342605463552, 342605479936) crossing stripe boundary

This is the same, it just means it crosses 64K boundary, which is not
supported for the incoming subpage support (using 4K page size on 64K
page size systems).

>
> Problem with updating is that this is currently still Debian 10 and a
> production environment and I don't know when it is possible to upgrade
> because of dependencies.

OK, understood the situation now.

Then I can't provide much helper as I'm not familiar with Debian...

If not reproducible so far, I can only recommend for a memtest to rule
out memory bitflip, which could also cause the bug.

Thanks,
Qu
>
> Regards
> Mia
>
> ------ Originalnachricht ------
> Von: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
> An: "Mia" <9speysdx24@kr33.de>; "Qu Wenruo" <wqu@suse.com>;
> linux-btrfs@vger.kernel.org
> Gesendet: 26.10.2021 00:45:18
> Betreff: Re: filesystem corrupt - error -117
>
>>
>>
>> On 2021/10/26 01:09, Mia wrote:
>>> Hi Qu,
>>>
>>> sorry for the late reply. I tried the btrfs check again with arch
>>> live cd:
>>>
>>> root@archiso ~ # uname -a
>>> Linux archiso 5.11.16-arch1-1 #1 SMP PREEMPT Wed, 21 Apr 2021 17:22:13
>>> +0000 x86_64 GNU/Linux
>>> root@archiso ~ # btrfs --version
>>> btrfs-progs v5.14.2
>>>
>>> https://gist.github.com/lynara/12dcfff870260b6bc35b9d1137921fc4
>>
>> OK, so the metadata problem is really there, but it shouldn't affect
>> your fs right now, unless you want to mount it with 64K page size.
>>
>> And for the new error (inline file extent too large), it may cause
>> problems, but under most cases, kernel can handle it without problem.
>>>
>>> I'm still getting many errors.
>>> Sorry I currently don't know what caused this. I suspect it might be
>>> Seafile since I'm now having a currupted library there.
>>>
>>> Should I use --repair?
>>
>> No, --repair won't help in this case.
>>
>> In fact, your fs is fine, no on-disk metadata problem yet.
>>
>> For your case, I can only recommend to use newer kernel to have better
>> sanity check.
>> Meanwhile I would also recommend to run a memtest to ensure it's not
>> some memory problem causing the bug.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Regards
>>> Mia
>>>
>>> ------ Originalnachricht ------
>>> Von: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
>>> An: "Qu Wenruo" <wqu@suse.com>; "Mia" <9speysdx24@kr33.de>;
>>> linux-btrfs@vger.kernel.org
>>> Gesendet: 25.10.2021 13:18:54
>>> Betreff: Re: filesystem corrupt - error -117
>>>
>>>>
>>>>
>>>> On 2021/10/25 19:14, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2021/10/25 19:13, Mia wrote:
>>>>>> Hi Qu,
>>>>>>
>>>>>> thanks for your response.
>>>>>> Here the output of btrfs check:
>>>>>> https://gist.github.com/lynara/1c613f7ec9448600f643a59d22c1efb2
>>>>>
>>>>> Unfortunately it's not full, and it's using an old btrfs-progs
>>>>> which can
>>>>> cause false alert.
>>>>
>>>> My bad, gist is folding the output.
>>>>
>>>> It shows no corruption for the extent tree, thus I guess the
>>>> transaction
>>>> abort has prevented COW from being broken.
>>>>
>>>>>
>>>>> Please use latest btrfs-progs v5.14.2 to re-check.
>>>>
>>>> In that case, a newer btrfs-progs is only going to remove the false
>>>> alerts.
>>>>
>>>> Any clue on the workload causing the abort?
>>>>
>>>> For now, I can only recommend to use newer kernel (v5.10+ I guess?) t=
o
>>>> see if you can reproduce the problem.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>>
>>>>>> Thanks,
>>>>>> Mia
>>>>>>
>>>>>> ------ Originalnachricht ------
>>>>>> Von: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
>>>>>> An: "Mia" <9speysdx24@kr33.de>; linux-btrfs@vger.kernel.org
>>>>>> Gesendet: 25.10.2021 12:55:46
>>>>>> Betreff: Re: filesystem corrupt - error -117
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 2021/10/25 18:53, Qu Wenruo wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2021/10/25 16:46, Mia wrote:
>>>>>>>>> Hello,
>>>>>>>>> I need support since my root filesystem just went readonly :(
>>>>>>>>>
>>>>>>>>> [641955.981560] BTRFS error (device sda3): tree block 3426850078=
72
>>>>>>>>> owner
>>>>>>>>> 7 already locked by pid=3D8099, extent tree corruption detected
>>>>>>>>
>>>>>>>> This line explains itself.
>>>>>>>>
>>>>>>>> Your extent tree is no corrupted, thus it allocated a new tree
>>>>>>>> block
>>>>>>>
>>>>>>> I missed the "w" for the word "now"...
>>>>>>>
>>>>>>>> which is in fact already hold by other tree.
>>>>>>>>
>>>>>>>> This means your metadata is no longer protected properly by COW.
>>>>>>>>
>>>>>>>> "btrfs check" is highly recommended to expose the root cause.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> root@rx1 ~ # btrfs fi show
>>>>>>>>> Label: none=C2=A0 uuid: 21306973-6bf3-4877-9543-633d472dcb46
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes used 189.12GiB
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 319.00Gi=
B used 199.08GiB path /dev/sda3
>>>>>>>>>
>>>>>>>>> root@rx1 ~ # btrfs fi df /
>>>>>>>>> Data, single: total=3D194.89GiB, used=3D187.46GiB
>>>>>>>>> System, single: total=3D32.00MiB, used=3D48.00KiB
>>>>>>>>> Metadata, single: total=3D4.16GiB, used=3D1.65GiB
>>>>>>>>> GlobalReserve, single: total=3D380.45MiB, used=3D0.00B
>>>>>>>>>
>>>>>>>>> root@rx1 ~ # btrfs --version
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 :(
>>>>>>>>> btrfs-progs v4.20.1
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> root@rx1 ~ # uname -a
>>>>>>>>> Linux rx1 4.19.0-17-amd64 #1 SMP Debian 4.19.194-3 (2021-07-18)
>>>>>>>>> x86_64
>>>>>>>>> GNU/Linux
>>>>>>>>
>>>>>>>> This is a little old for btrfs, but I don't think that's the caus=
e.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hope someone can help.
>>>>>>>>> Regrads
>>>>>>>>> Mia
>>>>>>>>>
>>>>>>
>>>>>
>>>
>
