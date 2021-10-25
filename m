Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0219443A6C9
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Oct 2021 00:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbhJYWru (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 18:47:50 -0400
Received: from mout.gmx.net ([212.227.15.15]:59873 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232470AbhJYWrt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 18:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635201923;
        bh=EVMy2Jitm3CXjMFIDnJQWqMWPKcnDqItRs/PPUzZqHo=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=AO3wvls82A3ezNrY5002SuolAPGc2FRREUZN6wWVwCplsXY9jSTxkrYPieLBXIaAa
         PuH4++BQLkQ6P2SwrnlBLUsjFura46zRo3+GfpryG0+j/FDcaupJbu/Giy/4xmSD9P
         7EWhRpCRGiPOjx+/a2UL6clRKVez9J6ZoE5E+wOY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mt79P-1mysQd0dD7-00tVAC; Tue, 26
 Oct 2021 00:45:23 +0200
Message-ID: <3ce1dd17-b574-abe3-d6cc-eb16f00117cc@gmx.com>
Date:   Tue, 26 Oct 2021 06:45:18 +0800
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <em6e5eb690-6dcd-482d-b4f2-1b940b6cb770@rx2.rx-server.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Gdjus2evDtF85UrEI3RkNupGA2emPvsRUj8f675+nKcA+zrca5
 iBNK+EOilx1ULRVEFmMZ/DdNmEcZnXIWS8yAREGogPCZDmzlVyh+uUPTERIrO+uCkCLBc8/
 jM5w4iDOo6/VZS2olv+/MlyGGQf8JjIlSf/4rlT8bKfH2pWZEIxAqjwH/OGR29GWpXreub9
 xvXDbBK1kdssiydMM58xQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UZggNzLurfM=:x0Rkashb4A7ViJfXgb9OXV
 q3lyaWtvFXKDUuk91Gf0ZiS1wy+p5caABwmtrbHPq54QCvbm5CG6aXFzZ1xs/VMnw9YEabvMX
 c9W58Hksbpt9GkRhUtm7V74DiuxU9lSiHMBO3NvFyulQMPfO3qxhWXFZ8Iwq2jYuaHNMsbKrs
 jN69uNjjcukUvt9NDG3ZVDi6XK5jZ2ox/7P2UXlqS1eKjylOM1J7RRpqc3XimdjwtNrcyW8Pg
 j7c15ktbWL+r7dghXC8qEM6kd8egBGvnCrNrDtP5+bYpQSuZj+5XeikNOAYRil/zYJHeeJ+QK
 aTgWHM0Q/xfEAIVdAFqf5Asj3i+pi24fhBMjZkWJSLRtbwPMxAP3EUcCpx724MvrjJ2NN0EyM
 3UjjnaKEDL7hsu0iCdi/TWSGd47vHFc2YINEgUTo2g6YbyOXi+1lgtTe5lQO3J1FhgMGc9DcW
 mXS2sw3hAp8JDIJpPbvDdchqxIb2Ns2fcp4OEDBKTsUaqZY/6JvldUIOSSjqyb724SXf4r07a
 VlYnph4jqQ0v2k1dZI1tvvY8ulGBwPe8oqEtGaSsx4Fn+/oauiys4ZgvtxRwyE4dUO16uapdo
 GIxnfGnnpS+uzCQib/XrNFFdCF6UQC9AgIJbix2HGp6YIfsZ6a8LtkTz0e1ZJDKa/HCUMdp0U
 yvG5LVAXWO8fYKiRyZKSz5Ex3w9FOZ/QnIqUbkIck5px/OupnQbSiVkTqA3M6Q8Ewt00rJq4v
 Xcjei4Gm8XWifRz+uiVh2iNEm97qfJrJtS2VMJCJh9jqmYnOmHPwmaIVO8U4upaLuP+WOvepD
 6+7SCRPuKQtzws4Mkui/r3E+t+HEcJLvihqPIhsTh1qCwwZz4plO1htfm2h4hPCvcUah55VUw
 FWEHagzbzbrvYaKbHTqVfi8BReY1dWrdssgj5WWqcamQE9cMvFrYPNpyKAKEhj6ebqb4NS4k2
 VQNDxI0BP8LhjnyhBmy5gMit7fics2ShfN+in8py97p130TVEREkj+ASMKiI0yqAUopERJx75
 124GtyOEVsywTe1M2JVLH+ZbCqc5P0SyiFfmN1LlltQDgTJgGJTEs72fMIU5x6JQg0d687CiO
 eXUu0zRZo3BDB8=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/26 01:09, Mia wrote:
> Hi Qu,
>
> sorry for the late reply. I tried the btrfs check again with arch live c=
d:
>
> root@archiso ~ # uname -a
> Linux archiso 5.11.16-arch1-1 #1 SMP PREEMPT Wed, 21 Apr 2021 17:22:13
> +0000 x86_64 GNU/Linux
> root@archiso ~ # btrfs --version
> btrfs-progs v5.14.2
>
> https://gist.github.com/lynara/12dcfff870260b6bc35b9d1137921fc4

OK, so the metadata problem is really there, but it shouldn't affect
your fs right now, unless you want to mount it with 64K page size.

And for the new error (inline file extent too large), it may cause
problems, but under most cases, kernel can handle it without problem.
>
> I'm still getting many errors.
> Sorry I currently don't know what caused this. I suspect it might be
> Seafile since I'm now having a currupted library there.
>
> Should I use --repair?

No, --repair won't help in this case.

In fact, your fs is fine, no on-disk metadata problem yet.

For your case, I can only recommend to use newer kernel to have better
sanity check.
Meanwhile I would also recommend to run a memtest to ensure it's not
some memory problem causing the bug.

Thanks,
Qu

>
> Regards
> Mia
>
> ------ Originalnachricht ------
> Von: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
> An: "Qu Wenruo" <wqu@suse.com>; "Mia" <9speysdx24@kr33.de>;
> linux-btrfs@vger.kernel.org
> Gesendet: 25.10.2021 13:18:54
> Betreff: Re: filesystem corrupt - error -117
>
>>
>>
>> On 2021/10/25 19:14, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/10/25 19:13, Mia wrote:
>>>> Hi Qu,
>>>>
>>>> thanks for your response.
>>>> Here the output of btrfs check:
>>>> https://gist.github.com/lynara/1c613f7ec9448600f643a59d22c1efb2
>>>
>>> Unfortunately it's not full, and it's using an old btrfs-progs which c=
an
>>> cause false alert.
>>
>> My bad, gist is folding the output.
>>
>> It shows no corruption for the extent tree, thus I guess the transactio=
n
>> abort has prevented COW from being broken.
>>
>>>
>>> Please use latest btrfs-progs v5.14.2 to re-check.
>>
>> In that case, a newer btrfs-progs is only going to remove the false
>> alerts.
>>
>> Any clue on the workload causing the abort?
>>
>> For now, I can only recommend to use newer kernel (v5.10+ I guess?) to
>> see if you can reproduce the problem.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> Thanks,
>>>> Mia
>>>>
>>>> ------ Originalnachricht ------
>>>> Von: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
>>>> An: "Mia" <9speysdx24@kr33.de>; linux-btrfs@vger.kernel.org
>>>> Gesendet: 25.10.2021 12:55:46
>>>> Betreff: Re: filesystem corrupt - error -117
>>>>
>>>>>
>>>>>
>>>>> On 2021/10/25 18:53, Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> On 2021/10/25 16:46, Mia wrote:
>>>>>>> Hello,
>>>>>>> I need support since my root filesystem just went readonly :(
>>>>>>>
>>>>>>> [641955.981560] BTRFS error (device sda3): tree block 342685007872
>>>>>>> owner
>>>>>>> 7 already locked by pid=3D8099, extent tree corruption detected
>>>>>>
>>>>>> This line explains itself.
>>>>>>
>>>>>> Your extent tree is no corrupted, thus it allocated a new tree bloc=
k
>>>>>
>>>>> I missed the "w" for the word "now"...
>>>>>
>>>>>> which is in fact already hold by other tree.
>>>>>>
>>>>>> This means your metadata is no longer protected properly by COW.
>>>>>>
>>>>>> "btrfs check" is highly recommended to expose the root cause.
>>>>>>
>>>>>>>
>>>>>>> root@rx1 ~ # btrfs fi show
>>>>>>> Label: none=C2=A0 uuid: 21306973-6bf3-4877-9543-633d472dcb46
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes used 189.12GiB
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 319.00GiB =
used 199.08GiB path /dev/sda3
>>>>>>>
>>>>>>> root@rx1 ~ # btrfs fi df /
>>>>>>> Data, single: total=3D194.89GiB, used=3D187.46GiB
>>>>>>> System, single: total=3D32.00MiB, used=3D48.00KiB
>>>>>>> Metadata, single: total=3D4.16GiB, used=3D1.65GiB
>>>>>>> GlobalReserve, single: total=3D380.45MiB, used=3D0.00B
>>>>>>>
>>>>>>> root@rx1 ~ # btrfs --version
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :=
(
>>>>>>> btrfs-progs v4.20.1
>>>>>>>
>>>>>>>
>>>>>>> root@rx1 ~ # uname -a
>>>>>>> Linux rx1 4.19.0-17-amd64 #1 SMP Debian 4.19.194-3 (2021-07-18)
>>>>>>> x86_64
>>>>>>> GNU/Linux
>>>>>>
>>>>>> This is a little old for btrfs, but I don't think that's the cause.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>>>
>>>>>>> Hope someone can help.
>>>>>>> Regrads
>>>>>>> Mia
>>>>>>>
>>>>
>>>
>
