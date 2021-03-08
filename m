Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02570330A56
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Mar 2021 10:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhCHJdT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Mar 2021 04:33:19 -0500
Received: from mout.gmx.net ([212.227.15.19]:35621 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229813AbhCHJdL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Mar 2021 04:33:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615195988;
        bh=duiMms18+8pCVuBqIFWXLqLw8sl4SO7zROWQnaMgDac=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=ZjPeqUidLeo8hzQwGqS7ntXZY9iDsUxjN3scObqFWD6+fK3lnYjDqXVQK01LjQ91p
         q/f8Brp8FTr7/j1LFleKoRxXodU3h9Do3xXOcQY6pKEji7ZFlUeEIWyjFGWFSyg/YG
         v9r/7DlbcjJLxkSZiFPCznidXlmlr0E4q7EoGug0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MCbIn-1lSEYC17Gl-009f0z; Mon, 08
 Mar 2021 10:33:08 +0100
Subject: Re: btrfs error: write time tree block corruption detected
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     chil L1n <devchill1n@gmail.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CABBhR_6Y=H6Eujw51xkt6_fjAQFjdcp5trVgjtbrNf9iMDxZ0g@mail.gmail.com>
 <PH0PR04MB74168E7E65BDF004A6C06BB39B939@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CABBhR_6mO2e2Bu2TLGTCjY-xG3+Yu34visp9+uqdvKUvpVhG-g@mail.gmail.com>
 <100894a0-51c5-6ba9-7688-32203cb822c6@gmx.com>
Message-ID: <6c73793c-e855-12c5-9214-7baddbc840c7@gmx.com>
Date:   Mon, 8 Mar 2021 17:33:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <100894a0-51c5-6ba9-7688-32203cb822c6@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qEQJ5EH+0SyArWNTz1Pw1dmdDyKkLoJuLtVMU/LC3yOx0QGTo7c
 5YV8b7F3inQpDDOmzEHXySRjIRfKnSUHpFEl1IVPde+aPxZFq/61WWXe9oPLxkd1pHDOFgE
 XVyvdrz5mghf7FovjXsk4KqkOgXZqfwlSTGY+WMz8JNHtDin193Wu5JjniVIzSOOc49rSev
 K44o/HFI1f1P168bD37KA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1Kj7pQrBztM=:rgDicJQneY33zbyVyTvJxk
 0pjcOX8bRO55oQDdqRTNHKavyDjZ/hoke6Ey27oPiC4SsqUWPLnBW81PIUtdpQCs9zxafIq9X
 TaV7NkfMPur1wJ8sEvHwh0sS3pF5Ika19a8pt4LyVyGShAM+HXnl69WqsFrbQNSXsurY+37l7
 N/EMHE0C98EWqXKxmyraRX+8OlH8Qrg7MhGszg2WtNS/DCYbyz9S2PFq8oKC7DXY4CQiHCrJa
 4w3rFq2MJI1KK2yKzE6kbE/lDoQpSVnvmU5W9FqLV69gH+cgQGMoH54Xvx2cVuSH0ZQIHxUo2
 VNhDoxrcDFokk5mHn1bWrDZnSaUdY92fpL969ozmF8uyr2SRg5DVYU9I58uUkRAjhj15yK2Hy
 6PWpTigby++SzLH/64DPfimLTzgvNcSzl1eCl+jAh+vwb2foJbUfs8xPtAKssrJy0Lm0Et/te
 aNew1W/eYr9dh3m8qbw2ZoGjt3D5h2/b+UCRkQjjy+ZVGdI7PGw8JRiCcqknfarPSxkntseT6
 K0M5z2KSQqgfifhzOA13EPko+M2BuHWXjZvl6vG9pxudRtOCP/Fa3Qye9kCCMMJW6u4B1XBYW
 wYGMZAY0Dv26IxKEdVRYMlDdjFSexYEdYy7beapTvDbKfDEnXVBIVah3FcvRKKBARGJpszXdt
 Lj168P4t/TmKGnGGlAsXHmuMoI5KQwmj6kz0EW4VdjMNrLN7uoSqKIprZ9f5gQTh+V+g+NuNO
 FWocKCHNtdBMqHgE+kLUEcwbGMkrNYU8in82hnvgFcRRr6W5Ky2rMqPTFZaX9exQWhgLNQFWE
 YlcDXRfR/7HnyCKb7b13UU4xZn8APaqxTx5Z36JzDqU0G7aomUVWH7j9YzDi9uAkInFN6JeL5
 czsn3NTHtRLUrasxqPnw==
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

Oh, no, the value is correct.... It's my hex diff incorrect...
>
> That's why I prefer to use hex:
> 3276800 =3D 0x320000
> 1310720 =3D 0x140000
> diff=C2=A0=C2=A0=C2=A0 =3D 0x200000

The diff is 0x260000 (xor).

But that can still be an indication of bitflip, on that 0x200000 part.

As the current key should be larger than previous key, one bit flip at
0x200000 can cause the problem and trigger the tree-checker.

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
