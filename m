Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4FF330A4E
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Mar 2021 10:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhCHJ3d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Mar 2021 04:29:33 -0500
Received: from mout.gmx.net ([212.227.15.18]:38935 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229917AbhCHJ27 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Mar 2021 04:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615195734;
        bh=Z7Hs7TFSAPUq1gqMS8nYtAymcxCtc9KRWlt4AAnaAv4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=G4oOE8k65rvP5sBMF5k7PXQsGAj2NzaGfU1Vay5Hr3K0/BPDKb/ekEktlG0qClayh
         irXHtRAz+OBeVobdXRKbkzexUmdWpO08nxaZC0BfXUMTDypk/Zwa7Qyjb8bMK3vDo3
         Vak3lePr3vrKSob3MY5b/B71ts78evwdYgpQ888M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBDnI-1lTazz3EKs-00Cehu; Mon, 08
 Mar 2021 10:28:54 +0100
Subject: Re: btrfs error: write time tree block corruption detected
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     chil L1n <devchill1n@gmail.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CABBhR_6Y=H6Eujw51xkt6_fjAQFjdcp5trVgjtbrNf9iMDxZ0g@mail.gmail.com>
 <PH0PR04MB74168E7E65BDF004A6C06BB39B939@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CABBhR_6mO2e2Bu2TLGTCjY-xG3+Yu34visp9+uqdvKUvpVhG-g@mail.gmail.com>
 <100894a0-51c5-6ba9-7688-32203cb822c6@gmx.com>
Message-ID: <c88dcb5c-648c-bd38-5df4-bfe811161a32@gmx.com>
Date:   Mon, 8 Mar 2021 17:28:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <100894a0-51c5-6ba9-7688-32203cb822c6@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3c8Xcf1U/CtxVwoOUK7NDuOuzfKDvrIRgei8DBmMG5pRakRgMGF
 gtujtoGJ3dWj7DraTqKvqReojM/+1QJhehEzvtsN5EjrOUX9p1L69S5xk0JrgwM9fSnxwyR
 JDcBOHQU4OnHSJkE9lZwxdHj5DR4qlXFxH+I9dOm5Xn8T0gyxT1uPVAHDAd9UYteWhlGYtj
 Ua5BnOgtgNjVKO4oybrLg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LoP+c3gKUuk=:mU7KZ46O5WGcFy/5sVsBqx
 d8BRgKo58lpShDHhnbY3A9g1iBzchBuZd6oFcm3jtiyNm/VnqN3VVV5JTJ+DBQBnznJjWe738
 tcGjz3ld9scgqoTJtL+2fUxIL5LhKAoG4r7bxYAsBNIvE/J7JBn9Y+U/7z+lXbBxCYoen65+h
 8ahU0orS5bG3hSBks4aPhZ4b8ZHjfWeu01xJ+YYCSC4STo335czn89aQVbXNe875hCqHWSI0H
 0lbqBEJLUuyEm4eDW/omJN3T3Rn1PoeX6Y1B7K6JoaqwxniUE3a/Q6VhcbHgSG8QmZx843LqO
 8MTlYAQpJPs86f3Ko26RRefQ9uPr8mHUEhT2rVaJw9RADh9TMYidmRYTnJlktKF2ApvQOX0aD
 ucO6vIiYyydt84qi6nJdJDV1oOArw/CSBK2UARqbWuWgP+b4cq035O2dmjCBB3SVnttkcqVwo
 0f31N6bag6Qo8nONXFgVbYl7c6Q/b28TskmGeiEA5HcAKu2wX02iFLOZk4B3nzYdCEFiClGdk
 Y2w4zFmCXkGzCsqsLYHjCUlhFe7WrOrfqtVSAcwX7966BGa2MNgXx6s4UEAGE9LrLCixharu9
 ohy+f9Sj5FUYIZA3yGRccxTW7XKtt28h/kb0ac32a5PUPVo/vBtZOUT7l2ad5MnkG7h29/WpA
 35T2J4R8Pl6WHGw0kxo2/mKCYEaoueMc/qvIjD9Vz6yXYeXTPI5Dsw3rbkJXB6QnPH3+Iz0hK
 xh4GD7ekBjGx83KJ8EbqhY5/x/tu0c/Zw3FPR/y1GQTkdpgv51HYXG2hwyi8dOqFmEimi+rgl
 PvH7Kk9sYwhMJlz/Mmsp4/up/pxdErwrE7iUfjXrRP0CtmkOhwq/oTm4VdVlh52wh8oOypB1n
 dvGvjaYURXvDTd3DOrqA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/8 =E4=B8=8B=E5=8D=885:23, Qu Wenruo wrote:
>
>
> On 2021/3/8 =E4=B8=8B=E5=8D=884:56, chil L1n wrote:
>> Hi Johannes,
>>
>> Thanks for the advice. I'm running memtester now. This will take some
>> time as the machine has 32GB RAM.
>> Regarding your explanation, I count two bit position differences, not
>> 1. Can you explain your reasoning?
>
> It looks like Johannes missed one 0, and caused some confusion.
>
> With 0 padded correctly, the result is:
>
> 3276800 =3D 0b1100100000000000000000
> 1310720 =3D 0b0101000000000000000000

What the heck? The copy&paste caused even more problem for the binary
output....

>
> That's why I prefer to use hex:
> 3276800 =3D 0x320000
> 1310720 =3D 0x140000
> diff=C2=A0=C2=A0=C2=A0 =3D 0x200000

At least the hex output still stands correctly.

Yeah, next time, let's not use binary output anymore.

Thanks,
Qu
>
> Definitely one bit flipped.
>
> Thanks,
> Qu
>
>>
>> Thanks,
>>
>> chill
>>
>>
>> On Mon, Mar 8, 2021 at 9:41 AM Johannes Thumshirn
>> <Johannes.Thumshirn@wdc.com> wrote:
>>>
>>> On 06/03/2021 10:11, chil L1n wrote:
>>>> [2555511.868642] BTRFS critical (device sda4): corrupt leaf: root=3D2=
58
>>>> block=3D250975895552 slot=3D78, bad key order, prev (256703 108 32768=
00)
>>>> current (256703 108 1310720)
>>>> [2555511.868650] BTRFS error (device sda4): block=3D250975895552 writ=
e
>>>> time tree block corruption detected
>>>
>>> This /might/ be a memory bitflip:
>>>
>>> 3276800 =3D 0b1100100000000000000000
>>> 1310720 =3D 0b101000000000000000000
>>>
>>> I guess the highest bit did flip so it should have been:
>>> 3407872 =3D 0b1101000000000000000000
>>>
>>> (3407872 - 3276800) / 4096.0
>>> 32.0
>>>
>>> Can you run a memtest on the machine to check if the RAM is ok?
>>>
>>> Byte,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Johannes
