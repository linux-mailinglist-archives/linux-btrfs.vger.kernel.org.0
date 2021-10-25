Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9160A4394A4
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 13:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhJYLV3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 07:21:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:55595 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230126AbhJYLVW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 07:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635160737;
        bh=Sc+m69lycnDMkcd+GhurnjSG9l86JMQZqGGO357JL90=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=XGMPoxkz9zYpBC54JHnzSj6Yl4f11mKegShajuVX9a0XDnuUxahkNzJxxx0lvzxGk
         JMs5s2bS3Atzg/z+RKs/MiQmOgP7NqNxvsZEiz15TAxXYFMz2+h/pm0ePIkV6OPK9G
         iXu5DuAzf4tHMxYHFh3QTPkrSiZv98ID8ABV/0hQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MysRk-1mrWmR0Rl4-00w0Vt; Mon, 25
 Oct 2021 13:18:57 +0200
Message-ID: <884d76d1-5836-9a91-a39b-41c37441e020@gmx.com>
Date:   Mon, 25 Oct 2021 19:18:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: filesystem corrupt - error -117
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, Mia <9speysdx24@kr33.de>,
        linux-btrfs@vger.kernel.org
References: <em969af203-04e6-4eff-a115-1129ae853867@frystation>
 <em33e101b0-d634-48b5-8a32-45e295f48f16@rx2.rx-server.de>
 <c2941415-e32f-b31d-0bc2-911ede3717b7@gmx.com>
 <69109d24-efa7-b9d1-e1df-c79b3989e7bf@rx2.rx-server.de>
 <em0473d04b-06b0-43aa-91d6-1b0298103701@rx2.rx-server.de>
 <146cff2c-3081-7d03-04c8-4cc2b4ef6ff1@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <146cff2c-3081-7d03-04c8-4cc2b4ef6ff1@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n+u/XbMqcXHki0tQsQdqX3KaNKxD38fKudtGZ37KGmZ20PoHCdr
 W9T/ryq7ALeglNXHM6+4dcI0dIBJiqz26dVuHwsp3mAxqpQUA4s0evGnVgv3f873oID+zU7
 PsAPdYUAduVC2OJGZEIJ/Dy/Ufv2k0nsmROnBPZNZVSySgNus7jNW2dH26LlCPU8JD391Ch
 r+HPNHt2xCcAVE5Oy5Hqw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z8YscXATR30=:Z/GG9fqccjtlqHbCm4Gbo8
 z2/ubbWDtUVZYXPZZ3MuT64Cc94f6U9in84Tql3KzzDCKDy651YVgX39YAd7Vhmw7JeY4lu2C
 2nK7BG5psU9s0EcuWeDRHJiaDWGhkTsISJnkPURmuK1tfeiHINFtWUdCmukF/Gui9Ybe7cMrD
 y5kjLu4MvIGPwrDg0W8w5tlSmxbIs9cPcfRo3LTjO5dRajoR3CVmX4YGS7yFxk9GIUyo4+Otd
 pWjfJY+12tn5qGFjw05gOw4LBRaTpZrTisf1d2jLbNxAeI1V8eoVvTWm+x1zyTa4FrtdHyw8O
 UDBlUByDVDVHz/21kQhGe7aMb8Yx0vGKAfKoTwIJC91OJpwMKwMnKy/9kF1U8mEdMI17XF1JF
 BBMmHkNp23LVR5QS6g/d5qfLXLM7f2/BhW7ZIa8qd7P26IcT0okwJ9sXZ8Bei3PnLk4edeoAe
 LkVd8M9aaRElmCQ2nOy3elJOiu7ARjFZ+Kfx2O9mQd1ovwJLPvZ0gyNHEpJfhMygDhe9bNK0F
 b8KdtcThQ1Ru21uxrG+oIkspWEaNLYWnNhqirr6auxmPgxGHqKDgOC+z1ORfCVGrLXFUD0I8X
 lgLfA6E09fTxcXe+JIOd+TgMGGVKzjbE1eGofEdsXbBaXZLh/8e1LqnhEFoiwSxXpKk+enxfZ
 74/GSrtdEIQD6fsZtSlmKQoYGYysUzSItegBRhLES0VdIDsV6oiRhJtL1bRkfQDmKsiQg/wTA
 nfdJQiI2jBwTZO/uYAipNGWmfHV1IRft+ouU82j2PYEiZG7bn5Z9rqj74EmD+VRFsggOInDnB
 eIslZiQmVfmYYYTDce1P0wjG4DEy/SQPpQZpf9xJLuPuaOi6PCMNrkH+cDryQnwNQFqy/Ynx7
 z0fJuNWNRhF5mquW8rEkLII5+F7zaPqFEVoevp3toN9H4oZqH/qukOd4Ox7i8xifQNFRRTago
 zR/KJkXd0wrGF0QnMesR+k6F3eKMn57hkHv5JlioZA9ejqaXrQXX5oTEWYHquYkQp9O7r7X9a
 Ly3rOIkllFaFd59iK1wdgp9EZvo6744kd+Bv0CJM1Y/Ie/MemdRAdzkU1dP7IJm3MuxXALVji
 SiXbDXmgADQwfk=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/25 19:14, Qu Wenruo wrote:
>
>
> On 2021/10/25 19:13, Mia wrote:
>> Hi Qu,
>>
>> thanks for your response.
>> Here the output of btrfs check:
>> https://gist.github.com/lynara/1c613f7ec9448600f643a59d22c1efb2
>
> Unfortunately it's not full, and it's using an old btrfs-progs which can
> cause false alert.

My bad, gist is folding the output.

It shows no corruption for the extent tree, thus I guess the transaction
abort has prevented COW from being broken.

>
> Please use latest btrfs-progs v5.14.2 to re-check.

In that case, a newer btrfs-progs is only going to remove the false alerts=
.

Any clue on the workload causing the abort?

For now, I can only recommend to use newer kernel (v5.10+ I guess?) to
see if you can reproduce the problem.

Thanks,
Qu

>
> Thanks,
> Qu
>>
>> Thanks,
>> Mia
>>
>> ------ Originalnachricht ------
>> Von: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
>> An: "Mia" <9speysdx24@kr33.de>; linux-btrfs@vger.kernel.org
>> Gesendet: 25.10.2021 12:55:46
>> Betreff: Re: filesystem corrupt - error -117
>>
>>>
>>>
>>> On 2021/10/25 18:53, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2021/10/25 16:46, Mia wrote:
>>>>> Hello,
>>>>> I need support since my root filesystem just went readonly :(
>>>>>
>>>>> [641955.981560] BTRFS error (device sda3): tree block 342685007872
>>>>> owner
>>>>> 7 already locked by pid=3D8099, extent tree corruption detected
>>>>
>>>> This line explains itself.
>>>>
>>>> Your extent tree is no corrupted, thus it allocated a new tree block
>>>
>>> I missed the "w" for the word "now"...
>>>
>>>> which is in fact already hold by other tree.
>>>>
>>>> This means your metadata is no longer protected properly by COW.
>>>>
>>>> "btrfs check" is highly recommended to expose the root cause.
>>>>
>>>>>
>>>>> root@rx1 ~ # btrfs fi show
>>>>> Label: none=C2=A0 uuid: 21306973-6bf3-4877-9543-633d472dcb46
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes used 189.12GiB
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 319.00GiB us=
ed 199.08GiB path /dev/sda3
>>>>>
>>>>> root@rx1 ~ # btrfs fi df /
>>>>> Data, single: total=3D194.89GiB, used=3D187.46GiB
>>>>> System, single: total=3D32.00MiB, used=3D48.00KiB
>>>>> Metadata, single: total=3D4.16GiB, used=3D1.65GiB
>>>>> GlobalReserve, single: total=3D380.45MiB, used=3D0.00B
>>>>>
>>>>> root@rx1 ~ # btrfs --version
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :=
(
>>>>> btrfs-progs v4.20.1
>>>>>
>>>>>
>>>>> root@rx1 ~ # uname -a
>>>>> Linux rx1 4.19.0-17-amd64 #1 SMP Debian 4.19.194-3 (2021-07-18) x86_=
64
>>>>> GNU/Linux
>>>>
>>>> This is a little old for btrfs, but I don't think that's the cause.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> Hope someone can help.
>>>>> Regrads
>>>>> Mia
>>>>>
>>
>
